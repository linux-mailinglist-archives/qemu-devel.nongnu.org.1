Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF00A150EF
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Jan 2025 14:53:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmm9-0002Yi-HW; Fri, 17 Jan 2025 08:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmls-0002Tk-Os
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:25 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlp-0003ki-Vl
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:24 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaee0b309adso345331466b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121937; x=1737726737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BAoeWKkDj1LhcqXrH6NGonyyn5Hcg/wwizoEUTfNUY=;
 b=tpD7VoG4mWWiqyc9zLH8mNOMQ9t+q4HD0cdPwbqdcYlTXD87noAP6kNUHB3wn1CyT7
 M484bwGJWEC4+6n8Txt/mzEvZWaNhO9cUjofbdFmg/Id9eKoG1h5AyWVnkd0pusmAcN5
 hPrVT5in7uN4dsLoPlmZA6lKFLN4V3Lkq8CheiQICqWQN1T9EeMYRQH6UKpRmOtlDf8A
 Tg/GZb8//sQrVxLBdfYavcvx8LLSQWLGz9lRgZpE3rB60L9PzmQs49PD/9HcyjzaQSo8
 ZKYmF5ZjA2nPrN/WxayurK5y7elHDJdc7pslCaHxpYkNJPtpP4WRvfYuWpOA54+Ujfte
 er2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121937; x=1737726737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BAoeWKkDj1LhcqXrH6NGonyyn5Hcg/wwizoEUTfNUY=;
 b=ktUlHrCuJAa/AT3yUUH8lWmcZ6fecUlfvDky+24WJbdFmRQEJHahd7Qd5H5TjR7+FK
 oVq8uQueyOPhBCMAwgusr/FaWJoDYp9LL9GrUYik86HZRhbb0Y/hbz8g/dJB16BTSR+2
 7ndtS9hrPrvtlKQFQ+YMUrRhp7sjS+sZOM+0HsqVXbimNu7JfAyY21aPdZRaisLqICcj
 zDW7GqpY69B3puU3RmBkrSz/aC2bLM5dsE2WQgc196XCVW/PjJeBAMJXyZK71MtG3hlL
 XiZeu8JrqQUOJSRueJB5ZZRc87vmqb2Ufp9qJP1a9kH0L/PHooTKt6DdA78xYlklzKrA
 VmZg==
X-Gm-Message-State: AOJu0YxP8OoHG51uRfJpoeL1Qk4Hw/jx6bsanF67j4qGol+40L93nip3
 zV2TIDH5HfOjhGbXxnNxI9ioahkbczuQf8k60gMstWC8jDuTV8CRVQG7SkrI1Ao=
X-Gm-Gg: ASbGncvGiYdb1t3GNDKQAcH9lDyBc+7ZTjhF671fj8N2AS/M5QntITZj9lEA7x14Bho
 wpc4TR+4rU0JF/O+HKzfCisxi0sQqy+zOw3EPquKts4dQWXbG5xaha5w0coNMnYdIyCFdZdkmSR
 xllXVmpRwuFwKOOFGIQEZgWDV44MzVfaQ0bAR7ApKLLzSw0Gz/n+8MlG89guf14pnxlcVJ2CTrN
 P/Pg5nyI2im2kq7PlZN6yqoI12Np6GGFK6TfyHII2fCXX4UIMEdElA=
X-Google-Smtp-Source: AGHT+IHpGaDIKVx7bZ+yk4k0+Nst3fsbzUMnoIRYMtuZssslTimVo7FSEPfkTmQNjeKYPmVE8eSMEw==
X-Received: by 2002:a17:906:4783:b0:aa6:7662:c56d with SMTP id
 a640c23a62f3a-ab38b167b33mr273208066b.30.1737121937391; 
 Fri, 17 Jan 2025 05:52:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab3999638f8sm44617666b.9.2025.01.17.05.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:52:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2F965608D6;
 Fri, 17 Jan 2025 13:42:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 24/37] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
Date: Fri, 17 Jan 2025 13:42:43 +0000
Message-Id: <20250117134256.2079356-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Stefan Weil <sw@weilnetz.de>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250110203401.178532-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-25-alex.bennee@linaro.org>

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 2f68b50079..d025933808 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -416,6 +416,26 @@ definitions instead of typedefs in headers and function prototypes; this
 avoids problems with duplicated typedefs and reduces the need to include
 headers from other headers.
 
+Bitfields
+---------
+
+C bitfields can be a cause of non-portability issues, especially under windows
+where `MSVC has a different way to lay them out than GCC
+<https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html>`_, or where
+endianness matters.
+
+For this reason, we disallow usage of bitfields in packed structures and in any
+structures which are supposed to exactly match a specific layout in guest
+memory. Some existing code may use it, and we carefully ensured the layout was
+the one expected.
+
+We also suggest avoiding bitfields even in structures where the exact
+layout does not matter, unless you can show that they provide a significant
+usability benefit.
+
+We encourage the usage of ``include/hw/registerfields.h`` as a safe replacement
+for bitfields.
+
 Reserved namespaces in C and POSIX
 ----------------------------------
 
-- 
2.39.5


