Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BDD741735
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 19:30:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEYzF-00032S-FN; Wed, 28 Jun 2023 13:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qEYzD-00031v-1Z
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 13:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qEYzB-0005Qd-KZ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 13:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687973384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eSFtaPiuHEYzRK6w1ImaJ8M/QPGrdzfXOBstR2RBPO0=;
 b=RxKerd5c1Zl8PTOxTFewaVPO3pYBHn0SUI4DOGKsqLYgcbXLNWXhxlxtZHsgOdPwxOpNqP
 t7Ulr3MrwV6W0t4YkcgiWDDVKHD1IqZDKfunaZj+PctIT4St9gYnRtxt2jjnXdxXRj/qFI
 pup5OZiG9oQgG2PAg4RRHdkRwvdcOFw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-J1oAPQRvOAC7dk_k5E53mA-1; Wed, 28 Jun 2023 13:29:42 -0400
X-MC-Unique: J1oAPQRvOAC7dk_k5E53mA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DF4A1C47668
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 17:29:42 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.17.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC12140C206F;
 Wed, 28 Jun 2023 17:29:41 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org,
	clg@redhat.com
Cc: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH] MAINTAINERS: Promote Cédric to VFIO co-maintainer
Date: Wed, 28 Jun 2023 11:29:32 -0600
Message-Id: <20230628172932.287318-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Cédric has stepped up involvement in vfio, reviewing and managing
patches, as well as pull requests.  This work deserves gratitude and
punishment with a promotion to co-maintainer ;)

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

Cédric, I'd also support if you wanted to add a tree entry here.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e07746ac7d45..37e48c72b16a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2051,7 +2051,7 @@ F: hw/usb/dev-serial.c
 
 VFIO
 M: Alex Williamson <alex.williamson@redhat.com>
-R: Cédric Le Goater <clg@redhat.com>
+M: Cédric Le Goater <clg@redhat.com>
 S: Supported
 F: hw/vfio/*
 F: include/hw/vfio/
-- 
2.40.1


