Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97402B25825
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 02:19:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umLe2-0000QX-QT; Wed, 13 Aug 2025 20:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1umLdt-0000PF-Pc; Wed, 13 Aug 2025 20:16:29 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1umLdk-0005Tg-AX; Wed, 13 Aug 2025 20:16:29 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-323266d38c2so619280a91.0; 
 Wed, 13 Aug 2025 17:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755130566; x=1755735366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3Kmj7EMds+XvdVFyWqM3Z02NVS/rOhSVj2kNVV45YY=;
 b=SUhDvKhbYUYsYJtazGlj6f6NASIWYcFtdkuQ+TX1UW3X+pqugXs+RQTmCucTbagVxA
 bZcrv2UQpHFungzmoUNkIiq4aD+ja0JMMF6suthPpUHhWqxgWaq4nqQiZeQX3fF1PfKm
 YI6zHXmVcI+8h1OAnqV7x5GeINX4mcaf9IpY/BVZlWLHY9p/h6iXOsZAThN6RZ6u7vg2
 BeITf3cxKBC7eB4I+BYYMl/G1MqU6gTKpXJYKgW0JPDE7jsQplmUgb15CwQnFFYDYO08
 UOsnUHkAcbjha+N9EZyttl9y6mlNKIILTOSxH7l0wjY+DbYnkByV1XDRZQVJTM2quzZW
 t2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755130566; x=1755735366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3Kmj7EMds+XvdVFyWqM3Z02NVS/rOhSVj2kNVV45YY=;
 b=nooyP02a0QjJTlIEEuVTWHgNKn1UB1D1lkc0trjy2tyBF8UfA4CTSV5yUc/BE+Yoxh
 2d+lW1Atv0L/9kJ7/QM98uhSyJfSPhYftU5TK97yKmEMfZdpQyaKuKjIElDlZtX9NiHR
 j+Lf5uw/aKMNqcFqlY5EpSFkiwnncnuuor7kzpkQfyMmlCiiP8eism+XDG09dCqYMC6A
 kQVNFoYub7ucFL1kn2JuQrywZooKbab6PHebSukzQMvqA06S3QFu0Myi4FFzc3mc0iAW
 4sJU7mRnr4qya3is3jDuJeEBe/G5e9p8kgsQEonRi9R74utEOaNXYYPnrGigCeC6JeoU
 31hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNn9epWimBNl7/2Aqy7JemziBE2+gxJbtYODpND4GI0kh08HK7wVAXOBw8iiZmJzlC/cAYpbnno52B@nongnu.org
X-Gm-Message-State: AOJu0Yx+p/q0OzyyB9MIE2kuX+Ud4Zb5Wiyfz1b+odfQXXxFr4ISKn9R
 KIjcdIoINDOwVK1OwZocsDXPohqcLjJtcIbbBTQ/ioMJfZwRg/oJNTRE
X-Gm-Gg: ASbGncsuWBxdJUw65YouZrhX3dLLZbsA25Y2c3WLV46TFetk0lewpleUsk+x43lFhL8
 PlI0nC3JZMvRkT+2x3Juf6MpPdGrBGQJMvNa77IaXi+6qMAKmBn2StW2zWXV2/Wz6US8MkN29D+
 NkDjFE3LoKXMakXS8pDd9JBgCerq1K9UbqwXLTudaJa0l1SqlhOCoY2wvGXxIinj+fXhIc22dfg
 xyLZF1rQJ892z19SU6YbylPwE58NizDIT/+2UytSVp+YzA76gKN4eA5wnkki5mNkWJegmseGxUX
 1vxJeyFIrrh8/QD+jfe6QpH6pdKyy9vOipJs649bcBBUwuJHRowawWTFrpOPhBLWlv/5Bt8VN8O
 uDU5fKU213kMjGZWoXUdKhoIl6IU=
X-Google-Smtp-Source: AGHT+IE/NhmxxMt/Ft6BfbS8HcdorI3IoVw6/8Uhhg6gVkvcp4oP6v+TjhNKzurRzscDp7Had7Qa5Q==
X-Received: by 2002:a17:90b:268a:b0:321:87fa:e1e4 with SMTP id
 98e67ed59e1d1-32327996e6emr1849817a91.6.1755130565878; 
 Wed, 13 Aug 2025 17:16:05 -0700 (PDT)
Received: from donnager-debian.. ([203.38.38.6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3232f7445f2sm81768a91.2.2025.08.13.17.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 17:16:04 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2] docs: riscv-iommu: Update status of kernel support
Date: Thu, 14 Aug 2025 09:44:50 +0930
Message-ID: <20250814001452.504510-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.07, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The iommu Linux kernel support is now upstream. VFIO is still
downstream at this stage.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 - Fix VFIO link
 - Fix qemu spelling
---
 docs/specs/riscv-iommu.rst | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
index 991d376fdc24..571a6a6cc963 100644
--- a/docs/specs/riscv-iommu.rst
+++ b/docs/specs/riscv-iommu.rst
@@ -30,15 +30,15 @@ This will add a RISC-V IOMMU PCI device in the board following any additional
 PCI parameters (like PCI bus address).  The behavior of the RISC-V IOMMU is
 defined by the spec but its operation is OS dependent.
 
-As of this writing the existing Linux kernel support `linux-v8`_, not yet merged,
-does not have support for features like VFIO passthrough.  The IOMMU emulation
-was tested using a public Ventana Micro Systems kernel repository in
-`ventana-linux`_.  This kernel is based on `linux-v8`_ with additional patches that
-enable features like KVM VFIO passthrough with irqbypass.  Until the kernel support
-is feature complete feel free to use the kernel available in the Ventana Micro Systems
-mirror.
-
-The current Linux kernel support will use the IOMMU device to create IOMMU groups
+Linux kernel iommu support was merged in v6.13. QEMU IOMMU emulation can be
+used with mainline kernels for simple IOMMU PCIe support.
+
+As of v6.17, it does not have support for features like VFIO passthrough.
+There is a `VFIO`_ RFC series that is not yet merged. The public Ventana Micro
+Systems kernel repository in `ventana-linux`_ can be used for testing the VFIO
+functions.
+
+The v6.13+ Linux kernel support uses the IOMMU device to create IOMMU groups
 with any eligible cards available in the system, regardless of factors such as the
 order in which the devices are added in the command line.
 
@@ -49,7 +49,7 @@ IOMMU kernel driver behaves:
 
   $ qemu-system-riscv64 \
         -M virt,aia=aplic-imsic,aia-guests=5 \
-        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        -device riscv-iommu-pci,addr=1.0 \
         -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
         -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
         (...)
@@ -58,21 +58,11 @@ IOMMU kernel driver behaves:
         -M virt,aia=aplic-imsic,aia-guests=5 \
         -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
         -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
-        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        -device riscv-iommu-pci,addr=3.0 \
         (...)
 
 Both will create iommu groups for the two e1000e cards.
 
-Another thing to notice on `linux-v8`_ and `ventana-linux`_ is that the kernel driver
-considers an IOMMU identified as a Rivos device, i.e. it uses Rivos vendor ID.  To
-use the riscv-iommu-pci device with the existing kernel support we need to emulate
-a Rivos PCI IOMMU by setting 'vendor-id' and 'device-id':
-
-.. code-block:: bash
-
-  $ qemu-system-riscv64 -M virt	\
-     -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1 (...)
-
 Several options are available to control the capabilities of the device, namely:
 
 - "bus": the bus that the IOMMU device uses
@@ -84,6 +74,7 @@ Several options are available to control the capabilities of the device, namely:
 - "g-stage": enable g-stage support
 - "hpm-counters": number of hardware performance counters available. Maximum value is 31.
   Default value is 31. Use 0 (zero) to disable HPM support
+- "vendor-id"/"device-id": pci device ID. Defaults to 1b36:0014 (Redhat)
 
 riscv-iommu-sys device
 ----------------------
@@ -111,6 +102,6 @@ riscv-iommu options:
 
 .. _iommu1.0.0: https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0.0/riscv-iommu.pdf
 
-.. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
+.. _VFIO: https://lore.kernel.org/linux-riscv/20241114161845.502027-17-ajones@ventanamicro.com/
 
 .. _ventana-linux: https://github.com/ventanamicro/linux/tree/dev-upstream
-- 
2.47.2


