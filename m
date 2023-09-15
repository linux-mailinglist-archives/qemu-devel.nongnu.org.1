Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 928BE7A2201
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:11:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhARI-0003EU-HO; Fri, 15 Sep 2023 11:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARE-0003BE-T5
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:56 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARC-000292-AG
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40472c3faadso20003475e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694790532; x=1695395332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ll2JCdzZBjak8Fv1H6Rw4JPUKwWAK7rZwdDw2TTprnw=;
 b=W1SMzq+SYBkvTQftcuHLUKoJDAbkdHNPUyy9R9fskUTlX0+lYbwBg0NFd3FP4/3ruD
 mMDq3QiJldne2NjSfczBmmyBydq8xjNA3nJT4CU0KuZo6DKula4kFnjFBueFa4UsJpZa
 klFBdXLSoQ/ZSWN+eMphGfrDBQbFzN8Wecra2Z57KnQCXZje24MsyNPRd2YOrIfXE0zA
 4mb6sEAjaBc/WLhda6L0TRvkwoq2VHSASLs6qG6K/JvXRZGl0rP3WgVghDMTnn7TvRHY
 DM5VcUZNW+CG+szP1prW9a1MTToHcjawMHfUg1hxyDktFBC7AiQLyMN47dg9utzDIviV
 Eebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694790532; x=1695395332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ll2JCdzZBjak8Fv1H6Rw4JPUKwWAK7rZwdDw2TTprnw=;
 b=Jin4s63REff9xL43/NGBGbhU0d0eRfzZCkFWzjAinhJtmKrUGNNrNLm9z1GlXv96Fw
 eVFz+QVDohBTTU67Miaqz5OuXhTvJ8EatVJUUDfoL9wbXb+CZrkDGoHWjWMgG+dFlC6o
 IfS6QEKHbzgRYw7glyEYuqXjjKlOQaAaIpXbcELo983zb6KO00j/1q/FnEmbt7fdTA4s
 F5hUYGnXR0sweO0KZ2HYLnap/zAJR1Pf9Iyje17lwfXCcsCFFvqHkH4JlbUAg+g1QJQH
 6dcQgluQoycuGCzvJ/smhHqQa716mAifXV3cQeXAoJKPXhTTSyNW33VR+YrGuNosdEKl
 JVmg==
X-Gm-Message-State: AOJu0Yy+ZQ1DIA/kZ29ygn9gDxuuQMVTV9DTkZozBOLbXeGYZ+MJ3kR/
 zBgdI9miTOp7KqmEprFlLSWGyw==
X-Google-Smtp-Source: AGHT+IGW9eAGe51zcRrwzRzdiyp63i5isGR7NrzRWsKp8+Vjic40fHidlCrpyjdYqSkOge0KoTuwMg==
X-Received: by 2002:a5d:5502:0:b0:313:eaf5:515 with SMTP id
 b2-20020a5d5502000000b00313eaf50515mr1536867wrv.6.1694790532698; 
 Fri, 15 Sep 2023 08:08:52 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a5d6b87000000b0031ae8d86af4sm4634863wrx.103.2023.09.15.08.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 08:08:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 314A21FFBD;
 Fri, 15 Sep 2023 16:08:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 2/9] gitlab: fix typo/spelling in comments
Date: Fri, 15 Sep 2023 16:08:42 +0100
Message-Id: <20230915150849.595896-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150849.595896-1-alex.bennee@linaro.org>
References: <20230915150849.595896-1-alex.bennee@linaro.org>
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230914155422.426639-3-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 188a770799..ef173a34e6 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -68,7 +68,7 @@ variables:
 
     #############################################################
     # Stage 2: fine tune execution of jobs in specific scenarios
-    # where the catch all logic is inapprorpaite
+    # where the catch all logic is inappropriate
     #############################################################
 
     # Optional jobs should not be run unless manually triggered
-- 
2.39.2


