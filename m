Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 051B4771378
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:41:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUaG-0003j5-VJ; Sat, 05 Aug 2023 23:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaE-0003hu-SH
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:34 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaD-0007aR-Aj
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:34 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so2445778a12.1
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293052; x=1691897852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+a1ntD1nPZIq5/3BuYdNWBqjL6H8GnZs4Nnik5eIQQ=;
 b=VtfJ3gn6ABglBbG23wqawv3eaDnP34LqhXTaK431QvWp4niDYCuo/Ee8fQSRhChIUy
 p8+PhimpmvkbpQOUsvGCbDOAR+yMpEOShzJArBm5THNoto1AKpKOkGDpse187DfTZ7e4
 epSI1plzAFXXp1TIDAPUvCjK84hDD8Zd0Jh9gx7tRH9vzY23SeM2DdJ3Dybiwmb/YhHW
 aBvR+FSOXtGxg9h5JkjxnVoa//PhYClcZsTm2Hh632OsObwwoYRv3AnwKXYFmc0u9ArT
 hA7rkhAS0eZZU/F460t9oCSmJ/xaZ49fyk2v6jSse/ko1kRYJeV51lpmq7PVP0jPq/Vo
 A/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293052; x=1691897852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+a1ntD1nPZIq5/3BuYdNWBqjL6H8GnZs4Nnik5eIQQ=;
 b=Jqh/VNsMq8HmVHlkvGOD2CgYdMjy6pEKFSDkVNi6Ab4fG2aw6UKGAgQdYVFwFJrgOc
 87BnCVL9/sf5TKRziGXs1Ck2mh1oGVxBlX61CMxISAvv763iRNlEx0pxdp928gLVq/oO
 pdOOUMO1Lo/14t6+MUhJ6v1mk4w0sXTb4JlEa9xYKHBSTJhJS3T6Bo7juBTJKOp8Efn1
 hY0MEtNNcYnlKB4XqASo6U689di/y6XumWkTm+CGhF8fsIS9NCL6toMZBVQQjjPet48l
 J/RQ5Isaz/LxmqCsowLgHxSxnq20JyOpE0Sm9PNaXWhprfFqjhx0ImXJ7exTb9ri5+9T
 ZEfw==
X-Gm-Message-State: AOJu0YzE9M/W4M7pRhiyM8NL0aVHS9Pxc9fukohxRXRSRhFra50GJ8cm
 92nV2PjL7QCrQKAT/SiiQkP0IwuKcGCuBGzCKM4=
X-Google-Smtp-Source: AGHT+IHOOwKlKVJZVGJOTFvyBYxO/JI901TtyStPf61DBnITZSDSQ+st6Jlksuy3VrQqNHiM6xuPIw==
X-Received: by 2002:a17:90a:8043:b0:269:46d7:f1db with SMTP id
 e3-20020a17090a804300b0026946d7f1dbmr1912631pjw.32.1691293052017; 
 Sat, 05 Aug 2023 20:37:32 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 19/24] linux-user: Properly set image_info.brk in flatload
Date: Sat,  5 Aug 2023 20:37:10 -0700
Message-Id: <20230806033715.244648-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

The heap starts at "brk" not "start_brk".  With this fixed,
image_info.start_brk is unused and may be removed.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h     | 1 -
 linux-user/flatload.c | 2 +-
 linux-user/main.c     | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4b0c9da0dc..4f8b55e2fb 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -29,7 +29,6 @@ struct image_info {
         abi_ulong       end_code;
         abi_ulong       start_data;
         abi_ulong       end_data;
-        abi_ulong       start_brk;
         abi_ulong       brk;
         abi_ulong       start_mmap;
         abi_ulong       start_stack;
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 5efec2630e..8f5e9f489b 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -811,7 +811,7 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
     info->end_code = libinfo[0].start_code + libinfo[0].text_len;
     info->start_data = libinfo[0].start_data;
     info->end_data = libinfo[0].end_data;
-    info->start_brk = libinfo[0].start_brk;
+    info->brk = libinfo[0].start_brk;
     info->start_stack = sp;
     info->stack_limit = libinfo[0].start_brk;
     info->entry = start_addr;
diff --git a/linux-user/main.c b/linux-user/main.c
index cb5e80612b..96be354897 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -963,8 +963,6 @@ int main(int argc, char **argv, char **envp)
             fprintf(f, "page layout changed following binary load\n");
             page_dump(f);
 
-            fprintf(f, "start_brk   0x" TARGET_ABI_FMT_lx "\n",
-                    info->start_brk);
             fprintf(f, "end_code    0x" TARGET_ABI_FMT_lx "\n",
                     info->end_code);
             fprintf(f, "start_code  0x" TARGET_ABI_FMT_lx "\n",
-- 
2.34.1


