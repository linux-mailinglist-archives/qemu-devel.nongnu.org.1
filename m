Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F5E737555
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:49:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIb-0008JL-0M; Tue, 20 Jun 2023 15:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7X-0004Fi-Eb
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:24 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7U-0006cT-Ml
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:23 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-56fff21c2ebso53779727b3.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281979; x=1689873979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ketisDiBHbRbLfAtb4owX6CirSCgZ560hstWukEHPU=;
 b=JV7mVW9o+DEfW49UhY6Ry0LlDSYnubxQvhH/85RSPJPv5iznjafVvKwT0WTw80NIHH
 ZzVJZ4uxnp6Hy9ouHIKN/+dUXz8k7PgDunBleGVEfPS4AGMqIIn0cN0bzuYyHyjXJt9S
 c4qjaIg4M+xIfnZlwwTV4j2h2oPsNsgCab9w5IYYB7RNikhwoAkZ7HPMhFE+Y/J6GhHn
 vL5uSRHMD7mxu/Qe0WvnyIcUII9xycI5IylaW7/BSTgK9RIqaXATKHTUBh9mjIBw2MUY
 jqGFkFdOXhXlpkyJu+qAZTjJsClrW1bOrRSiDbVFLiEPjs4JJdZo6525f4dH3VxIWXDR
 yNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281979; x=1689873979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ketisDiBHbRbLfAtb4owX6CirSCgZ560hstWukEHPU=;
 b=g+KqP7IhY++WjeEnQ0Bt+FU4CKKydzkC9Zgz2xU7Hhv4cWYIKWvvwNXg0zGObsfLfk
 zjoe+WTuBxUT225hmu/foGZF0jlRany6pxjy9+MFduw1RWOzR7o4xbsYibTgcpqd+8jU
 gpbvp6m5y9zQ/EhwUpsWnCkEm9uzO1/im7UrV5zUwFU/XS8xiNh1DkRqe8L4fRajtXiH
 xSd3g+e2okbYMug/b1LpnyJblT/mZGVi2B/nHjWrVBybY1XSV9e7JVS32+ZLYEpHcaVp
 A3bplH4YG6FDf11hAKbgOrCHwdTowWNdx///n4W9xdZvA314ZZISgtHsfTbrXyeSaJey
 KgBA==
X-Gm-Message-State: AC+VfDzLSzToVkA3tswF8XLZxrqXEMv+oY8Mx9r1XeclUG+IHPczqQdA
 zH1HFZtOe10ZaVovy1A/lufSbpk0eSEAjQ==
X-Google-Smtp-Source: ACHHUZ7Sy8MslonVrUjxUdWKSpd6ukF5+zxv5os2k+6NK3tmmIpKUWxcbVfweJ393p1b0WLmoKTnJw==
X-Received: by 2002:a0d:e447:0:b0:565:99c0:a690 with SMTP id
 n68-20020a0de447000000b0056599c0a690mr12747083ywe.36.1687281979267; 
 Tue, 20 Jun 2023 10:26:19 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:18 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v1 12/23] xen/pt: allow to hide PCIe Extended Capabilities
Date: Tue, 20 Jun 2023 13:24:46 -0400
Message-Id: <c8295fdebb40f9c5c2af6db8ed9451e4897dbb5c.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=jupham125@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:54 -0400
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

We need to hide some unwanted PCI/PCIe capabilities for passed through
devices.
Normally we do this by marking the capability register group
as XEN_PT_GRP_TYPE_HARDWIRED which exclude this capability from the
capability list and returns zeroes on attempts to read capability body.
Skipping the capability in the linked list of capabilities can be done
by changing Next Capability register to skip one or many unwanted
capabilities.

One difference between PCI and PCIe Extended capabilities is that we don't
have the list head field anymore. PCIe Extended capabilities always start
at offset 0x100 if they're present. Unfortunately, there are typically
only few PCIe extended capabilities present which means there is a chance
that some capability we want to hide will reside at offset 0x100 in PCIe
config space.

The simplest way to hide such capabilities from guest OS or drivers
is faking their capability ID value.

This patch adds the Capability ID register handler which checks
- if the capability to which this register belong starts at offset 0x100
  in PCIe config space
- if this capability is marked as XEN_PT_GRP_TYPE_HARDWIRED

If it is the case, then a fake Capability ID value is returned.

Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/xen/xen_pt.c | 11 ++++++++++-
 hw/xen/xen_pt.h |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index f757978800..2399fabb2b 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -164,7 +164,16 @@ static uint32_t xen_pt_pci_read_config(PCIDevice *d, uint32_t addr, int len)
     reg_grp_entry = xen_pt_find_reg_grp(s, addr);
     if (reg_grp_entry) {
         /* check 0-Hardwired register group */
-        if (reg_grp_entry->reg_grp->grp_type == XEN_PT_GRP_TYPE_HARDWIRED) {
+        if (reg_grp_entry->reg_grp->grp_type == XEN_PT_GRP_TYPE_HARDWIRED &&
+            /*
+             * For PCIe Extended Capabilities we need to emulate
+             * CapabilityID and NextCapability/Version registers for a
+             * hardwired reg group located at the offset 0x100 in PCIe
+             * config space. This allows us to hide the first extended
+             * capability as well.
+             */
+            !(reg_grp_entry->base_offset == PCI_CONFIG_SPACE_SIZE &&
+            ranges_overlap(addr, len, 0x100, 4))) {
             /* no need to emulate, just return 0 */
             val = 0;
             goto exit;
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index eb062be3f4..9a191cbc8f 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -93,6 +93,10 @@ typedef int (*xen_pt_conf_byte_read)
 
 #define XEN_PCI_INTEL_OPREGION 0xfc
 
+#define XEN_PCIE_CAP_ID 0
+#define XEN_PCIE_CAP_LIST_NEXT 2
+#define XEN_PCIE_FAKE_CAP_ID_BASE 0xFE00
+
 #define XEN_PCI_IGD_DOMAIN 0
 #define XEN_PCI_IGD_BUS 0
 #define XEN_PCI_IGD_DEV 2
-- 
2.34.1


