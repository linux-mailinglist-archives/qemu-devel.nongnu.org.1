Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B11687EA8F3
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 04:11:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2joK-0001pA-VU; Mon, 13 Nov 2023 22:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r2joH-0001og-NE
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 22:09:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r2joF-0001jC-Mn
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 22:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699931387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5zEWnzP/Zrk2SctaaWXM+4H11B4Az00OIEN4RPdC82E=;
 b=IJKgneBtTsT7z51H1yaUyDgOe7KmoQ7v5JAE5T2OZke5lSewJEGuDLUwZ88zuz4udFxvhX
 G3Cy35TvbnUOWlXiOD+69fgnP2zhYKt4E6FcEzr8sC6L1gzcEdxxEeSsccqTjrkH4eIqQO
 YRe+JGUyDOA/a3joWVP0GL6FiTqQ1zI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-KisDLx1_M92FVtSNqvi-jg-1; Mon,
 13 Nov 2023 22:09:45 -0500
X-MC-Unique: KisDLx1_M92FVtSNqvi-jg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA41B3806623
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 03:09:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A4F9C1596F;
 Tue, 14 Nov 2023 03:09:42 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com
Subject: [PULL 0/2] Net patches
Date: Tue, 14 Nov 2023 11:09:35 +0800
Message-ID: <20231114030937.5461-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 69680740eafa1838527c90155a7432d51b8ff203:

  Merge tag 'qdev-array-prop' of https://repo.or.cz/qemu/kevin into staging (2023-11-11 11:23:25 +0800)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to d90014fc337ab77f37285b1a30fd4f545056be0a:

  igb: Add Function Level Reset to PF and VF (2023-11-13 15:33:37 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Cédric Le Goater (2):
      igb: Add a VF reset handler
      igb: Add Function Level Reset to PF and VF

 hw/core/machine.c   |  3 ++-
 hw/net/igb.c        | 15 +++++++++++++++
 hw/net/igb_common.h |  1 +
 hw/net/igb_core.c   |  6 ++++--
 hw/net/igb_core.h   |  3 +++
 hw/net/igbvf.c      | 19 +++++++++++++++++++
 hw/net/trace-events |  1 +
 7 files changed, 45 insertions(+), 3 deletions(-)



