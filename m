Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 459457ED8FB
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:48:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3RQI-0005Er-Ls; Wed, 15 Nov 2023 20:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQG-0005ES-HQ
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQA-0001zF-Vb
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700099033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TBQsMXg0UqMi3OU8BrITW/nluz4TDp30aRzcy06GJIU=;
 b=QtNr8Q4aM0XhfP9FpKB2g2KyJ3DnPi3/pwBoqHhzOu2P7bDW4e6yzs+1v2R66p/NT/COEq
 Joyz+gefaf0Nl8tCV8tXFhsIZHjO5/AQAQqF9pTHMP6AfETrJMGMZUdebYRcRox8U8MQAG
 Q9Cup3oTzBlHTH0YGuzHyI04faLAuNM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-f3dy58YgPNW8riCMefq4Dg-1; Wed, 15 Nov 2023 20:43:51 -0500
X-MC-Unique: f3dy58YgPNW8riCMefq4Dg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47AA4810FC1;
 Thu, 16 Nov 2023 01:43:51 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.32.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC58EC15881;
 Thu, 16 Nov 2023 01:43:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 00/19] qapi: statically type schema.py
Date: Wed, 15 Nov 2023 20:43:31 -0500
Message-ID: <20231116014350.653792-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

Hi! This branch has some comical name like python-qapi-cleanup-pt6-v2=0D
but, simply, it finishes what I started and statically types all of the=0D
QAPI generator code.=0D
=0D
GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/1074124051=0D
=0D
Patch 1 is an actual fix,=0D
Patch 2 is a minor patch for pylint with no runtime effect,=0D
Patches 3-15 fix individual typing issues that have some runtime effect.=0D
Patch 16 adds typing information,=0D
Patch 17 removes the schema.py exemption from the mypy conf,=0D
Patches 18-19 are optional.=0D
=0D
Most of the patches (expect 16) are very small. I'm sure we'll need to=0D
rework parts of this, but hey, gotta start somewhere.=0D
=0D
--js=0D
=0D
John Snow (19):=0D
  qapi/schema: fix QAPISchemaEntity.__repr__()=0D
  qapi/schema: add pylint suppressions=0D
  qapi/schema: name QAPISchemaInclude entities=0D
  qapi/schema: declare type for QAPISchemaObjectTypeMember.type=0D
  qapi/schema: make c_type() and json_type() abstract methods=0D
  qapi/schema: adjust type narrowing for mypy's benefit=0D
  qapi/introspect: assert schema.lookup_type did not fail=0D
  qapi/schema: add static typing and assertions to lookup_type()=0D
  qapi/schema: assert info is present when necessary=0D
  qapi/schema: make QAPISchemaArrayType.element_type non-Optional=0D
  qapi/schema: fix QAPISchemaArrayType.check's call to resolve_type=0D
  qapi/schema: split "checked" field into "checking" and "checked"=0D
  qapi/schema: fix typing for QAPISchemaVariants.tag_member=0D
  qapi/schema: assert QAPISchemaVariants are QAPISchemaObjectType=0D
  qapi/parser: demote QAPIExpression to Dict[str, Any]=0D
  qapi/schema: add type hints=0D
  qapi/schema: turn on mypy strictness=0D
  qapi/schema: remove unnecessary asserts=0D
  qapi/schema: refactor entity lookup helpers=0D
=0D
 docs/sphinx/qapidoc.py |   2 +-=0D
 scripts/qapi/mypy.ini  |   5 -=0D
 scripts/qapi/parser.py |   3 +-=0D
 scripts/qapi/pylintrc  |   5 -=0D
 scripts/qapi/schema.py | 723 ++++++++++++++++++++++++++++-------------=0D
 5 files changed, 498 insertions(+), 240 deletions(-)=0D
=0D
-- =0D
2.41.0=0D
=0D


