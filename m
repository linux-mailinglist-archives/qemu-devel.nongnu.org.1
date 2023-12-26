Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD00781E7E9
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 16:06:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI8zE-0002yN-F4; Tue, 26 Dec 2023 10:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI8zB-0002y1-Pt
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 10:04:49 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI8z9-0003Xo-Nc
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 10:04:49 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d5ae89c7bso3277645e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 07:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703603085; x=1704207885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=53AW3JZnEVBpO4Di77Dp5vOYBvX9VB53tNaqD2ZNzQ4=;
 b=nvnnISdFG0jbtFGolUpVypxE62qlH3DUPc7xcdAghEgM6smurOXJph+/blpGXpkCZt
 uyRS9mUUJEPcrMVJRtawX7KViXf222Rv4dOUPsDc8rgm8B9UrLTLj5ZUFf//X+sHcsLM
 KD+Ah3wqRYInZwvE4oqeEPex5zTSprHx1DmUxBUwqbOPOjFi+UMHi8PREWD5nJZqLSXR
 KW6y7tFs3FBfrdacMHrUmoupv0yETfNjwbalYRc8/KmVRd0ow7MMhBuYZu9vUJsg29IJ
 8r/YomegX+Za0c15gw28AaWfTLNM0EwrcKrXBtn7UzHEv6peBH52odGc2Vjf4ud4NV5o
 w0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703603085; x=1704207885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=53AW3JZnEVBpO4Di77Dp5vOYBvX9VB53tNaqD2ZNzQ4=;
 b=mrFFR30q9Xx3AP9OyuBEicqBA5boDIyN9Sc5DAyvMduyBP4L6Tt1gG3tbnIbefKnzt
 m5MiR8PXqcXObyD2uJ3wsvlRWHfwAkkkgozGduvpspJOBR6nSL26Utm+iXgub7eJLwpK
 hoJfi12TuGLB5wuICcvCZyX8pyFKtnn9sJlfrdW8Z9uKVX7JhUnJDEFTrgr3m0ZUPmW0
 iRsZ5XZHbQLK2RI1RJkXoDlxyOTkJZ5lIwxAmPnkDylczyPiG1XD9khXByGy16dMRo5S
 LWCsEVWo8ionmE3tvm/IgLUgWH/FrIwQoLvBwGFD5Zn/9mItZtb3BgCe9ig3p1cvwSzM
 pPVA==
X-Gm-Message-State: AOJu0Ywm9OUmNOZzcs9YZVIYM3vgCdvlUBFmy4+a7o1Q9i4+J/hZ5ENr
 qsSTvUcRQSJhFZ4PfuUSjpvePdZT/TK79zMLkyG/acygw3o=
X-Google-Smtp-Source: AGHT+IHvFNtdAASS4DXDDVjC2zUHo0tK9FJRaH1nqR55Nwa+yDK6SpWGff6zLPXlm6O20Lwq5pTY0Q==
X-Received: by 2002:a05:600c:3d0b:b0:40d:5c99:7aaa with SMTP id
 bh11-20020a05600c3d0b00b0040d5c997aaamr84859wmb.4.1703603085372; 
 Tue, 26 Dec 2023 07:04:45 -0800 (PST)
Received: from localhost.localdomain (94.red-95-127-40.staticip.rima-tde.net.
 [95.127.40.94]) by smtp.gmail.com with ESMTPSA id
 fl25-20020a05600c0b9900b0040b3e26872dsm29121020wmb.8.2023.12.26.07.04.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Dec 2023 07:04:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Michael Tokarev <mjt@tls.msk.ru>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] docs/devel: Document conventional file prefixes and suffixes
Date: Tue, 26 Dec 2023 16:04:41 +0100
Message-ID: <20231226150441.97501-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Some header and source file names use common prefix / suffix
but we never really ruled a convention. Start doing so with
the current patterns from the tree.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/style.rst | 49 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 2f68b50079..4da50eb2ea 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -162,6 +162,55 @@ pre-processor. Another common suffix is ``_impl``; it is used for the
 concrete implementation of a function that will not be called
 directly, but rather through a macro or an inline function.
 
+File Naming Conventions
+-----------------------
+
+Public headers
+~~~~~~~~~~~~~~
+
+Headers expected to be access by multiple subsystems must reside in
+the ``include/`` folder. Headers local to a subsystem should reside in
+the sysbsystem folder, if any (for example ``qobject/qobject-internal.h``
+can only be included by files within the ``qobject/`` folder).
+
+Header file prefix and suffix hints
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When headers relate to common concept, it is useful to use a common
+prefix or suffix.
+
+When headers relate to the same (guest) subsystem, the subsystem name is
+often used as prefix. If headers are already in a folder named as the
+subsystem, prefixing them is optional.
+
+For example, hardware models related to the Aspeed systems are named
+using the ``aspeed_`` prefix.
+
+Headers related to the same (host) concept can also use a common prefix.
+For example OS specific headers use the ``-posix`` and ``-win32`` suffixes.
+
+Registered file suffixes
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+* ``.inc``
+
+  Source files meant to be included by other source files as templates
+  must use the ``.c.inc`` suffix. Similarly, headers meant to be included
+  multiple times as template must use the ``.h.inc`` suffix.
+
+Recommended file prefixes / suffixes
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+* ``target`` and ``common`` suffixes
+
+  Files which are specific to a target should use the ``target`` suffix.
+  Such ``target`` suffixed headers usually *taint* the files including them
+  by making them target specific.
+
+  Files common to all targets should use the ``common`` suffix, to provide
+  a hint that these files can be safely included from common code.
+
+
 Block structure
 ===============
 
-- 
2.41.0


