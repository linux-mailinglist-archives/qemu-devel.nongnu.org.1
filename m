Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D99969F2E8F
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Dec 2024 11:52:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN8h7-0004NW-S9; Mon, 16 Dec 2024 05:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tN8h3-0004Ll-KH
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tN8h2-0005QR-3d
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734346274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1EA3zxXos502LtgsWMd6Ob6LJRsWVtues3Dl//blLqc=;
 b=UPLsaZnkwe3mtTpw58HC0peNfNedIqrL4AVzdRVRMvTctxatVzVhkivmlZSNy8BnhT5dJW
 eYHOd/BsKwE7Yd3kcYStoP0Kp3pxbbMsQej3Om8B32Smq+gkXG1BPYryMoDlSUB+JTlK/L
 3xt6rvUUa0CzcfVpiGYj/XKqwPEodEw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-gePYdYmcP36xX4tYXtpCow-1; Mon,
 16 Dec 2024 05:51:09 -0500
X-MC-Unique: gePYdYmcP36xX4tYXtpCow-1
X-Mimecast-MFC-AGG-ID: gePYdYmcP36xX4tYXtpCow
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 220CA19560B6; Mon, 16 Dec 2024 10:51:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.88])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3E9119560A7; Mon, 16 Dec 2024 10:51:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1E7721800601; Mon, 16 Dec 2024 11:50:54 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PULL 6/7] pc-bios: add missing riscv64 descriptor
Date: Mon, 16 Dec 2024 11:50:52 +0100
Message-ID: <20241216105053.246204-7-kraxel@redhat.com>
In-Reply-To: <20241216105053.246204-1-kraxel@redhat.com>
References: <20241216105053.246204-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Without descriptor libvirt cannot discover the EDK II binaries via
the qemu:///system connection.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Message-ID: <20241212090059.94167-1-heinrich.schuchardt@canonical.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 pc-bios/descriptors/60-edk2-riscv64.json | 31 ++++++++++++++++++++++++
 pc-bios/descriptors/meson.build          |  3 ++-
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/descriptors/60-edk2-riscv64.json

diff --git a/pc-bios/descriptors/60-edk2-riscv64.json b/pc-bios/descriptors/60-edk2-riscv64.json
new file mode 100644
index 000000000000..14811ca307f6
--- /dev/null
+++ b/pc-bios/descriptors/60-edk2-riscv64.json
@@ -0,0 +1,31 @@
+{
+    "description": "UEFI firmware for riscv64",
+    "interface-types": [
+        "uefi"
+    ],
+    "mapping": {
+        "device": "flash",
+        "executable": {
+            "filename": "@DATADIR@/edk2-riscv-code.fd",
+            "format": "raw"
+        },
+        "nvram-template": {
+            "filename": "@DATADIR@/edk2-riscv-vars.fd",
+            "format": "raw"
+        }
+    },
+    "targets": [
+        {
+            "architecture": "riscv64",
+            "machines": [
+                "virt*"
+            ]
+        }
+    ],
+    "features": [
+
+    ],
+    "tags": [
+
+    ]
+}
diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.build
index afb5a959ccf4..cdd0be01a356 100644
--- a/pc-bios/descriptors/meson.build
+++ b/pc-bios/descriptors/meson.build
@@ -6,7 +6,8 @@ if unpack_edk2_blobs and get_option('install_blobs')
     '60-edk2-arm.json',
     '60-edk2-i386.json',
     '60-edk2-x86_64.json',
-    '60-edk2-loongarch64.json'
+    '60-edk2-loongarch64.json',
+    '60-edk2-riscv64.json'
   ]
     configure_file(input: files(f),
                    output: f,
-- 
2.47.1


