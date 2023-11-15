Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 530F97EC05B
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 11:23:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3D2X-0003Kz-7L; Wed, 15 Nov 2023 05:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1r3D2R-0003Jp-VV
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 05:22:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1r3D2N-0005p3-Ve
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 05:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700043739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EJUN3UrFDACuDWRB7wjI0fzTyBiVmFNg6aqmISrTNHw=;
 b=FWapQNvKT62wJaIMJ4TTwWt79GWVvSe+OVNF+h8hJiNGdXR9EGp40Cib45L6FmiM/GERHb
 PaPSRWkNVIKhYk2AuWNB/WIY84THStgz1E3gS1uFspbaoi1h7UaapG1XH/KUEqA8Jsla2B
 JiiLPUyZEVxb9sgYj0bqPnF6ScKLs40=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-mMhHFEDWOR6h-xDRSWnbSA-1; Wed, 15 Nov 2023 05:22:16 -0500
X-MC-Unique: mMhHFEDWOR6h-xDRSWnbSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1D88811E7D
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 10:22:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 021F740C6EB9;
 Wed, 15 Nov 2023 10:22:15 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH RESEND v2 0/2] i386: Fix Hyper-V Gen1 guests stuck on boot
 with 'hv-passthrough'
Date: Wed, 15 Nov 2023 11:22:13 +0100
Message-ID: <20231115102215.372012-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
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

Changes since v1/v1 RESEND:
- No changes.

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


