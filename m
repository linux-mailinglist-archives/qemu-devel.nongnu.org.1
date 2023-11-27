Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7C57F986E
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:38:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7TN6-0000bM-0v; Sun, 26 Nov 2023 23:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7TN0-0000aY-FJ; Sun, 26 Nov 2023 23:37:18 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r7TMz-0001GU-0q; Sun, 26 Nov 2023 23:37:18 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3b58d96a3bbso2317347b6e.1; 
 Sun, 26 Nov 2023 20:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701059834; x=1701664634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VOgRNpZvdVvAGbxkTra1OPfsf10qYyzqF/NLqWPBLM4=;
 b=BxIAcsAscwFHBlcT00I6aVl0CemKvLcf7TdoDceymCYRcv4mUI++WYUJGgFBfOMN0q
 4P5O1HoZs7A4w7u25bY8mBLLFA9P7swJABRh41Au6hNFtVYiuapRjS2ic7lYg3+FInL3
 cOTiXZNFSrrT51Kc816B2ABw5hoHQlWK4C8/XDPvi4CffwjO2ArPS4RuiLcbG32wwqfT
 fJc51gq47pOy9JCilTL+F8rObonjZU4Ri2ZIcFWh4ht4zckdlw8RaQZXty/IPs9oYD3z
 zbW83ircbHLVOQUlupAhdlZWS2CXTGa32Ufc4akNrKrIUSAGtLTjff6llWfcxijtnqu/
 2Q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701059834; x=1701664634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VOgRNpZvdVvAGbxkTra1OPfsf10qYyzqF/NLqWPBLM4=;
 b=GO2hwkD4Cdw3Xm9GFQHf4vDtnIBwSHzgy5c5hblzDg7X0mI6ofFo6KXBP3Y4hsysQ/
 6THAY9ekLSVHE6DNa5s9m2p2G3PEuAi0ySCxMJtsY6PoHxalvSdMKoLEsvMsqFszQa6M
 KPeh4RNBvQv9qfPcJFDwXOEvLOy8pkI/FurpllZtU+CDVztaGPMWtvSeFgjTH7GYzCig
 ROH9AOMe8Ux3aQQYx3qDbCBvS1/ZAX5soZaao/ffljVHqyTEkF2eRUumL85AOzycx0rO
 UVgEPdZ44vaB399a45F4aVJdPcqjPYmWlGBGL4Sif3Ovo5lnZk/FYW3dxnzL5iZni7lj
 cnzg==
X-Gm-Message-State: AOJu0Yz6Op/jBLB8tGCjRqFA3RDk5VCusYZTMMbNIZYQb0IgM1UtJWNK
 vNSaBIhXbT3WWtL1CazLXf8SUpASCk+v6z52
X-Google-Smtp-Source: AGHT+IEW/qYf3rdBaZAauHJ2jDhFts8YlnNFcBKCO32b6n/JUE0LyXb1Ik9dhgUL0YmUIQA3PWr11w==
X-Received: by 2002:a05:6808:13d5:b0:3b2:e577:7344 with SMTP id
 d21-20020a05680813d500b003b2e5777344mr14869031oiw.38.1701059834019; 
 Sun, 26 Nov 2023 20:37:14 -0800 (PST)
Received: from fedlinux.. ([106.84.128.244]) by smtp.gmail.com with ESMTPSA id
 u15-20020a62ed0f000000b006c4d86a259csm6280070pfh.28.2023.11.26.20.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 20:37:13 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v6 1/4] docs/qcow2: add the zoned format feature
Date: Mon, 27 Nov 2023 12:37:00 +0800
Message-Id: <20231127043703.49489-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127043703.49489-1-faithilikerun@gmail.com>
References: <20231127043703.49489-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=faithilikerun@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add the specs for the zoned format feature of the qcow2 driver.
The qcow2 file then can emulate real zoned devices, either passed
through by virtio-blk device or NVMe ZNS drive to the guest
given zoned information.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/system/qemu-block-drivers.rst.inc | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 105cb9679c..955fea271e 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -172,6 +172,41 @@ This section describes each format and the options that are supported for it.
     filename`` to check if the NOCOW flag is set or not (Capital 'C' is
     NOCOW flag).
 
+  .. option:: zone.mode
+    If this is set to ``host-managed``, the image is an emulated zoned
+    block device. This option is only valid to emulated zoned device files.
+
+  .. option:: zone.size
+
+    The size of a zone in bytes. The device is divided into zones of this
+    size with the exception of the last zone, which may be smaller.
+
+  .. option:: zone.capacity
+
+    The initial capacity value, in bytes, for all zones. The capacity must
+    be less than or equal to zone size. If the last zone is smaller, then
+    its capacity is capped.
+
+    The zone capacity is per zone and may be different between zones in real
+    devices. QCow2 sets all zones to the same capacity.
+
+  .. option:: zone.conventional_zones
+
+    The number of conventional zones of the zoned device.
+
+  .. option:: zone.max_open_zones
+
+    The maximal allowed open zones.
+
+  .. option:: zone.max_active_zones
+
+    The limit of the zones with implicit open, explicit open or closed state.
+
+  .. option:: zone.max_append_bytes
+
+    The number of bytes in a zone append request that can be issued to the
+    device. It must be 512-byte aligned.
+
 .. program:: image-formats
 .. option:: qed
 
-- 
2.40.1


