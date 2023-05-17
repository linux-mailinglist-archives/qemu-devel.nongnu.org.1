Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFF0706E3E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:35:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzK6P-0004AH-1n; Wed, 17 May 2023 12:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzK6N-00049l-F0
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzK6M-0005yj-3n
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684341249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BzRuunA8tm3Na7CtaNVsqJtYS7m8FrLAJOX4oJ4scwg=;
 b=PfjrsycQpjPcVwqhDjCEw51POyJWC4/RDI+3KJyJI1lhp5+56TBXq1ql/lTRKnnj+K8zXC
 IcJfU8xImnDPFVxBV+TPiMNTyIaG9pMOD+9uC6qDTf+YZ3FIN1efhQel6bYWjxETqs/vzj
 7k8MXY3sVb6yAg1fvI0UlmUhrAlQXXo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-zZk2xqleNjSPnP4X9baxUg-1; Wed, 17 May 2023 12:34:07 -0400
X-MC-Unique: zZk2xqleNjSPnP4X9baxUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FD7E1C12F82;
 Wed, 17 May 2023 16:34:07 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.9.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E30D12166B31;
 Wed, 17 May 2023 16:34:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Beraldo Leal <bleal@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/5] python: backport socket changes from python-qemu-qmp
Date: Wed, 17 May 2023 12:34:01 -0400
Message-Id: <20230517163406.2593480-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a small patchset designed to backport the changes made to the=0D
qemu.qmp code to utilize pre-existing sockets. This contains some small=0D
changes to machine.py to match the new API. This is necessary to do=0D
before dropping qemu.qmp from qemu.git so we can utilize the future=0D
0.0.3 version of qemu.qmp.=0D
=0D
(This should also fix the bug where the buffering limit was not being=0D
applied properly connections utilizing pre-existing sockets.)=0D
=0D
John Snow (5):=0D
  python/qmp: allow sockets to be passed to connect()=0D
  python/qmp/legacy: allow using sockets for connect()=0D
  python/machine: use connect-based interface for existing sockets=0D
  python/qmp/legacy: remove open_with_socket() calls=0D
  Revert "python/qmp/protocol: add open_with_socket()"=0D
=0D
 python/qemu/machine/machine.py | 17 +++++++------=0D
 python/qemu/qmp/legacy.py      | 26 +++++++++-----------=0D
 python/qemu/qmp/protocol.py    | 45 +++++++++++++++-------------------=0D
 3 files changed, 41 insertions(+), 47 deletions(-)=0D
=0D
-- =0D
2.40.0=0D
=0D


