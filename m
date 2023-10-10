Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B5D7BF4C7
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:51:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7VB-0008II-3G; Tue, 10 Oct 2023 03:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7V9-0008Hq-BR
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:49:59 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7V7-0004Zj-OK
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:49:59 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-991c786369cso890067366b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 00:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696924196; x=1697528996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JOtqibj2dbLOoy6fkge4kltiRjME8crv5WjHZGdx+Tg=;
 b=uvDmZTKx9zxF8tXYpaOaw3R+yF4kY4BBlGQkhI+UgZko6Y6sNVa5KreJxOWORoonrW
 rB0K3m9fOwnMsdZI7fBKpyPNrxRG8/k5aEHtmsJ0Hsxo0WAXit6hd81/oM22Kx1xBA4r
 n4N5uQSmaFFC6XsibscM0Mv8+rIYwofcATMdwisn6UWGPpcao5OLT/HrKtqUrrCR+iMo
 BGUliQuqRyJOKRJdCGAeXUTeWj0GawimIon7x8myNY3ZxxxVg3BQ4lz48qegOJSVBSpU
 DLUc9O0m7lhDzM5A8MK07vH3KoNDthmiV7gV+X7XwOg0B3QTIZNCqJf9YKkEtEE72IaA
 /TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924196; x=1697528996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JOtqibj2dbLOoy6fkge4kltiRjME8crv5WjHZGdx+Tg=;
 b=IgrkA9Cr66rdSli7hlKwEugluziV/aqACnqI5MIq7sdzXPqQnSG9k+Ua4VOXTcqlAD
 ydtL7caNXPYVSqFKRAO79oLC4E43FhmxohYAeEp5oCqzq+4bEqOHuu1h2YDUf2+PNB/I
 FIDhEgyd832R6JlvZXz3TabMpcx9c7urxC74WLuNnDBDwn9cdYnPIahr/l6tQ4BQusWG
 XLSGN6mZQ/lCMpJFluSefl3QaFrh8R7QfxdaVeDMarv2cB3kIjaf0OzoshRmqNTeb5zJ
 eoj0RmnKBcN3k8CjOI9/+C5zeCIsViTTVgXxvEc4lg7tFas9MMg33iVgZCKq/w41kvNM
 /dnA==
X-Gm-Message-State: AOJu0YyvP+VKib1Kuw0tmgOkqlU6sAgrqiocoJ/VNtX/ZA+4Wo5DutMm
 hA+LdeLSACyscmMWvnfguBCIZ0W//JpISVsyM3IYWQ==
X-Google-Smtp-Source: AGHT+IGn5xd4xjifpMZWqv3hO+nMNbC6Ki6OXNgt2RSlF4Hs8lSBQ1LGvZ8ECrTZ0+6dtpz/ZesOUQ==
X-Received: by 2002:a17:906:25d:b0:9ba:1d1a:1e2c with SMTP id
 29-20020a170906025d00b009ba1d1a1e2cmr5029409ejl.34.1696924196033; 
 Tue, 10 Oct 2023 00:49:56 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 r11-20020a170906364b00b009a1a5a7ebacsm7887987ejb.201.2023.10.10.00.49.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 00:49:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] tests/qtest: Introduce qtest_get_base_arch() and
 qtest_get_arch_bits()
Date: Tue, 10 Oct 2023 09:49:48 +0200
Message-ID: <20231010074952.79165-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

When unifying some 32/64 architectures as a single binary
(for example i386 & x86_64 -> x86), some qtests fail because
we lose some information (the arch bits).

This series introduce the tuple qtest_get_base_arch() /
qtest_get_arch_bits() to allow the tests to keep passing.

Eventually we should remove qtest_get_arch() entirely
and rename qtest_get_base_arch() -> qtest_get_arch().

So far these changes are sufficient to keep me progressing,
so posting up to this point.

Philippe Mathieu-Daudé (4):
  tests/libqtest: Introduce qtest_get_arch_bits()
  tests/qtest: Use qtest_get_arch_bits()
  tests/libqtest: Introduce qtest_get_base_arch()
  tests/qtest: Use qtest_get_base_arch()

 tests/qtest/libqtest.h            | 15 ++++++++++
 tests/qtest/ahci-test.c           |  5 ++--
 tests/qtest/am53c974-test.c       |  4 +--
 tests/qtest/arm-cpu-features.c    | 49 +++++++++++++++----------------
 tests/qtest/bios-tables-test.c    | 22 +++++++-------
 tests/qtest/boot-sector.c         |  6 ++--
 tests/qtest/device-plug-test.c    |  6 ++--
 tests/qtest/drive_del-test.c      | 16 ++++------
 tests/qtest/erst-test.c           |  4 +--
 tests/qtest/fuzz-e1000e-test.c    |  4 +--
 tests/qtest/ivshmem-test.c        |  6 ++--
 tests/qtest/libqos/qos_external.c |  6 ++--
 tests/qtest/libqtest.c            | 49 +++++++++++++++++++++++++++++++
 tests/qtest/lpc-ich9-test.c       |  4 +--
 tests/qtest/m48t59-test.c         |  6 ++--
 tests/qtest/pxe-test.c            |  6 ++--
 tests/qtest/qos-test.c            |  6 ++--
 tests/qtest/readconfig-test.c     |  6 +---
 tests/qtest/rtas-test.c           |  4 +--
 tests/qtest/ufs-test.c            |  4 +--
 tests/qtest/usb-hcd-uhci-test.c   |  6 ++--
 tests/qtest/virtio-net-test.c     |  3 +-
 tests/qtest/virtio-rng-test.c     |  4 +--
 23 files changed, 138 insertions(+), 103 deletions(-)

-- 
2.41.0


