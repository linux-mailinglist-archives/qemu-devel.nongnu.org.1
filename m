Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C76EA28666
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Feb 2025 10:21:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfbZv-0002cI-VP; Wed, 05 Feb 2025 04:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfbZq-0002bc-Jn
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:20:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfbZo-0005zM-Ts
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738747207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RDDuMojfzA3TtjMm7/XpBRWReWktry4qKIVeq2mwHM4=;
 b=hyl2bIZ9pgCstsYTmU47qfC7iXeAOjZ/CnEKhjLjmacPfeZv/NdpCx1oWN/veXNF1BoTWh
 hx65VoE+A186SaHMZpSlTFaBAoLDUzyEbwHnBmyTz3L5HRX55w3WK1U+E1PEnHR1fcJiUa
 jYLs+C2S8R5ZBQgGjhCmmjhgnlizYnA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-096-Yk1wOR6Ql3cHg0YnXQ-1; Wed,
 05 Feb 2025 04:20:04 -0500
X-MC-Unique: 096-Yk1wOR6Ql3cHg0YnXQ-1
X-Mimecast-MFC-AGG-ID: 096-Yk1wOR6Ql3cHg0YnXQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6239A1800264; Wed,  5 Feb 2025 09:20:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9384818004A7; Wed,  5 Feb 2025 09:20:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D4EF21E6A28; Wed, 05 Feb 2025 10:19:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Igor
 Mammedov <imammedo@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Eric Blake <eblake@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  Huacai Chen <chenhuacai@kernel.org>,  Rick
 Edgecombe <rick.p.edgecombe@intel.com>,  Francesco Lavra
 <francescolavra.fl@gmail.com>,  qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v7 28/52] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
In-Reply-To: <20250124132048.3229049-29-xiaoyao.li@intel.com> (Xiaoyao Li's
 message of "Fri, 24 Jan 2025 08:20:24 -0500")
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-29-xiaoyao.li@intel.com>
Date: Wed, 05 Feb 2025 10:19:59 +0100
Message-ID: <874j184ukg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
>
> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v6:
> - change error_code of GuestPanicInformationTdx from uint64_t to
>   uint32_t, to only contains the bit 31:0 returned in r12.
>
> Changes in v5:
> - mention additional error information in gpa when it presents;
> - refine the documentation; (Markus)
>
> Changes in v4:
> - refine the documentation; (Markus)
>
> Changes in v3:
> - Add docmentation of new type and struct; (Daniel)
> - refine the error message handling; (Daniel)
> ---
>  qapi/run-state.json   | 31 ++++++++++++++++++--
>  system/runstate.c     | 67 +++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.c | 24 +++++++++++++++-
>  3 files changed, 119 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index ce95cfa46b73..e63611780a2c 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -501,10 +501,12 @@
>  #
>  # @s390: s390 guest panic information type (Since: 2.12)
>  #
> +# @tdx: tdx guest panic information type (Since: 9.0)

Since: 10.0

> +#
>  # Since: 2.9
>  ##
>  { 'enum': 'GuestPanicInformationType',
> -  'data': [ 'hyper-v', 's390' ] }
> +  'data': [ 'hyper-v', 's390', 'tdx' ] }
>  
>  ##
>  # @GuestPanicInformation:
> @@ -519,7 +521,8 @@
>   'base': {'type': 'GuestPanicInformationType'},
>   'discriminator': 'type',
>   'data': {'hyper-v': 'GuestPanicInformationHyperV',
> -          's390': 'GuestPanicInformationS390'}}
> +          's390': 'GuestPanicInformationS390',
> +          'tdx' : 'GuestPanicInformationTdx'}}
>  
>  ##
>  # @GuestPanicInformationHyperV:
> @@ -598,6 +601,30 @@
>            'psw-addr': 'uint64',
>            'reason': 'S390CrashReason'}}
>  
> +##
> +# @GuestPanicInformationTdx:
> +#
> +# TDX Guest panic information specific to TDX, as specified in the
> +# "Guest-Hypervisor Communication Interface (GHCI) Specification",
> +# section TDG.VP.VMCALL<ReportFatalError>.
> +#
> +# @error-code: TD-specific error code
> +#
> +# @message: Human-readable error message provided by the guest. Not
> +#     to be trusted.
> +#
> +# @gpa: guest-physical address of a page that contains more verbose
> +#     error information, as zero-terminated string.  Present when the
> +#     "GPA valid" bit (bit 63) is set in @error-code.
> +#
> +#
> +# Since: 10.0
> +##
> +{'struct': 'GuestPanicInformationTdx',
> + 'data': {'error-code': 'uint32',
> +          'message': 'str',
> +          '*gpa': 'uint64'}}
> +
>  ##
>  # @MEMORY_FAILURE:
>  #

With the since information corrected
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


