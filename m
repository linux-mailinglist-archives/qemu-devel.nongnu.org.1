Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B520F7E338C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:07:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COU-0006q8-QG; Mon, 06 Nov 2023 22:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO4-0006Lv-Sc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:22 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO1-0000dz-QV
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:20 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc2575dfc7so37447545ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326256; x=1699931056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WGcbTt26SgxS0ytgFRjc8lzuW9J4z1MRxuXRCSnc66o=;
 b=qEjtUgyGm/xdlhB32WG+dmpJdJ2bcArjd8AwFb1CHeX99ShBmlaHDHBHduNKJs+5GY
 LlqUYCaN6+Hj2ASUsNFZEZpQcSLWGmoiELlJRK/abDTUr6K+krnJpqMfeqIiKhIBjeEp
 xty8ev+6evsBXlBzUKza1UC+ghfOljmT2xl3xwHSrvylyLZT/i/gtj7e8ViKl8omiCfJ
 JX1M10CKGzpSRdTkYBraUrZP9koaKcyxBqCNVE/pjn7e2IGzbmQxv+cbvHQBkvQaZbfN
 Ne+ftUe17//Dse1HBUwcmNogIP/Aoj+zggBO0V+y5nZqw5l6n1RjYQS6L+iqzIgNRG+5
 iLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326256; x=1699931056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGcbTt26SgxS0ytgFRjc8lzuW9J4z1MRxuXRCSnc66o=;
 b=tVbXFSEYENz+c9vk43mIVyZ/B5ONC3d/wJg2zzyZVlvqmqEqKJEYdxrCWOEVqVYSdn
 1t0RNkJ3kJrHfo0QoGZZJ0APxtXoF1Q/RACErFx7QOLJKDrDG4mkpEOKk5Zb5s3YVGg4
 m4kB2g5SqBVra1LB5Q7ANEneQpOJW9zN2taatFmkn+aF4MSGx7tHFrYe/9JYEH9m1hrU
 Uks+6VqG/9zLhsPWu5hOdSW239GKk/8Z4YT2noQCFt6mUZeAi29IsvUKMa1W+Jahtf1P
 rrZofU2go8awhAnBf1OUH4KbWAQS2KPi4ZJiJFD/q81fxvhoCXpwmwdCPe0JvjCMarah
 F95A==
X-Gm-Message-State: AOJu0Yz8w5bVjFBrfj2gbkr35SwrfIroWPrU9tWxQNlZPT1dBpI73Aoo
 ope7+/OZG2hI1YZFO657g8XVHRVzOo+ayLmB12c=
X-Google-Smtp-Source: AGHT+IGZr9p4HnDQq9AG+ydTr5nz+IsIPSmP3Vj4+UpLZ1+Fv1A0b3TgtPZGXjZspVAbxrA/f2qk8A==
X-Received: by 2002:a17:902:f990:b0:1cc:1ee2:d41d with SMTP id
 ky16-20020a170902f99000b001cc1ee2d41dmr22850428plb.39.1699326256120; 
 Mon, 06 Nov 2023 19:04:16 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/85] target/hppa: Fix hppa64 case in machine.c
Date: Mon,  6 Nov 2023 19:02:52 -0800
Message-Id: <20231107030407.8979-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Typo of VMSTATE_UINTTR_V and VMSTATE_UINTTR_ARRAY_V macros.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index ab3e8c81fa..61ae942ff1 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -24,9 +24,9 @@
 #if TARGET_REGISTER_BITS == 64
 #define qemu_put_betr   qemu_put_be64
 #define qemu_get_betr   qemu_get_be64
-#define VMSTATE_UINTTL_V(_f, _s, _v) \
+#define VMSTATE_UINTTR_V(_f, _s, _v) \
     VMSTATE_UINT64_V(_f, _s, _v)
-#define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v) \
+#define VMSTATE_UINTTR_ARRAY_V(_f, _s, _n, _v) \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
 #else
 #define qemu_put_betr   qemu_put_be32
-- 
2.34.1


