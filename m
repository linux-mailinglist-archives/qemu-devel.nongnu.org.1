Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B32F7B7B45
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:09:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxqd-0000mL-4M; Wed, 04 Oct 2023 05:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxqO-000089-0M
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:07:00 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxq9-0007Kr-2o
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:06:57 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31f71b25a99so1841234f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696410403; x=1697015203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KW0FErR7ELssAL8Eeq2tpDX3VFyHXdLlH6PwpSmbjt8=;
 b=yaAKmbYTt5A6XGmx32vDvgC0d/fj9lJU2txVJgzRys/KIK2OauLuzi/tbXj+nibQWz
 7v9Fi6IGDX0D7WaIweQBWbj9pN4/3TJBO81/fNA1LMGhQhrAToJr3Z+Dqbizv6uBaaDa
 TPbi1NBdb1BEamqE0aJosMVbHk2AAdKN5d7efFrmWPY2/N3RKdxFvSiXqZwJrPhJjl1C
 /QhMtHtZBdn2X7gFIjcG1ZdeuNxSHMMY069ySlCmK6/7PLxeBPGmYMx9tuzJbo3kHGuD
 U9rNGT6QwfTiwNR25qThtNoaMJJH10W/yJWWjuyjkFTPel6/Q798EqOcWRX70u9nfQad
 Ca0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696410403; x=1697015203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KW0FErR7ELssAL8Eeq2tpDX3VFyHXdLlH6PwpSmbjt8=;
 b=OR6UeL4XiJxK9BkyVBY9WYRsLTu0qB99cvNTEpuShTC6VAkiRsTqTmSGlKsxyTTGoV
 UzCX6gjZt198dbb7gWB9R0LWniX32QX4S+fuPOq/+t1ADU8hib2h10yMGNXMGxZUpNMo
 oYb5muKe1EZ2HMrLWbXAISuTgRSkWPL8U2RjEzk2vbtszzN7tna2/MA5YbPsa5lh0QAS
 sYHqJKofr3NJyhGfmom5GQUrrvhQ8K3PKaufkCtz5WOecXzVa+VRFw1/3CA/6eyKKTOP
 zva305bsQBKqHigArVzv2PfT9eNknBzCL/FOzZUSB0rtEzqoKGrg6gIIXH4aG5TlniYU
 xdlA==
X-Gm-Message-State: AOJu0YwT2jofwnHYL3o1ZaqLaCyhyM2Y3Q05NxfvDZp60cJ/yLE284EH
 uiec3E2PX+rIgy0NL1JFggUIk0GjsPWVp1GvSPA=
X-Google-Smtp-Source: AGHT+IG+f9X8fiDCU5jiCOaiu5Vl9cfEHkvdCPfGN4esmdsnG4SYojgqEzgjagAO0hCCXQprvL1b1Q==
X-Received: by 2002:adf:db09:0:b0:324:8839:cdf6 with SMTP id
 s9-20020adfdb09000000b003248839cdf6mr1551602wri.53.1696410403516; 
 Wed, 04 Oct 2023 02:06:43 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 e6-20020adfef06000000b003197b85bad2sm3520638wro.79.2023.10.04.02.06.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 02:06:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 02/13] travis-ci: Correct invalid mentions of 'softmmu' by
 'system'
Date: Wed,  4 Oct 2023 11:06:17 +0200
Message-ID: <20231004090629.37473-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004090629.37473-1-philmd@linaro.org>
References: <20231004090629.37473-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index b958eca5de..76859d48da 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -34,7 +34,7 @@ env:
     - BASE_CONFIG="--disable-docs --disable-tools"
     - TEST_BUILD_CMD=""
     - TEST_CMD="make check V=1"
-    # This is broadly a list of "mainline" softmmu targets which have support across the major distros
+    # This is broadly a list of "mainline" system targets which have support across the major distros
     - MAIN_SOFTMMU_TARGETS="aarch64-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
     - CCACHE_SLOPPINESS="include_file_ctime,include_file_mtime"
     - CCACHE_MAXSIZE=1G
@@ -197,7 +197,7 @@ jobs:
               $(exit $BUILD_RC);
           fi
 
-    - name: "[s390x] GCC (other-softmmu)"
+    - name: "[s390x] GCC (other-system)"
       arch: s390x
       dist: focal
       addons:
-- 
2.41.0


