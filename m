Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E78977E275E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:44:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00iW-0000l5-TO; Mon, 06 Nov 2023 09:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=667a8cc2a=dwmw2@infradead.org>)
 id 1r00i4-00083t-Rw; Mon, 06 Nov 2023 09:36:17 -0500
Received: from smtp-fw-52002.amazon.com ([52.119.213.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=667a8cc2a=dwmw2@infradead.org>)
 id 1r00hv-0000Yp-0Y; Mon, 06 Nov 2023 09:36:08 -0500
X-IronPort-AV: E=Sophos;i="6.03,281,1694736000"; d="scan'208";a="593337468"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-52002.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:36:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev
 (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
 by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix)
 with ESMTPS id 354448463C; Mon,  6 Nov 2023 14:35:49 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:33609]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.187:2525]
 with esmtp (Farcaster)
 id 17b942b6-4bce-4e6d-bd4d-69894513813a; Mon, 6 Nov 2023 14:35:49 +0000 (UTC)
X-Farcaster-Flow-ID: 17b942b6-4bce-4e6d-bd4d-69894513813a
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 14:35:38 +0000
Received: from u3832b3a9db3152.ant.amazon.com (10.106.83.6) by
 mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Mon, 6 Nov 2023 14:35:35 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: <qemu-devel@nongnu.org>
CC: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Stefano Stabellini
 <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul
 Durrant <paul@xen.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, <qemu-block@nongnu.org>,
 <xen-devel@lists.xenproject.org>, <kvm@vger.kernel.org>
Subject: [PATCH v4 08/17] hw/xen: do not repeatedly try to create a failing
 backend device
Date: Mon, 6 Nov 2023 14:34:58 +0000
Message-ID: <20231106143507.1060610-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106143507.1060610-1-dwmw2@infradead.org>
References: <20231106143507.1060610-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: Bulk
Received-SPF: none client-ip=52.119.213.150;
 envelope-from=prvs=667a8cc2a=dwmw2@infradead.org;
 helo=smtp-fw-52002.amazon.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

If xen_backend_device_create() fails to instantiate a device, the XenBus
code will just keep trying over and over again each time the bus is
re-enumerated, as long as the backend appears online and in
XenbusStateInitialising.

The only thing which prevents the XenBus code from recreating duplicates
of devices which already exist, is the fact that xen_device_realize()
sets the backend state to XenbusStateInitWait. If the attempt to create
the device doesn't get *that* far, that's when it will keep getting
retried.

My first thought was to handle errors by setting the backend state to
XenbusStateClosed, but that doesn't work for XenConsole which wants to
*ignore* any device of type != "ioemu" completely.

So, make xen_backend_device_create() *keep* the XenBackendInstance for a
failed device, and provide a new xen_backend_exists() function to allow
xen_bus_type_enumerate() to check whether one already exists before
creating a new one.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/xen/xen-backend.c         | 27 +++++++++++++++++++++------
 hw/xen/xen-bus.c             |  3 ++-
 include/hw/xen/xen-backend.h |  1 +
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/hw/xen/xen-backend.c b/hw/xen/xen-backend.c
index 5b0fb76eae..b9bf70a9f5 100644
--- a/hw/xen/xen-backend.c
+++ b/hw/xen/xen-backend.c
@@ -101,6 +101,24 @@ static XenBackendInstance *xen_backend_list_find(XenDevice *xendev)
     return NULL;
 }
 
+bool xen_backend_exists(const char *type, const char *name)
+{
+    const XenBackendImpl *impl = xen_backend_table_lookup(type);
+    XenBackendInstance *backend;
+
+    if (!impl) {
+        return false;
+    }
+
+    QLIST_FOREACH(backend, &backend_list, entry) {
+        if (backend->impl == impl && !strcmp(backend->name, name)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static void xen_backend_list_remove(XenBackendInstance *backend)
 {
     QLIST_REMOVE(backend, entry);
@@ -122,11 +140,6 @@ void xen_backend_device_create(XenBus *xenbus, const char *type,
     backend->name = g_strdup(name);
 
     impl->create(backend, opts, errp);
-    if (*errp) {
-        g_free(backend->name);
-        g_free(backend);
-        return;
-    }
 
     backend->impl = impl;
     xen_backend_list_add(backend);
@@ -165,7 +178,9 @@ bool xen_backend_try_device_destroy(XenDevice *xendev, Error **errp)
     }
 
     impl = backend->impl;
-    impl->destroy(backend, errp);
+    if (backend->xendev) {
+        impl->destroy(backend, errp);
+    }
 
     xen_backend_list_remove(backend);
     g_free(backend->name);
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 12ff782005..3ffd1a5333 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -209,7 +209,8 @@ static void xen_bus_type_enumerate(XenBus *xenbus, const char *type)
                           NULL, "%u", &online) != 1)
             online = 0;
 
-        if (online && state == XenbusStateInitialising) {
+        if (online && state == XenbusStateInitialising &&
+            !xen_backend_exists(type, backend[i])) {
             Error *local_err = NULL;
 
             xen_bus_backend_create(xenbus, type, backend[i], backend_path,
diff --git a/include/hw/xen/xen-backend.h b/include/hw/xen/xen-backend.h
index aac2fd454d..0f01631ae7 100644
--- a/include/hw/xen/xen-backend.h
+++ b/include/hw/xen/xen-backend.h
@@ -33,6 +33,7 @@ XenDevice *xen_backend_get_device(XenBackendInstance *backend);
 void xen_backend_register(const XenBackendInfo *info);
 const char **xen_backend_get_types(unsigned int *nr);
 
+bool xen_backend_exists(const char *type, const char *name);
 void xen_backend_device_create(XenBus *xenbus, const char *type,
                                const char *name, QDict *opts, Error **errp);
 bool xen_backend_try_device_destroy(XenDevice *xendev, Error **errp);
-- 
2.34.1


