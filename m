Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF387C7FC9
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD6V-0003qJ-1S; Fri, 13 Oct 2023 04:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5s-000167-BL
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:24 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5o-0007nK-3r
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-405505b07dfso18769925e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697184017; x=1697788817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wDa0+LeLRl26RBk3owDHhjoJ0wMiMLPngdzMA5WHgM=;
 b=ARgemBjyG+VQXwQnkG/1IGb6cseAoOpi7siKFD6NCD0svz9mC5Uear8JZtTeNVxOSL
 ZZtuczHB7xaV8o9jiAZCQklygVLVIKvc+Xdvbu25vIoNC0uzLeoHKBKnhJmdfbbAdpHS
 xiB0duclLWbc97eWgni8q2OzJEJillQVoTJliT/kpWugEr/M+CDLNcyygsQ3lVIOvp5y
 tZvne2Mj615ghSb5bbfwSs1pGg3+Wkps0H2N28UJ95Gf73c08u0zv+Itd2ZLXDpCm6jf
 Z95rQElBt89/7hcwEDT5zezxuEjZ35HdDnX+wGrgFpkm5MSghkMGWcuBYC0B4hMEgZaV
 Yutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184017; x=1697788817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7wDa0+LeLRl26RBk3owDHhjoJ0wMiMLPngdzMA5WHgM=;
 b=e8vmf3iE3iml4reUFduGVDZcIQGfU/2RDDaVR6tCyyxFnrU9Ox5zNTDjGP1+8knEMc
 +bvAfd7oMDghK+OMURFqQ14gGqAdoFzDMS1HBgRAnzpAHHKDNyY7l+hOUaNR4nYIIOVA
 iXIYH2qfXq/jWqh1QZ3IAXWrxn04jCI7eQU+O6lJlO1CNr1bbH8xfpxqHc4HlTV7wK2D
 oGcReFjf6/EFrehJQY+7gVfF/X3bN0TzIInkyeOvul2qvY5B2vXw9rboVv0s4hp5lpKn
 i4F3DW0giQyyD6AIg7YxRdz2lDhj5oU2Iq8h4LIfji6NlsLxWS4KDgbIYdlaJRS9VF6A
 PT1Q==
X-Gm-Message-State: AOJu0YwuQz9WJEhDnQPzYumwhEKyRBvRz+9VbjeNgSKmJFAVjscKficz
 HzUcuJoaPykuLoqJ54+QhgNH37AW/mjZPkmxDog=
X-Google-Smtp-Source: AGHT+IHb3dj63JqR90aM/Ft1VKlRbgEbi0KsRr5tHN3R9RwxbG5TrvcWOjIvB0hyba0sgZUR1qUfhg==
X-Received: by 2002:adf:b353:0:b0:32d:93a0:978f with SMTP id
 k19-20020adfb353000000b0032d93a0978fmr3294536wrd.2.1697184017348; 
 Fri, 13 Oct 2023 01:00:17 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.01.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:00:16 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC PATCH v2 78/78] meson.build: increase -Wimplicit-fallthrough to 5
Date: Fri, 13 Oct 2023 10:57:45 +0300
Message-Id: <7a263d4200cfef8185fce46633d29d01fee3167a.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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
@@ -612,28 +612,51 @@ While this generally results in simpler, less leak-prone code, there
 are still some caveats to beware of
 
 * Variables declared with g_auto* MUST always be initialized,
   otherwise the cleanup function will use uninitialized stack memory
 
 * If a variable declared with g_auto* holds a value which must
   live beyond the life of the function, that value must be saved
   and the original variable NULL'd out. This can be simpler using
   g_steal_pointer
 
 
 .. code-block:: c
 
     char *somefunc(void)
     {
         g_autofree char *foo = g_strdup_printf("foo%", "wibble");
         g_autoptr (GList) bar = .....
 
         if (eek) {
            return NULL;
         }
 
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
@@ -438,28 +438,28 @@ add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
 warn_flags = [
   '-Wundef',
   '-Wwrite-strings',
   '-Wmissing-prototypes',
   '-Wstrict-prototypes',
   '-Wredundant-decls',
   '-Wold-style-declaration',
   '-Wold-style-definition',
   '-Wtype-limits',
   '-Wformat-security',
   '-Wformat-y2k',
   '-Winit-self',
   '-Wignored-qualifiers',
   '-Wempty-body',
   '-Wnested-externs',
   '-Wendif-labels',
   '-Wexpansion-to-defined',
-  '-Wimplicit-fallthrough=2',
+  '-Wimplicit-fallthrough=5',
   '-Wmissing-format-attribute',
   '-Wno-initializer-overrides',
   '-Wno-missing-include-dirs',
   '-Wno-shift-negative-value',
   '-Wno-string-plus-int',
   '-Wno-typedef-redefinition',
   '-Wno-tautological-type-limit-compare',
   '-Wno-psabi',
   '-Wno-gnu-variable-sized-type-not-at-end',
 ]
-- 
2.39.2


