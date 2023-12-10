Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2791C80B8CD
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 05:08:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCB5q-0005Xz-Pn; Sat, 09 Dec 2023 23:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5m-0005XS-FC
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:58 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5j-0005WI-TI
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:58 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-59067f03282so1847453eaf.0
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 20:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702181214; x=1702786014;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=COhlOMuqAZTZiov08lDQfsiw4tBT53dAEaOcH/oormY=;
 b=SPH5imc04sPStnm9aOeclRhJjVJg//IONl5NUs3r+yEBZaoCyJz3+Zj14y+yBiISLf
 lrILJB8D3LX0tm1I/0wSytURSHvG3zMCs/fbyrykbtp1vZtKmqsAPtZacE0NzgI68hkq
 uNMmOWuJNZAgtaQyjmY2xmSkhUbfUvG2f5F3PuCNvNhRfwID0EroqVigwj2XFagO2Xr/
 pz9sCoLc6hDcu2Mlm60iA1McByNjZaOhw0M8pZ0V1bpARkIqzVu9wNRGWb2PMxIW124z
 fprWdjKvmTCjE9Mbdj40UVef80Md6CkgnnW4Gi8YU8huxukgm5XJ+KAnbu/UhXK4smQA
 7FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702181214; x=1702786014;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=COhlOMuqAZTZiov08lDQfsiw4tBT53dAEaOcH/oormY=;
 b=Xk7gZoXokVm9AZ+UZC/Vh//5uUPIYCaE2lMBXJi5uAquCUDU/nxRvHcR3gHDt3YFP7
 D2s+78D8dWqMTtRX2wexuVrcOlHMD3qFwUcL0ATlabZpdUfirsUd3sU6xN6w1EAhB+B3
 gp/j5xV4VDav/bSRCpK0F3N3ORw9l6CSm+zNO3FzHUh5f+Heaf4RikW/lYveuZ0M/YJ7
 xmDtJbpcc33PHejWo1iI6/c8SDmLJsfwsIM3DT2hnDwAAn447UrsnzMjeKWCzGW3hIvz
 DPquAREEfo6pv3yVHnNI3ddkW4yTLea6GkL+KvRJyc/osZqlE8apkNtKMQhki29j30YX
 35hg==
X-Gm-Message-State: AOJu0Yx6tPyYDFsH8XCGJnvy4+IkI/8ewPkdgQ50JiGH99R/XNQ2Zh3A
 UABENJVkxBXRliKQGkcN7fLIXg==
X-Google-Smtp-Source: AGHT+IGqHwL3efw/4tRWevbkqOfR3RA1NrZUQfu/QzJsk++6fLjQFXQ9v30al6iT7aK1c7IinDK8ug==
X-Received: by 2002:a05:6358:cd15:b0:16e:29cf:33b3 with SMTP id
 gv21-20020a056358cd1500b0016e29cf33b3mr2615267rwb.30.1702181214199; 
 Sat, 09 Dec 2023 20:06:54 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 w4-20020aa78584000000b006ce5c583c89sm4062831pfn.15.2023.12.09.20.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 20:06:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 13:05:52 +0900
Subject: [PATCH RFC v2 09/12] pcie_sriov: Check PCI Express for SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-sriov-v2-9-b959e8a6dfaf@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::c36;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc36.google.com
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

SR-IOV requires PCI Express.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 160dfc84ec..8272916cf3 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -46,6 +46,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
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
2.43.0


