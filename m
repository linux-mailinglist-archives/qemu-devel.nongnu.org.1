Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C72EBA2CEC4
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Feb 2025 22:07:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVZU-0008UC-VO; Fri, 07 Feb 2025 16:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVZ9-0007nt-Ab
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:11 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVZ5-000246-6Y
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:08 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f6a47d617so1384595ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 13:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738962426; x=1739567226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLitLdlmGvTcmycuDS6Q71bKYSkfaIiONi8PyJuH2g8=;
 b=dNQiKuV0UQNWnfh/9McZ1aha6JlIPfT5jkB4I6HmOEm8eqXvM4PweKS547mm72cW5w
 udbT5rNTVTf54riEA58Oc7Tdrx2dwVoOKptZERpcDSgZdtY7WkSrOO/v3l/yegPUL9Ze
 /Ir8RhNlLebqz+dGLevsP9VKqmIA9MtIARd1C+ACrZ4VD2yjXh0qrwEaCZxmUDJFMj9b
 zVIu9Ue5Q6WGUObmm4+877Ah8JtG4i+k7x5S1RjFdjuvnFYUeli5O4sYNb5ZSQANFeV8
 +kSX+Y6FsDdGXKCbLz5tMEyn/pYcPhOoHpEnZCYaSdPAWj3CJWT8kPtRoA0RMCGu1y02
 tBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738962426; x=1739567226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VLitLdlmGvTcmycuDS6Q71bKYSkfaIiONi8PyJuH2g8=;
 b=qFJmPIGR8tGGhmL4x3vzSQDX/z7YPUXJxFKjy4eufkkFy+ndCXb7Uw+PFujvwi/nZr
 txBeIF03U52e/EM06xgue/3ObD+Y2vFHcJcVvZ1qgNg04gxIbG2nHbKAscmB38DnN4PL
 sbSsnxKfDbOGykFslIdsFU0wcWcy7Y4ZQIMxE2hgncqNi+H2usK9AWn8a00Q/XC6oybz
 xmJCsZzR9jiwIKSqT4DJ2KOVRmeoCxUP7NfIBE5GWnAYpg5FtJ9swb8CKCH6L8vm4AM3
 YrVVZy+KOwV+TL3hTlU32nCJnjhhwCQJyx2uKkyliVcfpxlSvfm3z8r5HKSB9Aqqhgvi
 R8uw==
X-Gm-Message-State: AOJu0YwXSTJeldQmAndAKDojTBMv3GnJ3f0NBeZgQg03dkdM98hkjthP
 OLZ2YWSnnvdWx/9+ew0gG4AEN3SvwI44G8wHIJ1y4ZrtdneIIUb02x1miFPRjvvtyC1b9Ur+KhI
 v
X-Gm-Gg: ASbGncsHmL7NzfdZlWBox77pbD1Q14Fnl+VG/uBGn4MmFxm7W8gUcEjF8X5rjWxBoG0
 XVdn0XwWS2RvjK33EDkA/rSoAb1WLyeFZ7oBoB9ZLM9PHzEsbN9WObLUWkdu3sfvOTcv4SVg6Sr
 J+u/+B3NmwAaW6lZVHKtticdSTgweRY5qjEauUrXYJJoKhiBg8VqvduI6uBmbn5SoY0HSJy1Tj0
 7D/d4wOKOsQzL/yAOvUQa1Mg8pVxNrLDvZ5KqZ1CanZg2yuji8y0FSaXqWCKTwiYIFdh80g/Xhl
 2SuoBJFNU1a9qITXa+FL9+UkR+PsGfYORV8inNKplVXmv0k=
X-Google-Smtp-Source: AGHT+IGt+VupTrdJ15h4GYMLhd8RvgRDDK6zMX4O1HwbECDOgT6z2YyWQ6zFDXZe4zSDfFSAbTDkFg==
X-Received: by 2002:a05:6a21:181a:b0:1e7:6f82:3217 with SMTP id
 adf61e73a8af0-1ee03a2205fmr8986196637.3.1738962425666; 
 Fri, 07 Feb 2025 13:07:05 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51af64c1dsm3539043a12.52.2025.02.07.13.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 13:07:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 9/9] meson: Deprecate 32-bit host support
Date: Fri,  7 Feb 2025 13:06:55 -0800
Message-ID: <20250207210655.16717-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207210655.16717-1-richard.henderson@linaro.org>
References: <20250207210655.16717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We deprecated i686 system mode support for qemu 8.0.  However, to
make real cleanups to TCG we need to deprecate all 32-bit hosts.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/about/deprecated.rst | 7 +++++++
 meson.build               | 8 +++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a3c302962..7c61d0ba16 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -204,6 +204,13 @@ is going to be so much slower it wouldn't make sense for any serious
 instrumentation. Due to implementation differences there will also be
 anomalies in things like memory instrumentation.
 
+32-bit host operating systems (since 10.0)
+''''''''''''''''''''''''''''''''''''''''''
+
+Keeping 32-bit host support alive is a substantial burden for the
+QEMU project.  Thus QEMU will in future drop the support for all
+32-bit host systems.
+
 System emulator CPUs
 --------------------
 
diff --git a/meson.build b/meson.build
index ec51827f40..387490d922 100644
--- a/meson.build
+++ b/meson.build
@@ -4841,14 +4841,12 @@ if host_arch == 'unknown'
     message('configure has succeeded and you can continue to build, but')
     message('QEMU will use a slow interpreter to emulate the target CPU.')
   endif
-elif host_arch == 'mips'
+elif host_long_bits < 64
   message()
   warning('DEPRECATED HOST CPU')
   message()
-  message('Support for CPU host architecture ' + cpu + ' is going to be')
-  message('dropped as soon as the QEMU project stops supporting Debian 12')
-  message('("Bookworm"). Going forward, the QEMU project will not guarantee')
-  message('that QEMU will compile or work on this host CPU.')
+  message('Support for 32-bit CPU host architecture ' + cpu + ' is going')
+  message('to be dropped in a future QEMU release.')
 endif
 
 if not supported_oses.contains(host_os)
-- 
2.43.0


