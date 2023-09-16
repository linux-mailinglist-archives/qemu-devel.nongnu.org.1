Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC3C7A2DC7
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:38:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0l-0005tc-JO; Fri, 15 Sep 2023 23:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0i-0005sl-F5
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:20 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0f-0007yb-S6
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:20 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1d63d38c74fso1327001fac.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835016; x=1695439816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnAwpjjPQYUKoAysf3zPVEkKCoe8u86MgzkiH359pjE=;
 b=wF9ehr93L6KQH9jGXY8u77lIZH5A7YXjCPjGISuf6ZgT7PZxmeSjgVia4LSBMI5VB4
 Cqlwr6IkbvHHvcK3rC2oirGC+Et4JmwqP90+J7HKNVhLb34qED/PGThiYXo447MCxCoG
 1cds5gltvYVE0/GOCxvTXpeDJHufk70EPYt4+r0H3MqkvfpF7IKdo3XXmChBRRT/DS7P
 w4nHL7HY+C7IyBX2nzNdDMYf4S7E5RGm8ho98+qdKdwmg4epLPXumHIvhuG0lI1rbtac
 8MI0R1IHIjtGC7MIgnuN6jXKLwb4QsLvxX5x1WFPeRE/04a/ZXjpnhGktuR12o6sZhTb
 PmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835016; x=1695439816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PnAwpjjPQYUKoAysf3zPVEkKCoe8u86MgzkiH359pjE=;
 b=u/WOtjDmGTO9/nnQKYLyaXlD+BKlqQf/YiKzPUem+UQ12ixL+qy3FejGC0A5volyR1
 Ud+oZzNDERFckWRYyEtyix0A8J+vi8SUEaQE4fqpV0omgToY00JEa+Erov1YpwOiR/qg
 ldrIlJKHIyuc+mwqe/DGRhn38gBP2/GngxguRsktY2btnIFFqqpe3GhUXdHT8Bx3iUc2
 yp8VrC4h7rn6DHLCA9V8kjHtKIxsJPQeKNKrrmIZuGAbsNAHxxNYNPY1Q5/DyITEsRRa
 KV48Rc1OtslurYaWk0QGMlix+zKkuSjmVFQ3QdPmbSPdPQ+Jigfz7Qyb/PclS9z0Ut61
 EZJQ==
X-Gm-Message-State: AOJu0YzQUvCEeJh9wMm5hwPllRSFAd/SLrx2z2h6sLnQ/gOFH2wibz4W
 x63yOmJ15cnwXyYWSY3oU7z4pIwJZAfynS0Idqs=
X-Google-Smtp-Source: AGHT+IHbPIb2BqSPoiKB0rrFZMGq3zm3xKc27pL+nLIxLPjLEQPqay6ZaC2SI/g0l1HQ9fmKspdcSw==
X-Received: by 2002:a05:6870:418e:b0:1a9:caa6:1337 with SMTP id
 y14-20020a056870418e00b001a9caa61337mr3941489oac.23.1694835016370; 
 Fri, 15 Sep 2023 20:30:16 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 03/39] util: Delete checks for old host definitions
Date: Fri, 15 Sep 2023 20:29:35 -0700
Message-Id: <20230916033011.479144-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

IA-64 and PA-RISC host support is already removed with commit
b1cef6d02f ("Drop remaining bits of ia64 host support").

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230810225922.21600-1-akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/oslib-posix.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 4d583da7ce..e86fd64e09 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -585,7 +585,7 @@ char *qemu_get_pid_name(pid_t pid)
 
 void *qemu_alloc_stack(size_t *sz)
 {
-    void *ptr, *guardpage;
+    void *ptr;
     int flags;
 #ifdef CONFIG_DEBUG_STACK_USAGE
     void *ptr2;
@@ -618,17 +618,8 @@ void *qemu_alloc_stack(size_t *sz)
         abort();
     }
 
-#if defined(HOST_IA64)
-    /* separate register stack */
-    guardpage = ptr + (((*sz - pagesz) / 2) & ~pagesz);
-#elif defined(HOST_HPPA)
-    /* stack grows up */
-    guardpage = ptr + *sz - pagesz;
-#else
-    /* stack grows down */
-    guardpage = ptr;
-#endif
-    if (mprotect(guardpage, pagesz, PROT_NONE) != 0) {
+    /* Stack grows down -- guard page at the bottom. */
+    if (mprotect(ptr, pagesz, PROT_NONE) != 0) {
         perror("failed to set up stack guard page");
         abort();
     }
-- 
2.34.1


