Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F6273B745
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:32:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfwb-0001Ej-Ts; Fri, 23 Jun 2023 08:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwG-00019a-9X
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:30:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwB-0000T5-6A
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:30:55 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3129c55e1d1so675832f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523449; x=1690115449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOww9rbYnTUV82Nt8luSAT3uGVvZz6IBM9I4dizL0VQ=;
 b=iXB8XtNZCXPeU1aBUK6ybgZYU9vS5QZRQc+LRLIPKqJvJaUs4T2sztPICo2jIDbsf2
 +BmtzItp31WLuamO1qlA5RPlp4yYhXC155vDdm4INsMJaAI6wRXmYdgbcYtKMaQidxum
 YH+ECyyrGF/U23u711tC9pg8jkHqw41aNpOCobYx7Acpq1Bv4nm6F55392Y5TEkEPX45
 ZN0XnrHkkRI7QQd+E4AOoduyQpJg/63AuIpVoaufNzXhUTBxx4pd4K1NOfRfIrcmYF2w
 cg1hZFqcdh5EC8tp2vGlI9WFj1gbUMZbqSFEa18OWSkOKlOgDpb1X8FMXazJ10+lzXBy
 WYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523449; x=1690115449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOww9rbYnTUV82Nt8luSAT3uGVvZz6IBM9I4dizL0VQ=;
 b=cWf3GkW5ljfxonVk1OLO0pB2C+hZhRLundBn1ioRIz/WJKxvA5l8tZiNbcKrc5jQer
 46QrtzZgln2eAKWpR3ENiw+9Fwpl2As/DGuU1ue7KZqGsy/QRbCN5T3VGmR6yBZl6tIG
 /gNIl8Iigf3Pa8mJx5b6QgvZ9gnsqtv5GIPXgabfsGJ0uu1wOvlqptghoBgcOGTKifjC
 cdWJXIrgXcT/jRf/TKEzmwsJCIO9dru8oZVoleAJw1+2QU6EdycLD64K/76HNe6yrd5/
 BgxOQGdHKLdPna6l67vpncT39OCzHQZ6gdVcnWhQkpX9QrLEEO7slo859q7w2LLG2MH4
 ofiA==
X-Gm-Message-State: AC+VfDyhhxxSkosRQeTmfSq6gVHYyPqIazry5fWkdoZu4hN/1hk8+Osg
 5tZHBNOlzDDUy+sgSrwa3rmHtg==
X-Google-Smtp-Source: ACHHUZ5oYWlvLc7E3BfJGpgAvq1H4qhv2FA0ovzYmASIHxwtZkQiEFpkR3TgB/DgUgRA5MpznjvIug==
X-Received: by 2002:a05:6000:1191:b0:30a:b147:69db with SMTP id
 g17-20020a056000119100b0030ab14769dbmr19275521wrx.24.1687523449514; 
 Fri, 23 Jun 2023 05:30:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfe5d0000000b0030e5a63e2dbsm9481515wrn.80.2023.06.23.05.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:30:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1C6901FFBF;
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
Subject: [PATCH 21/26] docs/devel: add some front matter to the devel index
Date: Fri, 23 Jun 2023 13:20:55 +0100
Message-Id: <20230623122100.1640995-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Give an overview of the most useful bits of the devel documentation to
read depending on what the developer wants to do.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230619171437.357374-2-alex.bennee@linaro.org>

---
v2
  - removed excessive start
---
 docs/devel/index-process.rst |  2 ++
 docs/devel/index-tcg.rst     |  2 ++
 docs/devel/index.rst         | 24 ++++++++++++++++++++++--
 docs/devel/tcg.rst           |  2 ++
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
index d50dd74c3e..362f97ee30 100644
--- a/docs/devel/index-process.rst
+++ b/docs/devel/index-process.rst
@@ -1,3 +1,5 @@
+.. _development_process:
+
 QEMU Community Processes
 ------------------------
 
diff --git a/docs/devel/index-tcg.rst b/docs/devel/index-tcg.rst
index b44ff8b5a4..a992844e5c 100644
--- a/docs/devel/index-tcg.rst
+++ b/docs/devel/index-tcg.rst
@@ -1,3 +1,5 @@
+.. _tcg:
+
 TCG Emulation
 -------------
 
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 09cfb322be..abf60457c2 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -2,10 +2,30 @@
 Developer Information
 ---------------------
 
-This section of the manual documents various parts of the internals of QEMU.
-You only need to read it if you are interested in reading or
+This section of the manual documents various parts of the internals of
+QEMU. You only need to read it if you are interested in reading or
 modifying QEMU's source code.
 
+QEMU is a large and mature project with a number of complex subsystems
+that can be overwhelming to understand. The development documentation
+is not comprehensive but hopefully presents enough to get you started.
+If there are areas that are unclear please reach out either via the
+IRC channel or mailing list and hopefully we can improve the
+documentation for future developers.
+
+All developers will want to familiarise themselves with
+:ref:`development_process` and how the community interacts. Please pay
+particular attention to the :ref:`coding-style` and
+:ref:`submitting-a-patch` sections to avoid common pitfalls.
+
+If you wish to implement a new hardware model you will want to read
+through the :ref:`qom` documentation to understand how QEMU's object
+model works.
+
+Those wishing to enhance or add new CPU emulation capabilities will
+want to read our :ref:`tcg` documentation, especially the overview of
+the :ref:`tcg_internals`.
+
 .. toctree::
    :maxdepth: 1
 
diff --git a/docs/devel/tcg.rst b/docs/devel/tcg.rst
index b4096a17df..2786f2f679 100644
--- a/docs/devel/tcg.rst
+++ b/docs/devel/tcg.rst
@@ -1,3 +1,5 @@
+.. _tcg_internals:
+
 ====================
 Translator Internals
 ====================
-- 
2.39.2


