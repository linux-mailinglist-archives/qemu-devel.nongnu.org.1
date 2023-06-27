Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B770D740088
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:12:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBGN-0008DV-UK; Tue, 27 Jun 2023 12:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGJ-0007uR-Ua
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:52 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGE-0005mR-Pb
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fba9daf043so5515065e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882185; x=1690474185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTHkiiEsGJjQzyOMxbcLNdH7rkjQKhZ4rW+u2UfYIYE=;
 b=s3oijeXyWscwSskEJei5yO8vQHamNrFbnc4RWKUxI5xTpvIGwgKQqudPcSJra4dNdC
 Q0UaiMi9R+lBpQM9qstTpNvwc3HgNmmveDqgVlh1yFhuNO8Jr+2nL3wu7RrLiS/aaIay
 jE2IMz/H1AJ/BMyGbfw+Xc+m2gRq40nlZsmKBUrpGembZd2Gqku4zerEHI+dyZRML8or
 R1UyVBx8zfxuscVeyztoFy4waX5DuXjj09qHpANQH+NiLVmJvni9xNlLzY61eiBf5cD2
 t2f4wMNuDmy2U6VJCjboyNTB9W4wxuZDkUUVwCnh/D92uLBX45T4vLZ8yXlpzYUixPhQ
 attQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882185; x=1690474185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTHkiiEsGJjQzyOMxbcLNdH7rkjQKhZ4rW+u2UfYIYE=;
 b=SuzHxsPn6wyNAK6cmHIprZr9gybO7nYA4KK/IC21C6vATX6HcLD6QmmvO1/LffxvDA
 9qtgJV2e1vcMd9GRUgfLJaeSQ1h4dmuwPuKmzp1q7+iV/pxn4+G4ge6DYeOGiENtBQYE
 5R9C4sXK/SbCrpTQglXZCPuDQZEUlvjc4CC517jjE/msGMGlwgtbTRNq96XDX+kGuUcb
 dNncIJnq1Vg1QY0VsZDoLegXj4wVXzrri94zmKgYRK2Vq8cCjjublROT7Sz/nVfymB4K
 saIKfZR+s3LvhfKooPK94Zf2hIRibl0GVgfKzF43W+nEmGHSzgPxqqU1YEwETzhfaWJp
 n3Tw==
X-Gm-Message-State: AC+VfDwGJXpLDRSPfjuP2D0TnA3KrkyvJbqMSE16a7yNgxvNUFUdZsub
 66SJXZ8ipyj8BzMDtbP0pUaXIA==
X-Google-Smtp-Source: ACHHUZ5NebUVfFZuLcZwrBaykvgFxUo56mFzHZGkIfRlZ+Wpxrzi01gAA4taV86almTYXjx8SQ7I8A==
X-Received: by 2002:a7b:c8c9:0:b0:3f9:b955:5584 with SMTP id
 f9-20020a7bc8c9000000b003f9b9555584mr16630166wml.34.1687882185356; 
 Tue, 27 Jun 2023 09:09:45 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a1cf70e000000b003f9b2c602c0sm14205358wmh.37.2023.06.27.09.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:09:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 403BD1FFBF;
 Tue, 27 Jun 2023 17:09:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 03/36] gitlab: reduce testing scope of check-gcov
Date: Tue, 27 Jun 2023 17:09:10 +0100
Message-Id: <20230627160943.2956928-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


