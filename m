Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A894822050
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 18:24:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKiU1-0003vL-SQ; Tue, 02 Jan 2024 12:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKiTk-0003rn-Fh
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 12:23:00 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKiTi-0007uL-AA
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 12:22:59 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55539cac143so6234707a12.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 09:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704216175; x=1704820975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5PyjOrlqLt2tikWKlViCXX5DS0iRmJvOYnTmLkzlec=;
 b=zM2Az9qFn3Vr6+dNOURPtoNPdFma5yJ8Mldp4jU7EPzCceDyVCPOq2LRCBwaJJ0eYp
 Pmf8MLerarz6+9o3dau+zqBD1ATbdNqb7aL68Ni6tDqvGHX14d3GCSqCUJybPhtbTfAS
 pr0onalQLaT9KkwjU93PNIU6u41qfrif1D8Ow4IPZiiGW130DimncjBWI+fn/K8zqDry
 eweC3F4g8AhYdul4OQEkpt48RuWS7dnBcoRQ/o04+w0D9/p79DCc59R5Jm1BFNO71ZRl
 /SnkCMS9iaBytQDoYUCdiTMSRbxVwwARO5Zu3Ichqh/vBaUMGgUwHKvIikJKbkPYpSYF
 QbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704216175; x=1704820975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c5PyjOrlqLt2tikWKlViCXX5DS0iRmJvOYnTmLkzlec=;
 b=GTv8tixhUnCUYGsiuhkER81OnOFScddbx6yMqRjxrOq8eI2gqK6aTNhGI3mXSFammZ
 vokz1MMVL1wCPnWErxEmHvxG6mm1JrSu8AIjAi6cNGGsopp2PgdbcntcVDoM1DD4fWeC
 JjCUYOb9X1AtX1hzaVvN/cD9kFoVEw++XhxwY3IOxbfSmzNTHBi3EU+ekEi/+Z2T7aS3
 0c/wQ5BvL/CrXiep0elZNUVUNT/vKAjKOBhpaC0cxAeP8hEL9fFJoeLAoZ9XHedZsRmR
 RVRuQnVKYTlDgFf39K3AG2dVP6C/H4ekdhenMwfe/hFcfrg+TId/wQxBQduFlFfg95Im
 9DUw==
X-Gm-Message-State: AOJu0YwhqeDlq/0yCZhKHc/ySVaGK47T0ez1WKTf5SwHzMRvQFA+lGoW
 ICH3o6LEZBcRP1jMrurj7mEVJCLyCgw2HX+OqBjhvTj8mbw=
X-Google-Smtp-Source: AGHT+IE6r/vF1oL4Rvqvx2mFrqOJytyhC0g5lGFpotPsKf4IIyu43xiUxzET8whHT71PPAhUBvzocg==
X-Received: by 2002:a50:d6d8:0:b0:554:4c3a:f7db with SMTP id
 l24-20020a50d6d8000000b005544c3af7dbmr10913987edj.28.1704216175697; 
 Tue, 02 Jan 2024 09:22:55 -0800 (PST)
Received: from m1x-phil.lan (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 u23-20020aa7d0d7000000b005533a9934b6sm16141640edo.54.2024.01.02.09.22.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jan 2024 09:22:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Beraldo Leal <bleal@redhat.com>, WANG Xuerui <git@xen0n.name>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>,
 Tianrui Zhao <zhaotianrui@loongson.cn>
Subject: [NOTFORMERGE PATCH 2/2] gitlab: Add Loongarch64 KVM-only build
Date: Tue,  2 Jan 2024 18:22:39 +0100
Message-ID: <20240102172239.69452-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102172239.69452-1-philmd@linaro.org>
References: <20240102172239.69452-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Used to test https://lore.kernel.org/qemu-devel/20231228084051.3235354-1-zhaotianrui@loongson.cn/
---
 .../openeuler-22.03-loongarch64.yml           | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
index 86d18f820e..60674b8d0f 100644
--- a/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
+++ b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
@@ -19,3 +19,25 @@ openeuler-22.03-loongarch64-all:
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc --ignore=40`
  - make --output-sync -j`nproc --ignore=40` check
+
+openeuler-22.03-loongarch64-kvm:
+ extends: .custom_runner_template
+ needs: []
+ stage: build
+ tags:
+ - oe2203
+ - loongarch64
+ rules:
+ - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+   when: manual
+   allow_failure: true
+ - if: "$LOONGARCH64_RUNNER_AVAILABLE"
+   when: manual
+   allow_failure: true
+ script:
+ - mkdir build
+ - cd build
+ - ../configure --enable-kvm --disable-tcg
+   || { cat config.log meson-logs/meson-log.txt; exit 1; }
+ - make --output-sync -j`nproc --ignore=40`
+ - make --output-sync -j`nproc --ignore=40` check
-- 
2.41.0


