Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3980EC05
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:38:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1yc-000871-4t; Tue, 12 Dec 2023 07:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1yV-00082t-J8
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:35:01 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1yT-0006mY-BI
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:34:58 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ca09601127so75167691fa.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384495; x=1702989295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FjRv+vnD4PJf/d4rT729kMYrO2SSxTsxM5m/jedirA=;
 b=onBrAB/ZaIb3ARiQhlOWwn2lH3QcQ8yMBCnmlSn0eUoxt6naqapSRhl4FqxMFuVY9P
 ZiAbVKlUX8xPa8AIFB7WWTAggHWG/lRXA8iZaPqicxNG+g7FH0kV+FEwSs0mKz2xzGRC
 UhRrdf2e0azr94sHFNyiBMZVnyEMT1sicrxaRDETNSikdBOq9UVf4jI4WYM6+f7r4e3w
 sDZKxuLCueUI48kbBk5zWFakTzE+gE/3khADzJPbi3hTltJnWAWA6ilxyZRo99hveCfW
 anc002/M2bCqDY28gj2s2qIHTVOGEK6AET02ppoOrCp/3/YTox9XKHAgdHgL5jRHNPl7
 GXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384495; x=1702989295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FjRv+vnD4PJf/d4rT729kMYrO2SSxTsxM5m/jedirA=;
 b=GTariVnGsF55tR76Inwix9IX1/Y0VrocGKJsZv+CaeeEckEjHcE3C9AabbQSKxEeik
 47KUy8FaGOfCraEB7N21B6/KTLYLCszXXNuwI5EiOl7beKJSkWxAkhr6FxustwlGKhLl
 pk2kni8EJ7NETdSyNkwjs7JrwlEgg/wNmZ2iAw090gOIRRQn/uUaZeDfDS3dcushgaiU
 4yD4AZw2ufplrAkN2TE8NST6+M2XrMDg6R9JowXLiPMMIeruqTwD5cilNujo2zaNBrSc
 cqvpQyX2rv9nI0mYUaNTELJOOx83ULHXWkIAjNxIAQ7SLRiOdLIfQCZ2YJYY1Nfd2BAT
 t35g==
X-Gm-Message-State: AOJu0Yy7qKjJ3bGbDG1P/WANJtS/I8BvOV1wBk4eGqp4FXQWVwqLsFMA
 qE7E4+NcKERk/D1Zi6gJHnR2C0Vr9XObcPTDj4YESA==
X-Google-Smtp-Source: AGHT+IFExN2m5vaGNnbjku2yUioHYIglD4eGSxmMOFGsUNdvZCGc5nsUzfgEgN+E2fxwONhdqdMZDQ==
X-Received: by 2002:a2e:870e:0:b0:2ca:23e6:7373 with SMTP id
 m14-20020a2e870e000000b002ca23e67373mr2252314lji.90.1702384495204; 
 Tue, 12 Dec 2023 04:34:55 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 bt13-20020a0564020a4d00b00551d6d51401sm42198edb.53.2023.12.12.04.34.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 04:34:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/23] semihosting/guestfd: Remove unused
 'semihosting/uaccess.h' header
Date: Tue, 12 Dec 2023 13:33:43 +0100
Message-ID: <20231212123401.37493-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
References: <20231212123401.37493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

Nothing in guestfd.c requires "semihosting/uaccess.h" nor "qemu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 semihosting/guestfd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/semihosting/guestfd.c b/semihosting/guestfd.c
index 955c2efbd0..d3241434c5 100644
--- a/semihosting/guestfd.c
+++ b/semihosting/guestfd.c
@@ -12,10 +12,7 @@
 #include "gdbstub/syscalls.h"
 #include "semihosting/semihost.h"
 #include "semihosting/guestfd.h"
-#ifdef CONFIG_USER_ONLY
-#include "qemu.h"
-#else
-#include "semihosting/uaccess.h"
+#ifndef CONFIG_USER_ONLY
 #include CONFIG_DEVICES
 #endif
 
-- 
2.41.0


