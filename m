Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FE18245D4
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:09:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQH6-0005cU-3o; Thu, 04 Jan 2024 11:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQH4-0005Y4-8G
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:50 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQH2-0007v5-KC
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:08:49 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55569b59f81so826907a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384527; x=1704989327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAyCjySFzZ3CNc8Qdm5h2VyZtXHoxnVH1y+Hjj72MB0=;
 b=sP+7+tvyPZ/EFkoXFmtfyYmsdvjUYLh9TH1zu11IcWXDMCsgsGJhhY886in20e7Wws
 1GeU3Pm5+iqvKabh59lJkHo9pm6a2tqu48QK3g3wDu3aSNoMqRzm7getk1+Uu6JPtR34
 7uDF0CBkzFlKZrVoqWYCzPVm2QEikQCb3SL747LdPYZ8eHTKn8lZVXzptJc5SqnE1/mp
 xif6JoIMQqt4VP2Vqn3yVxCyuzxAXiZQHfcytUG6GkdA9kBMJKbBzr7G+P5d0SZ1JyrV
 Q9WzVNQpn6zg+kgjnax+vhMFfn3s59jz6MwmLzM9Es9a9LExoRG1T00LKxnP9hq0cBh8
 7/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384527; x=1704989327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WAyCjySFzZ3CNc8Qdm5h2VyZtXHoxnVH1y+Hjj72MB0=;
 b=iIMP9axw+9oE1gQhDiprd3bIHkti3jGM99MO+qpJKYsgz+BO0ys9vw8rt6Oif0vPQc
 3y4nkPRcmeVfsKmmS7hhUdeJiDzYWfUGFa2kUG7jUnHJC4whE7JloRZDN+LDf8eisiwJ
 5wDcRwiq4R+SSAFpbFQ2qwqMfH4HZOTXVMPqqMGOJeNndjYuMe4j9tev7Rb61nRagYW5
 eE3i2F2uMbk3wm2UhxbWn+gyEwH7xCupk42Upv8jLC+FQihH6A2OsaW+rn8csEeCd61a
 H2pULYKqeMY98pUlbZenLH7B+PsUBTxJa0OTDFLHCKzooco+rh5fUopQ8vBjVd/GvMSI
 wRIg==
X-Gm-Message-State: AOJu0YzYABrXET3c+lQ1Ac12WxijF9qLBBh/NT26k79TCMZqkbVQAtjR
 9gP6wRxr6t4WrVOmPLTAMs7qmhpd2Rk+azWNqu/eomJOofEB9A==
X-Google-Smtp-Source: AGHT+IFL+MLZUkIhWxy5OKZePUx0WrJ7EDjnuObJb1mSRoDkD/hgsNxYK1RNhHyAYGjZ0kK0XCkxvQ==
X-Received: by 2002:a17:906:bfc8:b0:a27:e6c8:7f19 with SMTP id
 us8-20020a170906bfc800b00a27e6c87f19mr449648ejb.50.1704384527160; 
 Thu, 04 Jan 2024 08:08:47 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 cl2-20020a170906c4c200b00a19afc16d23sm13812256ejb.104.2024.01.04.08.08.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Jan 2024 08:08:46 -0800 (PST)
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
Subject: [RFC PATCH 6/9] scripts/ci: Install libxdp-devel on x86 hosts
Date: Thu,  4 Jan 2024 17:08:02 +0100
Message-ID: <20240104160805.56856-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240104160805.56856-1-philmd@linaro.org>
References: <20240104160805.56856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

libxdp is arch-specific, and in use since commit cb039ef3d9
("net: add initial support for AF_XDP network backend").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/ci/setup/build-environment.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index 280e67593c..8a6855f472 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -256,7 +256,6 @@
           - libubsan
           - liburing-devel
           - libusbx-devel
-          - libxdp-devel
           - libxml2-devel
           - libzstd-devel
           - llvm
@@ -321,6 +320,7 @@
       dnf:
         name:
           - libpmem-devel
+          - libxdp-devel
       when:
         - ansible_facts['os_family'] == 'RedHat'
         - ansible_facts['architecture'] == 'x86_64'
-- 
2.41.0


