Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BC4747555
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:31:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhyF-0004g3-R9; Tue, 04 Jul 2023 11:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qGhyE-0004fo-RB
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qGhyD-0003Ck-8S
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688484576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yjwnQxDM6nbFbyKBhg+E3v2/LWCVjqIR/BvOckJnXc4=;
 b=Rseo9i4rMoU/DyqzhJG82W/N2hjwrAPd01RYzQWYuF/N5Uq5pugTgoF0JhOAFl12YQooeJ
 9F6MbJK5yy4ZoUCFQbXRpmP8YyAtNXBtpiHLRhhNA7Sbm+VbMr8c0PyE9z3YvZgD9jWWXA
 MMSS3sXpPcADphLuSRtcYyZCAV5OQKU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-uucJ-rzhPXON2Je6jGa6vA-1; Tue, 04 Jul 2023 11:29:34 -0400
X-MC-Unique: uucJ-rzhPXON2Je6jGa6vA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 684921C47662;
 Tue,  4 Jul 2023 15:29:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB52D2166B34;
 Tue,  4 Jul 2023 15:29:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Subject: [PULL 0/1] Block patches
Date: Tue,  4 Jul 2023 17:29:31 +0200
Message-Id: <20230704152932.194790-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit d145c0da22cde391d8c6672d33146ce306e8bf75:

  Merge tag 'pull-tcg-20230701' of https://gitlab.com/rth7680/qemu into staging (2023-07-01 08:55:37 +0200)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to c21eae1ccc782440f320accb6f90c66cb8f45ee9:

  block/blkio: fix module_block.py parsing (2023-07-04 17:28:25 +0200)

----------------------------------------------------------------
Pull request

Fix --enable-modules with the blkio block driver.

----------------------------------------------------------------

Stefan Hajnoczi (1):
  block/blkio: fix module_block.py parsing

 block/blkio.c | 108 ++++++++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 52 deletions(-)

-- 
2.40.1


