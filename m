Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E32FC930D7F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jul 2024 07:20:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTE8P-0008Oe-Db; Mon, 15 Jul 2024 01:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE82-0008FB-UK
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:20:06 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE80-0007Sg-SW
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:20:02 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7669d62b5bfso2226314a12.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721020799; x=1721625599;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eIrCsb1ntTQZ4u2QiCIc/D2bj4QGskaeiB3kw7Zorrg=;
 b=ncqbhm6eHRDzmRZflRXi7eqrkjbrD+Dl88qNh/oUrlWzjVVyyF3N1u1oiClj/K7SF8
 q7yAm15R43pxUSfMukKWSvivYgBjs7trccqT25Pjex0OImxO7dZCdPOyHpjTh/SnC2pP
 9YNmo0LI+71W0keNAZS7y3QMI8scdNxE6tYIXQp5HsPa6cl881mN1EkaMomv43cmY8PD
 mf4mVBkozz1G4K4lz5b86lecZXzb+/xSBduzB5EBhCanuTeNJP0HNpBCp4zVWxJkY94q
 ma53AT9IN/l74t/d8/SwA70IfBAFN1T/fI2COlbuTWj4nrx3GfAcpo2T3nhGZnIJ4KRj
 Lu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721020799; x=1721625599;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eIrCsb1ntTQZ4u2QiCIc/D2bj4QGskaeiB3kw7Zorrg=;
 b=HILa0o0v67vE0jxubSOQAwu6TFWUnoLvJLrxGh1HdQbTEzd3Cv3cwxXr28gnBDDE3n
 4y6oTNReTBrlOaJKuYk+zdXQJZV9xs3FfSipuOzngZitkRzJdwSeUBaqsgQUd6ZLqrFk
 PoRZ+xQJVwG6cj/JpGqop4l3dYwAW/HMNNcpvXDGSlbF6Jb5fHv1pQTjXUi4H2DLSaSD
 YZU45zVfOCuerW5zFOBySeQEhzpFVzMcCQvAKB6fB9oNr8GkIrKXamu7Rahb/IXbvKVf
 8UL+AAKa0ywN25sYlWeY4SOlfY8LQgK782YSlhxjh9LYb6KYDDCuNlarV+fc5XAAMPPu
 B4Hg==
X-Gm-Message-State: AOJu0YxePa2s+C3w9c2M/XuNDC7dq7C6ajPrBjPhe6peSXMAraVVDfQN
 WH5vtnOpofAMbDyV7bUNEo5wB4L2pS8GxnCZ4M+d68TJ5j0QjtRzIZ96SsIw8dc=
X-Google-Smtp-Source: AGHT+IFib7LEFM18p1VEiwK50F5jIM8zxzKC7ZaQb9YCDW0n1iSyWhpeQ8eQ4kfcat+6QasdswQ2zw==
X-Received: by 2002:a05:6a20:7b2a:b0:1c2:8f07:579e with SMTP id
 adf61e73a8af0-1c2984d7835mr14019965637.52.1721020798928; 
 Sun, 14 Jul 2024 22:19:58 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2cacd3e5a87sm5430253a91.14.2024.07.14.22.19.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:19:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jul 2024 14:19:10 +0900
Subject: [PATCH v5 4/8] pcie_sriov: Check PCI Express for SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-sriov-v5-4-3f5539093ffc@daynix.com>
References: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
In-Reply-To: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

SR-IOV requires PCI Express.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index ec8fc0757b92..3af0cc7d560a 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (!pci_is_express(dev)) {
+        error_setg(errp, "PCI Express is required for SR-IOV PF");
+        return false;
+    }
+
     if (pci_is_vf(dev)) {
         error_setg(errp, "a device cannot be a SR-IOV PF and a VF at the same time");
         return false;

-- 
2.45.2


