Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9427F7A6C3B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 22:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qihBo-0001rn-Sn; Tue, 19 Sep 2023 16:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qihBa-0001qo-Lf
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 16:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qihBY-0003XN-Eh
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 16:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695154742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v1W54GWxjK68JH29nAQg3HGiEuhTPnQrCcljhdhOBE4=;
 b=ZIjKoj4RR8JLhKf6jBfdqGmdLwY731SwbGZtxpOUm6tWF/rQnug0sPVzllv3b33J86KR++
 ir/iRvqnRH5gkptvwzKS/v/yuDo8gD/rh/FsGEVEsVrXwbh9SGjFCUlXqWlA86Vu6bgq6D
 ShWWKm0nx1B0MEJpk2si4ezW3AIzwXA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-lWnGqdO9NTqOo3wJ31Lldg-1; Tue, 19 Sep 2023 16:19:00 -0400
X-MC-Unique: lWnGqdO9NTqOo3wJ31Lldg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 013723C11A0A
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 20:19:00 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.224.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D07DE140273C;
 Tue, 19 Sep 2023 20:18:58 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 00/10] Validate and test qapi examples
Date: Tue, 19 Sep 2023 22:18:47 +0200
Message-ID: <20230919201857.675913-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

v2: https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg02383.html

- Sorry Markus, I kept the two last 'fix example' patches as I don't
  fully remember how we should go with it. Not taking them but taking
  the generator would be bad as we would fail the build.

- Removed the meson flag suggested by Philippe to take the pragma suggestion from Markus, the
  interesting diff is:

    --- a/scripts/qapi/dumpexamples.py
    +++ b/scripts/qapi/dumpexamples.py
    @@ -119,6 +119,10 @@ def parse_examples_of(self: QAPISchemaGenExamplesVisitor,

         assert(name in self.schema._entity_dict)
         obj = self.schema._entity_dict[name]
    +
    +    if not obj.info.pragma.doc_required:
    +        return
    +
         assert((obj.doc is not None))
         module_name = obj._module.name

  which avoid failures with tests that don't have any docs.

Cheers,
Victor

Victor Toso (10):
  qapi: fix example of get-win32-socket command
  qapi: fix example of dumpdtb command
  qapi: fix example of cancel-vcpu-dirty-limit command
  qapi: fix example of set-vcpu-dirty-limit command
  qapi: fix example of calc-dirty-rate command
  qapi: fix example of NETDEV_STREAM_CONNECTED event
  qapi: fix example of query-blockstats command
  qapi: fix example of query-rocker-of-dpa-flows command
  qapi: fix example of query-spice command
  qapi: scripts: add a generator for qapi's examples

 qapi/block-core.json         |  32 +++---
 qapi/machine.json            |   2 +-
 qapi/migration.json          |   6 +-
 qapi/misc.json               |   2 +-
 qapi/net.json                |   6 +-
 qapi/rocker.json             |   3 +-
 qapi/ui.json                 |   3 +-
 scripts/qapi/dumpexamples.py | 208 +++++++++++++++++++++++++++++++++++
 scripts/qapi/main.py         |   3 +-
 9 files changed, 236 insertions(+), 29 deletions(-)
 create mode 100644 scripts/qapi/dumpexamples.py

-- 
2.41.0


