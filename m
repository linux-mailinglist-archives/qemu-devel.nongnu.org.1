Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F02756EFB
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLVsp-00024G-UI; Mon, 17 Jul 2023 17:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVsn-00023B-QT
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:53 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVsk-00083c-H8
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689629746; x=1690234546; i=deller@gmx.de;
 bh=u5t1oXhIjdla/7PwxCCrpnFZUkuafq+bUKnWh7AGGNU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=lzKSU8DTeO3IDGVXM3pfpHH6oW6WBQv9h1O/+uX/RGWFtL8Bypq5AukhoIo0dQkScyr7gPC
 JGF1xpRZ1NDnsk4cw7/jCZoDLh9WPB5tx597cD82Yff0xBeWRdmNHFiCJ5Kr1qJB5AicR6czj
 PCBjiA+JqE4ypCJwslWLi8eWKMmfxwEv2I7R+SpL/lKLS7qeGs4UUhLfJBGAupdIP36BMKNuf
 lXYMddRlfsLyB+xvscvD3y38PGFHGbGOeEiBM7HwQha0xgHcLO7CNhTTfwYS6MQOHQlmpZ/wc
 L9wp8PhcWfb6fsORDjZEeyhEOcCkCZUP3+URqXNsx9Du5OC6hIjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.97]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbFs-1q3IJA0Nh0-00scz9; Mon, 17
 Jul 2023 23:35:46 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 0/6] linux-user: brk() syscall fixes and armhf static binary
 fix
Date: Mon, 17 Jul 2023 23:35:39 +0200
Message-ID: <20230717213545.142598-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gl55BELn0TqNztf4rov+95BjaIEoC0/RGuN2Vpu79o6FA1TJRF/
 O8nDSndA17XDSCorMKoVR9RZ772rXnWsmnI/ytxwClDmvq3Rkqw7vAhhHeS8FjJpHBWl85s
 5WaQK132MH4JwyNn6PAcXGzIagKOuj5hoSqHCCY2NZ4FQKabGCQYrl4ye6HWVX3UKPhqhMm
 t/lvErCHzXwrOIxN3Ia2Q==
UI-OutboundReport: notjunk:1;M01:P0:01TBSsL8jkk=;rffnFc1u0dSFfm17TM0rMFRXUXo
 KjYw6d2xiifR/aFzJEpBt7VilCr8AvTtz6kiPnpQBF/EJhPXBZyaliAWa5Al6Kfoz5RuLGoIW
 yobeSC/D/0G2lx1IDV9dEqk38FhIvxTbiOLaRLM/371knNyfbt2X4Y2MwKsBoPCaRGk2b3ts6
 ftHAHud6WbFdBT497W4N4e6AETwQIBXAKuNjEbQ0fQtYIlf9+8f8MAGnsH9mxBW4RvAGT/V7C
 IIRTtNnC0XyLy+lLzfOrJcYNPUc5mRdHI3BUBvVq8U/gbxaO+mqRZxvqi/hQW7DOVJpazNC71
 t1wYBtC0LpFZaeKwv3YibjS35IbuGvXsBP0t+uej2ePufGXG2HwvnqDzkQ1hp6mzRkZz6ARFX
 HjvkFlw+jPMn2s8f0gN0P8pkF2ehqMmNi8KtKBvEVd9oHGWbRE9m06ixD8Icn3CgKD66xOmJQ
 B+rGVlOP34xEPQdIXJmvZ/tHc5HkWGRy+/eXPLdMLXSW4cpH7SscmwLTQmnjPyUiMkCQpcZlP
 EVXez+LuBWnVGFSTXaiEEQDEKs5VH2A5WVuyAO81WzVlxDlZzOLdzJ1GXJECNBF3BsUNjadhI
 hNx+KAQyxooBMOIND+KRpfoKDG6N5nyUesZTiIDUEEM9u2HluV61iBJ8X7EtchIlGnx+wwTik
 koLcau4y5fWOwbMB5PJOnNGyn+QQnbxg39SeiWsAqjWJ7eahmNfXfF2p5turPV8uj6QHWeKzV
 63GLki+RW3RdcYpGPd8jczGJBp/c0+IIalayUY1kvHPHHB3RXhSxfRCf/WTndwtB3M0nvjA2C
 QJLHTxQJ23qIfotyTwWs0lZNz9Xg2ZYdE/bP2deOtbdizHSlCqnGRm+caUTxgQqbQnwuLErQH
 uSgZ5uZ8/Jr7EqNr6cUFP695wBj+zLrOd2PBLuShxyKS/apgtslP/Kmsk/GB4DIKUtC5l4C+t
 ulbXkFbsTwJ0wPRZCzPh5wdlkCU=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit 86f04735ac ("linux-user: Fix brk() to release pages") introduced th=
e
possibility for userspace applications to reduce memory footprint by calli=
ng
brk() with a lower address and free up memory.
This change introduced some failures for applications with errors like
- accesing bytes above the brk heap address on the same page,
- freeing memory below the initial brk address,
and introduced a behaviour which isn't done by the kernel (e.g. zeroing
memory above brk).

This patch set fixes those issues and have been tested with existing
programs (e.g. upx).

Additionally it includes one patch to allow running static armhf executabl=
es
(e.g. fstype) which was broken since qemu-8.0.

Helge

Helge Deller (6):
  Revert "linux-user: Make sure initial brk(0) is page-aligned"
  linux-user: Fix qemu brk() to not zero bytes on current page
  linux-user: Prohibit brk() to to shrink below initial heap address
  linux-user: Fix signed math overflow in brk() syscall
  linux-user: Fix strace output for old_mmap
  linux-user: Fix qemu-arm to run static armhf binaries

 linux-user/elfload.c |  7 +++++++
 linux-user/strace.c  | 49 ++++++++++++++++++++++++++++++++++++++++----
 linux-user/syscall.c | 25 +++++++++++++---------
 3 files changed, 67 insertions(+), 14 deletions(-)

=2D-
2.41.0


