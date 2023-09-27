Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB0E7B02E4
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:27:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSg7-0002PG-JP; Wed, 27 Sep 2023 07:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSfy-0002Oe-C2
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSfw-0001Vp-CW
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695813948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=el86RML6u4S9xI2DBJwteZAMnpthYGiv3VKPelR3cY8=;
 b=Zh8vccc7RIbNlWtdVZmExQc7y3g2pLfc4dGK2LN4ySofvFxOk+pPu/Gb6kAgHaVmjd8EG0
 aBS7cdaJ6jHk/Y+iNe/oLBMwNvzP8ynRyaA1BTM5cyrqTVQd4cGjvji+G07U68bRfHZ+cS
 BK5H1KJ837JhdcXxnvxWV0J4Ejph/qo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-JUPzwsojNjiNjf1V1KTKqQ-1; Wed, 27 Sep 2023 07:25:47 -0400
X-MC-Unique: JUPzwsojNjiNjf1V1KTKqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3FAE185A78E
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 11:25:46 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.224.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD9F610D14C7;
 Wed, 27 Sep 2023 11:25:45 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v1 0/9] qapi-go: add generator for Golang interface
Date: Wed, 27 Sep 2023 13:25:35 +0200
Message-ID: <20230927112544.85011-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi, long time no see!

This patch series intent is to introduce a generator that produces a Go
module for Go applications to interact over QMP with QEMU.

This idea was discussed before, as RFC:
 (RFC v1) https://lists.gnu.org/archive/html/qemu-devel/2022-04/msg00226.html
 (RFC v2) https://lists.gnu.org/archive/html/qemu-devel/2022-04/msg00226.html

The work got stuck due to changes needed around types that can take JSON
Null as value, but that's now fixed.

I've pushed this series in my gitlab fork:
    https://gitlab.com/victortoso/qemu/-/tree/qapi-golang-v1

I've also generated the qapi-go module over QEMU tags: v7.0.0, v7.1.0,
v7.2.6, v8.0.0 and v8.1.1, see the commits history here:
    https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v1-by-tags

I've also generated the qapi-go module over each commit of this series,
see the commits history here (using previous refered qapi-golang-v1)
    https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v1-by-patch


 * Why this?

My main goal is to allow Go applications that interact with QEMU to have
a native way of doing so.

Ideally, we can merge a new QAPI command, update qapi-go module to allow
Go applications to consume the new command in no time (e.g: if
development of said applications are using latest QEMU)


 * Expectations

From previous discussions, there are things that are still missing. One
simple example is Andrea's annotation suggestion to fix type names. My
proposal is to have a qapi-go module in a formal non-stable version till
some of those tasks get addressed or we declare it a non-problem.

I've created a docs/devel/qapi-golang-code-gen.rst to add information
from the discussions we might have in this series. Suggestions always
welcome.

P.S: Sorry about my broken python :)

Cheers,
Victor

Victor Toso (9):
  qapi: golang: Generate qapi's enum types in Go
  qapi: golang: Generate qapi's alternate types in Go
  qapi: golang: Generate qapi's struct types in Go
  qapi: golang: structs: Address 'null' members
  qapi: golang: Generate qapi's union types in Go
  qapi: golang: Generate qapi's event types in Go
  qapi: golang: Generate qapi's command types in Go
  qapi: golang: Add CommandResult type to Go
  docs: add notes on Golang code generator

 docs/devel/qapi-golang-code-gen.rst |  341 +++++++++
 scripts/qapi/golang.py              | 1047 +++++++++++++++++++++++++++
 scripts/qapi/main.py                |    2 +
 3 files changed, 1390 insertions(+)
 create mode 100644 docs/devel/qapi-golang-code-gen.rst
 create mode 100644 scripts/qapi/golang.py

-- 
2.41.0


