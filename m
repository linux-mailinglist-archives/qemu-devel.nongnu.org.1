Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B86FC7714EF
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:20:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchZ-0000F0-Oj; Sun, 06 Aug 2023 08:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchW-0000C4-JP
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:38 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchT-0001mi-I9
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324253; x=1691929053; i=deller@gmx.de;
 bh=h9yd8rngpT0I0RPSFORtYiuKz7zcmMDvTe2DL8IxR4U=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=MFj5sNo49M4zGW1gU4V5kryeFgQbyBGIsArK3cnyWJSBf1QkvTlv6dESM/jwLNj056NJrmt
 DgcySDMS3CuqWPXSCI6Yjc3vrsBY08OPgbKbpaFd1kzPlkgoPXa8nStTHE8QdapNZoDHnICQl
 AemVkrLGwr2DN8OLrh8b7XuQUg+lldy6DHorpJ+2/e3Cvtpwh+gdobvuNKCWJ/HRgQ0HyL8F5
 NmvraTxMRrlf5G+1zlpnhNr7UDR9/PIWw5YRMXqGSHUAwZf1bMD6iW1ppg8AnlVMFDsRCguZX
 tAL7IcZk6jiwJKsNpsRaG56ArrnLqqaYsXGwpwQ7BJZfvLIZPIEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ycl-1qPaQY1y0Z-0036U7; Sun, 06
 Aug 2023 14:17:33 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 05/23] target/avr: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:14 +0200
Message-ID: <20230806121732.91853-6-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZLKyKbiBj2L3fUQM744R9tzkIa0EZj0fcs/FZWO7MfN+/bmMM0A
 QGiacvRb0BjMie77BTL7iXYmkzZd6luTA2YBRKppQnQOWphvoDeMFsSpLU6qxS6RI2hpGzq
 wI27b602xfG999LK5b5ZzZBkm5+vpQo8TTX2YTcOy1PvVIBzZBTCR9KfZjgPTwxHcukPkvy
 tF77N4ZnCm9q45EchxtWA==
UI-OutboundReport: notjunk:1;M01:P0:mPaKDC33C3g=;5/Hr4rPm9vFihEg+fLt3Lv58mAC
 NfgtvrrD3I1eNUTWrzzz/QNq+Y6U+TF76mhe5+q95N18I3LIRjfTu992yEoPq7/VTl2xUEDCo
 x7hRXCNo87oYp6KLfcRje2U6axlzHv4BDSi5hKOm7zpuQf8/yp1IM9qOOPgzRQrWeUsDyUmAf
 sA1SlV/vXTIKduYpQNeXbkIDTA/3fWtfl7cwyIx9ZcGPOnKLQlDWPhgfVGiBUNhCHY4V6NnsH
 owi8VYtsWtLEr8zObhGKrsVPB4XPLCJCG9PXA4eAo4pZSOYBEwCuqe9Chu2MIwhPypMRKv+6g
 2FM51mf8JSjzz3BwQoCgvyQcVhzhnGod3t3Nl80cNHX3FUfFTB91X58Mnsjvj0yHWLNdHzAks
 ikTlVcG42oQ+PW5+l+5kboFSL7g9Arftipxq2oRAidHSXpabfa1DDOFKCdx39VLSJqQ5vCjaG
 pa0qza+KsiT8KYpPccTT1nWeRQTJFsKYipCGOUpgol//4C5CRx+1A7B9Tjk8XIjlOPUFnF/nr
 seFZR53LKhpayauGMVKF7wGJOjkgk+38c+mCcMQdH5FLhFelgQrViG7Rv+a0slh1BS140ovJW
 xXdxrL7ruRISLV9Q1DepC63uJu2HQ4FFYo4vqDX7qPsUdCim7tYZaLhYaXekPoaClyNkfcwkS
 4Eg9AQpEy49xXF9mvtnX3yzs2YScoABDlpFSwNiPb26TpnsdD3SQEsQ5Vq8B777R68UR2GvoX
 6DufgOJpqlcMnTwxNDidMUhbf/BCevKRia2YC+XYSsXkhg4v2/vt5kEWe0/zolDyNUQXzEPce
 FhBB0o/iC9UDbCeT5G48k8wsiT8aB2WS2A/bTloB0AxNviUYrzTw2D5sJbZ2aBP0zpy5NHHob
 +gPJoy2MFYRwmXUU8n+fLiSoVMzBb+/PqXO2KbegEqKeap50V2uAOlxn4fh/YQ9VTi20hfk4m
 98G0XEB9YLtsj8VG5Gu+4GgZZb4=
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

Use the new MMU_INDEX() helper to specify the index of the CPUTLB which
should be used.  Additionally, in a follow-up patch this helper allows
then to optimize the tcg code generation.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/avr/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 7225174668..8b5916d243 100644
=2D-- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -40,8 +40,8 @@
  * ST/LD instructions access data space
  * LPM/SPM and instruction fetching access code memory space
  */
-#define MMU_CODE_IDX 0
-#define MMU_DATA_IDX 1
+#define MMU_CODE_IDX MMU_INDEX(0)
+#define MMU_DATA_IDX MMU_INDEX(1)

 #define EXCP_RESET 1
 #define EXCP_INT(n) (EXCP_RESET + (n) + 1)
=2D-
2.41.0


