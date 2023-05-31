Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD6718AD3
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:10:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4S8E-00054D-Kf; Wed, 31 May 2023 16:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4S8B-0004iF-5i
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:09:16 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4S88-0006ju-AE
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:09:14 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30ae141785bso28157f8f.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685563750; x=1688155750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DsUa4RJyc5W4pf+d7JH/fhLj8l7nEkIXRqe2U6cf0mE=;
 b=FN4RK6aQKvLtasD8SoJtpTN8mXcdaYMyFog8XHJNJGMzw6xMCKDpBbWmKeHKEGLdRV
 3lrMHCuu9Htv9d97DTOEW4qBaoCNqdLxP/lovLoWTcjHFjomnZ8rG+S9CgZREmlUGF0v
 QcnWQQorzQm4Nxxa5GY0HU3pFqpEnxWzshoTb2BVGAoeYWTqSWu9/OURar6c7kf/c64W
 PfSpTquloBG0quYGo5UMniZUaPc6b4pjy9z4v6SIyT1HuF/rV8h7sMqSc5QsvOzUW/Y2
 HAIaHibIw+n8LwskmDCdtbfdaiVNOTrl+1WISl3RCG/nQUFvGkAMjA+YCvlRMmrDZE1H
 pC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685563750; x=1688155750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DsUa4RJyc5W4pf+d7JH/fhLj8l7nEkIXRqe2U6cf0mE=;
 b=CdfYLkxEk+Eiw+o4zExob8xOYR9YR41429nbmNPkwvPzlCdNm5R4qjH6crP51VcRiK
 VGNi4IS055IXxhEhUJZnf3daHntzZpASRC5VCxe0BXbQIce/HyyEU0uoWOIOqLyxQzLn
 KBtjFy+bQDtRgcce+4jh6enabN8//SGmH/RzV5m7LT3E+ogJ/7rhiAqLrOGl+aRkfLKy
 bOo0K73tyHxh5EM13H2a7o7THYYHjBMuGEq5zPSCDU+W1xoCbgy0ExHFrOXrKxYdxs8b
 T9RfOGVAxsN2IvbLV1o7lLTv2lo2mA3Pk5miAkcamwtLHwbYbMXI7nkGpdNDA5xQFrjx
 JjNw==
X-Gm-Message-State: AC+VfDy+ImzmkNPScqn7gKALNB0SQJuVaGt6LhMj2jL1DCUsUq5mrRkH
 WC8tN3W70eL9kHK8IyV7MFag+A==
X-Google-Smtp-Source: ACHHUZ5rYSVBo6s2pN2T5y9dqYWuqgH9/qw+4LxEuk4RTOJmxsq2DhHvA/aCL+UanT4FfObR5RjsxQ==
X-Received: by 2002:a05:6000:1107:b0:306:39e5:f338 with SMTP id
 z7-20020a056000110700b0030639e5f338mr98507wrw.62.1685563750195; 
 Wed, 31 May 2023 13:09:10 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 f15-20020adff58f000000b002fae7408544sm7712651wro.108.2023.05.31.13.09.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:09:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>
Subject: [PATCH 0/3] tests/vm/freebsd: Get up-to-date package list from lcitool
Date: Wed, 31 May 2023 22:09:03 +0200
Message-Id: <20230531200906.17790-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Philippe Mathieu-Daudé (3):
  tests/vm: Pass project source path to build_image()
  tests/vm: Introduce get_qemu_packages_from_lcitool_vars() helper
  tests/vm/freebsd: Get up-to-date package list from lcitool vars file

 tests/vm/Makefile.include |  1 +
 tests/vm/basevm.py        | 10 +++++++--
 tests/vm/centos           |  2 +-
 tests/vm/centos.aarch64   |  2 +-
 tests/vm/freebsd          | 46 +++++----------------------------------
 tests/vm/haiku.x86_64     |  2 +-
 tests/vm/netbsd           |  2 +-
 tests/vm/openbsd          |  2 +-
 tests/vm/ubuntuvm.py      |  2 +-
 9 files changed, 20 insertions(+), 49 deletions(-)

-- 
2.38.1


