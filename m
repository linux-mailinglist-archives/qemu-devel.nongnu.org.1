Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D37C70D3
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:58:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqx8D-0007y1-82; Thu, 12 Oct 2023 10:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqx8A-0007xf-2w
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqx88-0000tR-Ba
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697122659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VY7yYWrl74DMjKqEjJNpQ5wu/FhGWamfVRAk8X4dKeY=;
 b=YhV2U6m6IStFPJRu9mQOXqSYk61EYk7fYONMfZSr6gdkxDjcI58a4LRlN1k+VgBy9vaMU2
 8tymz+hiS2icrxB8noEvSE9qoHQuXw+1ecB7NfAUAGB9F6qQMRe/9P8xJOb8p6CC0YPLii
 W78xH38UCUCd7wkwAGjQ+xHy1/V5fY0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-fW0GqAitMK2EMTIx9Lc5RQ-1; Thu, 12 Oct 2023 10:57:23 -0400
X-MC-Unique: fW0GqAitMK2EMTIx9Lc5RQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BCC6811731
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 14:57:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0244202701E
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 14:57:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A935021E6A21; Thu, 12 Oct 2023 16:57:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/5] -Wshadow=local patches for 2023-10-12
Date: Thu, 12 Oct 2023 16:57:16 +0200
Message-ID: <20231012145721.77039-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

The following changes since commit a51e5124a655b3dad80b36b18547cb1eca2c5eb2:

  Merge tag 'pull-omnibus-111023-1' of https://gitlab.com/stsquad/qemu into staging (2023-10-11 09:43:10 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-shadow-2023-10-12

for you to fetch changes up to c35b2fb1fdc7f6926653cc6df289e5bd77ecbad3:

  target/i386: fix shadowed variable pasto (2023-10-12 16:37:31 +0200)

----------------------------------------------------------------
-Wshadow=local patches for 2023-10-12

----------------------------------------------------------------
Paolo Bonzini (1):
      target/i386: fix shadowed variable pasto

Thomas Huth (4):
      libvduse: Fix compiler warning with -Wshadow=local
      libvhost-user: Fix compiler warning with -Wshadow=local
      hw/virtio/virtio-gpu: Fix compiler warning when compiling with -Wshadow
      contrib/vhost-user-gpu: Fix compiler warning when compiling with -Wshadow

 contrib/vhost-user-gpu/vugpu.h            |  8 ++++----
 include/hw/virtio/virtio-gpu.h            |  8 ++++----
 contrib/vhost-user-gpu/vhost-user-gpu.c   |  6 +++---
 subprojects/libvduse/libvduse.c           |  2 +-
 subprojects/libvhost-user/libvhost-user.c | 12 ++++++------
 target/i386/tcg/seg_helper.c              |  2 +-
 6 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.41.0


