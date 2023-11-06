Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F22DE7E1BC5
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 09:17:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzumI-0000Xd-TR; Mon, 06 Nov 2023 03:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qzuly-0000MX-RX
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 03:15:53 -0500
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qzulv-0007xx-6B
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 03:15:49 -0500
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MuUrM-1rHzr000mY-00raJP; Mon, 06
 Nov 2023 09:15:44 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 4/4] macfb: allow reads from the DAFB_LUT register
Date: Mon,  6 Nov 2023 09:15:41 +0100
Message-ID: <20231106081541.53688-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106081541.53688-1-laurent@vivier.eu>
References: <20231106081541.53688-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GZbloz/oVG5VCNbOpCfBpENQGffdE3zuFuylMp+HWT8mTawvFl+
 eYtNN1rAiLzLTwM0N00fK/v+M/L53qAM3FrqRZGFkncdDRKLDBoaMzeA+qMGEWZHLd0yxML
 7YQtAwK6KnyILyeHrm/xD5N/iEDbRHqDeI1sKPj+XwwE22Vq/9zD/HdEjfAiU9wxOLNUecy
 v9xeSTtTkqzB66LEklgnw==
UI-OutboundReport: notjunk:1;M01:P0:LJo6d3fVYyI=;pR8y6h9zIhCtUJJlDy6DKBf7BwR
 IoIacKhqossRetHf0wgaYw47EBqem8Knt8E1J0wZACNn1HU4GQhcNijXUX2BoQs4s/YYxFpAy
 yvIUXeyFy7voXQgb3KETje3onaGG35XIbsNuT9xwJc2PobeGpPJXhl6TX1IsKzJ9eUdrVOl/f
 R+WjyhqFxxwgHcpYthJmvWcjcMJrJWxSVuGYS92u3Lh6xqShYGFVhq/0cNpV332BJFdmSlybZ
 pE3Yj6ArsqdSCz8LIncVM98jIurm+S1NmbNj+or5HHvDaPCnOlqiWOv1j5Ue1LGFsP01PzcHs
 9p3e7Ru15SojBNVxqQuykAW4YXrlOn3UIpmetr+8YeJaKmxu0seEsczImn7uc4VqyXKEgQRsf
 ju7gQPPGZAKAmb/AAR0SQJAjrk4Mki1069d4EiU5xL5IebHtZOiasI2g2QypYyICvPpWDzgFC
 rye66Totsr7ap8H3uA7hYk7Ypuf0FQEZy20ouyEMpuduo0wnTMMvoEiYzeeK8TDFuuuidJTCo
 QYshCvuh8JlDWFqupPN/QzJ7qcEbhDek0yA+kJnwKMw4Ci79Emi8iG58Sj3VDoGrtD8elGtGa
 0Tnt9HQmJdTCLBnwfwa9DeWoMvhUqCFhkt2ybsElAPwCHK+C/lP9xfU5J+IB9TOeEdumR8lYA
 dxGpWNCn8jsyBzw5d8ttFee5NutC0vXyxnuaGEnUxLtzU2i3JO4pwW7/KlZUDecNxCcgrns5W
 nXocUL/1eWIC+HAKulDH4j/0REUvtq9MVOWa72eISBGjFRFwls4miMduaGOjr1gDCh4Use91d
 niniuiiv4HBYDXmP8JWGa3/1h80EJZUSAIY2qUcySErU+dlz9cEZH632jikttiuNcpQ8JeghV
 UmiLrTAGLP1QMDQ==
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

This enables A/UX to correctly retrieve the LUT entries when used with
applications that use the MacOS Device Manager Status (GetEntries) call.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231026085650.917663-5-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/macfb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 4a1c75d5720f..d61541ccb5d5 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -537,6 +537,11 @@ static uint64_t macfb_ctrl_read(void *opaque,
     case DAFB_MODE_SENSE:
         val = macfb_sense_read(s);
         break;
+    case DAFB_LUT ... DAFB_LUT + 3:
+        val = s->color_palette[s->palette_current];
+        s->palette_current = (s->palette_current + 1) %
+                             ARRAY_SIZE(s->color_palette);
+        break;
     default:
         if (addr < MACFB_CTRL_TOPADDR) {
             val = s->regs[addr >> 2];
-- 
2.41.0


