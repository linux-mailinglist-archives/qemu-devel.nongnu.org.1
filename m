Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 844A17FF811
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 18:20:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8khP-00055y-UW; Thu, 30 Nov 2023 12:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r8khN-00055E-Ba
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 12:19:37 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r8khL-0006db-TN
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 12:19:37 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cfa5840db3so11252015ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 09:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701364774; x=1701969574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGaFxDd9DEgIY946KKxNCCYQHrryKrWh5AcjMejeCmY=;
 b=GWv+dUDnBRa8ngDezM0lLSRt7ieJHmjJzmYp+ujFbqGm5dOxynPizD+JBfD/QWTmw2
 jW8MVq8W2OjxWfKz2nCE+OUD9jZ7FCLQsN02JK++70zpleHTvxhAdiLRA39Qg1tHOxoa
 NhIlnz98jjsTtNyPUpR2jXq1sdAnC1J88cdO4wuCpKXD2klXqIGxsJd0O3hNtqfp6FpR
 jd5z+inS/SuTtgpfwj3R3F2yjetddazQ9hwbUgJiDsy2Y6GZfnVa+wr6yZIiVQdqQIT+
 d+AIS7Q8KPU3bmXsbHfGvNJSsjVZ4LissIdYXs3+1NweP6jrUnlrFZ/b3fAlvkugua7F
 a//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701364774; x=1701969574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NGaFxDd9DEgIY946KKxNCCYQHrryKrWh5AcjMejeCmY=;
 b=OMfFxrbQP1WjkzQtGZvtcXTG3Gi+PelW/uHnuGwAz9XHTXTviEvXtY92rZgDunqcTF
 +LgciCVdSg0vcAUgfsgSwc4LRBDfw0v6TyiAo0GH2WrZBJAFHxhBFEU4JjFfh9JETBMG
 Gg5fnS/sztgv7BGUrsRw7SvpfNlZjjPijd+TS/8qXuglrladLg0geD8FufFG6990NJ8u
 ZMuQz1H6Y3UbTYYZe3q/QPNSPhYwgMQ8RVowa7d2/YGZPMjVrM8XYwO6BwmaZc30EJeQ
 v5KcNZojU1XGmd3HwRgKuyxsUDFfMSBwoTKd4I2wETGZvVTPsiPhamTar3+TiM88+UDJ
 uAEQ==
X-Gm-Message-State: AOJu0Yx2F0PRyPQ/qX0vHUUQIkXb0p+dakSEtkHjfWnwdDjrr8oiw+MW
 AiYzJSATnCA0la5g2CjazeKxx+TCvr8=
X-Google-Smtp-Source: AGHT+IFUVoe11eoZ2T5TJ0ADewQphfA2qPSEp0EHce/eCPspGNjqMobYxN5Lpo2USuY4H6VRwRTwKQ==
X-Received: by 2002:a17:902:724a:b0:1cf:d2c3:2865 with SMTP id
 c10-20020a170902724a00b001cfd2c32865mr13135930pll.40.1701364774296; 
 Thu, 30 Nov 2023 09:19:34 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:646:a201:19d0:7eb0:c76b:d82c:8f94])
 by smtp.gmail.com with ESMTPSA id
 bc3-20020a170902930300b001cc29ffcd96sm1645926plb.192.2023.11.30.09.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 09:19:33 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/2] tests/tcg/xtensa: add icount/ibreak priority test
Date: Thu, 30 Nov 2023 09:19:20 -0800
Message-Id: <20231130171920.3798954-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130171920.3798954-1-jcmvbkbc@gmail.com>
References: <20231130171920.3798954-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

When icount and ibreak exceptions are due to happen on the same address
icount has higher precedence.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_break.S | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/xtensa/test_break.S b/tests/tcg/xtensa/test_break.S
index 3aa18b5cec3f..4c618feb5b10 100644
--- a/tests/tcg/xtensa/test_break.S
+++ b/tests/tcg/xtensa/test_break.S
@@ -129,7 +129,7 @@ test ibreak_remove
 4:
 test_end
 
-test ibreak_priority
+test ibreak_break_priority
     set_vector debug_vector, 2f
     rsil    a2, debug_level - 1
     movi    a2, 1f
@@ -145,6 +145,29 @@ test ibreak_priority
     movi    a3, 0x2
     assert  eq, a2, a3
 test_end
+
+test ibreak_icount_priority
+    set_vector debug_vector, 2f
+    rsil    a2, debug_level - 1
+    movi    a2, 1f
+    wsr     a2, ibreaka0
+    movi    a2, 1
+    wsr     a2, ibreakenable
+    movi    a2, -2
+    wsr     a2, icount
+    movi    a2, 1
+    wsr     a2, icountlevel
+    isync
+    rsil    a2, 0
+    nop
+1:
+    break   0, 0
+    test_fail
+2:
+    rsr     a2, debugcause
+    movi    a3, 0x1
+    assert  eq, a2, a3
+test_end
 #endif
 
 test icount
-- 
2.39.2


