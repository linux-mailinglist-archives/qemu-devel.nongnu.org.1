Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDF7A4765
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:43:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBhm-0002ZV-Vv; Mon, 18 Sep 2023 06:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBhd-0002Z9-Hz
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:42:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBhb-0003f0-Qv
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:42:05 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-404fbfac998so17663585e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695033721; x=1695638521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1A2I4McMyrbvruQYlutI6os3yuQBAn1zuRcOAOn6W+0=;
 b=wc4kRQ9G2QfVfkzDoRSvYF1aMQZDhOnq44s1EQs4yq+gB+Y8dogWpJVyg6czngrhhM
 4qyz5s0mSaZHno8MHydK/fmAikXTPxqUINUwscsxx9mEpMxE5bwBFhYsOTsYe1nIiy2A
 ydmIUyEduspZe1p894zTRdvtlcDI6jJGs9FjBoSM0qzURxzWKlFjibH8cwUpMNmnEsdw
 Om49dbJYJa/a4vQOhRYAwem8zlxYI1y7tQjBPkoGEhXY4OxERgDmLWuCVGjoehB7iVEi
 nV64laLMWzZym2cFY5zFlohSDD73aM4mi5HPfM0zqVP/NZTpAbtEh9tFCS5EZgx9yP/u
 wDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695033721; x=1695638521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1A2I4McMyrbvruQYlutI6os3yuQBAn1zuRcOAOn6W+0=;
 b=hMKHWpTF2aD7TQlP2pVp/aGCSsJBnIehbEa2deubCZPzC7+H9nmeii6ShmTwAm2nEu
 ZrnJxjB7b+VHlYXGzcZ+/U6IND5M9WZHq728j+mzGlSu2TrWMLUXF1rgnMpoRX9Ncm9I
 5GVs8y5P5FzjHXkf7DQH6z2yEj+AHyEP0PsnHgjQxku19Oy1jHHY+oKSGeCzFt0mP9Et
 5AGennRQyUXvZLBtJ16aAlwZWzTxofWjt7bj48+o/+GpURES0QWZ4WJWq82qBb3ow5iK
 JyrYe1Q0o1rrDmXOJrhivcMymEWauee0fttpBh5Vyq3KqEyuC6zuc8CvY/dUsvkEmEcv
 RCEA==
X-Gm-Message-State: AOJu0YzKJ4KzRu/OFFqPCJ+w0B2+P9/wViINIP7j9+jOl7yM6AB5WMbr
 UhrmWGTHUlDghC33u5zltM/vf3t8q2ra6erAPMMHAw==
X-Google-Smtp-Source: AGHT+IFlu/kVjloKMDTPRvdnQfmRTSEAOq4Mdim0ilLfSIU82vjisdBojDaLjs6b+f1oRSG1+/6M/Q==
X-Received: by 2002:adf:e78d:0:b0:314:17cc:31d0 with SMTP id
 n13-20020adfe78d000000b0031417cc31d0mr7143318wrm.34.1695033720895; 
 Mon, 18 Sep 2023 03:42:00 -0700 (PDT)
Received: from localhost.localdomain (5.red-88-29-175.dynamicip.rima-tde.net.
 [88.29.175.5]) by smtp.gmail.com with ESMTPSA id
 u8-20020a5d6ac8000000b0031416362e23sm12324622wrw.3.2023.09.18.03.41.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 03:42:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alessandro Di Federico <ale@rev.ng>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/3] accel: Factor tcg_cpu_reset_hold() out of cpu-common.c
Date: Mon, 18 Sep 2023 12:41:49 +0200
Message-ID: <20230918104153.24433-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi,

We want to have exec/ code agnostic to accelerators.
still we use various call to TCG and KVM. This series
factor the TCG code from cpu_common_reset_hold() to an
accel-specific handler within AccelOpsClass.

Based-on: <20230915190009.68404-1-philmd@linaro.org>

Philippe Mathieu-Daudé (3):
  accel/tcg: Declare tcg_flush_jmp_cache() in 'exec/tb-flush.h'
  accel: Introduce cpu_exec_reset_hold()
  accel/tcg: Factor tcg_cpu_reset_hold() out

 include/exec/cpu-common.h  | 3 ---
 include/exec/tb-flush.h    | 2 ++
 include/hw/core/cpu.h      | 1 +
 include/sysemu/accel-ops.h | 1 +
 accel/stubs/tcg-stub.c     | 4 ----
 accel/tcg/cputlb.c         | 1 +
 accel/tcg/tcg-accel-ops.c  | 9 +++++++++
 accel/tcg/translate-all.c  | 8 --------
 accel/tcg/user-exec-stub.c | 4 ++++
 hw/core/cpu-common.c       | 5 +----
 plugins/core.c             | 1 -
 softmmu/cpus.c             | 7 +++++++
 12 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.41.0


