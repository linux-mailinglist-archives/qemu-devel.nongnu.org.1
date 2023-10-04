Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3405A7B7B55
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxsW-0004d6-16; Wed, 04 Oct 2023 05:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxrH-00035D-CB
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:07:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxr4-0007bM-OW
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:07:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-405524e6769so3890535e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696410457; x=1697015257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GE4K3cclxwdi11+MNGgub3UZQqTqPuI5wyHW+6dSmuM=;
 b=TqEQCMgHz18wD82Tf0wrBjhWk942g3Mgb+VaSCTMIdBnzY7ZLE4EHRa4JePMq63SGZ
 Zz/AW9ID0Z64Pr88rYqP20bELCJMZxabfHPlIZU7v+rmlT6u9pcu+4rCY98STQbvNxM0
 BrM0gmu/WkcudsQDBZWc24h7P/u5PgYYnMnVRKl+rBYmd/d4d4UpmeHqgkm1/QHiTlrM
 3I/fZ060+zsDIm3yrZsfuDdBKmEk/GF+J3CdR3flIBWu+NeA2hDg9z0pKrCFK7R67l+f
 tnY2jeM0wS5CgEcOcMQ2IWgRQkO1GlaOz6zZ2Ij9wVUiG2y543OS4DzU8Xvy0zyUYbzs
 vkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696410457; x=1697015257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GE4K3cclxwdi11+MNGgub3UZQqTqPuI5wyHW+6dSmuM=;
 b=rorcoNH1XJBaNeVs4MVl67qqYmaZGAYpAk2L9GyrB9ZGCqtqCJEGIbVU7PjXEAwHW/
 nTkbOBZxTwqSEjS9RxyW53xpZbnBraUcpD2u4bPCvA+JbY88Y8In2qb3VcLSeRGOgn4i
 Tq6K9wlmps4+Luqs1/NpQ4YeLinS3MmoxYquwc3SozOLnjOVVXc/prjCq/IXquUpqvE1
 savIDHhhouqq+Tod5fVEuEXjBhzj4ooyu6u64aqYqlXMkQEbFZCGWFP7RtJ/6C+BeyfG
 CPu9Hfa3Q02oqMw9H74y2AJ1NiX75BNeiwbX08Ydp8AMKjaSsPO7qaH6ZfbMj4b857ak
 n+Kw==
X-Gm-Message-State: AOJu0YzA3J2TENMNAZWhtrKO82WGyU4AGt2yrBKUb7G5rXXo36Owh8gr
 y1SC73tirF+L6jM1B9zdoKMQShw0haPmIuOtiVs=
X-Google-Smtp-Source: AGHT+IF1cHzFnGdZVNQfZbRno2PlvcoBteHctrjAqAgcO/STSaFZRQ2G4M0UGUwXnQJ/RbbcKCCRQQ==
X-Received: by 2002:a7b:cc07:0:b0:406:51a0:17ea with SMTP id
 f7-20020a7bcc07000000b0040651a017eamr1229546wmh.10.1696410457632; 
 Wed, 04 Oct 2023 02:07:37 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 m10-20020a7bce0a000000b00405953973c3sm984629wmc.6.2023.10.04.02.07.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 02:07:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 11/13] meson: Rename softmmu_mods -> system_mods
Date: Wed,  4 Oct 2023 11:06:26 +0200
Message-ID: <20231004090629.37473-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004090629.37473-1-philmd@linaro.org>
References: <20231004090629.37473-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

See commit de6cd7599b ("meson: Replace softmmu_ss -> system_ss")
for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 21a1bc03f8..8890dc5748 100644
--- a/meson.build
+++ b/meson.build
@@ -3496,7 +3496,7 @@ modinfo_generate = find_program('scripts/modinfo-generate.py')
 modinfo_files = []
 
 block_mods = []
-softmmu_mods = []
+system_mods = []
 foreach d, list : modules
   if not (d == 'block' ? have_block : have_system)
     continue
@@ -3510,7 +3510,7 @@ foreach d, list : modules
       if d == 'block'
         block_mods += sl
       else
-        softmmu_mods += sl
+        system_mods += sl
       endif
       if module_ss.sources() != []
         # FIXME: Should use sl.extract_all_objects(recursive: true) as
@@ -3554,7 +3554,7 @@ foreach d, list : target_modules
                                 include_directories: target_inc,
                                 c_args: c_args,
                                 pic: true)
-            softmmu_mods += sl
+            system_mods += sl
             # FIXME: Should use sl.extract_all_objects(recursive: true) too.
             modinfo_files += custom_target(module_name + '.modinfo',
                                            output: module_name + '.modinfo',
@@ -3597,7 +3597,7 @@ block_syms = custom_target('block.syms', output: 'block.syms',
                              capture: true,
                              command: [undefsym, nm, '@INPUT@'])
 qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
-                             input: [libqemuutil, softmmu_mods],
+                             input: [libqemuutil, system_mods],
                              capture: true,
                              command: [undefsym, nm, '@INPUT@'])
 
@@ -3682,7 +3682,7 @@ common_ss.add(hwcore)
 ###########
 
 emulator_modules = []
-foreach m : block_mods + softmmu_mods
+foreach m : block_mods + system_mods
   emulator_modules += shared_module(m.name(),
                 build_by_default: true,
                 name_prefix: '',
-- 
2.41.0


