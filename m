Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF887BD7F2
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:05:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn6x-0003B8-IM; Mon, 09 Oct 2023 06:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn6H-00032d-O7
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:02:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn6G-00007s-5u
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:02:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-405361bb9f7so39467575e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845774; x=1697450574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KNu5WskARX8t8uiglt34aaZEs4+GnJbim8ACZvASM0Y=;
 b=tXyoQvhkfD2Wf38ehOsdKFvomMms6DhkvoYTz4E2Gx2bPaXF4egALMXxY1SYhWPiFe
 +P4ejsy5TueuAtfS9qUjlej8UOE3eNtNwaPOyIe455iFuQCCFYzNY30uCa7GcsAoZ7M3
 pSwBagpbXbRnPuYfhAG3UXxmiSDHs1Xuneb3MiRma04Z62JeUDuxtlgP//VnLVl4s1iF
 KvGq7lyVsGd0aZi39msvgswS02Y4vtPBzZXybmHVhxTpXMcOo4qPyICzw9NqYBjx9E9t
 uGZ+J1qk7f94eO34S82kkuQRwjqVIo2r7zj8SwxNPGViXtimgHEpA2cKMaSKFoTqL/1V
 iegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845774; x=1697450574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KNu5WskARX8t8uiglt34aaZEs4+GnJbim8ACZvASM0Y=;
 b=ptDSRbVZ1p04UlwRzdSXPtsU9qJT8Y1UKkT46ceTNlkuDn3nEgml76Zl9ItxLNIMpD
 ON9ahTd8nD5607G7Wfe7uSFRSJaeHtHTtZZNrxajQ45EJ9dMY88s2ilXxX4vVErkJxCZ
 e1Ani1nNoLu6QnXGDhao0wKGFKsWIp912TsU0iO9UQchY9dWkTeDk359IAbBF8buY7/Q
 0Go3wKQvQ+UdAVPMOzLbux7gJ8Zq+ifdbPJgSDWAglkmlZAIvqdVsBiQuEPdsMvEGRzD
 Unxy+Cu6nxT0aF4sfsG8auSEZB0BTOZ/og0sslOm78tV62amnEYiQnQWH5GdmA6UamID
 bGog==
X-Gm-Message-State: AOJu0YyV6Rd6VcjqVHvTRSe0IbAwgmLn4r56n3Z4eWhD8lFrLIRtTba6
 3QKzVts0MzmAoCZgVMucAFApz8sfb0nGD4Utu9A=
X-Google-Smtp-Source: AGHT+IFWM5+CPXvfbvoxyJmzXh58S45SE0RPsyJt6Kkp58zLCqV+OdcFb/Hx7DgR85nvymsZMrzaJw==
X-Received: by 2002:a1c:4b07:0:b0:405:3ca1:f6ba with SMTP id
 y7-20020a1c4b07000000b004053ca1f6bamr12278207wma.3.1696845774603; 
 Mon, 09 Oct 2023 03:02:54 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 n20-20020adf8b14000000b003296b62d413sm8723513wra.82.2023.10.09.03.02.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 03:02:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hao Wu <wuhaotsh@google.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Tyrone Ting <kfting@nuvoton.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/10] tests: Clean up global variables shadowing
Date: Mon,  9 Oct 2023 12:02:41 +0200
Message-ID: <20231009100251.56019-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Clean up global variables shadowing in tests/
in order to be able to use -Wshadow with Clang.

Philippe Mathieu-Daudé (10):
  system/qtest: Clean up global variable shadowing in
    qtest_server_init()
  tests/throttle: Clean up global variable shadowing
  tests/virtio-scsi: Clean up global variable shadowing
  tests/cdrom-test: Clean up global variable shadowing in
    prepare_image()
  tests/hd-geo-test: Clean up global variable shadowing
  tests/rtl8139: Clean up global variable shadowing
  tests/npcm7xx_adc: Clean up global variable shadowing
  tests/aio: Clean up global variable shadowing
  tests/aio-multithread: Clean up global variable shadowing
  tests/coroutine: Clean up global variable shadowing

 softmmu/qtest.c                   | 16 ++++++++--------
 tests/qtest/cdrom-test.c          |  6 +++---
 tests/qtest/hd-geo-test.c         | 12 ++++++++----
 tests/qtest/npcm7xx_adc-test.c    | 14 +++++++-------
 tests/qtest/rtl8139-test.c        | 12 ++++++------
 tests/qtest/virtio-scsi-test.c    |  2 +-
 tests/unit/test-aio-multithread.c | 16 ++++++++--------
 tests/unit/test-aio.c             |  4 ++--
 tests/unit/test-coroutine.c       | 12 ++++++------
 tests/unit/test-throttle.c        |  1 -
 10 files changed, 49 insertions(+), 46 deletions(-)

-- 
2.41.0


