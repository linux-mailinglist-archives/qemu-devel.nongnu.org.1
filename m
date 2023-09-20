Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 683597A7A84
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:37:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qivVK-0004qD-BX; Wed, 20 Sep 2023 07:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qivVI-0004oI-Fw
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qivVG-0005Q5-JX
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695209778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6EsSzrDPk53ytsTnkxYCxovB+eIyjeHtwjbCdK7OIUw=;
 b=JcoOPu+6yADOHV7LSqXnQuqYo+XjU71VQCKt0QCrl5Bmj2kAj9tZAjka3EECOgfA5AYNw3
 chkRz7H7vZ4Oktk0SN/BfhgXBh53JyhgvP4vWubHzBO2BE5xnTxQ5aMKpsqVO8ryTk9eEU
 h458ongPRAUqAeA7FViYGZgbw4Oi5YU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-TY0JEK0VNaCgsM2B_I_xBA-1; Wed, 20 Sep 2023 07:36:15 -0400
X-MC-Unique: TY0JEK0VNaCgsM2B_I_xBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DC912999B26;
 Wed, 20 Sep 2023 11:36:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ECF214171CA;
 Wed, 20 Sep 2023 11:36:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7123421E6900; Wed, 20 Sep 2023 13:36:13 +0200 (CEST)
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
Subject: Re: [PATCH v23 08/20] qapi/s390x/cpu topology: set-cpu-topology qmp
 command
References: <20230914120650.1318932-1-nsg@linux.ibm.com>
 <20230914120650.1318932-9-nsg@linux.ibm.com>
Date: Wed, 20 Sep 2023 13:36:13 +0200
In-Reply-To: <20230914120650.1318932-9-nsg@linux.ibm.com> (Nina
 Schoetterl-Glausch's message of "Thu, 14 Sep 2023 14:06:38 +0200")
Message-ID: <87y1h1hyaa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Nina Schoetterl-Glausch <nsg@linux.ibm.com> writes:

> From: Pierre Morel <pmorel@linux.ibm.com>
>
> The modification of the CPU attributes are done through a monitor
> command.
>
> It allows to move the core inside the topology tree to optimize
> the cache usage in the case the host's hypervisor previously
> moved the CPU.
>
> The same command allows to modify the CPU attributes modifiers
> like polarization entitlement and the dedicated attribute to notify
> the guest if the host admin modified scheduling or dedication of a vCPU.
>
> With this knowledge the guest has the possibility to optimize the
> usage of the vCPUs.
>
> The command has a feature unstable for the moment.
>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>  qapi/machine-target.json |  37 +++++++++++
>  hw/s390x/cpu-topology.c  | 132 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 169 insertions(+)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 0d45a590ce..e47a252bd9 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -4,6 +4,8 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or later.
>  # See the COPYING file in the top-level directory.
>  
> +{ 'include': 'machine-common.json' }
> +
>  ##
>  # @CpuModelInfo:
>  #
> @@ -375,3 +377,38 @@
>    'data': [ 'horizontal', 'vertical' ],
>      'if': 'TARGET_S390X'
>  }
> +
> +##
> +# @set-cpu-topology:

Move the overview here from [*] below.

> +#
> +# @core-id: the vCPU ID to be moved
> +# @socket-id: optional destination socket where to move the vCPU
> +# @book-id: optional destination book where to move the vCPU
> +# @drawer-id: optional destination drawer where to move the vCPU
> +# @entitlement: optional entitlement
> +# @dedicated: optional, if the vCPU is dedicated to a real CPU

Separate the members with blank lines, please.

The doc generator adds optional automatically, so this will come out
like

    "socket-id": "int" (optional)
       optional destination socket where to move the vCPU

    "book-id": "int" (optional)
       optional destination book where to move the vCPU

    "drawer-id": "int" (optional)
       optional destination drawer where to move the vCPU

    "entitlement": "CpuS390Entitlement" (optional)
       optional entitlement

    "dedicated": "boolean" (optional)
       optional, if the vCPU is dedicated to a real CPU

Drop the optional from the text.

Suggest

   # @dedicated: whether the vCPU is dedicated to a real CPU

(whatever that may mean; I'm an S390 noob)

> +#
> +# Features:

Another blank line, please.

> +# @unstable: This command may still be modified.
> +#

[*] The overview:

> +# Modifies the topology by moving the CPU inside the topology
> +# tree or by changing a modifier attribute of a CPU.
> +# Default value for optional parameter is the current value
> +# used by the CPU.

So, anything absent will not be changed.  Maybe that's a clearer way to
put it.  What do you think?

> +#
> +# Returns: Nothing on success, the reason on failure.
> +#
> +# Since: 8.2
> +##
> +{ 'command': 'set-cpu-topology',
> +  'data': {
> +      'core-id': 'uint16',
> +      '*socket-id': 'uint16',
> +      '*book-id': 'uint16',
> +      '*drawer-id': 'uint16',

CpuInstanceProperties uses 'int' for these.  Any particular reason for
the difference?

> +      '*entitlement': 'CpuS390Entitlement',
> +      '*dedicated': 'bool'
> +  },
> +  'features': [ 'unstable' ],
> +  'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
> +}

[...]


