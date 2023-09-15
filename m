Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE0A7A26CD
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 21:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhE3A-0005l0-Ex; Fri, 15 Sep 2023 15:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhE36-0005kW-Kv
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:00:16 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhE34-0007TT-QW
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:00:16 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52c9be5e6f0so2828572a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694804412; x=1695409212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Debqhd1KkXYkBU83fGVykCcugVwbCT/5D+O9otxBzPI=;
 b=o+IvfVkz92mStd2BWYBBWV3ME+WuYkjRybnrCgFzjsaGxbtk2yTG7YAXCcOJ6ks3ul
 Idg08zHtOKEdVtL8bXrIFkRD3opQnHUnRd27nl7aToi+HnuSm3SngukW5O7ag3NYUaXH
 jcgQE7tqeNvgse+85hWHpJOzoAIL4YV1MoNab+tD4Z4Fzm1NRadiboBrz7OIkAc6rh1j
 8cgJ4eb30doj5y9m+7sWV1Lt8iWoIKg2dXfdGeI+CLo0OV2+0xANTGKExkECIF+hPnOz
 cMervRhbeqlO8Ggax6dsB8fEI0lNQJkTbI+IQ9psewVhX+Tr5lBznC0fmE6NveauVP6/
 zLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694804412; x=1695409212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Debqhd1KkXYkBU83fGVykCcugVwbCT/5D+O9otxBzPI=;
 b=w2NWFOx0d19z7ye4qyAqj1NQy+ZL7EsJ5C+56lK4sOXYXadcKkuld6/C1M3HmjvPO8
 te23Bl+cTWefU2XCVuPNt9AsgiiMjLpORxbEWa1T3ZgdlFjywsZumVfysyLxv8bVEYcQ
 hzUvjA00FpHbF7nLAM9MGnNynaCtEfuZP8wmtre3DdlaM0Cjv9Crt3fkljSyKpf/V7Lw
 Lmea1JsiYvaBSvcU6kCqjqAh+09FGEgB+dwOKW6qZ27/TBNuW5ePhakpmtedct2DESDo
 00bPoKsT+kzjp7UYQcla4/zGydfv5e7PUf0cFfmHOYZieFNmQnHEy8pgyRWunQbvzYOH
 yuvQ==
X-Gm-Message-State: AOJu0Ywbvy5dbZclXnGmOG3J2CdBax+oyQ49sA7jAryWYDEDMBpcIQbt
 qdfqUpPODE5MqVYK91eQDVHFr7FHhBxEOomngu0=
X-Google-Smtp-Source: AGHT+IGt5AzYFdBLKwH4Y9IdNxzFm3HVuqcd7U4qlrCx0cG68aiVuPLcb9/hAMghxoQnz/mu3JWZNw==
X-Received: by 2002:a17:906:51cc:b0:99e:1358:ffdf with SMTP id
 v12-20020a17090651cc00b0099e1358ffdfmr1851110ejk.72.1694804412476; 
 Fri, 15 Sep 2023 12:00:12 -0700 (PDT)
Received: from m1x-phil.lan (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr.
 [176.171.209.234]) by smtp.gmail.com with ESMTPSA id
 rp9-20020a170906d96900b0099e05fb8f95sm2760571ejb.137.2023.09.15.12.00.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Sep 2023 12:00:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 0/5] accel: Restrict tcg_exec_[un]realizefn() to TCG
Date: Fri, 15 Sep 2023 21:00:03 +0200
Message-ID: <20230915190009.68404-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

- Add missing accel_cpu_unrealize()
- Add AccelClass::[un]realize_cpu handlers
- Use tcg_exec_[un]realizefn as AccelClass handlers

Philippe Mathieu-Daudé (5):
  accel: Rename accel_cpu_realizefn() ->  accel_cpu_realize()
  accel: Introduce accel_cpu_unrealize() stub
  accel: Declare AccelClass::[un]realize_cpu() handlers
  accel/tcg: Have tcg_exec_realizefn() return a boolean
  accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG

 accel/tcg/internal.h      |  3 +++
 include/exec/cpu-all.h    |  2 --
 include/qemu/accel.h      | 12 ++++++++++--
 accel/accel-common.c      | 27 ++++++++++++++++++++++++---
 accel/tcg/cpu-exec.c      |  4 +++-
 accel/tcg/tcg-all.c       |  2 ++
 cpu.c                     | 13 +++----------
 target/i386/kvm/kvm-cpu.c |  2 +-
 8 files changed, 46 insertions(+), 19 deletions(-)

-- 
2.41.0


