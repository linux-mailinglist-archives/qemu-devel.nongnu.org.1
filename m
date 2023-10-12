Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C143F7C6C93
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 13:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqu3j-0006cC-4x; Thu, 12 Oct 2023 07:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqu3U-0006SD-S9
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:40:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqu3G-0000Q2-Cp
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697110824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ptHjUSUcLOQy/0I79mlCXJl4iK1DuNkCNx9x7wvJAg=;
 b=Gd5NVBp5YuVqBm1PCrhX9UyBfPmjBN7W92tmMWWvACsAds9rBZHcG8sVqxd//tULUy2t0Z
 rATqRndWV73N+mTpkdRLBwmJ2CmzL1Iibnl9nRKaRmbqjOh5cWnMtQkvBS/yphXfhOYvSP
 s8m3ctCmyZ3cngClFZB5+i/MFCk2IYc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-m7vi9k_OM1CZWHkvRpOQlg-1; Thu, 12 Oct 2023 07:40:15 -0400
X-MC-Unique: m7vi9k_OM1CZWHkvRpOQlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 589D03C17124;
 Thu, 12 Oct 2023 11:40:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29CFE1C06533;
 Thu, 12 Oct 2023 11:40:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F0F421E6A21; Thu, 12 Oct 2023 13:40:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  Thomas
 Huth <thuth@redhat.com>,  Eric Blake <eblake@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Cleber Rosa
 <crosa@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,  Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v25 12/21] qapi/s390x/cpu topology:
 CPU_POLARIZATION_CHANGE qapi event
References: <20231005160155.1945588-1-nsg@linux.ibm.com>
 <20231005160155.1945588-13-nsg@linux.ibm.com>
Date: Thu, 12 Oct 2023 13:40:10 +0200
In-Reply-To: <20231005160155.1945588-13-nsg@linux.ibm.com> (Nina
 Schoetterl-Glausch's message of "Thu, 5 Oct 2023 18:01:46 +0200")
Message-ID: <8734ygyspx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In the subject: QAPI event

Nina Schoetterl-Glausch <nsg@linux.ibm.com> writes:

> From: Pierre Morel <pmorel@linux.ibm.com>
>
> When the guest asks to change the polarization this change
> is forwarded to the upper layer using QAPI.
> The upper layer is supposed to take according decisions concerning
> CPU provisioning.
>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>  qapi/machine-target.json | 34 ++++++++++++++++++++++++++++++++++
>  hw/s390x/cpu-topology.c  |  2 ++
>  2 files changed, 36 insertions(+)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 3fd8390922..02f1de5d02 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -417,3 +417,37 @@
>    'features': [ 'unstable' ],
>    'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
>  }
> +
> +##
> +# @CPU_POLARIZATION_CHANGE:
> +#
> +# Emitted when the guest asks to change the polarization.
> +#
> +# The guest can tell the host (via the PTF instruction) whether the
> +# CPUs should be provisioned using horizontal or vertical polarization.
> +#
> +# On horizontal polarization the host is expected to provision all vCPUs
> +# equally.

Blank line between paragraphs, please.

> +# On vertical polarization the host can provision each vCPU differently.
> +# The guest will get information on the details of the provisioning
> +# the next time it uses the STSI(15) instruction.
> +#
> +# @polarization: polarization specified by the guest
> +#
> +# Features:
> +#
> +# @unstable: This event is experimental.
> +#
> +# Since: 8.2
> +#
> +# Example:
> +#
> +# <- { "event": "CPU_POLARIZATION_CHANGE",
> +#      "data": { "polarization": "horizontal" },
> +#      "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
> +##
> +{ 'event': 'CPU_POLARIZATION_CHANGE',
> +  'data': { 'polarization': 'CpuS390Polarization' },
> +  'features': [ 'unstable' ],
> +  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
> +}
> diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
> index f3771f5045..327bccea4f 100644
> --- a/hw/s390x/cpu-topology.c
> +++ b/hw/s390x/cpu-topology.c
> @@ -24,6 +24,7 @@
>  #include "hw/s390x/s390-virtio-ccw.h"
>  #include "hw/s390x/cpu-topology.h"
>  #include "qapi/qapi-commands-machine-target.h"
> +#include "qapi/qapi-events-machine-target.h"
>  
>  /*
>   * s390_topology is used to keep the topology information.
> @@ -136,6 +137,7 @@ void s390_handle_ptf(S390CPU *cpu, uint8_t r1, uintptr_t ra)
>          } else {
>              s390_topology.polarization = polarization;
>              s390_cpu_topology_set_changed(true);
> +            qapi_event_send_cpu_polarization_change(polarization);
>              setcc(cpu, 0);
>          }
>          break;

Acked-by: Markus Armbruster <armbru@redhat.com>


