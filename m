Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A39573CB58
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 16:22:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD49g-0001xj-C3; Sat, 24 Jun 2023 10:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD49e-0001xA-2a
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 10:22:22 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD49c-0007B3-FG
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 10:22:21 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f87592ecaeso2251908e87.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 07:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687616537; x=1690208537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FMgEqFq2SmlukiduWNZPujfBbClcoqavfV0LzF/6hOY=;
 b=imQs+e6Uhr5f9cY5pRf8SFIXEpffPd8yIW9Y7nj6En6r5NasrOY0vZYxVepREilDqm
 mpKfPlhInK00K64No9w3wysvE/x4rnTNCm2/ERZ5+xqGaDJuOPeZF3NrD0szNcGifXNK
 28ZarldCEv7ID0ybhk8cBL+pLIPPn6SrDKDiqLMk8C/BoLsTf/M/vKPhLSpkBCLz9MRd
 5l0YWv9/g1YcVoCot2WHd164HnGgub53627p08YdWJF6krGMfqNMGYS9Sa2OciGYHT8G
 01Yva4f7ymltmQmzZV2wqiE2WhlaTalsMW7TT7r1lFELIPLDV/CCT7nhn3ouPssdn0/N
 lMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687616537; x=1690208537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FMgEqFq2SmlukiduWNZPujfBbClcoqavfV0LzF/6hOY=;
 b=Q+sIoYKPOJWcXsa3oRArz9/ymlC2YB2a1jSkR3SYRhnuLu4R9R5FMKOE3UeIdp3Sed
 EJuBcZaknK26DW3DOZ2c7wcYZyO26FGN5d2OdNINRXIv1n4FF/uCehnVBh60smlSgQ9D
 lwlkJEK6anXrnzdDEI+rQxhRSU8Zvilpmug3awCJvDr3hp4mb1f5rQd3ebsNbqFGFrkP
 aPePjj47sCo1PqoKRC27mY1UY/hpFQdScwV0aTC3r7iJwHnTw5PNdiWjJL8A+73BJKig
 NDk8pm+yNtVeCH9mBA7vZHfMORK+7bJtPo3xFj3mEuDh29wgIKZzU5m7zJ1aQLBnGYSE
 JJ3A==
X-Gm-Message-State: AC+VfDwjx6ZQl3h4/FkqTgFeBwgOeXKDH3x/g0GXOkCpYR7ulM/JrnZu
 GLyAiJuX7OAXobBnmMy4d/W5boGRXlTvzRpTugqUJw==
X-Google-Smtp-Source: ACHHUZ7w7oUmYP2pluvLJ8z57BHKXo2Vnnox/KstVtmpFHzIgP5xzuyjB3r4VhNujCIUDq6aiWMuiQ==
X-Received: by 2002:a05:6512:447:b0:4f8:5fce:3683 with SMTP id
 y7-20020a056512044700b004f85fce3683mr12735569lfk.20.1687616537448; 
 Sat, 24 Jun 2023 07:22:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 o23-20020a05600c379700b003f8f884ebe5sm2370287wmr.2.2023.06.24.07.22.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Jun 2023 07:22:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 0/2] accel: Re-enable WHPX cross-build on case sensitive
 filesystems
Date: Sat, 24 Jun 2023 16:22:09 +0200
Message-Id: <20230624142211.8888-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

Re-enable cross-building of WHPX (via Docker images;
also on CI).

Only cross-built.

Philippe Mathieu-Daudé (2):
  docs/devel/testing: Update the 'Docker Debugging' section
  accel: Re-enable WHPX cross-build on case sensitive filesystems

 docs/devel/testing.rst           | 2 +-
 meson.build                      | 4 ++--
 target/i386/whpx/whpx-internal.h | 4 ++--
 target/i386/whpx/whpx-all.c      | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.38.1


