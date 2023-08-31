Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3996878EE4B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhLQ-0008Aq-OL; Thu, 31 Aug 2023 09:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhHu-0007Mn-Uj
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:00:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhHq-0006lt-Po
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:00:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401b393df02so7999425e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486837; x=1694091637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uHTYP96hxROQBfiRHrUY1wrTC25GMnf+igTYqzxdbDE=;
 b=WD6MAfLiIo8WFCh9IzuyV3eICQyOVpEgw1+9dovw3501/dIr9lvebzAf8+bRn63dUP
 70Q5LftB9Nlee7NrBqhxg1FUenpbAZdn4xxjhfMc9uOL295JqCqDtO3shCQOB8RlGZJy
 C+pQRAEPasB3nJJ0jUyfe+BH8k9nf/N1Z70ERrxVniOIGBMEp+lYzAw7pPXhIBCxxrRH
 9XgTw9r2Xtrmo6lgk/otO4EAHwGj51pefzBFefg7SIttWzmNzVbspBXCtLUyIw2ZIRxM
 vMZnK2RTQiwC7wQiSBf//rwChAIwapxwgQ/mS8Mzl+PpT6gL9ZGcBFcTEBw1PcHpdOR2
 1P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486837; x=1694091637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uHTYP96hxROQBfiRHrUY1wrTC25GMnf+igTYqzxdbDE=;
 b=KRKDRMaT/QRuW8LiCUO9f87GY1DO2+hmcbq4mHmgBSoVLM4BJ7N7g9B6IhBnqJac5h
 D4b5StZ9rolXZ5F7BwJy9sfF3nYVaS0nKUtXoRiOQZxpvwIOo8XqCcy+fjDpPpd6e5G6
 SJ979O7w4KeVpithXCWWGeOTF9kR7T9ZOQPxRyRfbVrUlz+R2FZS8aiwI+/49uDZwJ50
 tn7QzGgYI5ZOLpQxcCXA3NIu3jBaDW+TDrhkAmWzL9cRIlx8ILJNLuHBbv+SRFg5e7mY
 dHb3eMG5oyFO7EieT5xK8xEWT7QIxUwv8TyYxPRbQALw68OU00IPtKPRgE3IgHtU/wcE
 xq4A==
X-Gm-Message-State: AOJu0YyDticqiGdPicmargilCvqspnAY3guXaSMWWg4YvTwUgbZba/tx
 4vcPnReyFDHaTfEqYqk00NEUW781EW1OIyQX1z0=
X-Google-Smtp-Source: AGHT+IHSfjXXbD7/9ei3HXX1kSg6gDM000wd3/dTlZv3LZYaKRVUta2cW+0Bh9erRMeVWfzJCTAoYw==
X-Received: by 2002:adf:f5c6:0:b0:314:3b02:a8a8 with SMTP id
 k6-20020adff5c6000000b003143b02a8a8mr3761369wrp.55.1693486836365; 
 Thu, 31 Aug 2023 06:00:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 r5-20020adfe685000000b003143867d2ebsm2189041wrm.63.2023.08.31.06.00.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 06:00:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PULL 38/41] docs/style: permit inline loop variables
Date: Thu, 31 Aug 2023 14:56:40 +0200
Message-ID: <20230831125646.67855-39-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

I've already wasted enough of my time debugging aliased variables in
deeply nested loops. While not scattering variable declarations around
is a good aim I think we can make an exception for stuff used inside a
loop.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230822155004.1158931-1-alex.bennee@linaro.org>
---
 docs/devel/style.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 3cfcdeb9cd..2f68b50079 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -204,7 +204,14 @@ Declarations
 
 Mixed declarations (interleaving statements and declarations within
 blocks) are generally not allowed; declarations should be at the beginning
-of blocks.
+of blocks. To avoid accidental re-use it is permissible to declare
+loop variables inside for loops:
+
+.. code-block:: c
+
+    for (int i = 0; i < ARRAY_SIZE(thing); i++) {
+        /* do something loopy */
+    }
 
 Every now and then, an exception is made for declarations inside a
 #ifdef or #ifndef block: if the code looks nicer, such declarations can
-- 
2.41.0


