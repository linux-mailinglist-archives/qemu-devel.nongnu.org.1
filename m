Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5158245D1
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:09:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQH1-0005Wo-5b; Thu, 04 Jan 2024 11:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQGz-0005WI-86
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:45 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQGw-0007uo-Jv
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:44 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50e7dd8bce8so763535e87.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384521; x=1704989321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnUpQLZU43UMHi7KSxzqXqyNfCHjYuiQzoZigtRlS5I=;
 b=e4qJJN0CiwSjwh0wWiRS67LFQ3OG9p9zUut5uMCIDsnqqsRkwP3uwGeQ1EvB6s2/72
 364UgKIrPXrgUpNfuwuTDBC90Rc+STMDxnVbNpOezKXdrP0j0Y5kw5XTw8QaR6jTKRO9
 SQxxDFu334h6fA0cdLi1Z8tanP4urOUdp58Kg8BLKciAJHzNpvUOIr5Zd+niqiHLX8Yj
 WASPYIcFMXTVKQv882XVJMmWRHnpqxsEazSQv7C/hf+m6DX40cvJ1Iw8Sjy7r9kDxDjE
 4OjXjlah/JzRxp4DSb/nhHOycUnrux6dFBohew1Fdri9vCbEY7nB+txrEtxIGQk7vfpd
 UyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384521; x=1704989321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnUpQLZU43UMHi7KSxzqXqyNfCHjYuiQzoZigtRlS5I=;
 b=rohyOyhMIcEmqrZAVpvEG6BJGE1SCIP6d1oOrRK2cseIZcsCl9xjwEC1bp7VEAGSBB
 w+ONg99KgyXlqpC91T6r8LhqpyE8QO2bx6VcFybZ7hXay2554MyyZ4VqW8eGNsFj3wQn
 BcAKcW1QOs2dqvysFUcRlMa1XcN/CXCljxKVasgDP6IfeMQFWTIr0Ut0MtGfC4JC21pc
 8pw5EZ+gW5b/Gc89uOxdmh7XwdJjtjWeY/96dacXXFNmj+28qdVUXBImXS0XPo6ZCPGf
 T30LbD3MF4vQlzM5apvAN6KvZxa2s8RoYMzA1vdhLhC95u6uMeTxXkiJ17w73ED4fMyV
 WBig==
X-Gm-Message-State: AOJu0YxEdII5m2oILwf1Cesl1IHrCw7yj9R4yvSV1OhcSNnCGjSfQxgq
 0oJfWLHom9QcvWorDe/7RJnVgV1Y03yqRGf+7bK4tHNSwGK1Uw==
X-Google-Smtp-Source: AGHT+IHU2939UwsXN3lyIX69HBFkSqlfAAPOlfL0+Oe03VxvY3uhnEHEI5vNF4vatJUFWwkNDCUbmg==
X-Received: by 2002:ac2:4e91:0:b0:50e:7a9e:4846 with SMTP id
 o17-20020ac24e91000000b0050e7a9e4846mr417337lfr.70.1704384520790; 
 Thu, 04 Jan 2024 08:08:40 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 ey18-20020a1709070b9200b00a26af6131e0sm13162492ejc.7.2024.01.04.08.08.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Jan 2024 08:08:40 -0800 (PST)
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
Subject: [RFC PATCH 5/9] scripts/ci: Restrict libpmem-devel package to x86
 hosts
Date: Thu,  4 Jan 2024 17:08:01 +0100
Message-ID: <20240104160805.56856-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240104160805.56856-1-philmd@linaro.org>
References: <20240104160805.56856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

libpmem-devel is not available for all host archs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/ci/setup/build-environment.yml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index 9518cc55a5..280e67593c 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -247,7 +247,6 @@
           - libiscsi-devel
           - libjpeg-devel
           - libnfs-devel
-          - libpmem-devel
           - libpng-devel
           - librbd-devel
           - libseccomp-devel
@@ -318,6 +317,14 @@
         - ansible_facts['distribution_file_variety'] in ['RedHat']
         - ansible_facts['distribution_version'] == '8'
 
+    - name: Install arch-specific packages (RH family)
+      dnf:
+        name:
+          - libpmem-devel
+      when:
+        - ansible_facts['os_family'] == 'RedHat'
+        - ansible_facts['architecture'] == 'x86_64'
+
     - name: Install Spice packages
       dnf:
         # Spice server not available in ppc64le
-- 
2.41.0


