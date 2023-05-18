Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A917085F0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 18:22:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzgMy-0007bh-TW; Thu, 18 May 2023 12:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMq-0007Ys-P1
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMo-0006Oj-Qe
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:40 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f49bf0223cso21787265e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684426837; x=1687018837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvrSe/0m52GzDnMMDzRQNC/FD8LWFpadN65cq2Wt+xM=;
 b=XYHaabGYmEmFFCX/TZMC/qaCzxN0WXe0y5/GLkSDjp+S/J2qo6RHchB8MQtf1WOwSZ
 1sDx/fWRTCmwAMVA683FXLqBIxlSEw1pU8/z/NrC/NGguiPskVbhgHlWQbV38w3xbLyO
 3nA2NKXu1vMqh+ri6f1NKYwCDqzp+7cvSbIuet5sPDRQz6JIp+CYhVcgXMGBo46657W+
 cJ8GU5evua0LYcKLjU6Cw4VRUP8hWf7+Ovy96/3fXLtXYZSDUYjj9vDdwCDe4K/Pr2KA
 KOV5XbRLSIxZ3e9GHJhKBPStEaVXzpCEFmiSCX4GiUhZeP8erle/bTk9XJURL/7bplyK
 gxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684426837; x=1687018837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvrSe/0m52GzDnMMDzRQNC/FD8LWFpadN65cq2Wt+xM=;
 b=PRMuBoXkC6iW1B8pME5GNpVcO3nFO7RksETbgvlyxU3A/5PeEsE6m5mtev0h3gm9rH
 sg6fVsCE4EXiD/2j6rHnvDTDqzAkKX1pwokwKhAuG2GuEXtva5PCdm9jNcR0YTYcalJC
 IXs4C9IJ7GlEH3Oc/UFWFTXnLqhPuc4JZO9vFXkMDG7IR5DHkOg1M1zNFoLc0Ygv88hM
 fzLqVluqddvX0KSiCgkaAAFRM6ew8ZKLLofteg2Ns3ahr8Q1z9ylpYbvHfxPk86Hhj5G
 3X97eerzkgiDh+IYJbtUPQoGMaWcpBh7ryi4Gbz05pH729R6yQV4ve2vc8aoCvCo73Nm
 Xe6w==
X-Gm-Message-State: AC+VfDw1AskG/ha+w78ioLGMCKjPyd3doy4qPb4bM1UvuUiBlqQ3IjQo
 v5ac1xyhI1I7AGyNrK8l7HRIQA==
X-Google-Smtp-Source: ACHHUZ6J41kHPPTne+ps/6asonsn+xzIbd+JvD9UFL8yFVMlgVwovSiNInmNIxH8YZOF0YvSDlYAAw==
X-Received: by 2002:a7b:c3cd:0:b0:3f4:271a:8aaf with SMTP id
 t13-20020a7bc3cd000000b003f4271a8aafmr1913348wmj.38.1684426837535; 
 Thu, 18 May 2023 09:20:37 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a7bc404000000b003f4e3ed98ffsm2469035wmi.35.2023.05.18.09.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 09:20:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D45471FFC1;
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
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 6/8] tests/avocado: move guest output to "avocado" namespace
Date: Thu, 18 May 2023 17:20:32 +0100
Message-Id: <20230518162034.1277885-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518162034.1277885-1-alex.bennee@linaro.org>
References: <20230518162034.1277885-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

It has been noted that console logs have disappeared since the update
to the latest avocado. This seems to fix it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/avocado_qemu/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index 33090903f1..b19f797b7b 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -138,7 +138,7 @@ def _console_interaction(test, success_message, failure_message,
     if vm is None:
         vm = test.vm
     console = vm.console_socket.makefile(mode='rb', encoding='utf-8')
-    console_logger = logging.getLogger('console')
+    console_logger = logging.getLogger('avocado.guest.console')
     while True:
         if send_string:
             vm.console_socket.sendall(send_string.encode())
@@ -407,7 +407,7 @@ class LinuxSSHMixIn:
     """Contains utility methods for interacting with a guest via SSH."""
 
     def ssh_connect(self, username, credential, credential_is_key=True):
-        self.ssh_logger = logging.getLogger('ssh')
+        self.ssh_logger = logging.getLogger('avocado.guest.ssh')
         res = self.vm.command('human-monitor-command',
                               command_line='info usernet')
         port = get_info_usernet_hostfwd_port(res)
-- 
2.39.2


