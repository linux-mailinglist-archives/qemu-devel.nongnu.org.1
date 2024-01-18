Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C18311C3
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:25:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJ0v-0003WW-SJ; Wed, 17 Jan 2024 22:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ0t-0003WN-To
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:19 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ0r-0002Lb-Ar
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:18 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-337c5bcf79fso1015311f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705548254; x=1706153054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YFLIRk8cQqFeaeITkhRPAuwLDSg1W8/L30Om3YahACI=;
 b=Dq3a2AXkeyG4KGL1mZAo+aq+p4AW/mB4H6uClneO7Z80JXrcVoywZq8Ds2U0dHqVZH
 5oPuX9oZnH1XRiUUIIxE2irbVfD6RTZM91pqSppWQ7ek3nme7x24vSHrtL/x91maLu53
 26eM8S3Dx/Z9/MYK/Cb0ua6fRs9Zr7VrtSW9i4HoOPFnK1wJEVw49AIebwti6OHwNwM3
 KSy/FO8FxDdlpQ8STzfPuQa4UXgJdC6lTJn3roqcF1wGtjVzmU4+P8rSIq3dKHcDAlya
 nauYOBpadcylnnP0zdtQ5QzlahPf4oaPtrz6Y87PsuxysP/WwJ+5Pma9f8Xg6GEhip+L
 LXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548254; x=1706153054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YFLIRk8cQqFeaeITkhRPAuwLDSg1W8/L30Om3YahACI=;
 b=t3ANCsGoV8MdNIBnoXzGpjiomqyNN8MpsEfOsV/jZ+XdCh1kR1hUHpO+XjhmCGBIIX
 yZjDkMTo+TnlCHx1+bH26nUSufeceIjjbW7aS0l+bv5Re9uvPvIZKw71CLo4B6v1M98K
 Gt1hPHU9LvM4ttUt1x72kxIfkCplYOhIEseAh3I4CpXMcDknL169sfNKjtntahbEv5gd
 G2KsIF+3X/uVtDWRvvFILNQX9K55ft/KKlbI+o2FlOwSw4JE03TzxQ8umEbBKWM+cTb7
 3pyNbEaMPdfk8Aw06jh51QjkEpulXwix51zs2gB52rwqZc6n2JISD9HF7L9/HRinAoqZ
 JSOw==
X-Gm-Message-State: AOJu0YzWEjJtnUp1hJfzK3mi0MQ/vx8CW4l4lqWV/pNrH3keXntwDvVb
 ZBPg9PudZCJBiuWldNsxxuy85SXZOxS7DROcMHV8Z60//A0upRCeEAnpDU8cH0nk25yXw7AT/1d
 5Jw8=
X-Google-Smtp-Source: AGHT+IF5ipIOZ/PgT4eLypTmPrCP1/WucUJGycjzX3S21hhUqmQARtHqAqPAs3gEuK0mUEiVs73zPw==
X-Received: by 2002:adf:f14b:0:b0:337:bc4c:48a3 with SMTP id
 y11-20020adff14b000000b00337bc4c48a3mr99402wro.95.1705548254435; 
 Wed, 17 Jan 2024 19:24:14 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm2894292wro.108.2024.01.17.19.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:24:14 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 00/14] TCG Plugin inline operation enhancement
Date: Thu, 18 Jan 2024 07:23:45 +0400
Message-ID: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x429.google.com
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

This series adds a new thread-safe API to declare inline operation
inside plugins. As well, it removes the existing non thread-safe API,
and migrates all existing plugins to use it.

Tested on Linux (user, system) for i386, x86_64 and aarch64.

To give some context, this a long term series of work around plugins,
with the goal to be able to do basic operations in a more performant and
accurate way. This will mean to add more inline operations and
conditional callbacks.

One final target of this work is to implement a plugin that implements
the icount=auto feature, and allow QEMU to run at a given "frequency"
based on number of instructions executed, without QEMU needing to keep
track of this.

Another final target is to be able to detect control flow changes in an
efficient and elegant way, by combining inline operation and conditional
callbacks.

v2
--

Implement scoreboard API (cpu local storage), so plugins don't have to deal
with how many cpus are used.

Since plugins have been modified again, I didn't transfer any reviewed-by on
those commits.

 Branches:
          base:  upstream/staging
          topic: plugin_inline_per_vcpu

 Pierrick Bouvier (15):
       [TO_REMOVE] commit support
       plugins: implement inline operation relative to cpu_index
       plugins: scoreboard API
       docs/devel: plugins can trigger a tb flush
       plugins: add inline operation per vcpu
       tests/plugin: add test plugin for inline operations
       tests/plugin/mem: migrate to new per_vcpu API
       tests/plugin/insn: migrate to new per_vcpu API
       tests/plugin/bb: migrate to new per_vcpu API
       contrib/plugins/hotblocks: migrate to new per_vcpu API
       contrib/plugins/howvec: migrate to new per_vcpu API
       plugins: remove non per_vcpu inline operation from API
       plugins: register inline op with a qemu_plugin_u64_t
       MAINTAINERS: Add myself as reviewer for TCG Plugins
       contrib/plugins/execlog: fix new warnings

  .gitignore                      |   1 +
  Dockerfile                      |  23 +++++
  MAINTAINERS                     |   1 +
  accel/tcg/plugin-gen.c          |  64 +++++++++++---
  build.sh                        |  18 ++++
  contrib/plugins/execlog.c       |   6 +-
  contrib/plugins/hotblocks.c     |  46 +++++-----
  contrib/plugins/howvec.c        |  50 +++++++----
  docs/devel/multi-thread-tcg.rst |   1 +
  include/qemu/plugin.h           |   9 ++
  include/qemu/qemu-plugin.h      | 135 ++++++++++++++++++++++-------
  mt.cpp                          |  44 ++++++++++
  plugins/api.c                   |  74 ++++++++++++----
  plugins/core.c                  | 112 +++++++++++++++++++++++--
  plugins/plugin.h                |  13 ++-
  plugins/qemu-plugins.symbols    |   9 ++
  run.sh                          |  22 +++++
  test.sh                         |  34 ++++++++
  tests/plugin/bb.c               |  63 ++++++--------
  tests/plugin/inline.c           | 182 ++++++++++++++++++++++++++++++++++++++++
  tests/plugin/insn.c             | 106 +++++++++++------------
  tests/plugin/mem.c              |  39 +++++----
  tests/plugin/meson.build        |   2 +-
  23 files changed, 846 insertions(+), 208 deletions(-)

Pierrick Bouvier (14):
  plugins: implement inline operation relative to cpu_index
  plugins: scoreboard API
  docs/devel: plugins can trigger a tb flush
  plugins: add inline operation per vcpu
  tests/plugin: add test plugin for inline operations
  tests/plugin/mem: migrate to new per_vcpu API
  tests/plugin/insn: migrate to new per_vcpu API
  tests/plugin/bb: migrate to new per_vcpu API
  contrib/plugins/hotblocks: migrate to new per_vcpu API
  contrib/plugins/howvec: migrate to new per_vcpu API
  plugins: remove non per_vcpu inline operation from API
  plugins: register inline op with a qemu_plugin_u64_t
  MAINTAINERS: Add myself as reviewer for TCG Plugins
  contrib/plugins/execlog: fix new warnings

 MAINTAINERS                     |   1 +
 accel/tcg/plugin-gen.c          |  64 +++++++++--
 contrib/plugins/execlog.c       |   6 +-
 contrib/plugins/hotblocks.c     |  46 ++++----
 contrib/plugins/howvec.c        |  50 ++++++---
 docs/devel/multi-thread-tcg.rst |   1 +
 include/qemu/plugin.h           |   9 ++
 include/qemu/qemu-plugin.h      | 135 ++++++++++++++++++-----
 plugins/api.c                   |  74 ++++++++++---
 plugins/core.c                  | 112 +++++++++++++++++++-
 plugins/plugin.h                |  13 ++-
 plugins/qemu-plugins.symbols    |   9 ++
 tests/plugin/bb.c               |  63 +++++------
 tests/plugin/inline.c           | 182 ++++++++++++++++++++++++++++++++
 tests/plugin/insn.c             | 106 +++++++++----------
 tests/plugin/mem.c              |  39 ++++---
 tests/plugin/meson.build        |   2 +-
 17 files changed, 704 insertions(+), 208 deletions(-)
 create mode 100644 tests/plugin/inline.c

-- 
2.43.0


