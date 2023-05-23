Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E81770DD07
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:52:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RTO-0007eK-0i; Tue, 23 May 2023 08:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RTJ-0007av-Us
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RTA-00058e-RF
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30957dd7640so3064736f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684846201; x=1687438201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bo4wEssufY7OMcqJPelA5xe5fr2l354WhOFpd2OibS0=;
 b=OiSkVvt3RM/f2XYuOozuHZ0+/TM1VRnSoEKpFCleAQ3tpH2Gjq1zRPC1aW9Xd41wkb
 GsdDGqYjYrnxXxbQDU91LK+cz/7OmsuqlLO2psLMZahVOtIVG+4QVH9kPyMc6QvH+UHO
 0L5lnye79xdxRZS7xTEbge8IQ/fW72jUlWdO6odmclTv2yD0yRX8ZH1Wk0u7WHlH/XOw
 bMIJKhvolpCDuW2Kc8Asp5VpGGyIoavMLCcjZpL3Zcp4oGw8h3sU8OuilcyijgfO3Qkb
 x8aDntnckP7R+5UnZojrPooscSyl9FglNEpWF8jJEMbaCKOR28U44R1Lv98QUCYYV1Ir
 nWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684846201; x=1687438201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bo4wEssufY7OMcqJPelA5xe5fr2l354WhOFpd2OibS0=;
 b=G9vfoqYjGM64qnNQRBa/Zie+EkSIRhEzfC6wf975pu+7qWMRUdi3fj5Br3hR5AXOIx
 s5HO7VphLGhthDEgrgDhK8FB6un4fSpstYy/3zLEvG3nMHxLgzpjbCpOS6B3vcl7PdQc
 NyyOk45gBpP34QqxrJR4cWkZ8cKmQsCAAFaJyuvfGwsIsdr3bolyClqhbN6sJtkIE7lm
 tL5PmsNVMp3btrbEJXN/22HzAGFw/n3FwXLyImndZmKbdYG2S4BK0mAa06K89SLm29Gf
 R8xGk9JqfzGJV0+eZIDPCqBJgOPZX6KV3jlQ69/sBq28/6pBE8Zl7XD39WcVXdQYwL0Y
 GuwQ==
X-Gm-Message-State: AC+VfDxuj4tiUv/FuCWjoGDUiVd64WAszUSZjzqc9TtQzf6rKEBn0li9
 rrx6J/NSDSOa4krWNwKvi6VEgA==
X-Google-Smtp-Source: ACHHUZ7mXDj1oNY0/uutaF/VjKeaZkbtrsfDMw1CXSeLTG+rbpeqhMnT7idzMWOWAfIJqnojJQzCHQ==
X-Received: by 2002:a5d:4e8c:0:b0:306:37ec:656c with SMTP id
 e12-20020a5d4e8c000000b0030637ec656cmr10499935wru.66.1684846201635; 
 Tue, 23 May 2023 05:50:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i14-20020adffdce000000b003095bd71159sm11193034wrs.7.2023.05.23.05.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:50:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E1D5F1FFBB;
 Tue, 23 May 2023 13:50:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Eric Blake <eblake@redhat.com>,
 libvir-list@redhat.com, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 00/10] tracing: remove dynamic vcpu state
Date: Tue, 23 May 2023 13:49:50 +0100
Message-Id: <20230523125000.3674739-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Hi Stefan,

The references dynamic vcpu tracing support was removed when the
original TCG trace points where removed. However there was still a
legacy of dynamic trace state to track this in cpu.h and extra hash
variables to track TBs. While the removed vcpu tracepoints are not in
generated code (or helpers) they still bring in a bunch of machinery
to manage the state so I've pulled them out. We keep and rename one
(cpu_reset) to a static trace points which dump vcpu->index as it is
useful to f4bug.

v4 addressed Markus's comments on QAPI bits and other fixes during re-base.

Please queue into your tree.

Alex Bennée (10):
  *-user: remove the guest_user_syscall tracepoints
  trace-events: remove the remaining vcpu trace events
  trace: remove vcpu_id from the TraceEvent structure
  scripts/qapi: document the tool that generated the file
  qapi: make the vcpu parameters deprecated for 8.1
  trace: remove code that depends on setting vcpu
  trace: remove control-vcpu.h
  tcg: remove the final vestiges of dstate
  hw/9pfs: use qemu_xxhash4
  accel/tcg: include cs_base in our hash calculations

 docs/about/deprecated.rst     |   9 +++
 qapi/trace.json               |  38 ++++++------
 accel/tcg/tb-hash.h           |   6 +-
 include/exec/exec-all.h       |   3 -
 include/hw/core/cpu.h         |   5 --
 include/qemu/xxhash.h         |  23 +++++--
 include/user/syscall-trace.h  |   4 --
 trace/control-internal.h      |  10 ----
 trace/control-vcpu.h          |  63 --------------------
 trace/control.h               |  48 ---------------
 trace/event-internal.h        |   2 -
 accel/tcg/cpu-exec.c          |   7 +--
 accel/tcg/tb-maint.c          |   5 +-
 accel/tcg/translate-all.c     |   6 --
 bsd-user/freebsd/os-syscall.c |   2 -
 hw/9pfs/9p.c                  |   5 +-
 hw/core/cpu-common.c          |   6 +-
 stubs/trace-control.c         |  13 ----
 trace/control-target.c        | 109 +++-------------------------------
 trace/control.c               |  28 ---------
 trace/qmp.c                   |  76 +++---------------------
 trace/trace-hmp-cmds.c        |  17 +-----
 util/qsp.c                    |   2 +-
 hw/core/trace-events          |   3 +
 scripts/qapi/gen.py           |   8 ++-
 scripts/tracetool/format/c.py |   6 --
 scripts/tracetool/format/h.py |  16 +----
 trace-events                  |  50 ----------------
 28 files changed, 86 insertions(+), 484 deletions(-)
 delete mode 100644 trace/control-vcpu.h

-- 
2.39.2


