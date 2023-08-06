Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87742771367
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:38:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUa7-0003eY-P3; Sat, 05 Aug 2023 23:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa5-0003dj-Rr
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:25 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa4-0007Xa-7n
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:25 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686ea67195dso2458964b3a.2
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293043; x=1691897843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8M/sECGKblXQECxwhiXY/mNUP2fHciHERdH2OiT8nA=;
 b=YhRjrWagjbp13SDviaVcq4SUcJqN8fFgf1kOTYRE5xGpALC0SXlo4yKQhBZT4RwFhd
 vPuXFP/fLW0Od+P3O7xl0j+H/OD0k5QaFEHqWjsfTxdBuPmx5MDfS6m89RgZ70/Emvza
 jrxbhtQaaRsXqia8xXY/ai24XnVOMHfDWM53mDmcws8obe15lffBBp5TgBp0s2wpyRit
 JWOPuFL1yZXe0yctgcRjswZUbYOKsdkgnvugCUKi7lQveUV83nOt04+w+eIagYiPxlXo
 YXSbMTXQBg2MlryX+UGwpJhPYRS40bJAsbiOkOngTAnIDqm6GtEm3CQM6R4n9g+6fTsX
 nvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293043; x=1691897843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8M/sECGKblXQECxwhiXY/mNUP2fHciHERdH2OiT8nA=;
 b=fi5BmKlbNCrd/AAWJLgTJVOLJ/jMD5xpHj/ljuyWykla7RkAdN4JKDn1sg5gDNeisN
 8OK41czmgFtFXRUThlExUg+oBUSjPqwV0gIKh2Ar9YdrroxNFxaa+H8G2IBzL6GPJedX
 gf4SNsadkTWDOg/9EuqzJYwx4zTRwYpBZA+KCs6fEHE5/T4XLCxI+SXhAPzrXFmY2caR
 LIK/QdZF8/10AdUw/Z/Vl7p0fXenraV2U6Vq+tGqxh05UlIbkiv/0XiACAmnEhW74l6M
 dPeYAgwN+czME238tSX7aUflipUQgWHNl0CJLfITvDiizBO+KXEXZwHUdmmPk+0+hWDR
 7f2g==
X-Gm-Message-State: AOJu0Yw5Z4hPWquzQYwnYrdAxjuf2RYIRUlHTp5d6qhLmuaCh0gTeKNh
 2nW7YJf8Mak/om/7tke0/iQ8Mp5FZSV3KgJmhps=
X-Google-Smtp-Source: AGHT+IEcVvz/QQf1HsxJAMkAA4SK992SrhyNjQyKk0WHgmlU5YjGBwhzbsnm+RY750+LRyRZC/DoKQ==
X-Received: by 2002:a17:903:2587:b0:1b8:b564:b531 with SMTP id
 jb7-20020a170903258700b001b8b564b531mr5870990plb.60.1691293042786; 
 Sat, 05 Aug 2023 20:37:22 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 08/24] linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
Date: Sat,  5 Aug 2023 20:36:59 -0700
Message-Id: <20230806033715.244648-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

MAP_FIXED_NOREPLACE can ensure the mapped address is fixed without
concerning that the new mapping overwrites something else.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-5-akihiko.odaki@daynix.com>
[rth: Pass -1 as fd for MAP_ANON]
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b9d2ec02f9..f64024273f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -854,17 +854,12 @@ abi_long do_brk(abi_ulong brk_val)
         return target_brk;
     }
 
-    /* We need to allocate more memory after the brk... Note that
-     * we don't use MAP_FIXED because that will map over the top of
-     * any existing mapping (like the one with the host libc or qemu
-     * itself); instead we treat "mapped but at wrong address" as
-     * a failure and unmap again.
-     */
     if (new_host_brk_page > brk_page) {
         new_alloc_size = new_host_brk_page - brk_page;
         mapped_addr = target_mmap(brk_page, new_alloc_size,
-                                  PROT_READ|PROT_WRITE,
-                                  MAP_ANON|MAP_PRIVATE, 0, 0);
+                                  PROT_READ | PROT_WRITE,
+                                  MAP_FIXED_NOREPLACE | MAP_ANON | MAP_PRIVATE,
+                                  -1, 0);
     } else {
         new_alloc_size = 0;
         mapped_addr = brk_page;
@@ -883,12 +878,6 @@ abi_long do_brk(abi_ulong brk_val)
         target_brk = brk_val;
         brk_page = new_host_brk_page;
         return target_brk;
-    } else if (mapped_addr != -1) {
-        /* Mapped but at wrong address, meaning there wasn't actually
-         * enough space for this brk.
-         */
-        target_munmap(mapped_addr, new_alloc_size);
-        mapped_addr = -1;
     }
 
 #if defined(TARGET_ALPHA)
-- 
2.34.1


