Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE607C80D0
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqV-0000ER-3v; Fri, 13 Oct 2023 04:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq5-0007mF-SA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:10 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq4-0000wm-9B
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:09 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32d9cb5e0fcso341846f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186886; x=1697791686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsqdHIBHyATGGVsHzIK9e4ccgcZXyAxYlzbdFPUEhww=;
 b=viuzoupSGSJ55Wt0oEWa/bAFMxpSup/rLFARoFwoyU0CtVRn2yYoe8XYIeWzuuSkEn
 EKkxSIp140oNLFyhkQpFcnnrs4e2CZQqM9s5D+0coE8l3lJMpI1YrvJpUeU+oxFyYnHj
 IWzmt45z5jlx1UmP5iV1E2fXbWjkH+nZGLczzQac7/PwMfG7fJ/+XgsIeSXfJGCbF5vG
 VU3XTMgu+2G1ijmvjT+kjuZO8y6dz14dEc49USvu6+DSm9+LBtIBJrGJXLjTaOzmR21h
 tMiaymXom4IEpDdNUjK/CN0Uw/uAAsgiTq+xY9eDJONhb+eKhYRs2bsO6obmc3lv/idA
 +nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186886; x=1697791686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsqdHIBHyATGGVsHzIK9e4ccgcZXyAxYlzbdFPUEhww=;
 b=rL2AxLv0B7jqPfjntQNKcCUJf85nRoADcDqh0/FTQzFJJK8rFUYrKIoEDsPq94Gx8p
 o0aqshEMgCVqxMf3Pnq6RuHs9zDb8V+42un2Z7cKQX7vT0/to/lvBQgrVbIsubHQUjow
 ey8in+BlwNGJJ6tRTDhKedYxNaXkvyNdmIUcNy5ZTJ4pgn98qwhVf60brYFH2igkmN7R
 M82tm0ey37/MmGeK1M2n+asEhPwL1zlpsD8yiHMI5swQnAxwUCuN7S2TUqoH963MsJMN
 c2jXV8mv2eDuQxifJomytTP3IAuPBo8nxboB6kG4GkeZA4hHCjNCVSbuCPQ+Gv2Ef8SM
 BjEg==
X-Gm-Message-State: AOJu0Ywd6vZw63xkIYClRDbtrQymET/waKMWNjPEu54BGvaWpeu5Lj6E
 1WOa++F3+phsuHsjJZhCoaqM3EczU6xK9wznM8c=
X-Google-Smtp-Source: AGHT+IHsducjz+rj/lF4gdMJOwFrQ/C3jSyIIHO0u380Orbo/Ma5t6Zrg/z6C9Gd5CKSPOZ5TpjPDQ==
X-Received: by 2002:a05:6000:228:b0:32d:56bd:1f5c with SMTP id
 l8-20020a056000022800b0032d56bd1f5cmr7730533wrz.71.1697186886702; 
 Fri, 13 Oct 2023 01:48:06 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:06 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [RFC PATCH v3 31/78] target/xtensa: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:59 +0300
Message-Id: <6453e401c67962a90200e6102c201569333c311e.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
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

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/xtensa/op_helper.c | 8 ++++----
 target/xtensa/translate.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 7bb8cd6726..69b72f474d 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -108,10 +108,10 @@ void HELPER(check_atomctl)(CPUXtensaState *env, uint32_t pc, uint32_t vaddr)
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
@@ -150,10 +150,10 @@ void HELPER(check_exclusive)(CPUXtensaState *env, uint32_t pc, uint32_t vaddr,
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
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 54bee7ddba..8ef940933c 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -803,7 +803,7 @@ static void opcode_add_resource(struct slot_prop *op,
         op->in[op->n_in].resource = resource;
         op->in[op->n_in].index = index;
         ++op->n_in;
-        /* fall through */
+        fallthrough;
     case 'o':
         if (direction == 'm' || direction == 'o') {
             assert(op->n_out < ARRAY_SIZE(op->out));
-- 
2.39.2


