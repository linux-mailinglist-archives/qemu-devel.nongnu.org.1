Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 425EE70D1B8
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:49:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2s-0003Wi-Tr; Mon, 22 May 2023 22:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2c-0003Qe-Jy
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:26 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2a-0004k5-0Z
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:26 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2533d74895bso5041096a91.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809982; x=1687401982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1Q2D35xtM/dApPJaXR0gNCr/zwqxhAMZGQrfhieACg=;
 b=4cCLhLs8auxW9L1QRJw6glDT251XHM4O/ahZXZ9Q1mOqNPhVunIRhbaEgqw5C5o8Tq
 PpkLw5eNMUdLLUkL3FsHkRW356XFbk2s8D/A5yeLfmHWy9IlGr2TI6zVfS9M0mFbGSdC
 6+wK/n+LmpfhgcuYeuTUxkU9H34C+jLvgkGnGPSjv41R9OAoPO3m/I/clatkqrYTr6mf
 jIeMrZferpWvkJEQ/Gh0oWAqkEjkEsxEYswQunEr/e6Ve6DKUcEmD+WYAAQD2Mo/KZ0I
 5xteeQ0qFhYfTPF5AjqlfAoY294/wkx0nxKqSDGFetrt1hEeJ1WBET+iIdzlSgdDT+/t
 HIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809982; x=1687401982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B1Q2D35xtM/dApPJaXR0gNCr/zwqxhAMZGQrfhieACg=;
 b=heL/vCkhdFH2JfTn29tDiDyMfSrbulQdZOrvhoQT4XWXGxSNOzSc+kqzQc2HcO7CH+
 x38JNi6SIAmeyUMN1RKv5L6kx5ZmgHIUvQc0yvE65EXlNuHMDtlsLD+gJdvMbmPsQ9ds
 PTTTzAQdikOjWE4srQ3ABg7vu6gvmbtv093uzEEvRdTvPAuLPFwnshBivKxytZPTgiIJ
 1xH9Eb9IuT2k+vOFBmMscEiaI1suHCRTVnyli3XJuX+2erc7lG61u/VibEojm6kNB6pR
 dWphtulZ+fMesu4uGCS79FiUjZc8ZJir9pq87QhwQTFpFZF+F9GfJtR8KdOD5cLypQFz
 utlA==
X-Gm-Message-State: AC+VfDyUuc9+P/voVF6j0l89lTONIGVxz9DwRN7IYLpy7m3gqtqemZzA
 8vq+p+Kkc1pohtw5e6JTRLPZ1w==
X-Google-Smtp-Source: ACHHUZ50gXV+eE5xgYrgWjZ8e80AWAGvvsti7u1TH6tq+xgqNEMoKIyVmfXoBiewsusUpBzDBlXRWg==
X-Received: by 2002:a17:90a:7e02:b0:24e:102e:edbf with SMTP id
 i2-20020a17090a7e0200b0024e102eedbfmr11517997pjl.13.1684809981746; 
 Mon, 22 May 2023 19:46:21 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:46:21 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 44/48] igb: Notify only new interrupts
Date: Tue, 23 May 2023 11:43:35 +0900
Message-Id: <20230523024339.50875-45-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
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

This follows the corresponding change for e1000e. This fixes:
tests/avocado/netdev-ethtool.py:NetDevEthtool.test_igb

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/igb_core.c                             | 201 ++++++++----------
 hw/net/trace-events                           |  11 +-
 .../org.centos/stream/8/x86_64/test-avocado   |   1 +
 tests/avocado/netdev-ethtool.py               |   4 -
 4 files changed, 87 insertions(+), 130 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 49d1917926..823dde8f28 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -94,10 +94,7 @@ static ssize_t
 igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
                      bool has_vnet, bool *external_tx);
 
-static inline void
-igb_set_interrupt_cause(IGBCore *core, uint32_t val);
-
-static void igb_update_interrupt_state(IGBCore *core);
+static void igb_raise_interrupts(IGBCore *core, size_t index, uint32_t causes);
 static void igb_reset(IGBCore *core, bool sw);
 
 static inline void
@@ -913,8 +910,8 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
     }
 
     if (eic) {
-        core->mac[EICR] |= eic;
-        igb_set_interrupt_cause(core, E1000_ICR_TXDW);
+        igb_raise_interrupts(core, EICR, eic);
+        igb_raise_interrupts(core, ICR, E1000_ICR_TXDW);
     }
 
     net_tx_pkt_reset(txr->tx->tx_pkt, net_tx_pkt_unmap_frag_pci, d);
@@ -1686,6 +1683,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
 {
     uint16_t queues = 0;
     uint32_t causes = 0;
+    uint32_t ecauses = 0;
     union {
         L2Header l2_header;
         uint8_t octets[ETH_ZLEN];
@@ -1788,13 +1786,14 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
             causes |= E1000_ICS_RXDMT0;
         }
 
-        core->mac[EICR] |= igb_rx_wb_eic(core, rxr.i->idx);
+        ecauses |= igb_rx_wb_eic(core, rxr.i->idx);
 
         trace_e1000e_rx_written_to_guest(rxr.i->idx);
     }
 
     trace_e1000e_rx_interrupt_set(causes);
-    igb_set_interrupt_cause(core, causes);
+    igb_raise_interrupts(core, EICR, ecauses);
+    igb_raise_interrupts(core, ICR, causes);
 
     return orig_size;
 }
@@ -1854,7 +1853,7 @@ void igb_core_set_link_status(IGBCore *core)
     }
 
     if (core->mac[STATUS] != old_status) {
-        igb_set_interrupt_cause(core, E1000_ICR_LSC);
+        igb_raise_interrupts(core, ICR, E1000_ICR_LSC);
     }
 }
 
@@ -1934,13 +1933,6 @@ igb_set_rx_control(IGBCore *core, int index, uint32_t val)
     }
 }
 
-static inline void
-igb_clear_ims_bits(IGBCore *core, uint32_t bits)
-{
-    trace_e1000e_irq_clear_ims(bits, core->mac[IMS], core->mac[IMS] & ~bits);
-    core->mac[IMS] &= ~bits;
-}
-
 static inline bool
 igb_postpone_interrupt(IGBIntrDelayTimer *timer)
 {
@@ -1963,9 +1955,8 @@ igb_eitr_should_postpone(IGBCore *core, int idx)
     return igb_postpone_interrupt(&core->eitr[idx]);
 }
 
-static void igb_send_msix(IGBCore *core)
+static void igb_send_msix(IGBCore *core, uint32_t causes)
 {
-    uint32_t causes = core->mac[EICR] & core->mac[EIMS];
     int vector;
 
     for (vector = 0; vector < IGB_INTR_NUM; ++vector) {
@@ -1988,124 +1979,116 @@ igb_fix_icr_asserted(IGBCore *core)
     trace_e1000e_irq_fix_icr_asserted(core->mac[ICR]);
 }
 
-static void
-igb_update_interrupt_state(IGBCore *core)
+static void igb_raise_interrupts(IGBCore *core, size_t index, uint32_t causes)
 {
-    uint32_t icr;
-    uint32_t causes;
+    uint32_t old_causes = core->mac[ICR] & core->mac[IMS];
+    uint32_t old_ecauses = core->mac[EICR] & core->mac[EIMS];
+    uint32_t raised_causes;
+    uint32_t raised_ecauses;
     uint32_t int_alloc;
 
-    icr = core->mac[ICR] & core->mac[IMS];
+    trace_e1000e_irq_set(index << 2,
+                         core->mac[index], core->mac[index] | causes);
+
+    core->mac[index] |= causes;
 
     if (core->mac[GPIE] & E1000_GPIE_MSIX_MODE) {
-        if (icr) {
-            causes = 0;
-            if (icr & E1000_ICR_DRSTA) {
-                int_alloc = core->mac[IVAR_MISC] & 0xff;
-                if (int_alloc & E1000_IVAR_VALID) {
-                    causes |= BIT(int_alloc & 0x1f);
-                }
+        raised_causes = core->mac[ICR] & core->mac[IMS] & ~old_causes;
+
+        if (raised_causes & E1000_ICR_DRSTA) {
+            int_alloc = core->mac[IVAR_MISC] & 0xff;
+            if (int_alloc & E1000_IVAR_VALID) {
+                core->mac[EICR] |= BIT(int_alloc & 0x1f);
             }
-            /* Check if other bits (excluding the TCP Timer) are enabled. */
-            if (icr & ~E1000_ICR_DRSTA) {
-                int_alloc = (core->mac[IVAR_MISC] >> 8) & 0xff;
-                if (int_alloc & E1000_IVAR_VALID) {
-                    causes |= BIT(int_alloc & 0x1f);
-                }
-                trace_e1000e_irq_add_msi_other(core->mac[EICR]);
+        }
+        /* Check if other bits (excluding the TCP Timer) are enabled. */
+        if (raised_causes & ~E1000_ICR_DRSTA) {
+            int_alloc = (core->mac[IVAR_MISC] >> 8) & 0xff;
+            if (int_alloc & E1000_IVAR_VALID) {
+                core->mac[EICR] |= BIT(int_alloc & 0x1f);
             }
-            core->mac[EICR] |= causes;
         }
 
-        if ((core->mac[EICR] & core->mac[EIMS])) {
-            igb_send_msix(core);
+        raised_ecauses = core->mac[EICR] & core->mac[EIMS] & ~old_ecauses;
+        if (!raised_ecauses) {
+            return;
         }
+
+        igb_send_msix(core, raised_ecauses);
     } else {
         igb_fix_icr_asserted(core);
 
-        if (icr) {
-            core->mac[EICR] |= (icr & E1000_ICR_DRSTA) | E1000_EICR_OTHER;
-        } else {
-            core->mac[EICR] &= ~E1000_EICR_OTHER;
+        raised_causes = core->mac[ICR] & core->mac[IMS] & ~old_causes;
+        if (!raised_causes) {
+            return;
         }
 
-        trace_e1000e_irq_pending_interrupts(core->mac[ICR] & core->mac[IMS],
-                                            core->mac[ICR], core->mac[IMS]);
+        core->mac[EICR] |= (raised_causes & E1000_ICR_DRSTA) | E1000_EICR_OTHER;
 
         if (msix_enabled(core->owner)) {
-            if (icr) {
-                trace_e1000e_irq_msix_notify_vec(0);
-                msix_notify(core->owner, 0);
-            }
+            trace_e1000e_irq_msix_notify_vec(0);
+            msix_notify(core->owner, 0);
         } else if (msi_enabled(core->owner)) {
-            if (icr) {
-                msi_notify(core->owner, 0);
-            }
+            trace_e1000e_irq_msi_notify(raised_causes);
+            msi_notify(core->owner, 0);
         } else {
-            if (icr) {
-                igb_raise_legacy_irq(core);
-            } else {
-                igb_lower_legacy_irq(core);
-            }
+            igb_raise_legacy_irq(core);
         }
     }
 }
 
-static void
-igb_set_interrupt_cause(IGBCore *core, uint32_t val)
+static void igb_lower_interrupts(IGBCore *core, size_t index, uint32_t causes)
 {
-    trace_e1000e_irq_set_cause_entry(val, core->mac[ICR]);
+    trace_e1000e_irq_clear(index << 2,
+                           core->mac[index], core->mac[index] & ~causes);
+
+    core->mac[index] &= ~causes;
 
-    core->mac[ICR] |= val;
+    trace_e1000e_irq_pending_interrupts(core->mac[ICR] & core->mac[IMS],
+                                        core->mac[ICR], core->mac[IMS]);
 
-    trace_e1000e_irq_set_cause_exit(val, core->mac[ICR]);
+    if (!(core->mac[ICR] & core->mac[IMS]) &&
+        !(core->mac[GPIE] & E1000_GPIE_MSIX_MODE)) {
+        core->mac[EICR] &= ~E1000_EICR_OTHER;
 
-    igb_update_interrupt_state(core);
+        if (!msix_enabled(core->owner) && !msi_enabled(core->owner)) {
+            igb_lower_legacy_irq(core);
+        }
+    }
 }
 
 static void igb_set_eics(IGBCore *core, int index, uint32_t val)
 {
     bool msix = !!(core->mac[GPIE] & E1000_GPIE_MSIX_MODE);
+    uint32_t mask = msix ? E1000_EICR_MSIX_MASK : E1000_EICR_LEGACY_MASK;
 
     trace_igb_irq_write_eics(val, msix);
-
-    core->mac[EICS] |=
-        val & (msix ? E1000_EICR_MSIX_MASK : E1000_EICR_LEGACY_MASK);
-
-    /*
-     * TODO: Move to igb_update_interrupt_state if EICS is modified in other
-     * places.
-     */
-    core->mac[EICR] = core->mac[EICS];
-
-    igb_update_interrupt_state(core);
+    igb_raise_interrupts(core, EICR, val & mask);
 }
 
 static void igb_set_eims(IGBCore *core, int index, uint32_t val)
 {
     bool msix = !!(core->mac[GPIE] & E1000_GPIE_MSIX_MODE);
+    uint32_t mask = msix ? E1000_EICR_MSIX_MASK : E1000_EICR_LEGACY_MASK;
 
     trace_igb_irq_write_eims(val, msix);
-
-    core->mac[EIMS] |=
-        val & (msix ? E1000_EICR_MSIX_MASK : E1000_EICR_LEGACY_MASK);
-
-    igb_update_interrupt_state(core);
+    igb_raise_interrupts(core, EIMS, val & mask);
 }
 
 static void mailbox_interrupt_to_vf(IGBCore *core, uint16_t vfn)
 {
     uint32_t ent = core->mac[VTIVAR_MISC + vfn];
+    uint32_t causes;
 
     if ((ent & E1000_IVAR_VALID)) {
-        core->mac[EICR] |= (ent & 0x3) << (22 - vfn * IGBVF_MSIX_VEC_NUM);
-        igb_update_interrupt_state(core);
+        causes = (ent & 0x3) << (22 - vfn * IGBVF_MSIX_VEC_NUM);
+        igb_raise_interrupts(core, EICR, causes);
     }
 }
 
 static void mailbox_interrupt_to_pf(IGBCore *core)
 {
-    igb_set_interrupt_cause(core, E1000_ICR_VMMB);
+    igb_raise_interrupts(core, ICR, E1000_ICR_VMMB);
 }
 
 static void igb_set_pfmailbox(IGBCore *core, int index, uint32_t val)
@@ -2196,13 +2179,12 @@ static void igb_w1c(IGBCore *core, int index, uint32_t val)
 static void igb_set_eimc(IGBCore *core, int index, uint32_t val)
 {
     bool msix = !!(core->mac[GPIE] & E1000_GPIE_MSIX_MODE);
+    uint32_t mask = msix ? E1000_EICR_MSIX_MASK : E1000_EICR_LEGACY_MASK;
 
-    /* Interrupts are disabled via a write to EIMC and reflected in EIMS. */
-    core->mac[EIMS] &=
-        ~(val & (msix ? E1000_EICR_MSIX_MASK : E1000_EICR_LEGACY_MASK));
+    trace_igb_irq_write_eimc(val, msix);
 
-    trace_igb_irq_write_eimc(val, core->mac[EIMS], msix);
-    igb_update_interrupt_state(core);
+    /* Interrupts are disabled via a write to EIMC and reflected in EIMS. */
+    igb_lower_interrupts(core, EIMS, val & mask);
 }
 
 static void igb_set_eiac(IGBCore *core, int index, uint32_t val)
@@ -2242,11 +2224,10 @@ static void igb_set_eicr(IGBCore *core, int index, uint32_t val)
      * TODO: In IOV mode, only bit zero of this vector is available for the PF
      * function.
      */
-    core->mac[EICR] &=
-        ~(val & (msix ? E1000_EICR_MSIX_MASK : E1000_EICR_LEGACY_MASK));
+    uint32_t mask = msix ? E1000_EICR_MSIX_MASK : E1000_EICR_LEGACY_MASK;
 
     trace_igb_irq_write_eicr(val, msix);
-    igb_update_interrupt_state(core);
+    igb_lower_interrupts(core, EICR, val & mask);
 }
 
 static void igb_set_vtctrl(IGBCore *core, int index, uint32_t val)
@@ -2346,7 +2327,7 @@ igb_autoneg_timer(void *opaque)
 
         igb_update_flowctl_status(core);
         /* signal link status change to the guest */
-        igb_set_interrupt_cause(core, E1000_ICR_LSC);
+        igb_raise_interrupts(core, ICR, E1000_ICR_LSC);
     }
 }
 
@@ -2419,7 +2400,7 @@ igb_set_mdic(IGBCore *core, int index, uint32_t val)
     core->mac[MDIC] = val | E1000_MDIC_READY;
 
     if (val & E1000_MDIC_INT_EN) {
-        igb_set_interrupt_cause(core, E1000_ICR_MDAC);
+        igb_raise_interrupts(core, ICR, E1000_ICR_MDAC);
     }
 }
 
@@ -2527,28 +2508,23 @@ static void
 igb_set_ics(IGBCore *core, int index, uint32_t val)
 {
     trace_e1000e_irq_write_ics(val);
-    igb_set_interrupt_cause(core, val);
+    igb_raise_interrupts(core, ICR, val);
 }
 
 static void
 igb_set_imc(IGBCore *core, int index, uint32_t val)
 {
     trace_e1000e_irq_ims_clear_set_imc(val);
-    igb_clear_ims_bits(core, val);
-    igb_update_interrupt_state(core);
+    igb_lower_interrupts(core, IMS, val);
 }
 
 static void
 igb_set_ims(IGBCore *core, int index, uint32_t val)
 {
-    uint32_t valid_val = val & 0x77D4FBFD;
-
-    trace_e1000e_irq_set_ims(val, core->mac[IMS], core->mac[IMS] | valid_val);
-    core->mac[IMS] |= valid_val;
-    igb_update_interrupt_state(core);
+    igb_raise_interrupts(core, IMS, val & 0x77D4FBFD);
 }
 
-static void igb_commit_icr(IGBCore *core)
+static void igb_nsicr(IGBCore *core)
 {
     /*
      * If GPIE.NSICR = 0, then the clear of IMS will occur only if at
@@ -2557,19 +2533,14 @@ static void igb_commit_icr(IGBCore *core)
      */
     if ((core->mac[GPIE] & E1000_GPIE_NSICR) ||
         (core->mac[IMS] && (core->mac[ICR] & E1000_ICR_INT_ASSERTED))) {
-        igb_clear_ims_bits(core, core->mac[IAM]);
+        igb_lower_interrupts(core, IMS, core->mac[IAM]);
     }
-
-    igb_update_interrupt_state(core);
 }
 
 static void igb_set_icr(IGBCore *core, int index, uint32_t val)
 {
-    uint32_t icr = core->mac[ICR] & ~val;
-
-    trace_igb_irq_icr_write(val, core->mac[ICR], icr);
-    core->mac[ICR] = icr;
-    igb_commit_icr(core);
+    igb_nsicr(core);
+    igb_lower_interrupts(core, ICR, val);
 }
 
 static uint32_t
@@ -2620,21 +2591,19 @@ static uint32_t
 igb_mac_icr_read(IGBCore *core, int index)
 {
     uint32_t ret = core->mac[ICR];
-    trace_e1000e_irq_icr_read_entry(ret);
 
     if (core->mac[GPIE] & E1000_GPIE_NSICR) {
         trace_igb_irq_icr_clear_gpie_nsicr();
-        core->mac[ICR] = 0;
+        igb_lower_interrupts(core, ICR, 0xffffffff);
     } else if (core->mac[IMS] == 0) {
         trace_e1000e_irq_icr_clear_zero_ims();
-        core->mac[ICR] = 0;
+        igb_lower_interrupts(core, ICR, 0xffffffff);
     } else if (!msix_enabled(core->owner)) {
         trace_e1000e_irq_icr_clear_nonmsix_icr_read();
-        core->mac[ICR] = 0;
+        igb_lower_interrupts(core, ICR, 0xffffffff);
     }
 
-    trace_e1000e_irq_icr_read_exit(core->mac[ICR]);
-    igb_commit_icr(core);
+    igb_nsicr(core);
     return ret;
 }
 
diff --git a/hw/net/trace-events b/hw/net/trace-events
index d171dc8179..e4a98b2c7d 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -207,21 +207,14 @@ e1000e_irq_msix_notify_vec(uint32_t vector) "MSI-X notify vector 0x%x"
 e1000e_irq_postponed_by_xitr(uint32_t reg) "Interrupt postponed by [E]ITR register 0x%x"
 e1000e_irq_clear(uint32_t offset, uint32_t old, uint32_t new) "Clearing interrupt register 0x%x: 0x%x --> 0x%x"
 e1000e_irq_set(uint32_t offset, uint32_t old, uint32_t new) "Setting interrupt register 0x%x: 0x%x --> 0x%x"
-e1000e_irq_clear_ims(uint32_t bits, uint32_t old_ims, uint32_t new_ims) "Clearing IMS bits 0x%x: 0x%x --> 0x%x"
-e1000e_irq_set_ims(uint32_t bits, uint32_t old_ims, uint32_t new_ims) "Setting IMS bits 0x%x: 0x%x --> 0x%x"
 e1000e_irq_fix_icr_asserted(uint32_t new_val) "ICR_ASSERTED bit fixed: 0x%x"
 e1000e_irq_add_msi_other(uint32_t new_val) "ICR_OTHER bit added: 0x%x"
 e1000e_irq_pending_interrupts(uint32_t pending, uint32_t icr, uint32_t ims) "ICR PENDING: 0x%x (ICR: 0x%x, IMS: 0x%x)"
-e1000e_irq_set_cause_entry(uint32_t val, uint32_t icr) "Going to set IRQ cause 0x%x, ICR: 0x%x"
-e1000e_irq_set_cause_exit(uint32_t val, uint32_t icr) "Set IRQ cause 0x%x, ICR: 0x%x"
-e1000e_irq_icr_write(uint32_t bits, uint32_t old_icr, uint32_t new_icr) "Clearing ICR bits 0x%x: 0x%x --> 0x%x"
 e1000e_irq_write_ics(uint32_t val) "Adding ICR bits 0x%x"
 e1000e_irq_icr_process_iame(void) "Clearing IMS bits due to IAME"
 e1000e_irq_read_ics(uint32_t ics) "Current ICS: 0x%x"
 e1000e_irq_read_ims(uint32_t ims) "Current IMS: 0x%x"
 e1000e_irq_icr_clear_nonmsix_icr_read(void) "Clearing ICR on read due to non MSI-X int"
-e1000e_irq_icr_read_entry(uint32_t icr) "Starting ICR read. Current ICR: 0x%x"
-e1000e_irq_icr_read_exit(uint32_t icr) "Ending ICR read. Current ICR: 0x%x"
 e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due to zero IMS"
 e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to IAME"
 e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IMS due to EIAME, IAM: 0x%X, cause: 0x%X"
@@ -237,7 +230,6 @@ e1000e_irq_tidv_fpd_not_running(void) "FPD written while TIDV was not running"
 e1000e_irq_eitr_set(uint32_t eitr_num, uint32_t val) "EITR[%u] = %u"
 e1000e_irq_itr_set(uint32_t val) "ITR = %u"
 e1000e_irq_fire_all_timers(uint32_t val) "Firing all delay/throttling timers on all interrupts enable (0x%X written to IMS)"
-e1000e_irq_adding_delayed_causes(uint32_t val, uint32_t icr) "Merging delayed causes 0x%X to ICR 0x%X"
 e1000e_irq_msix_pending_clearing(uint32_t cause, uint32_t int_cfg, uint32_t vec) "Clearing MSI-X pending bit for cause 0x%x, IVAR config 0x%x, vector %u"
 
 e1000e_wrn_msix_vec_wrong(uint32_t cause, uint32_t cfg) "Invalid configuration for cause 0x%x: 0x%x"
@@ -290,12 +282,11 @@ igb_rx_desc_buff_write(uint64_t addr, uint16_t offset, const void* source, uint3
 igb_rx_metadata_rss(uint32_t rss) "RSS data: 0x%X"
 
 igb_irq_icr_clear_gpie_nsicr(void) "Clearing ICR on read due to GPIE.NSICR enabled"
-igb_irq_icr_write(uint32_t bits, uint32_t old_icr, uint32_t new_icr) "Clearing ICR bits 0x%x: 0x%x --> 0x%x"
 igb_irq_set_iam(uint32_t icr) "Update IAM: 0x%x"
 igb_irq_read_iam(uint32_t icr) "Current IAM: 0x%x"
 igb_irq_write_eics(uint32_t val, bool msix) "Update EICS: 0x%x MSI-X: %d"
 igb_irq_write_eims(uint32_t val, bool msix) "Update EIMS: 0x%x MSI-X: %d"
-igb_irq_write_eimc(uint32_t val, uint32_t eims, bool msix) "Update EIMC: 0x%x EIMS: 0x%x MSI-X: %d"
+igb_irq_write_eimc(uint32_t val, bool msix) "Update EIMC: 0x%x MSI-X: %d"
 igb_irq_write_eiac(uint32_t val) "Update EIAC: 0x%x"
 igb_irq_write_eiam(uint32_t val, bool msix) "Update EIAM: 0x%x MSI-X: %d"
 igb_irq_write_eicr(uint32_t val, bool msix) "Update EICR: 0x%x MSI-X: %d"
diff --git a/scripts/ci/org.centos/stream/8/x86_64/test-avocado b/scripts/ci/org.centos/stream/8/x86_64/test-avocado
index a1aa601ee3..e0443fc8ae 100755
--- a/scripts/ci/org.centos/stream/8/x86_64/test-avocado
+++ b/scripts/ci/org.centos/stream/8/x86_64/test-avocado
@@ -30,6 +30,7 @@ make get-vm-images
     tests/avocado/cpu_queries.py:QueryCPUModelExpansion.test \
     tests/avocado/empty_cpu_model.py:EmptyCPUModel.test \
     tests/avocado/hotplug_cpu.py:HotPlugCPU.test \
+    tests/avocado/netdev-ethtool.py:NetDevEthtool.test_igb \
     tests/avocado/netdev-ethtool.py:NetDevEthtool.test_igb_nomsi \
     tests/avocado/info_usernet.py:InfoUsernet.test_hostfwd \
     tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu \
diff --git a/tests/avocado/netdev-ethtool.py b/tests/avocado/netdev-ethtool.py
index 6da800f62b..5f33288f81 100644
--- a/tests/avocado/netdev-ethtool.py
+++ b/tests/avocado/netdev-ethtool.py
@@ -67,10 +67,6 @@ def common_test_code(self, netdev, extra_args=None):
         # no need to gracefully shutdown, just finish
         self.vm.kill()
 
-    # Skip testing for MSI for now. Allegedly it was fixed by:
-    #   28e96556ba (igb: Allocate MSI-X vector when testing)
-    # but I'm seeing oops in the kernel
-    @skip("Kernel bug with MSI enabled")
     def test_igb(self):
         """
         :avocado: tags=device:igb
-- 
2.40.1


