Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD10846396
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Feb 2024 23:45:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVfmB-0006Ia-68; Thu, 01 Feb 2024 17:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVfm8-0006Gg-J2
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:43:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVflp-0006aC-4k
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706827374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SZ2BuUwZedumd7wAOOy0375BmtmEb3sTpJ8FTGLhqp4=;
 b=SMMR08br5XFc93xe0kiINR69dJqHVQiB2Ssl+xcvt40qBQMmsky5K85h6vEva9Vv7FCgJh
 f040t6j9rzTKlHnKoOEzRIXYxMLxcNK0HBBsl5e/qumZSu2qcX3rdFjwisk5MOuqApZkF7
 9Y0ibnA/jCPSadxx+LxFZK4owr9UvwQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-nsyxm8MzMBKVTAd_nhxf1g-1; Thu, 01 Feb 2024 17:42:51 -0500
X-MC-Unique: nsyxm8MzMBKVTAd_nhxf1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4B45185A780;
 Thu,  1 Feb 2024 22:42:50 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.18.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 572E12166B33;
 Thu,  1 Feb 2024 22:42:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 00/20] qapi: statically type schema.py
Date: Thu,  1 Feb 2024 17:42:26 -0500
Message-ID: <20240201224246.39480-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This is *v3*, for some definitions of "version" and "three".=0D
=0D
It's still got some parts that Markus isn't wildly fond of, but I needed=0D
a synchronization part for discussing the remaining nits. (Sorry Markus.)=0D
=0D
v3:=0D
 - 01: fixed alphabetization (... sigh)=0D
 - 03: updated docstring, added super calls,=0D
       renamed argument to @defn, reflowed long lines=0D
 - 04: updated commit message=0D
 - 05: updated commit message=0D
 - 06: pushed type hints into later commit=0D
 - 09: removed default argument and stuffed into next patch=0D
 - 10: Added the parts Markus doesn't like (Sorry)=0D
 - 11: updated commit message=0D
 - 12: updated commit message=0D
 - 13: Split into two patches.=0D
       Kept stuff Markus doesn't like (Sorry)=0D
 - 14: New, split from 13.=0D
=0D
I know this probably doesn't address everything, so if I didn't change=0D
it, feel free to re-flag so I can keep the feedback in one spot on the=0D
new series.=0D
=0D
(Sorry sorry sorry sorry sorry.)=0D
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
John Snow (20):=0D
  qapi: sort pylint suppressions=0D
  qapi/schema: add pylint suppressions=0D
  qapi: create QAPISchemaDefinition=0D
  qapi/schema: declare type for QAPISchemaObjectTypeMember.type=0D
  qapi/schema: declare type for QAPISchemaArrayType.element_type=0D
  qapi/schema: make c_type() and json_type() abstract methods=0D
  qapi/schema: adjust type narrowing for mypy's benefit=0D
  qapi/schema: add type narrowing to lookup_type()=0D
  qapi/schema: assert resolve_type has 'info' and 'what' args on error=0D
  qapi: use schema.resolve_type instead of schema.lookup_type=0D
  qapi/schema: fix QAPISchemaArrayType.check's call to resolve_type=0D
  qapi/schema: assert info is present when necessary=0D
  qapi/schema: split "checked" field into "checking" and "checked"=0D
  qapi/schema: Don't initialize "members" with `None`=0D
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
 scripts/qapi/schema.py     | 794 ++++++++++++++++++++++++-------------=0D
 5 files changed, 534 insertions(+), 283 deletions(-)=0D
=0D
-- =0D
2.43.0=0D
=0D


