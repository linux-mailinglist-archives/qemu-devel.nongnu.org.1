Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B217C88BB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:34:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKAT-0003TZ-AC; Fri, 13 Oct 2023 11:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qrKAR-0003TO-Oy
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qrKAQ-0003Fa-GE
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697211213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yvz1OHr5kVNdIs0kBAnzxqvYkh1Zjn6Y/YHAgI9pDVQ=;
 b=YyxLSpuQw76e+hRJuMNm3UP9HJ5+PCZCSDYySHYSMsPO16NmOJP1463mpNNYONFxfL3Cgh
 5vPtRjOz0DvIIHT2N/gDGCuk2uvu669JLillDUnWVWIiMzin0z1szfOBZo87+SlWTIF3vG
 BTy9RHDiBjcVTa1MUZQLixA0hetSu2Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-n3O4MS5FOZCl5szyRjw2Mw-1; Fri, 13 Oct 2023 11:33:22 -0400
X-MC-Unique: n3O4MS5FOZCl5szyRjw2Mw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 071691006E2C;
 Fri, 13 Oct 2023 15:33:22 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2701EC15BBC;
 Fri, 13 Oct 2023 15:33:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] block: Fix locking in media change monitor commands
Date: Fri, 13 Oct 2023 17:33:00 +0200
Message-ID: <20231013153302.39234-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Kevin Wolf (2):
  block: Fix locking in media change monitor commands
  iotests: Test media change with iothreads

 block/qapi-sysemu.c    | 5 +++++
 tests/qemu-iotests/118 | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.41.0


