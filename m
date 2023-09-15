Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DDB7A21FF
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:10:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhARe-0003Xv-Ld; Fri, 15 Sep 2023 11:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARG-0003Eb-U8
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARE-00029a-NW
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso24310385e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694790535; x=1695395335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l0mIdmdlmXswKm589oYcvupbnyEZRR+lBvL3XDXcnX4=;
 b=C9+a61VjONv3hLMulKsUUJ9Wxuuqwaa2PN+5O5pqY2k1I5B5f4lPG+lMNJS1JVSGlR
 GRTl/EsQUO4K2gFuqiM5cwINmZv+cSBm9frjSi8DjUIx3nRgSgyIr3JevSVWqNlcmZRe
 5i5GftgxZPwLB9Xi5ahbdeHeQV3X7Vifbfa+hm666Egy7xrqSQ0QKbEEJ8CFbToptYPV
 Pm446ZBAgr2giHyFLxhMBFhPdgwO2PYVoUcAXKsdjG1GSWCPXKybOBLZfvb4G08FzaUN
 z/LI0XQGizdjH446VVV40ooTBDMKfBqovJw0akLsy/MkOn/4ZZRHNFrXBygd+P3NroMX
 KD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694790535; x=1695395335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l0mIdmdlmXswKm589oYcvupbnyEZRR+lBvL3XDXcnX4=;
 b=JkyRwwTX95lxpfjTYCMnnqaRE3u88GSg5nvWtvXuWY87+lFtjNqXA+EUSioEEN78TF
 XGkjtb1m/6oapRrsAxMTnBI2egi21fncY+byXaKrOCQ42e6BdQV2pcKaRSsPL5CZms+L
 BA4sWS38+h2FcBpO0waEzCAFe9J3TSNJyouhV8eWHUOTwG2X2lOTp4CYvRCx1fhBnwoy
 hWl5YCsQJ4WHLZXP+r6G5T2/LKCEDTzO2Pd/aNzbyixpVYGxCbrSCaCe31nleEjmGxme
 xeqe7kEwMsJdjjrsaq2cE0B2swQNgI9hunT5YiW5Au+JQAJPioYRuzlBnrQqDTIrD1W9
 mLxw==
X-Gm-Message-State: AOJu0YwKVY17UbkVzB7DRD8PwpLVl8vkIl8JF/qGU5yZ96xUgp9c/S0Y
 CuonoZ64PeIs2SUveGC8cSZAjw==
X-Google-Smtp-Source: AGHT+IECXrTGTHUOetFMq9HbwvWy8UdRzu90bxlj6k3O7ITVG1CVGl4FPwiNxUB0uH/Zvqt7SzNEaQ==
X-Received: by 2002:a7b:ca4a:0:b0:401:c436:8999 with SMTP id
 m10-20020a7bca4a000000b00401c4368999mr2031176wml.30.1694790534932; 
 Fri, 15 Sep 2023 08:08:54 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a1c7914000000b003fe29dc0ff2sm4927349wme.21.2023.09.15.08.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 08:08:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AAC231FFC2;
 Fri, 15 Sep 2023 16:08:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 7/9] gitlab: make Cirrus CI jobs gating
Date: Fri, 15 Sep 2023 16:08:47 +0100
Message-Id: <20230915150849.595896-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150849.595896-1-alex.bennee@linaro.org>
References: <20230915150849.595896-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The Cirrus CI jobs have been non-gating for a while to let us build
confidence in their reliability. Aside from periodic dependancy
problems when FreeBSD Ports switches to be based on a new FreeBSD
image version, the jobs have been reliable. It is thus worth making
them gating to prevent build failures being missed during merges.

Signed-off-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230912184130.3056054-5-berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230914155422.426639-8-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 816d89cc2a..e7f1f83c2c 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -19,7 +19,6 @@
   # as there's often a 5-10 minute delay before Cirrus CI
   # actually starts the task
   timeout: 80m
-  allow_failure: true
   script:
     - source .gitlab-ci.d/cirrus/$NAME.vars
     - sed -e "s|[@]CI_REPOSITORY_URL@|$CI_REPOSITORY_URL|g"
-- 
2.39.2


