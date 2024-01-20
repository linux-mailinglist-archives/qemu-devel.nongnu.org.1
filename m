Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B383336A
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 10:55:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rR82l-00082M-Bh; Sat, 20 Jan 2024 04:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rR82j-00080w-Eh
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 04:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rR82g-00062v-DN
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 04:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705744413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bXH7BJgupruC+s9ZX2NkpVYHh5sEAE1NaDZQWk+6KL4=;
 b=F2a7z3Zw3kplVkSuy5Xjivxh/QSBNCjAJDfeWuaucZ7Hql/PKIj49dGGaOOZMRMnjZ6C0J
 22li2Othp8DXXwNiX4lo7zMoRUl49vuFc+fdTcjs8IrHDghqh2RyBFMeqbAcBmmhXNPC8y
 p3D2nN5qKq64Id0rST2chYIQo97szqw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-qbu6qsH3N3Oz5oU4LagXEQ-1; Sat,
 20 Jan 2024 04:53:29 -0500
X-MC-Unique: qbu6qsH3N3Oz5oU4LagXEQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A23E1C05154;
 Sat, 20 Jan 2024 09:53:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73565492BE2;
 Sat, 20 Jan 2024 09:53:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 50C6D21E66C8; Sat, 20 Jan 2024 10:53:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	peter.maydell@linaro.org,
	jsnow@redhat.com
Subject: [PATCH 0/7] qapi qmp: Documentation fixes
Date: Sat, 20 Jan 2024 10:53:20 +0100
Message-ID: <20240120095327.666239-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Markus Armbruster (7):
  docs/devel/qapi-code-gen: Fix missing ':' in tagged section docs
  docs: Replace dangling references to docs/interop/qmp-intro.txt
  qapi: Fix dangling references to docs/devel/qapi-code-gen.txt
  docs/interop/bitmaps: Clean up a reference to qemu-qmp-ref
  qapi: Fix mangled "Returns" sections in documentation
  qapi: Indent tagged doc comment sections properly
  qapi: Fix malformed "Since:" section tags (again)

 docs/devel/qapi-code-gen.rst            |  4 ++--
 docs/devel/writing-monitor-commands.rst |  4 ++--
 docs/interop/bitmaps.rst                |  6 +++---
 qapi/block-core.json                    |  4 ++--
 qapi/char.json                          |  4 ++--
 qapi/introspect.json                    |  2 +-
 qapi/machine.json                       | 24 ++++++++++++------------
 qapi/migration.json                     | 14 +++++++-------
 qapi/misc-target.json                   |  2 +-
 qapi/misc.json                          | 10 +++++-----
 qapi/net.json                           | 15 +++++++++------
 qapi/qdev.json                          |  5 +++--
 qapi/qom.json                           | 10 ++++++----
 qapi/yank.json                          |  4 ++--
 include/qapi/visitor.h                  |  2 +-
 include/qemu/yank.h                     |  2 +-
 qapi/qapi-util.c                        |  2 +-
 util/yank.c                             |  2 +-
 scripts/qapi/parser.py                  |  2 +-
 19 files changed, 62 insertions(+), 56 deletions(-)

-- 
2.43.0


