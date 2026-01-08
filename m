Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B91B2D0106C
	for <lists+qemu-devel@lfdr.de>; Thu, 08 Jan 2026 05:59:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdi6K-0008Ci-GR; Wed, 07 Jan 2026 23:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jescom87@onedot1.one>)
 id 1vdi6G-00089g-83
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 23:58:20 -0500
Received: from mail72.out.titan.email ([209.209.25.165])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jescom87@onedot1.one>)
 id 1vdi6E-0006BF-Bk
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 23:58:20 -0500
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dmt2V2s7Mz7t99
 for <qemu-devel@nongnu.org>; Thu,  8 Jan 2026 04:58:10 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=p4w3KRjzgFr3/LYhdZ6leQSlhS6+y8IVgfp+6cxcIzc=; 
 c=relaxed/relaxed; d=onedot1.one;
 h=date:to:message-id:references:mime-version:from:subject:from:to:subject:date:message-id:references:cc:in-reply-to:reply-to;
 q=dns/txt; s=titan1; t=1767848290; v=1;
 b=YzkEWQZGZYNk7iCYfqffkRyZxbHOLsdWytjaM6z9kORa3gWIpPe0Uc4F4h5QDMEyEPzP5zio
 XyzaGubRytJszAfn5VMvBixydAO1rUbYe7M+p24bxDOvYZEf3YaOu/dj1SCOlniS/SuqVM+4UFx
 CG9LUlKNKsztuKChZdVO4AiM=
Received: from webmail-out.titan.email (unknown [10.10.163.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp-out.flockmail.com (Postfix) with ESMTPS id 4dmt2V21MNz7t8D
 for <qemu-devel@nongnu.org>; Thu,  8 Jan 2026 04:58:10 +0000 (UTC)
Date: Thu, 8 Jan 2026 04:58:10 +0000 (UTC)
Feedback-ID: :jescom87@onedot1.one:onedot1.one:flockmailId
From: Jesse Comeau <jescom87@onedot1.one>
To: "std-discussion@lists.isocpp.org" <std-discussion@lists.isocpp.org>,
 "python-dev@python.org" <python-dev@python.org>,
 "jdk-dev@openjdk.org" <jdk-dev@openjdk.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "gem5-dev@gem5.org" <gem5-dev@gem5.org>,
 "termux-dev@groups.io" <termux-dev@groups.io>,
 "ubuntu-devel@lists.ubuntu.com" <ubuntu-devel@lists.ubuntu.com>,
 "devlist@kicad.org" <devlist@kicad.org>,
 "eclipse-dev@eclipse.org" <eclipse-dev@eclipse.org>
Message-ID: <199241473425581057.0.v2@titan.email>
References: <199239015399859200.0.v2@titan.email>
 <199241473425581057.0.v2@titan.email>
Subject: Jesse (Computer Systems Design)
MIME-Version: 1.0
Content-Type: multipart/related; 
 boundary="----=_Part_903500_1575031948.1767848290228"
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1767848290319568184.30087.5404901959738481382@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=WtDRMcfv c=1 sm=1 tr=0 ts=695f3962
 a=fV4G12KpgSuBi+7gI9c/cw==:117 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=CEWIc4RMnpUA:10 a=CIpa5kweAAAA:8 a=WEtUbng2D4nCYQTDy0AA:9
 a=uiLfa2BpfVANWj0z:21 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10
 a=X0qombyAlGba11bGhn4G:22 a=iWSbBnEO8tLaiwZIWIOP:22
 a=NWVoK91CQySWRX1oVYDe:22 a=1LUay7kfOPB8ZNMhXmZn:22
Received-SPF: pass client-ip=209.209.25.165; envelope-from=jescom87@onedot1.one;
 helo=mail72.out.titan.email
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

------=_Part_903500_1575031948.1767848290228
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,&nbsp;
<div>
 <br>
</div>
<div>
 &nbsp; &nbsp; My name is Jesse Comeau, August 4th 1987, 519-507-9274, Tees=
water, On. Owner/Founder, One.1, Professional Services. Computer Science, B=
usiness Administration, Thought Leadership.
</div>
<div>
 <br>
</div>
<div>
 &nbsp; &nbsp; From an Interior Systems Mechanic to a Heat and Frost Mechan=
ic, and now, from an ElectroMechanic to a QuantumMechanic.
</div>
<div>
 <br>
</div>
<div>
 &nbsp; &nbsp; I apologize, I'm kind of new to this. And sorry for the long=
 introduction. I believe I'm ready to Develop and Contribute. I just figure=
d out how to Clone, Configure, Build, and moved onto some Wrapping and Patc=
hing. Getting more and more familiar with it every day.
</div>
<div>
 <br>
</div>
<div>
 &nbsp; &nbsp; I thought about finding like some sort of a niche, somewhere=
 I feel comfortable that also made sense and stick to it. NAICs says Comput=
er Systems Design, so I took that as an example. I wasn't sure where to sta=
rt. So I gathered up my tools and started prepping.&nbsp;
</div>
<div>
 <br>
</div>
<div>
 &nbsp; &nbsp; I need all the support I can get. I'm not very shy, so that'=
s why I come to these mailing lists. It seems to be a good place to be a pa=
rt of a good community.
</div>
<div>
 <br>
</div>
<div>
 &nbsp; &nbsp; Here's a list of what I know and what I got. Feel free to co=
rrect me if I'm wrong. Any concerns or questions or comments are greatly ap=
preciated. You might hear back from me. Let me know what you think. I think=
 I'm off to a good start.
</div>
<div>
 <br>
</div>
<div>
 -------------------------------------------------
</div>
<div>
 -------------------------------------------------
</div>
<div>
 <br>
</div>
<div>
 ### Resources ###
</div>
<div>
 *** Tools ***
</div>
<div>
 <br>
</div>
<div>
 NAICs,
</div>
<div>
 Professional Services,
</div>
<div>
 Computer Systems Designer.
</div>
<div>
 <br>
</div>
<div>
 =E2=80=A2 Lenovo IdeaPad Slim 5&nbsp;
</div>
<div>
 - Ubuntu-X86 (BASH)
</div>
<div>
 =E2=80=A2 Motorola G35&nbsp;
</div>
<div>
 - Termux-ARM (BASH)
</div>
<div>
 <br>
</div>
<div>
 =E2=80=A2 C/C++ (Compilation)
</div>
<div>
 - .cc (Implementation)
</div>
<div>
 - .h (Declaration)
</div>
<div>
 =E2=80=A2 Python (Interpretation)
</div>
<div>
 - .py (Configuration)
</div>
<div>
 =E2=80=A2 Java (Compilation and Interpretation)
</div>
<div>
 - .java (Application)
</div>
<div>
 <br>
</div>
<div>
 =E2=80=A2 System:
</div>
<div>
 - gem5 (Full System Simulation)
</div>
<div>
 - qemu (Full System Emulation)
</div>
<div>
 <br>
</div>
<div>
 =E2=80=A2 Development:
</div>
<div>
 - eclipse (Integrated Development Environment)
</div>
<div>
 - kicad (Electronic Development Automation)
</div>
<div>
 <br>
</div>
<div>
 =E2=80=A2 Manufacturer:
</div>
<div>
 - STMicroelectronics&nbsp;
</div>
<div>
 =E2=80=A2 Distributor:&nbsp;
</div>
<div>
 - DigiKey&nbsp;
</div>
<div>
 <br>
</div>
<div>
 -------------------------------------------------
</div>
<div>
 -------------------------------------------------
</div>
<div>
 <br>
 <div data-signature-parent=3D"sig-parent">=20
  <signature data-signature-id=3D"local-8b789dba-8a86" style=3D"display:tab=
le;width:100%;">=20
   <div style=3D"user-select: inherit; scrollbar-color: var(--scrollbar-act=
ive-color) #0000; box-sizing: border-box;" fr-original-style=3D"user-select=
: inherit; scrollbar-color: var(--scrollbar-active-color) #0000; box-sizing=
: border-box;">
    Jesse Comeau
    <br style=3D"user-select: inherit; scrollbar-color: var(--scrollbar-act=
ive-color) #0000; box-sizing: border-box;" fr-original-style=3D"">August 4t=
h 1987
    <br style=3D"user-select: inherit; scrollbar-color: var(--scrollbar-act=
ive-color) #0000; box-sizing: border-box;" fr-original-style=3D"">519-507-9=
274
    <br style=3D"user-select: inherit; scrollbar-color: var(--scrollbar-act=
ive-color) #0000; box-sizing: border-box;" fr-original-style=3D"">Teeswater=
, On
    <br style=3D"user-select: inherit; scrollbar-color: var(--scrollbar-act=
ive-color) #0000; box-sizing: border-box;" fr-original-style=3D"">
    <br style=3D"user-select: inherit; scrollbar-color: var(--scrollbar-act=
ive-color) #0000; box-sizing: border-box;" fr-original-style=3D"">Owner/Fou=
nder
    <br style=3D"user-select: inherit; scrollbar-color: var(--scrollbar-act=
ive-color) #0000; box-sizing: border-box;" fr-original-style=3D"">One.1
   </div>=20
  </signature>=20
 </div>
</div>
<img class=3D"flm-open" width=3D"0" height=3D"0" style=3D"border:0;width:0;=
height:0;display:block;" src=3D"https://rtt-east.riva.co/dc/t/mo/v2?t=3DeyJ=
0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJwIjoiMTAwMiA3OTcyMDAyIHFlbXUtZGV2ZWxAb=
m9uZ251Lm9yZyBhMjkyMzFkMmVlMDQzMjI5OWU0YjdlZWI4NGM5MjkzYiA0MjQ2MDM2MzYzMzA2=
NTk4NiA4ID8iLCJleHAiOjE3ODM0MDAyODl9.bWOK0GtIfU7m4YIS6DcEZKFVvAGr7GcLJYxfB2=
SKHnPGUGbVovsOOMQnEYoph-i5WOL0X3dE9n-DM70uyGjMVw&requestId=3Da_08045757_SMR=
_592_epW_OeFO">
------=_Part_903500_1575031948.1767848290228--

