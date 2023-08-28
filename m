Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9B678B3C1
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 16:57:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qadfF-0003XD-QY; Mon, 28 Aug 2023 10:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qadfD-0003Vh-2F
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 10:56:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qadf9-0000hk-AO
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 10:56:22 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso31107395e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693234577; x=1693839377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0c9RUkLqeb/dUA6rdk/b7YWrq3qs8i6j4y2xORygss=;
 b=lMCqUxq3kCSkpFfLlHaGc43t/H8kjzJrNqZwgE8+i7pZkWKd3kZ6qy0MIKlsaTCpa7
 OZd840XQDIqp+YbIlyMK96SA3+Xs6c1VkYI9QAQOfLhuDkng2U0COkn3itO7AxYGkY4X
 5QeCCX2OKwa08nsl1O2CPfZmYZyqJ9eh3k/p8K1EFfout35o2I09Nh9iuMeQNumMrOrP
 7tyeLSDXjREbmxvF4BioxA5wP18FUatwWiz/Q2rR+12L9XkZYA5RZb3riKR6ahx3gSo+
 P+70K9Sub584uZBhO4dbH8smLwYTtfKGr82TYCsDFCbL/IwKvjNuFMPqEbs3UfpPrmGV
 Vq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693234577; x=1693839377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0c9RUkLqeb/dUA6rdk/b7YWrq3qs8i6j4y2xORygss=;
 b=aSIJgNuL3QQooUhWTk9QxOQavhMl3rO5LaGFGEyg8PRryyjwNDCDM9d52J73Edj0Gt
 +B1s2tTS9gogthP8d12dezPyEU2uSBJc000BTdpcPTvckhTUsNsV1Vwt89cRAlKeBQFH
 o60Dl4WdeDDTMjvwAWuovt1QeXVlks9d4GRsDOyLdnpXp8Ut0LSpRwsdyITf7AzI2K70
 gIk/2SIOjQlV+XFcu9a+NvXT0BAtlzxNprX/YBjuh5Y+obajzT32+pEKcs8N9mMiMHZx
 PDlwdc7Jm+SnRkXCLKTIqQYL7zGpZDJSo1bbe3dqZdnERSh4gmWFCgEGIKB9rxs64crm
 KQfQ==
X-Gm-Message-State: AOJu0YwNNy7H5xXHKUP4OzQtr3LSUscoCwmo8O94eVrO6iAWwp2S7AGP
 ZIKMGNF58IoY7FNlFFC/gmBy1Ga14KJmfQ5Z/Co=
X-Google-Smtp-Source: AGHT+IH8LHJo7gZTtmitP3v/Wqoj+m6D0mGjMDfoK2eVsNPqEevC5RGFoMKtQlURFl4sVPTrgARqgg==
X-Received: by 2002:a7b:c455:0:b0:401:c436:8999 with SMTP id
 l21-20020a7bc455000000b00401c4368999mr3828849wmi.30.1693234577802; 
 Mon, 28 Aug 2023 07:56:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a7bc4cc000000b003fed8e12d62sm11070682wmk.27.2023.08.28.07.56.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Aug 2023 07:56:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/8] target/translate: Restrict 'exec/cpu_ldst.h' to user
 emulation
Date: Mon, 28 Aug 2023 16:55:42 +0200
Message-ID: <20230828145545.81165-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828145545.81165-1-philmd@linaro.org>
References: <20230828145545.81165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Only handle_sigsegv_accerr_write(), declared with user
emulation, requires "exec/cpu_ldst.h" (for the abi_ptr
typedef).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/exec-all.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index d02517e95f..b2f5cd4c2a 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -21,7 +21,7 @@
 #define EXEC_ALL_H
 
 #include "cpu.h"
-#ifdef CONFIG_TCG
+#if defined(CONFIG_USER_ONLY)
 #include "exec/cpu_ldst.h"
 #endif
 #include "exec/translation-block.h"
-- 
2.41.0


