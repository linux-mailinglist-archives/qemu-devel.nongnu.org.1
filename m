Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF1D80B919
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:33:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCPE-0002g8-Of; Sun, 10 Dec 2023 00:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCP2-0002SI-CD
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:31:00 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCOx-000389-G2
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:30:54 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6d9d209c9bbso2619422a34.0
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186248; x=1702791048;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AXWc99Uks0utjFeyBxDTegSCMld6phR7BMinTCNJCDI=;
 b=J0pq1BeFEltNtmsoW4/GAsYnIhZVChjJoEDlnHKg1clYmdbUZyqHEl6veAJBViu0YZ
 co4DPlnMT406LJuuqhQfG14CVy77LiidmQb6wvRhoB/ise1cn3WsgLegDtwXRI6du9XH
 1iexq2EHXuHwgG3OITqKnn/KwdGEW7sW2L+vo1DKZbmiITsxSX01KB0xUigfhjEIf2XB
 2cBIDwPDrs6yKIaTUuPC731EvgZ7n0bwWlXWgoG3CFMcrBqH2+rSSc/RkU2+2wcj9QbD
 xHIgTlSam3+7UH0UlhHCSCtvpY9yz8St4bgfgwuMbnvcy6vbD2d7fyaHb40xRqj7lywg
 UCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186248; x=1702791048;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AXWc99Uks0utjFeyBxDTegSCMld6phR7BMinTCNJCDI=;
 b=VsRlU+1x63mYkIDrtP5RgQpu7G41/tSywxqBVw39cSa1+V8vh6dqe9ZD+SlAIrPNUf
 vz9AK6O2Pd4GMLDESuwBcMZgaEZETJu2nVrrnxl6aYzVwUqWgNoHsv2GJxyHqDWmIi8F
 hANTK7VyCMMam2JfLRb04M9a2lLsz0DDmVOQQXXVv2DXpfKHrdAvPeghAdM1sTKb+h5d
 ePw+dE3RpKCq3rjEYmJ5uLLlvx+2YpBsiactC/d6ALq0DOyY1JHotXMQK8VLQV6p08uh
 2XFuSpfHrtLnfnp3Rl22MjBHlyyin7QKue/Cd+gU2MvrJdKdyzWZsNOEXxafHtslt6p0
 2zmw==
X-Gm-Message-State: AOJu0Yw4Ixo7xpt93iQoyRJlscQv3HL3IOpq9+SQCZ+yTIpBPgCuP++d
 aLsubCza0P+pLlHEFwmP5zHoNg==
X-Google-Smtp-Source: AGHT+IFJclQBRju4Yfb0oANbjlAToOkFHLfdUnRuelXqobO8O+cqnkzvA4yXNsxbzT53u4xyfYIWCg==
X-Received: by 2002:a9d:7351:0:b0:6d9:f1b4:c560 with SMTP id
 l17-20020a9d7351000000b006d9f1b4c560mr2806299otk.67.1702186248421; 
 Sat, 09 Dec 2023 21:30:48 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 n37-20020a634d65000000b005c21c23180bsm4047061pgl.76.2023.12.09.21.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:30:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:49 +0900
Subject: [PATCH v8 11/19] virtio-net: Report RSS warning at device realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-11-9553ee714d38@daynix.com>
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
In-Reply-To: <20231210-rss-v8-0-9553ee714d38@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x336.google.com
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

Warning about RSS fallback at device realization allows the user to
notice the configuration problem early.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c2cbf39a5f..40beff2262 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1260,10 +1260,12 @@ static bool virtio_net_attach_epbf_rss(VirtIONet *n)
 
     if (!ebpf_rss_set_all(&n->ebpf_rss, &config,
                           n->rss_data.indirections_table, n->rss_data.key)) {
+        error_report("Failed to configure eBPF RSS");
         return false;
     }
 
     if (!virtio_net_attach_ebpf_to_backend(n->nic, n->ebpf_rss.program_fd)) {
+        error_report("Failed to attach eBPF to backend");
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
@@ -3746,10 +3742,14 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
-        !virtio_net_load_ebpf(n) &&
-        get_vhost_net(nc->peer)) {
-        error_setg(errp, "Can't load eBPF RSS for vhost");
-        virtio_net_device_unrealize(dev);
+        !virtio_net_load_ebpf(n)) {
+        if (get_vhost_net(nc->peer)) {
+            error_setg(errp, "Can't load eBPF RSS for vhost");
+            virtio_net_device_unrealize(dev);
+            return;
+        }
+
+        warn_report("Can't load eBPF RSS - fallback to software RSS");
     }
 }
 

-- 
2.43.0


