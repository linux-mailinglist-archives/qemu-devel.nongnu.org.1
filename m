Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D5F73EBCF
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 22:26:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDsmE-0005eD-F1; Mon, 26 Jun 2023 16:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDsm2-0005ad-Nz
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 16:25:22 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDsly-00054v-Kh
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 16:25:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f9b0f139feso52409705e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687811117; x=1690403117;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kufkpJWCHS04RR7Yrd43QCoxh136iqjolM/phbA6kXE=;
 b=v7M8dMsRRVKgEjWC8W82Bhlz7CVa4cJWktVnRqo0NxCjKTo9yOhjvSJbfVYHNrRX0w
 JH9si5A4XIIhDdDK8FVxI19iHG6xOBhfuaNEuAx9ISB967xpowAaNNwMt2D56/A7RbNl
 cBPCGI9z1bn2pkRp7pBaGA6bqV9a07XSzODksgkoKVjRcsVfJrd2i0DtFU6Wfm6vkG6f
 jHm0u2rsYsOlUoFUxX6Z9SghAA/6dbyg2lNrPMvYBDGUZ2GUvJWfyRLUjHtkMUJ0yeDs
 RWOJiVKZz/R/VOwouDfAMx6MabWbIEbwFoqGcTSGgRcdb0OfdLC3kmz4ODeXy/h/g7Ev
 F/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687811117; x=1690403117;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kufkpJWCHS04RR7Yrd43QCoxh136iqjolM/phbA6kXE=;
 b=gVScsbo2UEGzHd2r4JOkjRL+54SbR822PV6attSnJ+02OelwsqNZHqB+7Kw0oc8oJU
 Ixs4/qNRm7mlSw2LKKrqPp7t5azClZTLr5hwXzYm/oaTDS6FlDHmtRAPJyCHNa3MDihj
 I19S/LWsXgvd2EgRSyASZRiuG/W3aW2MvAJ3pe2AqGE9UlO4vpaqifIuiMQiFqpaxvyp
 nq9o0cm1PXclDBBAgo2qKZt2kI+/65uhoWIrLqQY/grJVH+2nWa9A/KKxweXvwzR78Pk
 LC1ejnVZFd58AdjffCDjb16uA0Gxcq6UGoUtaL+orl4OpAH7Fjc0ib+0ldD/wbs6WSbp
 wonQ==
X-Gm-Message-State: AC+VfDxaDGwgUnBG4id4Ywjlh4bmAE6runyMTiwlBpwzfWsiZK3GZUyQ
 WEgzoY94XA6RiHIpw6hGYgAQGg==
X-Google-Smtp-Source: ACHHUZ45k9Y0UuzlsK+70a17pa7g8CJFwx6KFQFiWILsEVbpRMH/jA1c/t7pu4RSWm8iptu8LA3ZEw==
X-Received: by 2002:adf:e791:0:b0:313:f124:aa53 with SMTP id
 n17-20020adfe791000000b00313f124aa53mr3200306wrm.45.1687811116929; 
 Mon, 26 Jun 2023 13:25:16 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d17-20020adffbd1000000b002fb60c7995esm8347280wrs.8.2023.06.26.13.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 13:25:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1C0751FFBB;
 Mon, 26 Jun 2023 21:25:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Qiuhao Li <Qiuhao.Li@outlook.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Cleber Rosa <crosa@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 0/6] maintainer omnibus: testing, fuzz, plugins,
 documentation
Date: Mon, 26 Jun 2023 21:25:09 +0100
Message-Id: <20230626202516.2507915-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

As softfreeze is fast approaching I thought it would be work combining
my various trees into an omnibus series to ease the review and
merging.

The testing updates exposed a number of latent leaks that confused the
oss-fuzz jobs (hence the test-fuzz addition to help debug that). This
also includes some minor plugin updates and finally some documentation
updates that clean-up and expose the QOM and QDEV APIs which are so
core to emulating anything in QEMU.

v2
  - applied a bunch of review tags
  - added missing doc suggestions from Paolo
  - tweaked the plugin fix for CI

The following patches need review:

 - qemu-keymap: properly check return from xkb_keymap_mod_get_index

Alex Bennée (3):
  gitlab: reduce testing scope of check-gcov
  tests/tcg: add mechanism to handle plugin arguments
  qemu-keymap: properly check return from xkb_keymap_mod_get_index

Ani Sinha (1):
  docs/devel: remind developers to run CI container pipeline when
    updating images

Daniel P. Berrangé (2):
  gitlab: explicit set artifacts publishing criteria
  gitlab: ensure coverage job also publishes meson log

 docs/devel/testing.rst               |  6 ++++++
 qemu-keymap.c                        | 24 ++++++++++++++++--------
 .gitlab-ci.d/buildtest-template.yml  |  4 +++-
 .gitlab-ci.d/buildtest.yml           |  7 ++++++-
 .gitlab-ci.d/crossbuild-template.yml |  1 +
 .gitlab-ci.d/crossbuilds.yml         |  2 ++
 .gitlab-ci.d/opensbi.yml             |  1 +
 tests/tcg/Makefile.target            |  8 ++++++--
 8 files changed, 41 insertions(+), 12 deletions(-)

-- 
2.39.2


