Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 601B879437F
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 21:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdxml-0006Af-59; Wed, 06 Sep 2023 15:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxmi-0006AQ-0c
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 15:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qdxmf-00087O-L2
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 15:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694026908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5H8pelRVsxJc9RClUG2Va6wOhXzoURG4z+1hJARkfMQ=;
 b=PlCjIh1bEl9FQFlmEfQ77JGDzE0KMPioIVprBU3x51yALOIeMPwYTBtLZCoSnJ8NLyQRnV
 7jrDvaf+LphdbP7e6Ki18i/0LIetz2vQ58eOOogSowswi4bn3az0A41t9JlzVNjlao6/c+
 CJHPshOfXST7FQVjcgPXSIHmY+g1HTo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-qwPGnw9UOxyb2nkJPL1MWQ-1; Wed, 06 Sep 2023 15:01:44 -0400
X-MC-Unique: qwPGnw9UOxyb2nkJPL1MWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A90D38157A7;
 Wed,  6 Sep 2023 19:01:43 +0000 (UTC)
Received: from localhost (unknown [10.39.193.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2A1D10EA0;
 Wed,  6 Sep 2023 19:01:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>, pbonzini@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 kwolf@redhat.com, Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 0/3] qmp: make qmp_device_add() a coroutine
Date: Wed,  6 Sep 2023 15:01:38 -0400
Message-ID: <20230906190141.1286893-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is not safe to call drain_call_rcu() from qmp_device_add() because
some call stacks are not prepared for drain_call_rcu() to drop the Big
QEMU Lock (BQL).

For example, device emulation code is protected by the BQL but when it
calls aio_poll() -> ... -> qmp_device_add() -> drain_call_rcu() then the
BQL is dropped. See https://bugzilla.redhat.com/show_bug.cgi?id=2215192 for a
concrete bug of this type.

Another limitation of drain_call_rcu() is that it cannot be invoked within an
RCU read-side critical section since the reclamation phase cannot complete
until the end of the critical section. Unfortunately, call stacks have been
seen where this happens (see
https://bugzilla.redhat.com/show_bug.cgi?id=2214985).

This patch series introduces drain_call_rcu_co(), which does the same thing as
drain_call_rcu() but asynchronously. By yielding back to the event loop we can
wait until the caller drops the BQL and leaves its RCU read-side critical
section.

Patch 1 changes HMP so that coroutine monitor commands yield back to the event
loop instead of running inside a nested event loop.

Patch 2 introduces the new drain_call_rcu_co() API.

Patch 3 converts qmp_device_add() into a coroutine monitor command and uses
drain_call_rcu_co().

I'm sending this as an RFC because I don't have confirmation yet that the bugs
mentioned above are fixed by this patch series.

Stefan Hajnoczi (3):
  hmp: avoid the nested event loop in handle_hmp_command()
  rcu: add drain_call_rcu_co() API
  qmp: make qmp_device_add() a coroutine

 MAINTAINERS            |  2 ++
 docs/devel/rcu.txt     | 21 ++++++++++++++++
 qapi/qdev.json         |  1 +
 include/monitor/qdev.h |  3 ++-
 include/qemu/rcu.h     |  1 +
 util/rcu-internal.h    |  8 ++++++
 monitor/hmp.c          | 28 +++++++++++----------
 monitor/qmp-cmds.c     |  2 +-
 softmmu/qdev-monitor.c | 34 +++++++++++++++++++++++---
 util/rcu-co.c          | 55 ++++++++++++++++++++++++++++++++++++++++++
 util/rcu.c             |  3 ++-
 hmp-commands.hx        |  1 +
 util/meson.build       |  2 +-
 13 files changed, 140 insertions(+), 21 deletions(-)
 create mode 100644 util/rcu-internal.h
 create mode 100644 util/rcu-co.c

-- 
2.41.0


