Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A485D7E9FDC
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:23:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Ykj-0001aS-Of; Mon, 13 Nov 2023 10:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Ykg-0001Zy-RB
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:21:26 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Ykf-0003DV-Ac
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:21:26 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9e1021dbd28so691892166b.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699888884; x=1700493684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R0n+efnCwqYZSgvX5xA6BN1n520F2bZNMKVl3gVhASA=;
 b=AmX6ck34N5q25RR3/BjTA9BuDaAR9ED2T8lSOOWfVoqbaSA7FlxiDn6cW2EXCutPgM
 zoNWmFqNouSfuFAq79N2Si+aS8JlcQnTImAt/XtPqqZoQ4fVsc8Sm64y5A1+0uEW84cY
 PgejuR3f0ckM8KhSrz5EEvvV4MJlPLi6T8JWdQO7y9Xwg1TNsVI+g+Sf0wfTC4sEoK5v
 jOA2QdvA5O+V5yhF/r9iMupT3na2U3dM8SE0PDjvtWSfx3uIXJLVSk32W8UK141beRkC
 QeBpUGjirJReSTuedHD1daulrA9lVVRIjCEM52SHhT4pfwQOh4pAuSiqx5jsBgfJb3ay
 Ahgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699888884; x=1700493684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R0n+efnCwqYZSgvX5xA6BN1n520F2bZNMKVl3gVhASA=;
 b=KB7dGrnECx0SIFR5KhJrGbxWwot6OVrfmXBlvlkGfTuejqXupbnVbQZhlWoCwCmqXO
 4BIgqo/dK67/LcKBvt+9qES4ESCoWxJ7V1D680Kesf5WhjwkQd+ypnrU6D9+ZONPhMS/
 Ho++73VFAbefm1T8AZAtclgpIACbiv8m+oX4LUQ5CyPrI9/a0D4Hckw0JLeWt4JGJ1nF
 NT24OYb+aRHGrZerp1TPFzv+aJY5uhsBcXUCj7Sn1te8FaE/J9OfGrGNX6A7I8CWt4Uy
 G1IBMFjfa5SVicumKgJQrU1h9xy3HGQU749/vlJA1s7IEEwKTY8BMmhX5PjvCqv4AoMS
 dDhw==
X-Gm-Message-State: AOJu0Yzy3cua/LngqagkOVsnMdaURFOmx1ve/GnraLFYHhect+a58SMG
 r5EMV0Rg0Ky5ZlyxZI7WU8wy20qkpWJchtdSbn8=
X-Google-Smtp-Source: AGHT+IH6xxb8oSsdvX/Qxe7SX73ROr6di4a0tnTAF45WIy9EC8KmTSkElWDjJsGSvtz6GSstCFLdyw==
X-Received: by 2002:a17:906:4c84:b0:9cb:5a8a:b19d with SMTP id
 q4-20020a1709064c8400b009cb5a8ab19dmr4350360eju.5.1699888883852; 
 Mon, 13 Nov 2023 07:21:23 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 dx15-20020a170906a84f00b009adcb6c0f0esm4204593ejb.193.2023.11.13.07.21.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 07:21:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 01/10] sysemu/xen: Forbid using Xen headers in user
 emulation
Date: Mon, 13 Nov 2023 16:21:04 +0100
Message-ID: <20231113152114.47916-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113152114.47916-1-philmd@linaro.org>
References: <20231113152114.47916-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Xen is a system specific accelerator, it makes no sense
to include its headers in user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/xen.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index bc13ad5692..a9f591f26d 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -10,6 +10,10 @@
 #ifndef SYSEMU_XEN_H
 #define SYSEMU_XEN_H
 
+#ifdef CONFIG_USER_ONLY
+#error Cannot include sysemu/xen.h from user emulation
+#endif
+
 #include "exec/cpu-common.h"
 
 #ifdef NEED_CPU_H
@@ -26,16 +30,13 @@ extern bool xen_allowed;
 
 #define xen_enabled()           (xen_allowed)
 
-#ifndef CONFIG_USER_ONLY
 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
-#endif
 
 #else /* !CONFIG_XEN_IS_POSSIBLE */
 
 #define xen_enabled() 0
-#ifndef CONFIG_USER_ONLY
 static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 {
     /* nothing */
@@ -45,7 +46,6 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
 {
     g_assert_not_reached();
 }
-#endif
 
 #endif /* CONFIG_XEN_IS_POSSIBLE */
 
-- 
2.41.0


