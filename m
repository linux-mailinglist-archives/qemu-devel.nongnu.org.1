Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CC9735CD6
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 19:15:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBISk-0003KQ-Op; Mon, 19 Jun 2023 13:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBISg-0003JY-N3
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBISe-00024n-Sj
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f900cd3f69so22395185e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687194879; x=1689786879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJ0znkPd7OGWQQPw/921rAm+F3I/XIRFyJEm2ABhTJI=;
 b=qL/MNiPzmpekrEJAYtxE56Jm0hU1bTxS+cDv0W4RQud8CV0sNUBe0MmUWF9tE+3M3S
 EC9Q08/99QFqLX/42ECbCZn50vmZpFqDA9ZE7pJGX2cAX6mznkDFnNUWdPP3UtVCQdKH
 BP0nBqrloVP9mXaBqySP5M+Smw0gYTASAbqYA72qAzrck76NRvttnrPwzJCaCzDcY15h
 6AhODXVHCPFKbgwGA9eGUho2xSekxHjFqdt1TnGpWkBQWO4/jOwkDE79CFryC9YEL8sg
 cpwm+gHqO7t4WETpTKJDIAo17ldF0O8uwwbsS0pvHM6ucuerkujv7LlzabIgAL24gRIl
 JLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687194879; x=1689786879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJ0znkPd7OGWQQPw/921rAm+F3I/XIRFyJEm2ABhTJI=;
 b=UW9SsWlVOxv15HGGTTJHZfl/4C5RtfB+MBPnbt2TpzuVoxe6vqKWBTg590PLI2WWCl
 kGpQULHJq6IZAq9tZOc5vZqDf2qjgBu0rBKxtxyp+Ri93cRR8i3iFOxxgTaiwcQDYbFM
 4EQqBaut7ge579iTbXLdKlUx25LqsjcHyZ+icPWQXt9abTMpssVpR5FAFGQcddncHuLw
 6wfPxh9TcL4wbxkZs1Y06PAlQISuiFlvFUJVi2hRSbED5uDjudnBqA4wTUPHJsKK/2Kt
 G9yHAgBOXKnsapyZiQPiOZebSX5e8meJ+OrD0nrLDqw9idvY/FjCIS0+n7ROE1vksNub
 tsWg==
X-Gm-Message-State: AC+VfDzSYQqU+v7QtOAIwI/629OO2gz04XPVjgxHVquyZ3PQMwHOIkxf
 51ZKnqRK44fdD0GOIkBy3cYufQ==
X-Google-Smtp-Source: ACHHUZ79hOK048U9FmiD8UxmjFic+gzr38SXhRDhK+IvAFjDHfFBRTcwt+S/0EYLrKvoz6BgSHFKtw==
X-Received: by 2002:a1c:f70a:0:b0:3f7:34dc:ed0d with SMTP id
 v10-20020a1cf70a000000b003f734dced0dmr7243948wmh.25.1687194879247; 
 Mon, 19 Jun 2023 10:14:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p25-20020a05600c205900b003f9b1131a90sm252645wmg.23.2023.06.19.10.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 10:14:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7B6031FFBC;
 Mon, 19 Jun 2023 18:14:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/5] docs/devel: add some front matter to the devel index
Date: Mon, 19 Jun 2023 18:14:33 +0100
Message-Id: <20230619171437.357374-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619171437.357374-1-alex.bennee@linaro.org>
References: <20230619171437.357374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Give an overview of the most useful bits of the devel documentation to
read depending on what the developer wants to do.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/index-process.rst |  2 ++
 docs/devel/index-tcg.rst     |  2 ++
 docs/devel/index.rst         | 24 ++++++++++++++++++++++--
 docs/devel/tcg.rst           |  2 ++
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
index d50dd74c3e..362f97ee30 100644
--- a/docs/devel/index-process.rst
+++ b/docs/devel/index-process.rst
@@ -1,3 +1,5 @@
+.. _development_process:
+
 QEMU Community Processes
 ------------------------
 
diff --git a/docs/devel/index-tcg.rst b/docs/devel/index-tcg.rst
index b44ff8b5a4..a992844e5c 100644
--- a/docs/devel/index-tcg.rst
+++ b/docs/devel/index-tcg.rst
@@ -1,3 +1,5 @@
+.. _tcg:
+
 TCG Emulation
 -------------
 
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 09cfb322be..8f7e3dd80f 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -2,10 +2,30 @@
 Developer Information
 ---------------------
 
-This section of the manual documents various parts of the internals of QEMU.
-You only need to read it if you are interested in reading or
+This section of the manual documents various parts of the internals of
+QEMU. You only need to read it if you are interested in reading or
 modifying QEMU's source code.
 
+QEMU is a large and mature project with a number of complex subsystems
+that can be overwhelming to understand. The development documentation
+is not comprehensive but hopefully presents enough of a starting point
+to get you started. If there are areas that are unclear please reach
+out either via the IRC channel or mailing list and hopefully we can
+improve the documentation for future developers.
+
+All developers will want to familiarise themselves with
+:ref:`development_process` and how the community interacts. Please pay
+particular attention to the :ref:`coding-style` and
+:ref:`submitting-a-patch` sections to avoid common pitfalls.
+
+If you wish to implement a new hardware model you will want to read
+through the :ref:`qom` documentation to understand how QEMU's object
+model works.
+
+Those wishing to enhance or add new CPU emulation capabilities will
+want to read our :ref:`tcg` documentation, especially the overview of
+the :ref:`tcg_internals`.
+
 .. toctree::
    :maxdepth: 1
 
diff --git a/docs/devel/tcg.rst b/docs/devel/tcg.rst
index b4096a17df..2786f2f679 100644
--- a/docs/devel/tcg.rst
+++ b/docs/devel/tcg.rst
@@ -1,3 +1,5 @@
+.. _tcg_internals:
+
 ====================
 Translator Internals
 ====================
-- 
2.39.2


