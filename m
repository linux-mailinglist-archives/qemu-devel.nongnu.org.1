Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB62E82C751
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:32:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQ2I-0005mq-7K; Fri, 12 Jan 2024 17:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2E-0005lL-Hv
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:29:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2B-0005yi-MS
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705098590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=am5SVZ0PzgwV01SHeVBKw7bRq5kNEGbeUDMmcAFtLJc=;
 b=G1D0oTRdJ26qqfGenX1oP/QGNQfBZFxiMzA4+sMjWjY+GQ9n45/tvGhG4RmlJA/kf3BiYf
 gReJnCEPIgNEp8zxqNryr1oESFfMYO2zctmZgFlxs6qC7Uak8Gl8BpVnXtFE8dL5bq+rgb
 HwsbeX7HBAe+nG6kae/t/aqrB7A4yv4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-u92Mzf1WPP6AChT7uj1kCQ-1; Fri,
 12 Jan 2024 17:29:46 -0500
X-MC-Unique: u92Mzf1WPP6AChT7uj1kCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FE9B28AC1D3;
 Fri, 12 Jan 2024 22:29:46 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.17.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36EA7C25AC8;
 Fri, 12 Jan 2024 22:29:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 00/19] qapi: statically type schema.py
Date: Fri, 12 Jan 2024 17:29:26 -0500
Message-ID: <20240112222945.3033854-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Patches 1-16 fix minor nits or typing issues,=0D
Patch 17 adds type hints with no runtime changes,=0D
Patch 18 turns on type checking with mypy,=0D
Patch 19 drops auxiliary asserts that are no longer needed.=0D
=0D
v2:=0D
 - dropped the resolve_type refactoring patch=0D
 - added QAPISchemaDefinition=0D
 - misc bits and pieces.=0D
=0D
001/19:[down] 'qapi: sort pylint suppressions'=0D
  New, Markus's suggestion.=0D
=0D
002/19:[0001] [FC] 'qapi/schema: add pylint suppressions'=0D
  Added newline, Markus's RB=0D
=0D
003/19:[down] 'qapi: create QAPISchemaDefinition'=0D
  New, Markus's suggestion.=0D
=0D
004/19:[0002] [FC] 'qapi/schema: declare type for QAPISchemaObjectTypeMembe=
r.type'=0D
  Adjusted commit message and comment.=0D
=0D
005/19:[down] 'qapi/schema: declare type for QAPISchemaArrayType.element_ty=
pe'=0D
  Patch renamed; removed @property trick in favor of static type declaratio=
n=0D
=0D
006/19:[0009] [FC] 'qapi/schema: make c_type() and json_type() abstract met=
hods'=0D
  Use abc.ABC and @abstractmethod=0D
=0D
007/19:[0001] [FC] 'qapi/schema: adjust type narrowing for mypy's benefit'=
=0D
  Adjusted commit message; left in an assertion that is removed later inste=
ad.=0D
=0D
008/19:[down] 'qapi/schema: add type narrowing to lookup_type()'=0D
  Renamed=0D
  removed type hints which get added later in the series instead=0D
  simplified logic.=0D
=0D
009/19:[down] 'qapi/schema: allow resolve_type to be used for built-in type=
s'=0D
  New patch. (Types are added later.)=0D
=0D
010/19:[down] 'qapi: use schema.resolve_type instead of schema.lookup_type'=
=0D
  New patch, replaces old 07/19 "assert schema.lookup_type did not fail"=0D
=0D
011/19:[0011] [FC] 'qapi/schema: fix QAPISchemaArrayType.check's call to re=
solve_type'=0D
  Dramatically simplified.=0D
=0D
012/19:[----] [--] 'qapi/schema: assert info is present when necessary'=0D
013/19:[----] [--] 'qapi/schema: split "checked" field into "checking" and =
"checked"'=0D
  Changed the commit message, but actually struggled finding anything simpl=
er=0D
  than what I already had, owing to the fact that q_empty is a valid constr=
uct=0D
  and I can't seem to avoid adding a new state variable here.=0D
=0D
014/19:[----] [-C] 'qapi/schema: fix typing for QAPISchemaVariants.tag_memb=
er'=0D
  Also unchanged from review, I think this is simplest still...=0D
=0D
015/19:[down] 'qapi/schema: assert inner type of QAPISchemaVariants in chec=
k_clash()'=0D
  Renamed, changed commit message and comment.=0D
=0D
016/19:[----] [--] 'qapi/parser: demote QAPIExpression to Dict[str, Any]'=0D
017/19:[0042] [FC] 'qapi/schema: add type hints'=0D
  Mostly contextual changes.=0D
=0D
018/19:[----] [--] 'qapi/schema: turn on mypy strictness'=0D
019/19:[0006] [FC] 'qapi/schema: remove unnecessary asserts'=0D
  Zapped a few more.=0D
=0D
John Snow (19):=0D
  qapi: sort pylint suppressions=0D
  qapi/schema: add pylint suppressions=0D
  qapi: create QAPISchemaDefinition=0D
  qapi/schema: declare type for QAPISchemaObjectTypeMember.type=0D
  qapi/schema: declare type for QAPISchemaArrayType.element_type=0D
  qapi/schema: make c_type() and json_type() abstract methods=0D
  qapi/schema: adjust type narrowing for mypy's benefit=0D
  qapi/schema: add type narrowing to lookup_type()=0D
  qapi/schema: allow resolve_type to be used for built-in types=0D
  qapi: use schema.resolve_type instead of schema.lookup_type=0D
  qapi/schema: fix QAPISchemaArrayType.check's call to resolve_type=0D
  qapi/schema: assert info is present when necessary=0D
  qapi/schema: split "checked" field into "checking" and "checked"=0D
  qapi/schema: fix typing for QAPISchemaVariants.tag_member=0D
  qapi/schema: assert inner type of QAPISchemaVariants in check_clash()=0D
  qapi/parser: demote QAPIExpression to Dict[str, Any]=0D
  qapi/schema: add type hints=0D
  qapi/schema: turn on mypy strictness=0D
  qapi/schema: remove unnecessary asserts=0D
=0D
 scripts/qapi/introspect.py |   4 +-=0D
 scripts/qapi/mypy.ini      |   5 -=0D
 scripts/qapi/parser.py     |   3 +-=0D
 scripts/qapi/pylintrc      |  11 +-=0D
 scripts/qapi/schema.py     | 773 +++++++++++++++++++++++++------------=0D
 5 files changed, 523 insertions(+), 273 deletions(-)=0D
=0D
-- =0D
2.43.0=0D
=0D


