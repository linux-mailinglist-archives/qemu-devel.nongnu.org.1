Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E98D77085E7
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 18:21:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzgMv-0007aj-Ha; Thu, 18 May 2023 12:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMp-0007YU-H5
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:39 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMm-0006O7-Kj
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:39 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3093eb8cd1fso1455911f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684426835; x=1687018835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0LIi5Oy0YvRsl6dl4+nVav7RiXqFXAxGtSAON8ILwKQ=;
 b=OCR/bfqARSmNNeq4QFxh9LBadstcBU1owEEmDLxQSQVBuEoQSQ2EgX7fjhr+iVa0kt
 QjLxw1ccA70XmWJM8/VYDg+ry96RmDNDrSKFmAdIx7yEAFIC0JWXxSb9JQPJP+An4Xxn
 w1ty1Nu1R5hFdaw3U3pR4UGGOjYSfEM0lBgYLbASWaGwKMPRcZwoYomHW+Iw/W8oiXAK
 Ki01ohXGdCZ2y8MY/SufUjHSts/l9rh1v2zM9Gh5hZlup7TUNXn7LfB4QoLVeQQYEN9i
 Vfd+XVEG+tnZvLwDWovOShna+mzRcOc1XYUupYD2hOMe3+opzm/tC8LZdfgNcZRiMdit
 PWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684426835; x=1687018835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0LIi5Oy0YvRsl6dl4+nVav7RiXqFXAxGtSAON8ILwKQ=;
 b=XtN7YDrS7+TzYb0Ooz5eeisxJtJUUPJazfJgY2XNJ7PWVyf5+xQOAPVN7UYYMU5EPw
 icUJ1vZeWPXRqVrErCQ2dgLc6GIC7NSwgNEHHBzSmgeSrUC6qP6O6zpV3eWACRjuAoy5
 pU69jZaCIxGx6Nbeeb8oF2tPE+n3QzVQiI80Me7/WG5LcqdprNE2UF6cyI4u4JuqmsD2
 LstqffkDObyIcRtbJuTtXtU9dGx1HzRx/kXqOkLmnVObL4aZR4JivcBWVxKxjWSbywlM
 UvQ77UtxLxq9x2D1x5IT0jdYU+PGwcTAXANTyd7v7ZhPyoN5T7niIhIP5kmCQVR9yGNY
 eMDA==
X-Gm-Message-State: AC+VfDwyVd9inHVYxCgOXmy/qdYqItfI3zXF7aasPhJFIC0xG9vBlrIV
 oC+Ox8p2/+2ZTqVhzLCDVg6lxQ==
X-Google-Smtp-Source: ACHHUZ7R4FMOXXZQVfRNVIZBIpGvmwgCEP0Vs4j3SFBd8PzsRMBolXZwivVwZnfOgXMPGH8bU/OB2g==
X-Received: by 2002:a05:6000:1087:b0:309:38af:91c6 with SMTP id
 y7-20020a056000108700b0030938af91c6mr1466878wrw.68.1684426834965; 
 Thu, 18 May 2023 09:20:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a7bcb0e000000b003f42a75ac2asm2526636wmj.23.2023.05.18.09.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 09:20:34 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 368311FFBB;
 Thu, 18 May 2023 17:20:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 0/8] testing/next: avocado logging, docs, gitlab
Date: Thu, 18 May 2023 17:20:26 +0100
Message-Id: <20230518162034.1277885-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Mostly this contains some fixes for the logging that went missing
since we bumped avocado up to 101. As well as tweaking the log
behaviour we also have a few gitlab tweaks from Daniel and some
updates to the documentation.

I've included Richards plugin fix so we don't break bisection although
it will likely go straight into the main tree by the time this becomes
a pull request.

Alex Bennée (4):
  tests/tcg: add mechanism to handle plugin arguments
  tests/avocado: move guest output to "avocado" namespace
  python/qemu: allow avocado to set logging name space
  docs: add some documentation on avocado logging

Ani Sinha (1):
  docs/devel: remind developers to run CI container pipeline when
    updating images

Daniel P. Berrangé (2):
  gitlab: explicit set artifacts publishing criteria
  gitlab: ensure coverage job also publishes meson log

Richard Henderson (1):
  accel/tcg: Fix append_mem_cb

 docs/devel/testing.rst                 | 31 +++++++++++++++++++
 accel/tcg/plugin-gen.c                 | 42 --------------------------
 .gitlab-ci.d/buildtest-template.yml    |  4 ++-
 .gitlab-ci.d/buildtest.yml             |  5 +++
 .gitlab-ci.d/crossbuild-template.yml   |  1 +
 .gitlab-ci.d/crossbuilds.yml           |  2 ++
 .gitlab-ci.d/custom-runners.yml        |  1 +
 .gitlab-ci.d/opensbi.yml               |  1 +
 python/qemu/machine/machine.py         | 42 ++++++++++++++------------
 tests/avocado/avocado_qemu/__init__.py |  7 +++--
 tests/tcg/Makefile.target              |  8 +++--
 11 files changed, 76 insertions(+), 68 deletions(-)

-- 
2.39.2


