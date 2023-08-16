Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE0977E830
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:05:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKrz-00026A-M5; Wed, 16 Aug 2023 14:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKrx-00024h-JZ
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:45 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKru-0001J6-FA
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:45 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bb84194bf3so43519525ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209021; x=1692813821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BbPoiA4hDTDe4hGu5oLPJ3b2yV0sQkSxEUBuznSGCYM=;
 b=zw+dwHlCnf29iPqZKw64+5+ren92LHt0qfYE+wBM/DINK76rLtniDSfwqVvyk6vhmC
 3Rzqz68IsZH3u/Br1aZEAN+69Xy3Cz2ZKAK9q5939gV6rCsc9OlqZvMN3VBXgJ6xcsaD
 7335nYyn5eTs3y3NoLbI153fvXQxULbGRzS7o+TVJqPEnvirxFQI15jJP9KEGij+1/4x
 AjlSdaAuju8Y3Ys8dcf2TF1V/aeRm4oN0OxrFSCBwFzH+/eSR4zFoWVlV/W7Jif/6fRn
 Vjvppfuqx5kwp4rSoVStxq+0OZYWnRaKJ0yhrcunlbrQRpPkSarymd5zbQMa2vFYKCTN
 I9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209021; x=1692813821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BbPoiA4hDTDe4hGu5oLPJ3b2yV0sQkSxEUBuznSGCYM=;
 b=dpVsrZiOYr3dY57GmTFPZoLJNeSjX2JrJ6TZ1gO7nNlDzFQ8xHyg5h3XHB5X2XHZwx
 p3gBCBNdDDEywrZB5+IUI25L4kaPRL7gE596MYLkK0WNZiFIvQTO6dcRphIJq9X9qRmH
 4cbJuyvyrCQl6JkXVZl1Q/uxZfxLV/tQrjEpO97nW9mMNbNGomyvJ4QhP1aXS2HGXgjS
 s4qgi9fombWHGHDLcXM40meaRp4GzUaizAnLdtV8wDnw8r4WK3gfDkvjx23OA+nR164R
 oNxKdpljrA6G9rfudW5xLbUHu//uF2w/g2VcdFNctmxCCiJuOvh9nTcjUNhkf0pVfm9z
 NmkA==
X-Gm-Message-State: AOJu0YwKrHEl8fupHiFCTQNnqK+Nma/Aht62fPYxIX6N1jtLx343t3mU
 AOiwGi+97vLRaeZkFtYUPlieBsI/8A5YUTGsUAQ=
X-Google-Smtp-Source: AGHT+IHFhHT2okcUG9IOc6mJ4WsIImH34gHAdUmPYYtuHL7HPv7Zcz8ReYzvR9B6EfbNb00k2em7zg==
X-Received: by 2002:a17:903:48c:b0:1be:1a2:8a85 with SMTP id
 jj12-20020a170903048c00b001be01a28a85mr2002807plb.0.1692209021128; 
 Wed, 16 Aug 2023 11:03:41 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001bc2831e1a9sm13446584plo.90.2023.08.16.11.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:03:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v4 02/18] linux-user: Tidy loader_exec
Date: Wed, 16 Aug 2023 11:03:22 -0700
Message-Id: <20230816180338.572576-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816180338.572576-1-richard.henderson@linaro.org>
References: <20230816180338.572576-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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


