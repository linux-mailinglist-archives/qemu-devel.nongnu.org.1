Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5B07A2DB0
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:32:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0m-0005u0-9i; Fri, 15 Sep 2023 23:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0i-0005tA-Sw
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:20 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0h-0007yr-Be
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:20 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1d643db2c98so1257751fac.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835017; x=1695439817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gh4fScBKoyUlMU3zgx4IueUiBP67YjSVPb6IBGAB3cw=;
 b=QjGhw6GYKFgDm8WlTD7Nnl5f3yPipwa+abdvekoJ/JBb9tkVn8b05SGF33zTIl5cXS
 mBBYUZfnpJAjh4lr9dvo1bS4vLWJGB9Zcjhd+FBYGgA7fnpPLpmSZH9CVNP2rwDZpyJB
 euovaJBvS8hDzeHwltNBsnnBZ2DqNzR5UWKb0hr3IsFwCbRuDW569wbAiXJ1MTy+qtDU
 NRqLW7jHuzZLh/GNNwEg3dbvg6y33U49UZWnel8YCG6MbXe7m54tR+6f3DfiY5llZ8Gi
 F0mys5gGgeBpliA7n6/tvgpBlH0C8HS72Rsqx1ccrBl9iXGBzniuI1KkJ+UO4v05jX0j
 rW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835017; x=1695439817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gh4fScBKoyUlMU3zgx4IueUiBP67YjSVPb6IBGAB3cw=;
 b=eb23QeTUIMOf5276Gwq6dMgXxCWv3kRGy2syeMNRxwrKJJHGFmqIOq+MDPMvdkhzZB
 gx3DdZuTN7I4QfSQkS1uLr7SQVMV8hpN6z0RVHjd3BESXIU+nE9fMLB+0x2zS9yDaqeq
 frhvYWLPtxJGn1ZlgiU9GXQkzDQVIXSiE6xRKrGzTlXCuMQCbxYinlTs8ZFdXkcv6oOM
 7vMQKT9XWryFjiDWbyg2/4k/w4BHkJpjfMjKWQayEUvGuc+izqan+vGvDXXORua9uXno
 VguIsS7WTyl0SMPOuWPgzcPhk/CytRKQNvtDlLMUkIkd9yaiIp4r84HMnNCYP1p4gLDU
 /GLw==
X-Gm-Message-State: AOJu0YzH01uFfF1vKHhhWWlb+50Qq388TnVqxN3onM68+U2y+rb+iQPk
 xRtNX9VI/LBnNCbvE6h5aVVUOXr/6PyIFsanxf8=
X-Google-Smtp-Source: AGHT+IFo2K9h7PbdwB3jIFzXTbOoUlelqajtnm9hm1+/rG0Dwv0xNcPQnyndI5oA8FYaiz94jvOlzA==
X-Received: by 2002:a05:6870:14ce:b0:1d0:d78b:982e with SMTP id
 l14-20020a05687014ce00b001d0d78b982emr4286734oab.35.1694835017386; 
 Fri, 15 Sep 2023 20:30:17 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 04/39] softmmu: Delete checks for old host definitions
Date: Fri, 15 Sep 2023 20:29:36 -0700
Message-Id: <20230916033011.479144-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

PA-RISC host support is already removed with commit
b1cef6d02f ("Drop remaining bits of ia64 host support").

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230810225922.21600-1-akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 softmmu/async-teardown.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/softmmu/async-teardown.c b/softmmu/async-teardown.c
index 62cdeb0f20..396963c091 100644
--- a/softmmu/async-teardown.c
+++ b/softmmu/async-teardown.c
@@ -121,10 +121,7 @@ static void *new_stack_for_clone(void)
 
     /* Allocate a new stack and get a pointer to its top. */
     stack_ptr = qemu_alloc_stack(&stack_size);
-#if !defined(HOST_HPPA)
-    /* The top is at the end of the area, except on HPPA. */
     stack_ptr += stack_size;
-#endif
 
     return stack_ptr;
 }
-- 
2.34.1


