Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8F77AF021
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:00:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlATL-0000Ii-Rf; Tue, 26 Sep 2023 11:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qlATH-0000I0-Ui
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qlATF-0007wg-Ug
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695743971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dotcYHPZVWZKXubN3IIwBkoVib1GBjOyExg8Im6ylNk=;
 b=Lskcow/AGBxVhSaJBGUj3uhn8q3ekXf+MbTyB6u0TdWHwmpSBykvCRciKR02ZnYA8RPGNZ
 4Ck2mg5Gqr8VbCGrdoLuOrnHSTmasxEsA6CYZy2EHjsosAGbFgPiP6nmPwZljVO9faleLb
 AlWsOdOoGjKhzHEuR38gNDMiWeRXNgA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-Vsc4q3PEMbegNCb5L_XEDA-1; Tue, 26 Sep 2023 11:59:30 -0400
X-MC-Unique: Vsc4q3PEMbegNCb5L_XEDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 278DB811E88;
 Tue, 26 Sep 2023 15:59:29 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D747E2026D4B;
 Tue, 26 Sep 2023 15:59:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-block@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/5] RFC: migration: check required entries and sections are
 loaded
Date: Tue, 26 Sep 2023 19:59:20 +0400
Message-ID: <20230926155925.1396309-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

To my surprise, QEMU didn't seem to check that required migration entries and
subsections are loaded. I took a naive approach to add such check, by adding
some "visited" marks along the loading path, and checking by the end that all
required entries have been loaded.

Note, I haven't thoroughly tested it yet (it passed make check on x86 targets
with the preliminary "fixes" applied).

Comments welcome!

Marc-André Lureau (5):
  block/fdc: 'phase' is not needed on load
  virtio: make endian_needed() work during loading
  net/slirp: use different IDs for each instance
  RFC: migration: check required subsections are loaded, once
  RFC: migration: check required entries are loaded, once

 hw/block/fdc.c      |  5 +++++
 hw/virtio/virtio.c  |  6 +++++-
 migration/savevm.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 migration/vmstate.c | 40 ++++++++++++++++++++++++++++++++++++++--
 net/slirp.c         |  3 ++-
 5 files changed, 93 insertions(+), 4 deletions(-)

-- 
2.41.0


