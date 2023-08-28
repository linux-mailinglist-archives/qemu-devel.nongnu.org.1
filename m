Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B008B78BBB3
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:45:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrn-0003h8-Jk; Mon, 28 Aug 2023 19:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrf-0003fC-W0
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:48 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrb-0006g8-6d
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:47 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34bad46e5a5so13079215ab.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266101; x=1693870901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k4ZavMA2jKcdyYrvnJgf/oPyCKcovCggmoEgQ8d/0jQ=;
 b=4dUNRms57VHNVJKXLs6qNd0u4Zv0VwrEfaxMzLuE0p/YCEBoxYUXfSqt66JwlIkoh4
 0wOgZfcgIQRLvcgt1U9OVFxi5cR9cQdAVkMF3lrVWYlc91YkvLWlgcne7OYaNvRWFzwT
 D3HFR/0vYAOA4cQO6Fky4JfrzUa5QhF2m8kWEhkCNEQxYZ4HFV4K9wT/Gf86Y4AYX546
 m4MKJlo1Eg0nW16fPqP8LGef4b4Ff1uLOCe+dt7WxZFsNhfcPh5aub6P/ZBq8+IgWZWy
 3E08onXtsQHdZWDdN/Lk0+0eh1foKGpJQNeKzO/D5l3HZcIE/gJ8Yx/B6a+f+zTp90zN
 M+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266101; x=1693870901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k4ZavMA2jKcdyYrvnJgf/oPyCKcovCggmoEgQ8d/0jQ=;
 b=iM26YdRtt9ZtApjZ/n3Pf0JChVwZkPB+7hnxXl6WVtz1MNIxEeoOjL7gNWsB++9sdd
 u2wGj1YGCfMh6A8SK0xwDhBMJZV6AJ8MoY7XN66+1QDI1m/xuxms3w+XxMpXPmtsta05
 8WIaC5M1bbHbOxQDsCByGzIuv80YbIcnCH1qqZooVPp2TXU7R5q9J1b0BjJyIRI5U1/Q
 TblbvRtPl471+Y4h4HW/qxg7DA6iJoUB0TyHlR5U0S6Te+ddxHjRMtvyeVQG0m8zhbif
 9cYCI1mrpwJ3BdTbWa0VS1s3CKDnjyF2jQLMk5t6fFGWS2xy/8h3Fb758S7Ya/83CqfZ
 1nhQ==
X-Gm-Message-State: AOJu0YzsRNmWsv4m8AlbDID9ckGlRlnDIz4T5EsBaCMtXyA11xtC7Hcc
 jsNriiFlgzF9xGV+o7jX8fp7+y5Mnkq4OGrBXVY=
X-Google-Smtp-Source: AGHT+IHXCvvJeKTQJAHJMypmBiWLrWacs0bfPPEYb2DtHj+QpVe11FskqB2J4dlIobGSnLLjApXQJw==
X-Received: by 2002:a92:ce0f:0:b0:349:7663:566c with SMTP id
 b15-20020a92ce0f000000b003497663566cmr15484586ilo.30.1693266101556; 
 Mon, 28 Aug 2023 16:41:41 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:41 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/36] bsd-user: Remove image_info.start_brk
Date: Mon, 28 Aug 2023 17:37:48 -0600
Message-ID: <20230828233821.43074-4-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::130;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

This has the same value is image_info.brk, which is also logged,
and is otherwise unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230818175736.144194-4-richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/elfload.c | 2 +-
 bsd-user/main.c    | 2 --
 bsd-user/qemu.h    | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 2d39e59258e..baf2f63d2f1 100644
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
index 381bb18df80..f913cb55a72 100644
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
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 898fe3e8b34..61501c321b0 100644
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
-- 
2.41.0


