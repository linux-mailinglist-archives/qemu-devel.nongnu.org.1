Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E18706CA8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:26:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJ1u-0004JU-Qc; Wed, 17 May 2023 11:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzJ1m-0004IB-SN
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzJ1k-0000CU-8D
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684337119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CHem1oZlaw1DyTScbVd3sK/4SBnmEdsiVu/lnPJP9wM=;
 b=ZOwhz00gSE/6jr+jQrmZUGdwVxyveWwW00uNoJrexgCsWjAwIzS1PveJ1KmXio2ZWws0AS
 jhl6KU0vbf9Gi4IAy2FiyCXjn/lDl4qcYH1ZZmEnzJ1SIVHff/j1S05KerCcUet45ddg6F
 cEMYn000v+RA6nBMOJqF16BQ0QPjbtg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-ZRQN1iTxPu2_iNpJF2iF5g-1; Wed, 17 May 2023 11:25:17 -0400
X-MC-Unique: ZRQN1iTxPu2_iNpJF2iF5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D7A310146E3;
 Wed, 17 May 2023 15:25:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BD12C15BA0;
 Wed, 17 May 2023 15:25:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1EEC821E6806; Wed, 17 May 2023 17:25:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/5] QAPI patches patches for 2023-05-17
Date: Wed, 17 May 2023 17:25:10 +0200
Message-Id: <20230517152516.1884640-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

The following changes since commit f9d58e0ca53b3f470b84725a7b5e47fcf446a2ea:

  Merge tag 'pull-9p-20230516' of https://github.com/cschoenebeck/qemu into staging (2023-05-16 10:21:44 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2023-05-17

for you to fetch changes up to 28d2a4f620db2bc327dbd3443b777890d39a0bf6:

  qapi/parser: Drop two bad type hints for now (2023-05-17 15:49:22 +0200)

----------------------------------------------------------------
QAPI patches patches for 2023-05-17

----------------------------------------------------------------
Markus Armbruster (2):
      qapi: Improve error message for description following section
      qapi/parser: Drop two bad type hints for now

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
 scripts/qapi/parser.py                        |   8 +-
 tests/qapi-schema/doc-interleaved-section.err |   2 +-
 12 files changed, 226 insertions(+), 262 deletions(-)
 delete mode 100644 docs/interop/qmp-intro.txt
 rename docs/interop/{qmp-spec.txt => qmp-spec.rst} (55%)

-- 
2.39.2


