Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F480B8CC
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 05:08:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCB6Y-00061W-3P; Sat, 09 Dec 2023 23:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB61-0005fF-Vt
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:07:18 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5x-0005tL-EU
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:07:13 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5c690c3d113so2805239a12.1
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 20:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702181228; x=1702786028;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xu544O3EFIYwNRJ2cJOKb9/B0TPA8YFLx9eseZtIzOs=;
 b=NR02RYHDW0rSk1/QW6X++tFM8GIVaUyP6gb9xtv1+U8cms/FGEpiIHmx/pmS9r4yNG
 t1qX3UYLvjwzzOQ7S4idGcGV5ABTYE3sqHVXKYShPLO6g7R31aR1qcu7oHtr9HYFlniR
 iVOxNnxFs3uVMnhn8b4gKW8QDHPu1ppQSEi8frrmq9o9CpHaWCQPsJr07Pk5ICMdDQxc
 27K4Ip12k11CeRpvanXYgjsrRJzOoi/xxJUTjzrmbu7C1CBgZZRTBxtJutfTfop0zt+w
 9hqGGdcnTtA+xWJ2ryniXm4n6pCSX0s3Q3QV5AP3R/pOVif3XpkriV7xY3J05jqgqyw3
 kpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702181228; x=1702786028;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xu544O3EFIYwNRJ2cJOKb9/B0TPA8YFLx9eseZtIzOs=;
 b=SbcskKp2HfBGxiesZEZIMtq2XzvM05c+qa2xiPx+QBnd+oa1T++J/pwXA97tSFdkju
 XeuG6BkfdCbUkCtZZ4NvV0fFV/moZioAWvAdoWCJ6+6JQFpYKdo4iWyCq6OtHf5Wd2T0
 uAgiwHZ4kmSfrDdIR4+W4Uaqp54fLPJoI7vUuTOjzIlYDM4YW/nHaOHmP87iMUIyDk07
 ZnO2KzMv966bcUhns00ln8BtTvabVT9wJxeGVeQc/ud22XmHEssgturinTbxLRU5HI1r
 oA6kC/L1NJ4463vxp1JXOIoTPlv+FHNuWMTtR83yN2NZGpAxY70iRcDjDTeafZUrElXb
 ealw==
X-Gm-Message-State: AOJu0Yw508D8kQ94Wd6jyG4Yjtyagx7CyeM0Rl1cTaLPJdmkmmJRSc/3
 ilzoKVNXv9b4Oa51j/ZBMUFvqw==
X-Google-Smtp-Source: AGHT+IHsBWil12yImCbrshsSC17Qfia77tREzJCey6r8WLJvcM4JzQyAjfHKUJTnJ7/pz7BoHmgA4g==
X-Received: by 2002:a17:902:7d8a:b0:1d2:eb05:9d05 with SMTP id
 a10-20020a1709027d8a00b001d2eb059d05mr2193855plm.90.1702181228066; 
 Sat, 09 Dec 2023 20:07:08 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 x2-20020a170902ea8200b001d0a0dd7d51sm4143705plb.48.2023.12.09.20.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 20:07:07 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 13:05:55 +0900
Subject: [PATCH RFC v2 12/12] virtio-net: Implement SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-sriov-v2-12-b959e8a6dfaf@daynix.com>
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
In-Reply-To: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
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

A virtio-net device can be added as a SR-IOV VF to another virtio-pci
device that will be the PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/virtio-net-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index e03543a70a..dba4987d6e 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -75,6 +75,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_VIRTIO_NET;
     k->revision = VIRTIO_PCI_ABI_VERSION;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
+    k->sriov_vf_user_creatable = true;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     device_class_set_props(dc, virtio_net_properties);
     vpciklass->realize = virtio_net_pci_realize;

-- 
2.43.0


