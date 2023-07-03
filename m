Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE94745DF5
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:54:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJzr-0000bJ-JW; Mon, 03 Jul 2023 09:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzi-0000WU-1F
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:34 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzf-00082G-Ql
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:33 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3094910b150so5196687f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392410; x=1690984410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6+iuI2PXGCyiWs8rbXeGtlJGrDRRAokHBPFrSzxP8Q=;
 b=RPh/NAo8meCrxfeAyfUEPm0XNeAD7iEDgaY/yWc6t0tvBhv3AeH6Wqo+wV7dDhYgqg
 VRZO78Y8TsbXKWm1Yu0cSC01oZ7hpNbecIzYS2ErRHIoR4LTxdxxkzVXJYNpTQMyj1NE
 zWX/dr85QW9KWIDh5nQ3Zi9WKJhCrk6fw9OoFOBet9YhsroPo8EOg18LEhNYaymyPYHU
 ARs0XzdGZbtotUvhErbC8SQknQv2+nxgBNh4iutFTW0PnyZkPMkl085vD0Rmo397c7X5
 wPFg4MHbZUseJBxA0lM1LrmHkGTwt+z50E/3mp38eYAUoaOo4myDTpppyhNEbZ46KcH/
 qUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392410; x=1690984410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6+iuI2PXGCyiWs8rbXeGtlJGrDRRAokHBPFrSzxP8Q=;
 b=UpFuuNku11bvx/OLZ2EwQ2m65ChPDWhWqADjibiFdEHX0HATByq1+jBMpNSO8lLz2h
 6M7WyBZ+U/xKB9ypdXWLY4RLI0uVyn+VT3V1ElL+O785TObXV47C3PpZZMkung+3c9Ys
 9wCqj/ByN5vJHZDsefZZjWNwe50B2aPy59uq7Xn4KGLRDbyDoJreW6YjmuQzlUDDJBOy
 uXWtKSW/Y2oQVj5g/JH3g7bX5S1j8dEwjqJN0y9GjSy2P1FkByHQibycwHqRVT5MbkVJ
 QfTxiTBvEom5uhRRCL1/90YTPb7DEe90mfF7TXK9BLJM7+XOas8zyQI1+zHzJ/Me0HQG
 MLew==
X-Gm-Message-State: ABy/qLaDEguZOXdNBVhErPCT9iO+IsCHVFfmoo7rM00GchrQ065AWgUu
 XegTLhKETpApgSh4IjteuGp8MA==
X-Google-Smtp-Source: APBJJlHPmHmMlsdMNXTCLMw/8M2G5smLhWJaHMynMhhvOADVBiQp638qH+kqBjuCS/JfnlC7KNTtXw==
X-Received: by 2002:adf:df03:0:b0:314:f88:4fea with SMTP id
 y3-20020adfdf03000000b003140f884feamr8749266wrl.8.1688392410524; 
 Mon, 03 Jul 2023 06:53:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s2-20020adff802000000b00313de682eb3sm25593708wrp.65.2023.07.03.06.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:53:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DE7461FFCF;
 Mon,  3 Jul 2023 14:44:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 26/38] docs/devel: split qom-api reference into new file
Date: Mon,  3 Jul 2023 14:44:15 +0100
Message-Id: <20230703134427.1389440-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

Lets try and keep the overview of the sub-system digestible by
splitting the core API stuff into a separate file. As QOM and QDEV
work together we should also try and enumerate the qdev_ functions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-27-alex.bennee@linaro.org>

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


