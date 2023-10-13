Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CED0C7C80E3
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtF-00086i-7C; Fri, 13 Oct 2023 04:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsi-00077y-LX
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:53 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsg-0001aT-2y
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-405361bba99so18650055e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187042; x=1697791842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2B57k0xDmewhDC2FEGeA+DORh7eV2cxV3ygwD/z5myM=;
 b=mhn+cavm59NTtF6x9u7c8fXf6epz5pA2M+SuEVfVrqQbPL6ys4XYg15fWR7ma9YfQl
 qPtDXo/7MJPbBh5fUYNwfQBPMRNfugFLVhO9Cw+Eq60ob4z59h0QUBbhxbjDLzPcD0a9
 JYxjc5IWNU6l1vkBSQNC2IFdUScaabjLMZ1B6AB1ipXhqIPXUdUzbmUEUadXOrp0TZWA
 D4QHR0ugX/iV6hErJVOu8NA9zFG6mFcp+cZSKIZapLMLidiSOB1HszAz5BHH3/yFKRID
 Kz3gxaes/UU9RTIjndkKkt8uocwCGCCInwhmF9XsBoFWEg9bTpUqp7dnuoAUAPqd7V2F
 cu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187042; x=1697791842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2B57k0xDmewhDC2FEGeA+DORh7eV2cxV3ygwD/z5myM=;
 b=uadBC5TTDD1agUhIyUeLY3oe+3rwyVuBhuYhOZznJLi1iaAPE4afytTeIrrL2hrCAE
 psDxoNCU8dVmUawYSZpxtuGWqEFmQjqUS+gRBPy1OfVhkaxwNZ8FMm8V+LcPZgQp5OwL
 iUecOxkMeHOErbTNycoJD5phwxx1yyv6i0G/I9jV/PVpiWL9tNvJO11rV5jZMbCnE8EL
 4lSmiEHSqvjmJvs0DH8VUTlmq4TguDYilGwf0Jo4h7GFDPYbm796huKhA9HcKbR/jQjN
 lYx+QpuOcvpHtOTUYfGPeM8E8UBuv7kaM3Blzk0eEDVGIQmUIFGKfy/0fHX3PYb2y26U
 Dkig==
X-Gm-Message-State: AOJu0Yx8aalE7VYf9M7OlZH+gP99Q6FHP6Ujala31uNlh55xvJgrcsoI
 o904FhB6NUps9hT7O51KST1cZ8inhowRhHdvH80=
X-Google-Smtp-Source: AGHT+IHb7Jwc4KtSJQbT2IqNqbNWwzSUTWDvmPXv+Qk8QoYudULTBD2RFxnAxPzuaQxtxUiW3T1+rw==
X-Received: by 2002:adf:fe0d:0:b0:31f:e5cf:6724 with SMTP id
 n13-20020adffe0d000000b0031fe5cf6724mr24489106wrr.46.1697187042785; 
 Fri, 13 Oct 2023 01:50:42 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:42 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH v3 69/78] hw/rdma/rdma_backend.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:37 +0300
Message-Id: <3c64f3d047edeaa8d79cf4d55efdf04407eb33e1.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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
@@ -812,7 +812,7 @@ int rdma_backend_create_qp(RdmaBackendQP *qp, uint8_t qp_type,
         return 0;
 
     case IBV_QPT_RC:
-        /* fall through */
+        fallthrough;
     case IBV_QPT_UD:
         /* do nothing */
         break;
-- 
2.39.2


