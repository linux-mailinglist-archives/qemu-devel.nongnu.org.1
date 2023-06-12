Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 584EB72BB0E
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 10:43:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8d92-0003zx-Fl; Mon, 12 Jun 2023 04:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1q8d8v-0003zD-Ke
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1q8d8u-0007Zl-4N
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686559395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AMabQvOSmOXuyURGy87blM9bmUvfM431ygIULb+3s+k=;
 b=JDxWbxI7l2zstz4+hGkslKf3UWKsb7eIJ4dHSYy1uGJvtU5kfAHZkgxJALYf2y/41Xuvxj
 D8JZRlXR1/RLivbrIffJ1CroPTSE3DBZ4/jIU57U1BdrhC6ZwLCpU2zdqNt8wGsG2f1Njg
 odHtg8A72bUGwEZadP4TorGIHfrMixU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-LweDO71HPE2ydnHaRl5O0w-1; Mon, 12 Jun 2023 04:42:03 -0400
X-MC-Unique: LweDO71HPE2ydnHaRl5O0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE33B2A59562
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 08:42:02 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C3181121315;
 Mon, 12 Jun 2023 08:42:01 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 0/2] i386: Fix Hyper-V Gen1 guests stuck on boot with
 'hv-passthrough'
Date: Mon, 12 Jun 2023 10:41:59 +0200
Message-Id: <20230612084201.294248-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Hyper-V Gen1 guests are getting stuck on boot when 'hv-passthrough' is
used. While 'hv-passthrough' is a debug only feature, this significantly
limit its usefullness. While debugging the problem, I found that there are
two loosely connected issues:
- 'hv-passthrough' enables 'hv-syndbg' and this is undesired.
- 'hv-syndbg's support by KVM is detected incorrectly when !CONFIG_SYNDBG.

Fix both issues; exclude 'hv-syndbg' from 'hv-passthrough' and don't allow
to turn on 'hv-syndbg' for !CONFIG_SYNDBG builds. 

Vitaly Kuznetsov (2):
  i386: Fix conditional CONFIG_SYNDBG enablement
  i386: Exclude 'hv-syndbg' from 'hv-passthrough'

 docs/system/i386/hyperv.rst | 13 +++++++++----
 target/i386/cpu.c           |  2 ++
 target/i386/kvm/kvm.c       | 18 ++++++++++++------
 3 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.40.1


