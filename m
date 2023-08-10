Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 546D4777C63
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:39:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7iT-0005II-CG; Thu, 10 Aug 2023 11:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iQ-0005EJ-RD
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iN-0003DQ-N7
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:46 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-317f1c480eeso985693f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691681802; x=1692286602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KrI0uKRluPvPH9UgmpgsTWgL+pnARwaqZASSAgNcoKA=;
 b=Q2gEd4vmUE7OAkpqggQle9I1UxlYKkvMhmEftWJC1/HNp3a95Zyw4SvNXU3G25xUIZ
 AaqEbfhhOg2awpbpiVmVdkFy21/NGj23VL/Mu6L9xvflA6SfKCXQ4FFtBmtxeLsWYgPf
 CvwMcds7E6rAuC8k/AByq48ir46GoqfGQnj6bZsrDThwMq2TD3BPyZN98wiykD97K3YM
 MO7XXkK2EJ+KqDBwiIETSRYGF+t6GRkV22NuQZP2hctPvoTi/gDqnyvIWQLPZzQAwGxm
 F4zkAAbOJlb2S45wNdJlnVt4U0U+4/b14y5BPCntHhv9HW6qd9bZcpxN2/xgfYDvueSU
 Yi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691681802; x=1692286602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KrI0uKRluPvPH9UgmpgsTWgL+pnARwaqZASSAgNcoKA=;
 b=C1R/a1bFRYpdI5IeW7DGGCEaMBDEw8a+bRfY/AJ0vUyNsy8yZ9k89qEq71sjTUpxGs
 fUntevmmNW4Lpz6Lzwgj6apQ6boCEACONsLBSIvwbOU4Kd1LoMHrPHe5q/pz+5Ui85bD
 Vaqt/By3Eq1TOyN1kOh7lAewwbOPeRXMAOVRS9QqOoMH18enspwO0p/mrhSsJc4dLn+B
 KEmLFD+slL04Q11E5HRV0oTD2AxNc6EepH8Di4mappWrgu/3eTJXxZUvn3DdA3b2BxLP
 hhUoMvu7SVJVXWMeAVYsOegMtKl/q0yjWp3tnB2W70MJB30Eoo8NDFeSsQku7No7bJfj
 n8Rg==
X-Gm-Message-State: AOJu0Yy6xUbnaLkwkgfyKkgcfJ+qsgODK2FSZ6Ph/cPfbEiYBl/9UNKX
 fQWCmXmVcxzkyp3c8nkyEM37dQ==
X-Google-Smtp-Source: AGHT+IFjGgpE1k6qPujba0Sx2Ijvuwy0cc5cDF7uYfChRPfTf7vxWEY32sM/7ga8BCw9Sg/3vt7/IA==
X-Received: by 2002:a5d:4090:0:b0:317:cff4:7357 with SMTP id
 o16-20020a5d4090000000b00317cff47357mr2294141wrp.20.1691681801988; 
 Thu, 10 Aug 2023 08:36:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d6b09000000b0031759e6b43fsm2564444wrw.39.2023.08.10.08.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 08:36:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EA76E1FFBD;
 Thu, 10 Aug 2023 16:36:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 2/8] tests/docker: cleanup non-verbose output
Date: Thu, 10 Aug 2023 16:36:34 +0100
Message-Id: <20230810153640.1879717-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810153640.1879717-1-alex.bennee@linaro.org>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Even with --quiet docker will spam the sha256 to the console. Avoid
this by redirecting stdout. While we are at it fix the name we echo
which was broken during 0b1a649047 (tests/docker: use direct RUNC call
to build containers).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 142e8605ee..dfabafab92 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -46,9 +46,9 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		--build-arg BUILDKIT_INLINE_CACHE=1 	\
 		$(if $(NOUSER),,			\
 			--build-arg USER=$(USER)	\
-			--build-arg UID=$(UID))	\
-		-t qemu/$* - < $<, 			\
-		"BUILD", $1)
+			--build-arg UID=$(UID))		\
+		-t qemu/$* - < $< $(if $V,,> /dev/null),\
+		"BUILD", $*)
 
 # Special rule for debootstraped binfmt linux-user images
 docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
-- 
2.39.2


