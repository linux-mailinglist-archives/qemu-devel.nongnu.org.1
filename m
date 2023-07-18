Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE1D75851B
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:54:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLpoe-0000tl-Bh; Tue, 18 Jul 2023 14:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qLpoc-0000sq-95; Tue, 18 Jul 2023 14:52:54 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qLpoV-0003NN-OH; Tue, 18 Jul 2023 14:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689706364; x=1690311164; i=deller@gmx.de;
 bh=Rx4B0JKQX5xnCv8PHKKcBOIyM5MzrsGvZF5tbMB77Mo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eoXHds/vxsoNXrLOVhtylLa9K+yFbiLykAqSXD30UGXYnoqJyiGzYshSo5oQhZStiee86GF
 5HRxFgTQHdHi9agafm197Ru1lgvnO+iRBpEJ76CP5trTyZi23M4C3HeFSUqgA+qUr61M7ZlhR
 NupfoF3/oVOtg4T0fuY+rwYmSfD3bEFFiHv8R+yzOVecVCIktl2kQl/eH7610SU8WNd9CL+ub
 TmvlQOh3xsyafqZc4eM2cutVHJx2QJ/Ii2aku6bNNjCIoU5na+hPe/bPgCTUDJBmfaTnx3IGW
 0J6QiG4yi/6mG0Lfsds0J29EchzHM0886QUWun1HqwFlNiSBeySQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.74]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpav-1peXlT2WoZ-00mMPt; Tue, 18
 Jul 2023 20:52:44 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Andreas Schwab <schwab@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
	qemu-stable@nongnu.org
Subject: [PATCH v2 5/5] linux-user: Fix qemu-arm to run static armhf binaries
Date: Tue, 18 Jul 2023 20:52:41 +0200
Message-ID: <20230718185241.11433-6-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718185241.11433-1-deller@gmx.de>
References: <20230718185241.11433-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uu8rxaudrckdKw3xat1fW6YiGzaEPrChCyZVfu4g/Hd7PmEQYQT
 qj3a9Yn8Rr1aoaBpYqZm8NhMGyau4DE/XNyIr4b+7lE5ogncRz0XPNrJBZSfOk8rCPIvT4n
 4GnKMN+cBfZFhdzgPL4rHdEDWaqOFq8V5Tv2WSRyWgfl5L9KGSmmNaO0IqGoT9YuWLhAN6A
 Pvx7TsOiwSFHHdy4Iy3hg==
UI-OutboundReport: notjunk:1;M01:P0:EZd+2tv+q/I=;pU0bylCpK7TdeEHTchkp11B9V62
 oID3Hoi6pSO6V8mx8qbCCumEkz8/5Zeo0KMbSkt0D/stWJaeFFbKJ6Ky3v9W3daOhIj2rEs2r
 xZoU/o1639NWn2+hWParotY+4ARGVD+kf7j10Uo5yt6mdNBDT2Ys0VmvvO73uQUfu3JN4uU6+
 VY0g0JNFjmKVJIXlG3V9m+3VzUHqt28pNJgOz6R11p1oHXGHNzGlWaM59N7s/8FRZpq+326SI
 PinxhVE/fKpUoYuYCHMMCNdqFv3SMoWxOT/Tzw4f4Z1smEkh0bQz2iDP4/K5eZi+4p+jk1YEo
 NMKQBKULGADZMjfOGBq5hNk4ftm6fq8Mn9AasNPk6doY4i3iQhx/skI6OVHhf77k2P9BZIV/y
 3B3YiCMviT1AAww9EcxcE7ko04Rb0FkBQQVH06Tf4sReW9PxuEHm25kSkmYUpafIr83tHtehp
 WZMavksfXPwIzSWkKLMYSFQAGas6Gmlm+avIBGj8Zo9fv3vBhWLCVGfpufRTJiB1qn31klo4C
 WbxCdBRW1YoIoVKrXtHbVV/XS76KCz2sGH2tUNcz4ukWZ7UEqEzEXQqyZin+2VVfsSpfWnzMi
 wt7HvYEuTzsGCbE4e6liwtXLPtZ/pOLEXVaN3Gqt2gT1fOE1Rj+s4vopUhSNpTZF66VJ9LhXr
 83yXZkxeQmIkxQU+W2ZHxJ7SAuA78qnNAi4RwyDV+UBfXCe8cCz6K56ZHAsxeiWxGb7/m3dDP
 788G29+sgbl+47tB3YyLY8O/H1gmmnilLVPPubZIrUGI4+ojIyE/MIV+VUyEY1oUFQJDzs0WN
 Y3S7iKhExFBLa3EtpZPh7pwA5PI33TIRkr7m6kegh+amqwmojRv2f2UnV6fdLMiwiTCDHUNl7
 2Zc6LkxdXahgxgqVkAViVcAVpQ6zTSBA2v3+5oLLk/9/ia8EDtN7p/DV3JUIewg3OvJo2p8gr
 QI0I3L4ucMDOm5OFpka7VhCSI1c=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

qemu-user crashes immediately when running static binaries on the armhf
architecture. The problem is the memory layout where the executable is
loaded before the interpreter library, in which case the reserved brk
region clashes with the interpreter code and is released before qemu
tries to start the program.

At load time qemu calculates a brk value for interpreter and executable
each.  The fix is to choose the higher one of both.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Andreas Schwab <schwab@suse.de>
Cc: qemu-stable@nongnu.org
Reported-by:  Venkata.Pyla@toshiba-tsip.com
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1040981
=2D--
 linux-user/elfload.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a26200d9f3..94951630b1 100644
=2D-- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3615,6 +3615,13 @@ int load_elf_binary(struct linux_binprm *bprm, stru=
ct image_info *info)

     if (elf_interpreter) {
         load_elf_interp(elf_interpreter, &interp_info, bprm->buf);
+        /*
+         * adjust brk address if the interpreter was loaded above the mai=
n
+         * executable, e.g. happens with static binaries on armhf
+         */
+        if (interp_info.brk > info->brk) {
+            info->brk =3D interp_info.brk;
+        }

         /* If the program interpreter is one of these two, then assume
            an iBCS2 image.  Otherwise assume a native linux image.  */
=2D-
2.41.0


