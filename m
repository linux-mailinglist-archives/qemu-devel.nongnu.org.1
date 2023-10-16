Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D86B7CAD79
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:28:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPVE-0001SR-Ec; Mon, 16 Oct 2023 11:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPVC-0001Re-Cv
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPV6-0003Og-75
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697470043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Aor/RvXplTNxyIJ4/OvP2b2sLCFwRozFvgoHbR6Y3o=;
 b=c8aHaKqrHmh6ZXSQrrCx7BMbGRBa+wzu0FGtGANihEfrgM133pdUJZUzDOkDAduDOL8qMb
 IpxhyjqyxqKtZPkefxt4tS3owM5wl7F24U+jMiQagTBvmMZX5+27RPrBwbRamT2yA54bVX
 SFQggiPuzDv7qP/AR8UaJX2mDROAMFU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-b_d3eZ22OkmXnYtjFJuSOg-1; Mon, 16 Oct 2023 11:27:07 -0400
X-MC-Unique: b_d3eZ22OkmXnYtjFJuSOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDBD72999B29
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 15:27:06 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C6A72026831;
 Mon, 16 Oct 2023 15:27:05 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v2 00/11] qapi-go: add generator for Golang interface
Date: Mon, 16 Oct 2023 17:26:53 +0200
Message-ID: <20231016152704.221611-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This patch series intent is to introduce a generator that produces a Go
module for Go applications to interact over QMP with QEMU.

This is the second iteration:
 v1: https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg06734.html

I've pushed this series in my gitlab fork:
https://gitlab.com/victortoso/qemu/-/tree/qapi-golang-v2

I've also generated the qapi-go module over QEMU tags: v7.0.0, v7.1.0,
v7.2.6, v8.0.0 and v8.1.0, see the commits history here:
https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v2-by-tags

I've also generated the qapi-go module over each commit of this series,
see the commits history here (using previous refered qapi-golang-v2)
https://gitlab.com/victortoso/qapi-go/-/commits/qapi-golang-v2-by-patch

Cheers,
Victor

* Changes:
 - All patches were rebased using black python formatting tool, awesome.
   (John) https://black.readthedocs.io/en/stable/
 - All patches were tested with flake8 and pylint. Minor complains
   remains. (John)
 - All generated types are sorted in alphabetical order (Daniel)
 - Using utf8 instead of ascii encoding of output files
 - Improved commit logs
 - renamed QapiError -> QAPIError (Daniel)
 - QAPIError's Error() returns only the description (Daniel)
 - Used more type hints (Where I could) (John)
 - Removed typehint from self in the Class implementation (John)
 - The Go code that is generated is now well formated. gofmt -w and
   goimport -w don't change a thing.
 - Added a fix from John
   https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01305.html
 - Added a tangent fix suggestion to main.py "scripts: qapi: black
   format main.py"

John Snow (1):
  qapi: re-establish linting baseline

Victor Toso (10):
  scripts: qapi: black format main.py
  qapi: golang: Generate qapi's enum types in Go
  qapi: golang: Generate qapi's alternate types in Go
  qapi: golang: Generate qapi's struct types in Go
  qapi: golang: structs: Address 'null' members
  qapi: golang: Generate qapi's union types in Go
  qapi: golang: Generate qapi's event types in Go
  qapi: golang: Generate qapi's command types in Go
  qapi: golang: Add CommandResult type to Go
  docs: add notes on Golang code generator

 docs/devel/index-build.rst          |    1 +
 docs/devel/qapi-golang-code-gen.rst |  376 ++++++++
 scripts/qapi/gen.py                 |    2 +-
 scripts/qapi/golang.py              | 1349 +++++++++++++++++++++++++++
 scripts/qapi/main.py                |   79 +-
 scripts/qapi/parser.py              |    5 +-
 6 files changed, 1781 insertions(+), 31 deletions(-)
 create mode 100644 docs/devel/qapi-golang-code-gen.rst
 create mode 100644 scripts/qapi/golang.py

-- 
2.41.0


