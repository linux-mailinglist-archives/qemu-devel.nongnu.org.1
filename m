Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FCC791B58
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:17:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCDg-0005jg-Dy; Mon, 04 Sep 2023 12:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDd-0005aS-7L
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:29 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDa-0007mO-Gf
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:28 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a2185bd83cso241072966b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844065; x=1694448865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsTnNe2odIs1TlMwUjNe64GWSQVkGVh+b8/mlWNguvM=;
 b=g9QVPfK4eZnVme7n94l/byTu2MOkqs/7+pfhpNlvhSSd0M99+ZL5OK59FjqmdoEL8u
 VgHW9cHqYqj5epCqSn1gETL0OQvsBXHUzWJ9bSdMe477etsXWR4ngCOh8yG8kcjd1btS
 z+U8pqD7Jzmd61Gq6atqUFUEie/q1yoT6sRV9T+gJNbu9k0pwXxwNMgQCzk4llc5AUqN
 2DKg+8KUO5DBn607uhsra33KwbegPgKc1NA+tPaA3qDA808Y5abKAyOmGxbyoLdsbMLb
 xUK0rWmAcu8B5DpFIZaPCmGNoy5MLtK/WqAp2j8MNkvjUVVbNKYiEXJJF7dVjCgSdWo+
 VMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844065; x=1694448865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZsTnNe2odIs1TlMwUjNe64GWSQVkGVh+b8/mlWNguvM=;
 b=D9BqUqh0fqjj645M6D4iBnT/l55VrC3lrM2iYlr+6Xoa6uG43Pl/iPsDL/U51qZtKS
 k3ktsLaqWhb3shAGF0Z2Bagu5gAssKbrdvFai30o9EK70KSH52eMyt7DW8lL83fPDpox
 ct964A/JQuq7Dz2AjJ+/0V7eDSU+qBkbTMj5dZS/SMDARIkP2kDF9H27YeKWS26+MDvg
 sHpJdzsWHipy/BrMz3gJFdJYtSfubSgNvY4iBnSjDUMmv1DnWlEtsY9fYwrHtoKcMlzD
 KONtlaoQwfROC0LT3mOhMuLHGsflAHZd87pDLnJHWiBnRgC0yF5XezQQ5Bj1w/u3qdoJ
 a2yQ==
X-Gm-Message-State: AOJu0YwL/RKAsmrsp/rCvsy0CdTNBBWcfpxgrBu5cFb1wypM3URg+SV4
 fKXA/84EK2c+9l/j017zoumhpQ==
X-Google-Smtp-Source: AGHT+IEXkuzRXUQdr5kibF9Hf+R77BeWDLmPe1Qc4dfXdNjTuHHaPn+Rd/7VONBl181PM3uXF5FHiQ==
X-Received: by 2002:a17:907:75e6:b0:988:9b29:5653 with SMTP id
 jz6-20020a17090775e600b009889b295653mr6541467ejc.77.1693844065083; 
 Mon, 04 Sep 2023 09:14:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a170906824300b0099b921de301sm6338473ejx.159.2023.09.04.09.14.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:14:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 19/22] linux-user/strace: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:31 +0200
Message-ID: <20230904161235.84651-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

  linux-user/strace.c: In function ‘print_sockaddr’:
  linux-user/strace.c:370:17: warning: declaration of ‘i’ shadows a previous local [-Wshadow=compatible-local]
    370 |             int i;
        |                 ^
  linux-user/strace.c:361:9: note: shadowed declaration is here
    361 |     int i;
        |         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/strace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index e0ab8046ec..cf26e55264 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -367,7 +367,6 @@ print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
         switch (sa_family) {
         case AF_UNIX: {
             struct target_sockaddr_un *un = (struct target_sockaddr_un *)sa;
-            int i;
             qemu_log("{sun_family=AF_UNIX,sun_path=\"");
             for (i = 0; i < addrlen -
                             offsetof(struct target_sockaddr_un, sun_path) &&
-- 
2.41.0


