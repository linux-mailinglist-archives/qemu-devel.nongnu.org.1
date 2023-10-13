Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8747C7FE2
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:19:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD5y-0001Ft-Kl; Fri, 13 Oct 2023 04:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5d-0008ER-H3
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:11 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5Z-0007UO-46
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:08 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5079a86df75so419555e87.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697184001; x=1697788801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MtYrK7r4bSuL5r98RVZM/HRC8aOVqfHWQY1jmXa6T8g=;
 b=UpAmklKjlPeEB1zozergMQDUlPtVUa1ahbm2Hi+e3V/ynt4KrGzUfk/dxzTSSMjc5S
 Z8qwLRbxwUYLap+3pL9CpIICZH9aPTnY4R+HFVEf1bIZmv5Swr5hNcHH00KdRcyPiTWJ
 UiB5r61uFmb2Ht0/njekaq4mKDzi1qIUc5oVtQCEDe9XmEE8CdwmbUakmTJ7uriw7qLL
 Zp7zbkM7ZLZ1uYwEO2B5vCs5HBQRYMx12MDIfIQTyA6oj7hN+zXqEcsy7krYAS/UyhTJ
 AoPtuGdx/v9vjyV5PbVEsYlU63pOqlT/FHg5aFPnypJIAvqSjUW4FH0DjjG2PvOonLNm
 397A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184001; x=1697788801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MtYrK7r4bSuL5r98RVZM/HRC8aOVqfHWQY1jmXa6T8g=;
 b=ldWi/M36sCHf5Hoxizzm6FoQEiTfm9f1dqiqDZCH01+tdzUx2ZIboGIXZbzwEy2Hcm
 ZHLzcdGwJCbAfCgAMOSb/5mj60/YiaMljQASJIgbC64e+8GSnmzfE6+GMm7HVc3cduYt
 q1E+qH40sJVWAXeWPZhxx8YjFD/d2bZIObtsYO7zcvfAaeMvlt/1zOrCOQwNfgjzw1hT
 bmXiCv2f1eBDl79hQu3b/J/mfc+BiG+NjRIroAU7hECDK9Powxz+bKzWLPnIzUB3fkX/
 LiTPBSGudungxBBOwDTf3vyqBg6t7Be3WqwrSaHaP4kpSD58eCw4Iu0IZ98ExG5clXEC
 qekw==
X-Gm-Message-State: AOJu0Yz53+4dnQOO9+r5rzZHdQcDI+i6kmz82UYSKQNHZCb1NLXV6Qzj
 ATZyrd51Fr7y+PggkHZXHMgS8liUnucyCiaIpYM=
X-Google-Smtp-Source: AGHT+IGpYhwKoPyjZP6q+1T660g347lshQhLEKTScHDsyuKfiIuC/VKkow87GCi6J7r9wi8t4MkFmg==
X-Received: by 2002:ac2:5f0a:0:b0:500:af69:5556 with SMTP id
 10-20020ac25f0a000000b00500af695556mr19913511lfq.29.1697184001184; 
 Fri, 13 Oct 2023 01:00:01 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:00:00 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH v2 69/78] hw/rdma/rdma_backend.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:36 +0300
Message-Id: <ef665a4bd46e9ae303d1db53bd008c6a76201ba0.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x133.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/rdma/rdma_backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 6dcdfbbbe2..09e5ad961e 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -800,50 +800,50 @@ void rdma_backend_destroy_cq(RdmaBackendCQ *cq)
 int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
                            RdmaBackendPD *pd, RdmaBackendCQ *scq,
                            RdmaBackendCQ *rcq, RdmaBackendSRQ *srq,
                            uint32_t max_send_wr, uint32_t max_recv_wr,
                            uint32_t max_send_sge, uint32_t max_recv_sge)
 {
     struct ibv_qp_init_attr attr = {};
 
     qp->ibqp = 0;
 
     switch (qp_type) {
     case IBV_QPT_GSI:
         return 0;
 
     case IBV_QPT_RC:
-        /* fall through */
+        fallthrough;
     case IBV_QPT_UD:
         /* do nothing */
         break;
 
     default:
         rdma_error_report("Unsupported QP type %d", qp_type);
         return -EIO;
     }
 
     attr.qp_type = qp_type;
     attr.send_cq = scq->ibcq;
     attr.recv_cq = rcq->ibcq;
     attr.cap.max_send_wr = max_send_wr;
     attr.cap.max_recv_wr = max_recv_wr;
     attr.cap.max_send_sge = max_send_sge;
     attr.cap.max_recv_sge = max_recv_sge;
     if (srq) {
         attr.srq = srq->ibsrq;
     }
 
     qp->ibqp = ibv_create_qp(pd->ibpd, &attr);
     if (!qp->ibqp) {
         rdma_error_report("ibv_create_qp fail, errno=%d", errno);
         return -EIO;
     }
 
     rdma_protected_gslist_init(&qp->cqe_ctx_list);
 
     qp->ibpd = pd->ibpd;
 
     /* TODO: Query QP to get max_inline_data and save it to be used in send */
 
     return 0;
 }
-- 
2.39.2


