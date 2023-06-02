Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B03D771FAEA
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 09:26:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4zAB-0005i2-3r; Fri, 02 Jun 2023 03:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q4zA8-0005fA-S0
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 03:25:28 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q4zA6-0007W9-Jv
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 03:25:28 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-39a3f26688bso1404435b6e.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685690725; x=1688282725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gf8W1Xf2Y7RWDSr3IHqzLWdnQ7xsXqcQcsDxS67Q/m0=;
 b=31PQvYTSVnGBTgW0tWfUa/dgmsZ2jR2ZCkNW4Pzxrz24sFLSTjDNNXF1rgan7Xmgb0
 AUNBoYUkcFh5PNPV0UdA+zV498rVHnoWXcaR+NgFWT/zUeV/2y/RFFAIHgPHC7ZdgXEF
 VFCxoD41T0cF1Hc/45CtC6ASHyEpM47Kvquznpvtgap3wxoQfgIiD/vtjOoAvzl8SpxZ
 0C1LBMZJsttnRXnsvD4Ik4rF2e/r9bF53J3bdzwbAmrfHnQkwPDGumG5O8Q0iINYZRmZ
 AbCCVQhTvJbAvZysQvQWTTI4II+q6n1rE61RHhB+aqdmvVJxgtzFpaHakdiRdXHgoTjq
 evrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685690725; x=1688282725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gf8W1Xf2Y7RWDSr3IHqzLWdnQ7xsXqcQcsDxS67Q/m0=;
 b=XwcnqCqs6Y4NQXx/Br8sODjzHap1yKv6y5gOKRl4zpzFVSI2B+ZrNAP93Yf0lL0H24
 GELtyUJ4B1Mgsi/EfxoeKP/gW9KF+MNyw1cUTxk2a4Oaz604kWVXAKkCNRVBZK4LpFo6
 PrKwzDDUpmZWd1EyNWeWtw+M9Zqu8TyXblyRCjI3VvEtFho+kbF4EZckBXEtnX2pji7V
 4z3JeMsGlv8j3vR8VRzQaj8BzyplSHUv0DqCF1M7O+4zoWQcSu5mjAAnBgeIyenucg0L
 f+CF64v4sURHPCDD/+eEVqqI/Rigm7n64p0rfVbnqPzC4xQkqE1WE/ZN8p9Bv6+nSUJZ
 prSg==
X-Gm-Message-State: AC+VfDxHo5t8dBh4JxAd6Iua+y5yV7CObg6Ucdvasoo476wLxiGGPo4w
 jLGMNI+KUVAcNR24VSmk4AJgBQ==
X-Google-Smtp-Source: ACHHUZ7F5CHCtNGSo/ggdYthVmAaThYDjJ5hOQaNIpm2mWXuVvrZub3S98vio+deVXsuvQt/3yE5oQ==
X-Received: by 2002:a05:6808:91:b0:39a:bf0:4fe0 with SMTP id
 s17-20020a056808009100b0039a0bf04fe0mr1585786oic.15.1685690725263; 
 Fri, 02 Jun 2023 00:25:25 -0700 (PDT)
Received: from alarm.. ([157.82.204.254]) by smtp.gmail.com with ESMTPSA id
 j4-20020a170902c3c400b001add2ba4459sm625780plj.32.2023.06.02.00.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 00:25:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: intel-wired-lan@lists.osuosl.org, qemu-devel@nongnu.org,
 alexander.duyck@gmail.com, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>
Subject: [PATCH] e1000e: Add ICR clearing by corresponding IMS bit
Date: Fri,  2 Jun 2023 16:25:16 +0900
Message-Id: <20230602072516.42502-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The datasheet does not say what happens when interrupt was asserted
(ICR.INT_ASSERT=1) and auto mask is *not* active.
However, section of 13.3.27 the PCIe* GbE Controllers Open Source
Software Developer’s Manual, which were written for older devices,
namely 631xESB/632xESB, 82563EB/82564EB, 82571EB/82572EI &
82573E/82573V/82573L, does say:
> If IMS = 0b, then the ICR register is always clear-on-read. If IMS is
> not 0b, but some ICR bit is set where the corresponding IMS bit is not
> set, then a read does not clear the ICR register. For example, if
> IMS = 10101010b and ICR = 01010101b, then a read to the ICR register
> does not clear it. If IMS = 10101010b and ICR = 0101011b, then a read
> to the ICR register clears it entirely (ICR.INT_ASSERTED = 1b).

Linux does no longer activate auto mask since commit
0a8047ac68e50e4ccbadcfc6b6b070805b976885 and the real hardware clears
ICR even in such a case so we also should do so.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1707441
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Supersedes: <20201203133236.222207-1-andrew@daynix.com>
("[PATCH v2] e1000e: Added ICR clearing by corresponding IMS bit.")

 hw/net/e1000e_core.c | 38 ++++++++++++++++++++++++++++++++------
 hw/net/trace-events  |  1 +
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 9785ef279c..338bbbf4f4 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2607,12 +2607,38 @@ e1000e_mac_icr_read(E1000ECore *core, int index)
         e1000e_lower_interrupts(core, ICR, 0xffffffff);
     }
 
-    if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
-        (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
-        trace_e1000e_irq_icr_clear_iame();
-        e1000e_lower_interrupts(core, ICR, 0xffffffff);
-        trace_e1000e_irq_icr_process_iame();
-        e1000e_lower_interrupts(core, IMS, core->mac[IAM]);
+    if (core->mac[ICR] & E1000_ICR_ASSERTED) {
+        if (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME) {
+            trace_e1000e_irq_icr_clear_iame();
+            e1000e_lower_interrupts(core, ICR, 0xffffffff);
+            trace_e1000e_irq_icr_process_iame();
+            e1000e_lower_interrupts(core, IMS, core->mac[IAM]);
+        }
+
+        /*
+         * The datasheet does not say what happens when interrupt was asserted
+         * (ICR.INT_ASSERT=1) and auto mask is *not* active.
+         * However, section of 13.3.27 the PCIe* GbE Controllers Open Source
+         * Software Developer’s Manual, which were written for older devices,
+         * namely 631xESB/632xESB, 82563EB/82564EB, 82571EB/82572EI &
+         * 82573E/82573V/82573L, does say:
+         * > If IMS = 0b, then the ICR register is always clear-on-read. If IMS
+         * > is not 0b, but some ICR bit is set where the corresponding IMS bit
+         * > is not set, then a read does not clear the ICR register. For
+         * > example, if IMS = 10101010b and ICR = 01010101b, then a read to the
+         * > ICR register does not clear it. If IMS = 10101010b and
+         * > ICR = 0101011b, then a read to the ICR register clears it entirely
+         * > (ICR.INT_ASSERTED = 1b).
+         *
+         * Linux does no longer activate auto mask since commit
+         * 0a8047ac68e50e4ccbadcfc6b6b070805b976885 and the real hardware
+         * clears ICR even in such a case so we also should do so.
+         */
+        if (core->mac[ICR] & core->mac[IMS]) {
+            trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR],
+                                                   core->mac[IMS]);
+            e1000e_lower_interrupts(core, ICR, 0xffffffff);
+        }
     }
 
     return ret;
diff --git a/hw/net/trace-events b/hw/net/trace-events
index e97e9dc17b..9103488e17 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -217,6 +217,7 @@ e1000e_irq_read_ims(uint32_t ims) "Current IMS: 0x%x"
 e1000e_irq_icr_clear_nonmsix_icr_read(void) "Clearing ICR on read due to non MSI-X int"
 e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due to zero IMS"
 e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to IAME"
+e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims) "Clearing ICR on read due corresponding IMS bit: 0x%x & 0x%x"
 e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IMS due to EIAME, IAM: 0x%X, cause: 0x%X"
 e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) "Clearing ICR bits due to EIAC, ICR: 0x%X, EIAC: 0x%X"
 e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits due to IMC write 0x%x"
-- 
2.40.1


