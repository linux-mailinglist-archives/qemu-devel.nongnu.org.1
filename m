Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 283177D6FE4
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:54:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfEM-0005Lp-9V; Wed, 25 Oct 2023 10:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fe87d11d956b9f6f1554+7367+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qvfE5-0005CH-1y; Wed, 25 Oct 2023 10:51:22 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+fe87d11d956b9f6f1554+7367+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qvfDp-000763-As; Wed, 25 Oct 2023 10:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=SKjWRXIgiNg5ff3bqQvSLiVcvlPitO7cHPHfc8XhUXU=; b=i2fwrV8zZ2vjfC4alhYHqho5Kg
 69ItbcjuoufZl6Gv9FMYnIEB1jR+EI2qtRRyqdOFgFYEK1LzG6KxP647hv5/G6my2/D3e1Nf518Bs
 bpsvnspf+G1TgFmvc69VdUs+xMWSbH3w/d4GIgFwg5c42Bt8j3HQ0PB1C/Uw/bTNjij8N3BLhn+ME
 sAQG8vSqxTsmOj0rSVeluMyopsAtLcdgMvZEUnRoZLqQP3/BB165JjV78qWqWj2nFaH3b3IQwlvyc
 qdKCIT24XkYpjsTqPbsyzvjsef9hJe/F4fTkTDMQPAPKlnUOqPmS4ZrhiS0hKFMIO3E4buVrrQeEB
 WiLXn9OQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qvfDa-00GPM6-1D; Wed, 25 Oct 2023 14:50:52 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qvfDZ-002dFU-1H; Wed, 25 Oct 2023 15:50:45 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
Subject: [PATCH v3 22/28] net: add qemu_{configure, create}_nic_device(),
 qemu_find_nic_info()
Date: Wed, 25 Oct 2023 15:50:36 +0100
Message-Id: <20231025145042.627381-23-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025145042.627381-1-dwmw2@infradead.org>
References: <20231025145042.627381-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+fe87d11d956b9f6f1554+7367+infradead.org+dwmw2@desiato.srs.infradead.org;
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

Most code which directly accesses nd_table[] and nb_nics uses them for
one of two things. Either "I have created a NIC device and I'd like a
configuration for it", or "I will create a NIC device *if* there is a
configuration for it".  With some variants on the theme around whether
they actually *check* if the model specified in the configuration is
the right one.

Provide functions which perform both of those, allowing platforms to
be a little more consistent and as a step towards making nd_table[]
and nb_nics private to the net code.

Also export the qemu_find_nic_info() helper, as some platforms have
special cases they need to handle.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/net/net.h |  7 ++++++-
 net/net.c         | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/include/net/net.h b/include/net/net.h
index 2fb1c9181c..56be694c75 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -205,7 +205,12 @@ int qemu_show_nic_models(const char *arg, const char *const *models);
 void qemu_check_nic_model(NICInfo *nd, const char *model);
 int qemu_find_nic_model(NICInfo *nd, const char * const *models,
                         const char *default_model);
-
+NICInfo *qemu_find_nic_info(const char *typename, bool match_default,
+                            const char *alias);
+bool qemu_configure_nic_device(DeviceState *dev, bool match_default,
+                               const char *alias);
+DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
+                                    const char *alias);
 void print_net_client(Monitor *mon, NetClientState *nc);
 void net_socket_rs_init(SocketReadState *rs,
                         SocketReadStateFinalize *finalize,
diff --git a/net/net.c b/net/net.c
index bbe33da176..f8b4973a1e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1072,6 +1072,57 @@ static int net_init_nic(const Netdev *netdev, const char *name,
     return idx;
 }
 
+NICInfo *qemu_find_nic_info(const char *typename, bool match_default,
+                            const char *alias)
+{
+    NICInfo *nd;
+    int i;
+
+    for (i = 0; i < nb_nics; i++) {
+        nd = &nd_table[i];
+
+        if (!nd->used || nd->instantiated) {
+            continue;
+        }
+
+        if ((match_default && !nd->model) || !g_strcmp0(nd->model, typename)
+            || (alias && !g_strcmp0(nd->model, alias))) {
+            return nd;
+        }
+    }
+    return NULL;
+}
+
+
+/* "I have created a device. Please configure it if you can" */
+bool qemu_configure_nic_device(DeviceState *dev, bool match_default,
+                               const char *alias)
+{
+    NICInfo *nd = qemu_find_nic_info(object_get_typename(OBJECT(dev)),
+                                     match_default, alias);
+
+    if (nd) {
+        qdev_set_nic_properties(dev, nd);
+        return true;
+    }
+    return false;
+}
+
+/* "Please create a device, if you have a configuration for it" */
+DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
+                                    const char *alias)
+{
+    NICInfo *nd = qemu_find_nic_info(typename, match_default, alias);
+    DeviceState *dev;
+
+    if (!nd) {
+        return NULL;
+    }
+
+    dev = qdev_new(typename);
+    qdev_set_nic_properties(dev, nd);
+    return dev;
+}
 
 static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
     const Netdev *netdev,
-- 
2.40.1


