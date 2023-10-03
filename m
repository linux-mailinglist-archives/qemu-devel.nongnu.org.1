Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD97F7B6427
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:31:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnao8-00020V-CY; Tue, 03 Oct 2023 04:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnao6-0001uy-1g
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnao4-0000I1-8p
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4t8E12TymlIMhdbdE+oLswhb61Lq4W9BqxeOsmnEps=;
 b=OCwBq4nxqsBNtgB21lS518CzBSUNBfaOhDOFgcjuOoZOzcLqT1I5p9EmGFhjUqh7QKYD15
 tDYRgrLWC943wgPxdG4oAKeVH5cZFkinqQRIMJ4T5Uc3dL32L3EWYAwMq5g08Ani92UKBv
 DczgQv9eZjZPqBNS47QYHqDmvCXSGkA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-ss0a7uF_PgqVI37oOLD2fQ-1; Tue, 03 Oct 2023 04:30:52 -0400
X-MC-Unique: ss0a7uF_PgqVI37oOLD2fQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9a1cf3e6c04so49235166b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321850; x=1696926650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x4t8E12TymlIMhdbdE+oLswhb61Lq4W9BqxeOsmnEps=;
 b=vXDR6691OCTEzbLIskQWAPR7TTT3YZAzt3UdZJP1RA0/JFq8WlIaXn5DtTuEr+inZZ
 un7Qsxlo0Le6JYI2Br5mPG4Jqs/oG/SGDkAm9V2ORh409L+cPU8p68V/lf8nvE8mgWGX
 XA65dFP2puQdl+g/TekeGFRr6gCKP71f44RBpFOdE2sG/WXWpqdvS+SNPdZCJ9eK79Nt
 jzAHgBi9SNc/3ifacDzZjBZN/cgebwSnBGCADB9yj2sxAL8m8CkLZnD/rN+xrWotK8mZ
 xpAgBGt5AhDBUQLjZSCfa9zKvu+FYxA35O0FVT2Huxx6m05US9ajkI5pNaFEaN4AVZDj
 +OBQ==
X-Gm-Message-State: AOJu0YxJ13JSPHQs9FQLgnxMDA5WQ+YYqHtYITcGxEj220cuPgoiKcBP
 nQIO81HhXn7xhIdcHmXJziYlUpSMiQzXiCItV+uJyF5NyodwBcJ4vRr+g5xN7gGxbyZm6HMfLnd
 DzrN9ClRymzoptsKpRsHrAxFilA5A0kePX1pdbcPAt3nhgDyRD7sxEzzV6NE5VPNbIQnc/t6dO5
 8=
X-Received: by 2002:a17:906:53d6:b0:9ae:7611:99be with SMTP id
 p22-20020a17090653d600b009ae761199bemr13244768ejo.66.1696321850423; 
 Tue, 03 Oct 2023 01:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJQaFcALZZWdj2BsO68rUpm5me8NaoSG7ShISYbsjJS6ErnqS/qCP5eSPIC/rErzAXdRjwoQ==
X-Received: by 2002:a17:906:53d6:b0:9ae:7611:99be with SMTP id
 p22-20020a17090653d600b009ae761199bemr13244740ejo.66.1696321849983; 
 Tue, 03 Oct 2023 01:30:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 kb15-20020a1709070f8f00b00997c1d125fasm655612ejc.170.2023.10.03.01.30.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:30:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/24] e1000: remove old compatibility code
Date: Tue,  3 Oct 2023 10:30:20 +0200
Message-ID: <20231003083042.110065-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This code is not needed anymore in the supported machine types.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/e1000.c | 79 +++++++++++++++++---------------------------------
 1 file changed, 27 insertions(+), 52 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 093c2d45315..548bcabcbba 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -127,13 +127,9 @@ struct E1000State_st {
     QEMUTimer *flush_queue_timer;
 
 /* Compatibility flags for migration to/from qemu 1.3.0 and older */
-#define E1000_FLAG_AUTONEG_BIT 0
-#define E1000_FLAG_MIT_BIT 1
 #define E1000_FLAG_MAC_BIT 2
 #define E1000_FLAG_TSO_BIT 3
 #define E1000_FLAG_VET_BIT 4
-#define E1000_FLAG_AUTONEG (1 << E1000_FLAG_AUTONEG_BIT)
-#define E1000_FLAG_MIT (1 << E1000_FLAG_MIT_BIT)
 #define E1000_FLAG_MAC (1 << E1000_FLAG_MAC_BIT)
 #define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
 #define E1000_FLAG_VET (1 << E1000_FLAG_VET_BIT)
@@ -180,7 +176,7 @@ e1000_autoneg_done(E1000State *s)
 static bool
 have_autoneg(E1000State *s)
 {
-    return chkflag(AUTONEG) && (s->phy_reg[MII_BMCR] & MII_BMCR_AUTOEN);
+    return (s->phy_reg[MII_BMCR] & MII_BMCR_AUTOEN);
 }
 
 static void
@@ -308,35 +304,34 @@ set_interrupt_cause(E1000State *s, int index, uint32_t val)
         if (s->mit_timer_on) {
             return;
         }
-        if (chkflag(MIT)) {
-            /* Compute the next mitigation delay according to pending
-             * interrupts and the current values of RADV (provided
-             * RDTR!=0), TADV and ITR.
-             * Then rearm the timer.
-             */
-            mit_delay = 0;
-            if (s->mit_ide &&
-                    (pending_ints & (E1000_ICR_TXQE | E1000_ICR_TXDW))) {
-                mit_update_delay(&mit_delay, s->mac_reg[TADV] * 4);
-            }
-            if (s->mac_reg[RDTR] && (pending_ints & E1000_ICS_RXT0)) {
-                mit_update_delay(&mit_delay, s->mac_reg[RADV] * 4);
-            }
-            mit_update_delay(&mit_delay, s->mac_reg[ITR]);
 
-            /*
-             * According to e1000 SPEC, the Ethernet controller guarantees
-             * a maximum observable interrupt rate of 7813 interrupts/sec.
-             * Thus if mit_delay < 500 then the delay should be set to the
-             * minimum delay possible which is 500.
-             */
-            mit_delay = (mit_delay < 500) ? 500 : mit_delay;
-
-            s->mit_timer_on = 1;
-            timer_mod(s->mit_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                      mit_delay * 256);
-            s->mit_ide = 0;
+        /* Compute the next mitigation delay according to pending
+         * interrupts and the current values of RADV (provided
+         * RDTR!=0), TADV and ITR.
+         * Then rearm the timer.
+         */
+        mit_delay = 0;
+        if (s->mit_ide &&
+                (pending_ints & (E1000_ICR_TXQE | E1000_ICR_TXDW))) {
+            mit_update_delay(&mit_delay, s->mac_reg[TADV] * 4);
         }
+        if (s->mac_reg[RDTR] && (pending_ints & E1000_ICS_RXT0)) {
+            mit_update_delay(&mit_delay, s->mac_reg[RADV] * 4);
+        }
+        mit_update_delay(&mit_delay, s->mac_reg[ITR]);
+
+        /*
+         * According to e1000 SPEC, the Ethernet controller guarantees
+         * a maximum observable interrupt rate of 7813 interrupts/sec.
+         * Thus if mit_delay < 500 then the delay should be set to the
+         * minimum delay possible which is 500.
+         */
+        mit_delay = (mit_delay < 500) ? 500 : mit_delay;
+
+        s->mit_timer_on = 1;
+        timer_mod(s->mit_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                  mit_delay * 256);
+        s->mit_ide = 0;
     }
 
     s->mit_irq_level = (pending_ints != 0);
@@ -1223,9 +1218,6 @@ enum { MAC_ACCESS_PARTIAL = 1, MAC_ACCESS_FLAG_NEEDED = 2 };
  * n - flag needed
  * p - partially implenented */
 static const uint8_t mac_reg_access[0x8000] = {
-    [RDTR]    = markflag(MIT),    [TADV]    = markflag(MIT),
-    [RADV]    = markflag(MIT),    [ITR]     = markflag(MIT),
-
     [IPAV]    = markflag(MAC),    [WUC]     = markflag(MAC),
     [IP6AT]   = markflag(MAC),    [IP4AT]   = markflag(MAC),
     [FFVT]    = markflag(MAC),    [WUPM]    = markflag(MAC),
@@ -1394,11 +1386,6 @@ static int e1000_post_load(void *opaque, int version_id)
     E1000State *s = opaque;
     NetClientState *nc = qemu_get_queue(s->nic);
 
-    if (!chkflag(MIT)) {
-        s->mac_reg[ITR] = s->mac_reg[RDTR] = s->mac_reg[RADV] =
-            s->mac_reg[TADV] = 0;
-        s->mit_irq_level = false;
-    }
     s->mit_ide = 0;
     s->mit_timer_on = true;
     timer_mod(s->mit_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1);
@@ -1432,13 +1419,6 @@ static int e1000_tx_tso_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static bool e1000_mit_state_needed(void *opaque)
-{
-    E1000State *s = opaque;
-
-    return chkflag(MIT);
-}
-
 static bool e1000_full_mac_needed(void *opaque)
 {
     E1000State *s = opaque;
@@ -1457,7 +1437,6 @@ static const VMStateDescription vmstate_e1000_mit_state = {
     .name = "e1000/mit_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = e1000_mit_state_needed,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(mac_reg[RDTR], E1000State),
         VMSTATE_UINT32(mac_reg[RADV], E1000State),
@@ -1699,10 +1678,6 @@ static void pci_e1000_realize(PCIDevice *pci_dev, Error **errp)
 
 static Property e1000_properties[] = {
     DEFINE_NIC_PROPERTIES(E1000State, conf),
-    DEFINE_PROP_BIT("autonegotiation", E1000State,
-                    compat_flags, E1000_FLAG_AUTONEG_BIT, true),
-    DEFINE_PROP_BIT("mitigation", E1000State,
-                    compat_flags, E1000_FLAG_MIT_BIT, true),
     DEFINE_PROP_BIT("extra_mac_registers", E1000State,
                     compat_flags, E1000_FLAG_MAC_BIT, true),
     DEFINE_PROP_BIT("migrate_tso_props", E1000State,
-- 
2.41.0


