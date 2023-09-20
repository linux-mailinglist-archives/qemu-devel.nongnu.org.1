Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A487A7ABD
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:45:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qivdh-0000If-NF; Wed, 20 Sep 2023 07:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qivdS-0000I5-EX
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qivdQ-0006fj-LG
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695210287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jcnUtU2StSDeKjiA5C0Eh+CpVTTz1vjiEByo9/YbnVo=;
 b=YVYUypZp+IPPufyIXYonPROUwt9Ri/DR1ss88L76Ndn2a5980sleglgqJFcLtJ674CTBpM
 meS6GVPCz0ElqnY8OI+p+i+D+zSRR12DpgwJLyZxuG7GLtATDZQXqLSmZOm81CnO6IFUAc
 T8C/Aqbq4FfF38876r2oBRFTSuUfXS0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-GbVdMvUYM9WmkI0_FWUZhw-1; Wed, 20 Sep 2023 07:44:45 -0400
X-MC-Unique: GbVdMvUYM9WmkI0_FWUZhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28956381258C;
 Wed, 20 Sep 2023 11:44:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 603A7C15BB8;
 Wed, 20 Sep 2023 11:44:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 68FEB21E6900; Wed, 20 Sep 2023 13:44:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  Thomas
 Huth <thuth@redhat.com>,  Eric Blake <eblake@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v23 09/20] machine: adding s390 topology to query-cpu-fast
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
 <20230914120650.1318932-10-nsg@linux.ibm.com>
Date: Wed, 20 Sep 2023 13:44:43 +0200
In-Reply-To: <20230914120650.1318932-10-nsg@linux.ibm.com> (Nina
 Schoetterl-Glausch's message of "Thu, 14 Sep 2023 14:06:39 +0200")
Message-ID: <87cyydhxw4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
> S390x provides two more topology attributes, entitlement and dedication.
>
> Let's add these CPU attributes to the QAPI command query-cpu-fast.
>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>  qapi/machine.json  | 9 ++++++++-
>  target/s390x/cpu.c | 9 +++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a63cb951d2..be1d70d8cd 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -56,10 +56,17 @@
>  # Additional information about a virtual S390 CPU
>  #
>  # @cpu-state: the virtual CPU's state
> +# @dedicated: the virtual CPU's dedication (since 8.2)
> +# @entitlement: the virtual CPU's entitlement (since 8.2)

Blank lines between members, please.

>  #
>  # Since: 2.12
>  ##
> -{ 'struct': 'CpuInfoS390', 'data': { 'cpu-state': 'CpuS390State' } }
> +{ 'struct': 'CpuInfoS390',
> +  'data': { 'cpu-state': 'CpuS390State',
> +            '*dedicated': 'bool',
> +            '*entitlement': 'CpuS390Entitlement'
> +  }
> +}
>  
>  ##
>  # @CpuInfoFast:

[...]


