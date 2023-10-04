Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B287B7E99
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:03:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0YH-0008MH-FH; Wed, 04 Oct 2023 08:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0YF-0008L2-R3
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:00:27 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0YD-0000hb-S2
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:00:27 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32329d935d4so1960438f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420824; x=1697025624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rvRCSn7mALp4422t4fF6+uBAlhgtzLHaRmkeIudcQEM=;
 b=J3My8iz9bbxi6SAcPaVJSWzFp0qsTRPhQJ2fttNTvH90RFdC4H8HF8O7iMWev61vep
 4EC9TE+qOUXjMzXTlXJXJ9X7HorgbOkaDbFP/InoMbn0a0eRsJVC4cSUiD+Vqyg4hYL7
 xmbcNaAmkA8VTnQwGZyipMFEdVJZdWCKTBajqk/u6Zrg3/gJtsT5R6XFw/LdEJsm82/5
 eUKaCbMKvhrPouRKMu6xzSCWN/fhuPGDfCnf8Sc2WeJefCm6kM68yJRjW4Cd96+C7s6k
 65KP8j7ZO0sua2DAVOz38j1FgLSv5U5qyUtQeO2jbwml5mz4B1Geb4qGjheDb4eL3jdB
 jckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420824; x=1697025624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rvRCSn7mALp4422t4fF6+uBAlhgtzLHaRmkeIudcQEM=;
 b=f0sJIFvGMjFRqeK2KgS+qUZtix02Rx2iGCOLvtjVVulpHzshdiw9k2U1MPHcW9QDJn
 FhsnPX++mt3btEiPIIV1dTJocRDUy+Pt9Je3Ifb6XSXc+Bc/ba136nZpTeHnBFuaNPWe
 dTqdY19y5sxFvzq5wlg8lBNVrwqUBJwoxEIK77SfF52Ias864kXk9vH/QnsoJYZe0WJ9
 8prne0UgZMkHkyzcOQT971i7gl2GE3zY1x4BX2xx0oWObd6jm+RuVxpXj5icPKfFmXhv
 o6k+qcFaYCEnGPYY4NzlJuXsb1ll3YKNeEGk3t4jNALhqguSBLtBS/OT7J8rmHhXGRBD
 3gYw==
X-Gm-Message-State: AOJu0YzfiAnT/RCySEz6hcWhpR40JobD9EUbfCoM45tW/cuD8ZBoZ/7w
 T10iG2mHF1FPt14bXciCIQCHMnXYcv7rCRanqeM=
X-Google-Smtp-Source: AGHT+IF9miJaHh8xGwJbXs6GFrm8wak1lqCWFfggG63YAyQRHGbx8eEH9aZkHTg7nnnqS7wJDmyliA==
X-Received: by 2002:adf:d4d2:0:b0:324:87d3:873b with SMTP id
 w18-20020adfd4d2000000b0032487d3873bmr1874260wrk.61.1696420822581; 
 Wed, 04 Oct 2023 05:00:22 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 e3-20020a056000194300b0031779a6b451sm3848532wry.83.2023.10.04.05.00.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:00:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/16] (few more) Steps towards enabling -Wshadow
Date: Wed,  4 Oct 2023 14:00:03 +0200
Message-ID: <20231004120019.93101-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
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

Since v2:
- Rebased (many patches merged by Markus)
- Updated arm/ide patches (Markus, Peter)
- More patches for optarg (3)

Since v1:
- Addressed review comments
- Added R-b tags
- More patches

For rational see Markus cover on
https://lore.kernel.org/qemu-devel/20230831132546.3525721-1-armbru@redhat.com/

Philippe Mathieu-Daudé (16):
  hw/audio/soundhw: Clean up global variable shadowing
  hw/ide/ahci: Clean up local variable shadowing
  net/net: Clean up global variable shadowing
  os-posix: Clean up global variable shadowing
  plugins/loader: Clean up global variable shadowing
  qemu-img: Clean up global variable shadowing
  qemu-io: Clean up global variable shadowing
  qom/object_interfaces: Clean up global variable shadowing
  semihosting: Clean up global variable shadowing
  ui/cocoa: Clean up global variable shadowing
  util/cutils: Clean up global variable shadowing in
    get_relocated_path()
  util/guest-random: Clean up global variable shadowing
  semihosting/arm-compat: Clean up local variable shadowing
  softmmu/vl: Clean up global variable shadowing
  sysemu/tpm: Clean up global variable shadowing
  trace/control: Clean up global variable shadowing

 include/hw/audio/soundhw.h      |  2 +-
 include/net/net.h               |  6 +++---
 include/qemu/guest-random.h     |  8 ++++----
 include/qemu/plugin.h           |  4 ++--
 include/qom/object_interfaces.h | 16 ++++++++--------
 include/semihosting/semihost.h  |  2 +-
 include/sysemu/os-posix.h       |  4 ++--
 include/sysemu/tpm.h            |  2 +-
 trace/control.h                 |  4 ++--
 hw/audio/soundhw.c              |  6 +++---
 hw/ide/ahci.c                   |  4 +---
 net/net.c                       | 14 +++++++-------
 os-posix.c                      | 12 ++++++------
 plugins/loader.c                |  4 ++--
 qemu-img.c                      | 22 +++++++++++-----------
 qemu-io.c                       |  4 ++--
 qom/object_interfaces.c         | 16 ++++++++--------
 semihosting/arm-compat-semi.c   |  5 ++++-
 semihosting/config.c            |  8 ++++----
 softmmu/tpm.c                   |  6 +++---
 softmmu/vl.c                    | 26 +++++++++++++-------------
 stubs/semihost.c                |  2 +-
 trace/control.c                 |  4 ++--
 util/cutils.c                   |  1 -
 util/guest-random.c             |  6 +++---
 ui/cocoa.m                      |  4 ++--
 26 files changed, 96 insertions(+), 96 deletions(-)

-- 
2.41.0


