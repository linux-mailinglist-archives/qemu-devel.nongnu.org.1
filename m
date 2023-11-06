Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6BC7E1BC4
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 09:17:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzumJ-0000Xu-IN; Mon, 06 Nov 2023 03:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qzulz-0000Md-Gx
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 03:15:53 -0500
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qzulv-0007xs-9G
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 03:15:50 -0500
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MjjKf-1rgNNs2QLz-00lDc2; Mon, 06
 Nov 2023 09:15:43 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 3/4] macfb: allow larger write accesses to the DAFB_LUT register
Date: Mon,  6 Nov 2023 09:15:40 +0100
Message-ID: <20231106081541.53688-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106081541.53688-1-laurent@vivier.eu>
References: <20231106081541.53688-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eVso82uQrgAqBr8bvnYuKHtD9ka4cSI5mGG6JBgYEChvffTVNlU
 I7o+foBAEDOgAVcOJrm2hv0LL5QL2MwwOOAjxlOVkuUclYMhPPtv3l8SY6y9axXlE/XedZI
 +bvIbyFHsoTI3ezCAEQrRES0a0qYNGRHHvyGsRYMNYqKPXDNNGxF6Dy222tSekpzEN1lzED
 w1M/J1kV+8FIWa5TnmNLw==
UI-OutboundReport: notjunk:1;M01:P0:0RQAEbnJE/E=;6DCyifJDkCLRpnLTwnXqksdMc3E
 2Gl0dF7sUAQyeGloC2fGXB3Z85YBP1B3FX39q5U4xJntjUr1T0e+p3RGPkiQdv7W8hNm3RcQF
 t/NHydDJPVIUfB2DrLJKBSY8FEghsv4X6mRuVEPlzUiSqcIrd5t+x/+miFf9qvpm+QII6B3K5
 T6O+6VAlarDUlpNtZ76fgvAD8qXkleTUfhqQMreqLJm1HPIBnGzuxckGZe8KmkvyqGsUxW2XO
 n4C37UckNwN8jNWVHhy4UOL9lyT6foss2At6IvLo9K7R+X6cYnJh3dgF3/zZDoViT0Lpb0EnU
 hJAiQiHWfmWWAQs1roDg14ORIe4s+9l/mDoUr5lUG1ZWjA4YrztICd/D7bd4Cs8Y4jga5oshM
 gq7h6CFdqjenJo2Qj9nud5s7DUI5aBJK43AZBD7bZn9ydG5RnAmaSIqD6kpK5aq5SUSUKd463
 +Z+Ho4B625y5h4tLKhx4jtjddP5EAWJaQDo3eGSlNNEIiltn2F+8L+u+1gPoqq6Xu3RZ0YhOM
 I1IdEgX9wJLlceE4421a4OuiM996yaqDQa6nUPhs0l6qK5XplCcbs3Ssn7IM6TLMhFHgsPuQg
 vOrv9ptfcPi3dVN4nPIrgad9J0tu6HOCDAUeaycgGucrlNZBpJwcM9pEZ9CLMjTyyBt/1t0RM
 H2sJ95TzGCy2do0WBgWyMjH8uy79DUgbq8K74CCkZlj8qhFwTQAk9r9iDPNpHcGawdiDKOq8h
 sg5IMnZFXDzBWQs6EWJ13sGUQLhT2JLHGZMkSbr2NWu5OBy/axIclN+z+9TFPWvGSA/cgSsO4
 QVQn3S6KCayCqhOG05m3o6pposQWtwQaeRQdwcPAEalB7hnZ8qiS6K5EVkXur9cnJWcEcC0qs
 rGZFxYKR05GCMiA==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The original tests with MacOS showed that only the bottom 8 bits of the DAFB_LUT
register were used when writing to the LUT, however A/UX performs some of its
writes using 4 byte accesses. Expand the address range for the DAFB_LUT register
so that different size accesses write the correct value to the color_palette
array.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231026085650.917663-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/macfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index eb4ce6b824c4..4a1c75d5720f 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -37,7 +37,7 @@
 #define DAFB_INTR_STAT      0x108
 #define DAFB_INTR_CLEAR     0x10c
 #define DAFB_LUT_INDEX      0x200
-#define DAFB_LUT            0x213
+#define DAFB_LUT            0x210
 
 #define DAFB_INTR_VBL   0x4
 
@@ -586,8 +586,8 @@ static void macfb_ctrl_write(void *opaque,
     case DAFB_LUT_INDEX:
         s->palette_current = (val & 0xff) * 3;
         break;
-    case DAFB_LUT:
-        s->color_palette[s->palette_current] = val;
+    case DAFB_LUT ... DAFB_LUT + 3:
+        s->color_palette[s->palette_current] = val & 0xff;
         s->palette_current = (s->palette_current + 1) %
                              ARRAY_SIZE(s->color_palette);
         if (s->palette_current % 3) {
-- 
2.41.0


