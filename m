Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00976801B4A
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:02:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9KwA-0004O7-Os; Sat, 02 Dec 2023 03:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kvt-0004Lc-20
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:02 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kvp-00050W-8D
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:00:58 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6d7f3a4bbc6so970019a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504055; x=1702108855;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aq8m7VGcssqI78XGOxjsweJbMFDzrgiYzBdT9vBPUfc=;
 b=b9XJBbB2aCOw3MMvo6HE1iUlRJYx66nJw6BX2LWUb9ujDwznN2UPV1msIv0WhXU0IU
 LJq6Wt1IsOFVTYM8HFo6aO58Pxt0zUhHXOUuyJcJRCPyi+lC7veeqTJp9wRr8fUvpGTk
 acC0AdQU53KuL9WcLKC4G+RRx4Nk0h31InoKyjMt90+sNeAV8mMiRaCNm6GUC7+7V6vc
 2vYQHrBxD5P5GPcO2AwBKHOpKn4v7ErvSJ8WAudyjVcwhMQh8DJ9GKqi6zPaggtLNhej
 lnXImSWy1uZDf6RA8vysbxbjMn0LBQg+pZUqJcKVcHRLWPlp2Z1YwVeGV0ZwHL+RPG4/
 8XFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504055; x=1702108855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aq8m7VGcssqI78XGOxjsweJbMFDzrgiYzBdT9vBPUfc=;
 b=MVC7H5A4EH1EIJPyQwRfZ1l4ZkJEPBIZ16KoNhcleUj/oc4dsDTIjDRKhcyIwGHGwP
 rulqjbASkQrtMU/ox4f4Oxg+ZxZsOEm2HaKqEEKu3sqki7ZDS8QiR9QmCyUis5udW/lM
 gZimizIAlBJCut/Ep+xBZ41IAkt6Du9BYOm1mXIhOiV5prbpnExaKf+BQMZI8j3ANrvc
 VPE8xVqsHR9A3T1Hcmt7CpQAtZAMLdh7jhzZadLmHWxSz25oEpNc6wl7Thn2to4qPXXG
 LgQFpifIFc27y+EWi3A/RIQTnLS2RP9hF4/5F3JG7JLCgDa+gwrRWipV7FlVfLKO8GUE
 xzIg==
X-Gm-Message-State: AOJu0YyEIrUz9DtBAxBzJ6K1hir91dcYW95wbG22GhogDuCP8bB4hNZv
 m1fX2dibESzXuTwhb1Tpy3+W3A==
X-Google-Smtp-Source: AGHT+IGP5DDkVd5YZHh+wEb+YwuRFEC5HDnv3mv3jAtKS7Ycukej4oyk+1C96W8a54tLTbhwEF0N5A==
X-Received: by 2002:a54:458c:0:b0:3b8:b063:8275 with SMTP id
 z12-20020a54458c000000b003b8b0638275mr992499oib.119.1701504055569; 
 Sat, 02 Dec 2023 00:00:55 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 w24-20020aa78598000000b006cdd1561dcbsm4087492pfn.134.2023.12.02.00.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:00:55 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:28 +0900
Subject: [PATCH 05/14] virtio-net: Implement pci-failover
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-5-32b3570f7bd6@daynix.com>
References: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
In-Reply-To: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32f.google.com
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

This change removes the parsing of pci-device's failover_pair_id
property from virtio-net, and lets pci-device to report an error if
an unknown ID is specified for the property.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-net.h |  3 ++-
 hw/net/virtio-net.c            | 24 ++++--------------------
 hw/virtio/virtio-net-pci.c     | 14 ++++++++++++++
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 55977f01f0..753cab4b32 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -218,7 +218,6 @@ struct VirtIONet {
     /* primary failover device is hidden*/
     bool failover_primary_hidden;
     bool failover;
-    DeviceListener primary_listener;
     QDict *primary_opts;
     bool primary_opts_from_json;
     Notifier migration_state;
@@ -233,6 +232,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
                                   unsigned out_num);
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
                                    const char *type);
+bool virtio_net_set_primary(VirtIONet *n, const QDict *device_opts,
+                            bool from_json, Error **errp);
 uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n);
 
 #endif
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 80c56f0cfc..7def9a1200 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3536,19 +3536,11 @@ static void virtio_net_migration_state_notifier(Notifier *notifier, void *data)
     virtio_net_handle_migration_primary(n, s);
 }
 
-static bool failover_hide_primary_device(DeviceListener *listener,
-                                         const QDict *device_opts,
-                                         bool from_json,
-                                         Error **errp)
+bool virtio_net_set_primary(VirtIONet *n, const QDict *device_opts,
+                            bool from_json, Error **errp)
 {
-    VirtIONet *n = container_of(listener, VirtIONet, primary_listener);
-    const char *standby_id;
-
-    if (!device_opts) {
-        return false;
-    }
-
-    if (!qdict_haskey(device_opts, "failover_pair_id")) {
+    if (!n->failover) {
+        error_setg(errp, "failover pair does not support failover");
         return false;
     }
 
@@ -3557,11 +3549,6 @@ static bool failover_hide_primary_device(DeviceListener *listener,
         return false;
     }
 
-    standby_id = qdict_get_str(device_opts, "failover_pair_id");
-    if (g_strcmp0(standby_id, n->netclient_name) != 0) {
-        return false;
-    }
-
     /*
      * The hide helper can be called several times for a given device.
      * Check there is only one primary for a virtio-net device but
@@ -3621,9 +3608,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     }
 
     if (n->failover) {
-        n->primary_listener.hide_device = failover_hide_primary_device;
         qatomic_set(&n->failover_primary_hidden, true);
-        device_listener_register(&n->primary_listener);
         migration_add_notifier(&n->migration_state,
                                virtio_net_migration_state_notifier);
         n->host_features |= (1ULL << VIRTIO_NET_F_STANDBY);
@@ -3789,7 +3774,6 @@ static void virtio_net_device_unrealize(DeviceState *dev)
 
     if (n->failover) {
         qobject_unref(n->primary_opts);
-        device_listener_unregister(&n->primary_listener);
         migration_remove_notifier(&n->migration_state);
     } else {
         assert(n->primary_opts == NULL);
diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index e03543a70a..e421cd9cea 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -64,10 +64,19 @@ static void virtio_net_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
+static bool virtio_net_pci_set_primary(DeviceState *dev,
+                                       const QDict *device_opts,
+                                       bool from_json, Error **errp)
+{
+    return virtio_net_set_primary(&VIRTIO_NET_PCI(dev)->vdev, device_opts,
+                                  from_json, errp);
+}
+
 static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    PCIFailoverClass *pfc = PCI_FAILOVER_CLASS(klass);
     VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
 
     k->romfile = "efi-virtio.rom";
@@ -75,6 +84,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_VIRTIO_NET;
     k->revision = VIRTIO_PCI_ABI_VERSION;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
+    pfc->set_primary = virtio_net_pci_set_primary;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     device_class_set_props(dc, virtio_net_properties);
     vpciklass->realize = virtio_net_pci_realize;
@@ -98,6 +108,10 @@ static const VirtioPCIDeviceTypeInfo virtio_net_pci_info = {
     .instance_size = sizeof(VirtIONetPCI),
     .instance_init = virtio_net_pci_instance_init,
     .class_init    = virtio_net_pci_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_PCI_FAILOVER },
+        { }
+    },
 };
 
 static void virtio_net_pci_register(void)

-- 
2.43.0


