Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CCA7C7FBE
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:16:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4l-0002LZ-KE; Fri, 13 Oct 2023 03:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4W-0000z9-Ro
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:01 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4S-0006vv-Ny
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40572aeb73cso19381035e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183932; x=1697788732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hrUsD3RhfEePTarbxbhkSuBWQuSjk/BmdC/mQSx7OjQ=;
 b=M/EhcbpTs1b7pMMIc9qMHWc+SYWSl4Oqr/VtDaiAHvwLPDnVrU9frQzqXhdv+GZGwN
 SLNf1I1Q9DeqAc1LK3UJN+Rfl/BoDUDY3v+izTLMmZXtBGblhV/ylLrwYMq8HQF5HBos
 6peZwL7qiyTcP0nmOp1dtArAOKRyXjN2+4ZZZA/jwSf0gIV0Uu7ZCbUBLBAS1NLhynlM
 iT5LSn9Un3Sk6bpF9lvIPesS33s32xiZsLhOqpzJEsfGJj4List6aWw74tdlYtJedLGr
 ys7AT6yfTCiU4nK+rqPV1ds55ebSLCiQQklLzOYEFZ9WZ2Nm4WJgyjPkhZZQ73AaUTVN
 YlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183932; x=1697788732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hrUsD3RhfEePTarbxbhkSuBWQuSjk/BmdC/mQSx7OjQ=;
 b=fE4PskXk81bNX9mQL/P/Ch5sSMo3JOJCwVXQJ9qGfPENi673hNX8swt+6CFNEO9vo2
 iQQ+P3FhFjFaiLrqPbwo/p8Aw6gaScQyC0guNhKvTbRPVw63jcwdO5iWINy4dynjpApB
 Z6Q8GRsSvUyaUNsbyYntG1vd8mNQMqi3RWaFscyMN65Zf18wF7xVh1xS1AeM2E3JkCfm
 PwPA3rPDXihulhNXIzKE4yLMfQkIBHBfzkb48dt9BSce3zRA1wXhWAF55nw57SXusy2m
 3S4tLq6f6CORuKcDUxsSuMb8RwKseGkI4MUOhTSVkzq84BJtwlthsGxOjLJH3uXMAfpT
 cqOg==
X-Gm-Message-State: AOJu0Ywf7mXwEhfS8ORv3Ml6N7nXrJkPcWlHuqm8M+m7NEfw96znuRV2
 RW18j8fu3vDsEDPPfzrOpcs46vGAJLE21EzzKdc=
X-Google-Smtp-Source: AGHT+IHOgSxPk6Hi9E7LLAfdqOtSUSUW32NkacNsoOqwcFR7M8xlk0Zkj/PeqI2F1VnuenrS5LjIyA==
X-Received: by 2002:a1c:7917:0:b0:401:d803:624f with SMTP id
 l23-20020a1c7917000000b00401d803624fmr23625964wme.4.1697183932349; 
 Fri, 13 Oct 2023 00:58:52 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:51 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [RFC PATCH v2 31/78] target/xtensa: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:58 +0300
Message-Id: <390bd7d2c57e0ab48dad854c7dd44037a3fe31c4.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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
 target/xtensa/op_helper.c | 8 ++++----
 target/xtensa/translate.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 7bb8cd6726..69b72f474d 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -73,58 +73,58 @@ void HELPER(update_ccompare)(CPUXtensaState *env, uint32_t i)
 /*!
  * Check vaddr accessibility/cache attributes and raise an exception if
  * specified by the ATOMCTL SR.
  *
  * Note: local memory exclusion is not implemented
  */
 void HELPER(check_atomctl)(CPUXtensaState *env, uint32_t pc, uint32_t vaddr)
 {
     uint32_t paddr, page_size, access;
     uint32_t atomctl = env->sregs[ATOMCTL];
     int rc = xtensa_get_physical_addr(env, true, vaddr, 1,
             xtensa_get_cring(env), &paddr, &page_size, &access);
 
     /*
      * s32c1i never causes LOAD_PROHIBITED_CAUSE exceptions,
      * see opcode description in the ISA
      */
     if (rc == 0 &&
             (access & (PAGE_READ | PAGE_WRITE)) != (PAGE_READ | PAGE_WRITE)) {
         rc = STORE_PROHIBITED_CAUSE;
     }
 
     if (rc) {
         HELPER(exception_cause_vaddr)(env, pc, rc, vaddr);
     }
 
     /*
      * When data cache is not configured use ATOMCTL bypass field.
      * See ISA, 4.3.12.4 The Atomic Operation Control Register (ATOMCTL)
      * under the Conditional Store Option.
      */
     if (!xtensa_option_enabled(env->config, XTENSA_OPTION_DCACHE)) {
         access = PAGE_CACHE_BYPASS;
     }
 
     switch (access & PAGE_CACHE_MASK) {
     case PAGE_CACHE_WB:
         atomctl >>= 2;
-        /* fall through */
+        fallthrough;
     case PAGE_CACHE_WT:
         atomctl >>= 2;
-        /* fall through */
+        fallthrough;
     case PAGE_CACHE_BYPASS:
         if ((atomctl & 0x3) == 0) {
             HELPER(exception_cause_vaddr)(env, pc,
                     LOAD_STORE_ERROR_CAUSE, vaddr);
         }
         break;
 
     case PAGE_CACHE_ISOLATE:
         HELPER(exception_cause_vaddr)(env, pc,
                 LOAD_STORE_ERROR_CAUSE, vaddr);
         break;
 
     default:
         break;
     }
 }
@@ -132,41 +132,41 @@ void HELPER(check_atomctl)(CPUXtensaState *env, uint32_t pc, uint32_t vaddr)
 void HELPER(check_exclusive)(CPUXtensaState *env, uint32_t pc, uint32_t vaddr,
                              uint32_t is_write)
 {
     uint32_t paddr, page_size, access;
     uint32_t atomctl = env->sregs[ATOMCTL];
     int rc = xtensa_get_physical_addr(env, true, vaddr, is_write,
                                       xtensa_get_cring(env), &paddr,
                                       &page_size, &access);
 
     if (rc) {
         HELPER(exception_cause_vaddr)(env, pc, rc, vaddr);
     }
 
     /* When data cache is not configured use ATOMCTL bypass field. */
     if (!xtensa_option_enabled(env->config, XTENSA_OPTION_DCACHE)) {
         access = PAGE_CACHE_BYPASS;
     }
 
     switch (access & PAGE_CACHE_MASK) {
     case PAGE_CACHE_WB:
         atomctl >>= 2;
-        /* fall through */
+        fallthrough;
     case PAGE_CACHE_WT:
         atomctl >>= 2;
-        /* fall through */
+        fallthrough;
     case PAGE_CACHE_BYPASS:
         if ((atomctl & 0x3) == 0) {
             HELPER(exception_cause_vaddr)(env, pc,
                                           EXCLUSIVE_ERROR_CAUSE, vaddr);
         }
         break;
 
     case PAGE_CACHE_ISOLATE:
         HELPER(exception_cause_vaddr)(env, pc,
                 LOAD_STORE_ERROR_CAUSE, vaddr);
         break;
 
     default:
         break;
     }
 }
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 54bee7ddba..8ef940933c 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -795,24 +795,24 @@ again:
 static void opcode_add_resource(struct slot_prop *op,
                                 uint32_t resource, char direction,
                                 int index)
 {
     switch (direction) {
     case 'm':
     case 'i':
         assert(op->n_in < ARRAY_SIZE(op->in));
         op->in[op->n_in].resource = resource;
         op->in[op->n_in].index = index;
         ++op->n_in;
-        /* fall through */
+        fallthrough;
     case 'o':
         if (direction == 'm' || direction == 'o') {
             assert(op->n_out < ARRAY_SIZE(op->out));
             op->out[op->n_out].resource = resource;
             op->out[op->n_out].index = index;
             ++op->n_out;
         }
         break;
     default:
         g_assert_not_reached();
     }
 }
-- 
2.39.2


