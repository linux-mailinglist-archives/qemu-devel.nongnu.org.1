Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B51740062
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:09:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBDw-0000Ir-Kv; Tue, 27 Jun 2023 12:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDg-00009d-US
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDc-00056P-Kb
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbab489490so3609765e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882023; x=1690474023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTHkiiEsGJjQzyOMxbcLNdH7rkjQKhZ4rW+u2UfYIYE=;
 b=N6whGesPH7klh/0MAJIQ/977PbeomWSVI02jLAM5i+Me3dW499smPi7P2NSLCgQHqw
 zA6mvsPcklBe/AOiBfJ4QVmHg7TGRo84e5+yo2k87UzLpy6hs2QzCyfLEo50dufwh+Wn
 nfWaQ56CtEYc99IFj981I7zqfXj6xDaugXpeVsgzlgs/44+fBtXwGsqpQP6iLRnzvhxC
 h1XEYeth7Bmoz3okTx2ppkqHU9Jq3IpytWI9fN9m2lRdeJ3vziCOrn+6E8TQvrX8yv+Y
 8kmq5eqDPksBNYf/bgAFSZ9rHsgRwsLQnQCIUiy+KAFA77eLhdgvaqYu/7WYZaamDpft
 eK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882023; x=1690474023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTHkiiEsGJjQzyOMxbcLNdH7rkjQKhZ4rW+u2UfYIYE=;
 b=EnxREw98UhyjfDYe3rxlPGpeMs1pZ86xjgA4SWcg/uLZyXvwv6UNXxIAcHt/7kpvpu
 BppxOYBYOW0LXJdHY6M2yir0NvMCHLqoQgHbysESM7VysgomDvDmGC82mnY4NmGsjtD6
 dB8Az/L6+Bn3jfQrcIWUssLBQQuCJinFxorV0tYt/217dumwOKUcGiGg2YhouIT4YWoy
 lru9SLAMrOpEuzFSyTe3x01wdOaYhv1sAx0TpUwJ46gp/yRAwHYN8W0RgTzx3b++LVmB
 zlmp+rFr6ONd0acO45yshOGrkKKoSkGKlIiHa2NcrrOVgYC272DnaHOxk7ZXkOPjYWNj
 1pAQ==
X-Gm-Message-State: AC+VfDyRTW7iBi66ZVmGXT4YeGtdzNnpzSFxTQoZUyT3NECbTluVTXIa
 GQwKrugGUTC04rUWNg6GoIUclA==
X-Google-Smtp-Source: ACHHUZ57YEFIpzt3ZbaDGLDM3SPY7uXERhM8Lko35dj7odXw7/SP9inr/ywpbT5QpyrtkIhZpcUO8g==
X-Received: by 2002:a1c:791a:0:b0:3fa:76e2:e6d5 with SMTP id
 l26-20020a1c791a000000b003fa76e2e6d5mr12235133wme.37.1687882023113; 
 Tue, 27 Jun 2023 09:07:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a5d4c83000000b0030497b3224bsm10775476wrs.64.2023.06.27.09.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:07:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 28B171FFBE;
 Tue, 27 Jun 2023 17:07:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Leonardo Bras <leobras@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bandan Das <bsd@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Juan Quintela <quintela@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v3 03/36] gitlab: reduce testing scope of check-gcov
Date: Tue, 27 Jun 2023 17:06:27 +0100
Message-Id: <20230627160700.2955547-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160700.2955547-1-alex.bennee@linaro.org>
References: <20230627160700.2955547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


