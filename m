Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB10800E30
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 16:14:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r95Cn-00053w-JG; Fri, 01 Dec 2023 10:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95C4-0004rF-50
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:12:42 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95Bz-00040A-DH
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:12:39 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40b40423df8so19504115e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 07:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701443554; x=1702048354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+4RIhvIWUcpCT7qUh814AJlZGLCqs4LOMeRimhH8r0=;
 b=fg2X59czmtDQxdrGIcVWNwFufWDX6/u5b0S7ERubPODP7cyt1YlbhlFPYGyPCkYieM
 FlhaqHaERwF98g0GVLDiTQclWzCAZoPqR6HpefsK8wMeqkHNow1EkT6ezLlT8GnCcrZw
 zo0mz6Rd10cvUYOCzfepmfbFvuU0teb0TjTrwGgDh3j5JHFuUnLpIKHbaiU4KQ+TYH5o
 d1QXzeXHud39iWcqnKLFDhFCK7n2i6xnhMQwv1C0Rwd9sutLY055LheLX0TcTSC0G1dr
 2Jk+7NeynbWtxUqbZe80U3kMRlkHm7ZZS6RAWdnjFPSDbofy3ifaW2MBHypnDRL6lLP5
 /BcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701443554; x=1702048354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+4RIhvIWUcpCT7qUh814AJlZGLCqs4LOMeRimhH8r0=;
 b=Q/xwIQ0AH2uxo1MG2+wdHKmRVp132jRlGKBRTQv4SNzBTRCnxfLihnDKV50v5ti/Fq
 /BEXLvPA9p0ZB+c5ff66BlAspNB8kGedisEdJIcYkeeSfT9DyL3lsdMIPHRlNxxhmQLo
 Z7E4AxzROh5PNLNbWI0I6JikuncfaksCT6+k3qSrnnEMqb/bkdx/0SLotHX3ea7aswUL
 caEDKjr63/iQ1HNQlp3pKzxXA7SqpBZ+H4MLbwhfBAJ9sdlCuCqdihDsZJDGjcC38y7t
 +xBclfA9akPl5XLFDzOrIEOnzUm1c4P7jDp++M8sRK4iM6ozyoULrDG5AAgUl2gVFvE+
 Rg+w==
X-Gm-Message-State: AOJu0Yw8eCqky4vTw9iTxHl3mzXyUk2kRZACsHXPGkT0rySR6Y50x6wH
 YL0DdTuyi9Z0NiEJSQ0lXzbKcg==
X-Google-Smtp-Source: AGHT+IH3EwFR/B2ezm6hg3FPVhAUZVDSRWwVPahZhRORlaZSAYWfKLdhcYGgjVsvuiD5HkXMYex+pQ==
X-Received: by 2002:a05:600c:2317:b0:40b:5e4a:409a with SMTP id
 23-20020a05600c231700b0040b5e4a409amr347344wmo.186.1701443553654; 
 Fri, 01 Dec 2023 07:12:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bg36-20020a05600c3ca400b003fe1fe56202sm5800283wmb.33.2023.12.01.07.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 07:12:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 568205FB69;
 Fri,  1 Dec 2023 15:12:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 5/6] gitlab: build the correct microblaze target
Date: Fri,  1 Dec 2023 15:12:27 +0000
Message-Id: <20231201151228.2610209-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201151228.2610209-1-alex.bennee@linaro.org>
References: <20231201151228.2610209-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We inadvertently built the LE target for BE tests.

Fixes: 78ebc00b06 (gitlab: shuffle some targets and reduce avocado noise)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231201093633.2551497-7-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 7f9af83b10..62b5379a5e 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -41,7 +41,7 @@ build-system-ubuntu:
   variables:
     IMAGE: ubuntu2204
     CONFIGURE_ARGS: --enable-docs
-    TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
+    TARGETS: alpha-softmmu microblaze-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
 
 check-system-ubuntu:
-- 
2.39.2


