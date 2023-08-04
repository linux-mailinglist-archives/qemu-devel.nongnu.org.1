Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AD2770B9D
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rM-0004t1-2h; Fri, 04 Aug 2023 18:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qr-0004kW-1w
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:53 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qp-0001uz-Ar
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:52 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2682e33509bso1722994a91.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186450; x=1691791250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+a1ntD1nPZIq5/3BuYdNWBqjL6H8GnZs4Nnik5eIQQ=;
 b=Xqv/SKUuQXPpsV5T23HQVOtPeceJm3UQP7aCM79PY6XuknhLpqMJYz+7E3pCTR8XHC
 tBk11FplI1128MKzc3p+DwAYdTYTlk8z/RuqXLO5+WzKoiNCAwINS3M+NkVr07EwbS9v
 rIpbXSoAOrN5b7nkQqp0Upw0wD277HfWuaGc+1WGIk4jWV3t/q6UTrQTz43Oe7pjtMjS
 rsZA27ctS2ePmBH9imqEKBcNIbFVgw5vXh1wl8Nvch0INb9qOzEOEasacZ4AAopvq9eh
 XO/HufO3LUvIucwyRKWRnxF34pQJSkYMEl8Udw1l0gEbflygf9plFc9Hm9TphlTvfLA5
 6Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186450; x=1691791250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+a1ntD1nPZIq5/3BuYdNWBqjL6H8GnZs4Nnik5eIQQ=;
 b=ke/M1qd9cUyJUg5q0OQ7yd2HXCToCQYpiCItRF4cHQECBC8uynUJslW7neWplxKYRe
 t5FPkmpDQSw/KUOHowwmCOMt22txLpJ+rw8IsM+7PeCSLJBab4xuryll5JW64+iRSdai
 5f3/FYwgM3ljpaQTDrkVwOwDoSw1U/50Mex54YcLJbtAc9tO2o07yMQZ/YQ6SDCtjYlq
 1No0t+i3MnxxKNERU5nD44lb6piaub2tW+S61KqGrfpxez+1+vftcspYESR7q0FpYDpt
 FtB9IjoueT8etS6Diz/WLCiXb+wHvCEGWpgxEX+ISS+zpc1QhX2k9gF4lkZ49upjixgp
 Y/yg==
X-Gm-Message-State: AOJu0YwV2Q32jTe8Ev0QfKOOiAQHYd+fWeMrVb+zP7nTWt2VsStsaPBK
 apa3bOSCasVTQEqQRBDD6luqGBt6aP57GqwQpQc=
X-Google-Smtp-Source: AGHT+IEp/KuIVCpxq54vXOKFMG6PONDj7Upeh9HJfu/CzdOQSVNZrynHaLPKfaAmEAW4Ed8A96/MWA==
X-Received: by 2002:a17:90a:408d:b0:268:13c4:b800 with SMTP id
 l13-20020a17090a408d00b0026813c4b800mr2830057pjg.21.1691186450173; 
 Fri, 04 Aug 2023 15:00:50 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 19/24] linux-user: Properly set image_info.brk in flatload
Date: Fri,  4 Aug 2023 15:00:27 -0700
Message-Id: <20230804220032.295411-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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


