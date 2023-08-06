Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3B37714F7
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:20:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchZ-0000Ex-I9; Sun, 06 Aug 2023 08:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchX-0000CY-1Q
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:39 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchT-0001ma-Bj
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324253; x=1691929053; i=deller@gmx.de;
 bh=+zCUxCVvReasse/M3JApczVrlfmNzUS1j4j2/1ouZbE=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=hAtyWiO6c7ri0b/Qk0lZFTffiHk7LbO3asY1OPtUKK5P4E+/BGLQ/QmTr27NedTfjB+0Wbl
 VgAQvojDI35B1nel88YFvVzDjv+hFU2fDTCtdgKAh/4Ssw4T8PK1rG3czVsOogoZbZ33QxrOs
 WsVuZ90UmtkoFp77751tFgMRsYUuM4eMBb/90jAPQNm//XQED/1aUiyuRvJinuYsYmFqWaSHi
 lUH7dxKDLD/RW1Zn+wsSj0XhvcBxywEqrP0JnjtXcL0yGd6UDWF4vgP6LwJzhET4ccmkNHycd
 6RA4x4AWxv1Jy1sry/WzBsL6iLmq8D0xWiGUpJ2zNULMK4wd8zjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRQq-1qGc890KPE-00TkI0; Sun, 06
 Aug 2023 14:17:33 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 01/23] cpu-defs.h; Add MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:10 +0200
Message-ID: <20230806121732.91853-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZP7Wo22Y7+w4FTEOpdh8gUOQ3J5E0HBv+B4tCOQcAS8UVBVBMbF
 nX2am371lii08ZsZDOLpyCuTBgA1lOtNGepWli5Ann7DaRPhcynCVnsID4bPJVVRBNDHj6/
 /3eweDkTxZqkwnNi7UK0cLTwAMlpcQk0hyZi1YDatM6IZ+wpLXJarP9XLftIb+nJGg5K1lU
 GVVO0ywg7XQUpERYbc0Dg==
UI-OutboundReport: notjunk:1;M01:P0:Cx8N4jL2CTY=;h+LpxDcfN8+DCQvLcYeyx0EwwuJ
 exNCstxeUBec9Ov4Yije2zC1UPUVBIJP0TM0K8edmcaXAT3HAFOtx6Uehp4+2ZWkVOoRJN8Yy
 dv79LH3bkJSYc+ky6KAqeX8rgym/+//C/cZ2+Xx5dYG3Uw47ntht3D9IN4jV7P+szKYNqAuQx
 MBPm/388s3NB3uTHGw2pbsjBXMs0rYutxW1JOvMNmgbuxcC99khYnhUnv3rGy8iZ5Vc8iP1BN
 FiaGF7JxwWY4SXSojJpgSi9M9GWV6OP2cC7XqSpgJWUv3y1ljvYqAEsSp3Y3eZk5VkIXao8z9
 4Ka52fsCf06OaGxK+TT0uxqeZT1NlnmmQSqhq/+bZ/xK1pEmJ8FWygNyTOeRD+bNzDck4fvIE
 NpjArK0oRcsS7lhhpOhW6Z2gFK4F/rOrKlTI9+8W3dv1i/pSqIgVX28EFqe7s1/gU4MHN+8/r
 7oA39wrqtJgdSreZYAv4Ng2sgCK1EyuUoXdML8uFp7czO2M+iPtdBueraQkxNF5N0CH0a8i16
 Ifc29eMgROQQ2C+inItqGckPhZgweS01362WXa7EFLfCGK5OmHh0QatWt08a75IG0IM/hxz7F
 79eeecyOus64HtC5iFfDT9FnhWAfEQWZAKrVaeujAGZSC+IMbc0ZG3/IBUa3szLtmU/qHJ8oU
 KYipQeS0/BmsD/O29CFIoG7U4BfNuspafWNSYKlefde0viuOe2xmjcSZZiPQW+c6LFJjV+U39
 FSqyH1CPD6dVpwuy5RHE1spvvGNuMVWmqZtQjqmHrbLtIXZvKXm5y3n6iot0EP23/ueN4WaSV
 pqeomMS/pHmpoyGiGjl3q9xMEGD8jjH//hpOWFCdFLXZ7j2ZBE2FthUy9VOa0ixhntKpaNut1
 sQ2cyVq7ExaftE/qa+JjZY73YmplknZ9TqZEZTlNoWoJ15pC/y4k3T8lFMacCKYNzIAmLtKlD
 bIVrjg==
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a MMU_INDEX() helper to specify which MMU entry to use.

Currently this is just an 1:1 mapper, but in a follow-up
patch it will enable us to generate smaller (and maybe faster)
tcg code.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 include/exec/cpu-defs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index fb4c8d480f..07bcdd38b2 100644
=2D-- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -60,6 +60,11 @@
  */
 #define NB_MMU_MODES 16

+/*
+ * MMU_INDEX() helper to specify MMU index.
+ */
+#define MMU_INDEX(n)    (n)
+
 #if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
 #include "exec/tlb-common.h"

=2D-
2.41.0


