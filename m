Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E407899DB
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 01:25:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa2dx-0000Sg-3l; Sat, 26 Aug 2023 19:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa2dj-0000RF-CX
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 19:24:24 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa2dh-00066K-2i
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 19:24:23 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a7d4030621so1308286b6e.3
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 16:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693092260; x=1693697060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAdtNsi8ueSm/FaTXl8r9wCJNZiral8qMJdVDfCEFMk=;
 b=Bj7QkS7hD9216l11I3EMVFauRe9ao8eKIoZ4dWgTJlCkCMGOUHC/l9h7+sA8vtK5RQ
 dmiumzA6SOYPk0/tBUZ0LIzL09B39pcjq+E8F02QgGGgx7Bmx4eAyaMxlIcn4O/50bd7
 smVzm0gNsai3hWpV+nj6rQmziJbJ446R/V4J3MBrSgQu/yGaWLyl5qTnY5dD9rFJdeyV
 RNvOI7q56azjBiA2GAfL5Ytu+DowT1Y3ZUID5Byk9bInJMvZ2gU323K1cGJoQ634LZ2l
 FNC1CvJwSOJnsl97g42IAMW4xR9xRFNtsVirNRcXnNOG/7/TXPCqbrhe6wr3YfMwUX7X
 3BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693092260; x=1693697060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAdtNsi8ueSm/FaTXl8r9wCJNZiral8qMJdVDfCEFMk=;
 b=S+EpyMcJLt8crxkCjKW4cD3NirNWJzLQphiZa+KhoP79qcJJo8Y7pYIqLZzdoBqSEu
 gv1P0Tj8XWgvKACi+y6Pw5/J84nFJgnPWc2TS7cy7Uj23FdfCT5Ha702QFw/0DaiKEZK
 Y/W1uvJ3QwGUJD1MDRHTSd1/SlWNUVIe7T67a1gDVgeU8LwhF7UXwzxMx5F0Zk3cQXuA
 VqoHZ0kgbD8y0BFKzXbVmzXYEJo/ZBGOzz24dbyZTfnYHF3mit4kR+spu8r0sy+yvJ2j
 KxfEWwzpgwM7KHzZhj0Y8Bqcc3CcwJoBSV3YHHTut5cdnXd7V0Je9HTIFdG84xlr580b
 Rtdg==
X-Gm-Message-State: AOJu0YxHsDUSA37sBpCAU9Nrn4YfYbZxbEU3k3IyZjEln9UfmusJSoAH
 uJosSP8KwEWKLbLQv577YdAmVFxIWwWqRGUTHu4=
X-Google-Smtp-Source: AGHT+IFGQSDjBPOivnu8wndlmSTUGralGMGA1QVHPYMriPmvBAhlCTbOOp+WMhkyRouPg+kYX3459g==
X-Received: by 2002:a54:4f03:0:b0:3a8:443b:d87b with SMTP id
 e3-20020a544f03000000b003a8443bd87bmr7235361oiy.34.1693092259406; 
 Sat, 26 Aug 2023 16:24:19 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 u9-20020a63a909000000b005633311c70dsm4226472pge.32.2023.08.26.16.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Aug 2023 16:24:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	pbonzini@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH 1/3] softmmu: Assert data in bounds in iotlb_to_section
Date: Sat, 26 Aug 2023 16:24:13 -0700
Message-Id: <20230826232415.80233-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230826232415.80233-1-richard.henderson@linaro.org>
References: <20230826232415.80233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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


