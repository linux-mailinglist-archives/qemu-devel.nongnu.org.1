Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A627C80FE
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:55:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtI-0008Ss-1r; Fri, 13 Oct 2023 04:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDst-0007PN-4r
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:51:03 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsq-0001dV-LA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:51:02 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50337b43ee6so2508191e87.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187059; x=1697791859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJpxflpF0VSGP1lY+JunfkK8++cYRxJyDiFsuvVgAAM=;
 b=w8vYQQBjvulDyD9Wdu/YHa7fOllo/b7ichbXAt2D0QySO+PEad5d1Fp3bHXmfwgIh3
 a6VUl78NPecSilVTl3MHX/eWI74iBAeRqmZIk10K13HARzlHB/WEgblTfW/GVcHRdTy5
 hHQSeCdULHQpJR5RahsrVHhAcT1G9yGu5uCpAjPU5AVWFKe84IuiNJVSNiNiEMgyv7C9
 WeHSJJ762l9r0fmZtUd4h9QLB49i2i3OgJzEeIjthGxlEHb/apedmjJTHKf/xtKrGTV3
 8OhCSBHRGnsb7ytMfymadsaID95k43VuM3JRi7oPpWmAWEygUHWJE8Mxe5u7ripj3wNW
 mRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187059; x=1697791859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJpxflpF0VSGP1lY+JunfkK8++cYRxJyDiFsuvVgAAM=;
 b=eBRwydM4AKMCyyMd7BUKItEaLSrd0hqly29xtlBsqi3O8mIM7gld7VJiOvYtLJLdYq
 uLEuJ8QEnBzepl9gzj/hXdTqbJ3VIkqvuXrEqhm/1MLLB3aTW0m7h8QSQqdmq5Zk2S/n
 Kvx+bFqroMV2qRjVzOpm8bOpNa0vCaDNXNTbmyCfrnZRbtcQGAgN8YPvhTkCbWRxKRyZ
 lPVmngLtOgfChmz1Wkv+/NqDuFTY48Agcw1NVwYkdiomVo7j2Y8dYptT6M2nsKcTcBdJ
 yaSdFRV9plzikrjcsIsKeRn6y/FOuVh+tLLtdLAJV+sg/9/mCjG0u43MyAl7HbWA7RJy
 Wu4Q==
X-Gm-Message-State: AOJu0Yz8eExA/2I+1/jEPtIQVZFraLkcupswrouG+1tvqLza9w5OQh9M
 IZHZZxQ1uPVwhQv+3a1YDfYV43xqye1VnzUttl8=
X-Google-Smtp-Source: AGHT+IGYxtapLYBLjPlYkh4BbnYViUKIPYbAbm3GGy9a4KuXIUIx3/vQ3ZzNLIe4OnJim6s4w5lnOQ==
X-Received: by 2002:a19:4f43:0:b0:500:a240:7240 with SMTP id
 a3-20020a194f43000000b00500a2407240mr21866359lfk.52.1697187058681; 
 Fri, 13 Oct 2023 01:50:58 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:58 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC PATCH v3 78/78] meson.build: increase -Wimplicit-fallthrough to 5
Date: Fri, 13 Oct 2023 11:46:46 +0300
Message-Id: <80a212fc419991612ca732cb3ed1c923a079ec3b.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x131.google.com
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

Make GCC's implicit fall-through static analysis stricter by requiring
the use of the fallthrough attribute statement instead of comments.

This makes the QEMU code style more consistent.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 docs/devel/style.rst | 23 +++++++++++++++++++++++
 meson.build          |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 2f68b50079..f473dd24e9 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -634,6 +634,29 @@ are still some caveats to beware of
         return g_steal_pointer(&foo);
     }
 
+Implicit switch case fall-through
+=================================
+
+The C language allows switch cases to "fall-through" when a "break" statement
+is missing at the end of a case. This, however, introduces ambiguity in the
+code, as it's not always clear if the missing break is intentional or a bug.
+
+As this behaviour allows for bugs we do not allow "implicit fall-through".
+
+In order to identify intentional fall-through cases, we have adopted a
+pseudo-keyword macro 'fallthrough' which expands to gcc's extension
+__attribute__((__fallthrough__)).  `Statement Attributes
+<https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html>`_
+
+All switch/case blocks must end in one of:
+
+.. code-block:: c
+
+	  break;
+	  fallthrough;
+	  continue;
+	  goto <label>;
+	  return [expression];
 
 QEMU Specific Idioms
 ********************
diff --git a/meson.build b/meson.build
index 79aef19bdc..e8805f0e0c 100644
--- a/meson.build
+++ b/meson.build
@@ -452,7 +452,7 @@ warn_flags = [
   '-Wnested-externs',
   '-Wendif-labels',
   '-Wexpansion-to-defined',
-  '-Wimplicit-fallthrough=2',
+  '-Wimplicit-fallthrough=5',
   '-Wmissing-format-attribute',
   '-Wno-initializer-overrides',
   '-Wno-missing-include-dirs',
-- 
2.39.2


