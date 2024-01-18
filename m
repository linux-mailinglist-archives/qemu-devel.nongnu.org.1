Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA48831BC5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:50:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQThL-00061L-Cw; Thu, 18 Jan 2024 09:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQTh7-0005vq-3b
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:48:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQTh3-0008Hv-2v
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705589310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L/IJu9Rtz1IbKP9qMg/crjm3mjcGXPwsSBSE4rPyN3A=;
 b=XPunrUZhrpkS6JaAkKJnYtjob/kowRBCJifQQcxwxknwpyXRNfsoPlSYbeUKLV0b9udueD
 qPceqiHXiqQU++1pSUnjARe24aFMDwQEZkuDTu1dqHODkxKcYiECwmlFPEaNC6D5k3vSt3
 aNw5PEig0Jni7KAeHqhR8qvnflWnwUc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-eP7QAM9NPEKT0Oqvz_lDXA-1; Thu, 18 Jan 2024 09:48:27 -0500
X-MC-Unique: eP7QAM9NPEKT0Oqvz_lDXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3437887E53;
 Thu, 18 Jan 2024 14:48:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53903112131D;
 Thu, 18 Jan 2024 14:48:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-stable@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/3] monitor: only run coroutine commands in
 qemu_aio_context
Date: Thu, 18 Jan 2024 09:48:20 -0500
Message-ID: <20240118144823.1497953-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

v2:
- Filter image format in 141 test output [Kevin]
- Fix pylint and mypy errors in 141 [Kevin]

Several bugs have been reported related to how QMP commands are rescheduled in
qemu_aio_context:
- https://gitlab.com/qemu-project/qemu/-/issues/1933
- https://issues.redhat.com/browse/RHEL-17369
- https://bugzilla.redhat.com/show_bug.cgi?id=2215192
- https://bugzilla.redhat.com/show_bug.cgi?id=2214985

The first instance of the bug interacted with drain_call_rcu() temporarily
dropping the BQL and resulted in vCPU threads entering device emulation code
simultaneously (something that should never happen). I set out to make
drain_call_rcu() safe to use in this environment, but Paolo and Kevin discussed
the possibility of avoiding rescheduling the monitor_qmp_dispatcher_co()
coroutine for non-coroutine commands. This would prevent monitor commands from
running during vCPU thread aio_poll() entirely and addresses the root cause.

This patch series implements this idea. qemu-iotests is sensitive to the exact
order in which QMP events and responses are emitted. Running QMP handlers in
the iohandler AioContext causes some QMP events to be ordered differently than
before. It is therefore necessary to adjust the reference output in many test
cases. The actual QMP code change is small and everything else is just to make
qemu-iotests happy.

If you have bugs related to the same issue, please retest them with these
patches. Thanks!

Stefan Hajnoczi (3):
  iotests: add filter_qmp_generated_node_ids()
  iotests: port 141 to Python for reliable QMP testing
  monitor: only run coroutine commands in qemu_aio_context

 monitor/qmp.c                                 |  17 -
 qapi/qmp-dispatch.c                           |  24 +-
 tests/qemu-iotests/060.out                    |   4 +-
 tests/qemu-iotests/071.out                    |   4 +-
 tests/qemu-iotests/081.out                    |  16 +-
 tests/qemu-iotests/087.out                    |  12 +-
 tests/qemu-iotests/108.out                    |   2 +-
 tests/qemu-iotests/109                        |   4 +-
 tests/qemu-iotests/109.out                    |  78 ++---
 tests/qemu-iotests/117.out                    |   2 +-
 tests/qemu-iotests/120.out                    |   2 +-
 tests/qemu-iotests/127.out                    |   2 +-
 tests/qemu-iotests/140.out                    |   2 +-
 tests/qemu-iotests/141                        | 307 ++++++++----------
 tests/qemu-iotests/141.out                    | 190 +++--------
 tests/qemu-iotests/143.out                    |   2 +-
 tests/qemu-iotests/156.out                    |   2 +-
 tests/qemu-iotests/176.out                    |  16 +-
 tests/qemu-iotests/182.out                    |   2 +-
 tests/qemu-iotests/183.out                    |   4 +-
 tests/qemu-iotests/184.out                    |  32 +-
 tests/qemu-iotests/185                        |   6 +-
 tests/qemu-iotests/185.out                    |  45 ++-
 tests/qemu-iotests/191.out                    |  16 +-
 tests/qemu-iotests/195.out                    |  16 +-
 tests/qemu-iotests/223.out                    |  16 +-
 tests/qemu-iotests/227.out                    |  32 +-
 tests/qemu-iotests/247.out                    |   2 +-
 tests/qemu-iotests/273.out                    |   8 +-
 tests/qemu-iotests/308                        |   4 +-
 tests/qemu-iotests/308.out                    |   4 +-
 tests/qemu-iotests/iotests.py                 |   7 +
 tests/qemu-iotests/tests/file-io-error        |   5 +-
 tests/qemu-iotests/tests/iothreads-resize.out |   2 +-
 tests/qemu-iotests/tests/qsd-jobs.out         |   4 +-
 35 files changed, 385 insertions(+), 506 deletions(-)

-- 
2.43.0


