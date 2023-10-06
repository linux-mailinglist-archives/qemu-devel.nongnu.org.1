Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ED67BBFE3
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 21:54:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoqsc-0002fS-WF; Fri, 06 Oct 2023 15:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoqsb-0002ei-3Y
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 15:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoqsZ-0007oc-Lh
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 15:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696621975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mThRO4SVT8bNe/15jLdU+4Qzp3TE2supcxk97WMuffE=;
 b=Wz/qNtVaWUuUO2jAKi5CohqkROw87epNGRG96iRH5QynWisiSca0jg2V3299WkSbmqMcqJ
 tuDZBG32Jh60ygqiMsPvGwl/XHiksV5IZhkkiEArmsc6lYtk7cgzR42OiD2yRYkt+aw+gK
 Typu6XFQoqOUq4fReC5pUEuQTn3eto8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-IalOPeXrOCKJ2YlxsV87Nw-1; Fri, 06 Oct 2023 15:52:44 -0400
X-MC-Unique: IalOPeXrOCKJ2YlxsV87Nw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78B9C802C1A;
 Fri,  6 Oct 2023 19:52:44 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE793492C37;
 Fri,  6 Oct 2023 19:52:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] Python: Enable python3.12 support
Date: Fri,  6 Oct 2023 15:52:39 -0400
Message-ID: <20231006195243.3131140-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

A few mostly trivial fixes, one backport from the qemu.qmp repo, and=0D
enabling the Python tests to run against Python3.12.=0D
=0D
John Snow (4):=0D
  Python/iotests: Add type hint for nbd module=0D
  python/qmp: remove Server.wait_closed() call for Python 3.12=0D
  configure: fix error message to say Python 3.8=0D
  Python: Enable python3.12 support=0D
=0D
 configure                              | 5 +++--=0D
 python/qemu/qmp/protocol.py            | 1 -=0D
 python/setup.cfg                       | 3 ++-=0D
 tests/docker/dockerfiles/python.docker | 6 +++++-=0D
 tests/qemu-iotests/tests/nbd-multiconn | 4 +++-=0D
 5 files changed, 13 insertions(+), 6 deletions(-)=0D
=0D
-- =0D
2.41.0=0D
=0D


