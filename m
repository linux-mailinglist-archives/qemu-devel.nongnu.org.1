Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE487C6500
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 08:00:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqojo-0006Z4-Lo; Thu, 12 Oct 2023 02:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqojm-0006Ye-W4
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqojk-0001AS-BZ
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697090394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oRlyC4pJ3lta0uUZRMdxV4f026ikyajbqO6Ibiig3YQ=;
 b=Qq0k/JkrKP8BhpRb1wL2KAWmq4Zu/Y+uRx3S5gxeV02w+ddIA0AQ7y6xkd3x+2EvdCx/sZ
 FEh1s0zFSoz0DE/q2JNg4SyP6rG9hkFeBODJyGwZ3yMBYU63aIxlHl4CVzZEwuLoiaGEDo
 nWIx/5OkLjT3LTliIy6C9DpbM9Bxwcc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-mHnodV7DMWW7PkXqQyp01A-1; Thu, 12 Oct 2023 01:59:50 -0400
X-MC-Unique: mHnodV7DMWW7PkXqQyp01A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACB978022EA;
 Thu, 12 Oct 2023 05:59:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A681440E3;
 Thu, 12 Oct 2023 05:59:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 20CAD21E6904; Thu, 12 Oct 2023 07:59:48 +0200 (CEST)
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
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v24 01/21] qapi: machine.json: change docs regarding
 CpuInstanceProperties
References: <20230926121534.406035-1-nsg@linux.ibm.com>
 <20230926121534.406035-2-nsg@linux.ibm.com>
Date: Thu, 12 Oct 2023 07:59:48 +0200
In-Reply-To: <20230926121534.406035-2-nsg@linux.ibm.com> (Nina
 Schoetterl-Glausch's message of "Tue, 26 Sep 2023 14:15:14 +0200")
Message-ID: <87fs2gnzxn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Clarify roles of different architectures.
> Also change things a bit in anticipation of additional members being
> added.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>
>
> Reference to s390x docs added in patch 14
>
>
>  qapi/machine.json | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a08b6576ca..3c074c9902 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -70,9 +70,9 @@
>  # @qom-path: path to the CPU object in the QOM tree
>  #
>  # @thread-id: ID of the underlying host thread
> -#
> -# @props: properties describing to which node/socket/core/thread
> -#     virtual CPU belongs to, provided if supported by board
> +

Keep the '#', please.

> +# @props: properties of type CpuInstanceProperties associated with a
> +#     virtual CPU, e.g. the socket id
>  #
>  # @target: the QEMU system emulation target, which determines which
>  #     additional fields will be listed (since 3.0)
> @@ -899,6 +899,9 @@
>  # should be passed by management with device_add command when a CPU is
>  # being hotplugged.
>  #
> +# Which members are optional and which mandatory depends on the architecture
> +# and board.

Long line.  Wrap like this:

   # Which members are optional and which mandatory depends on the
   # architecture and board.

Would "depends on the machine type" be more precise?

> +#
>  # @node-id: NUMA node ID the CPU belongs to
>  #
>  # @socket-id: socket number within node/board the CPU belongs to
> @@ -912,15 +915,13 @@
>  #
>  # @thread-id: thread number within core the CPU belongs to
>  #
> -# Note: currently there are 6 properties that could be present but
> -#     management should be prepared to pass through other properties
> -#     with device_add command to allow for future interface extension.
> -#     This also requires the filed names to be kept in sync with the
> -#     properties passed to -device/device_add.
> +# Note: management should be prepared to pass through additional
> +# properties with device_add.

Indent the second line for consistency with other Note: sections:

   # Note: management should be prepared to pass through additional
   #     properties with device_add.

>  #
>  # Since: 2.7
>  ##
>  { 'struct': 'CpuInstanceProperties',
> +  # Keep these in sync with the properties device_add accepts
>    'data': { '*node-id': 'int',
>              '*socket-id': 'int',
>              '*die-id': 'int',


