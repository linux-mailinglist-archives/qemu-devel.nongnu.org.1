Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 504FE769F66
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 19:22:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQWbA-0007cJ-0W; Mon, 31 Jul 2023 13:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qQWb2-0007c0-Kb
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 13:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qQWb1-0003Hu-8T
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 13:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690824132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWICzdCPmUTJX/+ZHynxSMjBmCq9ZDxjynL/w9DWhcs=;
 b=QdToZJJfCU8LglqCxXUsSWbpRrSROjAv7ZwQ9F3JwkwaaN4TeZITm+3OpS8lFuYtQ3DLnS
 PAUIecocbhwTDyB1QOPcGyabTMVe5OcSESI9o+LY/iyWE7C4+0BrG1KorRq3E07IUhUxab
 x1EvIEbOnGRTztrTVnuGtLX1Uxnpx/I=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-grBvdCx7P7qw3lCg8_9SnA-1; Mon, 31 Jul 2023 13:22:10 -0400
X-MC-Unique: grBvdCx7P7qw3lCg8_9SnA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 556A61C068C5;
 Mon, 31 Jul 2023 17:22:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DA12492B03;
 Mon, 31 Jul 2023 17:22:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 16D6621E692A; Mon, 31 Jul 2023 19:22:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Sean Christopherson
 <seanjc@google.com>,  David Hildenbrand <david@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Xu <peterx@redhat.com>,  Chao Peng
 <chao.p.peng@linux.intel.com>,  Michael Roth <michael.roth@amd.com>,
 isaku.yamahata@gmail.com,  qemu-devel@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [RFC PATCH 08/19] HostMem: Add private property to indicate to
 use kvm gmem
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-9-xiaoyao.li@intel.com>
Date: Mon, 31 Jul 2023 19:22:05 +0200
In-Reply-To: <20230731162201.271114-9-xiaoyao.li@intel.com> (Xiaoyao Li's
 message of "Mon, 31 Jul 2023 12:21:50 -0400")
Message-ID: <87o7js808y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 7f92ea43e8e1..e0b2044e3d20 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -605,6 +605,9 @@
>  # @reserve: if true, reserve swap space (or huge pages) if applicable
>  #     (default: true) (since 6.1)
>  #
> +# @private: if true, use KVM gmem private memory
> +#           (default: false) (since 8.1)
> +#

Please format like

   # @private: if true, use KVM gmem private memory (default: false)
   #     (since 8.1)

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

>  # @size: size of the memory region in bytes
>  #
>  # @x-use-canonical-path-for-ramblock-id: if true, the canonical path
> @@ -631,6 +634,7 @@
>              '*prealloc-context': 'str',
>              '*share': 'bool',
>              '*reserve': 'bool',
> +            '*private': 'bool',
>              'size': 'size',
>              '*x-use-canonical-path-for-ramblock-id': 'bool' } }


