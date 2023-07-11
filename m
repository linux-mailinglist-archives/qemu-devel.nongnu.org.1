Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0242A74F101
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:03:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJDwG-00031g-JU; Tue, 11 Jul 2023 10:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJDwF-00031W-Ft
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:01:59 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJDw5-000816-MX
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:01:54 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fb7dc16ff0so8831674e87.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689084107; x=1691676107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GZpdgYx+lSjr547P7nC0JDvamOwhYrffm2px6HSYgqk=;
 b=rRi2zYQ2ulVMmJfkXuHc3Pj3orTgh2ev18Mzx6sYeW97E34xQrMUYQuXBeC5xtcNuq
 Krm5ogfRHspNvNggglDfuzNxrVjovdMywEPOCdlFu6cSPBRfkNBhx7cK453e9xdX1j6h
 MbKbYRcs0imBXEAqvdMnAEcPiAuyE6xlxyEv2eUruuh2zFsoCs0zsrfrHh7NRZ0/UBsh
 BqdNvyR8h5ZJ4y/Tlasm29C+1aVBZvv9zq9LdkzzhTM2Mw5V5Ek5lWeg03X8RPiFc27L
 2CbVItCzTov1pdxbkJorgS0E7lITbuT9ogYrDgqg2QejeNZbmKZmbuAZHspX2b04ZJSB
 z9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689084107; x=1691676107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GZpdgYx+lSjr547P7nC0JDvamOwhYrffm2px6HSYgqk=;
 b=FnSsXjSI+MJDYT/bjslup8WzsYZkTiZIFWgXCC9H5YQTZlTZvHShwDF6sOW4iTZke5
 qRZtB+zUMBn5e79e7BORvlOLmCQlErn+BeiVLnB/02C1tcbTuJYNTKKz51JXX6uhkWfE
 vjdfvDmcPDpOJRtdP8+943AOBRS+YE79ZC6elrZG7nsXJtNXd+rRRcPsMr/N8k3BYth0
 YYQtUO1Gf3rUFXVM7215Y+N6im1GMcGslt4KuLsp29yeN/bdS+YB8qNMuMmKPv3WY0ub
 32Q5Xdwa3GFNV2kuct1+tu3XrjHerHWDvWNduajtHZC8PVJosrOc0M4wMwIajjs1XJoE
 Q5Yw==
X-Gm-Message-State: ABy/qLbzrUMEQxG7iF8dgbRjS0XruSp822yplsyRUChR3VOK+ugn+EqY
 iM/AhwMx6t+J51AplZKAvfIh48mJl4oI5yJJ934=
X-Google-Smtp-Source: APBJJlEi6hxiuAymuklqBWnlxE2+vPRzuppjanpV7CZ1jxXh8iFK6pQW04+OrI91BolKyJSM3bGLKg==
X-Received: by 2002:a19:6754:0:b0:4f6:1b45:e8aa with SMTP id
 e20-20020a196754000000b004f61b45e8aamr12014833lfj.50.1689084106961; 
 Tue, 11 Jul 2023 07:01:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a50ed8d000000b0051a1ef536c9sm1280122edr.64.2023.07.11.07.01.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 07:01:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Skultety <eskultet@redhat.com>
Subject: [PATCH v2 0/3] tests/vm/freebsd: Get up-to-date package list from
 lcitool
Date: Tue, 11 Jul 2023 16:01:40 +0200
Message-Id: <20230711140143.65818-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

Inspired by this patch from Thomas:
https://lore.kernel.org/qemu-devel/20230531090415.40421-1-thuth@redhat.com/

Instead of updating the package list manually, use lcitool vars file.

Since v1:
- Addressed Erik & Daniel comments (generate in JSON)

Philippe Mathieu-Daudé (3):
  tests/lcitool: Generate distribution packages list in JSON format
  tests/vm: Introduce get_qemu_packages_from_lcitool_json() helper
  tests/vm/freebsd: Get up-to-date package list from lcitool vars file

 tests/lcitool/refresh     | 11 ++++++++++
 tests/vm/Makefile.include |  6 ++++++
 tests/vm/basevm.py        |  9 +++++++++
 tests/vm/freebsd          | 42 ++-------------------------------------
 4 files changed, 28 insertions(+), 40 deletions(-)

-- 
2.38.1


