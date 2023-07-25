Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F907620F6
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:05:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMOK-00031d-FW; Tue, 25 Jul 2023 14:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qOMOI-0002zv-IG
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qOMOF-00018v-Sn
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690308246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9XuN+LNWkwxemHuxadKoQ4qZ4P3yeKY65rhtqX/RMqE=;
 b=RjZ6Q8mNYt8K/mGX0H7JSho+ctwrSCzHSTan9dfLRNsf4YRUPpmLkF98MzfOko+LznKZmF
 FvWvq9kuTfnrGq6vn+YHeb0mIr4UXw4FCVS1OsKQ1fe8CX/pX5wpQZr8/CasOTuzBH/6AL
 yYUurl9hhN368GqR5g3QZ0QkZqfD4Fk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-oZedKdsFMBGCjoPuuZdgGg-1; Tue, 25 Jul 2023 14:04:00 -0400
X-MC-Unique: oZedKdsFMBGCjoPuuZdgGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C11A2101A54E;
 Tue, 25 Jul 2023 18:03:38 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2BB21454154;
 Tue, 25 Jul 2023 18:03:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 0/6] python/machine: use socketpair() for console socket
Date: Tue, 25 Jul 2023 14:03:31 -0400
Message-ID: <20230725180337.2937292-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
V2:=0D
  - Fixed some Socket ownership/garbage collection problems=0D
  - Fixed callers of now-dropped VM arguments/properties=0D
  - added a dedicated sock_fd arg to ConsoleSocket()=0D
  - now using socketpair() for qtest console, too.=0D
  - dropped sock_dir arg from *all* machine.py classes=0D
  - Tested quite a bit more thoroughly ...=0D
=0D
CI: https://gitlab.com/jsnow/qemu/-/pipelines/945067498=0D
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


