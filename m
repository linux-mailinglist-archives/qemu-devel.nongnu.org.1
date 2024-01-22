Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1894A8370BD
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 19:49:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzM4-00087a-1s; Mon, 22 Jan 2024 13:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzLl-00084N-UP; Mon, 22 Jan 2024 13:48:51 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzLh-0007sv-V8; Mon, 22 Jan 2024 13:48:48 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a308db01df6so83119366b.0; 
 Mon, 22 Jan 2024 10:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705949322; x=1706554122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Keyekl1LXkor50exZE9URgZG7zjcN4gFFMZ2GsK0vo=;
 b=XDdmzkl0ittwAN5bcr2Jc7TWEkDUPS9EAsNiv3ak+tkkngJrv6Ewlir1gycgqi7ixS
 Mk6Ydu7LdQPdpvUP22B0+A7mmYwDltcIree1zA0sPWWuUlZ31gaXXuXDHxVGF1KqlS1l
 KN92g+uJfUYDJt1IkEDXkbAvAH3BU0XhadUT9cAFWbJys4P1LzQTo1Kc0rwPhkMlKzCl
 ZWJgem2TiP8xF0G9kfVrqwI0te5b25auwX1g4F8D+35wh8GHbVaZU+hJX5FXUNI6izj3
 6Mecf1tgi3ktRMbxbjpPh/QyzDVLFUbDcf2mlVqGDSHefQS/xEBzF+TJ7O9jwxOFM/lB
 uBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705949322; x=1706554122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Keyekl1LXkor50exZE9URgZG7zjcN4gFFMZ2GsK0vo=;
 b=aN15T/qZbMecLeYK5nUnm2kweM63D7/fD+60Seydsi2U0UMrdrOqkTTFM+RoF05937
 muScsIzsNznfhzl9O18NI2eP5hjS4yE3e2BC+cYqKTlO6SeCf/0hL2tGSr6jaehoL4OL
 T1j1lL+SbbnJf5hCeolidmpMaS2ZE5QiOngR8q2eIdo2eB4PSirTuLuBVl+Km+tWqdjz
 vp66xv7k8+TU5zh7bTxAN029bbe07VM0qfE/MDmL3HcRXSxj28xOO4ufS/hRE4qeJFxp
 JZtPIDP2SGcY8snDXBjMN4DNKMPiBHXYoBw/nqMJoX/mRBVGQZV2SluGe1eUpB11aLAr
 2a4g==
X-Gm-Message-State: AOJu0Yw2NPUG5BTMKQk4i6VM3H24fkstZqwU6O5sDg3Ef0g+URO3boNU
 yCwMMiKbG/om5J6vk+qbwFXx+FMYTXlY57/r2gpQ/nFs+hgIbFTdvZL8ZDyC79M=
X-Google-Smtp-Source: AGHT+IEC40AIlI3DvMlTkxZj3hhbYd7eqJk6NElqWxwerBb1k3AvSmcd6hwXK8xXxHpO3ST57oKE0A==
X-Received: by 2002:a17:907:b9c3:b0:a28:d32f:ecb1 with SMTP id
 xa3-20020a170907b9c300b00a28d32fecb1mr1195242ejc.75.1705949321744; 
 Mon, 22 Jan 2024 10:48:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:2454:367:1500:fa08:d4d:b569:ac2d])
 by smtp.gmail.com with ESMTPSA id
 en4-20020a17090728c400b00a282c5a3143sm13686908ejc.88.2024.01.22.10.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 10:48:41 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, hare@suse.de,
 Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v7 1/4] docs/qcow2: add the zoned format feature
Date: Mon, 22 Jan 2024 19:48:27 +0100
Message-Id: <20240122184830.40094-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122184830.40094-1-faithilikerun@gmail.com>
References: <20240122184830.40094-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x629.google.com
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
 docs/system/qemu-block-drivers.rst.inc | 42 ++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
index 105cb9679c..4db19b61ae 100644
--- a/docs/system/qemu-block-drivers.rst.inc
+++ b/docs/system/qemu-block-drivers.rst.inc
@@ -172,6 +172,48 @@ This section describes each format and the options that are supported for it.
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
+  .. option:: zone.max_active_zones
+
+    The limit of the zones with implicit open, explicit open or closed state.
+
+    The max active zones must be less or equal to the number of SWR
+    (sequential write required) zones of the device.
+
+  .. option:: zone.max_open_zones
+
+    The maximal allowed open zones. The max open zones must not be larger than
+    the max active zones.
+
+    If the limits of open zones or active zones are equal to the number of
+    SWR zones, then it is the same as having no limits.
+
+  .. option:: zone.max_append_bytes
+
+    The number of bytes in a zone append request that can be issued to the
+    device. It must be 512-byte aligned and less than the zone capacity.
+
 .. program:: image-formats
 .. option:: qed
 
-- 
2.40.1


