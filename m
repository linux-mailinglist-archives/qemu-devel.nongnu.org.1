Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D88821653
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:03:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3o-0003mI-Bs; Mon, 01 Jan 2024 20:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3f-0003i5-Iu
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:10 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3e-00075W-2P
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:07 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5c21e185df5so6728040a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160744; x=1704765544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKBqBWVnteg7nBg0Ct8xapNabPHsKvd3tq3kc9va8Z0=;
 b=MPckM0YuV/jFqFQXkL4L3ij7UFn8w2pCpZEHmpn+IL2RfR5jbjDktgy5t4Z6Wy1MtL
 wONNQiuRd4U9nyiJxrxq7rexQeBT01y29735acTYma7+OvbXFXo1Vkl2FRtYhMbHJYCp
 XpNmb/3yjJWeKZsnkqwbGEikK9nBEOzVbIHJNeGYjuqN4d4c1fRQNFZngH4Qqr/Q5pVT
 i02PEQ7CC4b0YBaC93mcqT5FNSAiGXa3cftdBFS14IXVk5pPs8mU1WhjpUboe2m/tygN
 VogTsoOCAHXbAPXvNbzTRWLWpH4ZkrvVZk6kbMr9XpoT5NS/375NcWa/tAEDQfBLxPzD
 ppMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160744; x=1704765544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NKBqBWVnteg7nBg0Ct8xapNabPHsKvd3tq3kc9va8Z0=;
 b=iYHo4d6TtDC/OcAGHk0W2McCOVL7KyDnJaQknabJqWwvIQ/xOk0m6anW2EWa8jSgmo
 9wz6BZ8WS/sia9HN2Biwh6nVYClO0spf2JECy9s4diAOXTlNEL/6P9uAnzJdXJyRneVR
 2tCgswJ03ofsfmDg1L06FP4m4mllQYDloHoXhMTw37uS4n5zlXgfwqyCvrHVBXusM+Ns
 25FltSO7UVnviyRTQJg3E71sqAFUuKI9/q24S3UmFlPXmHqxH/9KteDFEfghT5Hu26GP
 ZH3HTB/Dr9wQu+CQSZSk9MD41lemfbqrSIUzVqUP6/XA5cEE0oMC4H2XAb6ne+zhcF6G
 BoSw==
X-Gm-Message-State: AOJu0Yzbc0B8ErW0ajTtGiI9eVD04LyqBa5bTgf7qeI8owIVWBFjd3rv
 W1fe9QZj3nrzQvkQ+KPidl7s1vKVu0oSaTPs6Ov1CHcdjGI=
X-Google-Smtp-Source: AGHT+IFyMl1BSFmDo1oCTQ1t0Wp94IaM/eRJ8+F+zqGdVPQfbblnHF3Q5w9g52gO8YEsDlOXQzB94Q==
X-Received: by 2002:a05:6a20:3791:b0:194:ae7b:3847 with SMTP id
 q17-20020a056a20379100b00194ae7b3847mr16474705pze.34.1704160744753; 
 Mon, 01 Jan 2024 17:59:04 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:59:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 25/33] tests/tcg: Extend file in linux-madvise.c
Date: Tue,  2 Jan 2024 12:58:00 +1100
Message-Id: <20240102015808.132373-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

When guest page size > host page size, this test can fail
due to the SIGBUS protection hack.  Avoid this by making
sure that the file size is at least one guest page.

Visible with alpha guest on x86_64 host.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/linux/linux-madvise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/multiarch/linux/linux-madvise.c b/tests/tcg/multiarch/linux/linux-madvise.c
index 29d0997e68..539fb3b772 100644
--- a/tests/tcg/multiarch/linux/linux-madvise.c
+++ b/tests/tcg/multiarch/linux/linux-madvise.c
@@ -42,6 +42,8 @@ static void test_file(void)
     assert(ret == 0);
     written = write(fd, &c, sizeof(c));
     assert(written == sizeof(c));
+    ret = ftruncate(fd, pagesize);
+    assert(ret == 0);
     page = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE, fd, 0);
     assert(page != MAP_FAILED);
 
-- 
2.34.1


