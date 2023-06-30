Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A0F7441CF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIUv-00005Y-Eq; Fri, 30 Jun 2023 14:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIU0-0008K0-3I
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFITx-000710-HX
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc77e769cso10204265e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148272; x=1690740272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZ9lkOLlvuBeUlhuh2idWbjS3HxjyDfhOtWa7DeS7no=;
 b=XNeFLoreL5p3VIAvZV3PaQGB+77F1iocZxLvT0+r0jXTXQAADJN8CbvrRzd44lbtGS
 5+7Eb//ryZPNOwNsvaaF6r/LEZLPkqLpmZMY8giXGODe5h2NPsksAi8MXjsqH29QqKxh
 CNUG+MUpF/wo3BMreePsyJ9IQe6461W1NVLbqXrvcauZRN+OAViIAtUogdI8ipTejaG1
 KlZW+0L3kDESMlXu7rFzEARzAXSwnwKjQW0DL0EFe5WpumlpgwBAH6E9c+RMxKHKbvJT
 OghsqYtOCjOqqZpadF8j1MlFzj+OWznNJFUonbQagfFNtS8KFVLsv//anzZx5K8MC06r
 cwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148272; x=1690740272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZ9lkOLlvuBeUlhuh2idWbjS3HxjyDfhOtWa7DeS7no=;
 b=VKpEKNDWrEo8m18GJnJ2Db6kYkzCe0rcTHDmfduFlw/al0EQWib5KVJemFkx5GeHcX
 f2Z4zzY2psKuAWsktqRSjk6KRarPuZD79hXLAz9/e2+YIRVp4rekVC4L4ggLzYBAmYby
 Oyxq6bvIYAHQzzA0l5ZWzUqjiF57aHS9RbBZW5R7Ij9CNx3qa/APWh63TA7wV3UXQr0Z
 LOvBxGklW3tqIKnSPVC1jHwbrRwloPPIcLRRTVOYqlb9rUHG1If1R2qJyg0QKpDq5qtv
 3JfzZd0CLM1cezu3dVKE4G2kVQR18xEz9WhVUhBRl211TMOT554Vh4Pbit1QPL83mhT9
 R9cw==
X-Gm-Message-State: AC+VfDzpciY0wECekqfjPTDDxfuWysGjXu4mS3EWHIW2FWvXlsXHgCpB
 tg6J5hJF6z9J0bM2iReie30rgQ==
X-Google-Smtp-Source: ACHHUZ7Xqp6YABFefmTmB7YpiuuwXvdGcFAyulKJbUspgNcwfCWQCEG5O+d9EwlZT2wAHMMSS2+Scw==
X-Received: by 2002:a7b:cb4b:0:b0:3f9:b30f:a013 with SMTP id
 v11-20020a7bcb4b000000b003f9b30fa013mr2745520wmj.6.1688148271871; 
 Fri, 30 Jun 2023 11:04:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y23-20020a7bcd97000000b003fbb2c0fce5sm7107025wmj.25.2023.06.30.11.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:04:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 873461FFC6;
 Fri, 30 Jun 2023 19:04:25 +0100 (BST)
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
Subject: [PATCH v4 14/38] tests/lcitool: introduce qemu-minimal
Date: Fri, 30 Jun 2023 19:03:59 +0100
Message-Id: <20230630180423.558337-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

This is a very bare bones set of dependencies for a minimal build of
QEMU. This will be useful for minimal cross-compile sanity check based
on things like Debian Sid where stuff isn't always in sync.

Message-Id: <20230623122100.1640995-16-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - minor rewording
v3
  - shift extra packages from next commit
---
 tests/lcitool/projects/qemu-minimal.yml | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 tests/lcitool/projects/qemu-minimal.yml

diff --git a/tests/lcitool/projects/qemu-minimal.yml b/tests/lcitool/projects/qemu-minimal.yml
new file mode 100644
index 0000000000..d44737dc1d
--- /dev/null
+++ b/tests/lcitool/projects/qemu-minimal.yml
@@ -0,0 +1,27 @@
+# Very minimal set of qemu packages, used for minimal cross-compile sanity checks
+---
+packages:
+ - bash
+ - bc
+ - bison
+ - ccache
+ - findutils
+ - flex
+ - g++
+ - gcc
+ - gcc-native
+ - glib2
+ - glib2-native
+ - glib2-static
+ - libc-static
+ - libfdt
+ - libffi
+ - make
+ - meson
+ - ninja
+ - pixman
+ - pkg-config
+ - python3
+ - python3-venv
+ - sed
+ - tar
-- 
2.39.2


