Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1B67DB2A5
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:15:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKc8-0002AQ-Vs; Mon, 30 Oct 2023 01:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKc4-00029v-Om
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:56 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKc3-0001nN-8d
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:56 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b3c2607d9bso3445412b3a.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642893; x=1699247693;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33eHcWs5bVTl2Yl+vAjf/syz7nAHZ1f9UgWZDxn4ISw=;
 b=vpnZm75iENPIuN3EA/CZDKAMQC7LiLkaXP7fxxdzrRMcTveULeGQE8bE25OxVoMMDC
 TtEtbj8b6ksVWzJwj8cCGx1YSckNnTt4NlktuLwkWUUHlBgsNHt0eWvFRoQt8O5JfTzx
 XXXNdPwD4Kth6tWIVs/QFAwhbpFPNjj03ATwRFJkvCRhIbEF6MdAR/+cShevvU+hVKt/
 CiVQogt6ZKs/EMh68n0biD81+9OU7VSRQe/yclrg8NhQAIyZsnLBavOHb6K9KfPyxUt5
 fYwUWOTKhZL6Fn7wCSP/WntR3mzJP8bndpm2PqiEm6CbQaxnNxQU0i5I/qvC556FTWQs
 r81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642893; x=1699247693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33eHcWs5bVTl2Yl+vAjf/syz7nAHZ1f9UgWZDxn4ISw=;
 b=kiVTord0Qf8/SxEiwO0wuws8PdH7wsgN51FLXLQ5Y09oWWK6aFlPSDaAg7XwFcbC29
 2d5gC6hWgHaM6wbZ4g13/t4tX0b0q3Z0OhZCqwMgpnC1l08Dij2zYrrwXv9cPcv8duli
 IuIvG8wLS0ZIOlQ9GOlMfPuaWjP3/ikRlnmZVqqoc8CDpHS9dNBekMVk4XMW5WYyD1PP
 xnihHS5agGYS7TUjAoDC33B+ktIVY8czTqoM1kmcsI6x35CTesk6ee73ELpG/qYgTytN
 Mvm9PopGWms9Bu3lcAb4KexUEXNf0ev3UEtKcToi/YZ9xyHC/ZXOygLKZ2UyK+P4ybSX
 OD8A==
X-Gm-Message-State: AOJu0Yya25emkGnhQ5I059QKhd1G00KEHJQYQbZxp+h54Oql9fejQ77T
 TmV56bJzklva2OwhzXTZck60uyhnCnnw3BaBHjaO+g==
X-Google-Smtp-Source: AGHT+IEH9atTe1+5rwrTgNbVqeGYCt+uVulRu63HAucdJCqx0tfsyK/bXHwUUjOAQn3xGRL2lHfdAA==
X-Received: by 2002:a05:6a00:c8d:b0:6be:b92b:e5fe with SMTP id
 a13-20020a056a000c8d00b006beb92be5femr7185692pfv.34.1698642893654; 
 Sun, 29 Oct 2023 22:14:53 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 a15-20020a63704f000000b00563590be25esm3963531pgn.29.2023.10.29.22.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:14:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 12/21] virtio-net: Enable software RSS
Date: Mon, 30 Oct 2023 14:12:33 +0900
Message-ID: <20231030051356.33123-13-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

virtio-net implements software RSS but does not enable it. Enable it
when RSS is requested, but the eBPF implementation is not available.
We also check if vhost is in use in such a case since software RSS is
incompatible with vhost. A warning will be emitted when falling back to
software RSS since it provides no performance benefit.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7bb91617d0..1fa020d905 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1260,10 +1260,12 @@ static bool virtio_net_attach_epbf_rss(VirtIONet *n)
 
     if (!ebpf_rss_set_all(&n->ebpf_rss, &config,
                           n->rss_data.indirections_table, n->rss_data.key)) {
+        warn_report("Failed to configure eBPF RSS");
         return false;
     }
 
     if (!virtio_net_attach_ebpf_to_backend(n->nic, n->ebpf_rss.program_fd)) {
+        warn_report("Failed to attach eBPF to backend");
         return false;
     }
 
@@ -1278,16 +1280,10 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
 static void virtio_net_commit_rss_config(VirtIONet *n)
 {
     if (n->rss_data.enabled) {
-        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
+        n->rss_data.enabled_software_rss = n->rss_data.populate_hash ||
+                                           !virtio_net_attach_epbf_rss(n);
         if (n->rss_data.populate_hash) {
             virtio_net_detach_epbf_rss(n);
-        } else if (!virtio_net_attach_epbf_rss(n)) {
-            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
-                warn_report("Can't load eBPF RSS for vhost");
-            } else {
-                warn_report("Can't load eBPF RSS - fallback to software RSS");
-                n->rss_data.enabled_software_rss = true;
-            }
         }
 
         trace_virtio_net_rss_enable(n->rss_data.hash_types,
@@ -3747,8 +3743,13 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
         !virtio_net_load_ebpf(n)) {
-        error_setg(errp, "Can't load eBPF RSS");
-        virtio_net_device_unrealize(dev);
+        if (get_vhost_net(nc->peer)) {
+            error_setg(errp, "Can't load eBPF RSS for vhost");
+            virtio_net_device_unrealize(dev);
+            return;
+        }
+
+        warn_report_once("Can't load eBPF RSS - fallback to software RSS");
     }
 }
 
-- 
2.42.0


