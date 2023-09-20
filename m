Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E5B7A7B4D
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:50:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qivj5-00039m-Hb; Wed, 20 Sep 2023 07:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiviX-0002u5-6B
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiviT-0007VF-GD
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695210599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OefO2lBNSiR+eOOIvuSJIu2K4+g0k7MfNKcdw3LHEdw=;
 b=Ey0iA7Ba13d5bc6h4V1i4y+dNHSTARPrQOah1IJVgAUEROcHbTboiUKuYhp3lxug3UwgIg
 xwvinqOJ+m+1Ic6vwtAobRpbg5Ri1ZaKs3Gs3asw0z/a8PPVhVTXBmXGvySpfKOcSHNeq+
 jZmiEqByon9FwOyGDK3jnfZdgINLtJw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-hozuhyclNwWlIWBIuRJarA-1; Wed, 20 Sep 2023 07:49:53 -0400
X-MC-Unique: hozuhyclNwWlIWBIuRJarA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EE65803533;
 Wed, 20 Sep 2023 11:49:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8E65140273D;
 Wed, 20 Sep 2023 11:49:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E261721E6900; Wed, 20 Sep 2023 13:49:51 +0200 (CEST)
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
Subject: Re: [PATCH v23 11/20] qapi/s390x/cpu topology:
 CPU_POLARIZATION_CHANGE qapi event
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
 <20230914120650.1318932-12-nsg@linux.ibm.com>
Date: Wed, 20 Sep 2023 13:49:51 +0200
In-Reply-To: <20230914120650.1318932-12-nsg@linux.ibm.com> (Nina
 Schoetterl-Glausch's message of "Thu, 14 Sep 2023 14:06:41 +0200")
Message-ID: <874jjphxnk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
>  qapi/machine-target.json | 33 +++++++++++++++++++++++++++++++++
>  hw/s390x/cpu-topology.c  |  2 ++
>  2 files changed, 35 insertions(+)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index e47a252bd9..276c3bf9d1 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -412,3 +412,36 @@
>    'features': [ 'unstable' ],
>    'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
>  }
> +
> +##
> +# @CPU_POLARIZATION_CHANGE:
> +#
> +# Emitted when the guest asks to change the polarization.
> +#
> +# @polarization: polarization specified by the guest
> +#
> +# Features:

Blank line, please.

> +# @unstable: This command may still be modified.

Event, not command.  Suggest

   # @unstable: This event is experimental.

> +#
> +# The guest can tell the host (via the PTF instruction) whether the
> +# CPUs should be provisioned using horizontal or vertical polarization.
> +#
> +# On horizontal polarization the host is expected to provision all vCPUs
> +# equally.
> +# On vertical polarization the host can provision each vCPU differently.
> +# The guest will get information on the details of the provisioning
> +# the next time it uses the STSI(15) instruction.

Move this up before @polarization for consistency with other event
documentation.

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

[...]


