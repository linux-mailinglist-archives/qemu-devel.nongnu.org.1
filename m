Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FAD7714AF
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:02:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScQq-0001vf-V9; Sun, 06 Aug 2023 08:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQg-0001eJ-E7
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:16 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScQY-0005db-Ut
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691323204; x=1691928004; i=deller@gmx.de;
 bh=wH2Q5j3lm9FpTw8t3B3OJcOs4tm1iK2Y28uQcRF84Mw=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=Z2jFeqmrIHRW49lJfLAq2aO9Dvu/8OCsftRwE44jZw0A54KhkSHm/2mG4Pqc69aCADe00R9
 9dPREj8X12SXNjKP3Asg/L0cSWBnoBLhk7XYk7W9/w1tS3s5UuWzhYhyPSUFcmZw9I9qUXIjN
 MT39yzpmb3C+wG/F3nE3zxViqKRFRocX2vWs4c56K4vtUFIsqv1rMYIWTvq9cg+ZSB6i0lv3k
 lYXkUXZqRRXjKm0KXAhJ/ETFDqDhMJakU9EqLe/1wrWNRuvx8Cu/DyBIxFNL0r8B5jutDhHEU
 YJSxHYAtC1shmH1DvBfynlEnFT0ekJCIUH+j7InuQFV9/O6gU8Zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9o21-1qVfEX0VVN-005mt4; Sun, 06
 Aug 2023 14:00:04 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 17/23] target/microblaze: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 13:59:55 +0200
Message-ID: <20230806120001.89130-18-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806120001.89130-1-deller@gmx.de>
References: <20230806120001.89130-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yF1nDvDINr+/oRmPhvXKx+MbOD6OR8K01/wWLt0sw/aVPADBU0v
 GzHGQ+DqtsshVJ9uxwQwj0foYYT30TKzzzwtCai0W7XOj0NXkG7BokmEyKtMk7ixrgETUTA
 OVIqNO6cB54U0SQv/GOR049nDfd+E/Ig+lxDL8IrzMVSlFhHyjMbOMqSK+2Y4dgaxsce0Ao
 6p1scHRn9oFU3Coeb1cVA==
UI-OutboundReport: notjunk:1;M01:P0:1WdmIPtJ2PM=;9r+w0VCuXKG/djTAGMLdvr1Kf1S
 KHr46frD3FIFOjY+rn2NivJoEMQkWhfgrSJXk+/3B/eWAYQWelNJdwowqAeIOnXwdAhUJD5QL
 gBkfMUOg9r1INuWAFre9SLZa2TQpQIJxKpR2HzQhwnzvSCcDKaFyw4XLQ3M9btSgi3NsMc7bT
 PRFVjW0N4k8yGuEIGPSQ+bxEw2VegW31OGLtIYkQNKsAivsjnJhpQMmPblUhOH/YipsJki5qw
 55/046UDi73cSOz+Waw7JE+SVCuv0RsXz+zSDI894bil+g8OXCVgSiiBHe5QdF5ISc9EvHQhx
 2go8sJTsUGyMSzhBVk525ZH+ACngPZkWjCWxryvre2mS3v8ykGX7HVkrmzt29iP5Witx+r3O1
 08qH8RkXIZf+kt7py+j4pb4eNBBSqvSxUORYkahN8+3fJfHmHTRDjO54uagHECCo9R0FiNT3A
 xWB8lOZxj+797DifNd6z9xq1W5WplMNJa0XnpFMC5Zq1D1AH2nemG4YRiDLrfSckqdRkhJ2Gn
 ngLj7lz9D8J1TPNVJYLyrJxxXorNYBrGUeezXY1kDCtbf8QFsxzEkW4xoEdz++WqlN9j8GXfo
 iMqLVwo/5TKBcAeUc91hJu5YkBuCUoPXsw3jLOfBuWL8xGlwdEJhI++SdAIdvouIwZzIfmObz
 M+4TO0vJ1idtaWQ7L8gRv/ucPTunQ2g2M78dCLKl5VroNTGvOABR/AMjR2MJm7bSaM2HlwIfu
 dCZV9rOsfK1sdArM9ff+YoP6KHo9zYPjM3UnFAzz7MqQW5rK5MYjkDcfZQgUUbpLjxkiF1nS9
 iZDJ9jxHFMPpSQf/Pgy7mplc1eTN69MdOJwdTI2+zPZOfQslz18tKqhfCi0G/C1PytaLVn6Bj
 ezsmvMU7OUwyTZJPHBmUxZbrN9D9ge8MSjy/Ol0GvPR8eIZst8YT+OhcDj/WcTI6jcZCYcv0W
 J8fwqJ6BnmsOvOR0te9H8Ay/+0s=
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

Use the new MMU_INDEX() helper to specify the index of the CPUTLB which
should be used.  Additionally, in a follow-up patch this helper allows
then to optimize the tcg code generation.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/microblaze/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index f6cab6ce19..eed0d1d8ad 100644
=2D-- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -394,9 +394,9 @@ void mb_tcg_init(void);
 #define CPU_RESOLVING_TYPE TYPE_MICROBLAZE_CPU

 /* MMU modes definitions */
-#define MMU_NOMMU_IDX   0
-#define MMU_KERNEL_IDX  1
-#define MMU_USER_IDX    2
+#define MMU_NOMMU_IDX   MMU_INDEX(0)
+#define MMU_KERNEL_IDX  MMU_INDEX(1)
+#define MMU_USER_IDX    MMU_INDEX(2)
 /* See NB_MMU_MODES in cpu-defs.h. */

 #include "exec/cpu-all.h"
=2D-
2.41.0


