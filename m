Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C72B878127A
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:58:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX3jF-00011i-UH; Fri, 18 Aug 2023 13:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX3jD-00010Z-RH
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:57:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX3jB-0004A0-Kj
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:57:43 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-688779ffcfdso1026003b3a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692381460; x=1692986260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKC3oMtQdbEDSSpIBKgTNpz/jo9TrgS3VCqCg+QxX8s=;
 b=eFwCqPq++9ffa6d4Dg3GFby4Y+Cy1mV1bndnrdoswjbMXllXOuwQJhJCYm4snSKHuc
 1V+n/sYY68yG8R6xsOt7EOeeZBLXzxfmKAara6rk03aIpAIfYLofUKPsqu0tRfKnZouE
 tLGdQZ59vGIju5IoEbAauQYIndIldz65lQP+Q97A/FNUciA+DUoZxt/FcSwFWupUkMWo
 aXLe0GnGyBjdSTGymKAx65N7h6HZZTb2SWPKFt8AprGmdDmnNSmvuJH/7i+mI3gWDDCb
 22lpL8Ap5lJgl6+irRSGkUqUTqDbOMzWvti/+aGlUMx4pfbdQmJZEZQ42ZUUJse3nr3Y
 7phQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692381460; x=1692986260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKC3oMtQdbEDSSpIBKgTNpz/jo9TrgS3VCqCg+QxX8s=;
 b=fu3HCMuE1NQ/9Yfxe4DaUtKYvjwmA+eQhF64JzF5Zif2OlpbAT5I4pP2BK4l2gSlDx
 L0XEXkjdlP88wEZfW0f47j6TeQX5gxC5xCeszPtLASZKnUbf4eZTH4htxPnbeQItwVBd
 Uv+Gc+HioMOLJ9pNQpFEfePMAIiu18jA2LZZ5FyJJKMQxCe/kw19HelMPkkrOY5EXno1
 ZoJ18b7IlbEaZnBdGpVFjXNhvFIMD1QRvLAgO/TgOQQBE1VvYM7Qt+4s9P5mytRANaTo
 T0d0Ka0BsIuHmClxyxV8D8j/cMI0EAGMA++D6Of5b38p8s5E6NKTH6wgWTnKO+GAO4xQ
 EOzQ==
X-Gm-Message-State: AOJu0YwACcYAwkmO74j51BJtDEdu+g5IAD0RiGdSILB7rR85OI365V31
 a5bRvRQGaq/ExG4OPjj8O/TokDQGFAJl9qxNJP8=
X-Google-Smtp-Source: AGHT+IE2U58mD8DxnJeg8hcocQzjRiAS/RJCG2e7Mx0nvhFedpM4h09okaeGurbNnwhJPpsKxBvDYg==
X-Received: by 2002:a05:6a20:9146:b0:140:56b6:4137 with SMTP id
 x6-20020a056a20914600b0014056b64137mr4017369pzc.52.1692381460386; 
 Fri, 18 Aug 2023 10:57:40 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a638c4b000000b005637030d00csm1838212pgn.30.2023.08.18.10.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:57:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com
Subject: [PATCH 3/3] bsd-user: Remove image_info.start_brk
Date: Fri, 18 Aug 2023 10:57:36 -0700
Message-Id: <20230818175736.144194-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818175736.144194-1-richard.henderson@linaro.org>
References: <20230818175736.144194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

This has the same value is image_info.brk, which is also logged,
and is otherwise unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/qemu.h    | 1 -
 bsd-user/elfload.c | 2 +-
 bsd-user/main.c    | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 898fe3e8b3..61501c321b 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -50,7 +50,6 @@ struct image_info {
     abi_ulong end_code;
     abi_ulong start_data;
     abi_ulong end_data;
-    abi_ulong start_brk;
     abi_ulong brk;
     abi_ulong rss;
     abi_ulong start_stack;
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 2d39e59258..baf2f63d2f 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -811,7 +811,7 @@ int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
                                        bprm->stringp, &elf_ex, load_addr,
                                        et_dyn_addr, interp_load_addr, info);
     info->load_addr = reloc_func_desc;
-    info->start_brk = info->brk = elf_brk;
+    info->brk = elf_brk;
     info->start_stack = bprm->p;
     info->load_bias = 0;
 
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 381bb18df8..f913cb55a7 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -553,8 +553,6 @@ int main(int argc, char **argv)
             fprintf(f, "page layout changed following binary load\n");
             page_dump(f);
 
-            fprintf(f, "start_brk   0x" TARGET_ABI_FMT_lx "\n",
-                    info->start_brk);
             fprintf(f, "end_code    0x" TARGET_ABI_FMT_lx "\n",
                     info->end_code);
             fprintf(f, "start_code  0x" TARGET_ABI_FMT_lx "\n",
-- 
2.34.1


