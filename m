Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B677A0D99
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrXD-0007sg-Mf; Thu, 14 Sep 2023 14:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXC-0007sP-Dl
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:57:50 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrXA-0007d3-Qk
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:57:50 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bcb89b476bso21877711fa.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694717866; x=1695322666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dh8+LaQRQPmPlmPUdoCBAfz86Ho/nQrcFJbdDxanoB0=;
 b=C64I2qwSafRk4RtkOmEWuhwMN+vVjU56ZuW2XVVhEOLWcZFTMJgJXSbb/e4A66trow
 gQ3Uz1Tmk5qS9eogtd0YNfBz5gkJSLbV53skSeW2EPW/tpect0vS17N5Nm8Ff2F8sEnP
 HWPIRGf8WjNu/BVvIlPeSGqZm+nkPUGvaKSwSunDsR8DgYoQFEzOOnZSH1OO9zAPlWhY
 xk2xDoKLGNekgWfOQB5YkW201/KqnwVpbKWlDQMoFvGam+I8Qp87bcCCSMAuR1Y+VxJ/
 jHpbA2ox0qz1dwOwegfiob8qAoUZKVoCT+QzhILnqIPXKSzzdnF+NNkZD/TmBFHV3Zok
 ex5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717866; x=1695322666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dh8+LaQRQPmPlmPUdoCBAfz86Ho/nQrcFJbdDxanoB0=;
 b=D5A27cseDScVqaZZF/JMMvXjy7HXj7W/YU799S5+IrVFtku8EKL+TMN44XfsRKMpde
 Yrl1yfhEsQ3p3LRnf9HqhdnR+s0EYg/jDj1bXWKeccYz83YIMHQWAc813K2FdIV98mEE
 BkdnKlr2QohlRa85pz3cd2wdwTKdQRQqRCsCB/t6Eb8WLMavMwvj37Z4ROS57LUydFD4
 8JWx4AcXEJHcFPbJvPPjER74nW9pHiXR512jobJBk+Gh5lzPwce8rm+TxyCKMPfKVsL3
 UASIi/TCGBtSNEJ9nRgoyY9/a1CPYjfZwNJnPDwEWxMZol4/pfmPcmXTBObNcrsP+2l+
 Kwcw==
X-Gm-Message-State: AOJu0YzHTnFpZdzfvkhMebPdUvQux5Hc97Tr+SMT9Ao0dMcWdKvKpCpz
 lSn4W1BNOtXACOHu6pE51CW4CQ7CFrYrGTcNhlE=
X-Google-Smtp-Source: AGHT+IENqwwpP5sU+cDZK2nYF0CKO0oQIMhho0iZB262wD1FW0LHcCWWNmzAHRHWV7kk7+XA+S7SFQ==
X-Received: by 2002:a2e:990f:0:b0:2b9:412a:111d with SMTP id
 v15-20020a2e990f000000b002b9412a111dmr6442567lji.42.1694717865804; 
 Thu, 14 Sep 2023 11:57:45 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a1709067e5200b0099d798a6bb5sm1358420ejr.67.2023.09.14.11.57.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 11:57:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/11] accel: Make accel-blocker.o target agnostic
Date: Thu, 14 Sep 2023 20:57:10 +0200
Message-ID: <20230914185718.76241-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914185718.76241-1-philmd@linaro.org>
References: <20230914185718.76241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

accel-blocker.c is not target specific, move it to system_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/meson.build b/accel/meson.build
index 638a9a03ba..76f3cbc530 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,5 +1,5 @@
-specific_ss.add(files('accel-common.c', 'accel-blocker.c'))
-system_ss.add(files('accel-softmmu.c'))
+specific_ss.add(files('accel-common.c'))
+system_ss.add(files('accel-softmmu.c', 'accel-blocker.c'))
 user_ss.add(files('accel-user.c'))
 
 subdir('tcg')
-- 
2.41.0


