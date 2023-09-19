Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 175FA7A5E81
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:47:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXK8-0006bN-4y; Tue, 19 Sep 2023 05:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiXJG-000695-Ve
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiXJE-000810-FW
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695116778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pdeA7r4X94pTfbDHEA/XGuHKB/dfS6XI9f+ITzNO6KE=;
 b=JNxdREuC1X51fiK7QimZHtXXaZ8WtuzkHt44c0LSuGpo2ifEnVgeSUg9R1i1Hkgn2oZRa6
 hnbZUoA8LQDasPuKxvvmm4sK/hOj7bBRYdhrIysnrEhno0r6E8P+yUAE/cnTuvZ6j8viVF
 038x3DFgnzdINR23sIR+4eEpzkIF+aI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-D9Kqh9f0P7W0AU_qTjjjmg-1; Tue, 19 Sep 2023 05:46:17 -0400
X-MC-Unique: D9Kqh9f0P7W0AU_qTjjjmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7901E3822553;
 Tue, 19 Sep 2023 09:46:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 510AE2156701;
 Tue, 19 Sep 2023 09:46:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E8DB21E6900; Tue, 19 Sep 2023 11:46:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  qemu-devel@nongnu.org,  kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>,  isaku.yamahata@gmail.com,  Sean
 Christopherson <seanjc@google.com>,  Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v2 03/21] HostMem: Add private property and
 associate it with RAM_KVM_GMEM
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-4-xiaoyao.li@intel.com>
Date: Tue, 19 Sep 2023 11:46:15 +0200
In-Reply-To: <20230914035117.3285885-4-xiaoyao.li@intel.com> (Xiaoyao Li's
 message of "Wed, 13 Sep 2023 23:50:59 -0400")
Message-ID: <8734zazeag.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Add a new property "private" to memory backends. When it's set to true,
> it indicates the RAMblock of the backend also requires kvm gmem.

Can you add a brief explanation why you need the property?

> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index fa3e88c8e6ab..d28c5403bc0f 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -605,6 +605,9 @@
>  # @reserve: if true, reserve swap space (or huge pages) if applicable
>  #     (default: true) (since 6.1)
>  #
> +# @private: if true, use KVM gmem private memory (default: false)
> +#     (since 8.2)
> +#
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


