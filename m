Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3992573E160
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:01:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmmG-0007K2-T3; Mon, 26 Jun 2023 10:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDmmE-0007IK-Ob
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:01:10 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDmmB-0008FV-6E
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:01:10 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b69ff54321so17129801fa.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687788065; x=1690380065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Gnxy0hWR1/A5L1cIpllCbYRoWI9TM+IkHpFErpq5tE=;
 b=R9iTzQKrLZN9EImzzrqs1FViq9Y3gKYXKx3PGMXZNwDBq0/Ax0COmtAzOgWSnLJY7i
 4dbtOW9+/JFNwBE6ASbAkUtitpGSuEV7UktDOGzlGS1Vqujoo+5iNYF8/ClFM4Q529TX
 bRjqCOOHkOCMSPsGGHp4KrMCfBImegcxgrem/U7eC5efux4N+7xOTLNsn4twUPHd+ey0
 mGgb6fx4vWx88g8KTpGe2ldYXzg3JiAGyCRU2WqLBHJM6Fsvgnof80lOib1f3XRI2Cis
 vlkDJbNpI3bydjH20flsjIIYUaO87/AByrM79LtIlOCe4etbx3ht5X0BaDq6Y2cMoTYL
 jKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687788065; x=1690380065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Gnxy0hWR1/A5L1cIpllCbYRoWI9TM+IkHpFErpq5tE=;
 b=AiQiT/Jy2b9O5lbcFUrpjaMwmwTcf8FgQzOiMX1WX0l2jX5XhRmRRs+PBVuqPED3LR
 eLEyb1uz/r3H9eqWSegVsPZYxpTTuWWCfq9P+yCLXQj5UXJTilBuGKbq5r7gUg8Uw6Of
 iBTVzbDqrUy7C5ZPAyXRzK6aZOXihRKP08b7kzzx/XZ5QhRlSt5fSJRaWsyeWXcbyRkH
 9X66sRIFTTLug80XYN/8Q6thcJSc+JK+Nyk6gZnalpxlqs8hDl0Cs5/KhjvKF27kGgoN
 q0ZJPkOLWs61MV6DFhDuuMzLN5BCQAhsd7+6KuvBXGhWQxt6kDq9JhBI1mYqpEVo8njC
 2a4g==
X-Gm-Message-State: AC+VfDzEmt5K0Wi2Cj76mofZsKf5Gsj5CQxbRq8oJvrGhAvop8YVif9g
 sh0vKUiy7I0zmA3DAnR69dB8doTtCnDzzlCnICg=
X-Google-Smtp-Source: ACHHUZ40Vno7LYKsPIgueWl6jp4ZXkmJT0KoMdBEsWlINvYf08yMEuKPNFzhZ0wDLTOJWFAJSNdVxQ==
X-Received: by 2002:a2e:9d4e:0:b0:2b4:67e0:4ce0 with SMTP id
 y14-20020a2e9d4e000000b002b467e04ce0mr13941443ljj.44.1687788064758; 
 Mon, 26 Jun 2023 07:01:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.226])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a170906340600b0098dd26c6e95sm3267799ejb.42.2023.06.26.07.01.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jun 2023 07:01:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/ppc: Only generate decodetree files when TCG is enabled
Date: Mon, 26 Jun 2023 16:01:00 +0200
Message-Id: <20230626140100.67941-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
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

No need to generate TCG-specific decodetree files
when TCG is disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index a69f174f41..4c2635039e 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -28,7 +28,7 @@ gen = [
                      extra_args: ['--static-decode=decode_insn64',
                                   '--insnwidth=64']),
 ]
-ppc_ss.add(gen)
+ppc_ss.add(when: 'CONFIG_TCG', if_true: gen)
 
 ppc_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
 ppc_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user_only_helper.c'))
-- 
2.38.1


