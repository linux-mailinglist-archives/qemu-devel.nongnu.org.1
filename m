Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E19347714B4
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:04:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQj-0001at-4g; Sun, 06 Aug 2023 08:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQc-0001Zr-8i
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:10 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQW-0005Ya-TY
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323202; x=1691928002; i=deller@gmx.de;
 bh=+zCUxCVvReasse/M3JApczVrlfmNzUS1j4j2/1ouZbE=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=AJakhrrQkNonZyMD10wjp7Di+JSZeEXZ9f5GqBZyICtBWFwlafsybVcztjEfqknPU1DGBm0
 OGHiWkT/PEmbsh2C625oCd+2apQCQweo1g+Pg+M+PnxS8VYw3PczRzgMMyxGAU+n4zuTjziOh
 GuJ2tcEfteZZSKk0yk8Xz+HTD2mcAFPGZFqUhvApCkRoWSQchrMDk/5vh9qNEIp15GUaB9qou
 xt32Yyll23ZXND2F+u8Ub+qTt1YD6UNVH30MpBmmw5ReyC5S5/qhOrMw7d/47keb2TSGTBtMg
 L96EYS/E9jxs0x7EUrsg9Y0mDp1yakMpFwvgwbxhhuFeOkjc6vUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs4f-1q6G7H1k8H-00mqra; Sun, 06
 Aug 2023 14:00:02 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 01/23] cpu-defs.h; Add MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:39 +0200
Message-ID: <20230806120001.89130-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:upPPMKrLlXm8MOZLGoMw6ZtTOfx4anj3Q+Cpx5VJJk+1FJyx1Vh
 QShijZDsrV0HlmRItVBy/tX/02KK0qcaMwGWUqPC912TYSMASw6+/VehU1PD6e5+AvZU388
 H17CSnfrkFfiP24HGJV4hl8/J6iV4ElEsg07Ki47Cyzt4rhVbzfNRFMRkgXQCzItZYMI1ZO
 un5Y3/IQddu/tfjiTsO5w==
UI-OutboundReport: notjunk:1;M01:P0:5/qONVfyZMc=;y3QXNRpqUzuriCBHnVC11VSIysW
 yS4FpM6dsE19WaD0IDla6jB4gCpMwHqZCr3A5il/P10TPNN9ax8YTFk1jbUggdwu3T+dsEiwY
 Irlo9v+ALg5T+3C0AQJrjM6bG0ODia6BUOgeno2c4SUrkCaujcn2EnAyB0D4tP+8HSRvtZxhU
 u+2Y9OPV8suWTxnq+t/iWmOT3SDi1hulB84CJ68Xaa3Y3ORj3TbtsaCo31Qx6SYhLOtBgX1fV
 pEwtlTboGG3OslNX9Tdz8W3acXgsrBmMbCQjxXyFsn+iQEHftIeQDIBbzZfIO6NN6Ua5+przi
 7QkpauJyQiaFqz/7tEYJFNeJOlRyps5yBnFAnQhTbYVRbxR/1UDC5uIsQq5aiMgucpSwgtP9a
 f9+cIS0DDVML0pFcZXcVly65BqV61QfYm0ADteQGCKHZKTbnno/RcC8rGsW8sSGb6hRH0poqZ
 MplIeymKaWc/vs0qnXsElNSsxHQchJUUojhtoLEFEV8pIfpAyKJUiOwaZCpD/aYZRU+RdxC0y
 VtsJM5p8m2SqA8sD4Uf+lI0waUBjaKP8MceX4a3MSNqI6iYKLeLkGrqjL7MWQHYoU4+lxvzOL
 84Vv6dxebjzvKGnZMFsT/AN480QkdILuO1nQYV6+tT9AtWPEikMukvwhuvmHM5bVV3b0EtsFO
 T1JqQug8DJjv3K9BQ80LTbk1lJQwdDpV6hAIOv1DEfGv0yiEKFA+LvQ0jMInatNQENAe5zOs6
 pFS64k8OlluR0xPIxFOTXcL0KoNJZTx3cA8VGrZkVbC3696kOADk1FOymk2XAE8yPTx6MG47i
 ge9PACg5AnBuTKXRjqCGiXzi29/lprDjPruozUMKuQNqiQ+9kT278R1wCpW750hBNX7dJ8kKg
 HyjUDCh/3q6Vq8Zkpfi2qw9O8w6OpeOaOVUjyP6NE+TeTMJUWgKYwZuy3KEck15TuOUPwbl9w
 rTIBtgb/bhVtJMacEzTQKL2lr0w=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


