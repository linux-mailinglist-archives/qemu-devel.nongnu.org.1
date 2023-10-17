Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 010777CCA9F
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:27:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsolq-0006Jq-Ne; Tue, 17 Oct 2023 14:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+ff42024f62dfd72ba0d0+7359+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qsoli-0006Gm-AL
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:26:16 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+ff42024f62dfd72ba0d0+7359+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qsolT-0001UM-2t
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=ASyx27ABg/WdxWXFMwdeXHtm2HUFOe8n8pbrbgV+R1U=; b=dCsAZYtU5oS750WARgfG1cbHbk
 bPq+UZ7bR809wKmsw6T/r5Nxzqx94zY+jrblkr53Fbw9QGaa0IdcMIDWC7gMM9f/2wG56EATB16YM
 6Cdyn/BVEQT8FmID+F6W4Do+H9HkX8Yx6y3050hlpOfC4WRRmLws8CV1sav8q1c3JvBJ1buZfhQ1b
 D7SbIvxrk3EDzcEPbzuFIPt/piSKj+wHOSdiGhorqpUF3KFolMfYdOAF71tj/YcAZF/QvMnkDo0kt
 wNcmRNEUqWWlcIWAgKAiCrsr8NFVyln/wn+h28XuAME3OeO+FgYtDeHIGbHAG+XixHHmENkN4g5m3
 E+1fmYTg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qsolL-007II3-25; Tue, 17 Oct 2023 18:25:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qsolI-000Pal-25; Tue, 17 Oct 2023 19:25:48 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Jason Wang <jasowang@redhat.com>, xen-devel@lists.xenproject.org
Subject: [PATCH 1/4] hw/xen: only remove peers of PCI NICs on unplug
Date: Tue, 17 Oct 2023 19:25:42 +0100
Message-Id: <20231017182545.97973-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017182545.97973-1-dwmw2@infradead.org>
References: <20231017182545.97973-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+ff42024f62dfd72ba0d0+7359+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

When the Xen guest asks to unplug *emulated* NICs, it's kind of unhelpful
also to unplug the peer of the *Xen* PV NIC.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/xen/xen_platform.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 17457ff3de..e2dd1b536a 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -140,9 +140,14 @@ static void unplug_nic(PCIBus *b, PCIDevice *d, void *o)
 /* Remove the peer of the NIC device. Normally, this would be a tap device. */
 static void del_nic_peer(NICState *nic, void *opaque)
 {
-    NetClientState *nc;
+    NetClientState *nc = qemu_get_queue(nic);
+    ObjectClass *klass = module_object_class_by_name(nc->model);
+
+    /* Only delete peers of PCI NICs that we're about to delete */
+    if (!klass || !object_class_dynamic_cast(klass, TYPE_PCI_DEVICE)) {
+        return;
+    }
 
-    nc = qemu_get_queue(nic);
     if (nc->peer)
         qemu_del_net_client(nc->peer);
 }
-- 
2.40.1


