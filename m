Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 780A87E1FEE
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:26:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxSP-00050j-Rc; Mon, 06 Nov 2023 06:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxSN-0004qB-0X
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:07:47 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxSA-0004ke-7s
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:07:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40839652b97so32718665e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268852; x=1699873652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cb2SoP+Kcg9QwI4B3FcAYm9BYCwnPa3WzQeoNeejBGE=;
 b=sai4HMIyAnrFf0oZS3teI+VLwm5Mc3UWHOc5U48mdqxZ0uReRE6l/dH0a4Fsx8Cyar
 1MliJ7943Hqp912l4o9JwiVt9FYo+ppGRw6dooqkY/maR2BwYltAuZF8+4xZXXxzX7TU
 u+VU5ieRsbx8DKr1VwVrh7e0uCRPStWm9RQGBcoIyh+0UqAX/G6j4lCW0U7nZfzzSqAe
 ErjAjQTMZgqmnVEc6Bld+KDah6M/iE7/+KND36UwmW0SC/mGh32iRMfOmuHAij3h+2fq
 u+x/oKFBBwHAgBE0XH/33nOgKcQdB5v9rwz74VpPnfP1T2xwAheXZaZuUaRFLsmgzS1M
 AbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268852; x=1699873652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cb2SoP+Kcg9QwI4B3FcAYm9BYCwnPa3WzQeoNeejBGE=;
 b=fs0Sh+dZxiZ0QCLgRAVcrHup93ItDu3AlWUMbQkW3uqs3Ai1NW3XZwDXUv9qcfKicd
 haE3MnzIPYJfRRXYEhmNEJwikPf47IeNHExd2YkKwZIZCpUIWQvHMPIIghyiFs0ckrZn
 EoYGA91WRWwg0klUb+xRsqTV2gmh6uhHWjPTIDb3DdA8zjfXtf6DMxv8gqQ5WG9xMEWR
 tytj0ZHHUVq5Cz/c72D6wRyfXAdYM5DuegUJoSdYGL64T12tIRASHePVpRdbQ9nAoOdz
 5WB5qjlG7ZtQDWL819NmMEdh+9UiuTTvQJsEeR95sB4DwckuEvNDkkK8UtvpQXBy3XMl
 yddQ==
X-Gm-Message-State: AOJu0YxKUU04bJNvgNwN/k4sjLk906Gfp14ECXgwmu1TBguNxIZqd7V+
 veb6rhi5HXnMsw82i4b4miIM02/Ky/Xt992HK9g=
X-Google-Smtp-Source: AGHT+IGOwGb19To8VXCdR8ERpA0kEx5JDBtiDEBtx2l74K+wLoipriHx1wrJrWcABU//cghRcbbU9g==
X-Received: by 2002:a05:600c:4fc6:b0:401:b652:b6cf with SMTP id
 o6-20020a05600c4fc600b00401b652b6cfmr23757960wmq.13.1699268851941; 
 Mon, 06 Nov 2023 03:07:31 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a05600c4e8d00b0040596352951sm11677086wmq.5.2023.11.06.03.07.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:07:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 34/60] target/ppc: Restrict KVM objects to system emulation
Date: Mon,  6 Nov 2023 12:03:06 +0100
Message-ID: <20231106110336.358-35-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

CONFIG_KVM is always FALSE on user emulation, so 'kvm.c'
won't be added to ppc_ss[] source set; direcly use the system
specific ppc_system_ss[] source set.

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231003070427.69621-4-philmd@linaro.org>
---
 target/ppc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index eab4e3e1b3..0b89f9b89f 100644
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


