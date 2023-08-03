Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 833C676DDAC
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:55:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWY-0000dr-Om; Wed, 02 Aug 2023 21:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWW-0000dP-2b
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:08 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWU-0000j3-Hj
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:07 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7656652da3cso29663985a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027585; x=1691632385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcpamkfhLDMnz/NSh+jJyfv46fJPLLdBfB4ohxEUnGI=;
 b=vBbIm4OMvxNnQDlgaD4YReZqq86tCOIbKHBI+EadX6byJP4oV0k8Qya5a9MUk5cZe3
 Xn7WtQ024EWTyHxFfxPWE6x1OEefbgS2zsBT3zNwWNQsLbF0Pi2JMTejX/7sZYqAHKVg
 sREv8uU6H2RrNIL6Spo/tGEZY0VM9E4Cc3iAOoItrwM2HrjChgTKZdd3WeF+v8m/VL+9
 Cb7zFV9eQ9Ss2BOsWx7ia/2H5sJxz6OFGMpDpKHlVCc1dGntevwJMnAuAuI/jPhsKoYI
 wDbq7MyVDFMqjDlK7oagAD+Rtc1JY8NHUyhWjxb+UzXm8fjiFsY+ZvmtEsExTYwYsMiU
 VVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027585; x=1691632385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcpamkfhLDMnz/NSh+jJyfv46fJPLLdBfB4ohxEUnGI=;
 b=Sjp/82IxMeZ8wxqSgK3bRvLr+i9Qf569023b8YB70ZoU9uJKOqeL6/Cdk06qvBV6Xd
 rJdl1pFs6U1Xj47l6KXI5i3qZF5iE58J+FRalfVEGxmZY6GFuhRXMbFzpeBHq1ELKXCy
 GqN7U+XTO+j+Cqu3Fec6FW7PxNfUrhuCVZMBZtRE9nmnQL5enzp+aYxHcziEmgKBcni/
 JaTkB+qDmXANScDIGeEF6ePVhoy44It2KKTlXBnJt4wrseATvGqZpt65defkvQ3lf30b
 zw7d4ZVL80m6eIQJoEkOdqcagwqXhOyXQz5z9AmxEFezgy3VlU8YCKaR9rpIdDHI5zS7
 iFWw==
X-Gm-Message-State: ABy/qLZ9/YOrEbHhynflPVYtE646AQ6QLj73K34LC+Nff8kR+l/K5Jwa
 Du5hsY3vin0qv/jEDOmZKvyTT2fWfOeqELcSaAk=
X-Google-Smtp-Source: APBJJlFJGIXRGNAiYdBULk8VUjAKJKlq7WdbB03RJfPFiK6Vc63uSnIw5jc7RQoEfaMvHvUA36qgKQ==
X-Received: by 2002:a05:620a:4105:b0:76c:bb4d:97cf with SMTP id
 j5-20020a05620a410500b0076cbb4d97cfmr9543796qko.24.1691027584875; 
 Wed, 02 Aug 2023 18:53:04 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 01/14] linux-user: Unset MAP_FIXED_NOREPLACE for host
Date: Wed,  2 Aug 2023 18:52:49 -0700
Message-Id: <20230803015302.407219-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72b.google.com
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


