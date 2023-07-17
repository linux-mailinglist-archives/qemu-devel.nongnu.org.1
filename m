Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A087F756350
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:53:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNi3-00040X-Lu; Mon, 17 Jul 2023 08:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdr-0008RX-QA
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdm-0008T5-Ag
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbea147034so40886155e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689598069; x=1692190069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+E+optEz0nYwCwN2hJQhLLatmGokjisG+592zq4NO/8=;
 b=Ivq7E0ZQ29pk7V0StaXJ8b61sMdqQG7h2pNDu7n3qZCpESOR97i9KtIqSq5rWL4Q6J
 N5ETYcURe6o6Wh5ZhV2DO/fzI/HhXIK+qZBeA3vHz07vy+zqwQsSNhMAOPrAh31D1Q7Z
 yTmVx5UAGfvpPp80LXbrSCjtdgYJD4QTi5TbMd2jNdULw67TV7IbYWVOpvbP/AFLGMdJ
 wTk8tzEaWuS7aFZgmt0aoBqXFAsNqirszpBIdXeuCB1GM4I31+eEmzK5NfiYR8nI2Sx4
 zrqR6vElpyTfiboOnlrS4t5BfI9G88I3E92DpXh54TwzrKbufp8ZnIldh7DlPPJfUQYH
 pWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689598069; x=1692190069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+E+optEz0nYwCwN2hJQhLLatmGokjisG+592zq4NO/8=;
 b=IwMw/q70W0Cq21rsIJr4Acv7oFLvOsHTFcODGM/cJ61/b/j1yCNax1V4TDR99SDqBt
 Wvw6OcSowcJs/b70y1wuh38vjqzoOFOhFNggxI6kY+Ktn5wOUFb71bphOusMMjaniC2Y
 28r71FX9Mi365hW23ZzZoWhQ+xQDzMkF/M4l/3Va7TxqvgeMsrWmcnFEt0syYhXE9e+l
 MXWfkAazM6f2VnvD9VWTxCzf8tB7jV7rfPG/g8S0mrfjYZnH7ASprplEfnCQXg98LUZY
 Z87p8ZeOfs5wJHtMYFyFGO52ywWQ9dF4EGET2G0c7OzqeHLHUQHPh+NTxBDTm1PFe7bg
 jCVw==
X-Gm-Message-State: ABy/qLY+BJX4nmIpUwmnHgsv6QsVli5qNz/akAnpVk+e7gre3hLDz6D6
 TSVJOfIJ2GBgpWbFe5jeoxWwvHETiGSfonqX5Kw=
X-Google-Smtp-Source: APBJJlGB8EngbRkoTezBRAee1MVhdEobTe093wE2xbHG3Lu3tLqpZLwhYfYzULH9smMXvMyn71MPPQ==
X-Received: by 2002:adf:eec7:0:b0:314:4925:1704 with SMTP id
 a7-20020adfeec7000000b0031449251704mr9840535wrp.6.1689598068791; 
 Mon, 17 Jul 2023 05:47:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a5d6790000000b003112ab916cdsm19337737wru.73.2023.07.17.05.47.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 05:47:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/7] linux-user: Remove pointless NULL check in clock_adjtime
 handling
Date: Mon, 17 Jul 2023 13:47:41 +0100
Message-Id: <20230717124746.759085-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717124746.759085-1-peter.maydell@linaro.org>
References: <20230717124746.759085-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In the code for TARGET_NR_clock_adjtime, we set the pointer phtx to
the address of the local variable htx.  This means it can never be
NULL, but later in the code we check it for NULL anyway.  Coverity
complains about this (CID 1507683) because the NULL check comes after
a call to clock_adjtime() that assumes it is non-NULL.

Since phtx is always &htx, and is used only in three places, it's not
really necessary.  Remove it, bringing the code structure in to line
with that for TARGET_NR_clock_adjtime64, which already uses a simple
'&htx' when it wants a pointer to 'htx'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230623144410.1837261-1-peter.maydell@linaro.org
---
 linux-user/syscall.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 14641518262..c99ef9c01ef 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11190,16 +11190,14 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
     case TARGET_NR_clock_adjtime:
         {
-            struct timex htx, *phtx = &htx;
+            struct timex htx;
 
-            if (target_to_host_timex(phtx, arg2) != 0) {
+            if (target_to_host_timex(&htx, arg2) != 0) {
                 return -TARGET_EFAULT;
             }
-            ret = get_errno(clock_adjtime(arg1, phtx));
-            if (!is_error(ret) && phtx) {
-                if (host_to_target_timex(arg2, phtx) != 0) {
-                    return -TARGET_EFAULT;
-                }
+            ret = get_errno(clock_adjtime(arg1, &htx));
+            if (!is_error(ret) && host_to_target_timex(arg2, &htx)) {
+                return -TARGET_EFAULT;
             }
         }
         return ret;
-- 
2.34.1


