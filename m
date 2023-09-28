Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A15207B11BC
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 06:51:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qliyO-0002Hx-IF; Thu, 28 Sep 2023 00:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qliyI-0002H4-R1
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 00:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qliyE-0006gI-Ne
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 00:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695876588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y9oszX0ik0YIhF4C4Ia23RjkHAhAWVhA/YtWznqYNkw=;
 b=HbI6s4G61nQHET5d/1CFhURSz7zwQZ6Q+pQWlk+Fl3cjF79ndODWFmeQT4x9Svy4JhngxH
 MilfbYdAAUTBOCPERq0BBLqHuSJIJD3GbfmL9atAR24LGSytgHHkfLWNhH6Mpmil1Cu2yV
 o3aXs1XYRfIDvvFGAK1bZx7OanVJbq8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-Btr3QoQ4Oi-OGM7072o6Sg-1; Thu, 28 Sep 2023 00:49:44 -0400
X-MC-Unique: Btr3QoQ4Oi-OGM7072o6Sg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48721101A53B;
 Thu, 28 Sep 2023 04:49:44 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D5C51004145;
 Thu, 28 Sep 2023 04:49:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Daniel Berrange <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 0/6] python/machine: use socketpair() for console socket
Date: Thu, 28 Sep 2023 00:49:37 -0400
Message-ID: <20230928044943.849073-1-jsnow@redhat.com>
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

Like we did for the QMP socket, use socketpair() for the console socket=0D
so that hopefully there isn't a race condition during early boot where=0D
data might get dropped on the floor.=0D
=0D
May or may not help with various race conditions where early console=0D
output is not showing up in the logs and/or potentially being missed by=0D
wait_for_console_pattern.=0D
=0D
V3:=0D
  - Rebased.=0D
=0D
V2:=0D
  - Fixed some Socket ownership/garbage collection problems=0D
  - Fixed callers of now-dropped VM arguments/properties=0D
  - added a dedicated sock_fd arg to ConsoleSocket()=0D
  - now using socketpair() for qtest console, too.=0D
  - dropped sock_dir arg from *all* machine.py classes=0D
  - Tested quite a bit more thoroughly ...=0D
=0D
CI: https://gitlab.com/jsnow/qemu/-/pipelines/1019123030=0D
=0D
John Snow (6):=0D
  python/machine: move socket setup out of _base_args property=0D
  python/machine: close sock_pair in cleanup path=0D
  python/console_socket: accept existing FD in initializer=0D
  python/machine: use socketpair() for console connections=0D
  python/machine: use socketpair() for qtest connection=0D
  python/machine: remove unused sock_dir argument=0D
=0D
 python/qemu/machine/console_socket.py      | 29 ++++++++---=0D
 python/qemu/machine/machine.py             | 58 +++++++++++++---------=0D
 python/qemu/machine/qtest.py               | 54 +++++++++++++++-----=0D
 tests/avocado/acpi-bits.py                 |  5 +-=0D
 tests/avocado/avocado_qemu/__init__.py     |  2 +-=0D
 tests/avocado/machine_aspeed.py            |  5 +-=0D
 tests/qemu-iotests/iotests.py              |  2 +-=0D
 tests/qemu-iotests/tests/copy-before-write |  3 +-=0D
 8 files changed, 104 insertions(+), 54 deletions(-)=0D
=0D
-- =0D
2.41.0=0D
=0D


