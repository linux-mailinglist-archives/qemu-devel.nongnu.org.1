Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F317735CDB
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 19:16:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBISl-0003Mk-T0; Mon, 19 Jun 2023 13:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBISh-0003Ja-MN
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBISf-00024t-Cx
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f900cd3f96so24777645e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687194879; x=1689786879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAzDJYHeZ3egsdpPxn+zZy7ksHc4V1jiKHsxofssT6o=;
 b=PX92BXvxsydR26vi7/30yy9Ru+EgAhrexq/R58MkhqGZQ67Cq5LJjN9khjSL4EVu1V
 Vumb0c5eJoc41bCXFcuUMQYbikdnQ8/a0asfS1Jb6bZX9ItHOj/WvFO+Ya4xLQHBssIZ
 FMwa0rQs8HhtV8/rHJBKAbWCgq8gNYyJRVSwdyrGPvYon31ObQerdwXi88lXptEyjJCH
 mdyPrpECKnwEKOcR8hNfCokWkBj0fUb9OvqpdKn0RH+U5ycnViDegKdyakOh8G+7Nli8
 AmQEHFlL1+VBmAdBNj2GIcYD3Rw8BuKrpq58FcVgjSr7ec5V7r5d566CNrs//1ettuNK
 2fcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687194879; x=1689786879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAzDJYHeZ3egsdpPxn+zZy7ksHc4V1jiKHsxofssT6o=;
 b=iECefbOD5Cn+axk3aiIX8a2BvoKpxBP570e4Gw6u+DBAJS4+7LYN6rgCRHp3bmC6Ph
 LEH3ivF1EHYdmhEpASBp0fHaflzKlqEIlO6U2iks9ABA/nY0yqMVIQ0WTRzDhyxGDb75
 gxIWVCCn4BQFXG1HhlB5JN39xnYU5AW60ZunCExlrDPEXSgJIdjr6NmacLnzuMjJQP/f
 taLBruq7orU75M5ga63az/42ibvFcWdQXDFlnRn5wp0USj9K2lqNiISWx/f29yq55Wpk
 4ES1uu5gyl7okrQNjGc7n8qaQdBMibLZwaje0jBV8UQmTvZGH6TCGJ0IGaCR6UtIDSKf
 0N5w==
X-Gm-Message-State: AC+VfDw2044ZkFL7yPdRzdqir1tscheZkQIcP0uZrlojzFLSS7LAXJGi
 ztlY+Eh3wWm8PAZjru5tB0gaNA==
X-Google-Smtp-Source: ACHHUZ7rWzF24s0Q/G2XEonCuMywCdu2q+yf1VhtarF9fi8+n2iJEPlffN7edsN29kbjN77ib9vezQ==
X-Received: by 2002:a7b:cb87:0:b0:3f7:e4d7:4469 with SMTP id
 m7-20020a7bcb87000000b003f7e4d74469mr7283058wmi.41.1687194879501; 
 Mon, 19 Jun 2023 10:14:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a05600c0b4400b003f727764b10sm296549wmr.4.2023.06.19.10.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 10:14:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 969C31FFBD;
 Mon, 19 Jun 2023 18:14:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/5] include/migration: mark vmstate_register() as a legacy
 function
Date: Mon, 19 Jun 2023 18:14:34 +0100
Message-Id: <20230619171437.357374-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619171437.357374-1-alex.bennee@linaro.org>
References: <20230619171437.357374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Mention that QOM-ified devices already have support for registering
the description.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/migration/vmstate.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 084f5e784a..35579b2c1f 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1209,7 +1209,14 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
                                    int required_for_version,
                                    Error **errp);
 
-/* Returns: 0 on success, -1 on failure */
+/**
+ * vmstate_register() - legacy function to register state serialisation description
+ *
+ * New code shouldn't be using this function as QOM-ified devices have
+ * dc->vmsd to store the serialisation description.
+ *
+ * Returns: 0 on success, -1 on failure
+ */
 static inline int vmstate_register(VMStateIf *obj, int instance_id,
                                    const VMStateDescription *vmsd,
                                    void *opaque)
-- 
2.39.2


