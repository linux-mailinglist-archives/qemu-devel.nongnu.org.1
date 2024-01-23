Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AC5838D70
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:31:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSEzF-0006Wc-6n; Tue, 23 Jan 2024 06:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1rSEz5-0006VJ-5p
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:30:28 -0500
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1rSEz0-0007md-SS
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:30:26 -0500
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MAchM-1rHDLr45we-00B5Ae; Tue, 23 Jan 2024 12:25:04 +0100
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 1/2] igb: fix link state on resume
Date: Tue, 23 Jan 2024 12:25:00 +0100
Message-ID: <20240123112501.305681-1-lvivier@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3Kr0xbtmiUTjr4+OGuTOfK/qwBY5xe8KQVE30+hM1b/zukFemU/
 Pz+yP4e1ORhrjb2Lf3vkvlwWpZgLsmJN/fJrfwSKy9XJV5aLkdq77J6WNC+47ivLkz4KRS4
 R0FvGBUJGGJJIRyqAKd/K9P/cEPB5sdB6O+ugq2aIEvF35eTE42PbCdj3ZlurEceSYKS9Uz
 A9b3dQLlGFyeyZt0e5sKw==
UI-OutboundReport: notjunk:1;M01:P0:0A74SfUlOUg=;DYF7sPK3rBENRQnCwbkNJILGoxi
 eQEXBznY9ZcCayVNaT7hZQEMSo0lB33UOte2LRpZttZW0aDj4tkUwsTqBdYSIVhmoZjCHt9P/
 TAFatbLELFgADvQrz9JWeUqRpsq4ULjM0VWSkkTbt0e9+Z6wfU9gNOqAS2nE/R7nruymU0qlm
 WhGd3n8k0tK7jmjVwU435KBR6rnzUSV2WLUsNXwPDmHjdcTm/EuoKFthc+GL21C0bv0AoJDN+
 l3BVxkXb+lPiKH3ZK+du4cYnR2V4Y8UTLBPw+EtJj28vnOz0LNgSQtvcabndWpPH49hsl0oPT
 dzgjd4fdKNr2Kp9xg2CFNiZ1ToWefqMbV3yTNTDhXuf+w6PgIxjY0RvARm7ndEnNr9u08qW3N
 vaQKjfWW5Twvnvze6HgilziulaDzmA18NMsTfl+lvwtlwF2Z/bIYK6TvEmNRRO6j53LmYuIPq
 kZ7HTN06kB+fv8ZwxP6fX4xehFwMNAGK+wMljKzWZc6Ufd2g0T9OF/NUsKemBTQ8OSabkjl5D
 WY/1h1mqEqRnDAkh0tORv2RZkP8PWUDBNIeUzp/wl4+C2GLdc2VGlYAtQ2Eq1YkuR1o8W8LfG
 vo3KRiF9SnuF/xrKZ6XgAxG7Wz+NSIeg0cxO29h3i7C4rTJv1IFoN6q0QUxsamdAsQay9px2J
 BeepcCH3R5FerEw7jEvnvd34kswioW4JCMPx3YmTHy6aZmqpFKZj/GHy9yGbvgVhp8lZ4JJtO
 U2taSdSti7PC3jhQcvMKJMFQfxKw0dR8fCMboOxEri6g4Jt9i7BmgJyn1hyFnSv9eszip/W3A
 eAyVARREUQ3S2bFU8mS5u1GP+0TenLTAR6ILazDC0B9Cx9uaQFU81pnZkGr7axzGoY59Mifi4
 rYoItb2hAIYDtYw==
Received-SPF: permerror client-ip=212.227.126.134;
 envelope-from=lvivier@redhat.com; helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_FAIL=0.001,
 SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On resume igb_vm_state_change() always calls igb_autoneg_resume()
that sets link_down to false, and thus activates the link even
if we have disabled it.

The problem can be reproduced starting qemu in paused state (-S) and
then set the link to down. When we resume the machine the link appears
to be up.

Reproducer:

   # qemu-system-x86_64 ... -device igb,netdev=netdev0,id=net0 -S

   {"execute": "qmp_capabilities" }
   {"execute": "set_link", "arguments": {"name": "net0", "up": false}}
   {"execute": "cont" }

To fix the problem, merge the content of igb_vm_state_change()
into igb_core_post_load() as e1000 does.

Buglink: https://issues.redhat.com/browse/RHEL-21867
Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/igb_core.c | 47 +++--------------------------------------------
 hw/net/igb_core.h |  2 --
 2 files changed, 3 insertions(+), 46 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 2a7a11aa9ed5..31ab959ab8ff 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -160,14 +160,6 @@ igb_intmgr_timer_resume(IGBIntrDelayTimer *timer)
     }
 }
 
-static void
-igb_intmgr_timer_pause(IGBIntrDelayTimer *timer)
-{
-    if (timer->running) {
-        timer_del(timer->timer);
-    }
-}
-
 static void
 igb_intrmgr_on_msix_throttling_timer(void *opaque)
 {
@@ -212,16 +204,6 @@ igb_intrmgr_resume(IGBCore *core)
     }
 }
 
-static void
-igb_intrmgr_pause(IGBCore *core)
-{
-    int i;
-
-    for (i = 0; i < IGB_INTR_NUM; i++) {
-        igb_intmgr_timer_pause(&core->eitr[i]);
-    }
-}
-
 static void
 igb_intrmgr_reset(IGBCore *core)
 {
@@ -4290,12 +4272,6 @@ igb_core_read(IGBCore *core, hwaddr addr, unsigned size)
     return 0;
 }
 
-static inline void
-igb_autoneg_pause(IGBCore *core)
-{
-    timer_del(core->autoneg_timer);
-}
-
 static void
 igb_autoneg_resume(IGBCore *core)
 {
@@ -4307,22 +4283,6 @@ igb_autoneg_resume(IGBCore *core)
     }
 }
 
-static void
-igb_vm_state_change(void *opaque, bool running, RunState state)
-{
-    IGBCore *core = opaque;
-
-    if (running) {
-        trace_e1000e_vm_state_running();
-        igb_intrmgr_resume(core);
-        igb_autoneg_resume(core);
-    } else {
-        trace_e1000e_vm_state_stopped();
-        igb_autoneg_pause(core);
-        igb_intrmgr_pause(core);
-    }
-}
-
 void
 igb_core_pci_realize(IGBCore        *core,
                      const uint16_t *eeprom_templ,
@@ -4335,8 +4295,6 @@ igb_core_pci_realize(IGBCore        *core,
                                        igb_autoneg_timer, core);
     igb_intrmgr_pci_realize(core);
 
-    core->vmstate = qemu_add_vm_change_state_handler(igb_vm_state_change, core);
-
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
         net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
     }
@@ -4360,8 +4318,6 @@ igb_core_pci_uninit(IGBCore *core)
 
     igb_intrmgr_pci_unint(core);
 
-    qemu_del_vm_change_state_handler(core->vmstate);
-
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
     }
@@ -4586,5 +4542,8 @@ igb_core_post_load(IGBCore *core)
      */
     nc->link_down = (core->mac[STATUS] & E1000_STATUS_LU) == 0;
 
+    igb_intrmgr_resume(core);
+    igb_autoneg_resume(core);
+
     return 0;
 }
diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index bf8c46f26b51..d70b54e318f1 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -90,8 +90,6 @@ struct IGBCore {
 
     IGBIntrDelayTimer eitr[IGB_INTR_NUM];
 
-    VMChangeStateEntry *vmstate;
-
     uint32_t eitr_guest_value[IGB_INTR_NUM];
 
     uint8_t permanent_mac[ETH_ALEN];
-- 
2.43.0


