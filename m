Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0D07FEA18
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 09:01:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8byA-0002DX-1v; Thu, 30 Nov 2023 03:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8by3-0002D2-9W
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 03:00:18 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8bxx-00026V-43
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 03:00:14 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-332ed02ccd9so430067f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 00:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701331205; x=1701936005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GQXmI5dG7Gt3cquF9yAt8aqpNMg5Z7f0qPD848Q1k2g=;
 b=eFr879MSgHVbT5w2vcqQzJEwmMkgB3v0pB+E6GMUE0eD55ed1uZgj0xgTDTiPMumbI
 2Z9lQDj2Bz1U61m7gCR2+HORKpX+A2TkIcYGUs6ZO5wyT1xGahXap0LlnjSQFvXykv5J
 IUEL+cRITj1ElLEF5hB489QVCWB2giDd+zzekxbvHybW5cakuFr6lSQg5ZdtRQt86Ag9
 XGKxH1NX9kdk5TSd+zhMIiSoxcRcN85FwzEq4ZMjd093i2oKhCi9FPPJVD0RbJbdpAO0
 lHxMjvWpQfGh+S/xmWSuHdIWs/jKkmhRRx6lSmPmKwrxP7URJwr/Bd0AH4xV3ymFgppU
 795A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701331205; x=1701936005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GQXmI5dG7Gt3cquF9yAt8aqpNMg5Z7f0qPD848Q1k2g=;
 b=tdZflHAWQCFz+DeLXACUHf7DyOowqG6k5tVgaqndkE5Ux9k7DP6hvgQFsxC5vtF8KR
 6kSnHTQn8VX5VSDOC2nRauYeOIMQ8MT8vG/byKyxTV5U5TahacdYZ2Aj+AlDX0qZB2PH
 eZAHDjSPyzQPmZvxMU4A75EUhnvfg+Zlwqf/oTbn3OWoBG2h/Tbtl3piCSNmp9B/yJkL
 UMHCVmQAg5FMcMSblRa/gRi4TBFOFFnQc0Q5cxRZZtl8Yz40lmh7l7tiB0YwpY/+TLuR
 imw4E+kFakJeDer9sG1otBvaC8YmsoSK+AwgFP6e7kTYuCzscPItlM3vdqbGmOJjkie1
 HtZA==
X-Gm-Message-State: AOJu0YxJS5EELlDyzZ/xZH+R7FbV1Bk0PqenLkGoBox8lZYiHP2TabAS
 xPUFMBASsfXcQ5Gqr5PeuxSqkcTuEX8iSc9VyimaSw3e
X-Google-Smtp-Source: AGHT+IEfZW81Ni9uN5TkK3cQGIvllP9UqZ6NzB0hpQAfAnjGPOUX/XMpF2xL+z+2djKMPut1Svj+yA==
X-Received: by 2002:a05:6000:807:b0:333:880:e2b0 with SMTP id
 bt7-20020a056000080700b003330880e2b0mr8686426wrb.2.1701331205214; 
 Thu, 30 Nov 2023 00:00:05 -0800 (PST)
Received: from localhost.localdomain (53.red-88-28-16.dynamicip.rima-tde.net.
 [88.28.16.53]) by smtp.gmail.com with ESMTPSA id
 l7-20020a5d6747000000b003316db2d48dsm771518wrw.34.2023.11.30.00.00.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Nov 2023 00:00:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0] accel: Do not set CPUState::tcg_cflags in non-TCG
 accels
Date: Thu, 30 Nov 2023 08:59:58 +0100
Message-ID: <20231130075958.21285-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

'tcg_cflags' is specific to TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Other targets already use it restricted to TCG, or are TCG-only.
---
 target/arm/cpu.c  | 2 +-
 target/i386/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 25e9d2ae7b..098e964644 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1781,8 +1781,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     int pagebits;
     Error *local_err = NULL;
 
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     /* Use pc-relative instructions in system-mode */
-#ifndef CONFIG_USER_ONLY
     cs->tcg_cflags |= CF_PCREL;
 #endif
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cd16cb893d..dfb96217ad 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7222,8 +7222,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     static bool ht_warned;
     unsigned requested_lbr_fmt;
 
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     /* Use pc-relative instructions in system-mode */
-#ifndef CONFIG_USER_ONLY
     cs->tcg_cflags |= CF_PCREL;
 #endif
 
-- 
2.41.0


