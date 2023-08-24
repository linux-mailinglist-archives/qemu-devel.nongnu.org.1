Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FEE786ADF
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 10:59:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6AO-0007N6-Lf; Thu, 24 Aug 2023 04:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6AK-0007KO-LG
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6AH-0003iX-EL
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692867484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4UjV1Cq9QGogUnc6vRlj5MB9o7TDRbjhsTAnWa5TKhA=;
 b=CWm/0KVtKff2dGItZbHLFBHf+xROt/qP/d1yNDX0gg960dnhvxaHnRxY+mzfBERxQ7HGZQ
 BzQFGDO5GYfhawFKOrz0AEORFNPiyuINky2oFcCxt4p8CPXJVccSHCA5PIWAh7/b4CQe7t
 QaJGrkAYgF5eDz9MnhBrRqjqHHYREnU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-69TlBFKjOw2oNyPhqo0hhA-1; Thu, 24 Aug 2023 04:57:58 -0400
X-MC-Unique: 69TlBFKjOw2oNyPhqo0hhA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28D571C09A46;
 Thu, 24 Aug 2023 08:57:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE2AC492C13;
 Thu, 24 Aug 2023 08:57:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AEF8518003AB; Thu, 24 Aug 2023 10:57:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 0/6] misc tweaks for kvm and the 64bit pci window
Date: Thu, 24 Aug 2023 10:57:50 +0200
Message-ID: <20230824085756.66732-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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

v4 changes:
 - fix handling of 32bit memory bars.
v3 changes:
 - rename variables, use u8 for CPULongMode.
v2 changes:
 - e820 conflict fix

Gerd Hoffmann (6):
  better kvm detection
  detect physical address space size
  move 64bit pci window to end of address space
  be less conservative with the 64bit pci io window
  qemu: log reservations in fw_cfg e820 table
  check for e820 conflict

 src/e820map.h     |  1 +
 src/fw/paravirt.h |  2 ++
 src/e820map.c     | 15 ++++++++
 src/fw/paravirt.c | 89 +++++++++++++++++++++++++++++++++++++++++------
 src/fw/pciinit.c  | 26 +++++++++++---
 5 files changed, 119 insertions(+), 14 deletions(-)

-- 
2.41.0


