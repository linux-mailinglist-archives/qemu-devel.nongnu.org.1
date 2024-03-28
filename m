Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4610387C1B5
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Mar 2024 17:59:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkoPx-0006Rw-N2; Thu, 14 Mar 2024 12:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rkoPl-0006Ou-3J
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rkoPj-0003Xm-2f
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710435522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wOll5lyFhtYNeAOUADWumYDLJEBPlb1Hvjf3Y1fqP/c=;
 b=YAL62wf46pPoR7hCFROlK+M6A70ZxWu3QSWxOKQvpZ/aWOcBUn/OZV0DDrh9RWCpbjpp1q
 Ir44cXhKYjNaSanbDZOCXNXWXza/ojLyG/TPNNexjI8UGWThc18bVr7xqBb2sFnBB2yRlE
 W8I5YRmaPxU0F/BlPUrwmI6kWTCoqRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-ZueUhkXiMSqRb-nEKooYJw-1; Thu, 14 Mar 2024 12:58:37 -0400
X-MC-Unique: ZueUhkXiMSqRb-nEKooYJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A677879844;
 Thu, 14 Mar 2024 16:58:37 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CA57111E3F3;
 Thu, 14 Mar 2024 16:58:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, aliang@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH for-9.0 0/2] nbd: Fix server crash on reset with iothreads
Date: Thu, 14 Mar 2024 17:58:23 +0100
Message-ID: <20240314165825.40261-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

Kevin Wolf (2):
  nbd/server: Fix race in draining the export
  iotests: Add test for reset/AioContext switches with NBD exports

 nbd/server.c                                  | 15 ++---
 tests/qemu-iotests/tests/iothreads-nbd-export | 66 +++++++++++++++++++
 .../tests/iothreads-nbd-export.out            | 19 ++++++
 3 files changed, 92 insertions(+), 8 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/iothreads-nbd-export
 create mode 100644 tests/qemu-iotests/tests/iothreads-nbd-export.out

-- 
2.44.0


