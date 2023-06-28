Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 050B274172F
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 19:28:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEYwU-0001c2-MC; Wed, 28 Jun 2023 13:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1qEYwS-0001bo-VF
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 13:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mtosatti@redhat.com>)
 id 1qEYwR-0004sv-Gw
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 13:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687973214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6CKHaLdD6MUf5lvnyDsPv4nM3yOoVncz5ZyEqeb2Kto=;
 b=ZkEVa2nAhaHrZSCNthy+APxt0wduZ6LXoWbVQaZ0mPvwwqRkmuUd5uJMzkRjfYOb9MA+O0
 Hm5oo2JqdxlYJYdK2JUNYWOj53hQ6ybQuQPj4NVcPJJRutcp/XPq84QSNwEUihMr4k6rQd
 /HnuHOu94yvY+CGJF72sKFVUZmxv0R8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-5mLvSTM1PoaPaW_3_E8o2g-1; Wed, 28 Jun 2023 13:26:52 -0400
X-MC-Unique: 5mLvSTM1PoaPaW_3_E8o2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8FA1104458D
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 17:26:52 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67A922166B25;
 Wed, 28 Jun 2023 17:26:52 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
 id 3D345403C37D3; Wed, 28 Jun 2023 14:26:36 -0300 (-03)
Date: Wed, 28 Jun 2023 14:26:36 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <ZJxtTCWvqO2VuL8q@tpad>
References: <20230616140830.316655-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616140830.316655-1-aharivel@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mtosatti@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 16, 2023 at 04:08:30PM +0200, Anthony Harivel wrote:
> Starting with the "Sandy Bridge" generation, Intel CPUs provide a RAPL
> interface (Running Average Power Limit) for advertising the accumulated
> energy consumption of various power domains (e.g. CPU packages, DRAM,
> etc.).
> 
> The consumption is reported via MSRs (model specific registers) like
> MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are
> 64 bits registers that represent the accumulated energy consumption in
> micro Joules. They are updated by microcode every ~1ms.
> 
> For now, KVM always returns 0 when the guest requests the value of
> these MSRs. Use the KVM MSR filtering mechanism to allow QEMU handle
> these MSRs dynamically in userspace.
> 
> To limit the amount of system calls for every MSR call, create a new
> thread in QEMU that updates the "virtual" MSR values asynchronously.
> 
> Each vCPU has its own vMSR to reflect the independence of vCPUs. The
> thread updates the vMSR values with the ratio of energy consumed of
> the whole physical CPU package the vCPU thread runs on and the
> thread's utime and stime values.
> 
> All other non-vCPU threads are also taken into account. Their energy
> consumption is evenly distributed among all vCPUs threads running on
> the same physical CPU package.
> 
> This feature is activated with -accel kvm,rapl=true.

I suppose this should be a CPU flag instead? -cpu xxx,rapl=on.


