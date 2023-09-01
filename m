Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4A978F700
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:24:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpD-0006aT-My; Thu, 31 Aug 2023 22:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpA-0006Za-Gp
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:52 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp8-0001RW-Az
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:52 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68c0d262933so1262880b3a.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535029; x=1694139829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kaLhwLbHzHqv/PeQXejQChX9nX84J3A2xjA5ly6h/g=;
 b=UhMnNGYXFZr7WSTADl8NAcOgYpocmebTYMgxZ4PNBNqBQDWMF2EhtUfNea914Z/xfn
 Z4CXbhK971vODGPU/K+SvQNcQMQlhTfy2xD4mCyniUQgmByZ8OLtUygRxJ7Dx9bBbLYt
 PZENO2pq+Rk4r5crS0OlE7ubaNm5uazPfl+1ko9bprE6wisQH4IrWB1jm3Fl794gg/DF
 /fYBbqE3nh9QcBaId6fnICA5hLBGgNzE8eXrIAHTlk1Iez5cv/ZatmEBIz8iP18Z2O0j
 fjpi/b12RDL60kss8cWEPaLPFDLWRGSh6YZ038vnrUhbDWBq6jCAdoesbIrU0gEO2R5L
 g3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535029; x=1694139829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7kaLhwLbHzHqv/PeQXejQChX9nX84J3A2xjA5ly6h/g=;
 b=RP5HulJJCP4VFttTQSsp2zHIG6843S4IzrLgaVqzd28Lb5J5qsu9u5j6CwsVC4H5Sh
 n776XCnhq13iuxF19rcDfp+R1XA7Q9/3X7sXXRgmT6sEXwR105SUzp0207RTP75rlXh0
 sXiYm9LPOeSZS1lY+iV722dEiD9ZntHDq4+2b6GHITexgAbuzKzVxpN8m2Kyl/voGaCt
 G6oHaQ9SoweBqJ/FwSnulIfBh7xqb23RkoM2MupE+rs8j+WuwPtZcFUSd9n1Dn3YA85b
 m+2qWB6uZxuNAX+pTGfvVYXrCD/QQ/oz/HzE21ReT7Hlz4+tR/GCT9G1BjAoGuSq8n+s
 XTUQ==
X-Gm-Message-State: AOJu0YxuFjZ7y+rvtvqpcEMArcKy4Yjjo845GZXK7EgKvz47SN221NaY
 Kh3YD5eUcV4MEbqMUn69sCfo+Mm6fwFhB0Ix+NU=
X-Google-Smtp-Source: AGHT+IGdlVyKlE7XaWeb9M4/7zqNl1citcveANASsKu1V8aX43SozdZSzMba3yaGlAQkt2vBwclRIA==
X-Received: by 2002:a05:6a00:2290:b0:682:713e:e520 with SMTP id
 f16-20020a056a00229000b00682713ee520mr1931675pfe.8.1693535029110; 
 Thu, 31 Aug 2023 19:23:49 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 20/33] linux-user: Do early mmap placement only for
 reserved_va
Date: Thu, 31 Aug 2023 19:23:18 -0700
Message-Id: <20230901022331.115247-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

For reserved_va, place all non-fixed maps then proceed
as for MAP_FIXED.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index caa76eb11a..7d482df06d 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -495,17 +495,19 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     host_offset = offset & -host_page_size;
 
     /*
-     * If the user is asking for the kernel to find a location, do that
-     * before we truncate the length for mapping files below.
+     * For reserved_va, we are in full control of the allocation.
+     * Find a suitible hole and convert to MAP_FIXED.
      */
-    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+    if (reserved_va && !(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         host_len = len + offset - host_offset;
-        host_len = ROUND_UP(host_len, host_page_size);
-        start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
+        start = mmap_find_vma(real_start, host_len,
+                              MAX(host_page_size, TARGET_PAGE_SIZE));
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             return -1;
         }
+        start += offset - host_offset;
+        flags |= MAP_FIXED;
     }
 
     /*
-- 
2.34.1


