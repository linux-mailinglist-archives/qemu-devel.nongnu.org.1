Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE8481E659
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:26:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3g7-00023i-Ti; Tue, 26 Dec 2023 04:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3g4-0001hR-Ph
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3g3-0008Ie-5G
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLU/DtphONhg8DS+Rq3R1gZS3ALsJb4F39lfU8Eoxf0=;
 b=eSBKNrZJYtsrGQULuZgv0XU6oh/g+iHM2um4kNb6BXVWd92SB+TluwO/5XV/enGbF47ymX
 uHNj1IIdTPRDW47AxHJvZPs0yB0gHSASyxZ3Yp4Zv9acfirB5a2qRP7DS7atvORZkDlWUu
 C6ANXhat14q4owwLSqq4L4HfbHkeHjI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-xpNZ6NTcNoy2xi8z1mjQGQ-1; Tue, 26 Dec 2023 04:24:41 -0500
X-MC-Unique: xpNZ6NTcNoy2xi8z1mjQGQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d5aef0cfdso2082615e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582679; x=1704187479;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mLU/DtphONhg8DS+Rq3R1gZS3ALsJb4F39lfU8Eoxf0=;
 b=D24pOYos54NUQLGul3w4ZD5O0Rp4apCXMyoztbADWyAX64vfGuFfMMGC8WWQXkUp6b
 +dwIfB5Vs9WahBnHH/9iqVbld3fjbbKWOtO3xtkVR5HP1T5OlSDW8QCMR7WgVQPQBT3a
 LsEScIf9NtpSEgRwirIqUW6BgJs5LBSthUX7k7Srll/uIcNO48FH8RBPwxbTdHFi/G9/
 pAAcGDmgTdhfVt1EJfhNZYhvKOVUA7DG9ozbdXIR9sFgVRkbBSggxPyg9QMUV85rispT
 mtfYut5P3z8ekUgX9o3Dmbyk/HfG/C3J/+vUxfuCNaZuoKWY2K75naSJMquaiVBZ6IoV
 /aCQ==
X-Gm-Message-State: AOJu0Yx1T8EPJHymfEZULY94eewerAE79Vln9ga8OmWFwsmvMZv/1mwo
 DhSic4S9Gzm1HLSDfS83SxQfNzB8ukKyvyMg8/ZtlOm6j+sSDbNwhTliYPBfSS7LqJ8PxogXydS
 imbLy0KW62por76DzZAyC7l260/XVhuLTM845+Ym0R5kZijPahwuprrEs6WoJVm9mHch6AhZpoO
 Kf
X-Received: by 2002:a05:600c:1909:b0:40d:57d7:6388 with SMTP id
 j9-20020a05600c190900b0040d57d76388mr490077wmq.302.1703582678889; 
 Tue, 26 Dec 2023 01:24:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtArYLj8aR5Rhh9EzMdSeMYSHy5Q7/tYNM8auyh4R2aNYKlyjP0Rha0lb1McH21cbCmxH+Vg==
X-Received: by 2002:a05:600c:1909:b0:40d:57d7:6388 with SMTP id
 j9-20020a05600c190900b0040d57d76388mr490071wmq.302.1703582678630; 
 Tue, 26 Dec 2023 01:24:38 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 n33-20020a05600c502100b004030e8ff964sm28116356wmr.34.2023.12.26.01.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:24:36 -0800 (PST)
Date: Tue, 26 Dec 2023 04:24:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 09/21] vdpa: add VhostVDPAShared
Message-ID: <53ad2fa3e61f4eb6e5ee08597c488fc7056d1210.1703582625.git.mst@redhat.com>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Eugenio Pérez <eperezma@redhat.com>

It will hold properties shared among all vhost_vdpa instances associated
with of the same device.  For example, we just need one iova_tree or one
memory listener for the entire device.

Next patches will register the vhost_vdpa memory listener at the
beginning of the VM migration at the destination. This enables QEMU to
map the memory to the device before stopping the VM at the source,
instead of doing while both source and destination are stopped, thus
minimizing the downtime.

However, the destination QEMU is unaware of which vhost_vdpa struct will
register its memory_listener.  If the source guest has CVQ enabled, it
will be the one associated with the CVQ.  Otherwise, it will be the
first one.

Save the memory operations related members in a common place rather than
always in the first / last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20231221174322.3130442-2-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  5 +++++
 net/vhost-vdpa.c               | 24 ++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 5407d54fd7..eb1a56d75a 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -30,6 +30,10 @@ typedef struct VhostVDPAHostNotifier {
     void *addr;
 } VhostVDPAHostNotifier;
 
+/* Info shared by all vhost_vdpa device models */
+typedef struct vhost_vdpa_shared {
+} VhostVDPAShared;
+
 typedef struct vhost_vdpa {
     int device_fd;
     int index;
@@ -46,6 +50,7 @@ typedef struct vhost_vdpa {
     bool suspended;
     /* IOVA mapping used by the Shadow Virtqueue */
     VhostIOVATree *iova_tree;
+    VhostVDPAShared *shared;
     GPtrArray *shadow_vqs;
     const VhostShadowVirtqueueOps *shadow_vq_ops;
     void *shadow_vq_ops_opaque;
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index d0614d7954..8b661b9e6d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -240,6 +240,10 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         qemu_close(s->vhost_vdpa.device_fd);
         s->vhost_vdpa.device_fd = -1;
     }
+    if (s->vhost_vdpa.index != 0) {
+        return;
+    }
+    g_free(s->vhost_vdpa.shared);
 }
 
 /** Dummy SetSteeringEBPF to support RSS for vhost-vdpa backend  */
@@ -1661,6 +1665,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
                                        bool svq,
                                        struct vhost_vdpa_iova_range iova_range,
                                        uint64_t features,
+                                       VhostVDPAShared *shared,
                                        Error **errp)
 {
     NetClientState *nc = NULL;
@@ -1696,6 +1701,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     if (queue_pair_index == 0) {
         vhost_vdpa_net_valid_svq_features(features,
                                           &s->vhost_vdpa.migration_blocker);
+        s->vhost_vdpa.shared = g_new0(VhostVDPAShared, 1);
     } else if (!is_datapath) {
         s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
                                      PROT_READ | PROT_WRITE,
@@ -1708,11 +1714,16 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         s->vhost_vdpa.shadow_vq_ops_opaque = s;
         s->cvq_isolated = cvq_isolated;
     }
+    if (queue_pair_index != 0) {
+        s->vhost_vdpa.shared = shared;
+    }
+
     ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index, nvqs);
     if (ret) {
         qemu_del_net_client(nc);
         return NULL;
     }
+
     return nc;
 }
 
@@ -1824,17 +1835,26 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
     ncs = g_malloc0(sizeof(*ncs) * queue_pairs);
 
     for (i = 0; i < queue_pairs; i++) {
+        VhostVDPAShared *shared = NULL;
+
+        if (i) {
+            shared = DO_UPCAST(VhostVDPAState, nc, ncs[0])->vhost_vdpa.shared;
+        }
         ncs[i] = net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
                                      vdpa_device_fd, i, 2, true, opts->x_svq,
-                                     iova_range, features, errp);
+                                     iova_range, features, shared, errp);
         if (!ncs[i])
             goto err;
     }
 
     if (has_cvq) {
+        VhostVDPAState *s0 = DO_UPCAST(VhostVDPAState, nc, ncs[0]);
+        VhostVDPAShared *shared = s0->vhost_vdpa.shared;
+
         nc = net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
                                  vdpa_device_fd, i, 1, false,
-                                 opts->x_svq, iova_range, features, errp);
+                                 opts->x_svq, iova_range, features, shared,
+                                 errp);
         if (!nc)
             goto err;
     }
-- 
MST


