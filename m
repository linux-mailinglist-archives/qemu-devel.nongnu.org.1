Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 637778245DA
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:10:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQHM-0006Em-PQ; Thu, 04 Jan 2024 11:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQHH-0006D8-9a
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:09:03 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLQHF-0007w7-KS
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:09:03 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-556fc91aba9so914406a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384539; x=1704989339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkyRoAukzzjNZxJCvjtQL25l3Xz55vUpwmGgfR+jaus=;
 b=Cx6qikXKF5+si1ZJlYttz90fGOl6RLHXf6gfEONgppRawitvbVpBO5RiEjXJbHqjp5
 XINnVDMfyO3mGdAbypz9bxvUSglPs+jRHBNgMvJ7zZbPNVKeQxyJjtRhoQyV6vet7YLh
 SsMDjyj9UfvvjJ6twnVED0ObhtwNqiIms4VBdrVEjE/niclMiWBy17gm8CL/Lr0FVbVi
 upljEmneFsspSUbsXV/vGQ5fsLXdPgvaUQtqXVgHZ/kEZdKOX9TW3Q9bZ3upTgUUoPoI
 BKfXLYixI6btcKep45L4BBl5X6w5YPXonJXwNxO87zQQA394u3NXwmsyfSHodHDZZP47
 OZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384539; x=1704989339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FkyRoAukzzjNZxJCvjtQL25l3Xz55vUpwmGgfR+jaus=;
 b=SAbM2wn5KsvAXvg+FKAUZjWz4pCMcDiirwGQx2KJ4SGmAA9Tg7kp2xo2oks3WUZtOO
 Sb8uZ8K1RcQJAsPZcArVeLv4LAvCn3Fsaj5sON4ooJErJCMFzmzq2/nDaeiYmP2z6l1J
 GLvAU3R2pHbpgSTGnN4gopTgMxymnGB6VFxPLsGYbKFg9DJTFCuONJAPwic0lf3atkUp
 E4t76hmWJVCBMIZHASLq62p1aMhxxweLaamAuKrM9deJWRdPOg87nkd0sAd8VBmZma2e
 u3QmcyvbhzECAfzhjUsiEVM2DfR01tmGaAOyKGFVKqoaovZKeUxau1bm/enBJc4BzAjA
 Zlrw==
X-Gm-Message-State: AOJu0Yy7WxwOeZPmVKpGFzSCMmpoi7nDbhiaKDEBIygjGNRqH9wJy5We
 QW01qhnpeb6KkUJv5LyFfxzn1m+G5ggjR6vjoiOB3EUU2m5nTQ==
X-Google-Smtp-Source: AGHT+IGwi1PuBKL6dOJHv1Wnt0YJi4FSD5s5HByeUtPp5neS5KlxfclHX1EGDGPd+Y4/se8DyOShfg==
X-Received: by 2002:a17:906:4089:b0:a28:b085:bea with SMTP id
 u9-20020a170906408900b00a28b0850beamr452711ejj.53.1704384539816; 
 Thu, 04 Jan 2024 08:08:59 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 fw34-20020a170907502200b00a28da51438asm782859ejc.157.2024.01.04.08.08.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Jan 2024 08:08:59 -0800 (PST)
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
Subject: [RFC PATCH 8/9] scripts/ci: Update Ubuntu packages list
Date: Thu,  4 Jan 2024 17:08:04 +0100
Message-ID: <20240104160805.56856-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240104160805.56856-1-philmd@linaro.org>
References: <20240104160805.56856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

Update Ubuntu 22.04 package list running:

 $ lcitool variables -f json ubuntu-2204 qemu \
   | jq -r '.pkgs[]' \
   | xargs -n 1 echo "          -"

On libvirt-ci commit e9e7d3bf ("facts: enable gtk-vnc2-devel
on almalinux 8 / centos stream 8").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/ci/setup/build-environment.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index 6baa539b46..988aef3a07 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -58,7 +58,7 @@
           - git
           - hostname
           - libaio-dev
-          - libasan5
+          - libasan6
           - libasound2-dev
           - libattr1-dev
           - libbpf-dev
@@ -94,6 +94,7 @@
           - libnuma-dev
           - libpam0g-dev
           - libpcre2-dev
+          - libpipewire-0.3-dev
           - libpixman-1-dev
           - libpmem-dev
           - libpng-dev
@@ -139,6 +140,7 @@
           - python3-pip
           - python3-sphinx
           - python3-sphinx-rtd-theme
+          - python3-tomli
           - python3-venv
           - python3-yaml
           - rpm2cpio
-- 
2.41.0


