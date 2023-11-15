Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E8D7ED463
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 21:57:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3MvY-0004qy-G3; Wed, 15 Nov 2023 15:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvT-0004mH-M7
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:57 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvO-00089n-FG
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:53 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32dc9ff4a8fso71916f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 12:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700081747; x=1700686547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Am29rNstmoBjPWHdKzUHbk8KZyMNjdmqHD061pd8s4=;
 b=MNh1TzrdudRIV24c4MHDEciQmvcGLfxfkDi52eH9a+0dcmNsIXNSYb78ss7Er4owN/
 gRlidaANjkH6X4nbGLC7gCJwOD/5HolLMxkA1gVQB6wWwW9o79eB6tfoGGAwtB/xMBk4
 al5JMFla/11tbDMfhdTMbW2Io0mO6xlOCQRGEfbd28JBWUpopkOiPYR2REyWMztiQWg/
 Yum7PC+ESwkYGB2CC+78fuYd9pyoOf1YLrXtZorNbJOfXS+DmPvjja5KzucOc7Qr+aQZ
 4INIaBrZks96i52SdcQHdrBuOE3qqm1Jm++SZvZJkpKAPXV/Rkpwh1AWmpf+kI5BqLi8
 wWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700081747; x=1700686547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Am29rNstmoBjPWHdKzUHbk8KZyMNjdmqHD061pd8s4=;
 b=sd2Jp4Svd7sHhOpUP+LBOYnH1bROCOPmQK+HYjoOUVGqPtGX2GB9EJmmjrQMXfJaSX
 2hF0+jjoBZUSjgS9wgNLWtWIjkDWPa878gIP+998buRNxxzVv0YeKZ2UqihqlujSC4T0
 I16O8TiiAWl5ZlgguusS8qGaJEAPokGSQAEu4NwbJRvNyXxBcVW/3sDXbmnnu1THtYmr
 noINJOJpOSz8945I77N3xAZNrjVhCtfRYiTJHpomgmjdsLvQRw6w093+CPcLVhn2B1TP
 AbRSXaLDephXxarZIjw/XUgWUB8+wwjrc/p33ldxDrn543RGKTanphOCdMqOJsdfds/o
 X0Og==
X-Gm-Message-State: AOJu0Yz01rZKN2z3s7/2cewVnKHE0DUXWTpqZBNzSJ+0CaJtQPXjE090
 27NCaD5wLeEAj9piKmAK+lNn3g==
X-Google-Smtp-Source: AGHT+IGSOSgesv2hku/4P6U/jkwB4xWwn6kEpDrHL3W0gMusILYAJ/Q8soDLCnnHr0+jniVAg6L0MQ==
X-Received: by 2002:a05:6000:188b:b0:32d:701b:a585 with SMTP id
 a11-20020a056000188b00b0032d701ba585mr12297923wri.69.1700081747300; 
 Wed, 15 Nov 2023 12:55:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j16-20020a056000125000b0032f983f7306sm11470293wrx.78.2023.11.15.12.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 12:55:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D8435F7B6;
 Wed, 15 Nov 2023 20:55:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 06/10] docs/emulation: expand warning about semihosting
Date: Wed, 15 Nov 2023 20:55:38 +0000
Message-Id: <20231115205542.3092038-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115205542.3092038-1-alex.bennee@linaro.org>
References: <20231115205542.3092038-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

A surprising feature of calls like SYS_READC is this can cause QEMU to
indefinitely block as there is no handling for EOF.

Clarifies: https://gitlab.com/qemu-project/qemu/-/issues/1963
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/about/emulation.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 0ad0b86f0d..a2eefe3f3f 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -129,8 +129,9 @@ causing most hypervisors to trap and fault on them.
 .. warning::
    Semihosting inherently bypasses any isolation there may be between
    the guest and the host. As a result a program using semihosting can
-   happily trash your host system. You should only ever run trusted
-   code with semihosting enabled.
+   happily trash your host system. Some semihosting calls (e.g.
+   ``SYS_READC``) can block execution indefinitely. You should only
+   ever run trusted code with semihosting enabled.
 
 Redirection
 ~~~~~~~~~~~
-- 
2.39.2


