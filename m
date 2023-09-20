Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AEC7A7A33
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:14:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiv9k-0002ND-Go; Wed, 20 Sep 2023 07:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiv9i-0002Me-JD
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiv9h-0000L5-1w
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695208444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PjXTVd2gweyxIBBjMbR2tiIsEWwqBptWeHN4vbVkEKo=;
 b=SFdi1scUJLVAza3JurvTacRGk4EOpYFRiuRL2iVaLaPvHT6xjPiym7LNEhvj7Z6kSuST6v
 Cqcgn62k5o03oYOoMTgmYaVCfIX08hL7YSvIIgIkBspct8hQLH6mUZZWIUas6sgs/WxpcF
 o/rr7U6Fggiwe7D2S2kxw9t3dKy8VeQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-G7uwX8uhNC2e4JYK0dnPsA-1; Wed, 20 Sep 2023 07:13:57 -0400
X-MC-Unique: G7uwX8uhNC2e4JYK0dnPsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EA5E1C09A47;
 Wed, 20 Sep 2023 11:13:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC615140E950;
 Wed, 20 Sep 2023 11:13:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D3F3F21E6900; Wed, 20 Sep 2023 13:13:55 +0200 (CEST)
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
Subject: Re: [PATCH v23 03/20] target/s390x/cpu topology: handle STSI(15)
 and build the SYSIB
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
 <20230914120650.1318932-4-nsg@linux.ibm.com>
Date: Wed, 20 Sep 2023 13:13:55 +0200
In-Reply-To: <20230914120650.1318932-4-nsg@linux.ibm.com> (Nina
 Schoetterl-Glausch's message of "Thu, 14 Sep 2023 14:06:33 +0200")
Message-ID: <87cyydjdvw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Nina Schoetterl-Glausch <nsg@linux.ibm.com> writes:

> From: Pierre Morel <pmorel@linux.ibm.com>
>
> On interception of STSI(15.1.x) the System Information Block
> (SYSIB) is built from the list of pre-ordered topology entries.
>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>  MAINTAINERS                      |   1 +
>  qapi/machine-target.json         |  14 ++
>  include/hw/s390x/cpu-topology.h  |  23 +++
>  include/hw/s390x/sclp.h          |   1 +
>  target/s390x/cpu.h               |  75 +++++++
>  hw/s390x/cpu-topology.c          |   2 +
>  target/s390x/kvm/kvm.c           |   5 +-
>  target/s390x/kvm/stsi-topology.c | 338 +++++++++++++++++++++++++++++++
>  target/s390x/kvm/meson.build     |   3 +-
>  9 files changed, 460 insertions(+), 2 deletions(-)
>  create mode 100644 target/s390x/kvm/stsi-topology.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9c6599a55b..17b92fe3ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1702,6 +1702,7 @@ M: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>  S: Supported
>  F: include/hw/s390x/cpu-topology.h
>  F: hw/s390x/cpu-topology.c
> +F: target/s390x/kvm/stsi-topology.c
>  
>  X86 Machines
>  ------------
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index f0a6b72414..0d45a590ce 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -361,3 +361,17 @@
>                     'TARGET_MIPS',
>                     'TARGET_LOONGARCH64',
>                     'TARGET_RISCV' ] } }
> +
> +##
> +# @CpuS390Polarization:
> +#
> +# An enumeration of cpu polarization that can be assumed by a virtual
> +# S390 CPU

CPU polarization

Would someone reasonably familiar with S390 understand this?  Because
I'm not and I don't; I wonder what "a virtual CPU assuming a
polarization" means.

> +#
> +# Since: 8.2
> +##
> +{ 'enum': 'CpuS390Polarization',
> +  'prefix': 'S390_CPU_POLARIZATION',
> +  'data': [ 'horizontal', 'vertical' ],
> +    'if': 'TARGET_S390X'

Indentation is off.

> +}


