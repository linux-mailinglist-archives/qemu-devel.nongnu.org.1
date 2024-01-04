Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B37EF8245D7
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:09:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQHC-0005vZ-Sl; Thu, 04 Jan 2024 11:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQHA-0005op-Lv
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:56 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQH9-0007vc-5y
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:56 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-336897b6bd6so596139f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384533; x=1704989333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8eb864d056l6M6XqU22mHpGh3XTGQmhbEhgeMcbUxQ=;
 b=Gt0Aah4LDoDWn5iEhf+wYH7Q/6WK/NaXaZnBPhiFAgPvUeziswW556RsF/rZ2FzF8R
 V1KNe5DWPzNVXo5veKg+nq7m2JbmmxrKYKvOxa+oqqmY8i0Bu2/IrOU0pXp6ZMJk/PHt
 vQAPJLI+m7ZGowIdM/LOnupzwkP6AfEROjHbkTsz7lH4u2i2HAdTe3lUdQDYNdDjADYB
 PpC97HdzEFRUNAVAIE0nkTMx3bWZtpCS06H1l3pMEIsmsExiU4C0yL2irXTbIlfyRLPA
 67Oa26w71cir05uEFmqnY49zCaLyV0IL+Rmj1naxQsjOUh4D7OfOKWGQttVOJ8kAo7yp
 PowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384533; x=1704989333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8eb864d056l6M6XqU22mHpGh3XTGQmhbEhgeMcbUxQ=;
 b=ryWf8Dj8vD/pzDk689XYRZ4Q+L68w9oZsAa8WoaTTXMsJImwsgOqTDqlcevVCtZYor
 WBVwDetovdnE2F4ad1C0KfVv/ThsgRUWDegPxyTA4Z5vASSRW34m+cXMRoQ+wJ4KhUYt
 OJl26MJ1X4pprYzvQxQ7svVCZ4W2nZGGWDERQcvCUNXeegCIVFmTFHixbvExgkfG9/PZ
 7OZXrm5uqJXycsrJer4zqAsb/H3eZ6PXgFNTQZ9/LF27NKhUxor9rTpq98nzXwnVN06G
 p7/KPHbtvY4zk9qGlSTw0qh1MpuYMBH9fQ5CmSu9REaKtlpUBXJa1nftiIv+M/OjmmYd
 q6iw==
X-Gm-Message-State: AOJu0Yy0Zb4ky4LUPKieYkL1Hap2T8MCMWXxQaxRKvjsUQqAHrgsCTrF
 iY1Tqgs+JYO1c8JfoHcGEGRC3dnuItC60qOc234muCVZR3jCUw==
X-Google-Smtp-Source: AGHT+IH279atSDMQIVkdypNLAgFCEgBN8GI7t11jRiTuyNpOqj4S4sEEFqMEazu/0IIJkRkqTAXtfw==
X-Received: by 2002:a05:600c:3d19:b0:40e:362d:26f7 with SMTP id
 bh25-20020a05600c3d1900b0040e362d26f7mr77864wmb.228.1704384533466; 
 Thu, 04 Jan 2024 08:08:53 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 hz24-20020a1709072cf800b00a28ff7b8049sm145950ejc.224.2024.01.04.08.08.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Jan 2024 08:08:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Xianglai Li <lixianglai@loongson.cn>, Zhiguo Wu <wuzhiguo@loongson.cn>,
 Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH 7/9] scripts/ci: Install RH packages on RH derivative
 distros
Date: Thu,  4 Jan 2024 17:08:03 +0100
Message-ID: <20240104160805.56856-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240104160805.56856-1-philmd@linaro.org>
References: <20240104160805.56856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/ci/setup/build-environment.yml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index 8a6855f472..6baa539b46 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -193,7 +193,7 @@
         - ansible_facts['distribution_file_variety'] == 'CentOS'
         - ansible_facts['distribution_major_version'] == '8'
 
-    - name: Install basic packages to build QEMU on EL8
+    - name: Install basic packages to build QEMU on RH family
       dnf:
         name:
           - SDL2-devel
@@ -303,8 +303,7 @@
           - zlib-static
         state: present
       when:
-        - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
-        - ansible_facts['distribution_version'] == '8'
+        - ansible_facts['os_family'] == 'RedHat'
 
     - name: Install packages only available on EL8
       dnf:
-- 
2.41.0


