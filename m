Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0237CFE34
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:41:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtV8Z-00028j-Ln; Thu, 19 Oct 2023 11:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+06ae5fa416ae820d9d5a+7361+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qtV8W-00025m-Lc; Thu, 19 Oct 2023 11:40:36 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+06ae5fa416ae820d9d5a+7361+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qtV8R-0001iv-Vc; Thu, 19 Oct 2023 11:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=bY7G6BllzrJN3vFK/Y7G+K3RXXQYNifA9f7cWw91v+w=; b=MWiT9XbJDhi9ujm0tGvm22upP7
 te/lmQ/hmveZzn0ycVjWqixFGMKT6/5fU6uvVcMql6gSfMbgWZLlU7jwp9ryFUBA7uH56p+hVjjco
 0AZoYkc+YKjxkHCN455FCa166iJ2BrpMdVUOsH/51ZvwultlVsVlL27jQtCS6+ycQutWfSv92YIn8
 7ztLveVVi78j4kpc/qu9EyXLlAdscdGLg+mFl9+MTP4eKRjsKTd0Wr4JMvc3B3VT382bsQWkXT3pd
 P8bP7vqrqozgMjgfKrnxvHZI95genVjq6SQ4008ksTv9EPtTYLWgSGCSZ6RMS3gPObuzgRGF6D9zW
 4qnfXlBg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qtV8N-007ost-6Z; Thu, 19 Oct 2023 15:40:27 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qtV8M-000Puj-2e; Thu, 19 Oct 2023 16:40:26 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
Subject: [PATCH v2 16/24] hw/xen: handle soft reset for primary console
Date: Thu, 19 Oct 2023 16:40:12 +0100
Message-Id: <20231019154020.99080-17-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231019154020.99080-1-dwmw2@infradead.org>
References: <20231019154020.99080-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+06ae5fa416ae820d9d5a+7361+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On soft reset, the prinary console event channel needs to be rebound to
the backend port (in the xen-console driver). We could put that into the
xen-console driver itself, but it's slightly less ugly to keep it within
the KVM/Xen code, by stashing the backend port# on event channel reset
and then rebinding in the primary console reset when it has to recreate
the guest port anyway.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_evtchn.c          |  9 +++++++++
 hw/i386/kvm/xen_primary_console.c | 29 ++++++++++++++++++++++++++++-
 hw/i386/kvm/xen_primary_console.h |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index d72dca6591..ce4da6d37a 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -40,6 +40,7 @@
 #include "xen_evtchn.h"
 #include "xen_overlay.h"
 #include "xen_xenstore.h"
+#include "xen_primary_console.h"
 
 #include "sysemu/kvm.h"
 #include "sysemu/kvm_xen.h"
@@ -1098,6 +1099,7 @@ int xen_evtchn_soft_reset(void)
 {
     XenEvtchnState *s = xen_evtchn_singleton;
     bool flush_kvm_routes;
+    uint16_t con_port = xen_primary_console_get_port();
     int i;
 
     if (!s) {
@@ -1108,6 +1110,13 @@ int xen_evtchn_soft_reset(void)
 
     qemu_mutex_lock(&s->port_lock);
 
+    if (con_port) {
+        XenEvtchnPort *p = &s->port_table[con_port];
+        if (p->type == EVTCHNSTAT_interdomain) {
+            xen_primary_console_set_be_port(p->u.interdomain.port);
+        }
+    }
+
     for (i = 0; i < s->nr_ports; i++) {
         close_port(s, i, &flush_kvm_routes);
     }
diff --git a/hw/i386/kvm/xen_primary_console.c b/hw/i386/kvm/xen_primary_console.c
index 0aa1c16ad6..5e6e085ac7 100644
--- a/hw/i386/kvm/xen_primary_console.c
+++ b/hw/i386/kvm/xen_primary_console.c
@@ -112,6 +112,15 @@ uint16_t xen_primary_console_get_port(void)
     return s->guest_port;
 }
 
+void xen_primary_console_set_be_port(uint16_t port)
+{
+    XenPrimaryConsoleState *s = xen_primary_console_singleton;
+    if (s) {
+        printf("be port set to %d\n", port);
+        s->be_port = port;
+    }
+}
+
 uint64_t xen_primary_console_get_pfn(void)
 {
     XenPrimaryConsoleState *s = xen_primary_console_singleton;
@@ -142,6 +151,20 @@ static void alloc_guest_port(XenPrimaryConsoleState *s)
     }
 }
 
+static void rebind_guest_port(XenPrimaryConsoleState *s)
+{
+    struct evtchn_bind_interdomain inter = {
+        .remote_dom = DOMID_QEMU,
+        .remote_port = s->be_port,
+    };
+
+    if (!xen_evtchn_bind_interdomain_op(&inter)) {
+        s->guest_port = inter.local_port;
+    }
+
+    s->be_port = 0;
+}
+
 int xen_primary_console_reset(void)
 {
     XenPrimaryConsoleState *s = xen_primary_console_singleton;
@@ -154,7 +177,11 @@ int xen_primary_console_reset(void)
         xen_overlay_do_map_page(&s->console_page, gpa);
     }
 
-    alloc_guest_port(s);
+    if (s->be_port) {
+        rebind_guest_port(s);
+    } else {
+        alloc_guest_port(s);
+    }
 
     trace_xen_primary_console_reset(s->guest_port);
 
diff --git a/hw/i386/kvm/xen_primary_console.h b/hw/i386/kvm/xen_primary_console.h
index dd4922f3f4..7e2989ea0d 100644
--- a/hw/i386/kvm/xen_primary_console.h
+++ b/hw/i386/kvm/xen_primary_console.h
@@ -16,6 +16,7 @@ void xen_primary_console_create(void);
 int xen_primary_console_reset(void);
 
 uint16_t xen_primary_console_get_port(void);
+void xen_primary_console_set_be_port(uint16_t port);
 uint64_t xen_primary_console_get_pfn(void);
 void *xen_primary_console_get_map(void);
 
-- 
2.40.1


