Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 864C5830968
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:15:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7d0-0000w0-KY; Wed, 17 Jan 2024 10:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7cy-0000j5-Gx
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:14:52 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7cu-0005p4-Ai
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:14:52 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a2e0be86878so518667366b.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705504486; x=1706109286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Li9sRZN0mRf8DkyGaJQon8lVmYH2nBUS0oNdkHOoC+A=;
 b=z1tK+5ud7XB0ZxCEagXvc2P307RfjameKgTRtFnV5zqGhKf/Bsj1S3R7XHNac6QTGs
 lrqyabva1BTwU5C4nWVYavxjbsKZHxG0CRDe4khRED9IjkZfDv71X107XXn68oawgVS9
 623jd8wYbjXufWKiIN4C7aXQs463yXNbhaq/UoIl45BDIjO3DPz409t4plxjkxR8B7MG
 pelwFxUngLkZBcErPm8ebY5ArCDQBkvDT3aDX7xAxcNAACbkE5wKBs344ioPdJ5zPPoN
 m3mkejZUfRoIxcF96Bv8GF/Y0dDI7eTDodwCWezEYhoEJFQfo0krSMpvGD3tCKdfNIut
 3Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504486; x=1706109286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Li9sRZN0mRf8DkyGaJQon8lVmYH2nBUS0oNdkHOoC+A=;
 b=T4AEDy+26kBoXczscDaNLQeM74xLlU8smDzV0NY62pw1Rn2vRkRTAjrXg7dzOanMWd
 PGUhcUWIIjuKpmkvXsC7VxMOxEgTJMlf33AfiwRwu8XGfCKIm5kJs2NaZ/xHNKOluNoz
 fXbd7qVaoJh2zh7yJD0eJDFfmnpyAF8J922yyk0p63JwXSLdumi9JkYZM7cZ9nYPJwCr
 BXl7s4hOY3AFdYqVnAYbBs0sA6TeTNa9NGrh8C1+97DqOcB5Zly1yQaL6AY7EbNgvoZS
 imouIN+Fc5n8c+5cRBDAuGKZVRAbfTy0YJVNMtpIa/5J3/lAcBA0R/pXDMy8it6hXE3E
 fwEg==
X-Gm-Message-State: AOJu0Yxh4igsz1SDc61jCFsCbXGKTC805e1kQYG9nkv9KvphuC1P02aZ
 uSiv2eGpwUqGBxgH5/CN/5mdpu4lk1bG3n3Cl8k4nFDZwhUbR9jQkPnWz7ZOAKFmp09Rx4/iVlx
 6
X-Google-Smtp-Source: AGHT+IFNod80YwGzlhfG6lya+LBEAn7deDqBZ1b2vBAeQt6hezrnthyYChOftI2pwHUKy9tu1ZpW1A==
X-Received: by 2002:a17:906:c317:b0:a2d:6b8e:fb17 with SMTP id
 s23-20020a170906c31700b00a2d6b8efb17mr1016424ejz.20.1705504486526; 
 Wed, 17 Jan 2024 07:14:46 -0800 (PST)
Received: from m1x-phil.lan ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a17090699c600b00a2ed222d61esm845329ejn.199.2024.01.17.07.14.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jan 2024 07:14:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, devel@lists.libvirt.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] hmp: Remove deprecated 'singlestep' command
Date: Wed, 17 Jan 2024 16:14:29 +0100
Message-ID: <20240117151430.29235-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240117151430.29235-1-philmd@linaro.org>
References: <20240117151430.29235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This command has been deprecated before the 8.1 release,
in commit e9ccfdd91d ("hmp: Add 'one-insn-per-tb' command
equivalent to 'singlestep'"). Time to drop it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       |  9 ---------
 docs/about/removed-features.rst |  6 ++++++
 tests/qtest/test-hmp.c          |  1 -
 hmp-commands.hx                 | 13 -------------
 4 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 25527da423..316a26a82c 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -167,15 +167,6 @@ points was removed in 7.0. However QMP still exposed the vcpu
 parameter. This argument has now been deprecated and the remaining
 remaining trace points that used it are selected just by name.
 
-Human Monitor Protocol (HMP) commands
--------------------------------------
-
-``singlestep`` (since 8.1)
-''''''''''''''''''''''''''
-
-The ``singlestep`` command has been replaced by the ``one-insn-per-tb``
-command, which has the same behaviour but a less misleading name.
-
 Host Architectures
 ------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index a8546f4787..855d788259 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -635,6 +635,12 @@ Use ``migrate-set-parameters`` instead.
 
 This command didn't produce any output already. Removed with no replacement.
 
+``singlestep`` (removed in 9.0)
+'''''''''''''''''''''''''''''''
+
+The ``singlestep`` command has been replaced by the ``one-insn-per-tb``
+command, which has the same behaviour but a less misleading name.
+
 Guest Emulator ISAs
 -------------------
 
diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
index fc9125f8bb..1b2e07522f 100644
--- a/tests/qtest/test-hmp.c
+++ b/tests/qtest/test-hmp.c
@@ -64,7 +64,6 @@ static const char *hmp_cmds[] = {
     "qom-get /machine initrd",
     "screendump /dev/null",
     "sendkey x",
-    "singlestep on",
     "wavcapture /dev/null",
     "stopcapture 0",
     "sum 0 512",
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 765349ed14..fc5f5c57ad 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -398,19 +398,6 @@ SRST
   If called with option off, the emulation returns to normal mode.
 ERST
 
-    {
-        .name       = "singlestep",
-        .args_type  = "option:s?",
-        .params     = "[on|off]",
-        .help       = "deprecated synonym for one-insn-per-tb",
-        .cmd        = hmp_one_insn_per_tb,
-    },
-
-SRST
-``singlestep [off]``
-  This is a deprecated synonym for the one-insn-per-tb command.
-ERST
-
     {
         .name       = "stop|s",
         .args_type  = "",
-- 
2.41.0


