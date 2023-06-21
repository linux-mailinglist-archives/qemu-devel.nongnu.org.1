Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEAB73782D
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 02:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBlbY-00041f-Bn; Tue, 20 Jun 2023 20:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qBlbU-0003yV-7W
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 20:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qBlbQ-00007I-Ms
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 20:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687306899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Rpb0bW17Lq9dL8U2yqW0FfJJAd283MW1GSXaVIBmnXA=;
 b=WLPqj+0J+A7+cbNky+DmWQh9HII8rl0+Puop39xGNF+AyXJyGjTmMO3tjyogls60ISYp9d
 645XZfHeNiHWcc7pEVGuoRCqlz62Iebf8MZ0RJ+Jr8NqkU5vPv9po0T+rF7Sc69QP55u6c
 00HQ8vLLn/LHC0qktyjreIYh8BH2xwE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-GzpYEc-lPVm9GYtFL0gT5g-1; Tue, 20 Jun 2023 20:21:35 -0400
X-MC-Unique: GzpYEc-lPVm9GYtFL0gT5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F22680123E;
 Wed, 21 Jun 2023 00:21:35 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00321112132C;
 Wed, 21 Jun 2023 00:21:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RFC 0/6] Switch iotests to pyvenv
Date: Tue, 20 Jun 2023 20:21:15 -0400
Message-Id: <20230621002121.1609612-1-jsnow@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi, this is ... a fairly incomplete series about trying to get iotests=0D
to run out of the configure-time venv. I'm looking for some feedback, so=0D
out to the list it goes.=0D
=0D
Primarily, I'm having doubts about these points:=0D
=0D
1) I think I need something like "mkvenv install" in the first patch,=0D
   but mkvenv.py is getting pretty long...=0D
=0D
2) Is there a way to optimize the speed for patch #2? Maybe installing=0D
   this package can be skipped until it's needed, but that means that=0D
   things like iotest's ./check might get complicated to support that.=0D
=0D
3) I cheated quite a bit in patch 4 to use the correct Python to launch=0D
   iotests, but I'm wondering if there's a nicer way to solve this=0D
   more *completely*.=0D
=0D
John Snow (6):=0D
  experiment: add mkvenv install=0D
  build, tests: Add qemu in-tree packages to pyvenv at configure time.=0D
  iotests: get rid of '..' in path environment output=0D
  iotests: use the correct python to run linters=0D
  iotests: use pyvenv/bin/python3 to launch child test processes=0D
  iotests: don't add qemu.git/python to PYTHONPATH=0D
=0D
 configure                     | 31 +++++++++++++++++++++++++++=0D
 python/scripts/mkvenv.py      | 40 +++++++++++++++++++++++++++++++++++=0D
 tests/qemu-iotests/linters.py |  2 +-=0D
 tests/qemu-iotests/testenv.py | 21 ++++++++++++------=0D
 4 files changed, 87 insertions(+), 7 deletions(-)=0D
=0D
-- =0D
2.40.1=0D
=0D


