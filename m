Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF44825774
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 17:01:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmTS-00036j-Th; Fri, 05 Jan 2024 10:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmRo-0007aX-48
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:49:27 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmRl-00089l-If
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:49:23 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-336990fb8fbso1225269f8f.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469759; x=1705074559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HnuyTIxGYsWykQsG+bF/A0ZdepEt+u1/qeWfQkxoXY=;
 b=W5IRGN+q6DxEAK7IZ142Yb6IQ7SyaNnnL42Zi3OjH8BHb3APSAzo3/QcBLKwzXUKdk
 e6Mkz9HGBxDx8rVeGuNK2jOtNrjL0jAVeMGBY7b2XLo4Tayr6136TGASp/O5c0jggpU4
 gZaycS75NjgbR9dsRwT2ir3octbXCuBd6/nG9ecY2wsaqg7GDDwoLKApGOfJpkBNCV6x
 A5cGl5zFNSDisVBRiwrszNVn2k9W4dhBq4kh1W+odEl5du13AmPIQ/NQPdH31CABblza
 SeIxHR2/ZEjEu18tLg62ds9RFn9qD3EXRiZvHn6uNqoXJJiYpqdBUWfmT7aBx2ZiZKg2
 EBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469759; x=1705074559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3HnuyTIxGYsWykQsG+bF/A0ZdepEt+u1/qeWfQkxoXY=;
 b=N8iBysN30TQDDqWQAItx/QTNI2zbR0RFGZKCI7vn/adUuHaLoSLIQOQOBsYDy7fRZW
 Flb1FINRwJkd1RFqQlJ2Z1hyFF0pnxE64skORu4l+ZJmr858j/p0sCTquHtnZLk48K3i
 +AhernaE8pCoOVGgf8Mrx/rINjGJiX6KzDAt/K5mv5U1nSC7k28m2h5Jlq+E344bisft
 Hh7BisJOWL+lgdARr3Yz7QwYnaThX0MB3/MRKPOS5vArO9WD4QXaw3XfGfAsxLYrI9/o
 lz2ZH1r3XMCQgv44hoIKYqbhkULF9kM8+FXRnbOTMLGtTbBxGW7SkQMlSu9yRKiwzb5A
 O16Q==
X-Gm-Message-State: AOJu0Yz7hufI6i0Wpe00aRRrRDtpYcNt2LzCx5GKJzY48rarW/hnwb9L
 sk04k6P7TB/CONUtVPSJkThFIOvp8CEIx7maku576/P/XYk=
X-Google-Smtp-Source: AGHT+IF0Pyylu6bX+CfbQ1+REdITz6wqERsRZV89jAdI+Yqci0wvAbIS9//YMrS8A8aLBTnEpv3jBA==
X-Received: by 2002:a5d:5cc3:0:b0:336:e399:6fc7 with SMTP id
 cg3-20020a5d5cc3000000b00336e3996fc7mr1040828wrb.59.1704469758884; 
 Fri, 05 Jan 2024 07:49:18 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 k4-20020a5d6284000000b00336c43b366fsm1618203wru.12.2024.01.05.07.49.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:49:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gavin Shan <gshan@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 60/71] backends: Reduce variable scope in
 host_memory_backend_memory_complete
Date: Fri,  5 Jan 2024 16:42:53 +0100
Message-ID: <20240105154307.21385-61-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Reduce the &local_err variable use and remove the 'out:' label.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-Id: <20231120213301.24349-18-philmd@linaro.org>
---
 backends/hostmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 3f8eb936d7..1b0043a0d9 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -324,7 +324,6 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(uc);
     HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
-    Error *local_err = NULL;
     void *ptr;
     uint64_t sz;
 
@@ -400,15 +399,16 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
      * specified NUMA policy in place.
      */
     if (backend->prealloc) {
+        Error *local_err = NULL;
+
         qemu_prealloc_mem(memory_region_get_fd(&backend->mr), ptr, sz,
                           backend->prealloc_threads,
                           backend->prealloc_context, &local_err);
         if (local_err) {
-            goto out;
+            error_propagate(errp, local_err);
+            return;
         }
     }
-out:
-    error_propagate(errp, local_err);
 }
 
 static bool
-- 
2.41.0


