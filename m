Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B8744200
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:17:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIcl-0005S2-9V; Fri, 30 Jun 2023 14:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIci-0005QL-EL
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcf-0003Wg-9q
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31297125334so1972432f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148811; x=1690740811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MH8q2iOgTUeX14EJZw8vp3pnXPRkiEedRymAvSCpuUo=;
 b=oDvdq5F78Cxq+csDREUhlgsG/N37ST6wZcwezMzL84GD3V+fNjHlK+mysKyRUjxoBw
 TBbP218GWVvap1XSpClLPj596Nma3gfwoJVvP0nb7Ee2I/71shJM/R15ebPEq8szoXOJ
 q2so1rdXzWlpflsgiuMNucQS0uOanIKqyTVhSksPXrqmwgGryhTFoM2GMQDIoolmggQ+
 I7GeEc0/VAt5CoOqmQss/DkFlY2lvUQUiYo6zeAPzhg9LuvqCjw5JxS/7Hm8kUDEGGKJ
 pJYV2a7YHDuOd4P4Q5jKQqIj4OHgqAOlRCoSoU2haRGqgea/+MjtJUnTYXzB7lK1uzQY
 kLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148811; x=1690740811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MH8q2iOgTUeX14EJZw8vp3pnXPRkiEedRymAvSCpuUo=;
 b=L7CRELyjwJcGmT1bhE0VjEmiORya/i1vdozARFITgJIdutQMZi29bn0MqheCoMEkSx
 9wlTMYsNVBUiwvUwUARIBz2LLXhtm5YXF8tiwEyhvKO3zc5/+yV9UfU1yEaFx+Kezxse
 UPkfy8mPGvaRQhC88IlstFPjUVIWdhEXUE4NrVmpPFaC84nRFDgvC7r/KsBGRTNFgWR1
 P3Wcmzl0OKgViOndryPEdbSSx10HvkJGso8FHGwMpzpEmMUyGbkcCzNrucZT2Nv/kB1g
 9CNBxfHrnMvuFS/gktxlqQUwwNG2YFH4p2nEeJ7sdp1HIXA/GbHU4N+qVtReEcplJ4I1
 gniw==
X-Gm-Message-State: AC+VfDwoqMIrdb1XB2/MSctfxLX+sFB6yb/UTWOQHFvD8VbSUWDVTr3n
 Mc5xJU66t/CegHJhtTwv8TtOHg==
X-Google-Smtp-Source: ACHHUZ6FPZId11NE9s6Gn0wp3hGwjiBCr2A1Y/D4Ac4OaL8iuLXX45K0TtOaf+I9fWnN3pBMg0d/Fg==
X-Received: by 2002:a5d:518b:0:b0:313:ee4b:b584 with SMTP id
 k11-20020a5d518b000000b00313ee4bb584mr8038327wrv.1.1688148811676; 
 Fri, 30 Jun 2023 11:13:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm13308744wrm.103.2023.06.30.11.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:13:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 044331FFD0;
 Fri, 30 Jun 2023 19:04:27 +0100 (BST)
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
Subject: [PATCH v4 26/38] docs/devel: split qom-api reference into new file
Date: Fri, 30 Jun 2023 19:04:11 +0100
Message-Id: <20230630180423.558337-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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


