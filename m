Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6E77C6C7E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 13:36:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtyC-0002QB-8L; Thu, 12 Oct 2023 07:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqtyA-0002Q2-QY
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqty6-0007ka-5D
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 07:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697110505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qdn45EuOXkf3tTy39533skEIvLSAbD0jB+oHI0vsqDI=;
 b=cFUwLYPouNZ7LrAorSQnXcyKrIQJLXPCc3l72OUbFvhauLxMvozVMD9Jfm98jMkR1hCNHe
 hYMWjPIe4edNu+jtOKIAkVvWmiNmPYPhi6Vug+qMTXdJXxyNEQUgz2FrZZcOCgW7Ef0dEY
 WQiXFg5LKNjMS+qjL4F0SAHQWq/+6MA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-egQxp2YUMxqXG6U_XqX-FA-1; Thu, 12 Oct 2023 07:35:00 -0400
X-MC-Unique: egQxp2YUMxqXG6U_XqX-FA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEBC68663F0;
 Thu, 12 Oct 2023 11:34:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A58DB25C0;
 Thu, 12 Oct 2023 11:34:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 991A921E6A21; Thu, 12 Oct 2023 13:34:58 +0200 (CEST)
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
Subject: Re: [PATCH v25 09/21] qapi/s390x/cpu topology: set-cpu-topology qmp
 command
References: <20231005160155.1945588-1-nsg@linux.ibm.com>
 <20231005160155.1945588-10-nsg@linux.ibm.com>
Date: Thu, 12 Oct 2023 13:34:58 +0200
In-Reply-To: <20231005160155.1945588-10-nsg@linux.ibm.com> (Nina
 Schoetterl-Glausch's message of "Thu, 5 Oct 2023 18:01:43 +0200")
Message-ID: <87fs2gysyl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
>  qapi/machine-target.json |  42 +++++++++++++
>  hw/s390x/cpu-topology.c  | 132 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 93cbf1c128..3fd8390922 100644
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
> @@ -375,3 +377,43 @@
>    'data': [ 'horizontal', 'vertical' ],
>    'if': 'TARGET_S390X'
>  }
> +
> +##
> +# @set-cpu-topology:
> +#
> +# Modifies the topology by moving the CPU inside the topology

Imperative mood, please: Modify the topology ...

> +# tree or by changing a modifier attribute of a CPU.

Comma after tree.

> +# Absent values will not be modified.
> +#
> +# @core-id: the vCPU ID to be moved
> +#
> +# @socket-id: destination socket to move the vCPU to
> +#
> +# @book-id: destination book to move the vCPU to
> +#
> +# @drawer-id: destination drawer to move the vCPU to
> +#
> +# @entitlement: entitlement to set
> +#
> +# @dedicated: whether the provisioning of real to virtual CPU is dedicated
> +#
> +# Features:
> +#
> +# @unstable: This command may still be modified.

The conventional phrasing is "This command is experimental."

> +#
> +# Returns: Nothing on success, the reason on failure.

Scratch ", the reason on failure".  You get a QMP error reply on
failure.

> +#
> +# Since: 8.2
> +##
> +{ 'command': 'set-cpu-topology',
> +  'data': {
> +      'core-id': 'uint16',
> +      '*socket-id': 'uint16',
> +      '*book-id': 'uint16',
> +      '*drawer-id': 'uint16',
> +      '*entitlement': 'CpuS390Entitlement',
> +      '*dedicated': 'bool'
> +  },
> +  'features': [ 'unstable' ],
> +  'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
> +}

[...]


