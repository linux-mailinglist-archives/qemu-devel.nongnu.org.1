Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2E7783A2F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 08:53:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLFq-00059r-RP; Tue, 22 Aug 2023 02:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYLFo-00059g-R9
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYLFm-0006G2-Nf
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692687157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2k/uh5+xwoeOwQb5IgC8XG0uPFEtbKXJYGueazSUtCM=;
 b=QFRGC4M/pnmtelq7p57L5ji9OewQAk1eHFBSXArqxe5u1rdpidamSXWwKRz/bw03zLy03l
 8n+BnkM1zRCSYyRVePTZDDPQ03h7dG6LeSWnmYfvsuNBbzP3zPVS70S/TCl+LOkAUg3+Vf
 MWMBgB9DboapADYfDKmIhB5S/MXVy4o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-yQD1D_vCOR-wUCbrptey2w-1; Tue, 22 Aug 2023 02:52:32 -0400
X-MC-Unique: yQD1D_vCOR-wUCbrptey2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E782101A53C;
 Tue, 22 Aug 2023 06:52:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63C5A40C206F;
 Tue, 22 Aug 2023 06:52:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4787821E690D; Tue, 22 Aug 2023 08:52:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  David Hildenbrand <david@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Cornelia Huck <cohuck@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Marcelo Tosatti <mtosatti@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  qemu-devel@nongnu.org,
 kvm@vger.kernel.org,  Eduardo Habkost <eduardo@habkost.net>,  Laszlo
 Ersek <lersek@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,
 erdemaktas@google.com,  Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 41/58] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-42-xiaoyao.li@intel.com>
Date: Tue, 22 Aug 2023 08:52:30 +0200
In-Reply-To: <20230818095041.1973309-42-xiaoyao.li@intel.com> (Xiaoyao Li's
 message of "Fri, 18 Aug 2023 05:50:24 -0400")
Message-ID: <87wmxn6029.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> For GetQuote, delegate a request to Quote Generation Service.  Add property
> of address of quote generation server and On request, connect to the
> server, read request buffer from shared guest memory, send the request
> buffer to the server and store the response into shared guest memory and
> notify TD guest by interrupt.
>
> "quote-generation-service" is a property to specify Quote Generation
> Service(QGS) in qemu socket address format.  The examples of the supported
> format are "vsock:2:1234", "unix:/run/qgs", "localhost:1234".
>
> command line example:
>   qemu-system-x86_64 \
>     -object 'tdx-guest,id=tdx0,quote-generation-service=localhost:1234' \
>     -machine confidential-guest-support=tdx0
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  qapi/qom.json         |   5 +-
>  target/i386/kvm/tdx.c | 380 ++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.h |   7 +
>  3 files changed, 391 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 87c1d440f331..37139949d761 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -879,13 +879,16 @@
>  #
>  # @mrownerconfig: MROWNERCONFIG SHA384 hex string of 48 * 2 length (default: 0)
>  #
> +# @quote-generation-service: socket address for Quote Generation Service(QGS)
> +#
>  # Since: 8.2
>  ##
>  { 'struct': 'TdxGuestProperties',
>    'data': { '*sept-ve-disable': 'bool',
>              '*mrconfigid': 'str',
>              '*mrowner': 'str',
> -            '*mrownerconfig': 'str' } }
> +            '*mrownerconfig': 'str',
> +            '*quote-generation-service': 'str' } }

Why not type SocketAddress?

>  
>  ##
>  # @ThreadContextProperties:

[...]


