Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9949D7400B2
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:18:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBMT-0001Ez-M6; Tue, 27 Jun 2023 12:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMM-0001BB-U3
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:16:06 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMC-0008AL-Rr
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:16:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fa8cd4a113so26733435e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882555; x=1690474555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZAOTeGGrKkzwQAvWZdxb45rty8GpJ035mBrUTHulE4=;
 b=W/lOWDTR0Dz0qqO6kVc6rJyLGlUlJ4USiuOjkMXtjP8A+I2WoIq7eUgZm34pAkHFIc
 nza6zBCTf9K6eapcd3ijJ2AGPEIKxJV2E1DHClx5GQ+Gsb7RVM9Z3XIb5J74sWSTIdXO
 B0W54qk3boxwnFMXy+agcAhAkPLOtkb80jp0XEI5jlyz20tID097S2kzZb3Rwfd8PLK/
 5exjB5+fpZybcLdqHKnKNdISdaSuuIGczypVLks7UaY8ZLSL45kvMKU+HZYdkx4Wfb5g
 1Js8D7zRDNvIrEFR5mxHM5Q7H7mHmxjaaqQzHStLPfwy4GSLlGcLZBzwpTXcfixsyaGC
 CpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882555; x=1690474555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZAOTeGGrKkzwQAvWZdxb45rty8GpJ035mBrUTHulE4=;
 b=aevanKcdRyiP9zBCmZAZqmNDu3VtIi4DmMGTjbyXKT0nF61WDPiamBdYxM5T0TrpEL
 HsbBkhdg9yobSN1nVIFAVtvbCKw2JCRqcc6sQOTJZse8rCigeBS3BG0kKVU4JHLA9OPz
 mVz070Jm4IuH5lJJLGZS0RFWqT56pd0zi/KaP7YF/VFmM5M6gGzzJrhzJz2KoIUOnBH9
 jxNZUjtAvcbWtOuUsy76ydC0tL/1NQyl+uGlOlFoYyJgFk5dYHCyEh0njoJVS4ioz1vT
 9y9Fp+RnIwEICilICvJqTjBbVkn/WKMW4TNddAeuT/zKl17bq48CG0lwlkZr3gmAAXkd
 Fa9g==
X-Gm-Message-State: AC+VfDw3CErr//tJB94mLuDOwzuvp7KWgAutizy7wOPBBSUIqehcAv3F
 5hDbmO0aVNbZAbTCp3yIUrVr/w==
X-Google-Smtp-Source: ACHHUZ5U8K6T/ZfrDW4JZD2tsTit+9eSeb0Bk97nI2N+OTTdHrivay5+WCA+thaScTqTWdNvrQZ8vA==
X-Received: by 2002:a05:600c:230b:b0:3fa:8874:fe69 with SMTP id
 11-20020a05600c230b00b003fa8874fe69mr5892547wmo.29.1687882555030; 
 Tue, 27 Jun 2023 09:15:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a1c4b11000000b003f90a604885sm11275804wma.34.2023.06.27.09.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:15:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 732AB1FFC0;
 Tue, 27 Jun 2023 17:09:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 21/36] include/migration: mark vmstate_register() as a
 legacy function
Date: Tue, 27 Jun 2023 17:09:28 +0100
Message-Id: <20230627160943.2956928-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Mention that QOM-ified devices already have support for registering
the description.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230619171437.357374-3-alex.bennee@linaro.org>

---
v3
  - checkpatch cleanups
---
 include/migration/vmstate.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 084f5e784a..d1b8abe08d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1209,7 +1209,15 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
                                    int required_for_version,
                                    Error **errp);
 
-/* Returns: 0 on success, -1 on failure */
+/**
+ * vmstate_register() - legacy function to register state
+ * serialisation description
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


