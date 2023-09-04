Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA70791B99
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:29:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCRZ-0002N2-Rc; Mon, 04 Sep 2023 12:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCRW-0002D8-FO
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:28:51 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCRR-0002NC-M6
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:28:49 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52bcb8b199aso2171118a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844923; x=1694449723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V09dNf7wDwvKMqEpQRqfZrZ9Vsl+ZeGkw36NfyqmYlI=;
 b=JB3t0H6GJVI0lR6dWsBAT2L22pH5WV5Qy9aQ3QsrMrUcOgyOJ1P1rmHSxJ0EAu38cJ
 dE2dwLmCPNtZKLNPiZ5k0QXdZGqI/TTZteWCeWhgBKy3/UB2p/k22Jhmkv/Xg6DvGMkm
 DYKk3DulgKqm1yvqXX4hXM9z5Fw9o5Ot4hCrDIqaURRAM70i45qLG+1eYvln0W8r68zY
 IqOftDvwucu0oJXMrUf03+tWQpPrTeNouMUi9bO9L3VXJ/vzaNUwLLClpLx3vpmos2ck
 vBRxYWxN/gYDnyONbkPKUU2S+tIySGU1e81SKgBW4Mm3oTTZ3fPdcbTI1WsrBd+rMqiN
 QWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844923; x=1694449723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V09dNf7wDwvKMqEpQRqfZrZ9Vsl+ZeGkw36NfyqmYlI=;
 b=CzZNXv+5F1Cg8qdVL0/2EIpTTIVHZ4/82t5Flvaj1pkMqCNb73hTo+FcedyjIyTS9/
 HVfzbA30XgecY2HqS9XUGzOfhPFXR6Ew8gRko77hMuaA0rAb+jJHHJXuFUXYdwGxAMv8
 5uSXPJ1+8xWpnT4ILkGHwRfCzcKSq8g0pS/yVq1GPJb/TZMmGzBJY/RbC8OC5MGG+UuQ
 yqEKkUNuHcR+t59DUzYAP+dBAuHhY3lPAyMMSSMAPlO7mDMK+UlT6y+nUyP+eOJ2cTxY
 vJfgpAcrmjcI1+Q16U+1LtJiKLywNRVmlFr+NKr3ZAbqjqnLS168V9zkkGUIzlvOjtGb
 N9Bw==
X-Gm-Message-State: AOJu0YzrKoudSsXs4h3bhmSygD4pGHVXMdfixcgAhgXsRnGXC/YFA+KT
 K3Z/TuEIQyZm80XAUa96a3Gl00Rus3Mhjbil+YM=
X-Google-Smtp-Source: AGHT+IHPiHFlKCOIwU3oTD6y+IMPpuzCLKVP2FXB8LUj16xnEOzjZ4PG/bhSxJsLeoCIuIGEbuwBJw==
X-Received: by 2002:a17:906:224a:b0:9a4:88af:b77 with SMTP id
 10-20020a170906224a00b009a488af0b77mr7963442ejr.60.1693844923230; 
 Mon, 04 Sep 2023 09:28:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 ss20-20020a170907c01400b00993159ce075sm6356037ejc.210.2023.09.04.09.28.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:28:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/3] tests/qtest/pflash: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:28:24 +0200
Message-ID: <20230904162824.85385-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904162824.85385-1-philmd@linaro.org>
References: <20230904162824.85385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

  tests/qtest/pflash-cfi02-test.c: In function ‘test_geometry’:
  tests/qtest/pflash-cfi02-test.c:409:22: warning: declaration of ‘byte_addr’ shadows a previous local [-Wshadow=compatible-local]
    409 |             uint64_t byte_addr = (uint64_t)i * c->sector_len[region];
        |                      ^~~~~~~~~
  tests/qtest/pflash-cfi02-test.c:342:14: note: shadowed declaration is here
    342 |     uint64_t byte_addr = 0;
        |              ^~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/pflash-cfi02-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/pflash-cfi02-test.c b/tests/qtest/pflash-cfi02-test.c
index 0b52c2ca5c..8c073efcb4 100644
--- a/tests/qtest/pflash-cfi02-test.c
+++ b/tests/qtest/pflash-cfi02-test.c
@@ -406,7 +406,7 @@ static void test_geometry(const void *opaque)
 
     for (int region = 0; region < nb_erase_regions; ++region) {
         for (uint32_t i = 0; i < c->nb_blocs[region]; ++i) {
-            uint64_t byte_addr = (uint64_t)i * c->sector_len[region];
+            byte_addr = (uint64_t)i * c->sector_len[region];
             g_assert_cmphex(flash_read(c, byte_addr), ==, bank_mask(c));
         }
     }
-- 
2.41.0


