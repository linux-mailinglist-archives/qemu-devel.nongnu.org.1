Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6672874F2B1
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:51:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJEgL-0001FH-Fd; Tue, 11 Jul 2023 10:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEgK-0001F4-57
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:49:36 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEgB-0002lp-KZ
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:49:35 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9891c73e0fbso1161808466b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689086965; x=1691678965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NHLYfddFrDHe9BYhSsUCaksnly4CgTJQNI6D1iAoT2c=;
 b=eqIxfdWCjHHbUfEx+jMGZ2raAgAy9thC04Ybz31kG3LxgOz76D3UqAV9AN0zePJ0aC
 8TzFPuB1uuPOgQXhYiiDGo+XWhN0s2DUSkU7eiL85J90jmGWcIDQxFvGzsVV8y2LrTkx
 8aMAvcQP1yo1W1HWUQRsPFURkJBv4NXVpfGonoDpaLjP9x0kdZ5xNqa1tnCGOqsLIocq
 +Cnz1rdxFGMU6Qc/ofnBTeOYGtKNtABJokd6NPKKrzjSTUodZwGFDN7irMSqbpxhRIBx
 kDYIWJw4PYC9uNEsLCQx9UhX/SJKvDqz8Pw+hAvKaPjAfO31KqH5yNqMFvGiOC7COqZ1
 QoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689086965; x=1691678965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NHLYfddFrDHe9BYhSsUCaksnly4CgTJQNI6D1iAoT2c=;
 b=OuEdVJXuFkzXg8kowgGHqbWT07ngSiEeRRcV1DxGXSHWFy1GHYLRCFB3mPcJglmuT4
 QBUSlQ/Hf6DlW2iFd/d+GF5VAkOQw0PPfcV/Q/Y5AmU/BV0a1wAesOyBRh4pDTzovl7s
 buHCiVg+Kev953covZxrGKphZbBO+FlDsPJiPJvQctJTB1G6CQEY+X/yXVAv02q4nmSJ
 0Xl86BZ+NFtZY+sCP0hlnDLbC1uIcK0gxTsBmkhy4AUojpizrxzz5/NALTWYPxqbTYjB
 ewCPVfCNcJWwNt1+86fMwsSxFz2/QOfbc2tHkh6moyDxM2e5T4ArLrfgb2sEplXq6g/f
 AHWg==
X-Gm-Message-State: ABy/qLYKFYe1SbUMJO7jBRXFS8mYSV9tlh+ur7mPXQT3EyUvrSwnvV3d
 GTrzWv+dNIAMaSOgt9Kk3ow5rr+KSXdabvrYPu8=
X-Google-Smtp-Source: APBJJlEAeBtqdGYX0XAUgAxLf87TYnVQCN15jDNesxov6G25WAyY+BG2+cmVVzoftke3mxc/2IFkag==
X-Received: by 2002:a17:906:7952:b0:98e:4f1:f987 with SMTP id
 l18-20020a170906795200b0098e04f1f987mr23994419ejo.3.1689086965486; 
 Tue, 11 Jul 2023 07:49:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 w25-20020a170906481900b00992ddf46e65sm1260200ejq.46.2023.07.11.07.49.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 07:49:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v3 0/4] tests/vm/freebsd: Get up-to-date package list from
 lcitool
Date: Tue, 11 Jul 2023 16:49:18 +0200
Message-Id: <20230711144922.67491-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since v2:
- Commit generated json (Daniel)

Since v1:
- Addressed Erik & Daniel comments (generate in JSON)

Philippe Mathieu-Daudé (4):
  tests/lcitool: Generate distribution packages list in JSON format
  tests/lcitool: Refresh generated files
  tests/vm: Introduce get_qemu_packages_from_lcitool_json() helper
  tests/vm/freebsd: Get up-to-date package list from lcitool vars file

 tests/docker/dockerfiles/debian-amd64.docker |  2 -
 tests/docker/dockerfiles/ubuntu2004.docker   |  2 -
 tests/docker/dockerfiles/ubuntu2204.docker   |  2 -
 tests/lcitool/refresh                        | 11 +++
 tests/vm/basevm.py                           | 11 +++
 tests/vm/freebsd                             | 42 +----------
 tests/vm/generated/README                    |  5 ++
 tests/vm/generated/freebsd.json              | 77 ++++++++++++++++++++
 8 files changed, 106 insertions(+), 46 deletions(-)
 create mode 100644 tests/vm/generated/README
 create mode 100644 tests/vm/generated/freebsd.json

-- 
2.38.1


