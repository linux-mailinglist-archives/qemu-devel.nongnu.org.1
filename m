Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B39570EA00
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:06:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1btn-0004K5-5s; Tue, 23 May 2023 19:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btk-0004Hv-Qh
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:36 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btX-0001pT-Gy
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:34 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d3fdcadb8so95291b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886301; x=1687478301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sc7213RLRuctojtWLbzPuqzsIJI6tjTB/1Lhu64ZbUY=;
 b=ih/DCthxb31OTF9pCYXZnZMk8uXpq7ya8Rh32cV5Z/Y2P7O9raWWuh0O2LhKddpau8
 HA2tDYZUL9m37IMLnQ82jFPOQA1OXqKwztx1ApmOJKNlK5ilhlQXQ3PxSLOawbhVTmuP
 bXpBbCwyuhtMk31QJKtQCpMbS5q92e9aZZaHsvimepUBSAxmzKn8bfdMiRJ/NAzedVqa
 iSzmieAR2LxEC7aJMeVoApWSxJQOlBlQnwkFOQoI3i+/n2RLjk2KM6nkI2K4tAU3ig4O
 btmrvWzfrMu8JbKd/KAQOrF/1WKKXrzUa0qiY+FZ4ELLDcLyk88bi5qjp4CxSUp9JOyJ
 VZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886301; x=1687478301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sc7213RLRuctojtWLbzPuqzsIJI6tjTB/1Lhu64ZbUY=;
 b=gBi148VxQkmsOXBFSI9FIZBgMK+cfh3jmf2YmZKzPpOJabaUJmF6foFHNXUcxHi9Vk
 7klLB4WR/g4Pc2OvD6I4aGNzpxk0gveia00cuWFCWKrG3uW/tbtVcB+kv6VfqOQb37GG
 GdO6g5yscijH65GvgnASktk9XOrkO0VHwe8JKWSt5KtRlsQ0DefeYUAYKGLM9IxsUaKC
 i7j9i0VKctRUzG6JKCcKjYS8I0xnFLFX5ypEDuKEp9vtJM1ssVzbAW6bIfEfHyG4Gvg1
 +/p4Yr64CjFJXkYtPkPQy8FmcGayhO8oAp0sGTHCcxh15WRJVVk0a8png6on/uVnVLOa
 2I+g==
X-Gm-Message-State: AC+VfDziW7tu1Jdsn5rmMr1MLaamHQl1YTAoIn0mwgLauJp+0ZQ71hv2
 DMCZMbrKGiB7+MR7XTm0ROp/HUsXMUQdxhhAyMA=
X-Google-Smtp-Source: ACHHUZ7fkjMjIKvkBPo8apAsBDuDkUgkiyzS0SI2SJQ2Emmqrw3Xaj3SReZU2oz+XNqgspycbJ4asw==
X-Received: by 2002:a05:6a00:842:b0:64d:5cc5:fa67 with SMTP id
 q2-20020a056a00084200b0064d5cc5fa67mr804085pfk.17.1684886301235; 
 Tue, 23 May 2023 16:58:21 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 18/28] target/s390x: Always use cpu_atomic_cmpxchgl_be_mmu in
 do_csst
Date: Tue, 23 May 2023 16:57:54 -0700
Message-Id: <20230523235804.747803-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Eliminate the CONFIG_USER_ONLY specialization.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index c757612244..aa8ec6ba6d 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -1800,13 +1800,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
             uint32_t ov;
 
             if (parallel) {
-#ifdef CONFIG_USER_ONLY
-                uint32_t *haddr = g2h(env_cpu(env), a1);
-                ov = qatomic_cmpxchg__nocheck(haddr, cv, nv);
-#else
-                MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mem_idx);
-                ov = cpu_atomic_cmpxchgl_be_mmu(env, a1, cv, nv, oi, ra);
-#endif
+                ov = cpu_atomic_cmpxchgl_be_mmu(env, a1, cv, nv, oi4, ra);
             } else {
                 ov = cpu_ldl_mmu(env, a1, oi4, ra);
                 cpu_stl_mmu(env, a1, (ov == cv ? nv : ov), oi4, ra);
-- 
2.34.1


