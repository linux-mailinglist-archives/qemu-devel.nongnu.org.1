Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6EA70DB22
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 13:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Pp1-0004Sx-8s; Tue, 23 May 2023 07:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1Pox-0004SH-IN
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1Pov-0002c8-Rb
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684839888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kn5u4R+VPKfB4NezWg2H36ZuXLpsz4C/GTaMIy2LLz4=;
 b=c9f+PVQcXOcK29TggU+vugYbuw1d1bu8n96I0Dmb1nS/8V4/wGXPPv+1yTgA+yjxhAF/bv
 W9gtIE9GW8jjN9DeeZgHuuA0XH8+Z60T5Wfj8Ukts6OFacdFde+qj3ocLgtqcOiW/Gse0c
 RKA5JFmL25KImyrgGhTM+ymQhLm5hn0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-Nb9aR8leMEKrUf6hs6eMfw-1; Tue, 23 May 2023 07:04:46 -0400
X-MC-Unique: Nb9aR8leMEKrUf6hs6eMfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF6B13C13A09;
 Tue, 23 May 2023 11:04:45 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B8007AF5;
 Tue, 23 May 2023 11:04:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Max Filippov <jcmvbkbc@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/5] Use MachineClass->default_nic in more machines
Date: Tue, 23 May 2023 13:04:30 +0200
Message-Id: <20230523110435.1375774-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These patches are required for running more tests with "make check"
on builds that use "--without-default-devices". By marking the
default NIC in the generic MachineClass, the main code can decide
whether the NIC is available in the binary or not, so the instantiation
can be skipped if it has not been compiled in.

See https://lore.kernel.org/qemu-devel/20230512124033.502654-5-thuth@redhat.com/
and the other patches in that series for more information.

Thomas Huth (5):
  hw/hppa: Use MachineClass->default_nic in the hppa machine
  hw/alpha: Use MachineClass->default_nic in the alpha machine
  hw/arm: Use MachineClass->default_nic in the virt machine
  hw/loongarch64: Use MachineClass->default_nic in the virt machine
  hw/xtensa: Use MachineClass->default_nic in the virt machine

 hw/alpha/dp264.c    | 4 +++-
 hw/arm/virt.c       | 4 +++-
 hw/hppa/machine.c   | 4 +++-
 hw/loongarch/virt.c | 4 +++-
 hw/xtensa/virt.c    | 9 ++++++---
 5 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.31.1


