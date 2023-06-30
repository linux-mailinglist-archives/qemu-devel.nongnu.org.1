Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EE3744223
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:24:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFImT-0004gD-Li; Fri, 30 Jun 2023 14:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFImQ-0004dZ-Be
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:23:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFImN-0001ft-DI
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:23:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc244d39dso18035265e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688149408; x=1690741408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZAOTeGGrKkzwQAvWZdxb45rty8GpJ035mBrUTHulE4=;
 b=g/N7erLsp1h7BmSUo12Nbnbnfc8lW9elx9iRyhyZtgN0qhjESHti9E49CuYoISNP/1
 ZvbXdbSz3QOxnE3Cii5WTanfgLplB/VC3dQbYxggx6m16wXmFPFMDr6wHkuDm+ImcdsY
 +0xsx2sSNlvHBc4YeWo6078vsrVddhw/SuXRL+MllKyJQxK1uHSV2eGDoEKP+EE708/u
 7Z/n1qmOwQNrFuXz8NbQWCiPSRNZAjBJYlZw2AlvJaTAd2Fpp1W20ZSKbNXDk4F89ToZ
 D5EEGYweUyl+hg2vS5D5nZ5fqFKXhxTVVFhOkXDa/OXz1hqPOfb/dUimXQcxcpwhl9ZU
 pAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688149408; x=1690741408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZAOTeGGrKkzwQAvWZdxb45rty8GpJ035mBrUTHulE4=;
 b=NJd0jilpcLae5pcjLocLqlJnrktpVX/D9o6HxDonYrOT0olRmz+qXsZbgVLRw+N8Du
 FlWTLo+gCcsEydem0j16rCcpTiMvotmkziLMMXHsNLme+CpixLXS8ewYDINmGvKPuKLT
 3LOCfJhIbvWH1L60DVYyt8rxXOrS5H28x/Dcp8T2Dl8SB/8luW4AecKGY46Ziom7f0C2
 GnDe2ABfTrkmhPQS+0tklYqqZKHj/5j9195cK0tZk2hSwSdIjm3KA9Rj9QXduDvf1ZVt
 +2VQ5XwGQFcHrAZRVGFEKAvQbGMRrIgYR+hZGKFDudSWL9dDLeTZN0UKZvaz3MTmfq5P
 n/Iw==
X-Gm-Message-State: AC+VfDwtlwbkyvLc+T6CQzvSPNqR4d6jGirO46Kxvje42uZrDdJ4+9/k
 9TOcKESat1P9h9SGUl96PtmhyQ==
X-Google-Smtp-Source: ACHHUZ53fA+MW32qiNxB1TUtbD3entsj5zlT1qSwTLhduQjpO2M8k48J/HV8rwTxxa/TEfveHEEIMw==
X-Received: by 2002:a1c:e909:0:b0:3fb:b05d:f274 with SMTP id
 q9-20020a1ce909000000b003fbb05df274mr3323849wmc.4.1688149407977; 
 Fri, 30 Jun 2023 11:23:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a5d4145000000b00314145e6d61sm4976168wrq.6.2023.06.30.11.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:23:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A35E51FFCD;
 Fri, 30 Jun 2023 19:04:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v4 23/38] include/migration: mark vmstate_register() as a
 legacy function
Date: Fri, 30 Jun 2023 19:04:08 +0100
Message-Id: <20230630180423.558337-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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


