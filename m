Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1AC7714F6
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:20:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchr-0000L7-Hw; Sun, 06 Aug 2023 08:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qScha-0000GM-4M
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:42 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchU-0001nZ-ES
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324254; x=1691929054; i=deller@gmx.de;
 bh=wH2Q5j3lm9FpTw8t3B3OJcOs4tm1iK2Y28uQcRF84Mw=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=Q6z7v1NcQOXy38z8QBdySH3294TzvQfk2hZwhEpe0TEMNN+2YfogH7Zm6Hc3rwqveAZ4t5n
 neYZp8WNVzG8TxImzWWV/MGSkHWo4m76IcAW+neE+xi42OVuptH8g3UPxpyioG1HFsK1zEIqX
 QJyqZCOYUt8ZLx12T7xu4kHsOtY7TFxEG3jRpgs3Sqx9IOa8khBwNg3WnL1ctRNtqVrZUSOwt
 na/eI3ryThuQc9n/DxIabcThP9z2s2eVFZKUarSamU1Iog5hhSa3DJa6O98qOhNxjOBRwtYgC
 ENboliczfdnMijlYUhjy6clGBBlB8KUv0xLrJXh2aVUtCkkmkINA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1q8Keq2pMw-00KMLy; Sun, 06
 Aug 2023 14:17:34 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 17/23] target/microblaze: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:26 +0200
Message-ID: <20230806121732.91853-18-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yvHH+2XIloMrCAQZFE+BMeVBmkJBuzHVPZnnEsxiIKa/LjYjczf
 6NvPgLsgXzru6GEAfSv+VBfvYkbv1t/efI2wefrRw3jc/NALcm49oUbCSyF2exEk+Dsk10w
 zPEmkHzj85kGb5QRNKIw2yvk4NwcttpPj1MPByM9hrA2ydJ2WwmBXBwCKfQVO+XfQI+oilU
 hIpmrKYGHwRydBHXQpyrA==
UI-OutboundReport: notjunk:1;M01:P0:ZnMi8V1gS6w=;3IHzXl8Ya1NUFys7zIes7/arcBh
 VDKV4kJ9o60YWl1A72SNxPzOm8S1gNg0qynCWZU/Ib34tlMXiVSbgjluFVDszxPcD1RzhtHnt
 KwpTfK7/1927G9qB1CWg/5zd7ldetMzEBunoQHCrvFaRa96ppcqXvZavNqZYbRGG0dgZ/FTjL
 iD9BbmFGrKenWI62I9+oknLDwZVLkfi+PrizUwB4HF62k3x5FNOgFgaMrk9+alpigMTZaGiGS
 zx668+2oqoT5YPS3+rL3JuoYnnStYzt83BXfnp3bWw3NvuLgFe7+FTcgqS7SQDsz7/f9smWU8
 0wncTCvYeWdnFkPF/XvBM2N4BEFZR2VBtEXoDEZAEnv7i2BLAFuDS7GMoLEaVjhH3oQBiGzY7
 sMwefTvliOoKbw7jhCatmBGVf0kjPrhWPMA9+i2vuiUipYGIz6NnjyxeY+ISjJlZrVRUWGGsH
 P+VZCEhZT7FkUeFpWkhzOP8r9xZv3pWzvmZHyQZDugGUUJMZexHGU2s4Do8K2WqKF7OiKMJ8v
 Cs9M9V6CRhEa960quDFgxmR/eu0JUJhjV9zP9iiKlgS3aS9GFsa9Qmrj2n39i8+ECdlS1dXi6
 QciCoOXVD0vdgV4bKARjCsktFgpxCx15+LXaUQ+3IioUa2Nu6e3Ov8JrkrqDxqEGOznmKsAvZ
 W+GGLGmPWuvS7n/IKbnXgOWT+YmQlmLqSBfrSP3Oj8z4HCRRk7Tt6IavRlUpBc2nzjhjXilDS
 QxCD6twXsXd+i292SREI7sUcMA8FvGJbfjfIj6b3cHKQGkJCAkzfBOz1yJUFw+/KWBHnG28eu
 28K6+ajr33YUe605+oNowCjfYApTAhsyi3jWuqWpj4tR42zLS1OX5G7L9q5wHvSoOsjGVBQVd
 pQFnej7Uv165cOHoJhkaVUm7s0tpZRsIipdk8aNSpKoX+bdVey3mWMfR7Vhpb8sJDlCZzavrE
 MQeGUPnNTk8bJ0FOEkhdt+hWIrI=
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


