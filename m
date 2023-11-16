Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A177EE032
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 12:55:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3awx-0006j1-Rz; Thu, 16 Nov 2023 06:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3aww-0006ia-6X; Thu, 16 Nov 2023 06:54:22 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3awu-0007hf-LJ; Thu, 16 Nov 2023 06:54:21 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b6c31e604cso416417b6e.2; 
 Thu, 16 Nov 2023 03:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700135659; x=1700740459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gzk4ZadGqJKUIrJ6o9T7fB4bf6vD/1bzcOXqYlBNRKw=;
 b=B9QJAByrUTiAfSj0rzCpLdib3Wj1oHTcytNn0Lk+qFIdCML28463TsquNqroTne52w
 EwNg06YHjpJdIjpUg03jFbMt3TYgpYqfEr/0w70f0a2sduRLyN53xwiNKxtcNiNVgNuS
 Q7hqNs7HSKanrvIlqKfGvwow3hxlsjIE13b42tg8b5oSDhThjtqWgDxgJ5Q58TH2+mJN
 zxSP8kW6OQEjn5GfuZk0BLMZx8W/52fiZzVyl/UtV077N6qQygB7gpfb6QykqTilJBUa
 h6cgf5WP/8AwkMCg9+MnKbQ4kv+N3yTrevZjlJP+zFeyHOaxenjchTBKtxSelRrEyJIi
 h/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700135659; x=1700740459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gzk4ZadGqJKUIrJ6o9T7fB4bf6vD/1bzcOXqYlBNRKw=;
 b=Ulc5dt291trH2rlBeAYpmfl2uHE8wXXsuHFrrdmDNZNdbgRVHXpkmuM8nNCzVwd/g7
 1IWN/QkKjHi2XiTdHq6A6uERv0oVnXYkTi9mbqFx9Im7FIek8Ihh3mocQbs3hxkP5UL5
 2uGbyCydD8FMzCGdvqAYbPTo9LJ7/aJnDCqlW4KSMFQx9R+B8McIfn91f/HqCBubmelp
 Z8tsKeb6pM8D14mrffTg3rXj3mR9t9VAN2SXGnbaszSuMgb4NCZf8v9rgpEuKFRk1tp7
 Vhgib8oBC69mlOlcRDFz+KKW3GOjjT2v1KccqU/dNKmZF/RH4DNEsFTI/3CUuUnn+yHx
 yDNQ==
X-Gm-Message-State: AOJu0Yw67csnIC/2YNmX31pSGuy76LxhagS+VQDWilRRmy8a32ZenPTm
 bEP6B4E9ss9433PGbHiKYpx1WZtqvzc=
X-Google-Smtp-Source: AGHT+IEA/zCsQdaFOmZ17GgMPqLKuGhZSpXfxbkoirHYmP4iLfvFhubFuN3LYy3Ie+jlp5/uS7PAIw==
X-Received: by 2002:a05:6808:1a0e:b0:3b6:ad44:fd79 with SMTP id
 bk14-20020a0568081a0e00b003b6ad44fd79mr22119362oib.20.1700135658799; 
 Thu, 16 Nov 2023 03:54:18 -0800 (PST)
Received: from wheely.local0.net ([210.84.53.86])
 by smtp.gmail.com with ESMTPSA id
 n19-20020a62e513000000b006c60b150383sm4507960pff.12.2023.11.16.03.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 03:54:18 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Thomas Huth" <thuth@redhat.com>, "John Snow" <jsnow@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/3] tests/avocado: Enable reverse_debugging.py tests in
 gitlab CI
Date: Thu, 16 Nov 2023 21:53:54 +1000
Message-ID: <20231116115354.228678-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116115354.228678-1-npiggin@gmail.com>
References: <20231116115354.228678-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Let's try enable reverse_debugging.py in gitlab CI.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Maybe we could try this again at some point? The bug might have been
noticed sooner.

They only take a couple of seconds to run so should not take too much
overhead. But my gitlab CI pipeline doesn't run the avocado tests for
some reason, so I can't see if it's still causing problems.

Thanks,
Nick
---

 tests/avocado/reverse_debugging.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 128d85bc0e..b1410e7a69 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -205,8 +205,6 @@ def get_pc(self, g):
         return self.get_reg_le(g, self.REG_PC) \
             + self.get_reg_le(g, self.REG_CS) * 0x10
 
-    # unidentified gitlab timeout problem
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
@@ -222,8 +220,6 @@ class ReverseDebugging_AArch64(ReverseDebugging):
 
     REG_PC = 32
 
-    # unidentified gitlab timeout problem
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
@@ -246,8 +242,6 @@ class ReverseDebugging_ppc64(ReverseDebugging):
 
     REG_PC = 0x40
 
-    # unidentified gitlab timeout problem
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_ppc64_pseries(self):
         """
         :avocado: tags=arch:ppc64
@@ -259,7 +253,6 @@ def test_ppc64_pseries(self):
         self.endian_is_le = False
         self.reverse_debugging()
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_ppc64_powernv(self):
         """
         :avocado: tags=arch:ppc64
-- 
2.42.0


