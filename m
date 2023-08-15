Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B396977CE7F
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:53:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvOV-0005mW-0T; Tue, 15 Aug 2023 10:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvOT-0005lO-0z
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvOM-0006Fi-7H
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e8c4so50627485e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692111088; x=1692715888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqn39QxMs9aLTyxsVNGDWvzJYuuXaaxbNOeSMjBfXiY=;
 b=FDbUbCvGPy4nyh0kTR3uFhAv59rJkeoq5X0aNLKdNhrEQlQwBq6OqFKGywaCRtnTrS
 h7WH1sO9m4IxN8dob7+ArUZTitDbJL+YS9LDZiiv4/lfp608xWp1JK5DiLlsTansjPZ+
 +skAtIRULH658sSEfND5GK/CAm98pr0ZiBA7wYHjKLj9pPpyv87ig+7qi4WIHlQiy8eo
 sITsi3tcOU6K4ATQItV4my08GIZo+//YtLk+5DtRAVNMebmpDvUwMvny1e8jaBuC63Yj
 vkzuOvichtWKY34FeMCsZ99hsesAqofUq0hxUurXB1oY0DImYrPkwIjE/8wAqGiVhFdV
 /Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692111088; x=1692715888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqn39QxMs9aLTyxsVNGDWvzJYuuXaaxbNOeSMjBfXiY=;
 b=O5uYSyhuobdeY5d0MK+z8LuotO8gtf8bChIrE0eBpoz8H7W3HQTlyyFPvbVk7SIrGr
 1+Yh3NWdUiMrbwtfNCDAAcWcyF3vzxLkX1X+QPiJK+5vV4naV2264qdJ/VaK+Kd0BuQ9
 z5LzywJ9WlsPdbq/mza5haQLJOwgeU6Me92hGnvK4B1kkjtr/A8/3fVp42AUePq9IE1n
 a7gEig8bkLHUTgZ2JSfjzIC+k8d5N/5XxoYtuwnUA11/hg+nmAhQgPxQUhgeDVHPlSAn
 avaTSTtUz4lpWliWLOrcObvRAmlb4iFgfw2Aw1/Et0q4WQrQewgHAEn+LDTNo4iNBebi
 xQIg==
X-Gm-Message-State: AOJu0YwjXh2RlKJ0YR9toY9EFNncPXeY0OQFoFey7a4Nd6/1N/4/0Rti
 T0wFe4yZ94vht51VPRNW6tR/Ag==
X-Google-Smtp-Source: AGHT+IH0p/wrc02HDD3uI0OnCFVH5koi0Fwr35sOeTJRTejzgkh5LBLJNc0R7c24vRWGxIu9t44OJw==
X-Received: by 2002:adf:dc91:0:b0:313:e553:b858 with SMTP id
 r17-20020adfdc91000000b00313e553b858mr9712327wrj.33.1692111088112; 
 Tue, 15 Aug 2023 07:51:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a056000114a00b00301a351a8d6sm17931556wrx.84.2023.08.15.07.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:51:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0FDB21FFBD;
 Tue, 15 Aug 2023 15:51:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/9] tests/docker: cleanup non-verbose output
Date: Tue, 15 Aug 2023 15:51:19 +0100
Message-Id: <20230815145126.3444183-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815145126.3444183-1-alex.bennee@linaro.org>
References: <20230815145126.3444183-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


