Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F55718A83
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 21:50:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Ro4-00014G-Bp; Wed, 31 May 2023 15:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4Ro2-00013r-4M
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4Ro0-0002Yw-AW
 for qemu-devel@nongnu.org; Wed, 31 May 2023 15:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685562502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PtPuDT8VesHjFNdtHtyNL9SiyENtx3Qf4JgPFxAdAw4=;
 b=Bb0XwUfXzRT453Wla2e+1P8lh2WTmY3FxL/gkB+QgPdqyPAB8HdpTcxc/ix7ockumIi0q6
 Qfk3PgmvMag8WyVDrLgbPoRFfv70W1H1MxfKyPTaZqEjyxlLkhrMlNDx8bOCt/urWLb3tZ
 58NnVjBgTdDSw02yZ7YRwe2TzNV20QA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-SaKbfPpVPjya4ZDY7OChPA-1; Wed, 31 May 2023 15:48:19 -0400
X-MC-Unique: SaKbfPpVPjya4ZDY7OChPA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 925CC381D1EA;
 Wed, 31 May 2023 19:48:18 +0000 (UTC)
Received: from localhost (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AADB2166B25;
 Wed, 31 May 2023 19:48:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, libvir-list@redhat.com,
 Greg Kurz <groug@kaod.org>, Yanan Wang <wangyanan55@huawei.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Subject: [PULL 00/11] Tracing patches
Date: Wed, 31 May 2023 15:48:04 -0400
Message-Id: <20230531194815.1508961-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following changes since commit 51bdb0b57a2d9e84d6915fbae7b5d76c8820cf3c:

  Merge tag 'pull-tcg-20230530' of https://gitlab.com/rth7680/qemu into staging (2023-05-30 13:25:18 -0700)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 2e7eda52e5ea2f066b37ecd9fdb5983851eabbbf:

  accel/tcg: include cs_base in our hash calculations (2023-05-31 13:21:53 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

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
2.40.1


