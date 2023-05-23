Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8D070D1BC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:49:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I26-00070m-Cc; Mon, 22 May 2023 22:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1o-000684-IA
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:38 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1Z-0004RM-Kn
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:35 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2553f2706bfso1958621a91.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809918; x=1687401918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWwfpnQu5ztShG2O7Kt6FntEtpjoTmNtluRIdWAfHfQ=;
 b=ufqMIFPXzHNsUCpoZiI7wiyIClTbLIP3wg3wznoSfFEmM8xUOvZSDIa7jcY1E3Yzyu
 /rJ9an6jtUnYxfF4oadLpreVvrX+QY1dUUouf3t69QiIZtLzlheJZu/tceWPg+uOiPHT
 yEaSPhCo8JsAFp15xp+rU/nrYK0JT0rjJ3MvGdVOkMCrml3amxkx9pfzaEMs7baT7wbR
 QxMT//rblHFWjKcCR3wuYrPYEfxdxUlDhJ87zjirRbuFDP3tTQyqgZvM51sRD2KAg/Xj
 ZK3Rtu9gQakEyWcRCJXgiRM1GDB2q8Dpe7zsdM1iUEULUUMxRjip8Sl41nWfMId21rhC
 lXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809918; x=1687401918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YWwfpnQu5ztShG2O7Kt6FntEtpjoTmNtluRIdWAfHfQ=;
 b=iVcH/5nqu2QyjKkbA78SHCAuOqNMDqWBuKXskZJ64/5Yj/qN+A1xx4jaxk/Bw1CEvk
 61gbVi1wzEtXtunPrlwI/5AE7CazL0AjhYIJrn5m3qn+AjITBvSGs4uADMVZHEd76Ar/
 2HUxNC7r2XW8bKrNQ5hxSHBjjMjG1s1XnAHK7vNEcBUX0ZQlZ8E97vGXhnxFGAeN3itn
 A4+MKkIAEVYB/Pgepc47zSD+zDNk2A5CgNyr6SNuVCa5V2mJ3Sy4Tw2+PkVP0ChleaU4
 zzQ5/Lxzn4RFfpchfqXzeXyykZQlm3sZcJaI/JUxCE/loYXENeJn5W7GU5d+bqKPBrRi
 B1ow==
X-Gm-Message-State: AC+VfDwLzIyLKiH+9Jjy3mDUGSOuKstVizgZ3UT4rTIfkf+x3PdjS9ZX
 LVMXttmkImi8j/I+16J5B9aOYg==
X-Google-Smtp-Source: ACHHUZ4FsJTzpjtjbA3E86uvr3Npvl/xHHhhrHYe+KiLV3v8FMhV+DHHjcmdUWGrGpFuCeueYvo3dA==
X-Received: by 2002:a17:90b:f84:b0:247:14ac:4d3a with SMTP id
 ft4-20020a17090b0f8400b0024714ac4d3amr12980953pjb.20.1684809918115; 
 Mon, 22 May 2023 19:45:18 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 25/48] igb: Share common VF constants
Date: Tue, 23 May 2023 11:43:16 +0900
Message-Id: <20230523024339.50875-26-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

The constants need to be consistent between the PF and VF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/igb_common.h |  8 ++++++++
 hw/net/igb.c        | 10 +++++-----
 hw/net/igbvf.c      |  7 -------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/net/igb_common.h b/hw/net/igb_common.h
index 69ac490f75..f2a9065791 100644
--- a/hw/net/igb_common.h
+++ b/hw/net/igb_common.h
@@ -28,6 +28,14 @@
 
 #include "igb_regs.h"
 
+#define TYPE_IGBVF "igbvf"
+
+#define IGBVF_MMIO_BAR_IDX  (0)
+#define IGBVF_MSIX_BAR_IDX  (3)
+
+#define IGBVF_MMIO_SIZE     (16 * 1024)
+#define IGBVF_MSIX_SIZE     (16 * 1024)
+
 #define defreg(x) x = (E1000_##x >> 2)
 #define defreg_indexed(x, i) x##i = (E1000_##x(i) >> 2)
 #define defreg_indexeda(x, i) x##i##_A = (E1000_##x##_A(i) >> 2)
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 51a7e9133e..1c989d7677 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -433,16 +433,16 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_ari_init(pci_dev, 0x150, 1);
 
-    pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, "igbvf",
+    pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
         IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
         IGB_VF_OFFSET, IGB_VF_STRIDE);
 
-    pcie_sriov_pf_init_vf_bar(pci_dev, 0,
+    pcie_sriov_pf_init_vf_bar(pci_dev, IGBVF_MMIO_BAR_IDX,
         PCI_BASE_ADDRESS_MEM_TYPE_64 | PCI_BASE_ADDRESS_MEM_PREFETCH,
-        16 * KiB);
-    pcie_sriov_pf_init_vf_bar(pci_dev, 3,
+        IGBVF_MMIO_SIZE);
+    pcie_sriov_pf_init_vf_bar(pci_dev, IGBVF_MSIX_BAR_IDX,
         PCI_BASE_ADDRESS_MEM_TYPE_64 | PCI_BASE_ADDRESS_MEM_PREFETCH,
-        16 * KiB);
+        IGBVF_MSIX_SIZE);
 
     igb_init_net_peer(s, pci_dev, macaddr);
 
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 70beb7af50..284ea61184 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -50,15 +50,8 @@
 #include "trace.h"
 #include "qapi/error.h"
 
-#define TYPE_IGBVF "igbvf"
 OBJECT_DECLARE_SIMPLE_TYPE(IgbVfState, IGBVF)
 
-#define IGBVF_MMIO_BAR_IDX  (0)
-#define IGBVF_MSIX_BAR_IDX  (3)
-
-#define IGBVF_MMIO_SIZE     (16 * 1024)
-#define IGBVF_MSIX_SIZE     (16 * 1024)
-
 struct IgbVfState {
     PCIDevice parent_obj;
 
-- 
2.40.1


