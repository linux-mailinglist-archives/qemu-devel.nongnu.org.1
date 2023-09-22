Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3C37AB209
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 14:20:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjf83-0004FZ-3C; Fri, 22 Sep 2023 08:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1qjf81-0004FI-FB
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 08:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1qjf7z-0007jQ-WD
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 08:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695385163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tzosAyxUhGE9QDJvU79qEShrsZVM9LVDGIUq4K0O808=;
 b=UYe0JMMMVcDBiGm5k2gtxKiYynDqpdDrkllZAEXLu+tDqp4aaeHh8E6sZXwacNXXuAjKXH
 hDDjMSdFVthV9rLDsVk7i56KAyAR/EuPQTZuZgdpgD0Ze5rHGGtXXidmqzMUjTuiRz0e2x
 JNxz7770tyaq4FFWpufuCdumTsYDwnc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-F2L4j2jZNSq3VFdL8qSlYw-1; Fri, 22 Sep 2023 08:19:20 -0400
X-MC-Unique: F2L4j2jZNSq3VFdL8qSlYw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A68823C108E1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 12:19:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A86A071128A;
 Fri, 22 Sep 2023 12:19:16 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH RESEND 0/2] i386: Fix Hyper-V Gen1 guests stuck on boot with
 'hv-passthrough'
Date: Fri, 22 Sep 2023 14:19:13 +0200
Message-ID: <20230922121915.566591-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.41.0


