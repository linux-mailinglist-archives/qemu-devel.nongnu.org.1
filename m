Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F16FE74B02E
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:46:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhc-0002ox-Cb; Fri, 07 Jul 2023 07:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhY-0002oY-Ms; Fri, 07 Jul 2023 07:32:41 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhX-0006mS-3i; Fri, 07 Jul 2023 07:32:40 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6b711c3ad1fso1691956a34.0; 
 Fri, 07 Jul 2023 04:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729557; x=1691321557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kolsS4SSi+W0AiSzjPzgwdJRWCbHeiEnBUWE4eafZc=;
 b=AiPNBS9GH0DrykdZ1W06leYg9QVOhUr3U9EcVsJkj0QTA6y4ynzVoew3jUpskXWmYM
 GGsn4HgHwB/K1aKqavZ8xRp2upQeBZS0yk8cQhCnip1B2FIuL11qDJKjNG9kWGpvtoG8
 nhwnroDiZENB1t7xbAg3PptDNJx0qkBpus7HctUtBlProj1JtmclnAKe7a/rpNK5MT2v
 l0jCsDn1XzRd4JWLLQCNNzCfHEypVQWlcJ54YawQSRNLhgkBZ5fvX6MbekwKDCCMGs/l
 wmacEbGoYqtC6xI1/LB9Uz0QyYOUlV+Z0Mt7abBiWu7BhSai7iMBmCltWlb400adVGSV
 Hb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729557; x=1691321557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7kolsS4SSi+W0AiSzjPzgwdJRWCbHeiEnBUWE4eafZc=;
 b=U9Y56pQBbzOvVcJ4ZfphCeVky77A7tRJobEPcPeOGF5pOIQdWV9tOidPI0oZce9Zep
 JK5wT6GGIJYA6GDyd26jtw7Z2dJqmdmuGri8mx9fYgfQLNcgPz1uLU5UkwzncDVoXzPh
 QhhSKLoEL0fuZ7sfZ1oebxIID3zV68H/oAsMNteiBB5PusQ4kop0C3ULy/5WcK8IOsn/
 CXLbLYv/z594pgC6hIwm9vCitMPXkcxZJ3H+Ik7PFm1UFF/cqxt4Bgzht0AD+QuNK9iT
 FZhgwdQ5ZwqfGO2dHhJdU7mXVZd3kpMniWKMFcr5TPl7n7IJoX+ouICBeXNDs9nRqcJS
 WCyQ==
X-Gm-Message-State: ABy/qLYYYlE/vLRLVc3onGJZ2iCFavbJiKZknWa3tCCGZMHenO4eg9oi
 NKhTub6gVu8lkPE6UV+E/hzIb4X3ZEU=
X-Google-Smtp-Source: APBJJlFBj9bceTWBp0aAKyRDCEK9UcsVgCvucn4IZ9Ln2N8/l4FOD2OevY2ws/BWgTgI5eatNx3FkA==
X-Received: by 2002:a05:6830:1e23:b0:6b8:915c:7c6d with SMTP id
 t3-20020a0568301e2300b006b8915c7c6dmr2939013otr.20.1688729557506; 
 Fri, 07 Jul 2023 04:32:37 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:37 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 29/60] pnv/xive: Print CPU target in all TIMA traces
Date: Fri,  7 Jul 2023 08:30:37 -0300
Message-ID: <20230707113108.7145-30-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Add the CPU target in the trace when reading/writing the TIMA
space. It was already done for other TIMA ops (notify, accept, ...),
only missing for those 2. Useful for debug and even more now that we
experiment with SMT.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230705110039.231148-1-fbarrat@linux.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/intc/trace-events | 4 ++--
 hw/intc/xive.c       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 5c6094c457..36ff71f947 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -265,8 +265,8 @@ xive_source_esb_read(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64
 xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
 xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "END 0x%02x/0x%04x -> enqueue 0x%08x"
 xive_router_end_escalate(uint8_t end_blk, uint32_t end_idx, uint8_t esc_blk, uint32_t esc_idx, uint32_t end_data) "END 0x%02x/0x%04x -> escalate END 0x%02x/0x%04x data 0x%08x"
-xive_tctx_tm_write(uint64_t offset, unsigned int size, uint64_t value) "@0x%"PRIx64" sz=%d val=0x%" PRIx64
-xive_tctx_tm_read(uint64_t offset, unsigned int size, uint64_t value) "@0x%"PRIx64" sz=%d val=0x%" PRIx64
+xive_tctx_tm_write(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
+xive_tctx_tm_read(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
 xive_presenter_notify(uint8_t nvt_blk, uint32_t nvt_idx, uint8_t ring) "found NVT 0x%x/0x%x ring=0x%x"
 xive_end_source_read(uint8_t end_blk, uint32_t end_idx, uint64_t addr) "END 0x%x/0x%x @0x%"PRIx64
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index c014e961a4..56670b2cac 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -566,7 +566,7 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
 {
     const XiveTmOp *xto;
 
-    trace_xive_tctx_tm_write(offset, size, value);
+    trace_xive_tctx_tm_write(tctx->cs->cpu_index, offset, size, value);
 
     /*
      * TODO: check V bit in Q[0-3]W2
@@ -639,7 +639,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
      */
     ret = xive_tm_raw_read(tctx, offset, size);
 out:
-    trace_xive_tctx_tm_read(offset, size, ret);
+    trace_xive_tctx_tm_read(tctx->cs->cpu_index, offset, size, ret);
     return ret;
 }
 
-- 
2.41.0


