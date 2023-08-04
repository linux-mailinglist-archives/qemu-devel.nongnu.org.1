Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EBB76F71C
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:47:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjsv-0002gn-Kw; Thu, 03 Aug 2023 21:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsY-0002cb-LR
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:30 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsW-00056i-Rd
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:22 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-564b6276941so353181a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113519; x=1691718319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcpamkfhLDMnz/NSh+jJyfv46fJPLLdBfB4ohxEUnGI=;
 b=w/CFoL3fiGS+wcGcDzl1NFRwUN99aU+rTAbbef7rHt2IfcrWgiwdfmLtRNBAWXOeTd
 p9aPXsj8R8kBcNhnYdu+LnrLJ9DTaW72ruso0Ijc2/MgQFuL7A8hdBy2+dLXCxQJ8ymj
 AdldVj3kV9dbOUkrM+DiWpMcDHLcufVaqKlTMxOj1pQqVNKH+teb7hDMAKAzs4DuscBZ
 VWmol1d2RRgxZ5o/ehSESlk+J8/jaJzv6ASFUUA12Uk9p8lTY0oqw/1ugJpX3tehX/se
 6oXPUQ6sJY29c9DIPijN38BMDcM/oOFP8IZYPjgJYoFJJ1ypl2zMtVg1HRcNubdZc/j9
 ZdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113519; x=1691718319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcpamkfhLDMnz/NSh+jJyfv46fJPLLdBfB4ohxEUnGI=;
 b=gpOpuX1m9/K0wP6ZqpiBOk7QoMqZw5dfF0hE7/FX6ez2wM1LTrpl4cNdsGcnAkyD6h
 J5vh1zLJ0yEnOBhM9HF6/0GF1OlRIi13uquzEAsDnbDgqYIrxFs7405+NqlHaJGyX1Ix
 q1WyPN+MXYgPk8wSEEoktll1Rsopt+stgnpDL9MwP6YVRkyfe0EfhZRDQoZoftgCrALR
 S1osiTGtTRt3O1pSX83PyqtSg5ZRaEg4QDYJPMIOIOV/iYdEi1UkiRH5JNVXvzG4kr92
 6FJDLI2+pMYKaoSQnmg2O4vIsJqwr6oFHznGdrL8dhagj84w41Fkz0XqDL8U+7WIB9dX
 OZMw==
X-Gm-Message-State: AOJu0Yx85lgOSYnn+283yc3gfv0TJt9RiQMQRGM+f0oH0koyWMqaVIpG
 ihSkb8gE/ZukmbZp8iUKJ2mtrnMLtbzCtryrOFU=
X-Google-Smtp-Source: AGHT+IFsWXR3YY+DjvEqnImeEXjR8oMIJ4ILVxQi2QFWOyh/I9Uh+EGICfaZMKE6D5DVaFYxrL7z2Q==
X-Received: by 2002:a05:6a20:7495:b0:130:f6bc:9146 with SMTP id
 p21-20020a056a20749500b00130f6bc9146mr408826pzd.14.1691113519344; 
 Thu, 03 Aug 2023 18:45:19 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78c05000000b0066f37665a63sm456138pfd.73.2023.08.03.18.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 18:45:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH v8 01/17] linux-user: Unset MAP_FIXED_NOREPLACE for host
Date: Thu,  3 Aug 2023 18:45:01 -0700
Message-Id: <20230804014517.6361-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804014517.6361-1-richard.henderson@linaro.org>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Passing MAP_FIXED_NOREPLACE to host will fail for reserved_va because
the address space is reserved with mmap.  Replace it with MAP_FIXED
in that case.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-2-akihiko.odaki@daynix.com>
[rth: Expand inline commentary.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index a5dfb56545..a11c630a7b 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -603,11 +603,26 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
 
-        /* Validate that the chosen range is empty. */
-        if ((flags & MAP_FIXED_NOREPLACE)
-            && !page_check_range_empty(start, last)) {
-            errno = EEXIST;
-            goto fail;
+        if (flags & MAP_FIXED_NOREPLACE) {
+            /* Validate that the chosen range is empty. */
+            if (!page_check_range_empty(start, last)) {
+                errno = EEXIST;
+                goto fail;
+            }
+
+            /*
+             * With reserved_va, the entire address space is mmaped in the
+             * host to ensure it isn't accidentally used for something else.
+             * We have just checked that the guest address is not mapped
+             * within the guest, but need to replace the host reservation.
+             *
+             * Without reserved_va, despite the guest address check above,
+             * keep MAP_FIXED_NOREPLACE so that the guest does not overwrite
+             * any host address mappings.
+             */
+            if (reserved_va) {
+                flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;
+            }
         }
 
         /*
-- 
2.34.1


