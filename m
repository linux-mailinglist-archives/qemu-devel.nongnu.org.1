Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 120DE80073A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 10:38:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8zx0-0003rZ-NM; Fri, 01 Dec 2023 04:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8zwx-0003os-0H
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:36:43 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8zws-00045m-Q0
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:36:42 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3332f1512e8so614315f8f.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 01:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701423397; x=1702028197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUg0v3uMioRQGt7KqmfkhZG/6jp+lM3qQiMuLIa+vH0=;
 b=oXDWf09RmiIRCVulq4DlBdwaRrYZJwRGXZLOx0TtXyLVLCIjtV+/M77fRVzhzwjWm2
 sF6ZU3+gtHGsP8GaMNRTkKNrHuYFMl7t/0HR3Q25MhdO0mvSDf2u+VImsy9RN/J4xDIh
 DFBqqsQvrxFzpQjZYKllBaT37m7/Lt7chqp49NkGXWTEnn3OEuHJE96g3Xy3n9OMkI2X
 DUC7OzxE603WGqDgoWGixdCQt9IOo1Sd/tNDMpmbEtfeaiY/FEDLaS4zDXbC1stsdQNX
 t5oZpAJWWF4R21HrGpvTx5X9QdYJPoekpb+F8rInNCPUIKniDD8lcC7U1TR7Uag0SwgD
 ieSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701423397; x=1702028197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUg0v3uMioRQGt7KqmfkhZG/6jp+lM3qQiMuLIa+vH0=;
 b=JXLwX6yOgp8kMHy3aIPVzPKNXWG1fItlPsyw0gqYkVmUr8YR3YsYApipU+OpYPTXBl
 yjhqlV/rZturcLvUvg7+TWmgVH99V/kpwnvnXU7X6c3hdIMN4x01uuA/LwSNmBEaL5cf
 nXXVhyOliWyQ1Fov6+s28XQ2irtEE+vU67nvUt1TByzXjtULB0xOFjKTNtfVcyN4NxNu
 f1i+fHBgRODnsEnoRUyrC0bguhMiRkamPRTbFOxwxMD3YahOhAuw/QFd+5nrzcE6ah8K
 Xn2a+vJul3qju3eMa5ig2a1PE8ilUklE1/LoXAf/2uPpP70uw+KHDQ8HxxmFJGwqO6u6
 bOzQ==
X-Gm-Message-State: AOJu0YyFUog4sXvmaOsPRIbpXo7SFk8sVLBsSnV28Va2E7JZ3eixJObC
 Hymes1LdcLLqoWz0JxzrJLdXBw==
X-Google-Smtp-Source: AGHT+IF5YpFIIVOQPIwqlm+Msp1gnNr9LAAmvo1rv7MRDucoWXwn5yVmSu5AMnlj5cKMS//LCN69pw==
X-Received: by 2002:a5d:5918:0:b0:332:c585:400a with SMTP id
 v24-20020a5d5918000000b00332c585400amr608471wrd.44.1701423397373; 
 Fri, 01 Dec 2023 01:36:37 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j6-20020a5d5646000000b0033307ffb193sm3716885wrw.29.2023.12.01.01.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 01:36:37 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7BB945FB6B;
 Fri,  1 Dec 2023 09:36:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Eric Auger <eric.auger@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/7] gitlab: build the correct microblaze target
Date: Fri,  1 Dec 2023 09:36:32 +0000
Message-Id: <20231201093633.2551497-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201093633.2551497-1-alex.bennee@linaro.org>
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


