Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E98B3EF9A
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Sep 2025 22:28:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utB7Y-000472-O9; Mon, 01 Sep 2025 16:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utB7U-000462-Vn
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utB7P-0008Io-J3
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756758429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wZhChsJeLluGoBeNd3uQVli6iZw2M9Jb+loHpuiIp5I=;
 b=L4vseZWrDedDJ7TxdbGacaQnTUMTnb7b8mZjpU0CjTqGnkNeH8WRLQcrgQdl7N64gP1xlB
 scP8INXOUT50AOoi9Xx/yvXEa0zOg+OD7O2jo26068yugqf1OtQpOCUitzLCz9rSRKim9C
 AZVtsGQOj+QaLhIWE56AbnZpgIbqKsw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-rSmu6ONyN4isVoYUVjT-4w-1; Mon,
 01 Sep 2025 16:27:08 -0400
X-MC-Unique: rSmu6ONyN4isVoYUVjT-4w-1
X-Mimecast-MFC-AGG-ID: rSmu6ONyN4isVoYUVjT-4w_1756758427
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 375F4180047F; Mon,  1 Sep 2025 20:27:07 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6DFB419560AB; Mon,  1 Sep 2025 20:27:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 00/19] python: 3.14 compatibility and python-qemu-qmp
 synchronization
Date: Mon,  1 Sep 2025 16:26:42 -0400
Message-ID: <20250901202702.2971212-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi, this series aims to support Python 3.14; a large part of how it=0D
achieves this is by backporting various changes that have been made to=0D
the python-qemu-qmp standalone library to ensure that our in-tree=0D
version is very nearly byte identical to the standalone version.=0D
=0D
Several of Dan's patches are appended here which remove all deprecated=0D
behavior from our test suite and enables printing warnings whenever=0D
deprecated behavior is used so we will be able to catch it more readily=0D
in the future.=0D
=0D
Following this series, I intend to drop the QMP library from the qemu=0D
tree once and for all so that they do not desynchronize again. The=0D
standalone library needs to drop avocado-framework and cut a v0.0.4=0D
release first, but it's currently my top priority to end this=0D
embarrassing patch of duplicated code and maintenance.=0D
=0D
Reviewers: try applying this series and using diff to compare the=0D
qemu.git/python/qemu/qmp and python-qemu-qmp.git/qemu/qmp directories;=0D
you should find only five differences: three instances of LICENSE text=0D
being slightly different (pointing to LICENSE vs COPYING) and two=0D
instances of a pylint ignore that are not needed in qemu.git due to=0D
slightly different linter configuration in qemu.git/python/setup.cfg.=0D
=0D
If further changes are warranted, it is my preference to try to=0D
"upstream" them first before backporting them here instead of trying to=0D
amend this series.=0D
=0D
RFC: Should I squash the last two backport patches? One technically=0D
introduces a regression which breaks our "no regressions in series"=0D
rule, but makes the per-patch relationship murkier. Please let me know.=0D
=0D
--js=0D
=0D
Adam Dorsey (1):=0D
  python: backport 'feat: allow setting read buffer limit'=0D
=0D
Daniel P. Berrang=C3=A9 (5):=0D
  iotests: drop compat for old version context manager=0D
  python: ensure QEMUQtestProtocol closes its socket=0D
  iotests/147: ensure temporary sockets are closed before exiting=0D
  iotests/151: ensure subprocesses are cleaned up=0D
  iotests/check: always enable all python warnings=0D
=0D
John Snow (13):=0D
  python: backport 'Change error classes to have better repr methods'=0D
  python: backport 'EventListener: add __repr__ method'=0D
  python: backport 'kick event queue on legacy event_pull()'=0D
  python: backport 'protocol: adjust logging name when changing client=0D
    name'=0D
  python: backport 'drop Python3.6 workarounds'=0D
  python: backport 'qmp-shell: add common_parser()'=0D
  python: backport 'make require() preserve async-ness'=0D
  python: backport 'qmp-shell-wrap: handle missing binary gracefully'=0D
  python: backport 'qmp-tui: Do not crash if optional dependencies are=0D
    not met'=0D
  python: backport 'Remove deprecated get_event_loop calls'=0D
  python: backport '*really* remove get_event_loop'=0D
  python: backport 'python: avoid creating additional event loops per=0D
    thread'=0D
  python: synchronize qemu.qmp documentation=0D
=0D
 python/qemu/machine/qtest.py     |   2 +=0D
 python/qemu/qmp/__init__.py      |   3 +-=0D
 python/qemu/qmp/error.py         |   7 +-=0D
 python/qemu/qmp/events.py        |  50 ++++++--=0D
 python/qemu/qmp/legacy.py        |  46 +++++---=0D
 python/qemu/qmp/message.py       |  22 ++--=0D
 python/qemu/qmp/models.py        |   8 +-=0D
 python/qemu/qmp/protocol.py      | 194 +++++++++++++++++++------------=0D
 python/qemu/qmp/qmp_client.py    | 155 +++++++++++++++++-------=0D
 python/qemu/qmp/qmp_shell.py     | 165 ++++++++++++++++++--------=0D
 python/qemu/qmp/qmp_tui.py       |  30 +++--=0D
 python/qemu/qmp/util.py          | 143 ++++++-----------------=0D
 python/tests/protocol.py         |  10 +-=0D
 tests/qemu-iotests/147           |   1 +=0D
 tests/qemu-iotests/151           |   5 +=0D
 tests/qemu-iotests/check         |   4 +=0D
 tests/qemu-iotests/testenv.py    |   7 +-=0D
 tests/qemu-iotests/testrunner.py |   9 +-=0D
 18 files changed, 532 insertions(+), 329 deletions(-)=0D
=0D
-- =0D
2.50.1=0D
=0D


