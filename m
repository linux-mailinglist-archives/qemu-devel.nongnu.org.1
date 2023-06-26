Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C26D73EE71
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuM9-0003WB-UN; Mon, 26 Jun 2023 18:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLL-0003B3-VR
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:06:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLH-000711-As
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:05:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f9bece8e19so59491445e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687817149; x=1690409149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOww9rbYnTUV82Nt8luSAT3uGVvZz6IBM9I4dizL0VQ=;
 b=CpkZZ0CKU8Y+Kgdy29V40D9fpialqs9DGS75Oea7uipjHWC0mEMCs0yUl4OJl6iGl8
 17ktNqlW44ICSP9a6csLe/GyZ3VMPk0Troi0LStvCxUOuGTS73RwJ2RVVtmIB4xLSq0N
 sbbR1+3MolhJunBP1YiVWGFYEhIGCeOsqRNOLL00vrIS9UiWui111IMpITWm4AdylRa5
 O0YBrHTRVbCCbL8+W+TWGhrtbPmS70vO2b9LxOoSTC9tnhWMZLFqw02d0HFLFOJPyGbb
 kAl/4l7q7tHYztH/sG6QFYB9v2KAL4B0fxW9FvSJx75+e4/c9Y17O3xWAZ1HOOMpe2KW
 lFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687817149; x=1690409149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOww9rbYnTUV82Nt8luSAT3uGVvZz6IBM9I4dizL0VQ=;
 b=Xe7yfxO8JunsDrgGT4oxSZWIW/9UFvxLtHfyV4vkDVI7bfWLA1OspwwMX00hx/8vnf
 avT27Amv1nlQqiO8eBAIt77iszOslQXPyi1JjxiEgk/7I7RcV916hpzZ232on3dgfkTa
 CUfVVRH5fJffxNBB9/xLGnf5naVxGasEBK5K2/ajN/qWYMUYLiDEQ4FO4x0VCOttGzHS
 QBrByIEwSmtyq/c2WlrmLZ5PdC4xoWvrv6JUa+fIjQqZoDLAwRldrm3nOdypIyUVGxFd
 DGSS7O+N2e35XEn2zKKbjNs4aHq4Jjg0LvDEPRhEbgFzejxAf3M+uwDNn9aPL+Ywi1bP
 pkyg==
X-Gm-Message-State: AC+VfDzs6UDw7rPZvTOru8K/D4ZghNhjfBbkWvWBJ3hKULd8UNbXe72q
 VMCMOQgmVV86Nu6GPyipGguaUA==
X-Google-Smtp-Source: ACHHUZ6abYZhOsMJt33EE6iHT4AZmQVYk1hPldQaJmFQaIOREfuztc9xkfqfoXOLEh29uaQvqjXPAQ==
X-Received: by 2002:adf:db47:0:b0:313:f084:2ecb with SMTP id
 f7-20020adfdb47000000b00313f0842ecbmr5038461wrj.52.1687817149131; 
 Mon, 26 Jun 2023 15:05:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a056000054300b002c70ce264bfsm8543321wrf.76.2023.06.26.15.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:05:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A95B1FFCB;
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
Subject: [PATCH v2 20/26] docs/devel: add some front matter to the devel index
Date: Mon, 26 Jun 2023 22:59:20 +0100
Message-Id: <20230626215926.2522656-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
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


