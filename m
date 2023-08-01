Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DA776BB98
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 19:48:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQtSW-00016t-PL; Tue, 01 Aug 2023 13:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQtSU-00016N-Rf
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:46:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQtSS-00075l-Hf
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 13:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690912015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BLDF/HvE/xOFgSbar1kUmpbEcAu9bsVBfjwCBbik3EM=;
 b=GndZ7U2TXQign8yXbPLAd+gG6Y7Olii0qTsxFz1P5q1j+19bCCDLWTbTl+axMXuhS2b3q/
 uwsaBlF8SDwOb8YjOIJkO7kVlx2SY9ilIhxYrPEyPq28pMA+kEH+zr9UvE4RvuSqm0jVzz
 TkipYbRRy7qVLxboyAfV9PFWb3SPXuM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-7S4OkJNgOSWFLbCLtIphGA-1; Tue, 01 Aug 2023 13:46:52 -0400
X-MC-Unique: 7S4OkJNgOSWFLbCLtIphGA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 326C88A7F6B;
 Tue,  1 Aug 2023 17:46:52 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DCBC401DA9;
 Tue,  1 Aug 2023 17:46:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 0/1 for 8.1] TLS crash fix
Date: Tue,  1 Aug 2023 18:46:49 +0100
Message-ID: <20230801174650.177924-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

The following changes since commit 802341823f1720511dd5cf53ae40285f7978c61b:

  Merge tag 'pull-tcg-20230731' of https://gitlab.com/rth7680/qemu into staging (2023-07-31 14:02:51 -0700)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/io-tls-hs-crash-pull-request

for you to fetch changes up to 10be627d2b5ec2d6b3dce045144aa739eef678b4:

  io: remove io watch if TLS channel is closed during handshake (2023-08-01 18:45:27 +0100)

----------------------------------------------------------------
Fix crash during early close of TLS channel

----------------------------------------------------------------

Daniel P. Berrangé (1):
  io: remove io watch if TLS channel is closed during handshake

 include/io/channel-tls.h |  1 +
 io/channel-tls.c         | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.41.0


