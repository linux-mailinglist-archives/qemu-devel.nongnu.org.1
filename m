Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4757A0D9D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 20:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgrWp-0007ou-8Q; Thu, 14 Sep 2023 14:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrWo-0007of-6k
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:57:26 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgrWm-0007OW-Cd
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 14:57:25 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52fe27898e9so1489397a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694717841; x=1695322641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EOGtRH5OrHHNV11C5N1Q2XQkWUzQc7LaJZa+4HrbN3M=;
 b=rf1s+7C/aCieV5nztvFKY+uwrY5oAlJVkfOmI3ysNst9FjStSYijZDFrdB/iYZXK8i
 qJhhY7ijIvZxrKbE5l4Ybh7wK6Cw7rF3HYLCM6T4ThplMle+g31k/w8szEZmqBg7MJ8d
 bt5AeFje4XF/RDFZTbTF70nushhAmPAKxiJ7QZImMKClW9xywTThMEPC7xZMwQKWJwXu
 xfU+ZjKKL1Kmcg7GtBcqUqI1TlASoaa81cfi1EBhR6HsYfOsxIq+R4Lyk/Eb/MGZS46k
 z1r/Kpe4KLCgyoPPqG0tcWoQIjHXcKXSD0KBt2i+gPM86vdUkSnqU/gEZ0D7Uxm1EmU8
 hmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694717841; x=1695322641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EOGtRH5OrHHNV11C5N1Q2XQkWUzQc7LaJZa+4HrbN3M=;
 b=MXbC9wGHTMYcuYeSekMdMCBU6B+YxPl0MjYmQYVIHOBdTB9BZNZeGnR/F1amvRxuAJ
 YeJSxDIYCkIr13dHD8+03x4qyfqfkMQLUS8Gv5OYoFULDoYG6WS5/pS/g7S1GiSQglJb
 VkVB0uLjfuEs5xVWG5ItX/fLvIWuWxhAdCxXM/hC5hMKU4FL34gR+3AC5mkresF98noy
 pr37ajeiY6vs9jx92erDj+2eIHeTFy75GI/CY5KQlI4REeYpEJ7E8LmtgieUFcYWgAjg
 vbhCnLRCUXW9kUiZdUcosgcbqWJLUufMuSYkJgEcwR3OX986vvldrv0bgm3ki1Qe5he2
 kHaA==
X-Gm-Message-State: AOJu0YxGsD0BraY1SgT+i4AlKXaF858YVGyR/OZiEZ1+HAxDql0l9sr8
 FYYQ8lbMa2CnCXlpZRTg7Ahd56A92J3Jn3fzk34=
X-Google-Smtp-Source: AGHT+IHzBdLIB6vghVsLwUO+e0VS48Ll9glaTFREv17nKa9L+NZKWUs1wYny4G5IKkzMGZT0a/MkcQ==
X-Received: by 2002:a05:6402:5163:b0:523:7192:6803 with SMTP id
 d3-20020a056402516300b0052371926803mr6123381ede.8.1694717841346; 
 Thu, 14 Sep 2023 11:57:21 -0700 (PDT)
Received: from m1x-phil.lan (176-131-223-129.abo.bbox.fr. [176.131.223.129])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a056402068500b005254b41f507sm1271715edy.32.2023.09.14.11.57.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 11:57:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/11] accel/tcg: Make more files target agnostic (& exec/
 housekeeping)
Date: Thu, 14 Sep 2023 20:57:06 +0200
Message-ID: <20230914185718.76241-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

While reviewing Anton/Richard series [*] it was a bit hard
for me to figure out which headers are target specific and
"taint" the source which include them, in that we can not
compile them once for all targets.

My understanding is -all.h suffix is a target specific header,
and -common.c is a target agnostic file. I tried to consolidate
a bit renaming some files with the -target.c suffix (I'd like
to rename -all.h -> .target.h for parity / clarity, but that
is too much code churn at this point).

This series basically:
- Rename few files using -common/-target suffix,
- Move icount to accel/tcg/
- Make 3 files from accel/tcg/ target agnostic.

Based-on: <20230914024435.1381329-1-richard.henderson@linaro.org>
[*] https://lore.kernel.org/qemu-devel/20230914024435.1381329-1-richard.henderson@linaro.org/

Philippe Mathieu-Daudé (11):
  exec: Make EXCP_FOO definitions target agnostic
  exec: Move cpu_loop_foo() target agnostic functions to 'cpu-common.h'
  accel/tcg: Restrict dump_exec_info() declaration
  accel: Make accel-blocker.o target agnostic
  accel: Rename accel-common.c -> accel-target.c
  exec: Rename cpu.c -> cpu-target.c
  exec: Rename target specific page-vary.c -> page-vary-target.c
  accel/tcg: Rename target-specific 'internal.h' -> 'internal-target.h'
  accel/tcg: Make monitor.c a target-agnostic unit
  accel/tcg: Make icount.o a target agnostic unit
  accel/tcg: Make cpu-exec-common.c a target agnostic unit

 MAINTAINERS                                   |  7 ++--
 meson.build                                   |  6 +--
 accel/tcg/internal-common.h                   | 28 +++++++++++++
 accel/tcg/{internal.h => internal-target.h}   | 18 ++-------
 include/exec/cpu-all.h                        | 12 ------
 include/exec/cpu-common.h                     | 39 +++++++++++++++++++
 include/exec/exec-all.h                       | 30 --------------
 accel/{accel-common.c => accel-target.c}      |  0
 accel/tcg/cpu-exec-common.c                   |  3 +-
 accel/tcg/cpu-exec.c                          |  3 +-
 accel/tcg/cputlb.c                            |  3 +-
 softmmu/icount.c => accel/tcg/icount-common.c |  3 +-
 accel/tcg/monitor.c                           |  2 +-
 accel/tcg/tb-maint.c                          |  3 +-
 accel/tcg/tcg-all.c                           |  2 +-
 accel/tcg/translate-all.c                     |  3 +-
 accel/tcg/translator.c                        |  2 +-
 accel/tcg/user-exec.c                         |  3 +-
 cpus-common.c => cpu-common.c                 |  0
 cpu.c => cpu-target.c                         |  0
 page-vary.c => page-vary-target.c             |  0
 accel/meson.build                             |  4 +-
 accel/tcg/meson.build                         |  8 +++-
 softmmu/meson.build                           |  4 --
 24 files changed, 100 insertions(+), 83 deletions(-)
 create mode 100644 accel/tcg/internal-common.h
 rename accel/tcg/{internal.h => internal-target.h} (89%)
 rename accel/{accel-common.c => accel-target.c} (100%)
 rename softmmu/icount.c => accel/tcg/icount-common.c (99%)
 rename cpus-common.c => cpu-common.c (100%)
 rename cpu.c => cpu-target.c (100%)
 rename page-vary.c => page-vary-target.c (100%)

-- 
2.41.0


