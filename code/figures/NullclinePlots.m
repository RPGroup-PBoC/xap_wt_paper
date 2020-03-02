(* ::Package:: *)

(* ::Title:: *)
(*NullclinePlots: Plotting of ODE's as Vectorfields, Showing Nullclines*)


(* ::Text:: *)
(*Author: Kathrin Laxhuber*)
(*Created: 04.02.2019*)
(*Last modified: 18.05.2019*)


(* ::Section::Closed:: *)
(*Begin Package*)


BeginPackage["NullclinePlots`","MaTeX`"]


(* ::Section::Closed:: *)
(*Usage Definitions*)


NullclinePlots::usage = "This package provides functions to create vector or stream plots of two ODE's and show the corresponding nullclines.";


NullclinePlotSystem::usage="Plots a system of two ODE's as stream plot including the nullclines.";


QuickNullclinePlotSystem::usage="Plots a system of two ODE's at vector or stream plots including the nullclines. Has less options than PlotSystem and plots faster.";


VectorNullclinePlotSystem::usage="Plots a system of two ODE's as vector plot including the nullclines.";


LogNullclinePlotSystem::usage="Plots a system of two ODE's as Log Log stream plot including the nullclines.";


LogVectorNullclinePlotSystem::usage="Plots a system of two ODE's as Log Log vector plot including the nullclines.";


(* ::Section:: *)
(*Constants*)


(* ::Subsection:: *)
(*Basic / General*)


plotOptionsBasic={Frame->True,FrameStyle->BlackFrame};


(* ::Subsection:: *)
(*LaTeX*)


(* ::Input::Initialization:: *)
texStyle={FontFamily->"Times",FontSize->11};
plotSizesLaTeX=<|"Normal"->350,"Two"->250,"Three"->180|>;


(* ::Subsection:: *)
(*PowerPoint*)


(* ::Input::Initialization:: *)
PPStyle={FontFamily->"Calibri",FontSize->16,FontColor->Black};
PPPlotResolution=1000;
plotSizesPP=<|"Normal"->350,"Two"->250,"Three"->200|>;


(* ::Section:: *)
(*Function Definitions*)


Begin["Private`"]


(* ::Subsection::Closed:: *)
(*Asociation Matching*)


AssociationContaining[a_Association, 
   keyPatterns : {(_String -> (_Pattern | _PatternTest | _Blank)) \
..}] := MatchQ[a, KeyValuePattern[keyPatterns]]


AssociationContaining[
  keyPatterns : {(_String -> (_Pattern | _PatternTest | _Blank)) ..}] := 
 Curry[AssociationContaining][keyPatterns]


(* ::Subsection:: *)
(*Axes Ticks & Label*)


(* ::Input::Initialization:: *)
GenerateAdaptedTicks[ticks_,scitreshold_]:=Module[{maxabs=Max[Abs[ticks[[;;,1]]]],power},
power=Floor[RealExponent[maxabs]];
If[Abs[power]>scitreshold,
{Map[{#[[1]],If[#[[2,0]]===String,#[[2]],#[[2]]/10^power],#[[3]],#[[4]]}&,ticks],power},
{ticks,None}
]
]


(* ::Input::Initialization:: *)
GenerateAxesLabel[label_,power_,fontstyle_]:=If[power===None,
Switch[fontstyle,
"Normal",label,
"LaTeX",MaTeX[label,"FontSize"->14],
"PP",label
],

If[label===None,
Switch[fontstyle,
"Normal",StringForm["\[Cross] \!\(\*SuperscriptBox[\(10\), \(``\)]\)",power],
"LaTeX",MaTeX[ToString[StringForm["[ \\times 10^{``",power]]<>"} ]","FontSize"->14],
"PP",StringForm["\[Cross] \!\(\*SuperscriptBox[\(10\), \(``\)]\)",power]
],
Switch[fontstyle,
"Normal",Row[{label," ",StringForm["[\[Cross] \!\(\*SuperscriptBox[\(10\), \(``\)]\)]",power]}],
"LaTeX",MaTeX[label<>"\\text{ }"<>ToString[StringForm["[ \\times 10^{``",power]]<>"} ]","FontSize"->14],
"PP",Row[{label," ",StringForm["[\[Cross] \!\(\*SuperscriptBox[\(10\), \(``\)]\)]",power]}]
]
]]


(* ::Input::Initialization:: *)
AdaptTickFormatting[plot_,scitreshold_]:=Module[{ticks=Ticks/.AbsoluteOptions[plot,Ticks],xticks,yticks,xpower,ypower,label=AxesLabel/.AbsoluteOptions[plot,AxesLabel]},
{xticks,xpower}=GenerateAdaptedTicks[ticks[[1]],scitreshold];
{yticks,ypower}=GenerateAdaptedTicks[ticks[[2]],scitreshold];
Show[plot,Ticks->{xticks,yticks},AxesLabel->{GenerateAxesLabel[label[[1]],xpower],GenerateAxesLabel[label[[2]],ypower]}]
]


(* ::Input::Initialization:: *)
AdaptFrameTickFormatting[plot_,fontstyle_,scitreshold_]:=Module[{ticks=Ticks/.AbsoluteOptions[Show[plot,Frame->False],Ticks],xticks,yticks,xpower,ypower,label=If[Dimensions[#]=={2},#,If[Dimensions[#]=={2,2},{#[[2,1]],#[[1,1]]},{None,None}]]&@(FrameLabel/.Quiet@AbsoluteOptions[plot,FrameLabel])},
{xticks,xpower}=GenerateAdaptedTicks[ticks[[1]],scitreshold];
{yticks,ypower}=GenerateAdaptedTicks[ticks[[2]],scitreshold];
Show[plot,FrameTicks->{{yticks,Automatic},{xticks,Automatic}},FrameLabel->{GenerateAxesLabel[label[[1]],xpower,fontstyle],GenerateAxesLabel[label[[2]],ypower,fontstyle]}]
]


(* ::Subsection::Closed:: *)
(*myStreamPlot*)


Options[myStreamPlot]=Options[StreamPlot];

myStreamPlot[f_,{x_,x0_,x1_},{y_,y0_,y1_},opts:OptionsPattern[]]:=With[
{a=OptionValue[AspectRatio]},
Show[StreamPlot[{1/(x1-x0),a/(y1-y0)} (f/.{x->x0+u (x1-x0),y->y0+v/a (y1-y0)}),{u,0,1},{v,0,a},opts]/.Arrow[pts_]:>Arrow[({x0,y0}+{x1-x0,(y1-y0)/a} #)&/@pts],PlotRange->{{x0,x1},{y0,y1}}]
]


(* ::Subsection:: *)
(*Plot Functions*)


(* ::Subsubsection::Closed:: *)
(*Quick (No Functionality)*)


QuickNullclinePlotSystem[{dxdt_,dydt_},params_,opts:OptionsPattern[{myStreamPlot,ContourPlot,Show}]]:=
Module[{cplot,vplot,shade,pltrange,range},

pltrange=FilterRules[{opts},PlotRange];
range=If[Length[pltrange]==0,{{0,0},{0,0}},(PlotRange/.pltrange)];

vplot=myStreamPlot[{dxdt[x,y,params], dydt[x,y,params]},{x,range[[1,1]],range[[1,2]]},{y,range[[2,1]],range[[2,2]]},StreamStyle->{GrayLevel[0.6]},Evaluate@FilterRules[{opts},Options[myStreamPlot]]];

cplot=ContourPlot[{dxdt[x,y,params]==0, dydt[x,y,params]==0},{x,range[[1,1]],range[[1,2]]},{y,range[[2,1]],range[[2,2]]},Evaluate@FilterRules[{opts},Options[ContourPlot]]];

shade=RegionPlot[{x<0||y<0},{x,range[[1,1]],range[[1,2]]},{y,range[[2,1]],range[[2,2]]},PlotStyle->Directive[LightGray,Opacity[0.4]],BoundaryStyle->None];

Return[Show[vplot,cplot,shade,Evaluate@FilterRules[{opts},Options[Show]],GridLines->{{0},{0}},GridLinesStyle->Directive[Gray,Dashed]]];
]


(* ::Subsubsection:: *)
(*Normal*)


Options[NullclinePlotSystem]={PlotSize->"Normal",FontStyle->"Normal"};

NullclinePlotSystem[{dxdt_,dydt_},params__,opts:OptionsPattern[{NullclinePlotSystem,myStreamPlot,ContourPlot,Show}]]:=
Module[{cplot,vplot,shade,pltrange,range,sizeopts,framelbl},

pltrange=FilterRules[{opts},PlotRange];
range=If[Length[pltrange]==0,{{0,0},{0,0}},(PlotRange/.pltrange)];

sizeopts=Switch[OptionValue[FontStyle],
"Normal",plotOptionsBasic,

"LaTeX",Join[plotOptionsBasic,{ImageSize->plotSizesLaTeX[[OptionValue[PlotSize]]], BaseStyle->texStyle}],

"PP",Join[plotOptionsBasic,{ImageSize->plotSizesPP[[OptionValue[PlotSize]]], BaseStyle->PPStyle}]
];

vplot=myStreamPlot[{dxdt[x,y,params], dydt[x,y,params]},{x,range[[1,1]],range[[1,2]]},{y,range[[2,1]],range[[2,2]]},StreamStyle->{GrayLevel[0.6]},Evaluate@FilterRules[{opts},Options[myStreamPlot]],Evaluate@sizeopts];

cplot=ContourPlot[{dxdt[x,y,params]==0, dydt[x,y,params]==0},{x,range[[1,1]],range[[1,2]]},{y,range[[2,1]],range[[2,2]]},Evaluate@FilterRules[{opts},Options[ContourPlot]],Evaluate@sizeopts];

shade=RegionPlot[{x<0||y<0},{x,range[[1,1]],range[[1,2]]},{y,range[[2,1]],range[[2,2]]},PlotStyle->Directive[LightGray,Opacity[0.4]],BoundaryStyle->None];

Return[AdaptFrameTickFormatting[
Show[vplot,cplot,shade,Evaluate@sizeopts,Evaluate@FilterRules[{opts},Options[Show]],GridLines->{{0},{0}},GridLinesStyle->Directive[Gray,Dashed]],
OptionValue[FontStyle],1]];
]


(* ::Subsubsection::Closed:: *)
(*Log*)


Options[LogNullclinePlotSystem]={PlotSize->"Normal",FontStyle->"Normal"};

LogNullclinePlotSystem[{dxdt_,dydt_},params__,opts:OptionsPattern[{LogNullclinePlotSystem,myStreamPlot,ContourPlot,Show}]]:=
Module[{logdxdt,logdydt,cplot,vplot,pltrange,range,sizeopts,framelbl},

logdxdt[xlog_,ylog_,paramslog__]:=dxdt[10^(xlog),10^(ylog),paramslog] 10^(-xlog);
logdydt[xlog_,ylog_,paramslog__]:=dydt[10^(xlog),10^(ylog),paramslog] 10^(-ylog);

pltrange=FilterRules[{opts},PlotRange];
range=If[Length[pltrange]==0,{{0,0},{0,0}},(PlotRange/.pltrange)];

sizeopts=Switch[OptionValue[FontStyle],
"Normal",plotOptionsBasic,

"LaTeX",Join[plotOptionsBasic,{ImageSize->plotSizesLaTeX[[OptionValue[PlotSize]]], BaseStyle->texStyle}],

"PP",Join[plotOptionsBasic,{ImageSize->plotSizesPP[[OptionValue[PlotSize]]], BaseStyle->PPStyle}]
];

vplot=myStreamPlot[{logdxdt[x,y,params], logdydt[x,y,params]},{x,range[[1,1]],range[[1,2]]},{y,range[[2,1]],range[[2,2]]},StreamStyle->{GrayLevel[0.6]},Evaluate@FilterRules[{opts},Options[myStreamPlot]],Evaluate@sizeopts];

cplot=ContourPlot[{logdxdt[x,y,params]==0, logdydt[x,y,params]==0},{x,range[[1,1]],range[[1,2]]},{y,range[[2,1]],range[[2,2]]},Evaluate@FilterRules[{opts},Options[ContourPlot]],Evaluate@sizeopts];

Return[AdaptFrameTickFormatting[
Show[vplot,cplot,Evaluate@sizeopts,Evaluate@FilterRules[{opts},Options[Show]]],
OptionValue[FontStyle],2]];
]


(* ::Subsubsection:: *)
(*Vector*)


Options[VectorNullclinePlotSystem]={PlotSize->"Normal",FontStyle->"Normal"};

VectorNullclinePlotSystem[{dxdt_,dydt_},params__,opts:OptionsPattern[{VectorNullclinePlotSystem,VectorPlot,ContourPlot,Show}]]:=
Module[{cplot,vplot,shade,pltrange,range,sizeopts,framelbl},

pltrange=FilterRules[{opts},PlotRange];
range=If[Length[pltrange]==0,{{0,0},{0,0}},(PlotRange/.pltrange)];

sizeopts=Switch[OptionValue[FontStyle],
"Normal",plotOptionsBasic,

"LaTeX",Join[plotOptionsBasic,{ImageSize->plotSizesLaTeX[[OptionValue[PlotSize]]], BaseStyle->texStyle}],

"PP",Join[plotOptionsBasic,{ImageSize->plotSizesPP[[OptionValue[PlotSize]]], BaseStyle->PPStyle}]
];

vplot=VectorPlot[{dxdt[x,y,params], dydt[x,y,params]},{x,range[[1,1]],range[[1,2]]},{y,range[[2,1]],range[[2,2]]},Evaluate@FilterRules[{opts},Options[VectorPlot]],VectorStyle->{Thickness[0.006],GrayLevel[0.6]},Evaluate@sizeopts];

cplot=ContourPlot[{dxdt[x,y,params]==0, dydt[x,y,params]==0},{x,range[[1,1]],range[[1,2]]},{y,range[[2,1]],range[[2,2]]},Evaluate@FilterRules[{opts},Options[ContourPlot]],Evaluate@sizeopts];

shade=RegionPlot[{x<0||y<0},{x,range[[1,1]],range[[1,2]]},{y,range[[2,1]],range[[2,2]]},PlotStyle->Directive[LightGray,Opacity[0.4]],BoundaryStyle->None];

Return[AdaptFrameTickFormatting[
Show[vplot,cplot,shade,Evaluate@sizeopts,Evaluate@FilterRules[{opts},Options[Show]],GridLines->{{0},{0}},GridLinesStyle->Directive[Gray,Dashed]],
OptionValue[FontStyle],2]];
]


Options[LogVectorNullclinePlotSystem]={PlotSize->"Normal",FontStyle->"Normal"};

LogVectorNullclinePlotSystem[{dxdt_,dydt_},params__,opts:OptionsPattern[{LogVectorNullclinePlotSystem,VectorPlot,ContourPlot,Show}]]:=
Module[{logdxdt,logdydt,cplot,vplot,pltrange,range,sizeopts,framelbl},

logdxdt[xlog_,ylog_,paramslog__]:=dxdt[10^(xlog),10^(ylog),paramslog] 10^(-xlog);
logdydt[xlog_,ylog_,paramslog__]:=dydt[10^(xlog),10^(ylog),paramslog] 10^(-ylog);

pltrange=FilterRules[{opts},PlotRange];
range=If[Length[pltrange]==0,{{0,0},{0,0}},(PlotRange/.pltrange)];

sizeopts=Switch[OptionValue[FontStyle],
"Normal",plotOptionsBasic,

"LaTeX",Join[plotOptionsBasic,{ImageSize->plotSizesLaTeX[[OptionValue[PlotSize]]], BaseStyle->texStyle}],

"PP",Join[plotOptionsBasic,{ImageSize->plotSizesPP[[OptionValue[PlotSize]]], BaseStyle->PPStyle}]
];

vplot=VectorPlot[{logdxdt[x,y,params], logdydt[x,y,params]},{x,range[[1,1]],range[[1,2]]},{y,range[[2,1]],range[[2,2]]},VectorStyle->{GrayLevel[0.6],Thickness[0.005]},Evaluate@FilterRules[{opts},Options[VectorPlot]],Evaluate@sizeopts];

cplot=ContourPlot[{logdxdt[x,y,params]==0, logdydt[x,y,params]==0},{x,range[[1,1]],range[[1,2]]},{y,range[[2,1]],range[[2,2]]},Evaluate@FilterRules[{opts},Options[ContourPlot]],Evaluate@sizeopts];

Return[AdaptFrameTickFormatting[
Show[vplot,cplot,Evaluate@sizeopts,Evaluate@FilterRules[{opts},Options[Show]]],
OptionValue[FontStyle],2]];
]


(* ::Section::Closed:: *)
(*End Package*)


End[]


EndPackage[]
