Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6D6791B5B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:17:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCDZ-0005L0-FF; Mon, 04 Sep 2023 12:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDX-0005Ds-MJ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:23 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDV-0007k5-1x
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:23 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so250363366b.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844059; x=1694448859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAJ8IyF6qJ4L0zeYktHFZ3FRJiDz0/SjvkZRz5aktOM=;
 b=UIDrm9HjnlTLSi474CgCICY3xhEYFyAdf/M8GAeAQfUm7bW8pP1kK63rxSRuWlgveX
 6VpXlItFKU+G7k9ZoWJVbiddWMR99P54Pk+wJyE1+4XOfrzqW5jX/di9LFqwjyh3fJop
 105DRdg66KhXt5RTGzeoHrs7rVyIUqjdnK8tGeKOQmQYI4XMw5dSMg0CWKSgQxFpxf4I
 0Rlav2/U03ITaSlZgy9gfmotlXo+XVhP2N5vqRJcqnz1UsQO3ANfWJR66jE+BE4NF1SA
 tQo+Y60cpbGt/GK0k5oFREVqfUjKeaDBZh4nef+7c8HbfWwSmOc4SkcQveIU7A/4u8VD
 dXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844059; x=1694448859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAJ8IyF6qJ4L0zeYktHFZ3FRJiDz0/SjvkZRz5aktOM=;
 b=OnUVwLn6EXA/G1mO+1NiAfDu8nbz1/YMod3L4c+n+xqosFTauAjL+r49Sl9vvR9rQi
 ksqpsWFsT3ObEtYZT2kKtXOs6k9V8XVLN8VvYyPPMTuMmqWhrpNaHFiWDcFKKYSrSY1Z
 jXfzVgYoMS02MAak7VkJZzbvPuGMCWqD3PNE8Sq/Oz4uBkL8gvzCr8IpBGtGikKLfkCP
 2iGd1mEJLNXv0RpaebRrojcFs7aThJ4tlv3aAgm7roWOcXW/t4BEH/TgO0B4XPYotHBK
 tKCiVhc/rEXx9Xechq6tYgZH04r85ehE2gm1r/PphqpU+4aaZnXSQZoz4CCCmsAZ7Q2J
 SuVQ==
X-Gm-Message-State: AOJu0Yy7YgmwfM0t3+Lx4EknrLejqg9Gscmt2MIQQSdC1MbmFDCEgmdO
 Iq3GdRsQXWfMnx6oUGDVndYtfQ==
X-Google-Smtp-Source: AGHT+IHWd3g9dbdAbRXD6k37Djl5t4cJGZUnGQpwQ/K8x8GNzAXQpl5K2XGtunvfqzH19N4u3OObnw==
X-Received: by 2002:a17:907:7813:b0:9a2:16e2:35c with SMTP id
 la19-20020a170907781300b009a216e2035cmr7922548ejc.31.1693844059744; 
 Mon, 04 Sep 2023 09:14:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 pw9-20020a17090720a900b0098884f86e41sm6270060ejb.123.2023.09.04.09.14.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:14:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 18/22] semihosting/arm-compat: Clean up local variable
 shadowing
Date: Mon,  4 Sep 2023 18:12:30 +0200
Message-ID: <20230904161235.84651-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Fix:

  semihosting/arm-compat-semi.c: In function ‘do_common_semihosting’:
  semihosting/arm-compat-semi.c:379:13: warning: declaration of ‘ret’ shadows a previous local [-Wshadow=local]
    379 |         int ret, err = 0;
        |             ^~~
  semihosting/arm-compat-semi.c:370:14: note: shadowed declaration is here
    370 |     uint32_t ret;
        |              ^~~
  semihosting/arm-compat-semi.c:682:27: warning: declaration of ‘ret’ shadows a previous local [-Wshadow=local]
    682 |                 abi_ulong ret;
        |                           ^~~
  semihosting/arm-compat-semi.c:370:9: note: shadowed declaration is here
    370 |     int ret;
        |         ^~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 semihosting/arm-compat-semi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 564fe17f75..85852a15b8 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -367,7 +367,7 @@ void do_common_semihosting(CPUState *cs)
     target_ulong ul_ret;
     char * s;
     int nr;
-    uint32_t ret;
+    int ret;
     int64_t elapsed;
 
     nr = common_semi_arg(cs, 0) & 0xffffffffU;
@@ -376,7 +376,7 @@ void do_common_semihosting(CPUState *cs)
     switch (nr) {
     case TARGET_SYS_OPEN:
     {
-        int ret, err = 0;
+        int err = 0;
         int hostfd;
 
         GET_ARG(0);
@@ -679,14 +679,11 @@ void do_common_semihosting(CPUState *cs)
              * allocate it using sbrk.
              */
             if (!ts->heap_limit) {
-                abi_ulong ret;
-
                 ts->heap_base = do_brk(0);
                 limit = ts->heap_base + COMMON_SEMI_HEAP_SIZE;
                 /* Try a big heap, and reduce the size if that fails.  */
                 for (;;) {
-                    ret = do_brk(limit);
-                    if (ret >= limit) {
+                    if (do_brk(limit) >= limit) {
                         break;
                     }
                     limit = (ts->heap_base >> 1) + (limit >> 1);
-- 
2.41.0


