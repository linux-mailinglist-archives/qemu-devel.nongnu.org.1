Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B871A1E2
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:08:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jtE-0007VD-RH; Thu, 01 Jun 2023 11:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4jtC-0007Uv-96
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4jtA-0007jn-B6
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685632014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mLQFZ/a0faj7yXedrwziwyPiO5DMy2B8D5sF62Dbcjo=;
 b=QIqAfRk27ZJ4Mwel0K8ruFck2bLLZZopUQDZgtMJKntI/Y6OxNjsMaVZ6ENUvcci7DxlMH
 ozxbvnAiHY4ArRhptzBd1gkJDOPcf/ItqZddiSYE46Pa/fEqi7Gom6GfGbGIj4s6cbcteW
 IBDx+zdYSxSJ1ymbCbkSmsgzHLf0PfE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-dFh5s2paMsOzrwwPACNPWQ-1; Thu, 01 Jun 2023 11:06:53 -0400
X-MC-Unique: dFh5s2paMsOzrwwPACNPWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C1D229AB3E9;
 Thu,  1 Jun 2023 15:06:52 +0000 (UTC)
Received: from localhost (unknown [10.39.194.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0F8540CFD45;
 Thu,  1 Jun 2023 15:06:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Riku Voipio <riku.voipio@iki.fi>,
 Greg Kurz <groug@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL v2 00/11] Tracing patches
Date: Thu,  1 Jun 2023 11:06:38 -0400
Message-Id: <20230601150649.1591095-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

The following changes since commit c6a5fc2ac76c5ab709896ee1b0edd33685a67ed1:

  decodetree: Add --output-null for meson testing (2023-05-31 19:56:42 -0700)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 367189efae8b53ec2ade37a1c079fd8f69244b9e:

  accel/tcg: include cs_base in our hash calculations (2023-06-01 11:05:05 -0400)

----------------------------------------------------------------
Pull request

This pull request contains Alex Bennée's vcpu trace events removal patches.

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
 bsd-user/freebsd/os-syscall.c |   3 -
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
 28 files changed, 94 insertions(+), 497 deletions(-)
 delete mode 100644 trace/control-vcpu.h

-- 
2.40.1


