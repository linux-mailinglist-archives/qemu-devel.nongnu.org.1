Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E6B751850
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 07:47:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJp9i-0007ip-DF; Thu, 13 Jul 2023 01:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qJp9J-0007gV-2V
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 01:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qJp9G-0001TV-7W
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 01:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689227152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4hLiYy3eI3RGAwbymvKSHRyfNJ8dUeEtHkvmT3p1EKw=;
 b=i5ib17Jh7cD6I+tGsLDw5RIHdTqHbktfhawW3HnSvTZPm5LfkwfUSVBueQ5gfkXsMcHNrR
 +FG8ddswsonJ3ktnvnu3AYqwf0SVHHXacJa21mKDPIRxW9E2idHtKqKU6/zLitYfkHw2aU
 1rZuPKtXz+ysrzwBosLikANSPhTM3eo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-42N0DitWOQeBlEO0LFLgAg-1; Thu, 13 Jul 2023 01:45:47 -0400
X-MC-Unique: 42N0DitWOQeBlEO0LFLgAg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C8FC38117E7;
 Thu, 13 Jul 2023 05:45:47 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-126.bne.redhat.com [10.64.54.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78E6B111DCE0;
 Thu, 13 Jul 2023 05:45:43 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net,
 peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, shan.gavin@gmail.com
Subject: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
Date: Thu, 13 Jul 2023 15:44:59 +1000
Message-ID: <20230713054502.410911-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

There is a generic CPU type invalidation in machine_run_board_init()
and we needn't a same and private invalidation for hw/arm/virt machines.
This series intends to use the generic CPU type invalidation on the
hw/arm/virt machines.

PATCH[1] factors the CPU type invalidation logic in machine_run_board_init()
         to a helper validate_cpu_type().
PATCH[2] uses the generic CPU type invalidation for hw/arm/virt machines
PATCH[3] support "host-arm-cpu" CPU type only when KVM or HVF is visible

Testing
=======

With the following command lines, the output messages are varied before
and after the series is applied.

  /home/gshan/sandbox/src/qemu/main/build/qemu-system-aarch64 \
  -accel tcg -machine virt,gic-version=3,nvdimm=on            \
  -cpu cortex-a8 -smp maxcpus=2,cpus=1                        \
    :

Before the series is applied:

  qemu-system-aarch64: mach-virt: CPU type cortex-a8-arm-cpu not supported

After the series is applied:

  qemu-system-aarch64: Invalid CPU type: cortex-a8-arm-cpu
  The valid types are: cortex-a7-arm-cpu, cortex-a15-arm-cpu, \
  cortex-a35-arm-cpu, cortex-a55-arm-cpu, cortex-a72-arm-cpu, \
  cortex-a76-arm-cpu, a64fx-arm-cpu, neoverse-n1-arm-cpu,     \
  neoverse-v1-arm-cpu, cortex-a53-arm-cpu, cortex-a57-arm-cpu, \
  max-arm-cpu

Gavin Shan (3):
  machine: Factor CPU type invalidation out into helper
  hw/arm/virt: Use generic CPU type invalidation
  hw/arm/virt: Support host CPU type only when KVM or HVF is configured

 hw/arm/virt.c     | 23 +++-----------
 hw/core/machine.c | 81 +++++++++++++++++++++++++----------------------
 2 files changed, 48 insertions(+), 56 deletions(-)

-- 
2.41.0


