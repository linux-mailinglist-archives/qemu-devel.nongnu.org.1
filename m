Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA57262A7
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:21:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u0p-0002ri-Fd; Wed, 07 Jun 2023 10:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0o-0002rS-4U
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:46 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0l-0003PC-SY
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686147583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k3ef/Yah043cuQBdWrCnL0TAtjyxnRKzu4Znq8bA1Ag=;
 b=V6w457R8/frNCWU02DQMigFYYLRO2orOqsFH+w5O7xTiKZnUdFIkvWy3
 KXj1gc8dNdiasvjHyBm3lwuGRyCs7c9VGmHkvHYLwcDYMsIc0QZj3bNwP
 RPXavXa/8n+q9Wfm/CBOMTfPbE1UZLvYTJPzN+MS7M7NoO4qRz2xk1MZc U=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 111246587
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:yfX2TazNClSvhGAA3qB6t+cxxirEfRIJ4+MujC+fZmUNrF6WrkUGm
 GNNXjqFbvqPYGP1KNknPo+29EkB7ZaAzYdqSVNvpSAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTrafYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EsHUMja4mtC5QRgPa8T5jcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KUVq9
 t8eLW9QVyqavOux246ZVrkztP12eaEHPKtH0p1h5TTQDPJgSpHfWaTao9Rf2V/chOgXQ6yYP
 ZBAL2MyMlKZOUYn1lQ/UfrSmM+hgGX/dDtJ7kqYv6Mt70DYzRBr0airO93QEjCPbZwMxxzE+
 D+WoAwVBDk5HobOzx/V106Im/HenBqmQZ4XTOano6sCbFq7mTVIVUx+uUGAieC0j1P7V99BJ
 kg8/C0ooq4vskuxQbHVUwK9v1aNuxcOXNwWGOp89QLl90bPy1/HXC5eFGcHMYF48pZsHlTGy
 2NlgfvNIT9MtrjKFEun74ydqiiOGzRFcl07MHpsoRQ+3/Hvp4Q6jxTqR9llEbKogtCdJQwc0
 wxmvwBl2exN0JdjO7GTuAme3mny/sShohsdvF2/Y46z0u9uiGdJjaSM4EOT0/tPJZ3xorKp7
 CldwJj2AAzj4PiweM2xrAclRunBCxWtame0bbtT834JqVyQF4aLJ9w43d2HDB4B3jw4UTHoe
 lTPngha+YVeOnCnBYcuPdLvU5t0l/S7RIi8PhwxUjaoSsIpHONg1Hs3DXN8Iki3yBR8+U3BE
 cnznTmQ4YYyVv08kWveqxY12r433CEurV4/triipylLJYG2PSbPIZ9caQvmUwzMxP/cyOkj2
 4oFZpTiJtQ2eLGWXxQ7BqZNdQ1bcyJmX8meRg4+XrfrHzeK0VoJU5f5qY7NsaQ/90iJvo8kJ
 k2AZ3I=
IronPort-HdrOrdr: A9a23:KBtAPayLf3mS7YbaYWGEKrPwIr1zdoMgy1knxilNoH1uHvBw8v
 rEoB1173DJYVoqNk3I++rhBEDwexLhHPdOiOF6UItKNzOW21dAQrsSiLfK8nnNHDD/6/4Y9Y
 oISdkbNDQoNykZsfrH
X-Talos-CUID: 9a23:rOqFSG73SSe8CJEfJdss0GoXOcYgLSDk9m7rKkijNUR1GOKncArF
X-Talos-MUID: =?us-ascii?q?9a23=3AaCSshg/tTcmGaHECmnFIHMuQf+RCufWoLRAorbE?=
 =?us-ascii?q?bpdiFDHFpJzLF1yviFw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; d="scan'208";a="111246587"
To: <qemu-devel@nongnu.org>
CC: David Woodhouse <dwmw@amazon.co.uk>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 01/12] hw/xen: Simplify emulated Xen platform init
Date: Wed, 7 Jun 2023 15:18:28 +0100
Message-ID: <20230607141839.48422-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
References: <20230607141839.48422-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.155.175;
 envelope-from=prvs=51561cf95=anthony.perard@citrix.com;
 helo=esa6.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: David Woodhouse <dwmw@amazon.co.uk>

I initially put the basic platform init (overlay pages, grant tables,
event channels) into mc->kvm_type because that was the earliest place
that could sensibly test for xen_mode==XEN_EMULATE.

The intent was to do this early enough that we could then initialise the
XenBus and other parts which would have depended on them, from a generic
location for both Xen and KVM/Xen in the PC-specific code, as seen in
https://lore.kernel.org/qemu-devel/20230116221919.1124201-16-dwmw2@infradead.org/

However, then the Xen on Arm patches came along, and *they* wanted to
do the XenBus init from a 'generic' Xen-specific location instead:
https://lore.kernel.org/qemu-devel/20230210222729.957168-4-sstabellini@kernel.org/

Since there's no generic location that covers all three, I conceded to
do it for XEN_EMULATE mode in pc_basic_devices_init().

And now there's absolutely no point in having some of the platform init
done from pc_machine_kvm_type(); we can move it all up to live in a
single place in pc_basic_devices_init(). This has the added benefit that
we can drop the separate xen_evtchn_connect_gsis() function completely,
and pass just the system GSIs in directly to xen_evtchn_create().

While I'm at it, it does no harm to explicitly pass in the *number* of
said GSIs, because it does make me twitch a bit to pass an array of
impicit size. During the lifetime of the KVM/Xen patchset, that had
already changed (albeit just cosmetically) from GSI_NUM_PINS to
IOAPIC_NUM_PINS.

And document a bit better that this is for the *output* GSI for raising
CPU0's events when the per-CPU vector isn't available. The fact that
we create a whole set of them and then only waggle the one we're told
to, instead of having a single output and only *connecting* it to the
GSI that it should be connected to, is still non-intuitive for me.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20230412185102.441523-2-dwmw2@infradead.org>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/kvm/xen_evtchn.c | 40 ++++++++++++++++++++--------------------
 hw/i386/kvm/xen_evtchn.h |  3 +--
 hw/i386/pc.c             | 13 ++++---------
 3 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 3048329474..3d810dbd59 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -147,7 +147,10 @@ struct XenEvtchnState {
     QemuMutex port_lock;
     uint32_t nr_ports;
     XenEvtchnPort port_table[EVTCHN_2L_NR_CHANNELS];
-    qemu_irq gsis[IOAPIC_NUM_PINS];
+
+    /* Connected to the system GSIs for raising callback as GSI / INTx */
+    unsigned int nr_callback_gsis;
+    qemu_irq *callback_gsis;
 
     struct xenevtchn_handle *be_handles[EVTCHN_2L_NR_CHANNELS];
 
@@ -299,7 +302,7 @@ static void gsi_assert_bh(void *opaque)
     }
 }
 
-void xen_evtchn_create(void)
+void xen_evtchn_create(unsigned int nr_gsis, qemu_irq *system_gsis)
 {
     XenEvtchnState *s = XEN_EVTCHN(sysbus_create_simple(TYPE_XEN_EVTCHN,
                                                         -1, NULL));
@@ -310,8 +313,19 @@ void xen_evtchn_create(void)
     qemu_mutex_init(&s->port_lock);
     s->gsi_bh = aio_bh_new(qemu_get_aio_context(), gsi_assert_bh, s);
 
-    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(s), &s->gsis[i]);
+    /*
+     * These are the *output* GSI from event channel support, for
+     * signalling CPU0's events via GSI or PCI INTx instead of the
+     * per-CPU vector. We create a *set* of irqs and connect one to
+     * each of the system GSIs which were passed in from the platform
+     * code, and then just trigger the right one as appropriate from
+     * xen_evtchn_set_callback_level().
+     */
+    s->nr_callback_gsis = nr_gsis;
+    s->callback_gsis = g_new0(qemu_irq, nr_gsis);
+    for (i = 0; i < nr_gsis; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(s), &s->callback_gsis[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(s), i, system_gsis[i]);
     }
 
     /*
@@ -336,20 +350,6 @@ void xen_evtchn_create(void)
     xen_evtchn_ops = &emu_evtchn_backend_ops;
 }
 
-void xen_evtchn_connect_gsis(qemu_irq *system_gsis)
-{
-    XenEvtchnState *s = xen_evtchn_singleton;
-    int i;
-
-    if (!s) {
-        return;
-    }
-
-    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(s), i, system_gsis[i]);
-    }
-}
-
 static void xen_evtchn_register_types(void)
 {
     type_register_static(&xen_evtchn_info);
@@ -430,8 +430,8 @@ void xen_evtchn_set_callback_level(int level)
         return;
     }
 
-    if (s->callback_gsi && s->callback_gsi < IOAPIC_NUM_PINS) {
-        qemu_set_irq(s->gsis[s->callback_gsi], level);
+    if (s->callback_gsi && s->callback_gsi < s->nr_callback_gsis) {
+        qemu_set_irq(s->callback_gsis[s->callback_gsi], level);
         if (level) {
             /* Ensure the vCPU polls for deassertion */
             kvm_xen_set_callback_asserted();
diff --git a/hw/i386/kvm/xen_evtchn.h b/hw/i386/kvm/xen_evtchn.h
index bfb67ac2bc..b740acfc0d 100644
--- a/hw/i386/kvm/xen_evtchn.h
+++ b/hw/i386/kvm/xen_evtchn.h
@@ -16,10 +16,9 @@
 
 typedef uint32_t evtchn_port_t;
 
-void xen_evtchn_create(void);
+void xen_evtchn_create(unsigned int nr_gsis, qemu_irq *system_gsis);
 int xen_evtchn_soft_reset(void);
 int xen_evtchn_set_callback_param(uint64_t param);
-void xen_evtchn_connect_gsis(qemu_irq *system_gsis);
 void xen_evtchn_set_callback_level(int level);
 
 int xen_evtchn_set_port(uint16_t port);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bb62c994fa..fc52772fdd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1332,7 +1332,10 @@ void pc_basic_device_init(struct PCMachineState *pcms,
 
 #ifdef CONFIG_XEN_EMU
     if (xen_mode == XEN_EMULATE) {
-        xen_evtchn_connect_gsis(gsi);
+        xen_overlay_create();
+        xen_evtchn_create(IOAPIC_NUM_PINS, gsi);
+        xen_gnttab_create();
+        xen_xenstore_create();
         if (pcms->bus) {
             pci_create_simple(pcms->bus, -1, "xen-platform");
         }
@@ -1882,14 +1885,6 @@ static void pc_machine_initfn(Object *obj)
 
 int pc_machine_kvm_type(MachineState *machine, const char *kvm_type)
 {
-#ifdef CONFIG_XEN_EMU
-    if (xen_mode == XEN_EMULATE) {
-        xen_overlay_create();
-        xen_evtchn_create();
-        xen_gnttab_create();
-        xen_xenstore_create();
-    }
-#endif
     return 0;
 }
 
-- 
Anthony PERARD


