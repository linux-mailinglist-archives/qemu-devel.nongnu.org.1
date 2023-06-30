Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2167441C4
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIU8-0008ML-5e; Fri, 30 Jun 2023 14:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFITv-0008Hf-DX
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:31 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFITr-0006xv-Md
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:31 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4f9fdb0ef35so3617114e87.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148265; x=1690740265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqhI0bkTQitTyq9xrsayX2zpGaZY5TkEhiP+M9bVqrM=;
 b=c08bKGxq0P+kwW4pJ0jqOdEMvS1ioDlM5/DzZcsqwJRTb6dG+Bjr8nNOvEqb07krRp
 UVuDAp42zIGgpTOjH2mWifzhWdzZ2mZgn3zGu58cvr5aJQ8RSAEnAR9MVFZulYV1JoMh
 KB++kVan/jQJbcoK5qnU6m6ykcL4uaAHSOvFY4ytTN16SbsTXxRtZ5PF6NzfPzMlph6k
 m3eo0qx8Zjy6bZQ81LAefKcVQN3yJ5H8cw8wtsDV6f2sX+UzoCl9XVt0ECSlmIKYBFZG
 s/xV4pp52ny7e8xrPyWZidKX3nRetzGyeSsZogfueZMDLsMwzpDFPtDW7RWyZ0S7bLQM
 6RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148265; x=1690740265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fqhI0bkTQitTyq9xrsayX2zpGaZY5TkEhiP+M9bVqrM=;
 b=hkLD8oF3PX8dAaJUusOvCeWUeS4viaWTtyaAVHSl9+MwSgyy8zCLXtRGqlLDMR/Lrj
 bu7Dj0tUDalqp0ZBOCMgLtbc7izKWJpB6pD+aHZ5nFj4rLLs8/VQ18KV1NLvGnKCo8nh
 CacI/mYT43cTqTjHdnAtbmKPsMUQOQB/99ip8AhDRnKLxLzjEFh00YW7fKKIRMX/Bifu
 gQ9/7oabfN3PZLmlIORmxT/QEGgIPLK26dDPh2LquceBrZJF+w7JgsJs1g1lwPmhfRHz
 eBtTgaxhRYIbt91goXtfBr9VkF+CqjNGWa7Aps23pHwg86JIMlsYWew4HexHnDAXrIPB
 LyxQ==
X-Gm-Message-State: ABy/qLaUTjHGMEyXBjJl953r/bbqbLdhIiA9bxUwTK4zQzh6kHNhSWqT
 TRw4BVfxsX6+79WeVNKhKim1QA==
X-Google-Smtp-Source: APBJJlFrMoGHXTnWV2xz3rTBdecSY7Neqs4AGS6DdDIZOL3cm+a1Ex2VARjXIcGEN7gAihrvgP7TzQ==
X-Received: by 2002:a05:6512:3131:b0:4f8:7897:55e6 with SMTP id
 p17-20020a056512313100b004f8789755e6mr2595659lfd.45.1688148265171; 
 Fri, 30 Jun 2023 11:04:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a1ccc02000000b003fa74bff02asm19430550wmb.26.2023.06.30.11.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:04:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4138B1FFBE;
 Fri, 30 Jun 2023 19:04:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v4 03/38] gitlab: reduce testing scope of check-gcov
Date: Fri, 30 Jun 2023 19:03:48 +0100
Message-Id: <20230630180423.558337-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


