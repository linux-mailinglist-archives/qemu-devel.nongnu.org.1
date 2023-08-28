Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8391278B7AD
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:57:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qahP9-0000r1-P8; Mon, 28 Aug 2023 14:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP7-0000pr-D3
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:56:01 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP5-0002SC-9Q
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:56:01 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-268bc714ce0so3097399a91.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693248958; x=1693853758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kes4dWAfnCF0sbsmuI+kEptn1hS/yp74fg4t9duR770=;
 b=PVlt6LU7ElyNwkbZTuIdBKWHN+yZ6AbiKL44WN+tpuTzvnCE7I7CoIGJ56vbugw01Q
 MX9ThoXSE2u0HkHbIJOGiTbabNx0NVFe3bv77/NJHQks6qAOdLc4vHJTHoicedeyyp7p
 +qeTA/UiRchYgzr5zFpuVfxIROdOHKXvW5nfbxJOMlXw2L/7v6j9yQhPlZQQmWulQJIA
 3QQudAU2YgC/BL8+POFnEBIa3cTzFxvmUiUZBDsvDNUGzBQil9Tx0OakHg8mjvo51Q1i
 aH7hVo86Uid02hMEue3P3tJMZVwSBio9idOU+EqjN1vspAiyjeRPtuPIoCAb6UQWMwIz
 x+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248958; x=1693853758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kes4dWAfnCF0sbsmuI+kEptn1hS/yp74fg4t9duR770=;
 b=d37QsIAX1/RDrrpw5OdYKqxB+n95e5vV3OTDL4c7HEm4zqYbOBGVCELSIvLqnf5p2i
 bXnum9WeTjf82MR98kQXLxb5nWHpmgmolnZgy389mj6P15mIST7xiUiNnmjuH0Tc13gK
 2HrdmZ4lzbmBsa61uLrnoimJDdIbEAsjxZAbNPdM0O5x+8AaU0p4eXJp/jxahxQyXJ8V
 geQIO+ZcNEOsRdjD5QhsEXub6SUvTHutXvxFGGcriVU9t6YF8RUZ+xFmQBPYsB5goyrd
 x5BAvgvtohM5MC5iMjPDvMMnvaId+U7WoTQSaWKQae5qonLgcb8J+R8PiHnomVNdLYy7
 Mmaw==
X-Gm-Message-State: AOJu0YxUaHmkfbny2W6HqPFQgSK16aoZMkdVDpD0KoNyxB9sj/60WJaD
 odP3on/jOr4Nnt+AXtgdbmnD2cV35vk/vgg5P0I=
X-Google-Smtp-Source: AGHT+IHQhAuWnC2xkH68grGmKg8HMs71amh8ABd5xowlhuTkGwZt/iiaYRjyBOKXIl7EAjAAfx8erA==
X-Received: by 2002:a17:90a:d185:b0:268:808:8e82 with SMTP id
 fu5-20020a17090ad18500b0026808088e82mr683519pjb.1.1693248958105; 
 Mon, 28 Aug 2023 11:55:58 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 4-20020a17090a190400b002680dfd368dsm7932835pjg.51.2023.08.28.11.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:55:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 06/10] accel/tcg: Replace direct use of io_readx/io_writex in
 do_{ld, st}_1
Date: Mon, 28 Aug 2023 11:55:46 -0700
Message-Id: <20230828185550.573653-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828185550.573653-1-richard.henderson@linaro.org>
References: <20230828185550.573653-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
index d2e4c4459d..6a7f6bf701 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2339,7 +2339,8 @@ static uint8_t do_ld_1(CPUArchState *env, MMULookupPageData *p, int mmu_idx,
                        MMUAccessType type, uintptr_t ra)
 {
     if (unlikely(p->flags & TLB_MMIO)) {
-        return io_readx(env, p->full, mmu_idx, p->addr, ra, type, MO_UB);
+        QEMU_IOTHREAD_LOCK_GUARD();
+        return do_ld_mmio_beN(env, p->full, 0, p->addr, 1, mmu_idx, type, ra);
     } else {
         return *(uint8_t *)p->haddr;
     }
@@ -2854,7 +2855,8 @@ static void do_st_1(CPUArchState *env, MMULookupPageData *p, uint8_t val,
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


