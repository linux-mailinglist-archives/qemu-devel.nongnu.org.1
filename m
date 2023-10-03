Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A33CD7B6211
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 09:05:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZSj-0001H5-E2; Tue, 03 Oct 2023 03:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZSh-0001Em-Mc
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:04:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZSg-0008S0-7r
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:04:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40566f8a093so5530985e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 00:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696316692; x=1696921492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQzhyHwmNDSDi5pTVRLTrtcYFBIcSrpF9DmpQnEWx1k=;
 b=OZu6YVHbTb/BLaIqAkrLJ3FPQoYRKNqWtCi6B60qQJP7C3g+pPkR4sdPAOwk3TMcot
 jktTOEbq2T9V9PE8Jp0SNyWM+RWaaidIOpOCxGKIyKVJtz5P1ueYqU6jF7PsbpOjT/HV
 SVQijkb+JVCqROgSABcyqdhM1zkUJGmiJsC12YSnqOnWGqH/4mVkqcnI4JAOrOrTfv2O
 jaLhgif4g1GjFomSFnzPYHfeZn1pnZLOioqMhw8f31QBeV9evCe5K2Xvilf4viTtmlyf
 KwWa7BhFP7YW3qSOijbVOreedVrBPy/E/smLwnR2u5v/jtUZtHzriH53Fn0ntmpmtYaL
 9V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696316692; x=1696921492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQzhyHwmNDSDi5pTVRLTrtcYFBIcSrpF9DmpQnEWx1k=;
 b=c410nJ7tV3GLPkLtLlUnrJee1/QOQtzPsR2P/n4Lmcorzds3P4pEGR572D3SOSrEhM
 tCO5LsHE8vvfmza52yTOc/iodZuPJEUHWPIsHTssC/sWGC3cjaua/+DDfOP45jcIQPz8
 6sFTiLedKXTDj6SkomkLbhyg9i8xBinlsm5jIrwCTkDfv45YN0rPNSwGdKZyMWjxCrzY
 R9tOjb7Z9oFgZv0akTbgh85bQ7skMfJl9ozxSskCyQTFmati1n0bhIEEy3zp+TYYqzOR
 BLO0B3sgiAk+uWm3f3NjKeBZgF++pss1Ow1gifqFOOYRY49TC9aUdbIqJcZRKk945NQn
 svuA==
X-Gm-Message-State: AOJu0YzzK0LTHLf+VGyH12F/tPJqan8F/W8l5ReH09NbTP9GPtZkCqZV
 a2XtX5YjsIAtvE5IIC1MKW6P+4i1/cXiYl48vjAioA==
X-Google-Smtp-Source: AGHT+IH5gi/VEas+l3NNvHvsWgSkQlY/4YqInldrRsPk6XIBCqPemE3++yzm1NzvbAR+ZF3pEplFwg==
X-Received: by 2002:a5d:618c:0:b0:31f:eb6a:c824 with SMTP id
 j12-20020a5d618c000000b0031feb6ac824mr10944176wru.10.1696316692435; 
 Tue, 03 Oct 2023 00:04:52 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d50c5000000b003200c918c81sm813270wrt.112.2023.10.03.00.04.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 00:04:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/4] target/ppc: Restrict KVM objects to system emulation
Date: Tue,  3 Oct 2023 09:04:25 +0200
Message-ID: <20231003070427.69621-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003070427.69621-1-philmd@linaro.org>
References: <20231003070427.69621-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

CONFIG_KVM is always FALSE on user emulation, so 'kvm.c'
won't be added to ppc_ss[] source set; direcly use the system
specific ppc_system_ss[] source set.

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index 0bff3e39e5..44462f95cd 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -30,7 +30,6 @@ gen = [
 ]
 ppc_ss.add(when: 'CONFIG_TCG', if_true: gen)
 
-ppc_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
 ppc_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user_only_helper.c'))
 
 ppc_system_ss = ss.source_set()
@@ -46,6 +45,7 @@ ppc_system_ss.add(when: 'CONFIG_TCG', if_true: files(
 ), if_false: files(
   'tcg-stub.c',
 ))
+ppc_system_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
 
 ppc_system_ss.add(when: 'TARGET_PPC64', if_true: files(
   'compat.c',
-- 
2.41.0


