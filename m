Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC07AACA976
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Jun 2025 08:24:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyZQ-0006Qf-4R; Mon, 02 Jun 2025 02:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLN-0006d7-3Y
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:42 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLK-00025o-NR
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:20 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso3434090b3a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 23:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748844497; x=1749449297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IAXt1W/zUR31UqhhUYbswiahGjC6fEsaj/iooiJKKuY=;
 b=Tq1pKY2tQZ5UxQagO89cKM3e2GurmsXeTyYV+uuirU3ZegDyECoKxMylXPfdrxll2o
 gO/vpOMiK2pUpxp6ovhwvjus1Bpa2k1S/or/q3TprDAK0XJyA72i1lCgJ7eOk7ZPZAXg
 QGwTwGDiKluxreo/OKJgboPzz1SXM5ssMHfUwD7Gs2CpGy1oz8WjEN9LrJSKQliYh3pv
 XbbT44DBOSv39wy/ZZ+9Wa96/RsimKudJUGr3LqYWRHTjCcmkaZYjU2pv/pu0+magQyX
 w5ReBBCM+DQlA2mkUcFoTpNnWnlL3fCHZGpXmYaGRpOi5vv+I6Y0kS0+qdoe5vd+l2n7
 vN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748844497; x=1749449297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IAXt1W/zUR31UqhhUYbswiahGjC6fEsaj/iooiJKKuY=;
 b=eoy+j/rGtTqxvSnH8jvBeLvYo5ERxcv+FDzkYRhf+4AN2NGqzPpKArZvbsikAhfjI8
 XyRHBjhviVe3N8J9q3QkZLFzKI+UEgxRdT0UMlR+JJ73lKzhCHz4U+JEIPiZ7M6Xb+uP
 YKF1a/7iwmNHuFhws0DPhWnFbap6L9AYVEdTnqRnFbsrmdpEtFLwO0Na6Npfmzv1rMyp
 J2kUKcYlErIKYhuhBVgLPRQaD9lWFxCOZkpHlq2Q68UUF8iT/EPRYwOmlV5FbZA+BT1S
 YFTj+QIdR1r+3Q+n2//dEfM1NgeZ18rcHieZFYawnr1Y8Pst+LL3h1xvD2emRqgQRd85
 NSeQ==
X-Gm-Message-State: AOJu0Yxuc274ECvw18TcKWak4qNQBoJ+pBhmb7dgPUehA0w4aZokTBc/
 z0vXVDlNhzNQVEaF6fnioZypcOGdOadIjjTDVv6jRv5c2DdnYnoTBfQtUm9DCpRXL8A=
X-Gm-Gg: ASbGncv8yJg4SzHS73J2/cp+407W2NSoo1XR4fZM5MY9RsZEujUlfSWzRJdNYl0YZZG
 S1eW5qGsPlkLgByEW04yyThlfx5qG3inhgV8zb9nfi0JAprh0NDDKeXmm+BT+S17e78dN7Boazj
 LbNDLOJ6W+bP/rODpMCoyBgsUsxcj4/byERbCXYgUl2jP3MCEsMMGM0pu7a+vnI0WTcMdtKht9C
 MzHSV/EtdFtjKyofvPG10ftDRM4pZ6t63IjJ6xQYxANF4rKtrq2LFekVuCslCfEkngQpQwY5c+k
 5VdnOOvnjUf4Ct0BlBVSJ9uOUSnf1HEGBMbGl3x/O10aeYKvfyGg/Mxf5ZDbFeYmVGoFe/xJ
X-Google-Smtp-Source: AGHT+IHDTIX/35oHZp1s5UJjWftj3wZjVBNRu05Od5wgdTaHWDUUd6LGhLgTQbloJdbWE04+INIsOA==
X-Received: by 2002:a05:6a00:2d24:b0:746:25d1:b712 with SMTP id
 d2e1a72fcca58-747bdd85e08mr15402310b3a.7.1748844496649; 
 Sun, 01 Jun 2025 23:08:16 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afff7388sm7036966b3a.171.2025.06.01.23.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 23:08:16 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v6 0/9] Add additional plugin API functions to read and write
 memory and registers
Date: Sun,  1 Jun 2025 23:08:06 -0700
Message-ID: <20250602060815.328261-1-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch series adds several new API functions focused on enabling use
cases around reading and writing guest memory from QEMU plugins. To support
these new APIs, some utility functionality around retrieving information about
address spaces is added as well.

The new qemu_plugin_write_register utilizes gdb_write_register, which is now
declared in gdbstub.h for this purpose instead of being static.

qemu_plugin_write_memory_vaddr utilizes cpu_memory_rw_debug much the same as
the existing read_memory_vaddr function does.

The read and write_hwaddr functions are the most different. These functions
use address_space_rw, which works well in most cases. There is an important
caveat that for writes, the page being written will be set dirty by the
write operation. This dirty setting requires locking the page range,
which can contend with an already held lock in page_collection_lock
when called in a tb translate callback with a write to the instruction
memory in the tb. The doc comments warn against doing this, and it's unlikely
anyone would want to do this.

I've also added two test plugins: one that implements a simple hypercall
interface that guest code can use to communicate with the plugin in a
structured way with a test to ensure that this hypercall works and writing
virtual memory works. And one that implements a simple patch utility to patch
memory at runtime. The test for the second plugin ensures the patch applies
successfully to instruction memory, and can use both hw and vaddr methods.

For v3, I've had a few comments from the last submission that I've addressed,
and some that I haven't for one reason or another:

- Enforce QEMU_PLUGIN_CB_ flags in register read/write operations: done!
- Fix my commit messages and add long messages describing commits: done!
- Un-expose AS internals: done! Functions operate on current vCPU, current AS.
- Clean up use of current_cpu: done!
- Make functions take a vcpu_idx: not done. May revisit but it allows footguns.
  Even for translation, seems best to not do this now. We can easily add _vcpu
  versions of these functions in the future if we change our minds!

For v5, I've just updated the enforcement of the QEMU_PLUGIN_CB_ flags to just
use immediate stores, which simplifies the implementation quite a lot and
should be more efficient too. Thanks Pierrick for the suggestion!

v6 is a formatting pass, I left some whitespace that needed removal, some
license text was wrong, and so forth.

Rowan Hart (2):
  plugins: Add enforcement of QEMU_PLUGIN_CB flags in register R/W
    callbacks
  plugins: Remove use of qemu_plugin_read_register where it is not
    permitted

novafacing (7):
  gdbstub: Expose gdb_write_register function to consumers of gdbstub
  plugins: Add register write API
  plugins: Add memory virtual address write API
  plugins: Add memory hardware address read/write API
  plugins: Add patcher plugin and test
  plugins: Add hypercalls plugin and test
  plugins: Update plugin version and add notes

 accel/tcg/plugin-gen.c                        |  30 +
 gdbstub/gdbstub.c                             |   2 +-
 include/exec/gdbstub.h                        |  14 +
 include/hw/core/cpu.h                         |   1 +
 include/qemu/plugin.h                         |   4 +
 include/qemu/qemu-plugin.h                    | 166 +++++-
 plugins/api.c                                 | 135 ++++-
 plugins/core.c                                |  32 +-
 tests/tcg/Makefile.target                     |   2 +
 tests/tcg/plugins/hypercalls.c                | 547 ++++++++++++++++++
 tests/tcg/plugins/insn.c                      |  22 +-
 tests/tcg/plugins/meson.build                 |   2 +-
 tests/tcg/plugins/patch.c                     | 297 ++++++++++
 tests/tcg/x86_64/Makefile.softmmu-target      |  36 +-
 tests/tcg/x86_64/system/hypercalls-target.c   |  40 ++
 tests/tcg/x86_64/system/patch-target.c        |  27 +
 .../tcg/x86_64/system/validate-hypercalls.py  |  40 ++
 tests/tcg/x86_64/system/validate-patch.py     |  39 ++
 18 files changed, 1386 insertions(+), 50 deletions(-)
 create mode 100644 tests/tcg/plugins/hypercalls.c
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/hypercalls-target.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/tcg/x86_64/system/validate-hypercalls.py
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

-- 
2.49.0


