Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B64CA70A911
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PQN-0003ot-VI; Sat, 20 May 2023 12:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQE-0003i4-U0
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:12 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQ8-0003Aq-Q6
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:10 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ae851f2a7dso11662285ad.0
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600022; x=1687192022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qaZpDDjPwlY2m7x6v9ar9hpPELeL8Q6hzaJ5d16jETI=;
 b=U2/mcl5/P+7RETzri4waiMyUilkBv7sfeUJDAQF/mdwr6jDCvTX1jwvGvtYEg+KctE
 DYUMOlvF0E9a+ifbbgo5CfvJvkRFDGhnnTE5lQZq0IDWDgSMhLrNyOI/FA/kcyDsW016
 f9YDA63+/UuJHRxMvYvUF2URHuEGGXQmSxJi//cvfrhDVKYbFNh6yAEWXj6IyQT5BuSH
 McEQnIWDL14nNfVPpoBA/JJKhrNcdMvNy8Gx53akC7aIhFFNJ13BlEwyTAOkWsPyLRMZ
 9ftWFpO2D227iLt56McjV/fdqbDUtjUCGYKwM8LEkMjsq+HiG4CANQSzFcwAB80yehlZ
 uG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600022; x=1687192022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qaZpDDjPwlY2m7x6v9ar9hpPELeL8Q6hzaJ5d16jETI=;
 b=baX87BB2XMo8xZ4TO6wvVWpyGjuZ/xXOPJQB8ot98ya2iIHbTOsvToYL/o9a7hqfwf
 JTtbd03fZXMZ+Q8b/G2u0eeQ+my9/4RJZE9eYV9UAv08cpwe2XM++90mViqpdFhkfusi
 sMV4YZ43qaxCTnKcELJPI4qu6t0fz9L+jzkC2IoGs4IB7xqYNovFn7RBUgeVrXBtzKRD
 0Ocw020ARF6hpU7ovsloJN/8j/xxZpVRn2jVjgVGAXijpCsdaMmoqWkfIXo7Qy/z6FXV
 WlhRCJelUbQzuPbWYWQGHV48zMT6sR8ClGNbweujILgtt42EniRbnG8BK2iOzg5uGLAn
 OlDA==
X-Gm-Message-State: AC+VfDwzufV6RJydVbsWNMKWceW6aIWe0UA5bibMRWRelKs1e9PtQYsI
 C4VHNCy3VfB7GUVpnRqtkLq4BMttNqXcHXESZz0=
X-Google-Smtp-Source: ACHHUZ4+6uBPA30u3LOkA4F8c7MnD1PnhMxrPAhI5h5h6TTJdSmiUXokTWRfoDmT7UX4b9beREKayg==
X-Received: by 2002:a17:902:e74e:b0:1a9:a408:a52f with SMTP id
 p14-20020a170902e74e00b001a9a408a52fmr10584163plf.24.1684600021975; 
 Sat, 20 May 2023 09:27:01 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:27:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 18/27] target/s390x: Always use cpu_atomic_cmpxchgl_be_mmu in
 do_csst
Date: Sat, 20 May 2023 09:26:25 -0700
Message-Id: <20230520162634.3991009-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: qemu-s390x@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/mem_helper.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index b6cf24403c..bad789a742 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -1798,13 +1798,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
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


