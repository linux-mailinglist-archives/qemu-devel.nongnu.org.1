Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 857797B8DA4
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 21:48:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo7pE-0004gp-9b; Wed, 04 Oct 2023 15:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qo7pA-0004fR-5m
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:46:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qo7p6-00057V-RE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696448779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TX7kKZmBtJZ5PBGYSWB5p9gNJO/hUqyWgAymBZ2GhF0=;
 b=TTekZrTq/ztHm0PlN0K5WnDLy0XWzCVvBieqjkAzmNA48GwftYarwuHl1xMrTICXI/CyKk
 6E3VsKL4s7nTXb77rP8MINjFuIty50H+O8G5AkZOiz+yKWVcDGYeKd9P0NAobTe4vjfuyh
 f3yD+HwbGjrW7Cu+gqLHKGo3fNPnx/s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-phOAvBEzOEylcy3t1q5R3A-1; Wed, 04 Oct 2023 15:46:16 -0400
X-MC-Unique: phOAvBEzOEylcy3t1q5R3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85F271C05AA7;
 Wed,  4 Oct 2023 19:46:15 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CA4B1054FC2;
 Wed,  4 Oct 2023 19:46:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 0/9] Python patches
Date: Wed,  4 Oct 2023 15:46:04 -0400
Message-ID: <20231004194613.2900323-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit da1034094d375afe9e3d8ec8980550ea0f06f7e0=
:=0D
=0D
  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging =
(2023-10-03 07:43:44 -0400)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/jsnow/qemu.git tags/python-pull-request=0D
=0D
for you to fetch changes up to 4d7a663cbe8343e884b88e44bd88d37dd0a470e5:=0D
=0D
  Python: test Python 3.12 (2023-10-04 15:19:00 -0400)=0D
=0D
----------------------------------------------------------------=0D
Python pullreq=0D
=0D
Buffering improvements for qemu machine, minor changes to support the=0D
newly released Python 3.12=0D
=0D
----------------------------------------------------------------=0D
=0D
John Snow (9):=0D
  Python/iotests: Add type hint for nbd module=0D
  python/machine: move socket setup out of _base_args property=0D
  python/machine: close sock_pair in cleanup path=0D
  python/console_socket: accept existing FD in initializer=0D
  python/machine: use socketpair() for console connections=0D
  python/machine: use socketpair() for qtest connection=0D
  python/machine: remove unused sock_dir argument=0D
  python/qmp: remove Server.wait_closed() call for Python 3.12=0D
  Python: test Python 3.12=0D
=0D
 python/qemu/machine/console_socket.py      | 29 ++++++++---=0D
 python/qemu/machine/machine.py             | 58 +++++++++++++---------=0D
 python/qemu/machine/qtest.py               | 54 +++++++++++++++-----=0D
 python/qemu/qmp/protocol.py                |  1 -=0D
 python/setup.cfg                           |  3 +-=0D
 tests/avocado/acpi-bits.py                 |  5 +-=0D
 tests/avocado/avocado_qemu/__init__.py     |  2 +-=0D
 tests/avocado/machine_aspeed.py            |  5 +-=0D
 tests/docker/dockerfiles/python.docker     |  6 ++-=0D
 tests/qemu-iotests/iotests.py              |  2 +-=0D
 tests/qemu-iotests/tests/copy-before-write |  3 +-=0D
 tests/qemu-iotests/tests/nbd-multiconn     |  4 +-=0D
 12 files changed, 114 insertions(+), 58 deletions(-)=0D
=0D
-- =0D
2.41.0=0D
=0D


