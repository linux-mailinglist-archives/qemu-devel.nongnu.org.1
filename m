Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C677BFF1E
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 16:25:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqDfX-0001ut-E1; Tue, 10 Oct 2023 10:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qqDfU-0001rG-Ev
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qqDfS-0008Ta-SD
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696947902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M1ohce11WkNNe0cgAMwi8ts3gYAezYJYisUUMXuKoVk=;
 b=CgkLaFa03+4DpM6yTv8k4Hs0d6VRDgGrYZk1ivKyf9tRzbOwWNUTV2DlJRwxQv9USL4Jhu
 f8ALNOh8UTrQcPTT/St6/InTSBMcNqCoI5HK0D5oIzVVi8zSQb3Ux8PasvzaLUFbr8eToe
 j9MqM8qhaRZOij4BiQOz3QuQnuf66Rk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-89qBaz_dOnaFnIUeUFJLoQ-1; Tue, 10 Oct 2023 10:24:58 -0400
X-MC-Unique: 89qBaz_dOnaFnIUeUFJLoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56B9C1875056;
 Tue, 10 Oct 2023 14:24:57 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-239.str.redhat.com
 [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BD3921CAC6B;
 Tue, 10 Oct 2023 14:24:56 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 0/3] arm/kvm: use kvm_{get,set}_one_reg
Date: Tue, 10 Oct 2023 16:24:50 +0200
Message-ID: <20231010142453.224369-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I sent this cleanup first... in mid-July (ugh). But better late than never, I guess.

From v1:
- fix buglets (thanks Gavin)
- add patch 3 on top

The kvm_{get,set}_one_reg functions have been around for a very long
time, and using them instead of open-coding the ioctl invocations
saves lines of code, and gives us a tracepoint as well. They cannot
be used by invocations of the ioctl not acting on a CPUState, but
that still leaves a lot of conversions in the target/arm code.

target/mips and target/ppc also have some potential for conversions,
but as I cannot test either (and they are both in 'Odd fixes' anyway),
I left them alone.

Survives some testing on a Mt. Snow.

Cornelia Huck (3):
  arm/kvm: convert to kvm_set_one_reg
  arm/kvm: convert to kvm_get_one_reg
  arm/kvm: convert to read_sys_reg64

 target/arm/kvm.c   |  28 +++-------
 target/arm/kvm64.c | 129 ++++++++++++---------------------------------
 2 files changed, 40 insertions(+), 117 deletions(-)

-- 
2.41.0


