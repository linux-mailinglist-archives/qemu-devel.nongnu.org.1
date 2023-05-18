Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 439A9707935
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 06:42:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzVRz-00069K-5g; Thu, 18 May 2023 00:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVRv-00068B-Um
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:11 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzVRu-00079Q-Df
 for qemu-devel@nongnu.org; Thu, 18 May 2023 00:41:11 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5144a9c11c7so1395200a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 21:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684384868; x=1686976868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Omw1nMDVnF0V8qz6BMrXc136GARiubJIhiuWXtAXyKE=;
 b=LJBDolZ3LXuDhFgyZQyUTIdEaHN/6MS8bYsMcFKauH8bVroAlc0lJgeUZwnlXJffmq
 fLBm8j8RIMCvrv5Y1vfQEGo7xyt7pfb68+EvuqoWGaUc3PTqcoNb1r3Edt4ySav7Bqye
 BYbzVHJzDBoic4WJ/H6PTI9hY/Rf0LDCiiYcOjo3c7J0b5ss9TI1KRePQ+icklR42cuE
 Lr+BYhA46Rh6ZxJOtikVs0wlvoxKstJ9XR7CZITQBjzRdnXUlUH1rhH8Y4UGBFZVHgEL
 NhlbC9u+MjwtwngKxiNO7y2ReFe1AjIrjCfJSp4HWHv1sIRDhKhJixlCaQzojfboPyws
 oZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684384868; x=1686976868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Omw1nMDVnF0V8qz6BMrXc136GARiubJIhiuWXtAXyKE=;
 b=H4fHdTOeiJxtiylwhCIw/Tv/AVkWpTeKnx4QJw7pxUEnjMAg9GP9x4AuP+zi0pXoGC
 /H7Vr3yv5dYiMP97m3qsZIb+Zwn51Ie1DtzR8z8x8GKuwLTYMs0Ph71lS6cGBKvlHn4h
 oIzPO3d9vefciSIt10F3Pj5zWNGxfVktJlAntJMBAwVq7uNp87I+Tf/JyqZEEogfC/Wc
 Lr4u2XvAAdQPjf6ND7XUB1CgkJryHBSBQjkeXJtV8toBmi9ZTdcorsBjJD5CsjZuUhdA
 JvbI3/oVBFKBQkDDDkQunz7/iDMGwn87UNvEFooucHe2j1JBR5f4TmU6Lji/6l5xstGV
 AOmg==
X-Gm-Message-State: AC+VfDybzEqwEROFtEv4v+eh10ZpkbP5O7vCLtJBDddfvNYBoWhXY5x3
 udH389d9J39qNapFZ3i6SWRsyVJjNexklZgmKIs=
X-Google-Smtp-Source: ACHHUZ7diX1/ghlpSkp2SNulXAb0+ZyFjXaM6OnrHy9gUXjjLPV26IPHFntD7cEe5cQKup4OsBMQog==
X-Received: by 2002:a17:903:2287:b0:1a3:cd4c:8d08 with SMTP id
 b7-20020a170903228700b001a3cd4c8d08mr1499025plh.38.1684384867994; 
 Wed, 17 May 2023 21:41:07 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a170902e84900b001ab1d23bf5dsm225592plg.258.2023.05.17.21.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 21:41:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 8/9] migration: Build migration_files once
Date: Wed, 17 May 2023 21:40:57 -0700
Message-Id: <20230518044058.2777467-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518044058.2777467-1-richard.henderson@linaro.org>
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

The items in migration_files are built for libmigration and included
info softmmu_ss from there; no need to also include them directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: Juan Quintela <quintela@redhat.com> 
Cc: Peter Xu <peterx@redhat.com> 
Cc: Leonardo Bras <leobras@redhat.com> 
---
 migration/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/meson.build b/migration/meson.build
index dc8b1daef5..21ac014496 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -7,7 +7,6 @@ migration_files = files(
   'qemu-file.c',
   'yank_functions.c',
 )
-softmmu_ss.add(migration_files)
 
 softmmu_ss.add(files(
   'block-dirty-bitmap.c',
-- 
2.34.1


