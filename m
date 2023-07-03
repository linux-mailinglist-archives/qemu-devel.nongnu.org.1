Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84318745DBD
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJrO-0007wg-Jn; Mon, 03 Jul 2023 09:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJr2-0007TH-SG
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:38 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJqx-0005fg-HT
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:44:34 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3113da5260dso4920350f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688391869; x=1690983869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQVppiiyqsC0HGXhv0zk8KKZESG+1QKz8Jmvmi/GdQw=;
 b=IPQsgK7n209qs4XkB7Fd/G/Zdm8onghcBBOwRMlrUWz33Dl2FnUssZ7XscRAttVNJ3
 uNwBfU+ELwkdpSocInK9Dy0zjdh+qdkOVfgr2pzOfGzM0byLRuoUSrE9328enBdDERNf
 Fx/T1i2m45e4HY2buGXUNVyTSLFGdT8og9DuT0LrbTEBtm8Wp4D/hHYnM3qkX7S+vIMQ
 WcQOSSDO5/bRtjEvcgZNrvHPFR2pCuVHNkWnjkLO+sJ7th/OIPS6QOcVTuoF7YXBvk62
 W7C7Ul5zv6c3qYtVwgg3BF07Mj43oMGMa3t6S665OC+tpQE/G35UkLxfuD3M0dmvO6r1
 61kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391869; x=1690983869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQVppiiyqsC0HGXhv0zk8KKZESG+1QKz8Jmvmi/GdQw=;
 b=BiqNNgqBDskWfaPLu0Wg55FOvHfywsWOpTCiqS2vVBZFBdMnUeDiZ/r/UbPhA8zdc+
 q7fgtMUbn/78OmX8VJNfMG60aksuD1RZjnbWOCAmTQIllssmsa3FI8MhD4LaTYCL8yH/
 gaSLJj0xPqHN3y8XVyVWQ8h7uFAQ7CywgSToVXQp1zkklB2AyK6eLOe6rkBbU6xpfzCJ
 AqBoYEbEUTkXpvTLtbWAeFqImjU7ihEc/1U495OoJYpx5qkA7kH1KmWk5H8LtSDjC/GV
 zkMMMgl3SaxvgZvT1/7CcamRRYGiaV5QcxS6GvKO4XC1nZ7uo/z99V63c9CFKE1bv4YX
 mG2w==
X-Gm-Message-State: ABy/qLYdWS8xnp/oVVwSkYVcJVRqZAG7xZJptrEhECQjC+3y675E3Ptk
 tmxHaSdX0PZCJr+Ddom+0RVZ+2evPEqcr17tVfY=
X-Google-Smtp-Source: APBJJlFnpGSoqU2W61roIkWwsRja7jisWLp0D3KJGsLWnHjr6RhWXuRfQUrAQlyiRTudHWBHsgr40w==
X-Received: by 2002:a5d:4409:0:b0:314:152d:f8db with SMTP id
 z9-20020a5d4409000000b00314152df8dbmr7535192wrq.58.1688391869747; 
 Mon, 03 Jul 2023 06:44:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a7bc043000000b003fbdd5d0758sm990766wmc.22.2023.07.03.06.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:44:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 321321FFBE;
 Mon,  3 Jul 2023 14:44:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 03/38] gitlab: reduce testing scope of check-gcov
Date: Mon,  3 Jul 2023 14:43:52 +0100
Message-Id: <20230703134427.1389440-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
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

This keeps timing out on gitlab due to some qtests taking a long time.
As this is just ensuring the gcov machinery is working and not
attempting to be comprehensive lets skip qtest in this run.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-4-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index a8fd9a0c1f..77dc83a6be 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -454,7 +454,7 @@ gcov:
     IMAGE: ubuntu2204
     CONFIGURE_ARGS: --enable-gcov
     TARGETS: aarch64-softmmu ppc64-softmmu s390x-softmmu x86_64-softmmu
-    MAKE_CHECK_ARGS: check
+    MAKE_CHECK_ARGS: check-unit check-softfloat
   after_script:
     - cd build
     - gcovr --xml-pretty --exclude-unreachable-branches --print-summary
-- 
2.39.2


