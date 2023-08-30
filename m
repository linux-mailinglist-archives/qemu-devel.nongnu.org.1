Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C30978D6B7
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:56:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMaI-0001C2-VT; Wed, 30 Aug 2023 10:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaF-0001AC-Qg
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:15 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaC-0000jr-83
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:15 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31c3df710bdso4532304f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407251; x=1694012051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CAQcCHxhhzOkaK3t8ZyiVpaGWR3QfKLpmoXkKlWorI=;
 b=B5Ym9j3w+9mechIcDJ9NXZ0jO5Rwqv91eeXmwXk9SgFdUqtoz0zyNb/J7NwoSfNRqY
 VbYvhNGh0fuJbZVr902J/UtCzHdOPI8NuJalNbBDyaW/6wZhhMEyy5GztSGbkz8fn9tK
 xN0DJ8ARBHW7Aio39iEQnMYmEF/AoVwNi01LxbhOYgBjBpbBIiM0qFVSjAM17UD7wlOw
 EwsKS1OKd2coW5rvF74YS/8QkyloO6TQlNclB1Hjlp3ak5MkoC3Kh7doPeNv1kbcuP0k
 lp63fe9iL5LbQqx8wGwcaQF6UjYM87QY8H5X4DUuEDRIMDNPpIn3i5GbLR7gAwAu2S6i
 jhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407251; x=1694012051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7CAQcCHxhhzOkaK3t8ZyiVpaGWR3QfKLpmoXkKlWorI=;
 b=GpG4oKbY5E4MPRBO1vJ95BUge13QyA2zEu6rkwJjkXQ7FiJt2fd0tKVJr7/6n5175h
 vcf0yHwzBt+YTcKulBAl82IQhhhWSUQvQpkrphbtbPdqM5vAssskwJ+0TZZRo9P/D1vZ
 UFeWMxv/8MzP+sP1T4MbJYNqO/Py8uIPKMExCmVenZjTygGNVQLuh/s9dZYux8Nc+EOA
 2zcEaITkAlPmrSrbdbyGnp/R8P8wSFw8zhq2WLi3IH+3Xts6U+TxiCWRGXbJGyGY+xkN
 +MmE6B4S4i8W3EhgcsXkWGqXDnPCcB7fi13sHh4WMe9e72fb+VwzNyoT1YhmLrA6h92j
 JS6w==
X-Gm-Message-State: AOJu0Yxg2zOoN/YiXMEPz7dJl4jA2TqxSuTAzxENlcpBWeGSvQ5rd/Xf
 GDRr9v2LbtSJ5qmBZchIRgiJhw==
X-Google-Smtp-Source: AGHT+IFCiEyGALB38hp5uucJyGR4YcyqFH603p7Wp8Mq6i+4QG+GS/YgeWbhEdBhrpGJvQLsRAs7zg==
X-Received: by 2002:a5d:568f:0:b0:31a:d3fd:221b with SMTP id
 f15-20020a5d568f000000b0031ad3fd221bmr1784043wrv.20.1693407250857; 
 Wed, 30 Aug 2023 07:54:10 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a5d6184000000b0030ae53550f5sm16998302wru.51.2023.08.30.07.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:54:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 242601FFC0;
 Wed, 30 Aug 2023 15:54:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 05/12] .gitlab-ci.d/cirrus.yml: Update FreeBSD to v13.2
Date: Wed, 30 Aug 2023 15:54:00 +0100
Message-Id: <20230830145407.3064249-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830145407.3064249-1-alex.bennee@linaro.org>
References: <20230830145407.3064249-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Thomas Huth <thuth@redhat.com>

The FreeBSD CI job started to fail due to linking problems ... time
to update to the latest version to get this fixed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230823144533.230477-1-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230829161528.2707696-6-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 1507c928e5..41d64d6680 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -50,7 +50,7 @@ x64-freebsd-13-build:
     NAME: freebsd-13
     CIRRUS_VM_INSTANCE_TYPE: freebsd_instance
     CIRRUS_VM_IMAGE_SELECTOR: image_family
-    CIRRUS_VM_IMAGE_NAME: freebsd-13-1
+    CIRRUS_VM_IMAGE_NAME: freebsd-13-2
     CIRRUS_VM_CPUS: 8
     CIRRUS_VM_RAM: 8G
     UPDATE_COMMAND: pkg update; pkg upgrade -y
-- 
2.39.2


