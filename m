Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D6574C756
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:42:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEE-0005BQ-Vp; Sun, 09 Jul 2023 14:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZE9-0004QN-9L
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZE7-0004Js-Pm
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso37967655e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927622; x=1691519622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+u+6sqOJ5iK1/8L4kug7OWcFShgptBBIOzAjdLQUcYU=;
 b=YH4bzitB7tbGEyrhunznqzVxTiIaWzTjoUq5WxnikLyFHp5Nihcv1GTLxBpptbXvWN
 mSG5fo6M1eUpbrm0xqoj8cMxGbLH9INnHzdZKB0ZrGxDoTDlHbkuG3uEQcCxMrR8ZVV8
 +Cgr2eOzqA9V2O0FSMub7ZSsmz08L3d3ZlSz5vp5Ca3JOZ4qrwmfYSQSZEkPPtz1ahgC
 pGhj4jMdgkwxAB9I864M3Y/iqfIp9hrCeYrh4EGQjiyPhEjDAlwhwtvtzpdniqh6RrnM
 vvnmTmtZ9e+anvfi4FUs5JRInnZ17Yibpl6tuD8s02/9pR9gfu947i6bkmNo9gNQfHU+
 drMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927622; x=1691519622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+u+6sqOJ5iK1/8L4kug7OWcFShgptBBIOzAjdLQUcYU=;
 b=gxjkZ0yVX+qBntNakuagerZmeC+WJxO+HWZH7uNq8v3IRv+250c2YbOJMy8UudC8s/
 wv6A+fUmE+lTbkdeB1zoA+CX64RLWxF3/UAlGbWg3XOyWexOJU93H+0anQV1MsePfI5r
 K/u2sih0hGHRhqvwC0BQpzLfeLJbd1oLUFRTeDdTqzp4hPdxnhrtiIp/0jgdHTia4wc4
 +uAm1CTVJSdOBGzNOhbNYozfrr4n3z7N+Xczjdbyhwn0wu0nKIiGTGpFF6Pn+ZO2+DWG
 gSH+vTrhFqcnxQHxIcEVUd5II74/7bFC7cnO+pPzQneVmgU2OerY40hYr4nO49DS1Y7k
 y29A==
X-Gm-Message-State: ABy/qLZU1jCbNsYzHPa1xoQNCkqgXuuR6eBNv8+lvskPFBvqeDNGUIS4
 b9Wlx5rGFo+JxhN8+JPL9oRagtLtXiCVJLfS0aNQjA==
X-Google-Smtp-Source: APBJJlE0bGPtx7Hkvtk79HZDHlTmwhR9tSQquc/FBsUPFKZ3NmB2ElwinRUiCGJhYleXQMCbJ/RZzQ==
X-Received: by 2002:a5d:4809:0:b0:314:3ad6:2327 with SMTP id
 l9-20020a5d4809000000b003143ad62327mr7584486wrq.12.1688927621850; 
 Sun, 09 Jul 2023 11:33:41 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 40/45] accel/tcg: Accept more page flags in page_check_range
Date: Sun,  9 Jul 2023 19:29:29 +0100
Message-Id: <20230709182934.309468-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

Only PAGE_WRITE needs special attention, all others can be
handled as we do for PAGE_READ.  Adjust the mask.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230707204054.8792-24-richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index e4f9563730..1e8fcaf6b0 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -561,8 +561,8 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
         }
 
         missing = flags & ~p->flags;
-        if (missing & PAGE_READ) {
-            ret = -1; /* page not readable */
+        if (missing & ~PAGE_WRITE) {
+            ret = -1; /* page doesn't match */
             break;
         }
         if (missing & PAGE_WRITE) {
-- 
2.34.1


