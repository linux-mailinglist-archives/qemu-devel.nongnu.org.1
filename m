Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9266574B827
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:41:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGF-0004ig-SB; Fri, 07 Jul 2023 16:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGC-0004hs-RA
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:00 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGB-0004ZM-1f
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:00 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3143b88faebso2555863f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762457; x=1691354457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xqq6acmDez25lx55OCz0HM5T/6u0RG73b+x1AtLg/sQ=;
 b=UuH/qllR8Dd8ye4FXvsFtMOb9GOU+QIKw4+jmEs5gmtpkNBsX6Y93mhSJ3itwH7Hjj
 KH5VYeVKa/HPrbZnmRMW44fG2BR5gg83UvnpkqyhZO88mJPsBATb4/isRu+FxwiHtfCj
 nwoJjulL16xpbRkrXT0gZZZb31EBXGruKCUrH1ESiR+jxzxNHz8rm7t9+lBTc+7ls6nM
 Ih65hHCCD5brO+sCWQX6BQZFmJzkIOVf/DqppuIRh9r3zZy7AV0I0BOsmV/pj7/O70ho
 Rtq1sOACnfpuqwWFrut1oaTmqKkJzeRY3q1ZmuwY6fRzhwWLzAJp0Aw3+boLinkkKs/v
 ToGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762457; x=1691354457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xqq6acmDez25lx55OCz0HM5T/6u0RG73b+x1AtLg/sQ=;
 b=GPoAWDbkITIWRsGcH10yZF7lEDwxR4+LpE2gkzq3GYu5+KgRP9LTgK0aKID5x1kDAT
 4NUlxkDlkAtsPNj8fOts+PfSXr4vKgLVfRS7HfAmsju6Dw1gOr9VDGlaRZWtKtdjj6Zd
 +/qPJEbnpsclK07wFB13StSn2OnycAfJfH9DLDY7f6plLP2Rffee20b9gGCULdMOIMNn
 pZWImpeDH5NaPY4ll5SlLb0GRcLkha4kA18m6UMPc3ZxiyNqmtODApwlwhsr9OH3nX2c
 N2NIhcJ47SXpXuI3HZDqxgeu7pHkmi4aevibxatWxaqCfxlDGnp2/lEZlnGfdIc4PpSm
 FqGw==
X-Gm-Message-State: ABy/qLa3GcsmK0VieIFlp9oOrFNbqo6EYbKpP6QKcG1+OIkDhOygJgiL
 OUb4qfr4OgkZlmVAlanCOCg1ukwmhfuQb7jctthW0w==
X-Google-Smtp-Source: APBJJlEREvkWqd3sUo5EOMX1DaRP6ZQcBLtEP8lOTqkpAt3m80B+SxtNpXeVbjHWjdH6Y5OknLbzcQ==
X-Received: by 2002:a05:600c:2102:b0:3fa:9538:963e with SMTP id
 u2-20020a05600c210200b003fa9538963emr4995728wml.36.1688762457686; 
 Fri, 07 Jul 2023 13:40:57 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:40:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, mjt@tls.msk.ru,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/24] linux-user: Use assert in mmap_fork_start
Date: Fri,  7 Jul 2023 21:40:30 +0100
Message-Id: <20230707204054.8792-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

Assert is preferred over if+abort for the error message.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 2692936773..bae3dcdc27 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -49,8 +49,7 @@ bool have_mmap_lock(void)
 /* Grab lock to make sure things are in a consistent state after fork().  */
 void mmap_fork_start(void)
 {
-    if (mmap_lock_count)
-        abort();
+    assert(mmap_lock_count == 0);
     pthread_mutex_lock(&mmap_mutex);
 }
 
-- 
2.34.1


