Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFE773EE3C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuFE-0002ZH-9N; Mon, 26 Jun 2023 17:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuFC-0002Xt-1t
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:34 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuF8-0004r6-Ib
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8ceso8165485e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687816769; x=1690408769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTHkiiEsGJjQzyOMxbcLNdH7rkjQKhZ4rW+u2UfYIYE=;
 b=A+Mfv9E4rUR1HCI7ba2cUzk7VUKCYbIWzmM+xo41K+TzesAzamKSzB9bZX1rNSDixh
 S5g2vycEzctJiZW5nmksQZTY9eBLAbxeXWiqaMVtjFioasIv/KP+AGdDF2u2vUZn3psB
 Q6gwYgJMwTRzbl1DDLIfzqkEJ9im5PUSwkhZ/hCuCVpqvv+SGE/2p6gsc+v8gYomz3mx
 hkOGorZHVOHs/vF1C+OtSKBUW6gC1EpU3KrCgoCiXkdngbs68VjciPp3hvvNb0VKPe2E
 Py4EufdzHj5T+9ImpgcFrRhzRGavRzm6/H5Nlev35Uc1sUP4cJBiFwdFQ+OeVxO/elvC
 P+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816769; x=1690408769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTHkiiEsGJjQzyOMxbcLNdH7rkjQKhZ4rW+u2UfYIYE=;
 b=L3OX2mJ3/vdXkgRUU8+Rg4dgeY9WN5Ndm7YNlAH10/UY5K804+1TO9NwNABNl6G8db
 Tfbo9U6PvKrWIms+nCTee+JwwS8pMiHVvUkcIkg28kQl9JFyehEU0eQ0dPKTTTc4AIQ8
 ssFfN+TgYFU6T7HxjbRceic7AnyeykHneGVPQMP5GUuiT7Ctrs1AqoNxOXApUpUeTnVX
 7ZwPzRDQT0fU0duQkaJBPeq5u8Hoj5BjIAHOi9wiQOdlKoqHeIot7kimGdGpIc876MQK
 CGKEQine5mHemuoc6kxMy8roV4PLZx9XSY/mukpnT+R00vVWvSX2oqCKWbD/PLT89kAE
 t5/Q==
X-Gm-Message-State: AC+VfDwWWPfgtITKZbE5o0jB91VfxiYfaVRVSPyw5M8rLDMldIIC1Gtr
 pdWyZag/xYiToPOZf2wdrqjBhw==
X-Google-Smtp-Source: ACHHUZ4f7DsAVNL1p/Gd5UN5mKmETs3rmK+Hg+2obZlKKtefCDZeOBaorrS9pDR3OI6KNSOeGBDe2g==
X-Received: by 2002:a1c:e90d:0:b0:3f8:fc2a:c7eb with SMTP id
 q13-20020a1ce90d000000b003f8fc2ac7ebmr21467501wmc.5.1687816769143; 
 Mon, 26 Jun 2023 14:59:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e15-20020adfe7cf000000b0030aed4223e0sm8419202wrn.105.2023.06.26.14.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 14:59:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A4331FFBE;
 Mon, 26 Jun 2023 22:59:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 03/26] gitlab: reduce testing scope of check-gcov
Date: Mon, 26 Jun 2023 22:59:03 +0100
Message-Id: <20230626215926.2522656-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
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

Message-Id: <20230623122100.1640995-4-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


