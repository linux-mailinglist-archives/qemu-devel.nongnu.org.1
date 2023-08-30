Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F3578D6B3
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:56:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMaE-00019X-Tv; Wed, 30 Aug 2023 10:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaD-00018p-Am
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaA-0000jM-Ud
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-401da71b85eso15324605e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407249; x=1694012049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8cg7lXi99py9TiXtzqC5JVNbbz3iUJEdseyNMZLjwS8=;
 b=jH1sPRJBNvm62X8el2msjoKnfgLwRH130boP4EAALgG8cc9cliNlKBjHaaleqS8FrT
 D6c/nItcm4nLTLEek3vsuTG8gESIiTFuT5UqTyDniEmmPv78OJA47rg3af8Jh5Jqa8+t
 +5yI88k2iTJDcUjS5zvTh4mmzPoLwNzY08XfnQ9+18224il4cnvl/GOL5JpJuFcYJvKH
 PefLkwajFdhtAOw9pqERIYGHU0mLPOBxbPzpJh7/dTBDODBEHd6b0M54q/cGiGDw6Z4d
 Fue7faVEDeD3evv4wU4oyqdrbmFO5pBm7hqG2KC+Y+qj667WdBIOOyGeYa/XQgIJNA2o
 Y3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407249; x=1694012049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8cg7lXi99py9TiXtzqC5JVNbbz3iUJEdseyNMZLjwS8=;
 b=d6mp69TyBmxFXkqT47w/mC0AusQI9x3erLbPkmBcjW5LicH4CTxktN/D8raoMu1GHL
 nfUKbqmavXZ8NQ0163TiXrLQZ5zmuFqdrJKrrFNWn9WjaojnXvxNMlL6Egj0m7hXeYJU
 w6Y933poXkrWnksb8FeL6vR8ASYff5OwDOSb/AdmQ7Dv+PE4sy8YTRigtj2U9F5VlQve
 4QwW99aSimQQJZmkmelzjuigcQEjfaeMayLAFI9+3qInEVE+791otS7VJxugHZzVbVdW
 xPdCq8PasfPvtxaUV4ZM05G6uImEhIu/qYvOs3dQSZl1KfBtuY+kkdkaZqaOP9VOlgp4
 i3gQ==
X-Gm-Message-State: AOJu0YwoH2p4mKTLHU9LN68+Qbujpu5NmaV0Bd4bMJED85WldqbkB6DK
 k8hcy1SoHDYbLj4yDobHo9tpwg==
X-Google-Smtp-Source: AGHT+IH/9EU/f3219IHvXZr74GlKohrBK8NMP+kvq+Mn4BAiFVzRnCwj8E9N6dGP07vxNZF8czJaIQ==
X-Received: by 2002:a05:600c:3b10:b0:401:daf2:273b with SMTP id
 m16-20020a05600c3b1000b00401daf2273bmr2329760wms.12.1693407248751; 
 Wed, 30 Aug 2023 07:54:08 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a1c7208000000b003fefaf299b6sm2514008wmc.38.2023.08.30.07.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:54:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D23081FFBD;
 Wed, 30 Aug 2023 15:54:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 02/12] tests/docker: cleanup non-verbose output
Date: Wed, 30 Aug 2023 15:53:57 +0100
Message-Id: <20230830145407.3064249-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830145407.3064249-1-alex.bennee@linaro.org>
References: <20230830145407.3064249-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Even with --quiet docker will spam the sha256 to the console. Avoid
this by redirecting stdout. While we are at it fix the name we echo
which was broken during 0b1a649047 (tests/docker: use direct RUNC call
to build containers).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230829161528.2707696-3-alex.bennee@linaro.org>

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


