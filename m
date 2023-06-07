Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5930E7264DF
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:41:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vHU-0001XI-2Q; Wed, 07 Jun 2023 11:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6vHS-0001WV-Ij
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:41:02 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6vHQ-0001zs-KK
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:41:02 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-33c1e7743b7so6235975ab.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686152459; x=1688744459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pa4S7jJz81Gz70anasGmPBYA2dZgq4FTivtkn/UEopk=;
 b=K3l/sVSEE2eRD4Jh88uqNsnFv9e0nHalEdMLrQLngLu630mYMimv1dytMb1mZHg6mD
 SQyjznxcl9DSC3DN4AJqG+0zpW/mMcOrRQuyrcN5yFNF1GAWTrJpvPxFtIIMsYU+v8CX
 ndqsP/1RwkIuBKkWh7iBF1gJCX/6aT1FzSZW2P2BI8OXJyqCtecpDG4FVWFQ/L0PeP4x
 rBsmEcjXEsB5MHNMHzdFuaqmdnD9RaZ6k0NCoXZFy0cOY1Mi1onymGparpYjk2z1JRxj
 SPbc+8x5LCzQ5Gm8hnEJ2CpHxexRivBrcOh9kYSerbWh+EkE6w0T+R5xWcb3KmjQgqsY
 SYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686152459; x=1688744459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pa4S7jJz81Gz70anasGmPBYA2dZgq4FTivtkn/UEopk=;
 b=Vo3mNAnkGvAqGOaP67K6rhkSeL1kmeOTWCH2J38kuxP7019enhUukqieXO7HHDK8lF
 gLPcuDNrgo7H3g8pCnIQHeZzMp9Z+iP4cP0LLBDAKeOB+GnznwUOeWFDTjtzwLfZjB62
 R1yL8KWIoP2lTh+Kp9JsdmuiITOyHl5z9GUdzMpqzdiQ4YEamEP8uX3CrvHBNUa9BFuv
 fQoD9rlf2VZdzdyfdm09QQRmqCup1KSEtQ1TofGwz1vT+STkWgWmDj+6X1DqtxmWRzcw
 sGvp6z+GRZRYB9pvrOWyRgZe6XP7k0T7oLdr1BF1xlMDzPqU8squPdpnBdAXmrK1a335
 LWww==
X-Gm-Message-State: AC+VfDx4qqzUMm/kqvNe/a1kDgrUQ6l7YyFZz0LJWvhRUcGHILT8oZjO
 1s3+7zE2RrfN9X8n9vLorfHLooglb3xUBHBZwqI=
X-Google-Smtp-Source: ACHHUZ6l/ZtwDzrUinSczSMlsxvhYLTvud1eHRUgkaAd30+cilp0x7MYx9FjCAWwEZryHh2gNdVolw==
X-Received: by 2002:a92:4a02:0:b0:33b:6cc0:ee6b with SMTP id
 m2-20020a924a02000000b0033b6cc0ee6bmr8464011ilf.13.1686152459512; 
 Wed, 07 Jun 2023 08:40:59 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:f25d:ffb3:64e4:8ded])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a17090a420b00b002591b957641sm1518066pjg.41.2023.06.07.08.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 08:40:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 4/5] gitlab: Add cross-arm64-kvm-only
Date: Wed,  7 Jun 2023 08:40:53 -0700
Message-Id: <20230607154054.625513-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607154054.625513-1-richard.henderson@linaro.org>
References: <20230607154054.625513-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12e.google.com
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

We are not currently running a --disable-tcg test for arm64,
like we are for mips, ppc and s390x.  We have a job for the
native aarch64 runner, but it is not run by default and it
is not helpful for normal developer testing without access
to qemu's private runner.

Use --without-default-features to eliminate most tests.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/crossbuilds.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 61b8ac86ee..1e0e6c7f2c 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -29,6 +29,14 @@ cross-arm64-user:
   variables:
     IMAGE: debian-arm64-cross
 
+cross-arm64-kvm-only:
+  extends: .cross_accel_build_job
+  needs:
+    job: arm64-debian-cross-container
+  variables:
+    IMAGE: debian-arm64-cross
+    EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
+
 cross-i386-user:
   extends:
     - .cross_user_build_job
-- 
2.34.1


