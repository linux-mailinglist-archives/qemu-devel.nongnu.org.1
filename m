Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D600A838D6F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:31:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSEzF-0006XF-RW; Tue, 23 Jan 2024 06:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1rSEz5-0006VK-FT
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:30:28 -0500
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1rSEz0-0007mb-Qp
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:30:27 -0500
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N9L64-1r53mm2ikm-015Fgy; Tue, 23 Jan 2024 12:25:04 +0100
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 2/2] e1000e: fix link state on resume
Date: Tue, 23 Jan 2024 12:25:01 +0100
Message-ID: <20240123112501.305681-2-lvivier@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123112501.305681-1-lvivier@redhat.com>
References: <20240123112501.305681-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CBm09x7yLOvR07L/zHYkVcOUg3/MHvjg1vQfqykGJ80DqOjsuS7
 UIx6eYUZotqaqMmzkPq+V7UFwuCQX7vSJQMjw4eBOMig0PjHfUTPwblSdHsma1MdWOys114
 9KcZKnppK1tBuoUjDSWPxnBIVwHb5Vg8bLGYmdCvjavKwWrmhbY9cqAX1FizQASHTCASQ3u
 1RFBshkWNvRZnaby44FpA==
UI-OutboundReport: notjunk:1;M01:P0:9TCk6udNkOk=;fA/tUQ5+i+gJAJiVryC/1pip9fx
 0xL71FBVRpcNBxIoizi69yAcP/UFTYQRRkAfeViBTeML+TDj3csC7K5ekavbwVar+AjNr0beb
 zQPUE5ZKoB0HDqwsVblVOx1pNxZGse8sUSFdWN71vNa5jHwlISn7J+AFxbY1Zm3DP6NCac/li
 hVe69fUrAPx3LQMWdNj8lCTeFBrWEQScJcqcVlTN4aW9qysnN37VF3f9O518+tsGS8Nq3QBDE
 JjNVsIVaIFcR1278+yQpW35dAMfRlWfx6uwYKyajcGEsciT3xb2ca4rdwOdxJ2D7o5kjLQW4S
 iajs6BSFbK2XqPvup7AFZ6iTXozJX/3heS1YcODxLYLebYM6y75q2KjpVeUGNb9VpmQt0EcQ5
 HwlmI3MRo2KQflE/aMZyyFE+HB2NXW87MrRi28IjC6aflwsYbSIFsOwmPU/n3enoAaZFaHzv6
 zpzGYgh6N0Xl3mafQBEHnD+ibzlusjzZ0k8stSS9JSbSgTfHakyO+bmTQtRroEyr3sIwC1xXd
 YBZb2FVU8C+bw3PZ0qJH8YMWucPpBZlQiRZSRBeXXw+x7zUxWiMyz+vOc82CVrQENw4gW5X68
 JXqImo7zQGMBlsNuOQ+sQE7cM2GkPEFPPJiwZ8Y2RzETz/vHEqLhhf0aNGirp/NMPyZ6ydLYM
 WVl8OKv/g+6MII0r4jcQF/DXi5NHIXOdj0fNT0z4wAe6fxgWQQRGbfuHJ/yYqIiEgBXY0T7Zb
 xhQ4HpQI3ZblDjS4T29HgPQ78VvMVETsPwBM7svbdpzFoUc2Kzw36iNchgCAHqcxp2Wssihg2
 UxjLu1SgpedmtcIuygFmRN0I9Lm6RIpz9JRN/OfT339Dds4/CoYGdk6BLRkkDOXG0E9F5QHpP
 xOnItnkiDkLyxhQ==
Received-SPF: permerror client-ip=212.227.126.130;
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

On resume e1000e_vm_state_change() always calls e1000e_autoneg_resume()
that sets link_down to false, and thus activates the link even
if we have disabled it.

The problem can be reproduced starting qemu in paused state (-S) and
then set the link to down. When we resume the machine the link appears
to be up.

Reproducer:

   # qemu-system-x86_64 ... -device e1000e,netdev=netdev0,id=net0 -S

   {"execute": "qmp_capabilities" }
   {"execute": "set_link", "arguments": {"name": "net0", "up": false}}
   {"execute": "cont" }

To fix the problem, merge the content of e1000e_vm_state_change()
into e1000e_core_post_load() as e1000 does.

Buglink: https://issues.redhat.com/browse/RHEL-21867
Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/e1000e_core.c | 50 +++-----------------------------------------
 hw/net/e1000e_core.h |  2 --
 2 files changed, 3 insertions(+), 49 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index e324c02dd589..95311fd60530 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -123,14 +123,6 @@ e1000e_intmgr_timer_resume(E1000IntrDelayTimer *timer)
     }
 }
 
-static void
-e1000e_intmgr_timer_pause(E1000IntrDelayTimer *timer)
-{
-    if (timer->running) {
-        timer_del(timer->timer);
-    }
-}
-
 static inline void
 e1000e_intrmgr_stop_timer(E1000IntrDelayTimer *timer)
 {
@@ -398,24 +390,6 @@ e1000e_intrmgr_resume(E1000ECore *core)
     }
 }
 
-static void
-e1000e_intrmgr_pause(E1000ECore *core)
-{
-    int i;
-
-    e1000e_intmgr_timer_pause(&core->radv);
-    e1000e_intmgr_timer_pause(&core->rdtr);
-    e1000e_intmgr_timer_pause(&core->raid);
-    e1000e_intmgr_timer_pause(&core->tidv);
-    e1000e_intmgr_timer_pause(&core->tadv);
-
-    e1000e_intmgr_timer_pause(&core->itr);
-
-    for (i = 0; i < E1000E_MSIX_VEC_NUM; i++) {
-        e1000e_intmgr_timer_pause(&core->eitr[i]);
-    }
-}
-
 static void
 e1000e_intrmgr_reset(E1000ECore *core)
 {
@@ -3351,22 +3325,6 @@ e1000e_autoneg_resume(E1000ECore *core)
     }
 }
 
-static void
-e1000e_vm_state_change(void *opaque, bool running, RunState state)
-{
-    E1000ECore *core = opaque;
-
-    if (running) {
-        trace_e1000e_vm_state_running();
-        e1000e_intrmgr_resume(core);
-        e1000e_autoneg_resume(core);
-    } else {
-        trace_e1000e_vm_state_stopped();
-        e1000e_autoneg_pause(core);
-        e1000e_intrmgr_pause(core);
-    }
-}
-
 void
 e1000e_core_pci_realize(E1000ECore     *core,
                         const uint16_t *eeprom_templ,
@@ -3379,9 +3337,6 @@ e1000e_core_pci_realize(E1000ECore     *core,
                                        e1000e_autoneg_timer, core);
     e1000e_intrmgr_pci_realize(core);
 
-    core->vmstate =
-        qemu_add_vm_change_state_handler(e1000e_vm_state_change, core);
-
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
         net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
     }
@@ -3405,8 +3360,6 @@ e1000e_core_pci_uninit(E1000ECore *core)
 
     e1000e_intrmgr_pci_unint(core);
 
-    qemu_del_vm_change_state_handler(core->vmstate);
-
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
     }
@@ -3576,5 +3529,8 @@ e1000e_core_post_load(E1000ECore *core)
      */
     nc->link_down = (core->mac[STATUS] & E1000_STATUS_LU) == 0;
 
+    e1000e_intrmgr_resume(core);
+    e1000e_autoneg_resume(core);
+
     return 0;
 }
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index 66b025cc43f1..01510ca78b47 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -98,8 +98,6 @@ struct E1000Core {
 
     E1000IntrDelayTimer eitr[E1000E_MSIX_VEC_NUM];
 
-    VMChangeStateEntry *vmstate;
-
     uint32_t itr_guest_value;
     uint32_t eitr_guest_value[E1000E_MSIX_VEC_NUM];
 
-- 
2.43.0


