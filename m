Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBD2779522
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:51:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVLs-0005kC-Ok; Fri, 11 Aug 2023 12:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLn-0005ip-Iu
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:50:59 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVLl-0001Le-Ui
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:50:59 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bc83a96067so16148305ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691772656; x=1692377456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BbPoiA4hDTDe4hGu5oLPJ3b2yV0sQkSxEUBuznSGCYM=;
 b=QsKlJln/1tTBPB5wpY0CMcxDjuYE3SYt1z6TF7b2RKj8BpD38A8CIPv+RtJjakYznV
 bCpG18PRps215iekak1X2REf7FuLKdJLp4LbXd64+dj/cd51f7xAX551cUCSwAGQbyvw
 KbO+tb1cmY7yM1zGNMXibNm2GysVemE4IKD+FX6g3sE3uznHObcIezIHOZ5dXGidVf1e
 VOogD2B5l0UM6Vt0GYAGjV0LvqsS23KU9qhWBAmhKX+V0ZPtSFsUfVO3d5o40xx44VMl
 OhfR0wypaVbsWx1kaqncTzOh7B8gUlzGRZTqZkWwMMqcp/rJJU3I7DbDdp+VxmBLqV/6
 JReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691772656; x=1692377456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BbPoiA4hDTDe4hGu5oLPJ3b2yV0sQkSxEUBuznSGCYM=;
 b=OeCoKvx4v/GbwNzr+mYjpDX3TsgkxopAerqVsiVJgmlNS+gdLqb8MSnz1F6RUbM6EN
 DcgMSR1++uruhgO8QftJV2pONpUVGWBHYQSuUQIYtr7to26khKaPOCybMcB4QQ6XqMZi
 jC4eR14zUN174uqR34yU+7mLk70frJyPy0EXhxahrFkfZOcq1NBs6FsdNZHtg1QOHKX9
 wimRSUU3tHM36yMJQtGddSN8K+yAPhcyBDS22buUkVKXu043SUpSxxFuky9JU8pDaj5m
 W5UMZ/dDEakJRXc1+PdvhrTKMz/F9LOJXkyHBoRCm5QBsBufyBv9gjDYXeNvaqxRJB00
 PdQg==
X-Gm-Message-State: AOJu0Yznm02zuCgwbphyntK6X2JZbbogqyMnhKN4elUsIhRX/0rWcGp8
 uYIg1ATUP3012JHneLONCi0r5o6AP2IPPPxzUf8=
X-Google-Smtp-Source: AGHT+IGpjB1SM6BT410O7D+8H0pm/G0QvDngy5tHeQZ8q5hs9dyEMLYcoilHt2/VUX2tRPjwZGoaKg==
X-Received: by 2002:a17:903:11d0:b0:1bc:844:5831 with SMTP id
 q16-20020a17090311d000b001bc08445831mr2231945plh.57.1691772655802; 
 Fri, 11 Aug 2023 09:50:55 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm3803713pjj.8.2023.08.11.09.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:50:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pbonzini@redhat.com, philmd@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v3 02/15] linux-user: Tidy loader_exec
Date: Fri, 11 Aug 2023 09:50:39 -0700
Message-Id: <20230811165052.161080-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811165052.161080-1-richard.henderson@linaro.org>
References: <20230811165052.161080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reorg the if cases to reduce indentation.
Test for 4 bytes in the file before checking the signatures.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/linuxload.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
index 3536dd8104..5b7e9ab983 100644
--- a/linux-user/linuxload.c
+++ b/linux-user/linuxload.c
@@ -154,31 +154,31 @@ int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
 
     retval = prepare_binprm(bprm);
 
-    if (retval >= 0) {
-        if (bprm->buf[0] == 0x7f
-                && bprm->buf[1] == 'E'
-                && bprm->buf[2] == 'L'
-                && bprm->buf[3] == 'F') {
-            retval = load_elf_binary(bprm, infop);
-#if defined(TARGET_HAS_BFLT)
-        } else if (bprm->buf[0] == 'b'
-                && bprm->buf[1] == 'F'
-                && bprm->buf[2] == 'L'
-                && bprm->buf[3] == 'T') {
-            retval = load_flt_binary(bprm, infop);
-#endif
-        } else {
-            return -ENOEXEC;
-        }
+    if (retval < 4) {
+        return -ENOEXEC;
     }
-
-    if (retval >= 0) {
-        /* success.  Initialize important registers */
-        do_init_thread(regs, infop);
+    if (bprm->buf[0] == 0x7f
+        && bprm->buf[1] == 'E'
+        && bprm->buf[2] == 'L'
+        && bprm->buf[3] == 'F') {
+        retval = load_elf_binary(bprm, infop);
+#if defined(TARGET_HAS_BFLT)
+    } else if (bprm->buf[0] == 'b'
+               && bprm->buf[1] == 'F'
+               && bprm->buf[2] == 'L'
+               && bprm->buf[3] == 'T') {
+        retval = load_flt_binary(bprm, infop);
+#endif
+    } else {
+        return -ENOEXEC;
+    }
+    if (retval < 0) {
         return retval;
     }
 
-    return retval;
+    /* Success.  Initialize important registers. */
+    do_init_thread(regs, infop);
+    return 0;
 }
 
 bool imgsrc_read(void *dst, off_t offset, size_t len,
-- 
2.34.1


