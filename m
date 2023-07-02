Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A65744D11
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 11:48:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFtfT-0003mY-GI; Sun, 02 Jul 2023 05:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFtfK-0003m9-G1
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:46:46 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFtfI-0007hC-WB
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:46:46 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-666e5f0d60bso1753171b3a.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688291203; x=1690883203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rynjAUP6lxRQ+wMlciGvKUU8H/YrNM/NmVpo+UCvFLI=;
 b=B612EM/a3WVZrH9RXFziPekzNdgf+ikv0zlJdQfb52yMHVV84Dwom/ODLgUnwqJtYu
 bIx7IhMP56WJaeSAjtxGQF47FyyfU9u/LCQwT6VBM3o9ZUgk8oVBr87xJqUArbxFEwWg
 UMyaMiC+g+wENgLN7hDZSs/JaKtwCw9ukfCmzXeQC6z2fA9LWvrWfsOWcv/bvWNGb/BD
 6GWMHkf1esw627Tr4Z8aY3JANRy7hHn4+k4VBaGnGxuJlivvD4CJPxoF5o3wtKpF1otL
 fCy+/PUUWkKW+GLuozaZrXz+2cHwvqgtQVUWCd7LPvibUaH+wZ2y3RWT6MYJEihS4v/7
 Q4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688291203; x=1690883203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rynjAUP6lxRQ+wMlciGvKUU8H/YrNM/NmVpo+UCvFLI=;
 b=TN331p0we2S7g9iaF7jJW8QjsEktLpKqI7FcaLOkboKDrTCMQ+Dn5CzUWIQ/Nlru2c
 E0C4HUpY5lMgeqIrcspYg61ooGHM21Pl+0tisDC4z2RX1R+nqwfAVBYn8QIw1I6bMDC8
 zvjr1a9sUtiJVMCNUGm2ekF2aWfUoZTGXdKMKQ6Y7s73mR6xpbJfKimTkt1V6lFHEbZX
 mm8e/VK5rMSsmPuQVrlXZqQkjroe3sCs/ER+5J46gEUzm7c6Zhq8CfP3EqkvQ227HFcN
 Yn+v3lCDhVQlBNOD9kXMRe6uNhP48v8abQt97YfEyAUakQCswuAe3K884yoY8+mbrKb6
 NzZw==
X-Gm-Message-State: ABy/qLaKH5EAfFCeYHKXd5z4FB5bwvShYBrv4XsqpsPfbbyghcYR4xOH
 XhQPYHVuVP/6WFhU/qsWTZnGwK6RGbTVkrsvM8Y=
X-Google-Smtp-Source: APBJJlGYx0zHr5rAT4MElCApMVKMqDnTweJ5MkKsuQDp8ASdjoFtmYdlueFoS9hV/AuFE2B4gF142w==
X-Received: by 2002:a05:6a20:3ca7:b0:12d:7555:a62d with SMTP id
 b39-20020a056a203ca700b0012d7555a62dmr6175250pzj.33.1688291203687; 
 Sun, 02 Jul 2023 02:46:43 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 i1-20020a635841000000b005348af1b84csm12934067pgm.74.2023.07.02.02.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 02:46:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 2/4] hw/nvme: Fix ARI next function numbers
Date: Sun,  2 Jul 2023 18:46:26 +0900
Message-ID: <20230702094631.39111-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702094631.39111-1-akihiko.odaki@daynix.com>
References: <20230702094631.39111-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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

The ARI next function number field is undefined for VF. The PF should
end the linked list formed with the field by specifying 0.

Fixes: 44c2c09488 ("hw/nvme: Add support for SR-IOV")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/nvme/nvme.h    | 1 +
 hw/core/machine.c | 1 +
 hw/nvme/ctrl.c    | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 209e8f5b4c..c2ba6755ab 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -515,6 +515,7 @@ typedef struct NvmeParams {
     uint16_t sriov_vi_flexible;
     uint8_t  sriov_max_vq_per_vf;
     uint8_t  sriov_max_vi_per_vf;
+    bool     ari_nextfn_1;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 46f8f9a2b0..f984a767a2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,7 @@
 
 GlobalProperty hw_compat_8_0[] = {
     { "migration", "multifd-flush-after-each-section", "on"},
+    { "nvme", "ari-nextfn-1", "on"},
 };
 const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index fd917fcda1..4bbafc66b5 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8088,7 +8088,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     pcie_endpoint_cap_init(pci_dev, 0x80);
     pcie_cap_flr_init(pci_dev);
     if (n->params.sriov_max_vfs) {
-        pcie_ari_init(pci_dev, 0x100, 1);
+        pcie_ari_init(pci_dev, 0x100, n->params.ari_nextfn_1 ? 1 : 0);
     }
 
     /* add one to max_ioqpairs to account for the admin queue pair */
@@ -8406,6 +8406,7 @@ static Property nvme_props[] = {
                       params.sriov_max_vi_per_vf, 0),
     DEFINE_PROP_UINT8("sriov_max_vq_per_vf", NvmeCtrl,
                       params.sriov_max_vq_per_vf, 0),
+    DEFINE_PROP_BOOL("ari-nextfn-1", NvmeCtrl, params.ari_nextfn_1, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


