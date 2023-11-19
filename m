Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E9D7F0562
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 11:18:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4es1-0003CN-WD; Sun, 19 Nov 2023 05:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4erm-00038D-WF
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 05:17:33 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4erk-0005B8-UV
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 05:17:26 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-285196556fcso335957a91.0
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 02:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700389041; x=1700993841;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+5L02nXQHrhWgW8h3ky7PXJRSckRlBeH1hAu0xsoy88=;
 b=YQxQrxCaGFBjHFBniedw97WhBHCapAQe8KiCONeFWKVjrStU4HbZPeWI9wazK8SbdK
 oxBxDT/kh/VeSXLlPnVAsxZTEgaKVDR8zwLK+csMLmk4dm7uD5i1+Sc1XweAHXh39J7y
 g7VIN7EG2XFSYTEcZtj6cmBbry4zWks/gom6oO7ehiY9Ot0+mSSwPXUpHNm/1faWWgY8
 OUtPj0brV19+yOCeP6CtLSPPw8/eKpBvJnp8Euuwj6slc8vEFx+jl/xyvpIlAu5BOI3u
 kXFW+uPuubgmy8ORtpc9I72qyz9KDhg480qGOaKRA82g8NtUJ0wc3oMf31KpJDXlTIYz
 vD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700389041; x=1700993841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+5L02nXQHrhWgW8h3ky7PXJRSckRlBeH1hAu0xsoy88=;
 b=ChWCdUkSkQ4zFNJvueGwBojLj8aIqzyJsfcpYZL+0zWEU85K/8tL1NNK/Nsu1aTb7U
 8MU5uM3zjkYIN7ReKjelo9/Px5LbJ+wP47S4qYR6vHk6vI5d3qBj/kS5S5UID+SNTdK9
 W2z3u65Nj43boXeaybfMVxsx/a4yQG0AWUgO8NzfG8e7/qLdSVLZ7MDBXRlT3f59XZOI
 9qSbR1lcFFFKL4V96Ev+iaJM8QCkLiVx3OrDgJl1oCECh1tFqX8AmUufuiLiReJvUM/P
 gVWzlEZ4+hofzaCUcnzl1g7tSrnyhXFe9HbExLG7EwMS+BS5LjhcB2KqOxYKd8lAuie+
 Gsvg==
X-Gm-Message-State: AOJu0YzIxxLKNIFoTtLgHVA690YKVVTtBjtqTWPioMpk1TqHWO61C4fl
 TqwkE4jvsczxLelmDbcvWrfujA==
X-Google-Smtp-Source: AGHT+IF6k2Hq5c6Gmf54n8jes95PEIhFJx4GzNf58oFqouLAsk+xMcQWxZUMXQi7L7ECTtry6LShNA==
X-Received: by 2002:a17:90a:fe0a:b0:27d:853:9109 with SMTP id
 ck10-20020a17090afe0a00b0027d08539109mr3969400pjb.20.1700389041513; 
 Sun, 19 Nov 2023 02:17:21 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 d13-20020a17090ad3cd00b00280202c092fsm3866805pjw.33.2023.11.19.02.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Nov 2023 02:17:21 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] configure: Make only once with pseudo-"in source tree" builds
Date: Sun, 19 Nov 2023 19:16:02 +0900
Message-ID: <20231119101604.47325-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pseudo-"in source tree" build used to run make in the build directory
as many times as goals. Worse, although .NOTPARALLEL is specified,
it does not work for patterns, and run make in parallel, which can break
things.

Add a new rule "build", and let it call make. The pattern rule only
needs to specify "build" as its prerequisite and have a no-op recipe so
that it does more than canceling built-in implicit rules.

Fixes: dedad02720 ("configure: add support for pseudo-"in source tree" builds")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 configure | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index abcb199aa8..d73a9d811b 100755
--- a/configure
+++ b/configure
@@ -41,12 +41,7 @@ then
 # This file is auto-generated by configure to support in-source tree
 # 'make' command invocation
 
-ifeq ($(MAKECMDGOALS),)
-recurse: all
-endif
-
-.NOTPARALLEL: %
-%: force
+build:
 	@echo 'changing dir to build for $(MAKE) "$(MAKECMDGOALS)"...'
 	@$(MAKE) -C build -f Makefile $(MAKECMDGOALS)
 	@if test "$(MAKECMDGOALS)" = "distclean" && \
@@ -54,8 +49,9 @@ endif
 	then \
 	    rm -rf build GNUmakefile ; \
 	fi
-force: ;
-.PHONY: force
+%: build
+	@
+.PHONY: build
 GNUmakefile: ;
 
 EOF
-- 
2.42.1


