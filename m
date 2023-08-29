Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EC078C972
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:17:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1Nn-00052H-K3; Tue, 29 Aug 2023 12:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NY-0004p4-D4
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NP-0004PG-PA
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401d10e3e54so14428005e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693325732; x=1693930532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GEwqqGD6lwuTZz4D+67GaWk3Ul1LFarK634KRjfE2c=;
 b=cw+YPilqNTOPDy2QcgniekMAJi9dZpoGNYDsCQ/s4m5nosMOFu0Yr0nGrmYz5DlTFl
 XyYdJlAbwR/XTy7Gnik8u5/qF+zYAk2Kqgs5Z4o2lBOlrsBjJHZmwpK80EEnO4cadUxU
 VqjIKvq5ZjMDtExlPOl2hchFEUWNy3RY5EcO+kjw9EClGyoR9IaoX1LAEZS2Odm8DVc9
 rDy0uIARoGzmBFmOlRTcq6IGe9bmZmX413Eq8/tXWdr8dINtKvjYyoShWe23Oyw1QS6y
 Z0GDpebYQ2DeA+bbyt91WLU00jwmXorjB+O/tjzj+AKM6n3ryRZGIBcERYs0lNEMiGSL
 hk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693325732; x=1693930532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4GEwqqGD6lwuTZz4D+67GaWk3Ul1LFarK634KRjfE2c=;
 b=l34R7GP6PbiL+EISHinld99n1WcPyC9FvKzDTC/HjxMOGZZX958+QElBCdM1FuoBN4
 xQlmcZ5CXedoQx5LEVg3XwL44zhfX3nXiAAsAUSxE8xf2zVE8Ynyji0wae1ZS6fsqGJ8
 /D/aO2ZpxuwfERlorcND2UYlD5eeMLM7Cqvto/qJSvQ9bfgWBd5Yq9cc9M8hZJsdZOj9
 Rdu2FNC5ELZlaI1B2WZ78vWwB8CqsE55tTwMNWggPPRXWeHDbUWOlYn4NNhGdkncjUlX
 UJ86HC7wH8jP8y/I3eubVDaY2RInbxibOTnokMSQcLoHpzEUm+OyO8VRR2bbiPmlNijc
 TYlg==
X-Gm-Message-State: AOJu0YyAPJAn8w915Ry5tnvUob+fjGzDGz0IE13+0g6a/eiZRnyGooI7
 bgAr/4ed/IEiZudqEPycB9pQ/A==
X-Google-Smtp-Source: AGHT+IFuuBSw89fV6pTURv3C7CQSoKutwlukpxJYg+1Mm3pLuOszxq6hybiYBKqV3gvhTlqkIBjQfw==
X-Received: by 2002:a05:600c:1d1f:b0:401:d803:6241 with SMTP id
 l31-20020a05600c1d1f00b00401d8036241mr1580739wms.21.1693325731804; 
 Tue, 29 Aug 2023 09:15:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c260e00b003fefb94ccc9sm14326506wma.11.2023.08.29.09.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:15:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BEE061FFC0;
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
Subject: [PATCH v3 05/12] .gitlab-ci.d/cirrus.yml: Update FreeBSD to v13.2
Date: Tue, 29 Aug 2023 17:15:21 +0100
Message-Id: <20230829161528.2707696-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829161528.2707696-1-alex.bennee@linaro.org>
References: <20230829161528.2707696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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


