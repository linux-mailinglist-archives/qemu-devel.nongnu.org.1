Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F67E718B68
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:45:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Sff-0005qY-J5; Wed, 31 May 2023 16:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q4Sfd-0005pA-If
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q4SfY-0004tc-UK
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685565823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q6LtvR1dm0dEbGy//NpEggfZC2HfPkGEeilpSRyqNNE=;
 b=Q3Jw1AVEEHMXi8vVKBGwKeBEmi6I9cAMrGNxSXJMdMuIcIHmwTRtmZ2zVYw2D9TC+F87iw
 Xz3YCKUY3+NOs+uBGsW9wAr25diW0WyIg1aJd1sVaNng5rSiyqgekvFgeXgHKfE9jg0Ace
 ej+BIVeX5CEgcDbuQH+pmGaLiOG5uvo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-BvCNrmmxMremeMNU0YPoDQ-1; Wed, 31 May 2023 16:43:40 -0400
X-MC-Unique: BvCNrmmxMremeMNU0YPoDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A67A5185A78E;
 Wed, 31 May 2023 20:43:39 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.9.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 023A2202696C;
 Wed, 31 May 2023 20:43:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PULL 0/5] Python patches
Date: Wed, 31 May 2023 16:43:33 -0400
Message-Id: <20230531204338.1656158-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

The following changes since commit ab7252279727da51c01cdaf41c5fe563bbded3a6=
:=0D
=0D
  gitlab: switch from 'stable' to 'latest' docker container tags (2023-05-3=
1 10:29:14 -0700)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/jsnow/qemu.git tags/python-pull-request=0D
=0D
for you to fetch changes up to c76e7652c786683edcc846ee0a7a65b587787792:=0D
=0D
  Revert "python/qmp/protocol: add open_with_socket()" (2023-05-31 16:25:35=
 -0400)=0D
=0D
----------------------------------------------------------------=0D
Python: synchronize python-qemu-qmp=0D
=0D
----------------------------------------------------------------=0D
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
2.40.1=0D
=0D


