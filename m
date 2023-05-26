Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D3B712B20
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:55:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ahe-0002wW-K8; Fri, 26 May 2023 12:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2aha-0002vY-Oc
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:06 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2ahZ-0002Fk-6a
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:54:06 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30ad8f33f1aso550468f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685120043; x=1687712043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aNgvF1U6DPPWVuKO08h1QsvUdyYGXngalDac3kMNIfs=;
 b=A+ronVnHN0aE07c7PKZ8yDmF/T+akdw63yz8NWqKUId5mcdhQzxxncFJcpvsO2L28B
 5VrghQtupeSDu5OJk0DS7VXyjw8uERYfYy2pdAn6tDrRLtYFewm4hUWhqr1T65RDq4Lp
 6pMLcT2Dhk/h2wQmpDQUWqgi/MtLy/nSOv/UBYLn4CKZBT+TXiXOlsoiVoPoELVeUZIH
 hyPt8QPZUECxBbhguWL3+E9IU5Xh6lF5zFRp9WAYNsXOn/XMjZVyDWD5EbKYHJxfedW4
 wkzhkuegydVbm03rnPjHEuQ2lKpiApw80cSolYM+ypCs10GLtVJ/s5iXDAhNijmiGL7i
 655A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685120043; x=1687712043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aNgvF1U6DPPWVuKO08h1QsvUdyYGXngalDac3kMNIfs=;
 b=cudtvDQN6CuZeNwA6OvTVLIBTdm0DpZ9kQnn5sGeoJw6f4Un3kKvC0oPDGRP5wfXBv
 a4yDL/OsaYdap/9DjQepHjnuYKIz7i1sadtbMg4zbxzIjLhuXpUIo0SWoOwXh1DevzSe
 o8G8/au2nfU3UfQYH12zQaM7Uk4QCNnR2SWkdrh6/OWE/8PumGJ48cAVOnsPxk0Xphib
 inpweVlZT3LGIjzC459aC1d95rOoccm8N0Y+3wJmNtXqQ2j67gkiFIL5RaY6GW1CMQjA
 R7u4wpnzGrYnhn4jLplhlYk6ne8tmEcKu3DI6ZPJvUCz6Ex7J0CzMbfFHz5Uemo+Mvet
 UYPA==
X-Gm-Message-State: AC+VfDy3s1jlw3cMcpqWeAswmHMPD1S/KzOiUXBZ+XomwT1mGdDn+ib0
 UmCkzxTrsq3fyaZIHWs4S2hduw==
X-Google-Smtp-Source: ACHHUZ4VAPQDebypG6Kb+2ocQlu8+ZrvpBdnuxCSyF5EjO6Uxv6GZ6W6lc8VYm6/IYyhHCU74F9Prw==
X-Received: by 2002:adf:f603:0:b0:305:ed26:8576 with SMTP id
 t3-20020adff603000000b00305ed268576mr2095682wrp.9.1685120042772; 
 Fri, 26 May 2023 09:54:02 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c2-20020adfed82000000b003078a3f3a24sm5647501wro.114.2023.05.26.09.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:54:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ECDAA1FFBB;
 Fri, 26 May 2023 17:54:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Markus Armbruster <armbru@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 00/11] tracing: remove dynamic vcpu state
Date: Fri, 26 May 2023 17:53:50 +0100
Message-Id: <20230526165401.574474-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

v6 new patch to shuffle deprecated, added rth's rb, qapi doc cleanups

Please queue into your tree.

Alex Bennée (11):
  *-user: remove the guest_user_syscall tracepoints
  trace-events: remove the remaining vcpu trace events
  trace: remove vcpu_id from the TraceEvent structure
  scripts/qapi: document the tool that generated the file
  docs/deprecated: move QMP events bellow QMP command section
  qapi: make the vcpu parameters deprecated for 8.1
  trace: remove code that depends on setting vcpu
  trace: remove control-vcpu.h
  tcg: remove the final vestiges of dstate
  hw/9pfs: use qemu_xxhash4
  accel/tcg: include cs_base in our hash calculations

 docs/about/deprecated.rst     |  25 +++++---
 qapi/trace.json               |  40 ++++++-------
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
 trace/trace-hmp-cmds.c        |  18 +-----
 util/qsp.c                    |   2 +-
 hw/core/trace-events          |   3 +
 scripts/qapi/gen.py           |   9 ++-
 scripts/tracetool/format/c.py |   6 --
 scripts/tracetool/format/h.py |  16 +----
 trace-events                  |  50 ----------------
 28 files changed, 94 insertions(+), 496 deletions(-)
 delete mode 100644 trace/control-vcpu.h

-- 
2.39.2


