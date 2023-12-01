Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8158800944
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 12:02:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r91Hy-0004tA-QR; Fri, 01 Dec 2023 06:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r91Hq-0004sZ-1k
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 06:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r91Hn-0008GU-T8
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 06:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701428538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hFdOs1CKBCcZmt4jrpvGA5vZPLyGHB7koIvV+uXcRd0=;
 b=im8soXr8jp1hiUlJR1fh1ouSFjCGWrFXlx8RmWt905ejdIN0T3gCMvsa3+UjU4p6IEZD8g
 z12NvRbHBN7p3ubJzDsUo+QulCwpu/kQ4H7tYYkXH3yHVM3UfHieKUW2QZF2nYDeTXTclM
 g0lJsWuf9UsJdTxhpVdoes22HutZtEU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-148F8G_nNdK9zbjoFmhQbw-1; Fri,
 01 Dec 2023 06:02:12 -0500
X-MC-Unique: 148F8G_nNdK9zbjoFmhQbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D235629ABA28;
 Fri,  1 Dec 2023 11:02:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE7661C060AE;
 Fri,  1 Dec 2023 11:02:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 84B7E21E6A1F; Fri,  1 Dec 2023 12:02:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  qemu-devel@nongnu.org,  kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>,  Sean Christopherson
 <seanjc@google.com>,  Claudio Fontana <cfontana@suse.de>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,  Chenyi
 Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v3 52/70] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-53-xiaoyao.li@intel.com>
Date: Fri, 01 Dec 2023 12:02:10 +0100
In-Reply-To: <20231115071519.2864957-53-xiaoyao.li@intel.com> (Xiaoyao Li's
 message of "Wed, 15 Nov 2023 02:15:01 -0500")
Message-ID: <87jzpyw5hp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> For GetQuote, delegate a request to Quote Generation Service.
> Add property "quote-generation-socket" to tdx-guest, whihc is a property
> of type SocketAddress to specify Quote Generation Service(QGS).
>
> On request, connect to the QGS, read request buffer from shared guest
> memory, send the request buffer to the server and store the response
> into shared guest memory and notify TD guest by interrupt.
>
> command line example:
>   qemu-system-x86_64 \
>     -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-socket":{"type": "vsock", "cid":"2","port":"1234"}}' \
>     -machine confidential-guest-support=tdx0
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Codeveloped-by: Chenyi Qiang <chenyi.qiang@intel.com>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v3:
> - rename property "quote-generation-service" to "quote-generation-socket";
> - change the type of "quote-generation-socket" from str to
>   SocketAddress;
> - squash next patch into this one;
> ---
>  qapi/qom.json         |   5 +-
>  target/i386/kvm/tdx.c | 430 ++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.h |   6 +
>  3 files changed, 440 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index fd99aa1ff8cc..cf36a1832ddd 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -894,13 +894,16 @@
>  #
>  # @mrownerconfig: base64 MROWNERCONFIG SHA384 digest
>  #
> +# @quote-generation-socket: socket address for Quote Generation Service(QGS)
> +#

Long line.  Better:

   # @quote-generation-socket: socket address for Quote Generation
   #     Service(QGS)

>  # Since: 8.2
>  ##
>  { 'struct': 'TdxGuestProperties',
>    'data': { '*sept-ve-disable': 'bool',
>              '*mrconfigid': 'str',
>              '*mrowner': 'str',
> -            '*mrownerconfig': 'str' } }
> +            '*mrownerconfig': 'str',
> +            '*quote-generation-socket': 'SocketAddress' } }
>  
>  ##
>  # @ThreadContextProperties:


