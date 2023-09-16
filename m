Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C11CA7A2DC5
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM17-00065X-NL; Fri, 15 Sep 2023 23:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM14-00063v-No
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:42 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM13-000850-8J
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:42 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68fba57030fso2636203b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835040; x=1695439840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u0AuYZutp/iLiCcCm0QzvSuRpv7NI6KdrAuHS+GXldc=;
 b=qGHn0WuQlS3WVExlJyNEaU5eYjUTk+WLwEnA7pYagDXk/6sXEdG1GbMTuNHENg19WT
 ubiBVo0t5Nwwb45fawCfgyoSexjw45PXMjdP/EoDs9L15p+TtCl0Hv1YW1xzdTe7pDoW
 rDQAwolYmpnW8vt084GL1mfeppfR6avgJtM2XZfElywZPowu/RlTIgTGNHHAQRC/Ts48
 5G4CUfziyK811LlfpkBVD9/wlEIbGq54Xsran9Ljmb3lFWH+phYpvayOI1F/ANUxl2E2
 cRSTWiQgJh65EvwBXWrUkEjIZe1JgajEZ05oEjrR40mz5NIxYIYqgU6AoTU/+9twrMb1
 +oGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835040; x=1695439840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0AuYZutp/iLiCcCm0QzvSuRpv7NI6KdrAuHS+GXldc=;
 b=dWqGtGqcWNTMbLorM+Vy7zk/TNuO6mLnJdtKVquOKHKWJYZIs1k+nNuOjCGT+JoM+h
 sRPulvuIGhrH0nAf3LHAnO5jvQ9Jx5jHv2hEVs+OM/UtTBV9EifkZatE0VZ/LeI4RcXQ
 xw75VNpNPcENvNIeg6xniTPkwS74H/x37usY8j1TASE4Nzf2gUpU72wchqpxXiT/F5z1
 nCb9HwbKzWx0/eCACtSL35Xbgyz5yIvBtf3TXsmH61C51UhT1FiTHAbv+pKn1dDrB9d1
 w97SwNlnfgWXASbuE1j00cxHpnf7aMLktKdi2c8AvkadhF2rNwWj5+x93MGDOBcqEloD
 z+Ow==
X-Gm-Message-State: AOJu0YzEsy/Cj1Qbw3uts/yDP6Yw9ytlDlBPUN/h2oYhkN02zZpG0Osy
 m+rGabskVfeBDZdBnt75gIOKyWFBBj5psmDPp8k=
X-Google-Smtp-Source: AGHT+IGWHi0nLU7gabZzv/3Ww6V2TpTadIeBP0/62ruPrrjpGEbZFLV2E3vPxSqvjHc3PSfRxpKz+g==
X-Received: by 2002:a05:6a00:13a9:b0:68e:35e6:4b02 with SMTP id
 t41-20020a056a0013a900b0068e35e64b02mr3868742pfg.23.1694835039973; 
 Fri, 15 Sep 2023 20:30:39 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/39] accel/tcg: Replace direct use of io_readx/io_writex in
 do_{ld, st}_1
Date: Fri, 15 Sep 2023 20:30:01 -0700
Message-Id: <20230916033011.479144-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f3635afb36..cc36e681a7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2342,7 +2342,8 @@ static uint8_t do_ld_1(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
                        MMUAccessType type, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        return io_readx(env, p->full, mmu_idx, p->addr, ra, type, MO_UB);
+        QEMU_IOTHREAD_LOCK_GUARD();
+        return do_ld_mmio_beN(env, p->full, 0, p->addr, 1, mmu_idx, type, ra);
     } else {
         return *(uint8_t *)p->haddr;
     }
@@ -2857,7 +2858,8 @@ static void do_st_1(CPUArchState *env, MMULookupPageData *p, uint8_t val,
                     int mmu_idx, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        io_writex(env, p->full, mmu_idx, val, p->addr, ra, MO_UB);
+        QEMU_IOTHREAD_LOCK_GUARD();
+        do_st_mmio_leN(env, p->full, val, p->addr, 1, mmu_idx, ra);
     } else if (unlikely(p->flags & TLB_DISCARD_WRITE)) {
         /* nothing */
     } else {
-- 
2.34.1


