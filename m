Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8631D787594
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:40:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDMj-0006Je-A1; Thu, 24 Aug 2023 12:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMh-0006Ig-SH
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMZ-00086f-O0
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401b3ea0656so275785e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692895154; x=1693499954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GEwqqGD6lwuTZz4D+67GaWk3Ul1LFarK634KRjfE2c=;
 b=p180aKlfum3DESaYhDrgyP0wmOAlWSN27rTdi5+nLzAXoXEosYSqJfFbcPGFEPeoUo
 URf9e0s9TyhJLe6ZO2Ki/uISr92JxQOGoMZ0qSkL6m1n1xrp0XnHqk/tDhBUxrDW6cJ7
 sd+rWAMvmyaFUjoGlZsNGI6zDdWlbyrBHDZyXxGMF1AfveuPUBwLDzWc7lclbqsCVqsM
 eN/7WC47TQSH3WUr51CSg1ZNFhz+NAzPJxASPjig+JTSzgJEIIs7ELXO5QmbC6P9Xroq
 cz14D8P3GDTv7yFcHC9GHalq7OL6DLM+02n/W7u0y7ewjMXlbNeWOc1oQgC2vUPw7aRg
 b7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692895154; x=1693499954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4GEwqqGD6lwuTZz4D+67GaWk3Ul1LFarK634KRjfE2c=;
 b=iGdLoxVkI5cLiutcpM3iODeSAtIo1EQ5toeplhCMNUGGRkzxV0Egy2M67auXDY7jBw
 bgo6c0GY110rS8UZpVA/lqEXjtaygFs+zoTP3ho+5Cz9cQS8QQDLS2r+1hY6asPty/Yb
 TADxYlIXWN+Wh+Cx3fMMbeXRU+KIQBlolCM0CftdYJmICxgKL+8KLR6Qm1o40Z47ayjK
 xX7OgR8tqMlZRz0OMSAOLpE6/bOpnK314/b8KhXVrRJZlMarX4zw8iPanfTq2E1WGAqB
 S3ArmMCrp8HwFTYC4PBqhCfJYmi09tPDgxm4aMt13AVQFjpDLckPm1jZvJUfmKJptBy3
 za8w==
X-Gm-Message-State: AOJu0YyJzUe9ydQRfzg8vDcGsEjzmk7N+RhZbhF2PkEetqLRcnD1TJYw
 Vn81BWoPXFw4ECfZcOw7K6EqCw==
X-Google-Smtp-Source: AGHT+IHVXmLkHsqk7rsfPrQfsxei49aGRrC+6J+UPz2jFzHnCmg/9leQKJPRA/hsx5m3NuRxnXYVIQ==
X-Received: by 2002:a05:600c:b44:b0:3fb:a100:2581 with SMTP id
 k4-20020a05600c0b4400b003fba1002581mr13163314wmr.14.1692895154412; 
 Thu, 24 Aug 2023 09:39:14 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c230c00b003fe24441e23sm3134878wmo.24.2023.08.24.09.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:39:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C22D31FFC0;
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
Subject: [PATCH v2 05/12] .gitlab-ci.d/cirrus.yml: Update FreeBSD to v13.2
Date: Thu, 24 Aug 2023 17:39:03 +0100
Message-Id: <20230824163910.1737079-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824163910.1737079-1-alex.bennee@linaro.org>
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
---
 .gitlab-ci.d/cirrus.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


