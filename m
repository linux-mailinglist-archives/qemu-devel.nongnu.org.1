Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 663D073B770
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:35:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfwf-0001L5-5V; Fri, 23 Jun 2023 08:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwK-0001AV-5A
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwE-0000Up-Fy
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:30:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f90b8acefdso6681915e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523452; x=1690115452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MH8q2iOgTUeX14EJZw8vp3pnXPRkiEedRymAvSCpuUo=;
 b=SuoHao7Zwm8fDp6+rfCUOPx6ojzfiUHRaGmhqEtaaYkNxxm33csRVffHJZno6I8155
 oW6EDJXWxmMDdHKZt/rjHqFb7Mo4o231+zL49Rltp66ZzaOjk957Vr0Kxce4UF5lAEC0
 6yr2vIV4kFukUsW5QS3p/vsBJtW7YYmkGqyaUXPzMUmO5WO6+yUeBKHciPGvLs1oTIN6
 JNCURXjfZ/6JnzlbtAdwnyr8fpU4DFa381DaTjJkjZ6R37KBpe1aFTyeyMNqPOK27QM4
 Uy6Dpw9hoEjGfeUlxxJYrP5uVqIayaGhRVSh1xVpohn4hOkACRrYQVaOnF7bpih5papt
 wyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523452; x=1690115452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MH8q2iOgTUeX14EJZw8vp3pnXPRkiEedRymAvSCpuUo=;
 b=JXcfPpAXXXA7kh7VXt2g5Nii0XA8mM8F5JvCmZnE8F2hpewOXdXEjpSTST9r0EcxQe
 lWhZObmlD+9msRt/u7UX1NarE7vA6nobhhek7CSsx4Aq6+hEuqoTm4Y0do8H0QZkh66o
 BHhFr903GjIwcInE1SiQcyQGvmYNOxNOZD4jZxJmUTOvAiK5VkjEdD1FDTdM+50hgMZU
 FJRqS40P3ynvaCeDJrf/ywloIESPvV84Yfr/d7X9ViZ5amILYMK7v6t3oDRCkYzt+kCV
 agl3n+j/C7CBVswbHxT6Yl6IEv51R+Yc8V5HCAP/ZdFoBzRmyJZHAjVPyrmwb/yBoWsG
 YNTA==
X-Gm-Message-State: AC+VfDwfGzDecO89fKXxqIygW6CYluHU549VTcD/pGt7v/+E5K2OXJHI
 DyUL5BuGeJ66i2Gvm5IJfUOVSQ==
X-Google-Smtp-Source: ACHHUZ4XxUjA4citVDVBzLzr+kIwlH4eM/ql9n/akclyKpfunJZRTnjiHTyuG4pDprqFTWoc9cKIIw==
X-Received: by 2002:a7b:cbd9:0:b0:3fa:7d9d:456f with SMTP id
 n25-20020a7bcbd9000000b003fa7d9d456fmr950487wmi.40.1687523451680; 
 Fri, 23 Jun 2023 05:30:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a05600c221400b003f8f8fc3c32sm2211198wml.31.2023.06.23.05.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:30:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 89A521FFC0;
 Fri, 23 Jun 2023 13:21:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 25/26] docs/devel: split qom-api reference into new file
Date: Fri, 23 Jun 2023 13:20:59 +0100
Message-Id: <20230623122100.1640995-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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


