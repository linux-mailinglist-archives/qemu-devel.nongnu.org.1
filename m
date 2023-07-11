Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7362874EE00
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 14:18:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJCIO-0002vx-4L; Tue, 11 Jul 2023 08:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCI7-0002YR-W4
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:16:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJCI4-0005XL-Ob
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:16:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc59de009so58804165e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 05:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689077783; x=1691669783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VcrcmwVrf9RqawEoaPwEdVct9xbfPJK0OnI5Lpqm1Nc=;
 b=Z6H3XVApYUsoiVahdRvkpqixFsPKgEwv0DIbVUQ2jSL+/uoYZg/YW3hAJ89F6hIVXy
 PF4xAeJ7Mu+uuPxa0Inin37Fb66QoFc0Dgw96R2ahGL3SCvENVM/QVERC+Fcj5UJkNtp
 TrfA7L8sR9A+bC5GfJAjjEkcxTTuL6Q8kBs0LgvnF8N4tRyf4T44Z9qonQuIpJgXFPD8
 V1qjhXdVc0c8VNOn3m/pr9CRpd4j+WX9ml9nAwu1fIsZTvoHeuTfU+WLBYhSlo51PMix
 2nCOr0lGEPbROEaZ29StRePWudVvEJb97zE2b3Pz0aLNuADFGkdC/eM0DUogoKIougeB
 4k6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689077783; x=1691669783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VcrcmwVrf9RqawEoaPwEdVct9xbfPJK0OnI5Lpqm1Nc=;
 b=JkEmvZeLNAxWJL6+EALZybBkkAfXyvnz5otpKObyglyJICJ2F3jx6VAR04lLRnjTvb
 a/TYa18VOOmv1ZFcxVSEsR26fOK+st7yCV2CN789dv2ZCK1cOflkt9OpDbBNzzHbP5It
 fkjfGZolzqIyozBzlbIW6wpW3oFrK5oJWGE9YF0Pws6fjOMbIyUrbZWw4f/rnMkg7nlw
 PEmbZKH7nHYWf7cuttkcnK+4/cqyZSo+t3d9g8cweYoYWJwmpccMl3NdcoPvpxfjdwUf
 c4iGWFXGSs6QP+adrlnN84rwr2ocSQIzAdDHcGyIltb/fGESIV6aJDFqQcdIN5BGGyiH
 BL3Q==
X-Gm-Message-State: ABy/qLZdei41azt80bTfMbj3iIqQr/J70v6PPaV0WYQtwbnr2dvNdo7i
 If68DllTzJ5v5FIGrrUmPwx9pcou372fKh5vhy4=
X-Google-Smtp-Source: APBJJlGf/D9vXm9druRqZQcbn7V/sDfQGRh0NKiwjXYlfypMEbSiv5pBQiKavVH2ljx78m+i0OnRdw==
X-Received: by 2002:a7b:c019:0:b0:3f7:f584:579b with SMTP id
 c25-20020a7bc019000000b003f7f584579bmr13219185wmb.9.1689077782997; 
 Tue, 11 Jul 2023 05:16:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05600c220e00b003fbacc853ccsm2393095wml.18.2023.07.11.05.16.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 05:16:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 16/16] gitlab-ci.d/crossbuilds: Add KVM riscv64 cross-build
 jobs
Date: Tue, 11 Jul 2023 14:14:53 +0200
Message-Id: <20230711121453.59138-17-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711121453.59138-1-philmd@linaro.org>
References: <20230711121453.59138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Add a new job to cross-build the riscv64 target without
the TCG accelerator (IOW: only KVM accelerator enabled).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .gitlab-ci.d/crossbuilds.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 84ff2f6d2b..e311744880 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -129,6 +129,14 @@ cross-riscv64-user:
   variables:
     IMAGE: debian-riscv64-cross
 
+cross-riscv64-kvm-only:
+  extends: .cross_accel_build_job
+  needs:
+    job: riscv64-debian-cross-container
+  variables:
+    IMAGE: debian-riscv64-cross
+    EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
+
 cross-s390x-system:
   extends: .cross_system_build_job
   needs:
-- 
2.38.1


