Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA61EA5CC31
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 18:30:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3P8-000141-UQ; Tue, 11 Mar 2025 13:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3P6-00013l-4S
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:32 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3P1-0004uD-7u
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:31 -0400
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-Qg9C9pbnMey9EL7fbK8dmQ-1; Tue,
 11 Mar 2025 13:28:16 -0400
X-MC-Unique: Qg9C9pbnMey9EL7fbK8dmQ-1
X-Mimecast-MFC-AGG-ID: Qg9C9pbnMey9EL7fbK8dmQ_1741714095
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02AA01956083; Tue, 11 Mar 2025 17:28:15 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.44.32.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CD361944F12; Tue, 11 Mar 2025 17:28:10 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 0/6] 9pfs: Fix ftruncate-after-unlink
Date: Tue, 11 Mar 2025 18:28:03 +0100
Message-ID: <20250311172809.250913-1-groug@kaod.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

QEMU 9.2 already fixed the long standing limitation of failing fstat() on
unlinked files. This series does something similar for ftruncate().

The following program can be straced inside the guest with a shared fs in
passthrough mode over 9p2000.L.

int main(void)
{
	struct stat st;
	int fd = creat("./foo", 0000);

	ftruncate(fd, 100);
	unlink("./foo");
	ftruncate(fd, 1000);
}

Before :

creat("./foo", 000)                     = 3
ftruncate(3, 100)                       = -1 EACCES (Permission denied)
unlink("./foo")                         = 0
ftruncate(3, 1000)                      = -1 ENOENT (No such file or directory)

After :

creat("./foo", 000)                     = 3
ftruncate(3, 100)                       = 0
unlink("./foo")                         = 0
ftruncate(3, 1000)                      = 0

This v2 has a qtest as suggested by Christian Schoenebeck.

Cheers,

--
Greg

Christian Schoenebeck (1):
  tests/9p: add 'Tsetattr' request to test client

Greg Kurz (5):
  9pfs: local : Introduce local_fid_fd() helper
  9pfs: Don't use file descriptors in core code
  9pfs: Introduce ftruncate file op
  9pfs: Introduce futimens file op
  tests/9p: Test `Tsetattr` can truncate unlinked file

 fsdev/file-op-9p.h                    |  5 +++
 hw/9pfs/9p-local.c                    | 49 ++++++++++++++++++++-------
 hw/9pfs/9p-synth.c                    | 22 ++++++++++++
 hw/9pfs/9p-util.h                     |  1 +
 hw/9pfs/9p.c                          | 21 +++++++++---
 hw/9pfs/cofs.c                        | 37 ++++++++++++++++++++
 hw/9pfs/coth.h                        |  4 +++
 tests/qtest/libqos/virtio-9p-client.c | 49 +++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-9p-client.h | 34 +++++++++++++++++++
 tests/qtest/virtio-9p-test.c          |  9 +++++
 10 files changed, 213 insertions(+), 18 deletions(-)

-- 
2.48.1


