Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D5F78CA1F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:04:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb27K-0002Zb-LL; Tue, 29 Aug 2023 13:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb278-0002Sx-2l
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:02:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb272-00051N-I1
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:02:46 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bdb7b0c8afso28366965ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693328562; x=1693933362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LGuoxVvMU6aem7Q6XdFNRJrRZCWqnrvT0uINgJVeIFY=;
 b=AMPFPl5aZoJvEyneJbMUO5oOVau75/4U7nXf+Z/UTSTYLn8WOBXz0/VsmI3YgpO7Hl
 pc5OEO5uyFbbruIJS9kQqCbVaMG5dSDMywG0W8SwhPezivuO1TLH2LWpFEs+2kigs3XG
 ABNxwLSm3omtqiISEUCzh3BGzz+uwH+MGqtNungd0YXNA2ebc3U5UzRrfTtGpWReif0h
 fEkS8ZGa3QawjS3VrvtDSxveqsDUDN5jhy4+kaFxUcUcHxrRlZ7MlSPUVISAVMK7X2WV
 qOnZW5ReHaISNs1cZOHlM3dHvWhs7f7Nm7pToubd1J0I1lutZvfNa/O124CJ9N7bsx/L
 ZClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328562; x=1693933362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LGuoxVvMU6aem7Q6XdFNRJrRZCWqnrvT0uINgJVeIFY=;
 b=dNve8gWv4I1MCdq47xu3MadWjerKMUCvQ8uURIL4lsYvBUaOGFIgS9Yr1mnZBW4jaF
 S23zpzPoeVldIi6oDVrnnaFD1pWRxvP5aUDVhZcC9cBdiRJtdHgU1r37gRUvDG3AbyFg
 aP3bYxoee4Mw4qGVXAAqoVA6G9z3KC8Hk62R+W0gfzt24oWQG+jDdT9wJm+PRlIwLRlS
 XQ20k2M+7Bz1ndL//Prw4QwXl7iSlEiRokQP16s+Sd4LMb6UtoYSA5k/2iK3+XGV8h+b
 kvefIAgL4gXNfQKuMn4YRqsbfIMHFHOnna0VZFLO2IeyN78g1eU3+nKHVA9ahJZUutDp
 Cjgg==
X-Gm-Message-State: AOJu0YycSKHVq6mpbXsDgtL4Y2p94QblPFMgnJJYqaY1pN+ceIDSMkgH
 9MvVdZyUHi7KLAjnoxehjOdJkDvbRsuxZNDGL1k=
X-Google-Smtp-Source: AGHT+IFmJ5/siakb8z5t5YE+5c4tLI0ld1TH7dZziXNC56MKDMMxmuodqQgSKUjadzMTlhnPDatKlg==
X-Received: by 2002:a17:90a:cb02:b0:25e:d727:6fb4 with SMTP id
 z2-20020a17090acb0200b0025ed7276fb4mr23520014pjt.2.1693328562484; 
 Tue, 29 Aug 2023 10:02:42 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 cv2-20020a17090afd0200b00267b7c5d232sm10989645pjb.48.2023.08.29.10.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 10:02:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 1/4] softmmu: Assert data in bounds in iotlb_to_section
Date: Tue, 29 Aug 2023 10:02:37 -0700
Message-Id: <20230829170240.765996-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829170240.765996-1-richard.henderson@linaro.org>
References: <20230829170240.765996-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 softmmu/physmem.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 3df73542e1..7597dc1c39 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2413,9 +2413,15 @@ MemoryRegionSection *iotlb_to_section(CPUState *cpu,
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
     CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
     AddressSpaceDispatch *d = qatomic_rcu_read(&cpuas->memory_dispatch);
-    MemoryRegionSection *sections = d->map.sections;
+    int section_index = index & ~TARGET_PAGE_MASK;
+    MemoryRegionSection *ret;
 
-    return &sections[index & ~TARGET_PAGE_MASK];
+    assert(section_index < d->map.sections_nb);
+    ret = d->map.sections + section_index;
+    assert(ret->mr);
+    assert(ret->mr->ops);
+
+    return ret;
 }
 
 static void io_mem_init(void)
-- 
2.34.1


