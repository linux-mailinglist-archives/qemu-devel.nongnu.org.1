Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D290976BFA7
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:56:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxKG-0003p4-0X; Tue, 01 Aug 2023 17:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxKC-0003nn-Vm
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:54:40 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxK9-0004ky-Na
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:54:39 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31783d02093so5674136f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926865; x=1691531665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wZlbbYabVFvZ7OGREAjxC6Yuo6bw08JRcyjvqTjKMH4=;
 b=ua/NFytMG8rZiLsLFpnrLWQp0cVj5JpQPG8PF16U5VI/XaZpoU8byctnMsMJ8HbKQ/
 M1YpEYSBj5gDcUIfw6NYASMYfQB1UWC7mKuv6XxBQtFmwh+TJbL9Cv0NXBl0lS0AxXX2
 8mDtiefbXtUJycFTVF8b0l3Zn+Dj3AmcRgyvn18rh5Ay3sO3bpYm/NB8+OIVC9HIjDyi
 klluPgZQiiztFJCI6Zflti0Vwti109qNVrG3q95UR7LCQmbQP18yTbcuimHn+BbUzhx7
 IB6gtkaIzVOnWzgkIozfmax/PsR7IiJ4vBLZ+j2OADReCj8Up0D1S+9YKsFD4CN+nwee
 CjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926865; x=1691531665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wZlbbYabVFvZ7OGREAjxC6Yuo6bw08JRcyjvqTjKMH4=;
 b=asru7MqVRinRLqN43D0Q+b0m8r/QhrJw21AKJryde8Qe1i1/4be+mn2eQ5w9DG3dZm
 0AmprK0m0c7s9FKEUn1BlDVVv+FSa7bU4eS07v6vsu8trhIk5tuzpgk/8p4viftaBZIw
 +f6mfSZH3w7nXwwT60SlvsEAsUout6ZL7Tzhv4AQaxNExzu/76UUuo4GjNAq3Kdefw39
 dwW5tmSHZPP04T72QUYyFi8KxB5dpcP2EGqahrdiW4vlEm+/QUigvGkWtujm2YV3XwEC
 svvAx5PUtft3fmEsBMSE76Sqyz8it6wkDMOgPHvnT+aPUphXk3rE80D25LzZQ1A5q2VV
 05kg==
X-Gm-Message-State: ABy/qLbFQ/HsiZmD29R8mIxE8nt97Spf3kM2kSp1b/oaoBfsezcmJQHX
 zceUQGBSZnag2UL2Kj4YjiChmtj4b6PkmTm2564=
X-Google-Smtp-Source: APBJJlFmLKmwE6/StUdQIQiC8D11UUNB1+lB7/i+UixnmwEuUFcri8tx5qRGRND2ZbECNwgAJ0aIhA==
X-Received: by 2002:adf:f40d:0:b0:317:65de:4389 with SMTP id
 g13-20020adff40d000000b0031765de4389mr2886050wro.61.1690926865263; 
 Tue, 01 Aug 2023 14:54:25 -0700 (PDT)
Received: from localhost.localdomain ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d6b85000000b0031455482d1fsm3307792wrx.47.2023.08.01.14.54.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Aug 2023 14:54:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/10] Misc fixes for 2023-08-01
Date: Tue,  1 Aug 2023 23:54:11 +0200
Message-Id: <20230801215421.60133-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The following changes since commit 802341823f1720511dd5cf53ae40285f7978c61b:

  Merge tag 'pull-tcg-20230731' of https://gitlab.com/rth7680/qemu into staging (2023-07-31 14:02:51 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/misc-fixes-20230801

for you to fetch changes up to 8caaae7319a5f7ca449900c0e6bfcaed78fa3ae2:

  target/m68k: Fix semihost lseek offset computation (2023-08-01 23:52:23 +0200)

----------------------------------------------------------------
Misc patches queue

xen: Fix issues reported by fuzzer / Coverity
misc: Fix some typos in documentation and comments
ui/dbus: Build fixes for Clang/win32/!opengl
linux-user: Semihosting fixes on m68k/nios2
tests/migration: Disable stack protector when linking without stdlib

----------------------------------------------------------------

Akihiko Odaki (1):
  tests/migration: Add -fno-stack-protector

David Woodhouse (3):
  hw/xen: fix off-by-one in xen_evtchn_set_gsi()
  i386/xen: consistent locking around Xen singleshot timers
  hw/xen: prevent guest from binding loopback event channel to itself

Keith Packard (2):
  target/nios2: Pass semihosting arg to exit
  target/nios2: Fix semihost lseek offset computation

Marc-Andre Lureau (1):
  ui/dbus: fix win32 compilation when !opengl

Marc-André Lureau (1):
  ui/dbus: fix clang compilation issue

Peter Maydell (1):
  target/m68k: Fix semihost lseek offset computation

Stefan Weil (1):
  misc: Fix some typos in documentation and comments

 docs/about/deprecated.rst      |  2 +-
 docs/devel/qom.rst             |  2 +-
 docs/system/devices/nvme.rst   |  2 +-
 include/exec/memory.h          |  2 +-
 hw/core/loader.c               |  4 ++--
 hw/i386/kvm/xen_evtchn.c       | 15 ++++++++++----
 target/i386/kvm/xen-emu.c      | 37 +++++++++++++++++++++++++---------
 target/m68k/m68k-semi.c        |  2 +-
 target/nios2/nios2-semi.c      |  6 +++---
 ui/dbus-listener.c             |  7 +++++--
 ui/vnc-enc-tight.c             |  2 +-
 tests/migration/s390x/Makefile |  4 ++--
 12 files changed, 56 insertions(+), 29 deletions(-)

-- 
2.38.1


