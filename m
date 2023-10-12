Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B52287C6C92
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 13:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqu4R-0006tj-Cz; Thu, 12 Oct 2023 07:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqu4O-0006ta-V9
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqu4N-0000cF-Ft
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697110894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jESRy1M0i2FzsNYrNAeZGIdtEHvvflh2/WIQVZt1lcE=;
 b=Rxrq1EhmA92TPKv6GMXov0gdl4m+CVCX8ZgVBLWoe41G7D09NyE30fKmTdhpQeVT2VNxLU
 IdIaNjqUGUPodUNCVgsZWR2xyduuqrueJPaGyOkt6kkWHO5FqFWHs2j0JOl/kKZ6b+BTfH
 IADu4+lrn7gU5np+9Kki/C0WdXOzp2Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-iG7JMOqkOn-GX8jAbZzwmA-1; Thu, 12 Oct 2023 07:41:26 -0400
X-MC-Unique: iG7JMOqkOn-GX8jAbZzwmA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86222185A79B;
 Thu, 12 Oct 2023 11:41:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 615D520296DB;
 Thu, 12 Oct 2023 11:41:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6402621E6A1F; Thu, 12 Oct 2023 13:41:24 +0200 (CEST)
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
Subject: Re: [PATCH v25 13/21] qapi/s390x/cpu topology: add
 query-s390x-cpu-polarization command
References: <20231005160155.1945588-1-nsg@linux.ibm.com>
 <20231005160155.1945588-14-nsg@linux.ibm.com>
Date: Thu, 12 Oct 2023 13:41:24 +0200
In-Reply-To: <20231005160155.1945588-14-nsg@linux.ibm.com> (Nina
 Schoetterl-Glausch's message of "Thu, 5 Oct 2023 18:01:47 +0200")
Message-ID: <87y1g8xe3f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Nina Schoetterl-Glausch <nsg@linux.ibm.com> writes:

> From: Pierre Morel <pmorel@linux.ibm.com>
>
> The query-s390x-cpu-polarization qmp command returns the current
> CPU polarization of the machine.
>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>  qapi/machine-target.json | 30 ++++++++++++++++++++++++++++++
>  hw/s390x/cpu-topology.c  |  8 ++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 02f1de5d02..10289835fb 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -451,3 +451,33 @@
>    'features': [ 'unstable' ],
>    'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
>  }
> +
> +##
> +# @CpuPolarizationInfo:
> +#
> +# The result of a CPU polarization query.
> +#
> +# @polarization: the CPU polarization
> +#
> +# Since: 8.2
> +##
> +{ 'struct': 'CpuPolarizationInfo',
> +  'data': { 'polarization': 'CpuS390Polarization' },
> +  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
> +}
> +
> +##
> +# @query-s390x-cpu-polarization:
> +#
> +# Features:
> +#
> +# @unstable: This command is experimental.
> +#
> +# Returns: the machine's CPU polarization
> +#
> +# Since: 8.2
> +##
> +{ 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
> +  'features': [ 'unstable' ],
> +  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
> +}
> diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
> index 327bccea4f..f16bdf65fa 100644
> --- a/hw/s390x/cpu-topology.c
> +++ b/hw/s390x/cpu-topology.c
> @@ -459,3 +459,11 @@ void qmp_set_cpu_topology(uint16_t core,
>                           has_drawer, drawer, has_entitlement, entitlement,
>                           has_dedicated, dedicated, errp);
>  }
> +
> +CpuPolarizationInfo *qmp_query_s390x_cpu_polarization(Error **errp)
> +{
> +    CpuPolarizationInfo *info = g_new0(CpuPolarizationInfo, 1);
> +
> +    info->polarization = s390_topology.polarization;
> +    return info;
> +}

Acked-by: Markus Armbruster <armbru@redhat.com>


