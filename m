Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DE780EA6A
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 12:31:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD0yI-00069t-1j; Tue, 12 Dec 2023 06:30:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD0yB-00067K-SM
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:30:36 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD0y9-0004Db-F5
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:30:34 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54c5d041c23so7613891a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 03:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702380631; x=1702985431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCdPCnhAmawlvGjzJcBxXQKNZDPrtvUlP4jFKDMYMSc=;
 b=DbYO8TXovEskdgMldCCsIJc9L4kZbBMLf+F+7WRrbcDGqk9kcp1EnD7cJKb4g3isWc
 9trDnxlMHrDyuu91GzXMqXBKmW3XO0o4YN3ZKqVBxmJPtULfo9+nonRqV/G4LmxyoW++
 kUEePD/x2we6zmdV0gZFkZwJYZKjXEdSE0qRRqiXRIyOt3uVh1pPACbkqQBW+0KDulNo
 jz2/hD4CBfuBjz/SxFO1mcCol1gr02yM02HWTYa4ex67n8+qRzLxWY8h6AvXfe1EABZv
 79PohnNZ3lCVvVxlIETPUB53MFYy4KCiIlDdUdPOuKkdRBqiNKek06zgtJ0doncIwCo0
 52Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702380631; x=1702985431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCdPCnhAmawlvGjzJcBxXQKNZDPrtvUlP4jFKDMYMSc=;
 b=V9Eh/YclKgQmU0rD5f4sqGRTBJHZdeC3yAVzYvmKopRT655EFw3aMXA5U8kY0+Vxqq
 afQYvZDJGPn9f2yfM175uXmwqamZC3c/WopAiECz1b+N/oF5DaPdhL0ZN57vsWK863y3
 j8gaDgD7IcqaeTnFeVXRXnErXfbPB0LOOSBC4g5FD3oCOz9NCJw8ojOLaJFpcQ9YDzR5
 mjoGHuzSlB1BdoDqSRDz7lV8jXFhoix5OwIop/B6WuuONB0IzViKyMw7TnzrZF95/9Jq
 yUNj/vAcGjj5O/OP3qEvirRJ4TwKSSlFBZXWDA5ysvcgaaM1vbszysCHvqLf36yPn7Nr
 C/GQ==
X-Gm-Message-State: AOJu0YytksGY28+Ckp4ebH6s7hwXawioyBer0Y9zNXFxSwSJ9lwMfOdA
 /n4jys/WcRvXKWaHDeUR9cIJql4Aj87mxISUttTuFg==
X-Google-Smtp-Source: AGHT+IERi3FWynU+KUuYflnt7QPdg89Bev5Aeyg6L7KgrFsZi4fhMECbTiNx13p3yRIL7tcflzxZcw==
X-Received: by 2002:a17:907:7ea1:b0:a16:88e8:2de7 with SMTP id
 qb33-20020a1709077ea100b00a1688e82de7mr2246852ejc.23.1702380630950; 
 Tue, 12 Dec 2023 03:30:30 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 ll9-20020a170907190900b00a1da2f7c1d8sm6118003ejc.77.2023.12.12.03.30.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 03:30:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] system/qtest: Restrict QTest API to system emulation
Date: Tue, 12 Dec 2023 12:30:16 +0100
Message-ID: <20231212113016.29808-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212113016.29808-1-philmd@linaro.org>
References: <20231212113016.29808-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

Outside of system emulation, only qtest_enabled() can be used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/qtest.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 85f05b0e46..b5d5fd3463 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -23,6 +23,7 @@ static inline bool qtest_enabled(void)
     return qtest_allowed;
 }
 
+#ifndef CONFIG_USER_ONLY
 void qtest_send_prefix(CharBackend *chr);
 void G_GNUC_PRINTF(2, 3) qtest_sendf(CharBackend *chr, const char *fmt, ...);
 void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words));
@@ -35,5 +36,6 @@ void qtest_server_set_send_handler(void (*send)(void *, const char *),
 void qtest_server_inproc_recv(void *opaque, const char *buf);
 
 int64_t qtest_get_virtual_clock(void);
+#endif
 
 #endif
-- 
2.41.0


