Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E31DE75AF28
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:06:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTL7-0005nS-AD; Thu, 20 Jul 2023 09:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qMTL0-0005lX-AK
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qMTKw-00063u-IU
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689858292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ftUq+rgsXyJSZNk7V89bB6G85oBw0fZ4y3/aNGIEZV8=;
 b=Q4/9aifWssMeaRgkpHiGg+ZmH9gMbS8t9UItHcRO/U6tiD3yJ67VB7hKh1A7XMC4ThYnjD
 JQumUsXx3zMuL3Pn6HZihG3nQ4s9gyMeJE6iF9VPO/sFyTv3UXtUEOcHxbLSiMa7za6Qp2
 99LWyP7jTfIV5934aps02vxmN+OMaEo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-DYk36zNjMnuCCi1W-a_eiQ-1; Thu, 20 Jul 2023 09:04:49 -0400
X-MC-Unique: DYk36zNjMnuCCi1W-a_eiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BEBD8F1847;
 Thu, 20 Jul 2023 13:04:49 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.18.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCF731121315;
 Thu, 20 Jul 2023 13:04:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel Berrange <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 0/4] python/machine: use socketpair() for console socket
Date: Thu, 20 Jul 2023 09:04:44 -0400
Message-ID: <20230720130448.921356-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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
"lightly tested"; passes local tests and gitlab CI. Doesn't seem to make=0D
anything worse.=0D
=0D
John Snow (4):=0D
  python/machine: move socket setup out of _base_args property=0D
  python/console_socket: accept existing FD in initializer=0D
  python/machine: use socketpair() for console connections=0D
  python/machine: remove unused console socket configuration arguments=0D
=0D
 python/qemu/machine/console_socket.py      | 11 +++---=0D
 python/qemu/machine/machine.py             | 40 +++++++++-------------=0D
 python/qemu/machine/qtest.py               |  6 ++--=0D
 tests/qemu-iotests/tests/copy-before-write |  3 +-=0D
 4 files changed, 27 insertions(+), 33 deletions(-)=0D
=0D
-- =0D
2.41.0=0D
=0D


