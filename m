Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CA192AE54
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jul 2024 04:49:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR0tx-0008E7-DQ; Mon, 08 Jul 2024 22:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sR0tp-0007gV-QA
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:48:13 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sR0tn-00048m-Tm
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:48:13 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-75c3afd7a50so2323379a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 19:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720493290; x=1721098090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrkIIgQX6TLIKPjYDCoZVTqMBbiuqD+0ICFBlvY+Bo0=;
 b=lYmX58PnwTWdvy7IaL/UDm1Lp3g/dMSen6Dfsw3ZPdfdKMwdBpOChY6DHJ1I8l+rYL
 OKbOQjOSUxlnoZtlipbSssQ33Rw3co5et65TrvZ4iK0P35o59kMkO1ZpIorzk7abDKCm
 x8LxrqGn1sfmEMdOITCv0Mo+puHU3qots/q03q9NM9f1s5Q2fU5BylrHwAvrnU/isP1y
 tOGZRJJxTd6gc53ecN9s5Gd0Ozq/AtxKQMJtdtx4rDiuCerY8RAYFtWnLJNPcPXNgZLa
 sAoLU+Rqr+tqAz3jaMmW2kVSq6bm+DTfl4QqbvhXhehaYu9KNhGGS1rTSVEmDjRVrywX
 k5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720493290; x=1721098090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrkIIgQX6TLIKPjYDCoZVTqMBbiuqD+0ICFBlvY+Bo0=;
 b=TERc3FhdPfQ5QKQ0UQbluoUN+PH1QrAgX6T1Fw8N2CAOvana9K3pbyCdWgKvfx7bgF
 Gzxo6GCPakAGmqzj2erbItbXk8Ib8VHuWKD4mtr/2iUuQq8mT9gL0jELWeUbWU5LzsRI
 pCNE8pW1HakmWQkv96GCKYxAgRLqCkbqypuIx2LGXocjYHV6R6e3jsyHHILn9Zoovk+E
 DDIWgUj8t3NCGQWaBQe8KWL9pQFqw35bA02ZGhs/vG3qqryj27or3gPkzSR29BAMzqLa
 rkCXkgn3h2ZN05SZhgRSiWCJi+Cns+t0Bm6Oo70i/sMTv4IKYK967459sCz1nseAo7K7
 /pPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX6D3o1qevdt8zG25TZOOlmzmz9HMf4RX1CJlC+XXJiyujR1an9VOpi9BE0HzF10cPwHr4w9Lu+99oWU+vjNDFIKNCBCo=
X-Gm-Message-State: AOJu0YwEl0Ca3ZHuYQWQAl38nUEiOfDA3x30adpuz2FEwQp4J3AP9hNe
 azDW4lbyNJQoKM5ytzC/m900II7Kj4K1PLbEgmU7P7koKvnvWbr1YvBkfB9+2H8=
X-Google-Smtp-Source: AGHT+IH4+UhEgX1vBHl1RyMAwyBv7NU0C2eEuu2qE9QAx1fgQ4ilwN5S5f6VLKdSayU3Yl7GbM7+iA==
X-Received: by 2002:a05:6a20:258f:b0:1c0:d9c9:64f9 with SMTP id
 adf61e73a8af0-1c298243af3mr1415907637.36.1720493290387; 
 Mon, 08 Jul 2024 19:48:10 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a97e8a5sm8964661a91.27.2024.07.08.19.48.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Jul 2024 19:48:10 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v8 08/10] hw/nvme: enable ONCS and rescap function
Date: Tue,  9 Jul 2024 10:47:04 +0800
Message-Id: <20240709024706.4108-9-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240709024706.4108-1-luchangqi.123@bytedance.com>
References: <20240709024706.4108-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This commit enables ONCS to support the reservation
function at the controller level. Also enables rescap
function in the namespace by detecting the supported reservation
function in the backend driver.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/ctrl.c       | 3 ++-
 hw/nvme/ns.c         | 5 +++++
 include/block/nvme.h | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..ad212de723 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8248,7 +8248,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(NVME_MAX_NAMESPACES);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES | NVME_ONCS_DSM |
-                           NVME_ONCS_COMPARE | NVME_ONCS_COPY);
+                           NVME_ONCS_COMPARE | NVME_ONCS_COPY |
+                           NVME_ONCS_RESERVATIONS);
 
     /*
      * NOTE: If this device ever supports a command set that does NOT use 0x0
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index ea8db175db..a5c903d727 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
+#include "block/block_int.h"
 
 #include "nvme.h"
 #include "trace.h"
@@ -33,6 +34,7 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     BlockDriverInfo bdi;
     int npdg, ret;
     int64_t nlbas;
+    uint8_t blk_pr_cap;
 
     ns->lbaf = id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
     ns->lbasz = 1 << ns->lbaf.ds;
@@ -55,6 +57,9 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     }
 
     id_ns->npda = id_ns->npdg = npdg - 1;
+
+    blk_pr_cap = blk_bs(ns->blkconf.blk)->bl.pr_cap;
+    id_ns->rescap = block_pr_cap_to_nvme(blk_pr_cap);
 }
 
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 8b125f7769..9b9eaeb3a7 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1251,7 +1251,7 @@ enum NvmeIdCtrlOncs {
     NVME_ONCS_DSM           = 1 << 2,
     NVME_ONCS_WRITE_ZEROES  = 1 << 3,
     NVME_ONCS_FEATURES      = 1 << 4,
-    NVME_ONCS_RESRVATIONS   = 1 << 5,
+    NVME_ONCS_RESERVATIONS  = 1 << 5,
     NVME_ONCS_TIMESTAMP     = 1 << 6,
     NVME_ONCS_VERIFY        = 1 << 7,
     NVME_ONCS_COPY          = 1 << 8,
-- 
2.20.1


