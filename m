Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E27A792F4D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 21:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdc3x-0001gP-W5; Tue, 05 Sep 2023 15:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qdc3p-0001fE-6e
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qdc3m-00073D-LR
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 15:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693943400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XyhcVcAQMp69u7V6qYdWMawHVzl1k8vq3w5NI6uFKuw=;
 b=VJNDdjHz38JI1uFTvJ0BadAUOr2J+MwU4C8ss3Bd6NBSLAfrnYpE2kK9zJJizQWBAQLV4P
 DnAcsPU12kGHJoiWVw0rgJAdFUGCdYykuYiwz9vOdJN3QVXBZHPq/0dLVIHSoRZPAPPqWG
 tylQbM4XDY2QZHIWqNJdSWFfdPngAgo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-4FVSkqWlNpWdZAEEMdlDYQ-1; Tue, 05 Sep 2023 15:48:48 -0400
X-MC-Unique: 4FVSkqWlNpWdZAEEMdlDYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F12B28237CE
 for <qemu-devel@nongnu.org>; Tue,  5 Sep 2023 19:48:48 +0000 (UTC)
Received: from tapioca.wind3.hub (unknown [10.45.225.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45E93C03292;
 Tue,  5 Sep 2023 19:48:47 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v1 0/7] Validate and test qapi examples
Date: Tue,  5 Sep 2023 21:48:39 +0200
Message-ID: <20230905194846.169530-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

Hi,

This is a follow up from the RFC sent in the end of 08-2022:
    https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg04525.html

The generator code was rebased, without conflicts. The commit log was
improved as per Markus suggestion [0], altough I'm sure it can be
improved further.

To clarify, consuming the Examples as data for testing the qapi-go
work has been very very helpful. I'm positive it can be of use for other
bindings in the future, besides keeping the examples functional.

Cheers,

[0] https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg04682.html

Victor Toso (7):
  qapi: scripts: add a generator for qapi's examples
  qapi: fix example of get-win32-socket command
  qapi: fix example of dumpdtb command
  qapi: fix example of cancel-vcpu-dirty-limit command
  qapi: fix example of set-vcpu-dirty-limit command
  qapi: fix example of calc-dirty-rate command
  qapi: fix example of NETDEV_STREAM_CONNECTED event

 qapi/machine.json            |   2 +-
 qapi/migration.json          |   6 +-
 qapi/misc.json               |   2 +-
 qapi/net.json                |   6 +-
 scripts/qapi/dumpexamples.py | 194 +++++++++++++++++++++++++++++++++++
 scripts/qapi/main.py         |   2 +
 6 files changed, 204 insertions(+), 8 deletions(-)
 create mode 100644 scripts/qapi/dumpexamples.py

-- 
2.41.0


