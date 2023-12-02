Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA6B801B4B
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:02:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9KwH-0004QZ-I4; Sat, 02 Dec 2023 03:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kw3-0004OM-26
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:16 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kw0-00052w-9g
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:09 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so1089614a12.1
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504066; x=1702108866;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QAYyku7fpNHviK5U06HOAT5ynzSeWxO3H+3lWwncrV4=;
 b=qUFIsiUp6Y3uh4yKdTiP2+gKEWCENTYo5QfR0oeoy1sgLBrGE7Sm/Qq3Sh6HHlNzOd
 qq0+OLsYsrhrJunmujtbwtcQARzj1FZWHuKg7iJ17X2EMv7ngwibPe4CKbPE19CDFtBW
 jROgJW1toANYjK60lzF8jV2X33mpGDuORzoFSh1foqdeEu5AGsdfnBM94xSgFTCmUWnZ
 cYvL2gR3ELqgCkQCeanrhkb+I1KmDaZN0KLPy0hC1OIE1ng6JpnT5OyCC0CpaxJPfKzB
 rC4Rd484Vw1PSp/T5Nu4b78VcEmv9gPeImjpHmx3Y0iQcRKBwtgPwgaj9yc2suKnnFYD
 xnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504066; x=1702108866;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QAYyku7fpNHviK5U06HOAT5ynzSeWxO3H+3lWwncrV4=;
 b=OJxJqGFwdLcpz/qywvOLOCQQEbfVaUAwxQivGpvqmKc/UjGo+ZUxdm5cqLS9jEuMYW
 1AUvnzyluRUahVleXJPfm3KxTsy0CWgbnsMjeQkCMeoAGb1OBS+H/yTs810STWe9+8/Q
 crLOv0Ujjn+Wp5Dn/cv1nf9UQZgYKdVyVKV2yniW5QA7xvpfNbYUwItMdQyVcb9BSBEn
 kYG+Hy2dK3uxqswZZ4RyGauofc5S+x7aBeAACOpuJ00rGMHVLvFkmP68iBh7W4DmHW1j
 fG91ZznijQT5sPUwqw6wAJIskJjrF1oAoIQBhw9SVCeQ8Z8/Sr7wd7T87DdsVNAIA+KF
 hgcQ==
X-Gm-Message-State: AOJu0YxK4yvafq4FmULXomB9LeKLOO9vUvOm/Rsp034XHI2PG5YsoRp8
 k4SJ+rrBsayOwyMThL5nO/DyxQ==
X-Google-Smtp-Source: AGHT+IGLq2bSgHxf58UrE0lvYBapyzTh027hMmhqiPI1/drn5SiKHXxA+Se68P/X9gJozXldZFjYkg==
X-Received: by 2002:a17:902:f2d2:b0:1d0:6ffd:e2bc with SMTP id
 h18-20020a170902f2d200b001d06ffde2bcmr672433plc.86.1701504065688; 
 Sat, 02 Dec 2023 00:01:05 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 13-20020a170902c20d00b001cc2f9fd74csm2386885pll.189.2023.12.02.00.01.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:01:05 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:30 +0900
Subject: [PATCH 07/14] hw/pci: Add hide()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-7-32b3570f7bd6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x531.google.com
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

hide() can be implemented to prevent creating a PCI device and get
device options.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h | 2 ++
 hw/pci/pci.c                | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index a7bfb192e8..deae29f070 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -29,6 +29,8 @@ DECLARE_CLASS_CHECKERS(PCIFailoverClass, PCI_FAILOVER, TYPE_PCI_FAILOVER)
 struct PCIDeviceClass {
     DeviceClass parent_class;
 
+    bool (*hide)(PCIDeviceClass *pc, const QDict *device_opts, bool from_json,
+                 Error **errp);
     void (*realize)(PCIDevice *dev, Error **errp);
     PCIUnregisterFunc *exit;
     PCIConfigReadFunc *config_read;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 3d07246f8e..67d8ae3f61 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2054,11 +2054,19 @@ PCIDevice *pci_find_device(PCIBus *bus, int bus_num, uint8_t devfn)
 static bool pci_qdev_hide(DeviceClass *dc, const QDict *device_opts,
                           bool from_json, Error **errp)
 {
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(dc);
     const char *standby_id;
     DeviceState *dev;
     ObjectClass *class;
     ObjectClass *interface;
 
+    if (pc->hide) {
+        bool hide = pc->hide(pc, device_opts, from_json, errp);
+        if (hide || *errp) {
+            return hide;
+        }
+    }
+
     if (!device_opts) {
         return false;
     }

-- 
2.43.0


