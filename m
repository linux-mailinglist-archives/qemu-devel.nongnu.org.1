Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAF174B82F
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:42:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGM-0004o3-Qv; Fri, 07 Jul 2023 16:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGK-0004nR-ML
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:08 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGG-0004g8-Ro
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:08 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f76a0a19d4so3614421e87.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762463; x=1691354463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWcGYI7xB8LlKTPPYJbQ3MPkeMAscTRkJ+piG/iDAy8=;
 b=kgLd9JZgzUCnBaWwYIHeSliIdqz/CKARNj85jImEDDcsHeY0pgtIW7ztsTJ0HGyNcN
 3clYBcy+0OZjalk998XWFASrSjp3abW4rwS7y3S4R2b0qN6FWOxmalGJTintaRw0RnPG
 kHvJDrR/eO15Q8h93eztPsNlg4Qqsr4FKX72T+gSqpVxwatto76A189TqhpleV5+/q6n
 MDFl/OUUtEwgcjq++8UvajWgQkkhnLa2eralseRgVwySLsFyuUN1fKa1OPIaUovEpcR+
 DG7PmQ/qfxBic6aeiYMY6IrkYifAQ5tf96IgTHQPzR3FrAGNvi6Nvm53FyvOy4uL8LuJ
 5ClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762463; x=1691354463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWcGYI7xB8LlKTPPYJbQ3MPkeMAscTRkJ+piG/iDAy8=;
 b=HpsNav8kOVWj/jsBdflaO5VtlVKq01RpAcRc4FvzcSlpqKS7vOwS7lA22kbD0KGksE
 6n6ddlSmJ7RAzMiQEQBI/1sI0av2maU2acHNfBQq6YNth2MR22IGJQqunUDMsi1IVLLn
 PqTcD+iZCVWz7Pk0LhgaOGGWKFr1GQDaLEsv0tFhqpUx0mWbZylJZVBQuRQXuxtNHFZD
 Yy/nmEpIHanG8IZ1NrOqWlkAV6VojLLBK5HsZ4jUZ0VMkVP/8frHIdH266SH52q/G7xa
 16vBn8QImuQCtr3LRrx9uel4FGzqtNmEj4aEdrdG6O/rwc1yj0qWD1/Qp6+gf7xw+MLn
 lEHA==
X-Gm-Message-State: ABy/qLbM/E/yynev8LtAeADtEXES+lp6mTZXNlf9D0fMQblhpPPP8/F3
 ErBXUs/WFnJs8z3LOZY0WZpFyBNfGRAl4xcZakrGdA==
X-Google-Smtp-Source: APBJJlEjwU3+MfoxViyCrTROJG+f7j3jee3/sRhVNXqmIHtOVZMBa3TP3s5nmabkjMcxpdSfI2hHcQ==
X-Received: by 2002:a05:6512:3b83:b0:4f6:45af:70b8 with SMTP id
 g3-20020a0565123b8300b004f645af70b8mr5412257lfv.58.1688762463004; 
 Fri, 07 Jul 2023 13:41:03 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, mjt@tls.msk.ru, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PATCH v2 08/24] bsd-user: Use page_check_range_empty for MAP_EXCL
Date: Fri,  7 Jul 2023 21:40:38 +0100
Message-Id: <20230707204054.8792-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x133.google.com
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

The previous check returned -1 when any page within
[start, start+len) is unmapped, not when all are unmapped.

Cc: Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 565b9f97ed..07b5b8055e 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -609,7 +609,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         }
 
         /* Reject the mapping if any page within the range is mapped */
-        if ((flags & MAP_EXCL) && page_check_range(start, len, 0) < 0) {
+        if ((flags & MAP_EXCL) && !page_check_range_empty(start, end - 1)) {
             errno = EINVAL;
             goto fail;
         }
-- 
2.34.1


