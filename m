Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7017D3BD7
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxVk-00020v-VX; Mon, 23 Oct 2023 12:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVc-0001vf-Re
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVb-0001nY-9Z
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:28 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-408425c7c10so29171955e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698077423; x=1698682223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hay4vfiV3EkB4X3edFjXsW35St08FgrroC8EsCiYjMU=;
 b=z8JGKPjhwDwf7gQOYAytON0SwbIJK9CFfP5KJWP7hsod8OcBJimgpuBTeOiCpxRPms
 l4qTOXMcK4fj/dPXsfGeATnlPtDr4drwBpjWEiKofeoY4WD8BSSb8/WdKmKgnakIxJd+
 oijY83LvdaieHr3mZsnIeaH5D6kbJVofNHAXDp+5gzypFj9GN6A7aN8qs9Uq7YFNrTM8
 61p7hOIphWkQfWQ1vZ5ECfdOYjIYB+SvbyLxG1zRM/YfNlRfH0QSt9il5hfk94p8E/Nh
 F9WgxZuIstWTfUQqk8qQi987TOjQKiRDObjf7E/s9TF1Sl2yKB+V/X4lNQLmfw/WXW8k
 M0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077423; x=1698682223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hay4vfiV3EkB4X3edFjXsW35St08FgrroC8EsCiYjMU=;
 b=uy8UTSe2A2uRDylH+iK0T3cutBDAbEK/ghav9P1jx2FU4m1ph4qQkxqUS89CDwSpaa
 4k5A7DcD5n0pBheoKQ54YC9WQsVXUA+4/LoHW4D6pSJMKx6KJX5iSw39+NZeAANKpUHp
 b4FudCy8Rrn9N6xY7O9bdqgIeKx+FKrws1CxkjLzlyZ+KDlafJoMEpmXy55GOLgt6Bic
 3yR5aYyK10G+C6YPPLY7pmMc2B+aFZnxTCX88mjgI8Nz8/5a3wS121AZQXEjGBV+trIR
 xMT26Vps88DdF0z7y+DRCawbJ1FjiB+h3QNHyFItTd0LRo54MCpqU5b5Utcubr6Laijl
 frgw==
X-Gm-Message-State: AOJu0Yz1P6R+poxFjJJkD5RzyYCLwCLtY2N4AbfqchKDs3Q3Sv89ZdKq
 HsODKyeRjJqMkLWZLZ5LpSp9/TQTyR2MzdeQO6g=
X-Google-Smtp-Source: AGHT+IGi6UxfjMkWNbaSZviG/5RvguvfiiQnxzBsG8ZBs65Rp3nmw0joygvdOUFNMC7letUXL/OWhA==
X-Received: by 2002:a05:600c:3483:b0:405:a30:151e with SMTP id
 a3-20020a05600c348300b004050a30151emr8250917wmq.12.1698077423459; 
 Mon, 23 Oct 2023 09:10:23 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr.
 [176.170.216.159]) by smtp.gmail.com with ESMTPSA id
 o3-20020a5d6843000000b003143c9beeaesm8065718wrw.44.2023.10.23.09.10.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Oct 2023 09:10:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 6/9] target/xtensa: Use tcg_gen_extract_i32
Date: Mon, 23 Oct 2023 18:09:41 +0200
Message-ID: <20231023160944.10692-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023160944.10692-1-philmd@linaro.org>
References: <20231023160944.10692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/translate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index de89940599..cbc564c020 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1595,11 +1595,7 @@ static void translate_entry(DisasContext *dc, const OpcodeArg arg[],
 static void translate_extui(DisasContext *dc, const OpcodeArg arg[],
                             const uint32_t par[])
 {
-    int maskimm = (1 << arg[3].imm) - 1;
-
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_shri_i32(tmp, arg[1].in, arg[2].imm);
-    tcg_gen_andi_i32(arg[0].out, tmp, maskimm);
+    tcg_gen_extract_i32(arg[0].out, arg[1].in, arg[2].imm, arg[3].imm);
 }
 
 static void translate_getex(DisasContext *dc, const OpcodeArg arg[],
-- 
2.41.0


