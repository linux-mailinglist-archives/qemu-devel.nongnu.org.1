Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB0873753F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:46:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIh-0008Sp-7G; Tue, 20 Jun 2023 15:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7h-0004Vf-9f
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:33 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7f-0006fr-38
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:33 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-57045429f76so52288637b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281989; x=1689873989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A524XPsKBXV8yIUUkONAn98uAFCiKVTYyMvCRnHwi2c=;
 b=iQ/RkOUENSnolhvtv9AkWVvC4+UoqgOn8Qysgb9xM3IofX21Tzz6Tk0oEZuJOA/e/3
 4b4tNVmMbG7HVhgB2DPb/TeYAHtGMylmnD3PJGacsE6/UpjcGwS+jXQ9UYlvdfzS+y8W
 +Vu4tu3igfZ700VaRbou+aFFluHvMdiysHJurJ1+8YlyD5mkRIgzLOMNBKfFmqyq/QtV
 e4/X4zvaJw2dDt7kr+97WsS0/n2+F2Co2wdODsrDd0BtitsYUXbJ6XJ4MLgdQtK4MhsU
 JFdQFOyU4xBA1kNZjcfwHK2JxiV8LkG0adb9oUxGBPDx1/yQrCCu2Mhlu2/Rgp5Tt9wY
 uRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281989; x=1689873989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A524XPsKBXV8yIUUkONAn98uAFCiKVTYyMvCRnHwi2c=;
 b=h8t6bZpZsW2T9s1cze//FQkMxZbFC3N9nt9eH/e+/5EsscwPbBjP+w+JvQlOVJq7y1
 95I716+yyR7gChRXveHELZllfElMlbFos8++bvrsp8XtybnJbTvCM+E+IP9XqxY88tct
 8/hquyQDCFDp+w2z2u2i5n6xttU/NDg9HtuDFLmW2f4kf09DvGToKMlZg9LCENm/b8rB
 w/smDT9WHP+nmveqN6ylUu4cHf9PxRqD3z5JqEUF2JXF7bAqLlYILxmz/Hxr4Bi6s8er
 F/KX3Ld5zDF+PvJh56p1WeFzZRHJCPQ6IsJoMhgqaKDQRwz8kj3GQ1q+BjwCCWUieD2Q
 WkyA==
X-Gm-Message-State: AC+VfDxv/5ZI1/secVcRjRmC7C4hkvI49NCqVjdUdHlXrBmXQcZNZTvO
 CAC7Of927BN7UodwzXC+NcrCnaaA0MPKdQ==
X-Google-Smtp-Source: ACHHUZ6S4m8fu+H0OgrlYLgV+H0vy/atkpSHK7ZVonYsWljbCF1QmDliwrTxL0EO6NGWYcflU0wPUw==
X-Received: by 2002:a81:6684:0:b0:568:f2c:ee40 with SMTP id
 a126-20020a816684000000b005680f2cee40mr12259954ywc.3.1687281989562; 
 Tue, 20 Jun 2023 10:26:29 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:28 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v1 17/23] xen/pt: add Resizable BAR PCIe Extended Capability
 descriptor and sizing
Date: Tue, 20 Jun 2023 13:24:51 -0400
Message-Id: <30ddc5858c9a309ed4ab812ab93b3e930b7bfd68.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=jupham125@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:55 -0400
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

Unlike other PCIe Extended Capabilities, we currently cannot allow attempts
to use Resizable BAR Capability. Without specifically handling BAR resizing
we're likely end up with corrupted MMIO hole layout if guest OS will
attempt to use this feature. Actually, recent Windows versions started
to understand and use the Resizable BAR Capability (see [1]).

For now, we need to hide the Resizable BAR Capability from guest OS until
BAR resizing emulation support will be implemented in Xen. This support
is a pretty much mandatory todo-feature as the effect of writing
to Resizable BAR control registers can be considered similar
to reprogramming normal BAR registers -- i.e. this needs to be handled
explicitly, resulting in corresponding MMIO BAR range(s) remapping.
Until then, we mark the Resizable BAR Capability as
XEN_PT_GRP_TYPE_HARDWIRED.

Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/xen/xen_pt_config_init.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 1fba0b9d6c..c5157ee3ee 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -2093,6 +2093,27 @@ static int xen_pt_ext_cap_pmux_size_init(XenPCIPassthroughState *s,
     return ret;
 }
 
+/* get Resizable BAR Extended Capability register group size */
+static int xen_pt_ext_cap_rebar_size_init(XenPCIPassthroughState *s,
+                                          const XenPTRegGroupInfo *grp_reg,
+                                          uint32_t base_offset,
+                                          uint32_t *size)
+{
+    uint32_t rebar_ctl = 0;
+    uint32_t num_entries;
+
+    int ret = xen_host_pci_get_long(&s->real_device,
+                                    base_offset + PCI_REBAR_CTRL,
+                                    &rebar_ctl);
+    num_entries =
+        (rebar_ctl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
+
+    *size = num_entries*8 + 4;
+
+    log_pcie_extended_cap(s, "Resizable BAR", base_offset, *size);
+    return ret;
+}
+
 static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
     /* Header Type0 reg group */
     {
@@ -2424,6 +2445,13 @@ static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
         .size_init  = xen_pt_ext_cap_dpc_size_init,
         .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
     },
+    /* Resizable BAR Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_REBAR),
+        .grp_type   = XEN_PT_GRP_TYPE_HARDWIRED,
+        .grp_size   = 0xFF,
+        .size_init  = xen_pt_ext_cap_rebar_size_init,
+    },
     {
         .grp_size = 0,
     },
-- 
2.34.1


