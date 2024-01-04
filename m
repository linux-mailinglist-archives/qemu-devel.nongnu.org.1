Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A078245CC
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:08:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQGW-0005Jy-0d; Thu, 04 Jan 2024 11:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQGU-0005Jh-0T
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:14 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQGS-0007ql-ET
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:13 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-553ba2f0c8fso754852a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384489; x=1704989289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vZX4vLdYoxQhq3xs2F7H35mPl0qdWd5hwfMHMHmdr8Q=;
 b=hUkZELDprsNpoLO8Z/zFGddmjtjH+Rnv5VDBqCCzUkBlXWBoUmBgdH6ohsnxYEztVp
 1SoMJ67h+TjanWLDlabut7DF7ScqOcViyF0DicC3ARsnsaOiLWITKTvFvGlbobPC6TJz
 vGXyyKODVgFx8jEOOYMgFehSDdqeD0KXl0+OKavkxi8Bh34mS5mH4FVvFiaqzsX7/Jvt
 eYnXqxMPEBrLIJG8mli4Rx+3wJ3VZoZTqw2XKXhoo2B+UmzjLG0rymd0NeQJWcYSB+AP
 tFf9N9EblYJvRmSjL75IWyL4Ziw7sEKxRr+GL1K3nZolyUlKa7v1wKnqiYyHJHoAzFCI
 ocPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384489; x=1704989289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vZX4vLdYoxQhq3xs2F7H35mPl0qdWd5hwfMHMHmdr8Q=;
 b=lF1lmzZvwVgv7yOF2Q2CXUgShFiKwKMFXhbV/Hk7CwhBDuDBdC7DvTOZ7Jm+pmmjY2
 N681EZUcvV0TqpkxE6xu+gL2k5HsHFK1mYGsLsHcLBEunaCcsAHrLRdZ8SesyWdtUYcJ
 r2gR3YMUsqAtFJccUusu25d2OqXDabLNXf4HBae0F44PAM5uTapGppELQm4fs3oX7/DF
 bppBqqJ+1f5K0u5shzOdOWnUvAiwbFyAfhPGSUFUkEwjLUdPsRot8GHZiwTB3WVWsYp2
 jY6gg1FIlE/nLm/yjnGnWSNw+cxJP8ak1hWnJdlX8wz0o+z14kC+CAqz5N8WmM1+qStV
 AEnQ==
X-Gm-Message-State: AOJu0YzqO5wr3C6HIFZVmpa88oeJl2tl7UMmQz4pFSou0UH9QOBYFlEC
 xh7nPhrDMrtjdUlHPD4OSE5LU6s99pBKuYjsZ/HNsJlCiX9QcQ==
X-Google-Smtp-Source: AGHT+IGY9G08d9KRH30QpoLvtEZ71frN5La3A+w72ZE+QjIgywC8dnpOmnEM7KYafxmsnmRCmLvvvw==
X-Received: by 2002:a50:d54a:0:b0:556:7e24:6343 with SMTP id
 f10-20020a50d54a000000b005567e246343mr228139edj.98.1704384489170; 
 Thu, 04 Jan 2024 08:08:09 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a0564021f0a00b00552d45bd8e7sm19054093edb.77.2024.01.04.08.08.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Jan 2024 08:08:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Xianglai Li <lixianglai@loongson.cn>, Zhiguo Wu <wuzhiguo@loongson.cn>,
 Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH 0/9] scripts/ci: Consolidate Ansible playbook rules
Date: Thu,  4 Jan 2024 17:07:56 +0100
Message-ID: <20240104160805.56856-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Hi,

The CI Ansible playbook scripts failed when trying to provision
a openEuler instance. I was going to do a manual installation,
but Alex strongly suggested to keep using Ansible, implicitly
asking to fix the scripts :) This is what this series does.

Note, when libvirt-ci is upgraded, we neglect to update the
playbook packages list. Not sure how to automate that, so I
updated manually.

Philippe Mathieu-Daudé (9):
  scripts/ci: Do not enforce gitlab-runner path
  scripts/ci: Do not restrict spice package to x86/arm hosts
  scripts/ci: Split EL8 specific packages out of Centos8 list
  scripts/ci: Update Centos8 package list
  scripts/ci: Restrict libpmem-devel package to x86 hosts
  scripts/ci: Install libxdp-devel on x86 hosts
  scripts/ci: Install RH packages on RH derivative distros
  scripts/ci: Update Ubuntu packages list
  scripts/ci: Restrict libpmem-dev and libxen-dev packages to x86 hosts

 scripts/ci/setup/build-environment.yml | 123 +++++++++++++++++++++----
 scripts/ci/setup/gitlab-runner.yml     |   6 +-
 2 files changed, 107 insertions(+), 22 deletions(-)

-- 
2.41.0


