Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E3C735E59
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 22:18:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBLJW-0000mZ-Ds; Mon, 19 Jun 2023 16:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankwmiller@frankwmiller.net>)
 id 1qBKmz-0003bj-Bq
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 15:43:49 -0400
Received: from mta-231a.oxsus-vadesecure.net ([15.204.3.4]
 helo=nmtao201.oxsus-vadesecure.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frankwmiller@frankwmiller.net>)
 id 1qBKmx-00065l-G0
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 15:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; bh=IlNhE3iRS+fAcJNiQ6oDLXT8dHerhmFcuPNKhm
 ypSRs=; c=relaxed/relaxed; d=webcom.xion.oxcs.net; h=from:reply-to:
 subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:
 in-reply-to:references:list-id:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt; s=mail1;
 t=1687203820; x=1687808620; b=j0hZj77MZJfouglJGz6VZJRejeoMrH1Rugq3m1ud2
 EDbJMzDm0PDS+MIxCsxytIjv80Zaf79p+CHZ2Oi2p8ojFer52kVrTEPsdxY18vXDZIkcDRo
 /N5fu/ArhSF9ItbcxjXwu9k/V+l9TrADBP8RP3bUn5VSFE6HY86phXPCwV0SkxD/IVTF8wD
 /SMP6P7C8ylJUCt+d/tBrEpXcBMgbvj2wUuXZGQGc7JdV7ScqqVGf3N3Q/zy15IFEoK8LUY
 oU11jUxi3D3ei8S2tMIkDQB3Jbc9nF2Cc4wWblTSS1V5dQISkN92jJXybYIrFayZGcocp1A
 ubbVcCNNkf4E8ITQg==
Received: from submission-proxy-7d554f789d-zm8lc ([73.153.169.190])
 by oxsus2nmtao01p.internal.vadesecure.com with ngmta
 id 258d988e-176a26ef4e57d847; Mon, 19 Jun 2023 19:43:40 +0000
Date: Mon, 19 Jun 2023 13:43:38 -0600 (MDT)
From: "frankwmiller frankwmiller.net" <frankwmiller@frankwmiller.net>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <413144073.1734477.1687203818872@webmail-oxcs.networksolutionsemail.com>
Subject: Faster than real-time execution
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_1734476_1984401661.1687203818871"
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.13.105
X-Originating-IP: 73.153.169.190
X-Originating-Client: open-xchange-appsuite
Authentication-Results: oxsus-vadesecure.net;
 auth=pass smtp.auth=frankwmiller@frankwmiller.net
 smtp.mailfrom=frankwmiller@frankwmiller.net; 
Received-SPF: pass client-ip=15.204.3.4;
 envelope-from=frankwmiller@frankwmiller.net;
 helo=nmtao201.oxsus-vadesecure.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 19 Jun 2023 16:17:10 -0400
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

------=_Part_1734476_1984401661.1687203818871
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Greetings,
 
I've been contemplating using QEMU for faster-than-real-time execution of SPARC executables on an X86-64 machine.   It appears from the base architecture of QEMU that this is not possible if QEMU is using JIT of the SPARC to x86-84 since the resulting x86-64 will run on the hardware at the processor clock speed and there's not really any way around that.
 
However, is it possible to do something like this.  Execute the SPARC instructions in simulation, i.e. without any JIT, and then since everything is executed as simulated SPARC instructions, essentially speed up time in the simulated environment and execute FRT that way?
 
Thanks
FM
 
 
------=_Part_1734476_1984401661.1687203818871
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!doctype html>
<html>
 <head>
  <meta charset="UTF-8">
 </head>
 <body>
  <div class="default-style">
   Greetings,
  </div>
  <div class="default-style">
   &nbsp;
  </div>
  <div class="default-style">
   I've been contemplating using QEMU for faster-than-real-time execution of SPARC executables on an X86-64 machine.&nbsp;&nbsp; It appears from the base architecture of QEMU that this is not possible if QEMU is using JIT of the SPARC to x86-84 since the resulting x86-64 will run on the hardware at the processor clock speed and there's not really any way around that.
  </div>
  <div class="default-style">
   &nbsp;
  </div>
  <div class="default-style">
   However, is it possible to do something like this.&nbsp; Execute the SPARC instructions in simulation, i.e. without any JIT, and then since everything is executed as simulated SPARC instructions, essentially speed up time in the simulated environment and execute FRT that way?
  </div>
  <div class="default-style">
   &nbsp;
  </div>
  <div class="default-style">
   Thanks
  </div>
  <div class="default-style">
   FM
  </div>
  <div class="default-style">
   &nbsp;
  </div>
  <div class="default-style">
   &nbsp;
  </div>
 </body>
</html>
------=_Part_1734476_1984401661.1687203818871--

