Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A3790803
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:03:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQEJ-0001As-K8; Sat, 02 Sep 2023 08:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEH-0001Ai-Fl
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEF-0001i3-2z
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSmlrs0rjxYxWDp5Xt8aIVKmdYFzTslCtqqGTiwtP84=;
 b=eKHUBe4ZvxOgOq+UMMjNVGVkO6lCJQ5gz6FOVGwfHf0Ut7DOvuJVVIdw9/+r+B6JnJXci+
 OoVboRaEySNHgK2RSrc3gxOD+Mobp4kejTd3ZtKcQb4KTfsTyHvcQYjXpoAXW9P4yFIjt0
 f0A62cZaR3ndBq8WV5Zfs6qTBROJNuA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-yd8kCiiXM7uRgsXTGdeDPw-1; Sat, 02 Sep 2023 08:59:53 -0400
X-MC-Unique: yd8kCiiXM7uRgsXTGdeDPw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-401dba99384so18833785e9.3
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 05:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659591; x=1694264391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSmlrs0rjxYxWDp5Xt8aIVKmdYFzTslCtqqGTiwtP84=;
 b=BbdZh0A234L78uJCsNZohTu5woObsgObYNxzjMdNpeK7qwxLew3fIUk8trDu+xV8RW
 mSaF21XryTS0tEAgrMQN0L+oRb0jM3TiTYGGayxUiNwwvou5qt1+eOI2PDRCYstGEMqx
 b0rGl14snspEpoFyR64ta96ucJYmBVAJcJ5zZBW89RyHPLbGPxwfq14pYSfci3JLyVpn
 M7OnQadde7yKpO2ZzQzxaAf2I6iD08TaTuZzGCzmlU2D2jvO4eKRBL+LBmECHgc42M3Q
 Lm0Lv++/hkgYFTvz9b+JB4EFFgj3+4h6XrWJw6QTm9dgTu3lRgehdmQaxp9o5C2LzBev
 iNPA==
X-Gm-Message-State: AOJu0YzBVxO0yG0kGYesEQMVtyeRXH+HcMfzRNORaf+BoeVdMhylWuuU
 Qy6yJj7z8/Qkwez+jk4Cf55EaDzThpvKBTjXkBaUZNolo6xKdDnWDTUShsn3E/dKuYVGjhXPE/V
 ZICC+GxVS4hmv525eaAqbum+P6hWI3Fs+cLzNCgE284H8Wa0x68OaNy+5SO/QSn8T6lg92eZGcf
 E=
X-Received: by 2002:a7b:c859:0:b0:3fe:dcd0:2e32 with SMTP id
 c25-20020a7bc859000000b003fedcd02e32mr3399452wml.19.1693659591391; 
 Sat, 02 Sep 2023 05:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1orhzNhrCwqzUFry2EiO/NlGhgnmieYYPr8CE7RgflmNfBB+3cNg+cyYkB+ML7sS5SMi9hA==
X-Received: by 2002:a7b:c859:0:b0:3fe:dcd0:2e32 with SMTP id
 c25-20020a7bc859000000b003fedcd02e32mr3399442wml.19.1693659590914; 
 Sat, 02 Sep 2023 05:59:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a05600c204100b003fe1630a8f0sm10956297wmg.24.2023.09.02.05.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 05:59:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/15] meson: test for CONFIG_TCG in config_all
Date: Sat,  2 Sep 2023 14:59:27 +0200
Message-ID: <20230902125934.113017-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902125934.113017-1-pbonzini@redhat.com>
References: <20230902125934.113017-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CONFIG_TCG is not included in *-config-devices.h, so the test is
always failing.

Fixes: 74884cb1a6d ("qtest/meson.build: check CONFIG_TCG for boot-serial-test in qtests_ppc", 2022-03-14)
Fixes: 44d827ea69e ("qtest/meson.build: check CONFIG_TCG for prom-env-test in qtests_ppc", 2022-03-14)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index df63909ee51..c0751ef7c35 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -155,8 +155,8 @@ qtests_ppc = \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_M48T59') ? ['m48t59-test'] : []) +                     \
-  (config_all_devices.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                      \
-  (config_all_devices.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                   \
+  (config_all.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                              \
+  (config_all.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                           \
   ['boot-order-test']
 
 qtests_ppc64 = \
-- 
2.41.0


