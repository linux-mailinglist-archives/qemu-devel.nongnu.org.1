Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2529070F7E4
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 15:41:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1oii-0008HE-RU; Wed, 24 May 2023 09:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oic-000868-3e
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:39:58 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oia-0003lb-BX
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:39:57 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30a992a9c3eso622076f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684935594; x=1687527594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u9MezhkRJFa7KtuFyZF8PJAQaX7cStoJFAkEANy5Sy8=;
 b=cQu9ilBHfUMlaT756/JDVeMRmDHAxpcpJmG6qoMq9/k/kDuOCukR3mNDGt3OfxRpOy
 pX2w/+hoycFMLfH1eIzoIEye+TsMmMiu8kf/Nldrb/XAjg01ChEUP5TRsMCKi3aJtCOH
 6Ccb6d55q7O9ov57cXJW+Uki7DGHJm37YMH9no2kOHg1kE1YfzQvzc7F2azZfRsxxh1k
 iY5rPyoc3nhBkSwQx/jALoAYsOKQYR/QJIJ6c10NqxPdm+pB0inmbFfUSne7WoAjKBnf
 7jTzNX2SerrLFil+Rju5GZRV+EaYukbgTYxV1/wUHTSH0SxQUyMtgj/rCl2+1DlG6YeE
 9rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684935594; x=1687527594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u9MezhkRJFa7KtuFyZF8PJAQaX7cStoJFAkEANy5Sy8=;
 b=X3Wl+beetFTCnRuOk/h/5XXYyp3smD/HTUhLO3/NdPiOGlFy2P7a+v4Oot4KZB0+dA
 RKgpfk+8MqZdkINMir81kgDI569tmdV1LsUUZDxzEgk5qAHtGDFd5tXIGABJXSDP8O5O
 Zt5MooPiwN155hIwn96N8VsLaNQC4tT2+Nzbzz59bgTE5rYeYfiRh8FiRhOiFsm75YPs
 CYDFn4a4Cfh6+QQlrHxysOGusaQeEPgyiue0UVgIQOh6yxzR2lHnt1rh3Jhhgqmw9lSv
 e4CjNmDR5YepKpmb1m8yylh+85cNTlJ+0ir/jIRstouoIPbGExP7AsAf5jD5NfUgbU4A
 xpyw==
X-Gm-Message-State: AC+VfDxGEB+0ZPEy/EI31lcOjQYCzxU2Zk+CGcomxnb7LsFePmYvpsws
 XV2DDWkrGZHMwm5ARIsfGHJVRQ==
X-Google-Smtp-Source: ACHHUZ5Obdys4HJ6tWym+lDVfybl309huHssV/cqxXEjLFaKcvTZbhpdw49cnf3slFg7sm0C9L3oUg==
X-Received: by 2002:adf:f601:0:b0:307:7be5:90d7 with SMTP id
 t1-20020adff601000000b003077be590d7mr12821126wrp.10.1684935594080; 
 Wed, 24 May 2023 06:39:54 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i18-20020adffc12000000b0030631a599a0sm14504020wrr.24.2023.05.24.06.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 06:39:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E30E41FFBB;
 Wed, 24 May 2023 14:39:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v5 00/10] tracing: remove dynamic vcpu state
Date: Wed, 24 May 2023 14:39:42 +0100
Message-Id: <20230524133952.3971948-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

v5 added f4bug's rb, minor reword of state and rth's suggested tweak for xxhash

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
 scripts/qapi/gen.py           |   8 ++-
 scripts/tracetool/format/c.py |   6 --
 scripts/tracetool/format/h.py |  16 +----
 trace-events                  |  50 ----------------
 28 files changed, 86 insertions(+), 487 deletions(-)
 delete mode 100644 trace/control-vcpu.h

-- 
2.39.2


