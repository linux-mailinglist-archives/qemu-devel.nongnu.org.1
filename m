Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C3F7CBFB8
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 11:42:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsgZY-0003nW-6m; Tue, 17 Oct 2023 05:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qsgZV-0003n6-4w
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 05:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qsgZT-00035I-Fg
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 05:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697535662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u85gew9SAzh1jS4Q95uFepU/sGixncvfZTX4qsl4/aA=;
 b=AydlUTLSkfs77wLMjv2225gmGDmDBHKPv1kjew5VtCWfjmPDIOLx6wlhX8vSUkmVQcm8s4
 hlmg5P3sGbG5wOjalmLgQy0QJBr8xHupx037G7TX/wzbRxW0xiwfZ1ACk8L7J1mqNwOnMm
 g0KTPjTxEu4np9VWqE9xHKNf3B0dsvg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-M-1F3bDLNZWupF7sicPU_Q-1; Tue, 17 Oct 2023 05:40:54 -0400
X-MC-Unique: M-1F3bDLNZWupF7sicPU_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA9F71C0BB57;
 Tue, 17 Oct 2023 09:40:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2688040C6CA0;
 Tue, 17 Oct 2023 09:40:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1973D21E6A1F; Tue, 17 Oct 2023 11:40:52 +0200 (CEST)
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
 <bleal@redhat.com>
Subject: Re: [PATCH v26 01/21] qapi: machine.json: change docs regarding CPU
 topology
References: <20231016183925.2384704-1-nsg@linux.ibm.com>
 <20231016183925.2384704-2-nsg@linux.ibm.com>
Date: Tue, 17 Oct 2023 11:40:52 +0200
In-Reply-To: <20231016183925.2384704-2-nsg@linux.ibm.com> (Nina
 Schoetterl-Glausch's message of "Mon, 16 Oct 2023 20:39:05 +0200")
Message-ID: <878r81bn8b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

> Clarify roles of different architectures.
> Also change things a bit in anticipation of additional members being
> added.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>  qapi/machine.json | 58 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 20 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a08b6576ca..058e884fd2 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -71,8 +71,8 @@
>  #
>  # @thread-id: ID of the underlying host thread
>  #
> -# @props: properties describing to which node/socket/core/thread
> -#     virtual CPU belongs to, provided if supported by board
> +# @props: properties of type CpuInstanceProperties associated with a
> +#     virtual CPU, e.g. the socket id

This comes out like

    "props": "CpuInstanceProperties" (optional)
       properties of type CpuInstanceProperties associated with a virtual
       CPU, e.g. the socket id

in generated documentation.

Scratch "of type CpuInstanceProperties, please.

>  #
>  # @target: the QEMU system emulation target, which determines which
>  #     additional fields will be listed (since 3.0)
> @@ -899,28 +899,34 @@
>  # should be passed by management with device_add command when a CPU is
>  # being hotplugged.
>  #
> +# Which members are optional and which mandatory depends on the
> +# architecture and board.
> +#
> +# The ids other than the node-id specify the position of the CPU
> +# within the CPU topology as defined by @SMPConfiguration.

Actually by machine property "smp", which is of type SMPConfiguration.
Not obvious for the reader.  Suggest "as defined by machine property
"smp".

> +#
>  # @node-id: NUMA node ID the CPU belongs to
>  #
> -# @socket-id: socket number within node/board the CPU belongs to
> +# @socket-id: socket number within CPU topology the CPU belongs to
>  #
> -# @die-id: die number within socket the CPU belongs to (since 4.1)
> +# @die-id: die number within the parent container the CPU belongs to
> +#    (since 4.1)
>  #
> -# @cluster-id: cluster number within die the CPU belongs to (since
> -#     7.1)
> +# @cluster-id: cluster number within the parent container the CPU
> +#     belongs to (since 7.1)
>  #
> -# @core-id: core number within cluster the CPU belongs to
> +# @core-id: core number within the parent container the CPU
> +#     belongs to
>  #
> -# @thread-id: thread number within core the CPU belongs to
> +# @thread-id: thread number within the core the CPU  belongs to
>  #
> -# Note: currently there are 6 properties that could be present but
> -#     management should be prepared to pass through other properties
> -#     with device_add command to allow for future interface extension.
> -#     This also requires the filed names to be kept in sync with the
> -#     properties passed to -device/device_add.
> +# Note: management should be prepared to pass through additional
> +#     properties with device_add.
>  #
>  # Since: 2.7
>  ##
>  { 'struct': 'CpuInstanceProperties',
> +  # Keep these in sync with the properties device_add accepts
>    'data': { '*node-id': 'int',
>              '*socket-id': 'int',
>              '*die-id': 'int',
> @@ -1478,21 +1484,33 @@
>  # Schema for CPU topology configuration.  A missing value lets QEMU
>  # figure out a suitable value based on the ones that are provided.
>  #
> +# The members other than @cpus and @maxcpus define topology
> +# containers.

"define a topology of containers"?

"define a hierarchy of containers"?


> +#
> +# The ordering from highest/coarsest to lowest/finest is:
> +# @sockets, @dies, @clusters, @cores, @threads.
> +#
> +# Different architectures support different subsets of topology
> +# containers.
> +#
> +# For examples, s390x does not have clusters and dies, the socket

"For example,"

", and the socket is"

> +# is the parent container of cores.
> +#
>  # @cpus: number of virtual CPUs in the virtual machine
>  #
> +# @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
> +#     machine
> +#
>  # @sockets: number of sockets in the CPU topology
>  #
> -# @dies: number of dies per socket in the CPU topology
> +# @dies: number of dies per parent container
>  #
> -# @clusters: number of clusters per die in the CPU topology (since
> +# @clusters: number of clusters per parent container (since
>  #     7.0)

This now fits in the previous line:

   # @clusters: number of clusters per parent container (since 7.0)

>  #
> -# @cores: number of cores per cluster in the CPU topology
> +# @cores: number of cores per parent container
>  #
> -# @threads: number of threads per core in the CPU topology
> -#
> -# @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
> -#     machine
> +# @threads: number of threads per core

Much clearer than before.

>  #
>  # Since: 6.1
>  ##

Address my nitpicks one way or the other, and you may add
Acked-by: Markus Armbruster <armbru@redhat.com>


