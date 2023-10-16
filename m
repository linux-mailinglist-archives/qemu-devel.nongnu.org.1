Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E81497CAD4F
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:20:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPNk-0000c2-9W; Mon, 16 Oct 2023 11:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1bdf71eab2d76d13073e+7358+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qsPNO-0000OX-9X; Mon, 16 Oct 2023 11:19:26 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1bdf71eab2d76d13073e+7358+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qsPNK-0001am-Vl; Mon, 16 Oct 2023 11:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=MzyeUS8+Q6DyGG1BYkZOM8Vo8wKa2UEntgjHbKC7sqQ=; b=GJb2yG67l2i9wJHfLSPli4NmiV
 +WTJ+STZ9PvEtXrFika2dLjRUrokj2hMR900jok8EpQMettPN7gS3FHyPQKoznf647TUOpQSYHY87
 7NhsXIonFGtW9kxXtw/WrFVNq3USbXjMFevv9C8aamNvWluW8r5OoAlCDIqIh2MY7r95iGlt3LwPy
 5WsUY2qda44FfRXdd6nB2ta+X7WWj3YG/9DdMeQ3M++iT+3xJ8ubaNHJ4hpP0CAXaBOr6HpHe17qm
 Dw1r3eL81en6tel9bQMu5Y3fvInjNbKvWsdnZNPfP0uvJdUrEuS9xLq5kA/UMXrbV4xTXsKUFPxUa
 fbe12+bQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qsPNB-0067AI-2H; Mon, 16 Oct 2023 15:19:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qsPNC-0005na-07; Mon, 16 Oct 2023 16:19:14 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Woodhouse <dwmw2@infradead.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: [PATCH 08/12] hw/xen: do not repeatedly try to create a failing
 backend device
Date: Mon, 16 Oct 2023 16:19:05 +0100
Message-Id: <20231016151909.22133-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231016151909.22133-1-dwmw2@infradead.org>
References: <20231016151909.22133-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+1bdf71eab2d76d13073e+7358+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
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
index cc524ed92c..0da2aa219a 100644
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
2.40.1


