Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C245774279A
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 15:43:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErOF-0000Tu-Nt; Thu, 29 Jun 2023 09:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qErOE-0000Tg-20
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:08:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qErOC-0004CT-3s
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:08:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc0981755so3232015e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688044126; x=1690636126;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dsfD/aIYtIgnf7oqZVro3YHSi2wJ1fCEXphESOXhvcM=;
 b=RzaW+G8kt4qSOcRzAxkG7sLurNxzwqMdSvgz4eD76N3hKJwsVUVOt3a+qQIy4DmANN
 Y6PcgOPxKSU1yez7xdWZ0KiQYmJLf69CXaN7veeMWjtPMfzYKGk2L/d/Y1VzeZCm4ZWk
 IaxExQGY+cPbvbJIPP7tsFCwnma65oIV0jHG+DW9uLeofrQsdTg2d9NHrTr360OsUAzR
 9Fq0ck3SIs5VPEQNjH4BPZyKagn+DvWA9jF78VFMhM6GUWXA3PCx6MsGCSeUyCIz2hof
 YxVoN6H8Lc3DEG7mcD3lk8jkLpW0JwMruc7LAH5n9NHwbw/4UDwbiqofs52WU7Ce+87d
 QdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688044126; x=1690636126;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dsfD/aIYtIgnf7oqZVro3YHSi2wJ1fCEXphESOXhvcM=;
 b=QfSoz19EfWQUxO7ynd5W+q0nm9bPMUHqiCQp5pdfKgW2p9GMNwrmkZ81KX3AH7oyLv
 P3b2kSCT7HZkgk+ow2kfzKWCFZXEW8/MAcFuNfWB0LNKRSNdF0rpTKbvJi51RQpbwHHD
 NJmRvyr0eDP1mkRw9HFHkI/JR0SIgbrnA3Y8U5H7sdlY0zT2rm61XkPT7Jj/yxpGofLY
 y7YZJI+boO+IouwbjgkYGM05Y5E4ElyohrH5xbv1rYwvo479T7alngKsnqctFjG7Sz3Q
 hiMnb2L/Xb/4Tn/hgEiXVWiqwLDWetAsm/Uphz2T6F1FJITLKEazAjJ4cSwN7MO/5FPR
 3EiA==
X-Gm-Message-State: AC+VfDwDGZfx/A13J7vhuN1nepnI10RKueXYOTwnDR+8iDqcXyVP9SbF
 858ibFb7Jf39fIAbj71riuWUhrOLmABFdMke523xarXA
X-Google-Smtp-Source: ACHHUZ6+MU4BzH8s2pXoWSBsmvibQYNP+V1z5S6UXAr9TbTTBbrsBIu9FBwbcweUbXXuu1ANpaPIZA==
X-Received: by 2002:a05:600c:214d:b0:3fb:a576:3212 with SMTP id
 v13-20020a05600c214d00b003fba5763212mr5598956wml.39.1688044126061; 
 Thu, 29 Jun 2023 06:08:46 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a7bcb10000000b003fbb5142c4bsm3009527wmj.18.2023.06.29.06.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 06:08:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH] gitlab: Disable plugins for cross-i386-tci
Date: Thu, 29 Jun 2023 15:08:44 +0200
Message-Id: <20230629130844.151453-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

There are timeouts in the cross-i386-tci job that are related to plugins.
Restrict this job to basic TCI testing.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

E.g. most recent failure(s),

https://gitlab.com/qemu-project/qemu/-/jobs/4565517825
4488: make[1]: *** [Makefile:189: run-plugin-memory-with-libbb.so] Error 124
4497: make[1]: *** [Makefile:189: run-plugin-memory-with-libempty.so] Error 124
4506: make[1]: *** [Makefile:189: run-plugin-memory-with-libinsn.so] Error 124
4550: make[1]: *** [Makefile:189: run-plugin-memory-with-libmem.so] Error 124
4558: make[1]: *** [Makefile:189: run-plugin-memory-with-libsyscall.so] Error 124

We do tci+plugin testing with an x86_64 job, so I don't think it's
important that we cover plugins here.  Mostly we want to make sure
that TCI *builds* on a 32-bit host.

Anyway, here's a pass with shared infrastructure,
https://gitlab.com/rth7680/qemu/-/jobs/4565547513

There might well be different timings on the project k8s hosts.


r~

---
 .gitlab-ci.d/crossbuilds.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 1e0e6c7f2c..b6ec99ecd1 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -57,7 +57,7 @@ cross-i386-tci:
   variables:
     IMAGE: fedora-i386-cross
     ACCEL: tcg-interpreter
-    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user
+    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins
     MAKE_CHECK_ARGS: check check-tcg
 
 cross-mipsel-system:
-- 
2.34.1


