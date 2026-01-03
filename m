Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2B1CEFA47
	for <lists+qemu-devel@lfdr.de>; Sat, 03 Jan 2026 03:39:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbrWd-0003KL-8m; Fri, 02 Jan 2026 21:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jescom87@onedot1.one>)
 id 1vbrWY-0003Jz-B4
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 21:37:50 -0500
Received: from mail52.out.titan.email ([209.209.25.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jescom87@onedot1.one>)
 id 1vbrWV-0000Pn-9l
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 21:37:48 -0500
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4djl8p3vLgz7t7l
 for <qemu-devel@nongnu.org>; Sat,  3 Jan 2026 02:37:46 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=VlyK0nJZOqc5MMD9WUG8f7DQfSjnleAGqqhMlxkesFU=; 
 c=relaxed/relaxed; d=onedot1.one;
 h=to:message-id:from:subject:mime-version:date:from:to:subject:date:message-id:cc:in-reply-to:reply-to:references;
 q=dns/txt; s=titan1; t=1767407866; v=1;
 b=YCUDkwWanxhKEyOCwZ7mJpVhZhmZEx8ZSWwf70aENbFja7qaLX8usL0IuJJqvWp1cU1ppKp1
 F7yb3p1pPzZTaQtlnQ9mzv0DEK1Gfs53hV4x4VJjO9VxsCRBXzp+bcqLJN9xCP99GqRMWx0QS8h
 u5itVg2j4ZwDC+aCXxDqyV8Q=
Received: from webmail-out.titan.email (unknown [10.10.132.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp-out.flockmail.com (Postfix) with ESMTPS id 4djl8p31bvz7t84
 for <qemu-devel@nongnu.org>; Sat,  3 Jan 2026 02:37:46 +0000 (UTC)
Date: Sat, 3 Jan 2026 02:37:46 +0000 (GMT)
Feedback-ID: :jescom87@onedot1.one:onedot1.one:flockmailId
From: Jesse Comeau <jescom87@onedot1.one>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <198779656619774976.0.v2@titan.email>
Subject: Jesse (Termux)
MIME-Version: 1.0
Content-Type: multipart/related; 
 boundary="----=_Part_7122889_1198599051.1767407866270"
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1767407866454515101.30087.8862045117033669641@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=695880fa
 a=zUALi2e9YtxYzuTtHVOXhQ==:117 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=CEWIc4RMnpUA:10 a=mTLUI6cdAAAA:8 a=k_soojD9K1zzZ7W-puQA:9
 a=YYW4CeQkUg_uW3TF:21 a=QEXdDO2ut3YA:10 a=PKy9fIuPxEFJzp7oedu4:22
 a=Z_60_2tg-voYcxSmnYWO:22 a=iWSbBnEO8tLaiwZIWIOP:22
 a=NWVoK91CQySWRX1oVYDe:22 a=1LUay7kfOPB8ZNMhXmZn:22
Received-SPF: pass client-ip=209.209.25.115; envelope-from=jescom87@onedot1.one;
 helo=mail52.out.titan.email
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_IMAGE_ONLY_20=1.546, HTML_IMAGE_RATIO_04=0.001, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_REMOTE_IMAGE=0.01 autolearn=no autolearn_force=no
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

------=_Part_7122889_1198599051.1767407866270
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,&nbsp;
<div>
 <br>
</div>
<div>
 &nbsp; &nbsp; Interested in qemu source code for Termux?
 <br>
 <br>
 <div data-signature-parent="sig-parent"> 
  <signature data-signature-id="local-8b789dba-8a86" style="display:table;width:100%;"> 
   <div style="user-select: inherit; scrollbar-color: var(--scrollbar-active-color) #0000; box-sizing: border-box;" fr-original-style="user-select: inherit; scrollbar-color: var(--scrollbar-active-color) #0000; box-sizing: border-box;">
    Jesse Comeau
    <br style="user-select: inherit; scrollbar-color: var(--scrollbar-active-color) #0000; box-sizing: border-box;" fr-original-style="">August 4th 1987
    <br style="user-select: inherit; scrollbar-color: var(--scrollbar-active-color) #0000; box-sizing: border-box;" fr-original-style="">519-507-9274
    <br style="user-select: inherit; scrollbar-color: var(--scrollbar-active-color) #0000; box-sizing: border-box;" fr-original-style="">Teeswater, On
    <br style="user-select: inherit; scrollbar-color: var(--scrollbar-active-color) #0000; box-sizing: border-box;" fr-original-style="">
    <br style="user-select: inherit; scrollbar-color: var(--scrollbar-active-color) #0000; box-sizing: border-box;" fr-original-style="">Owner/Founder
    <br style="user-select: inherit; scrollbar-color: var(--scrollbar-active-color) #0000; box-sizing: border-box;" fr-original-style="">One.1
   </div> 
  </signature> 
 </div>
</div>
<img class="flm-open" width="0" height="0" style="border:0;width:0;height:0;display:block;" src="https://gateway-east.rootserverlink.com/dc/t/mo/v2?t=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJwIjoiMTAwMiA3OTcyMDAyIHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyBiMTk3MTk0MDYwZTEwNzQxMWM5NmViOGQzMjljMjM2ZCA0MjM4NjQ3MjkzMjk2NjQwMiAxID8iLCJleHAiOjE3ODI5NTk4NjZ9.diqBoDcjOU1tyaeLQX4pjcdSL_3383n7ki3wyJaEVT4Gaa_DYRmPnKdq45AFxRH-yx-qB_lwRB4w2P-tr55KkQ&requestId=a_03023733_SMR_120_epW_PyFc">
------=_Part_7122889_1198599051.1767407866270--

