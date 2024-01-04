Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B07EF8245D6
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:09:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQGj-0005N8-8b; Thu, 04 Jan 2024 11:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQGf-0005Ms-DV
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:25 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQGd-0007rq-R9
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:25 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5571b26fda8so88691a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384502; x=1704989302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJy7Wt2jc64lOn7AtGOipdtRDw6Xrpk77ZRRAYTrF5g=;
 b=psD/FvDaRQe0BLhbKL6geGuyLkiidNSi8ZfGM59z5mwE3rfKULhwzqi8kDJ39IzC4P
 TqhTHap0FrYPyW41XAAek8LhlcNyJMDOu2TwP+/yzyANrGCkN7LJN1K8Zl0DiuKXp1rl
 BfR8cpjobr8ELrPheFYrXUSzO9ufyBl5gtmk8r6U0sAutDwi5rea+Oa11N6keuw3r5dA
 rIf4/vQ3QeLcm5VS8k86ncM+RoZJmkoAhxDz+fPHwq/GlKw9/Nq70Y+5bFgJROB0ZVE1
 5f1roz7atJ+mmgdMdEvghqiv7jpFpTOWLTqRnetTli39+xzI+phdKt0t+0Q8lOkbRyOv
 +e/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384502; x=1704989302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJy7Wt2jc64lOn7AtGOipdtRDw6Xrpk77ZRRAYTrF5g=;
 b=FDprW2Fex67Z/B+VET53hRrbsEJH+oUHEhBTsoLftHrDCCy0UvaTAUt0rOG5y0SyZW
 BWV4XU4Ay0yzzOyvWKpQB3jasHSMltMZr0QXvTssDYinE3BpLjAxPS1aXUU+QOnL2CTp
 Hiq38lVSMppWro1PjKWtQH2e1aF2TbbA1WnQ20iXPgYF00dnjdk9kpW/mUzb44VsI2we
 jOIbTxcV4Ob9FV3FX5urx5W2R0VZGKuQt0I6mAhjQlFcBM8BJXXXE9QJebb9qRp+jyl1
 UH16g+ton7JFK9dhy40QtYHYyLIF+sCV2+pHWcEkdjsDs7qIWGjeBZ/k+pwwsYQecFve
 jfUg==
X-Gm-Message-State: AOJu0YzOa7a5dVfvPuCdaoql20Di6g3T/OJMMpwvTOTUuLx4CpDtSeeE
 FOyE7DqKcNZj1WQvwhj7iy06ga4WA65fCAv3z8HdGqGkOinQvg==
X-Google-Smtp-Source: AGHT+IHzvpJoZUeKiFq7SvCj6LKf3KkadyCVPVLgMMfjhGB+xnTqjqCTFMa0VlyRoUOn4AE5Hch/LQ==
X-Received: by 2002:aa7:c9d0:0:b0:555:3b98:7540 with SMTP id
 i16-20020aa7c9d0000000b005553b987540mr549634edt.33.1704384501967; 
 Thu, 04 Jan 2024 08:08:21 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a056402044200b005553a8bb61dsm12178417edw.87.2024.01.04.08.08.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Jan 2024 08:08:21 -0800 (PST)
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
Subject: [PATCH 2/9] scripts/ci: Do not restrict spice package to x86/arm hosts
Date: Thu,  4 Jan 2024 17:07:58 +0100
Message-ID: <20240104160805.56856-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240104160805.56856-1-philmd@linaro.org>
References: <20240104160805.56856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

Allow installing spice-server-devel package on any non-ppc64le host,
as per commit  556ede028d ("scripts/ci/setup: spice-server only on
x86 aarch64") describes: "Spice server not available in ppc64le".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/ci/setup/build-environment.yml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index f344d1a850..32ac0a74f4 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -249,7 +249,7 @@
         - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
         - ansible_facts['distribution_version'] == '8'
 
-    - name: Install packages only available on x86 and aarch64
+    - name: Install Spice packages
       dnf:
         # Spice server not available in ppc64le
         name:
@@ -257,9 +257,8 @@
           - spice-server-devel
         state: present
       when:
-        - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
-        - ansible_facts['distribution_version'] == '8'
-        - ansible_facts['architecture'] == 'aarch64' or ansible_facts['architecture'] == 'x86_64'
+        - ansible_facts['os_family'] == 'RedHat'
+        - ansible_facts['architecture'] != 'ppc64le'
 
     - name: Check whether the Python runtime version is managed by alternatives
       stat:
-- 
2.41.0


