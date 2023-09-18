Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC8C7A4106
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 08:26:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi7ht-00067o-QQ; Mon, 18 Sep 2023 02:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qi7hk-00067I-Gf
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 02:25:57 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qi7hi-0006cW-OZ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 02:25:56 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31ad9155414so3881434f8f.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 23:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695018352; x=1695623152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pM8ji656g6r3sVyQ1eGKRNVB6OG5Gf99yhLOId3yIVY=;
 b=e2QCc0n7C3JpZ3kEdU0pt1gYD2aOoyUdadMjxP8rUAKep1C1rFqgIVYqVfAQYDtT0b
 EF2IirW3U7nX6fjuJYS40r6TrIK9iXR4J8lsGKCByAyqNLrWq/fvr0ox0mhvUntT/DoI
 rACasnDOxYR+wGRErMIa75KRX8wG/Fbq/x1ey7gNX5c/Cut64wnjZmz5GIy3b7f1Ll4x
 vky+jqpJhu/Qid+14Yss3k9IPnsdQpHX7ZiBr2xk84lBv8JCaBWO/IQyaYtyWfLZPKGc
 6jo24IihgfRj7NiH2ITxfqtitPz64+y/NnnQmlaWAp+Rf9eJnqCcbQhYIQfk2HxTILkO
 WObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695018352; x=1695623152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pM8ji656g6r3sVyQ1eGKRNVB6OG5Gf99yhLOId3yIVY=;
 b=uxCcVwn7JONUS75HgbxQK/e+cLqciJ1gYi2zGq0y9L+BBwxN17rxHLnmhTAu+0nj44
 R1GeHsIwvSNwe12xeTJ+t/IRmUGbshHonJgPWx14hMoQEz5uOX9eJm1vez6mOq2LmKJI
 ew1BbOMEziADu08voJSnFosvHXgqtRJDJInU5ZX7diZudz2BU/3HQ2gCG6QffW9xwR6G
 rKcKpOkKECmyekcsTPwnnNvLzt636XmWDBlYuHiADo0clRXcghS5vnZUn7Rew3WoNwZp
 jCrCrTgUjPvtrKV+ve3s7gA/3LENSEtuWQxGoATu9Krmjw3vSrry9yuTZ4OMaiPqb3/9
 /s0g==
X-Gm-Message-State: AOJu0Yy9r3stSYW14KPqeb9jgsaB5yXNpNlgMG98xLHrNBSrgRd9/1yt
 FHScQG0vbgWURh0VaTDZEyfWItuD4gbQFSyh6vyvKw==
X-Google-Smtp-Source: AGHT+IFJvwX9dsDfJI6+ydTTnVbNCcpeEQ8T3PhsleFKMZX9TVBCKdz4+/vgwZ6zKVNlGL4DdkTT1Q==
X-Received: by 2002:adf:e783:0:b0:319:6afc:7a3c with SMTP id
 n3-20020adfe783000000b003196afc7a3cmr6712341wrm.10.1695018352597; 
 Sun, 17 Sep 2023 23:25:52 -0700 (PDT)
Received: from localhost.localdomain (246.red-95-127-42.staticip.rima-tde.net.
 [95.127.42.246]) by smtp.gmail.com with ESMTPSA id
 l26-20020a056000023a00b0031ff1ef7dc0sm8676468wrz.66.2023.09.17.23.25.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 17 Sep 2023 23:25:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/qtest/netdev-socket: Do not test multicast on Darwin
Date: Mon, 18 Sep 2023 08:25:49 +0200
Message-ID: <20230918062549.2363-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Do not run this test on Darwin, otherwise we get:

  qemu-system-arm: -netdev dgram,id=st0,remote.type=inet,remote.host=230.0.0.1,remote.port=1234: can't add socket to multicast group 230.0.0.1: Can't assign requested address
  Broken pipe
  ../../tests/qtest/libqtest.c:191: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
  Abort trap: 6

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/netdev-socket.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
index 8eed54801f..3fc2ac26d0 100644
--- a/tests/qtest/netdev-socket.c
+++ b/tests/qtest/netdev-socket.c
@@ -401,7 +401,7 @@ static void test_dgram_inet(void)
     qtest_quit(qts0);
 }
 
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(CONFIG_DARWIN)
 static void test_dgram_mcast(void)
 {
     QTestState *qts;
@@ -414,7 +414,9 @@ static void test_dgram_mcast(void)
 
     qtest_quit(qts);
 }
+#endif
 
+#ifndef _WIN32
 static void test_dgram_unix(void)
 {
     QTestState *qts0, *qts1;
@@ -511,7 +513,7 @@ int main(int argc, char **argv)
     if (has_ipv4) {
         qtest_add_func("/netdev/stream/inet/ipv4", test_stream_inet_ipv4);
         qtest_add_func("/netdev/dgram/inet", test_dgram_inet);
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(CONFIG_DARWIN)
         qtest_add_func("/netdev/dgram/mcast", test_dgram_mcast);
 #endif
     }
-- 
2.41.0


