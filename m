Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB73270DDE6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:49:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SMn-0000iP-RT; Tue, 23 May 2023 09:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMk-0000Y4-BY
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:54 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SMi-00018Y-1d
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:47:54 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d1a0d640cso4495553b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849671; x=1687441671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMMLECzBZvLbq8oOai1RMIPgWJmrRTbYQa8uL1NZwrA=;
 b=o3YpeNIKKmZRvW6OjT2jKQc3duTvw+ipPacNIrmqAPJ0RkTDK7hJyppfz1sfth8tYl
 Ocu5dSHd4vDKvjANuZsp0bfd65Op5ifQMpUos+KjqifDtD6drlCONGA14Sm2ua0x4zrp
 8W3fU6h/Vcjt8+8H0OSiNQJEnwYWJNUj92JY1kxEVWmAjDukLnWcTGkmfE6sAyXZm3Yg
 9b+fSyi9tM+WROrLdBmoebCBjD6hBRwaosAA2+DFuPKM02v+xaw/O5EJZcxoQL7wlIC/
 4RONZpn4IxymfNHUW55SHVYkKqxYoWDBQQDGI8l/VC8DN4aK2/eZpyFXHenKrM9U3GsP
 HZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849671; x=1687441671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HMMLECzBZvLbq8oOai1RMIPgWJmrRTbYQa8uL1NZwrA=;
 b=QJu8jwMHpfMY1NCSh+Eh4szVFHbGQEPSajNdBSwuZtoWCWXnUF3GAGt8iPlru7vPQZ
 8qqJCW9OqsUKGzkYjuNTWWRWYOTg6NKJUP6wQgMt23PfMS7DfBhCLTGWy6gmcIiaEx0Q
 vwGlXV2vpETIxYBBzPTW/cB15dfb+L90RcxfbDRCUbltih7l+5X3OBoUb8gzl4lDzyu+
 ciw4OsJ7JxDzuHIcYmNlzkRCYTcP2fpxQoSGEOrw9ifMUYm/K3yiFDtxx81WI0ueEpUs
 h2S/h/BajWnnKzORBoPkgPCVYpy8RF5b9ggAR174UWlNiKgx4UUlT3/AIRkQIeBxFOW5
 4AYw==
X-Gm-Message-State: AC+VfDxlK2zAzs8AIRJAx9ObGoIl3uU5eAPSamimrA+pD0fbuqcPvsg3
 QBicbs+Sv4kqwutr0Jt1Z0XR7k/xQtiA3rU0se4=
X-Google-Smtp-Source: ACHHUZ5bJsoG7ZPPG8CrCFypqS/Ko0Pjk8i/VQ8RkMR6sBCPVIWNFN7vN4+P8HGvmmVAtAZ7xGFc7A==
X-Received: by 2002:a05:6a21:329a:b0:10b:4f58:3fef with SMTP id
 yt26-20020a056a21329a00b0010b4f583fefmr8903765pzb.2.1684849670804; 
 Tue, 23 May 2023 06:47:50 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm5737122pfa.199.2023.05.23.06.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:47:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 18/27] target/s390x: Always use cpu_atomic_cmpxchgl_be_mmu
 in do_csst
Date: Tue, 23 May 2023 06:47:24 -0700
Message-Id: <20230523134733.678646-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523134733.678646-1-richard.henderson@linaro.org>
References: <20230523134733.678646-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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


