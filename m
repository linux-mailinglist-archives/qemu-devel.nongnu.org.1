Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA57B0729
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 16:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlVif-0005Qb-KF; Wed, 27 Sep 2023 10:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlVid-0005QH-9K
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlVib-0000hR-Vw
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695825647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7fTH1opKly2agrDVyW5EpwUnSFkGFO8Hcgn8aBDzQ/M=;
 b=dZAa8zOlHwteIZToobtntes0mnsXsBXjBxhMvSIFDwNGLNyMzkGQ6VrV2Tcxedug8zobYz
 NLa1mIfTZhW/kpGesPjKGQUvwZRA8jZlR1Qa+yPz+J5I2CZebf2UEXHdi1S10MWHyaZ8RB
 mc+10+N/UuDnrx+yEt32b4rXZ6C2hFg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-JpRSbFmuOxusMl9Ny_kfsQ-1; Wed, 27 Sep 2023 10:40:41 -0400
X-MC-Unique: JpRSbFmuOxusMl9Ny_kfsQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62558803D7D;
 Wed, 27 Sep 2023 14:40:40 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B183492C37;
 Wed, 27 Sep 2023 14:40:39 +0000 (UTC)
From: "Eric Blake" <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, andrey.drobyshev@virtuozzo.com,
 peter.maydell@linaro.org, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 0/3] Another attempt at mailmap patches
Date: Wed, 27 Sep 2023 09:38:16 -0500
Message-ID: <20230927143815.3397386-5-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Blake <eblake@redhat.com>

Experimenting yet again, this time with an eye towards letting patchew
attribute the patch to my name rather than my email.  Also, by sending
a series with more than one patch, I'm testing how authorship is
preserved.  My editor window does not see a body From: line, but
hopefully the list archives do.

Andrey Drobyshev (1):
  mailmap: Fix Andrey Drobyshev author email

Eric Blake (2):
  maint: Tweak comments in mailmap regarding SPF
  mailmap: Fix BALATON Zoltan author email

 .mailmap | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

-- 
2.41.0


