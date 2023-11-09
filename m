Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2107E6E35
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:06:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17XH-0000Go-6K; Thu, 09 Nov 2023 11:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r17XC-000075-LF
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:05:34 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r17XA-0001tP-Or
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:05:34 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9d10f94f70bso173814666b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 08:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699545931; x=1700150731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pu+pzrUnys2SeNgm7PEF1MRQsZlzhVygnTqwJQJb0I0=;
 b=a23fDr2dcD9Y57utHhSqoaob8nifIXao5VH2nmJ6eLb9V7aWAtG778hMO0Jxi99W6G
 vaeQDglvUwWhVLvcquxMR+sG6Mmrdu/DK2dF8AjckFKMYExu8pof+zxGW8yIPsjCI/qJ
 mK7Yyf9y7+CMFHUlabbq0jnbKJ1bic2cAbwII3DEgv03Z6xik0VNr3qRpoV8RmFM3Lm1
 Ktv4CHdrtoT+CeS1sNL0ETj7LL86eVLb+gimFKvdhpgR/pPJhGESRTwQJwWXOT2oQiGa
 okMGCq2LMhUJPj958f2EtX31zTWp0x6ebrtjnS0KpKk2PnJhUWpJ2T//TrHmnVBB4+A/
 r74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699545931; x=1700150731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pu+pzrUnys2SeNgm7PEF1MRQsZlzhVygnTqwJQJb0I0=;
 b=OJ98vi7Ml1GzOqxRB21V5G9gLAEQazoCs2/WB9IyI283zI921gwR0OwqEblDIhT60U
 wKM21R9auG7iL1PhaMfqkiToTbrpNh3pbF89FqD5cA49zLKCM+KytSj07bai6/v8B4sy
 iRgPUWUIyM3dNoOGLb4HFMkz5Xcucc011r45XPTwhHYDlh+RcaUlUeSa7VbjdI97NZGV
 /GU/RON1jzBmK+HShtB325Zeu6M5PvAdFUXQXSI1C+Zr+N/qDhSg5maWrn3oRlgs5nE6
 Y9g0vKMldfcLLWNX3HYX48TQRUpRqOd80rLuxmI4ZMk1JX2I+bQbvhXwCyURu56eNrtM
 WKzg==
X-Gm-Message-State: AOJu0Yywap3BwNnCB3gsr5OjIn6Z08/WW9U0qvAFAG2T78Pz4xo+jkvA
 HV0DCBIftFP+RTSqSa6xUSFEeiB5nPvEvvQ6d8bMEw==
X-Google-Smtp-Source: AGHT+IHrMP5M6ZdGFhw0fZmjImPG/P6lLD8J4a89PR0hLsYJhRI92ZbTGiXUp53gPh295vtS56Bs6Q==
X-Received: by 2002:a17:906:a084:b0:9e3:ef19:7205 with SMTP id
 q4-20020a170906a08400b009e3ef197205mr3868019ejy.3.1699545931245; 
 Thu, 09 Nov 2023 08:05:31 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a170906591900b0099bcd1fa5b0sm2704670ejq.192.2023.11.09.08.05.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 08:05:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Beraldo Leal <bleal@redhat.com>, Rene Engel <ReneEngel80@emailn.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/2] buildsys: Bump meson version to build on macOS Sonoma
Date: Thu,  9 Nov 2023 17:05:01 +0100
Message-ID: <20231109160504.93677-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

macOS 14 "Sonoma" was released end of September 2023,
developers who upgraded they host can not build QEMU
anymore because meson v0.63.3 is too old.
Bump to a working version. Test our CI covered hosts
also work.

Based-on: <20231108162022.76189-1-philmd@linaro.org>
  "cirrus CI: Upgrade macOS to 13 (Ventura)"
Supersedes: <20231108183251.80572-1-philmd@linaro.org>
  "buildsys: Use host meson on macOS Sonoma (14)"

Philippe Mathieu-Daudé (2):
  buildsys: Bump minimal meson version required to v1.2.3
  .gitlab-ci.d/cirrus: Add manual testing of macOS 14 (Sonoma)

 .gitlab-ci.d/cirrus.yml                     |  16 ++++++++++++++++
 .gitlab-ci.d/cirrus/macos-14.vars           |  16 ++++++++++++++++
 python/wheels/meson-0.63.3-py3-none-any.whl | Bin 926526 -> 0 bytes
 python/wheels/meson-1.2.3-py3-none-any.whl  | Bin 0 -> 964928 bytes
 pythondeps.toml                             |   2 +-
 tests/lcitool/libvirt-ci                    |   2 +-
 tests/lcitool/refresh                       |   1 +
 7 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 .gitlab-ci.d/cirrus/macos-14.vars
 delete mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl

-- 
2.41.0


