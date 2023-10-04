Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E16AC7B988B
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 01:07:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoAwG-00046f-R1; Wed, 04 Oct 2023 19:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoAwE-00045b-9V
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 19:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoAvy-0002da-6T
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 19:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696460737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MOB+/vtlLZUdKli1u6XA1ebyVaYq96iaGoXcBJRD0dk=;
 b=R13S1yFi5WMA35hc5soCt8taRwYlTf3IHTV95XfP7U6Mq5wRIJCtf+AnGaXGNOOSqcWM6H
 P8cWQrzv6Se0LegnafEA4XRqCgoAs+bFav1AT8wdvZAi4C+O05jt5TqwLPd20MyAPbXATm
 gyTCJ7JdPZOSGFYOiBSFL3+AUrocEEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-8ErgJ9CZP1iYfavxea_UNQ-1; Wed, 04 Oct 2023 19:05:33 -0400
X-MC-Unique: 8ErgJ9CZP1iYfavxea_UNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C915811E96;
 Wed,  4 Oct 2023 23:05:33 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E249EC15BB8;
 Wed,  4 Oct 2023 23:05:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v5 0/3] [DO-NOT-MERGE] qapi: static typing conversion, "pt0"
Date: Wed,  4 Oct 2023 19:05:29 -0400
Message-ID: <20231004230532.3002201-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

I'm sending this one out for Victor Toso's benefit this time. If you=0D
aren't Victor Toso, you can probably mark this as read now. If you're=0D
Markus, you can just assume everything in here is perfect and good.=0D
=0D
This is a manual testing pre-requisite for other QAPI cleanup=0D
patches. It isn't meant for inclusion, it's included here as an=0D
informative basis for ongoing work only.=0D
=0D
(Except the last patch, which is perfect and good, and Markus should=0D
apply it without even looking at it. That's just how normal and good it=0D
is.)=0D
=0D
sphinx-autodoc is enabled for the scripts/qapi package so that docstring=0D
formatting can be validated and inspected to make sure the output looks=0D
"nice". It is not necessarily how we'd want to expose this information,=0D
ultimately, but serves as a good smoke test for base-line docstring=0D
consistency.=0D
=0D
Lastly, some scripts/tools for running linters with "canonical"=0D
configurations are provided as a means to verify the linting=0D
base-line. I use these to validate my own work.=0D
=0D
V5:=0D
 - Rebased on today's origin/master;=0D
 - Minor fix to re-establish baseline.=0D
=0D
John Snow (3):=0D
  [DO-NOT-MERGE] docs: enable sphinx-autodoc for scripts/qapi=0D
  [DO-NOT-MERGE]: Add some ad-hoc linting helpers.=0D
  qapi: re-establish linting baseline=0D
=0D
 docs/conf.py                          |  3 ++-=0D
 docs/devel/index.rst                  |  1 +=0D
 docs/devel/python/index.rst           |  7 +++++++=0D
 docs/devel/python/qapi.commands.rst   |  7 +++++++=0D
 docs/devel/python/qapi.common.rst     |  7 +++++++=0D
 docs/devel/python/qapi.error.rst      |  7 +++++++=0D
 docs/devel/python/qapi.events.rst     |  7 +++++++=0D
 docs/devel/python/qapi.expr.rst       |  7 +++++++=0D
 docs/devel/python/qapi.gen.rst        |  7 +++++++=0D
 docs/devel/python/qapi.introspect.rst |  7 +++++++=0D
 docs/devel/python/qapi.main.rst       |  7 +++++++=0D
 docs/devel/python/qapi.parser.rst     |  8 ++++++++=0D
 docs/devel/python/qapi.rst            | 26 ++++++++++++++++++++++++=0D
 docs/devel/python/qapi.schema.rst     |  7 +++++++=0D
 docs/devel/python/qapi.source.rst     |  7 +++++++=0D
 docs/devel/python/qapi.types.rst      |  7 +++++++=0D
 docs/devel/python/qapi.visit.rst      |  7 +++++++=0D
 scripts/qapi-lint.sh                  | 29 +++++++++++++++++++++++++++=0D
 scripts/qapi/Makefile                 |  5 +++++=0D
 scripts/qapi/gen.py                   |  2 +-=0D
 scripts/qapi/parser.py                |  5 +++--=0D
 21 files changed, 166 insertions(+), 4 deletions(-)=0D
 create mode 100644 docs/devel/python/index.rst=0D
 create mode 100644 docs/devel/python/qapi.commands.rst=0D
 create mode 100644 docs/devel/python/qapi.common.rst=0D
 create mode 100644 docs/devel/python/qapi.error.rst=0D
 create mode 100644 docs/devel/python/qapi.events.rst=0D
 create mode 100644 docs/devel/python/qapi.expr.rst=0D
 create mode 100644 docs/devel/python/qapi.gen.rst=0D
 create mode 100644 docs/devel/python/qapi.introspect.rst=0D
 create mode 100644 docs/devel/python/qapi.main.rst=0D
 create mode 100644 docs/devel/python/qapi.parser.rst=0D
 create mode 100644 docs/devel/python/qapi.rst=0D
 create mode 100644 docs/devel/python/qapi.schema.rst=0D
 create mode 100644 docs/devel/python/qapi.source.rst=0D
 create mode 100644 docs/devel/python/qapi.types.rst=0D
 create mode 100644 docs/devel/python/qapi.visit.rst=0D
 create mode 100755 scripts/qapi-lint.sh=0D
 create mode 100644 scripts/qapi/Makefile=0D
=0D
-- =0D
2.41.0=0D
=0D


