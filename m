Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 489D673EE60
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuMJ-0003mm-GQ; Mon, 26 Jun 2023 18:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLM-0003B7-TM
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:06:02 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLI-00071Z-Kw
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:05:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f9b4a71623so36859255e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687817150; x=1690409150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MH8q2iOgTUeX14EJZw8vp3pnXPRkiEedRymAvSCpuUo=;
 b=reDTl2fW8w+mwUUub3P/EUrm7eH6/xv+SZMZYprBT+gTma36oycMQreo8LSusX0ZmJ
 0zumbmd9WXUFP6Gl2uQeVMVCFlswF57nUMZRmZYgRQcIEzHn2RPjzA/Jc+FfseZGfodI
 0JKhDsSkBs0sAF3GOPdehHREPri7mZy9uC0q61i/GCl8SzyJN4ZSsle/dtJCtaoN+BrL
 djW1aw99VoWoKgCeYapYvaxNdZx+3XKuRMCOqGhofrQzH3097DJUxc8xTKPipA13i3VJ
 NWt4MBr4mtx1NtIGRfOb5rMxjgxjZ4qvQ3gBVwOMswcFbre3x0PMJ7mkmnLHdoqf73MH
 pPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687817150; x=1690409150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MH8q2iOgTUeX14EJZw8vp3pnXPRkiEedRymAvSCpuUo=;
 b=R/9NqX2IMklmjWT3OLnmJ4GtDBj60EtSCgwRFlzdkBzSd9sEejmGGsPhHpIGMcUqyl
 5tplS0oQF011L0uDgutMlUAyheQBsQGOHViD5hBRiXuxdxYb6ga8VcRoU+3/SE0xNHtb
 vb6C1wVgIzJmpdCJdlUMPasYemWuMtCPxJG2PqDAuCljDCKZKpbaenvYTHgmrCaigzaU
 K0cntMocePbiHIqGlJ6vp7oX7wxM/BM8S0I2O1Wqx1nCrUXycIsX3zzArScijBdEutgh
 /2Hg/55dXmLhV2Y/4TRldf065c/BA2LYmY7Krn5kY2Cmy/eb+IuRNA+me5f/OHjxxJXb
 nLZQ==
X-Gm-Message-State: AC+VfDzLpaGQoi23SnV0jg6LZUUWy2b80wDihC1J37aHV4KlmiwlR+aZ
 1bnxB5cX4TBXuweIGck50qPMUA==
X-Google-Smtp-Source: ACHHUZ4m5W2MtgqMXvBOQKCkl7zE2ldHa3Q6N8ux2tvVo5vs+huJeIUjM/e4pXclDbuYDjU0TkWEFg==
X-Received: by 2002:a05:600c:2942:b0:3f7:5d:4a06 with SMTP id
 n2-20020a05600c294200b003f7005d4a06mr9703538wmd.1.1687817150541; 
 Mon, 26 Jun 2023 15:05:50 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c210800b003f9b4330880sm8849979wml.29.2023.06.26.15.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:05:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CBF651FFCE;
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
Subject: [PATCH v2 24/26] docs/devel: split qom-api reference into new file
Date: Mon, 26 Jun 2023 22:59:24 +0100
Message-Id: <20230626215926.2522656-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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


