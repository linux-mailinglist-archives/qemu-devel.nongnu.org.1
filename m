Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 965F476F71A
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:46:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjsw-0002h7-2D; Thu, 03 Aug 2023 21:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsc-0002cn-Be
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:38 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsY-000574-Iv
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:24 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-564af0ac494so477455a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113521; x=1691718321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGlGyVbf5mAt3X+pirtJo2XZVAZPR2luQo7KvVPWG+g=;
 b=kcZtU3YxWpNkprmQXiWiLFO8ck28BThWvw9h+/g8UXdewLliVapiIV2LON3nN0xARz
 D9WWqZZ3mlsbi1cYQEOfrOb6fi78v5riypqLG9zlqPEL19hFb4AxpHqjQw9gVSz9Ij2V
 c4AarmcsMUWDQGtR44gq8i9Unf9hqOE1Az608HKWZvP9pQdSenhWUbtwQnnAxr4OWQlo
 EsA2VenyWIfhcf+X4d/vFrb7b5ZQIkh3vEcXeJiZ41IXOPKkbdX1gRJFqygDQZfN2zke
 nrojJyhVMUvbkUz5jStEd2to8ISsEDtk3OrpOEtrDd+fP6VbTlKgiFbMzFLB5aNaE6gU
 GDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113521; x=1691718321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGlGyVbf5mAt3X+pirtJo2XZVAZPR2luQo7KvVPWG+g=;
 b=IDCOIQoIPFJbA//K2K5mJAS9Km8YEmtYVh8gkBKSlwfMyoGhYjU2CS7h95/AhxrhRY
 +/Dt02ebFpyQKHq9GmPh8rQ7xJDwyHr9VW/ObhZQCPHQlzDvz+LTlJrZnzNUgUFWq1yQ
 wRQKet55AsCSC8BC6A/W1DvcQNzV/o11R3s9cO6Mz0DbDd6mYb8i0tlkkWuVt5YO2nms
 5RK8Q6gKgf7EAT+QAU+PdZdUYwR1Yb2oTI9ZWi/EZUK1nU9fhCdiWa2sIohAhZRvGXWQ
 so49XY9qqgU2IgUt8Hv8TXKuaQcb8BGROqmY7Wwz7m0vuvS9UCy1izK2tTKvmgblvsrh
 B20w==
X-Gm-Message-State: AOJu0YzNGwpawzTOJ04cu7nMIH6gBDjigpBr32VGBvmTZsjUUqhxctF8
 NR908qU6ZJ1IXDUdAzf7nue62aMwekHARUPT9yo=
X-Google-Smtp-Source: AGHT+IHnwqFojHI81K8DV3O0xyw9izgYmoDcs06ENGFU22WmEUy/4owxoR2SFDmlVFYezjn+HSGewA==
X-Received: by 2002:a05:6a20:139a:b0:13e:f5b5:48f5 with SMTP id
 hn26-20020a056a20139a00b0013ef5b548f5mr206361pzc.27.1691113520936; 
 Thu, 03 Aug 2023 18:45:20 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78c05000000b0066f37665a63sm456138pfd.73.2023.08.03.18.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 18:45:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH v8 03/17] linux-user: Do not call get_errno() in do_brk()
Date: Thu,  3 Aug 2023 18:45:03 -0700
Message-Id: <20230804014517.6361-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804014517.6361-1-richard.henderson@linaro.org>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Later the returned value is compared with -1, and negated errno is not
expected.

Fixes: 00faf08c95 ("linux-user: Don't use MAP_FIXED in do_brk()")
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-4-akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 95727a816a..b9d2ec02f9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -862,9 +862,9 @@ abi_long do_brk(abi_ulong brk_val)
      */
     if (new_host_brk_page > brk_page) {
         new_alloc_size = new_host_brk_page - brk_page;
-        mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
-                                        PROT_READ|PROT_WRITE,
-                                        MAP_ANON|MAP_PRIVATE, 0, 0));
+        mapped_addr = target_mmap(brk_page, new_alloc_size,
+                                  PROT_READ|PROT_WRITE,
+                                  MAP_ANON|MAP_PRIVATE, 0, 0);
     } else {
         new_alloc_size = 0;
         mapped_addr = brk_page;
-- 
2.34.1


