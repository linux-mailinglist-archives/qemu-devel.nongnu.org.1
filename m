Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D384F76DDA0
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:54:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWm-0000jL-V9; Wed, 02 Aug 2023 21:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWg-0000iF-Dw
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:18 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWe-0000pD-Q9
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:18 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a6f3ef3155so316372b6e.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027596; x=1691632396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=on5r7f0kRrvLwtEMgkqNRJQnFQG3tYk+wVcG6tCyF5I=;
 b=Q7hy9xAmmOJ2EIbmxpBQ/PQ3gPWXju5XalvqnJ3Hc1HT+3FphegfRcS969Nm7CyWWV
 Pv84H4x594rxD/Ua0NGeqtsEzsb1YeW7CcB9DqvQ7Z2L11plqVqVDB284u1x6XRaxwQD
 RaDd4QQ4/+lKBtiRYwHTAqoZRUwc4SyW7gBaTmdGWRR9x14771PH4cSKg0l5jI1wp+w9
 97KXWZDNN4D44FCyAoVwkgOapXIr4d0tz9vlpXMIROcC3UpSkEjXs6SP+W+B+MWC/Jpc
 JanPdwzHKfiNYfWxa+OC8HqLr0+vhzpOTUAFrOvbuhVRCUrYWH3N6rUMBYGy4kGSlYea
 cKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027596; x=1691632396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=on5r7f0kRrvLwtEMgkqNRJQnFQG3tYk+wVcG6tCyF5I=;
 b=X7ihU2lwCCQXv84P1z44SHRj9GuU21CX7kqXgUb15KcI3rIwOoJScgQ8A0u/HJ/uqe
 jcpqNBv2PMg61yLqkmcKiXfdIojyh7/KFx4Mkvg971MtLc8bgzzl2oRVgzoh9kv/9CCH
 HcarmB9VB38vcW4dex/3ZHrw0Z0sjvQHviHuOPXtbbfrfm5NLv+XekA170A54mo0U0fm
 01OqF4FTiiAUNY5Ub975GNdKHoKLjsUldURic3xq3Uul1VUImMj36I8QTJ+bxyuREpm5
 mA1TcbZH5+9T4OV/2cMAwCiNzSlPA/Oe4T9wv9ubHcZip/sNfY7QA4UyAlqMcNquzD67
 GFKg==
X-Gm-Message-State: ABy/qLajDU15gXHdq5qoLW+/a35UWb0XjTScIxybXkZReJDd9t0k36O4
 3DisTt1DFweOtGNK3QeqHfe3BkybL8a7J++TClc=
X-Google-Smtp-Source: APBJJlFmH+6sJ3azm6YpLj+ARnMtuWRn95EZsU3Y4k7Bjm32usbJ7r8FAhNe1okLgN0J86fZtDWwTg==
X-Received: by 2002:a05:6808:1493:b0:3a7:4b9a:43ca with SMTP id
 e19-20020a056808149300b003a74b9a43camr8655437oiw.53.1691027595849; 
 Wed, 02 Aug 2023 18:53:15 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 14/14] linux-user: Properly set image_info.brk in flatload
Date: Wed,  2 Aug 2023 18:53:02 -0700
Message-Id: <20230803015302.407219-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

The heap starts at "brk" not "start_brk".  With this fixed,
image_info.start_brk is unused and may be removed.

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
index 2b6f3f22c7..c393a2ceb6 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -961,8 +961,6 @@ int main(int argc, char **argv, char **envp)
             fprintf(f, "page layout changed following binary load\n");
             page_dump(f);
 
-            fprintf(f, "start_brk   0x" TARGET_ABI_FMT_lx "\n",
-                    info->start_brk);
             fprintf(f, "end_code    0x" TARGET_ABI_FMT_lx "\n",
                     info->end_code);
             fprintf(f, "start_code  0x" TARGET_ABI_FMT_lx "\n",
-- 
2.34.1


