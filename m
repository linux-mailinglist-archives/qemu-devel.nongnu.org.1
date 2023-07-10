Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 250A274DCDB
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 19:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIv7P-0001PT-F4; Mon, 10 Jul 2023 13:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv7N-0001PH-Jk
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:56:13 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv7M-00031U-0n
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:56:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3094910b150so5263062f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689011770; x=1691603770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d88bgK5nKTUjHgwCFSumEr074aVt3uHbLJ93tUHMNrI=;
 b=VYT8pVKRc+RqoLBybiDCJfbBbe6nV5IcCc2gEgkuj+VP0VTP7/S4CQDbDAKosvr8AY
 MhHRvW9MMkA9haJu6VYLdC7MKjX/cdHA9ak61eD8tAByPNTZW4BklemNaWcf9aDCirQr
 6StwwoDss2MkmfA1eBoFVlZ7MJEJuNaXcTeJpRsrNmzgxB5dBDwae2AXOE4Ui8Xc0kQC
 yyZWkdV1S1AsFwPFGKSjNjGflXHNPk08CBr1Y4gXfCktZwekwbi7eyxMiSII4xNepN0z
 s/xKHIvfExdfgYr+Rb/ufryLK0wOTXIkOfBGrni93ZUqB0RZNecK2SMgfM8R7a1y4HJi
 j46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689011770; x=1691603770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d88bgK5nKTUjHgwCFSumEr074aVt3uHbLJ93tUHMNrI=;
 b=VDUGkW+5S+pmA0yiwr9Wf4Ia39nte6ou3NTILXW6XCjOr7rREQOJoZzmnJPEkMshOJ
 HxN0Gqpxllolkm7tWMFA2zSkwJLPUg3pnGy7HY9PdjR0rF739QKsSJuqIskPdJvY4M/I
 8DKJhQipBMT5abDgaHxpAj65+87GvBVKHtqMAPTBGuKOXdQF+CAG3IjdBdqBzljI0yT7
 DTJ78uVPZuyym4jxfpB+lLE/tqkwpHBO5M8rKX5BtEb/rUUKuYY5xbWJCrvf7QlFMDs7
 bKmSvwleFZSmqslmoOyg/2iAbkunjnGWyK6v10Js2UIwrnuPl9UJ5UqJxswErNarY7zm
 aMiQ==
X-Gm-Message-State: ABy/qLaFPZdhbaZBrrvseBqcpsQGQKjguHBTbSW8TOLf/FA0MKb5nrjS
 fuqG8nvpb4AcnmHQ/7x1oIaE/jYuIT42GNGGeKAxng==
X-Google-Smtp-Source: APBJJlFkuE+sqpaXbz5et7uDe0IMZoHNvMFOQPpnFIeMGayVqjntX6MmQo0xjj9rO6lBxt32JAlVSQ==
X-Received: by 2002:adf:e7c1:0:b0:313:f68c:cfe9 with SMTP id
 e1-20020adfe7c1000000b00313f68ccfe9mr7513137wrn.35.1689011770339; 
 Mon, 10 Jul 2023 10:56:10 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 m9-20020adfe949000000b0031128382ed0sm25773wrn.83.2023.07.10.10.56.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 10:56:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/migration: Restrict initrd-stress.img to Linux
Date: Mon, 10 Jul 2023 19:56:07 +0200
Message-Id: <20230710175607.32818-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Trying to build initrd-stress.img on Darwin we get:

  $ ninja tests/migration/initrd-stress.img
  Compiling C object tests/migration/stress.p/stress.c.o
  FAILED: tests/migration/stress.p/stress.c.o
  ../tests/migration/stress.c:24:10: fatal error: 'linux/random.h' file not found
  #include <linux/random.h>
           ^~~~~~~~~~~~~~~~
  1 error generated.
  ninja: build stopped: subcommand failed.

Per the include path, this test is Linux specific.
Since this is the single binary built in this directory,
restrict the whole meson.build to Linux.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/migration/meson.build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/migration/meson.build b/tests/migration/meson.build
index ac71f13290..56523e0785 100644
--- a/tests/migration/meson.build
+++ b/tests/migration/meson.build
@@ -1,3 +1,7 @@
+if targetos != 'linux'
+   subdir_done()
+endif
+
 sysprof = dependency('sysprof-capture-4', required: false)
 glib_static = dependency('glib-2.0', version: glib_req_ver, required: false,
                          method: 'pkg-config', static: true)
-- 
2.38.1


