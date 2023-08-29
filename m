Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB9678C981
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:19:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1Np-000564-Fs; Tue, 29 Aug 2023 12:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1Nm-000515-6g
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NT-0004N8-Qf
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31dcf18f9e2so1641417f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693325729; x=1693930529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zI7JCT8Y6EDH1PV9qo6Yd/dGahx6z15mbByhoBXxgRQ=;
 b=RfNV7JpGpTXLU4D803M+5ff/KJsHaquxIMZhbgjNLgjPHbd6h596//0IGv+A1rGzd4
 oYtRW9NL8HWN4Lw/ilaE9QcPy7ANgL02jS9RQcgj8YF1VZZLO0VPPbUGUHXGL0gpY+BU
 Srcj7IO2RjKFYGhyR1keAYGj9QbHkLyEW5X2vxbxA4gg4YuOJiDy+cudYCoHm1PW1VMq
 wonZ3Qern6C+P0aNKEN3UYH0D94NwrT8AfENT6X9JoRYWvOAqGziDnafpiJL6/sWpt1Q
 jQI6OJD1fmnCA+ieyf/YbOhtcwfdOh3X1EiW9TKdGAcaE3lOKW9PCphTf0WijISXdp+5
 9gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693325729; x=1693930529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zI7JCT8Y6EDH1PV9qo6Yd/dGahx6z15mbByhoBXxgRQ=;
 b=aC+ulwex1c/jSCyiimqKg14HaoV1zwd2F102ePhzr8yqed/98jjzcT6SAKlW1hJsiT
 NUyu9f4AkX2sG+64B17g4bKyx+uQ0mD7t5zA7koTnKn+orI0qynZ5NPS0nBxJF0149B7
 UY63zsHJXztdt89S/yPSOYagxjbDL53jSCmxu0iJgdiYpxMbgKYvgRiWyY+R6H7vwnvV
 t33nYvdRPRhg0v0yajbjRaGx+PMpU4CjuV6wxzNfeVq10r3yIkUqJJVSqrnGBsghJwei
 lGskQzo9EwgXuuxqsVG4v8mIn2ahB/AdCs2mxP2fDvQ6YUsxdCL8WXsvLKbXUEhPKrFT
 bcNQ==
X-Gm-Message-State: AOJu0YzxO5NxovwnbHyrCmPz906J85nco5Z86A+dRw4FORa1XVPiWItf
 JhFZtdOqiRsciTFyeDiwJhtyWg==
X-Google-Smtp-Source: AGHT+IFuGeZNM+oO+vMhd38UffW+fTdVXkUCoYbZ78BByNwXmXWaqIKV7lePNtI3iiPFg6DvB2GmuQ==
X-Received: by 2002:adf:f9c4:0:b0:317:5d1c:9719 with SMTP id
 w4-20020adff9c4000000b003175d1c9719mr24199159wrr.9.1693325729483; 
 Tue, 29 Aug 2023 09:15:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 21-20020a05600c231500b003fc0505be19sm14371693wmo.37.2023.08.29.09.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:15:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 747951FFBD;
 Tue, 29 Aug 2023 17:15:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Juan Quintela <quintela@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 02/12] tests/docker: cleanup non-verbose output
Date: Tue, 29 Aug 2023 17:15:18 +0100
Message-Id: <20230829161528.2707696-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829161528.2707696-1-alex.bennee@linaro.org>
References: <20230829161528.2707696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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


