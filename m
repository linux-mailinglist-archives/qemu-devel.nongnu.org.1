Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D992270BB9F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:22:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q13ah-0001jw-5x; Mon, 22 May 2023 07:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q13aY-0001jY-VJ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q13aW-000132-CX
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684754427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lTxhINT3tSai960CRilv6ny897MRlKVQ/VxVmmBNJHU=;
 b=VlE0nBuMVGvSJXjEU/4pVfF/VZourQn/qWx6FrPMQ1T3an6ncfa+j5dwuZtt9cQUDNWcc5
 2rs3edmk+9vf9XxMw6uHV0FxbbisGApRRmj72AidN2QCsVdnRZzXZQyagIdX8eQg1cScee
 pjjFEyxImQb8eH/10s0Kd6y5icgm+UE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-_38_B91cPDaH5-0VNRlNcg-1; Mon, 22 May 2023 07:20:23 -0400
X-MC-Unique: _38_B91cPDaH5-0VNRlNcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80692811E7C;
 Mon, 22 May 2023 11:20:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DDA8200AE6F;
 Mon, 22 May 2023 11:20:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3EC2721E692E; Mon, 22 May 2023 13:20:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL v2 0/4] QAPI patches patches for 2023-05-17
Date: Mon, 22 May 2023 13:20:18 +0200
Message-Id: <20230522112022.2075140-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit aa222a8e4f975284b3f8f131653a4114b3d333b3:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-05-19 12:17:16 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2023-05-17-v2

for you to fetch changes up to 0ec4468f233c53eb854f204d105d965455deec51:

  docs/interop: Delete qmp-intro.txt (2023-05-22 10:22:29 +0200)

----------------------------------------------------------------
QAPI patches patches for 2023-05-17

----------------------------------------------------------------
Markus Armbruster (1):
      qapi: Improve error message for description following section

Peter Maydell (3):
      docs/interop: Convert qmp-spec.txt to rST
      docs/interop/qmp-spec: Update error description for parsing errors
      docs/interop: Delete qmp-intro.txt

 docs/devel/qapi-code-gen.rst                  |   3 +-
 docs/interop/index.rst                        |   1 +
 docs/interop/qmp-intro.txt                    |  88 -------
 docs/interop/{qmp-spec.txt => qmp-spec.rst}   | 337 ++++++++++++++------------
 qapi/control.json                             |   4 +-
 qapi/qapi-schema.json                         |   3 +-
 qobject/json-lexer.c                          |   2 +-
 python/qemu/qmp/models.py                     |   8 +-
 python/qemu/qmp/qmp_client.py                 |   4 +-
 qemu-options.hx                               |  28 ++-
 scripts/qapi/parser.py                        |   4 +-
 tests/qapi-schema/doc-interleaved-section.err |   2 +-
 12 files changed, 224 insertions(+), 260 deletions(-)
 delete mode 100644 docs/interop/qmp-intro.txt
 rename docs/interop/{qmp-spec.txt => qmp-spec.rst} (56%)

-- 
2.39.2


