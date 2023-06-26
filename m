Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B1C73EE5E
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:08:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuML-0003z2-U8; Mon, 26 Jun 2023 18:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLN-0003BN-8I
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:06:04 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLJ-00071r-Cu
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:05:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-313e68e99c7so3466430f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687817151; x=1690409151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lZ58MHVs7VVcDhLDA+codKww1SNsRkU8Vn2ofdw4A8=;
 b=GaoLL0Av24FtXSfp1pDXtwYtHpzcPpIef97X4uobrcSHzsML1boLPKxWYeqUdHXEVw
 iUSXlF7V8UpZjO51vxa3nPuc8qywonSsTOYa/6wgnWBj5t0lpmk9nstj6MvXj5eZU92e
 TcTcpS7mOMrBSbyUucmQAneK/m75ZBntPrji8qqoAUbaFe7Dpx9qph0S2yeYqdzwDjBa
 C/cvGHK/m77xnyRaEwvAzYg/Lu6d2AFk+W8uzFHcmYH9FN/hI79vnouXxwv/RuvwmzLU
 +T2okMMxTRKEWS1BHsfRh1kuxWywJhf96Augt3H4ql6J48faqbOphnjFUeKrZpfQPMFt
 A33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687817151; x=1690409151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/lZ58MHVs7VVcDhLDA+codKww1SNsRkU8Vn2ofdw4A8=;
 b=VHanD11HFSTHcV5m2eia2y2/UdIMIuiRXUT3olSnh7aygj8XijJWnrr0EE2+RAt0U2
 yspv4lh+5POGkgYh1e9x00B9hn9abj36dQV7FaIGuD92CBkWxXziAXu9dbGGdSZTeuj2
 Dz+bCY1pDoVi34QT/8GG05RxBmlbQD7kEPybhA5JgdCjDRb2JFXxRJNH11nmEmWTaLvx
 eCCWEV155UFlbvmzk277JSNW53ul2hci15RGQeS1+mBvClbPawxMYhv3cBBaT17JsMXW
 l4HQCtr9TY7bR2Pj2YvAIpA9KweMl1uLFzKLKOtjZo46HmelzkQOMPkA1i/Tdk88jypf
 2qRQ==
X-Gm-Message-State: AC+VfDyz+6arzjgzgNphkApQ4t2NvRXlel3hYbCXjCnjtAj+8PqZDFgL
 3AUCrnk/50/SNcXK1oBwNyT8gg==
X-Google-Smtp-Source: ACHHUZ46vPtCXTrmB7xGGeOqCcYwyJaYdRK6vqHi8/6xYhQfECY6cVyBUCht8WISIku2eGi8XpwjJA==
X-Received: by 2002:a05:6000:1949:b0:313:e161:d013 with SMTP id
 e9-20020a056000194900b00313e161d013mr6253303wry.15.1687817151622; 
 Mon, 26 Jun 2023 15:05:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a5d4c41000000b0030ae499da59sm8423516wrt.111.2023.06.26.15.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:05:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 73D7E1FFCC;
 Mon, 26 Jun 2023 22:59:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 21/26] include/migration: mark vmstate_register() as a
 legacy function
Date: Mon, 26 Jun 2023 22:59:21 +0100
Message-Id: <20230626215926.2522656-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230619171437.357374-3-alex.bennee@linaro.org>
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


