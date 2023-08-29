Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C98F278D062
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:23:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n6-0000sZ-HG; Tue, 29 Aug 2023 19:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nE-0002NI-UO
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:37 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nC-000484-3m
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:36 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68bed2c786eso3439161b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346553; x=1693951353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BbPoiA4hDTDe4hGu5oLPJ3b2yV0sQkSxEUBuznSGCYM=;
 b=hG3z/rGTj/ci7t6TQvuaJGHAr6QayQo+7l5XjCD+b/Ie0tKkeJicDt27J/ehvBGh7W
 hth4a28z7N5omYH14ZH+0HM+V6H/RFUv2mLxdiIfWY0XoTngFXGG3qg2kJvLZNafQ0hb
 xJDWbq8mBhyLKLtDTZpZrZkTrajVL8TdthXtZZpBCDbuuugRAKsbwCQ0TGIGOjcvh/Bq
 alRiXFWirF5ghlNgVMcDlL/Ri63i25mIGRWPD74mzWZaBOdFvis+muc1kAey2KK5/Cb/
 /0KSUpgtf1eDG0zp21eAPmjij1QPZAVuZCG/Le5bPr0kwQ7OhFMxXaFMM29ovwssXV51
 UgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346553; x=1693951353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BbPoiA4hDTDe4hGu5oLPJ3b2yV0sQkSxEUBuznSGCYM=;
 b=LKyMGcdvHTaGIVWu9O4RwWR3nJRCLP1Nb/pni6zU7rhJuH6UmGk3JtChEmbOFhhT+Z
 C3lbwRGWnfbZ2hoI/0iCqsCS//wdljbR0rgzyJjAqQLz7daZ1MeBG8s976r92ezGLGSB
 e3az0Tn/5a3MaXoqS1ka1wqkEkFKZ6MT3J5f/fLDiiJr9DWNRN3zb++8FUOYL/SjcO+c
 oM/4xaNvV8ha9Oc3yQEzZbr9Tq9DCq9q0GRVKE1rCK71o+y6IuTXM6MyudfRhcZ01gfe
 pSKEVU4zrI8Q25cCNPDCRw5kJkQkAYMR2h09qNFxnoZS4yNHR34N6YjifymNnxjRzPJy
 uU4g==
X-Gm-Message-State: AOJu0YyhhdjJlQQkkijvM/rp+qG8GRhUZJynCTnoXgBAvy1sqm3BYaW/
 oEGPyeF0NxA7/0I5CEzKW4ZPZMxzP5IoLx0mhEA=
X-Google-Smtp-Source: AGHT+IHLA0/pRYrIsucgut/SO0JFX8x+MuRjnpCJI0Av9cPDOQ5UzianjFxJjJXYcju3MgfNtqYYVw==
X-Received: by 2002:a05:6a00:170d:b0:68b:e29c:b61 with SMTP id
 h13-20020a056a00170d00b0068be29c0b61mr447946pfc.19.1693346552720; 
 Tue, 29 Aug 2023 15:02:32 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v5 03/20] linux-user: Tidy loader_exec
Date: Tue, 29 Aug 2023 15:02:11 -0700
Message-Id: <20230829220228.928506-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829220228.928506-1-richard.henderson@linaro.org>
References: <20230829220228.928506-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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


