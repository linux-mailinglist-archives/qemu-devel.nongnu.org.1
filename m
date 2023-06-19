Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 581AB735CD1
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 19:15:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBISk-0003KR-Op; Mon, 19 Jun 2023 13:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBISi-0003Jt-7F
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:44 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBISg-000255-Dh
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:43 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30adc51b65cso3814506f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687194880; x=1689786880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNCXKy9KD1nbv+iKj9nGFzUMHc9zCSFXe2xCj+cXcBY=;
 b=edNhWpuUu+tLTJQkAf+/0XFZ8Z5YXKWEaCfVcxkaLQCDw+T9BHwLbVjfsQHyVpewbK
 /IkROx3+CJ6cZzhRDDVO5znmmP3dNRreaKhRTDup/4V22KaAtYrhxhMfKmjwdt1aSbQF
 5/IDAUU0XWsn3fUd2cZZTPjU5mQDmXy+1bbFvMcQbpVats5n5tqZ4z84QuPOFG+L2Diq
 ORC7qpDfYv1DQHzH+qa3mv0TMin2dMjKgfUIdSYLoPpXpXYqgqt5tRYANIXESKcUs7i7
 f+Z7m9AnMfBdJxJWCD0uENxKaaFOyI0ijuKazrHSmLN0QJ7b+/zmodpk9r5Emajukcqf
 JjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687194880; x=1689786880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNCXKy9KD1nbv+iKj9nGFzUMHc9zCSFXe2xCj+cXcBY=;
 b=k5aoj07G2MlH/ohUQsHACSs2ylBs/Lmswe2sLwGye9nJKB38qIo1w2Tu117CF0pkuR
 cLVt/nDHYCUq2bvMUJBNOC0aM+Pcf6hNAHuoAYBBOwwBkuoFpqbbGk/Ya9/KEx4QiQtD
 1wZEXvtaJ9xitjGAl40eN6r5OhWdaVUja7lmEw6GMkriN5vxEScRGxTvfFClATUIZsBa
 nhAj1oYN8EnpgOJebhBHZkVR95Vqrm29JcHp6pes6Xc/mAsBxO80Abogd70RVTmpIaiN
 YZZb0iBd8JOk1N8AJrp8VgO6JY28sMTOlGVKiF/8gVGeF2842KaLolXxptVjWKZz8j96
 IycA==
X-Gm-Message-State: AC+VfDxzrgkaepUNY4CD7DIBbb+Zd3owEz7x3zSZM/zy9LOC6mNyKiEG
 SwLd8+x2cSHpWtGmG3t/jAcueQ==
X-Google-Smtp-Source: ACHHUZ5lZjRdqyIDUUfDkWl5AJxY0jw80UcjPv/p3EEkQgqPiUOkQrHpZIjIYMpat94HpOmVzdMwjw==
X-Received: by 2002:a5d:6084:0:b0:312:74a9:8263 with SMTP id
 w4-20020a5d6084000000b0031274a98263mr1488897wrt.44.1687194879977; 
 Mon, 19 Jun 2023 10:14:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x1-20020a5d4441000000b00311d8c2561bsm37700wrr.60.2023.06.19.10.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 10:14:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CEDBA1FFBF;
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
Subject: [PATCH 4/5] docs/devel: split qom-api reference into new file
Date: Mon, 19 Jun 2023 18:14:36 +0100
Message-Id: <20230619171437.357374-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619171437.357374-1-alex.bennee@linaro.org>
References: <20230619171437.357374-1-alex.bennee@linaro.org>
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
Currently this is a little broken as kerneldoc doesn't understand our
macros.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/index-api.rst |  2 ++
 docs/devel/qdev-api.rst  | 12 ++++++++++++
 docs/devel/qom-api.rst   |  9 +++++++++
 docs/devel/qom.rst       |  3 ++-
 4 files changed, 25 insertions(+), 1 deletion(-)
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
index 0000000000..d47c4d7493
--- /dev/null
+++ b/docs/devel/qdev-api.rst
@@ -0,0 +1,12 @@
+.. _qdev-api:
+
+================================
+QEMU Device (qdev) API Reference
+================================
+
+We don't currently generate the API documentation for QDEV due to QEMU
+macros confusing the kerneldoc tool. For now see the headers in
+``include/hw/qdev-core.h``
+
+..
+  kernel-doc:: include/hw/qdev-core.h
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
index c9237950d0..98a4f178d5 100644
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


