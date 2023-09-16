Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 267DF7A2DAE
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:32:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0m-0005ud-S5; Fri, 15 Sep 2023 23:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0j-0005tL-LN
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:22 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0h-0007z9-QU
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:21 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-656262cd5aeso12353206d6.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835018; x=1695439818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRP2RNc4oTuBpL1/TRdUiohoElZew6gpwHeHdQINSsc=;
 b=KqdkMkSX2lkHWYw0BUZEwRu72aAOANvwBzbhj0p5XiGobUVKuqKPi8A4uELbdOX1A+
 z0fs+RWJWCnRZ/41NMc9gByQxfsXjYNCUVPzwsedbdRgpHSO5Nfusi4b4b+gdZbQ2lz6
 Lp0wmCSXn6TOe0WSZa6lXO3OAs4T7DXHbTZqhmU4GsKKkujyDSYGoybKR3AEwkznJ5Cm
 s8NT/Ndw8ow9RMg84XNm4Hxob2je2Lh/JO0hY+7cfXXsxdxp64EisOrdQcMJ+bLsUInP
 WvD/XCu0Kuk38TTmDuxf1rJWbw1D/vRmbWZH/sVvt59Vf8lsfbo+D2Las6HRNTbllrBc
 dOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835018; x=1695439818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRP2RNc4oTuBpL1/TRdUiohoElZew6gpwHeHdQINSsc=;
 b=kmvN46r51MIZ8Ylu46b4d5xC232YT4gNv78Dod1WJdBFw3zaI0gDYtHJStyE6Tfx4Y
 Qq9tkN7y385zbll3kllkvDKavpFH9LM5v841U0DsCuO/UjgDrzh6MgG3AaszfcdkhFhP
 /60HyZG4HpSBGJi1RHI/pUEai33T9+XGhm7S1DsIv04Z5YZGsNdsbCYfOgTXiwz0tG1O
 6BrQGFVIpwHWe46BdXPxAV0CTEKgb9Q/pOcu2C8+txw0G1qExvJdP8m2BfqZlMYKGWos
 rV5i3wTq/fcPpiW2jNlNdyszTdYo3HXyuAsmVw7fKblA0m4dYbgFsOr5+lmEs7w80tGF
 0TTA==
X-Gm-Message-State: AOJu0YxTF/GWkow80UoQoRV9xfULgz9jayKeL6VLKyNI2J8rAhc6Dfc4
 YtBPaVtvfsltRSO/NWkauRfNAtjgTz2h1S7PTGY=
X-Google-Smtp-Source: AGHT+IG0Ds64BBmLHsdN3p5W7c25I7cIDeEMcyp4Ubc/sObkLst/8VBVMr7mJB2i3sQoEW8Ei1D6Pw==
X-Received: by 2002:a05:620a:2981:b0:76c:ea00:e5d7 with SMTP id
 r1-20020a05620a298100b0076cea00e5d7mr3557758qkp.12.1694835018386; 
 Fri, 15 Sep 2023 20:30:18 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/39] thunk: Delete checks for old host definitions
Date: Fri, 15 Sep 2023 20:29:37 -0700
Message-Id: <20230916033011.479144-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2d.google.com
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

Alpha, IA-64, and PA-RISC hosts are no longer supported.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230808152314.102036-1-akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/user/thunk.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index 6eedef48d8..2ebfecf58e 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -111,8 +111,7 @@ static inline int thunk_type_size(const argtype *type_ptr, int is_host)
         if (is_host) {
 #if defined(HOST_X86_64)
             return 8;
-#elif defined(HOST_ALPHA) || defined(HOST_IA64) || defined(HOST_MIPS) || \
-      defined(HOST_PARISC) || defined(HOST_SPARC64)
+#elif defined(HOST_MIPS) || defined(HOST_SPARC64)
             return 4;
 #elif defined(HOST_PPC)
             return sizeof(void *);
-- 
2.34.1


