Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0787400A3
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:16:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBMH-00011G-GN; Tue, 27 Jun 2023 12:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMF-0000z2-Ed
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:15:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMA-000894-Gj
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:15:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fa96fd79feso28513345e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882553; x=1690474553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MH8q2iOgTUeX14EJZw8vp3pnXPRkiEedRymAvSCpuUo=;
 b=DdoZxOLN+AvjXoCRjUIs4sxtM6xjeJtnVRAiZaPPV/Af6XT+Ht3QnEGPuV0BPQ3BC3
 DCksIEuF/7WM78vkBqJ/lpXOdWc+Gf3xGT84ZjSOP144lEvGDqLuZybzwKgfcfsHgjMs
 kwe7eTmWGFUAiiZ8Hl6kyRXwBtH6FGSz8yfM9g2MHdmQOtA33Tynkq/7Vsd+U/vlSVK0
 cknZz9qFxB4wY8BKaXlAQYD2fgxXKPWP74ygjHKRCx4QvkBDgMZgl/IbsRo83r6jtWGi
 +f6YCASZhM1lPFuOWMHcoRYzzgvcez1l5duW8Ohraz3lhV3yFLS7mqQmeiFOC+zznouD
 q9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882553; x=1690474553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MH8q2iOgTUeX14EJZw8vp3pnXPRkiEedRymAvSCpuUo=;
 b=J5Z/v2BCqPlFb0AKFYos+F5e/9j0rmcwY22WIO98k/7i6yOQS9yYZFNc66a7E3gRPB
 toCr7Tl3m8RMY+c8zgQLPdIWpxtZkRnd0jGYszd8reXJjdI0uLY/u+98/pCVgBO7zcwS
 Hy53tCz+rMyFz9FRCUhENsS0Nea39zlmK8vadQCQHOFhH+JnIxeAPl+dNAXATghjD1vS
 bT/78gAXWZUXpXnHSdrPxsIz6qSkCQyrGbsj/x8+sSAXgtUHvp1f5UMf1H2R26/jWXfm
 5VB5wPmepN4h9vJtNC2U3QodPUkZU4zbt7ztShVdvyXyRrYWPdoNovGFMCKX/eu9DvV2
 JLZA==
X-Gm-Message-State: AC+VfDxKBljCiheBW3wBCIjOoe5HpUVQQUPsMpJYzK/Z51LKBSltji+8
 Ku0stsrZQYAjLuqDGZPtSWQmQg==
X-Google-Smtp-Source: ACHHUZ753D9V94g9P81TcGZiVxNVmg9lchUPmPANFuoQ6KFdLKZLydzthzpXYwgQyeRE5Mzk9jDlkg==
X-Received: by 2002:a1c:791a:0:b0:3fa:76e2:e6d5 with SMTP id
 l26-20020a1c791a000000b003fa76e2e6d5mr12256709wme.37.1687882552815; 
 Tue, 27 Jun 2023 09:15:52 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a05600c290500b003f9b66a9376sm14234527wmd.42.2023.06.27.09.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:15:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C99821FFC1;
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
Subject: [PATCH v3 24/36] docs/devel: split qom-api reference into new file
Date: Tue, 27 Jun 2023 17:09:31 +0100
Message-Id: <20230627160943.2956928-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Lets try and keep the overview of the sub-system digestible by
splitting the core API stuff into a separate file. As QOM and QDEV
work together we should also try and enumerate the qdev_ functions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230619171437.357374-5-alex.bennee@linaro.org>

---
v2
  - also include qdev API
---
 docs/devel/index-api.rst | 2 ++
 docs/devel/qdev-api.rst  | 7 +++++++
 docs/devel/qom-api.rst   | 9 +++++++++
 docs/devel/qom.rst       | 3 ++-
 4 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 docs/devel/qdev-api.rst
 create mode 100644 docs/devel/qom-api.rst

diff --git a/docs/devel/index-api.rst b/docs/devel/index-api.rst
index 7108821746..539ad29c21 100644
--- a/docs/devel/index-api.rst
+++ b/docs/devel/index-api.rst
@@ -11,5 +11,7 @@ generated from in-code annotations to function prototypes.
    loads-stores
    memory
    modules
+   qom-api
+   qdev-api
    ui
    zoned-storage
diff --git a/docs/devel/qdev-api.rst b/docs/devel/qdev-api.rst
new file mode 100644
index 0000000000..3f35eea025
--- /dev/null
+++ b/docs/devel/qdev-api.rst
@@ -0,0 +1,7 @@
+.. _qdev-api:
+
+================================
+QEMU Device (qdev) API Reference
+================================
+
+.. kernel-doc:: include/hw/qdev-core.h
diff --git a/docs/devel/qom-api.rst b/docs/devel/qom-api.rst
new file mode 100644
index 0000000000..ed1f17e797
--- /dev/null
+++ b/docs/devel/qom-api.rst
@@ -0,0 +1,9 @@
+.. _qom-api:
+
+=====================================
+QEMU Object Model (QOM) API Reference
+=====================================
+
+This is the complete API documentation for :ref:`qom`.
+
+.. kernel-doc:: include/qom/object.h
diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 2828843058..c342ce18e3 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -387,4 +387,5 @@ OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
 API Reference
 -------------
 
-.. kernel-doc:: include/qom/object.h
+See the :ref:`QOM API<qom-api>` and :ref:`QDEV API<qdev-api>`
+documents for the complete API description.
-- 
2.39.2


