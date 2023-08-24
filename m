Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF567875AE
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:41:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDMg-0006H8-Tv; Thu, 24 Aug 2023 12:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMe-0006E6-4N
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMY-00085v-2S
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fef4b063a7so36126065e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692895152; x=1693499952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zI7JCT8Y6EDH1PV9qo6Yd/dGahx6z15mbByhoBXxgRQ=;
 b=qEO8Zy1eDblNs9NDuEk3OYQj9FygmlkTpm8uwb5aHOZiRO3kxNIHNPxqZgKAD7iujV
 P5HDYEbcIcbgDDF/1v4Dc0g09sXQHq9OUmInVVbKeo/o32yR5yIfjLk9MNCWpy7lVX6A
 PxwQ+iTaf2M2IPXVYjECAbwbOjE5tDwLZfYTy9wFsi4AU552xRE3ePzNpVzwrKLrzd/Z
 DUbrwfi81dlYmMhq4+j1bSvTPUIlboRpM+xRqdcWyOun4fFcbPAFHqr+bxXARln19fMi
 MYyXMm4CRKHjPK2kdMISGmex39tjoJU1Oimc0tx+gdqwYFecyohV4c8TwmWWH0GB+/Vj
 BnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692895152; x=1693499952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zI7JCT8Y6EDH1PV9qo6Yd/dGahx6z15mbByhoBXxgRQ=;
 b=Yz5wFARx2naNqesn/RFkzJkafURnedGh2vYvb9LgVeAeXCaWR9dlaz7TszlmIXGme+
 ZGApvTxVVu2GPphwkoO39Fz7z89MPFTUNXMZ20hiJ9vLTiuHvs0cQ7Rj73c8O+nmEvnY
 6wQuSHRJGC9Eoojc+LmR1wwPeMOU4St/lUVKHXkB9vJL2dRa8vMxGWiqLhE0wFgwUs0r
 82Crxqix3hLu5cMmVwyfeCZD3qt2G+oFqpIlo8ddmJN3c48vDmCsXAJQIfHqQIUHz0Bl
 C61snltF0TC+5qLvTB0FrqnunWHARWUFJlLnNg9vdT8u0rIDoxQ6M7RYbae8M23jA+wX
 ycHQ==
X-Gm-Message-State: AOJu0YyrzOCRnZowj+AZVIQjA1UY31rW7NaLno5cRtb1HhDXqPz3qKt7
 fgL82at22KVdM7gMFygZstDEtA==
X-Google-Smtp-Source: AGHT+IEdb2Mu0HkvlMAz6j1D4/Dlvzip6d5JqDT6SsDNH2JNVMTpHCrsKDOaA4IW/3RuzDgQNl2baQ==
X-Received: by 2002:a1c:7c04:0:b0:3fe:179a:9eef with SMTP id
 x4-20020a1c7c04000000b003fe179a9eefmr12104116wmc.40.1692895152521; 
 Thu, 24 Aug 2023 09:39:12 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a5d4fcb000000b003141e629cb6sm22495847wrw.101.2023.08.24.09.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:39:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 74B061FFBD;
 Thu, 24 Aug 2023 17:39:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 02/12] tests/docker: cleanup non-verbose output
Date: Thu, 24 Aug 2023 17:39:00 +0100
Message-Id: <20230824163910.1737079-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824163910.1737079-1-alex.bennee@linaro.org>
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


