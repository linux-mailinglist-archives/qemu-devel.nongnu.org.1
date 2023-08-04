Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CD376F720
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:47:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjsw-0002hM-7J; Thu, 03 Aug 2023 21:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsk-0002d5-NX
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:38 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsh-0005BH-2S
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:33 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686ed1d2594so1418087b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113530; x=1691718330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKCV0XRiqzz/Bbo5CE3ioXvHDRvgwqgKDuyImywiLU0=;
 b=RXCM1bWvgGAyowHopprbFDQXe/0eKIuxZEvZezXoijdcr3VVhoe7HpLXHcUHFVXkhG
 rsLp+pnyT1udQdFsd+qSIUblau2v/rIUvtm8Zr6eHlLY1Lrj2A72fseqSpoSEJ2PLZgS
 AQaUjcJmSIbFw3UCZStutXCFmpVCh7z7kFPhV8TBqWgOTMoURROvQghFsvNAzl7OdOcx
 UOx9UDmNTI/JSTFXpFXAu33aZnxDYstXkhEitAFTkx5rP5Q8xpMFwvGTO4ajN/9xd2Oh
 Yz1YGkgDlEhq7rVANe60nkZ8avq0SZmMdq/rGasbVx/TW0cNjSRzIYUBv5qTvi01YCQH
 TFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113530; x=1691718330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKCV0XRiqzz/Bbo5CE3ioXvHDRvgwqgKDuyImywiLU0=;
 b=k0CVNb4MsHCaPnooKfyem404hc6vVjX4P5b4JXp/K1YC1YW4HmBzjqcZ7fi9np4zQm
 c4cnhDDcotSzvtbIu2uGIXogbAvKfb1FJKkaNZYt6HB4tcPK+nDepUClKvqSzn2LGifS
 6nwgXFjgVZXd9TPHeYKEXBtMHP7Qc3rGq6JUjICZ/o34MZ+NMD8SVi1EnCc6dW37RSJE
 5To1PlgZ8oVXw8aU/a0BIli8W1vVMxavCT4Vd8UntN6pituPGZd0MAfMB65yZIBnj/zK
 I7h5Oep31YcOoOccBkGgkIY2oMF4H7mHPsWJ9WpFkOOWGYuVPG2qhdx/3DHXgILoVG+G
 TC7w==
X-Gm-Message-State: AOJu0YxKZdNkoQg6AwXRHnBBtuwtauulZf6reF6PbOsHTMHGubfqNB1A
 GdQlmR529Dlw1eBEZqOK8jhT067CYFD2DSpgxQY=
X-Google-Smtp-Source: AGHT+IG4salondNf9L6eeWx3fmF/KG4kxr/GrmUfqYN307z3DBQ2rmfnzYtoquSIpsiuNXNAIjCJYg==
X-Received: by 2002:a05:6a00:b90:b0:681:50fd:2b98 with SMTP id
 g16-20020a056a000b9000b0068150fd2b98mr516508pfj.31.1691113529917; 
 Thu, 03 Aug 2023 18:45:29 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78c05000000b0066f37665a63sm456138pfd.73.2023.08.03.18.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 18:45:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH v8 14/17] linux-user: Properly set image_info.brk in flatload
Date: Thu,  3 Aug 2023 18:45:14 -0700
Message-Id: <20230804014517.6361-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804014517.6361-1-richard.henderson@linaro.org>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
index e089123cfa..51ee8649e2 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -953,8 +953,6 @@ int main(int argc, char **argv, char **envp)
             fprintf(f, "page layout changed following binary load\n");
             page_dump(f);
 
-            fprintf(f, "start_brk   0x" TARGET_ABI_FMT_lx "\n",
-                    info->start_brk);
             fprintf(f, "end_code    0x" TARGET_ABI_FMT_lx "\n",
                     info->end_code);
             fprintf(f, "start_code  0x" TARGET_ABI_FMT_lx "\n",
-- 
2.34.1


