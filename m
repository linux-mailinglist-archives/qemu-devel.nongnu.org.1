Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC59A3DF7A
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Feb 2025 16:55:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8sz-0000Bj-Pu; Thu, 20 Feb 2025 10:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tl8sx-0000Ar-Hx
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:54:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tl8st-0004m9-E8
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740066881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=svMb0hMjsByEN3jNk32qxtNTGWo84eb8AH74fZ+nvGk=;
 b=bMvWugEh0oQr1Qnd507CUYT6hMQ60Y0ECVrG5JdIcKyynzD2FLJarnRZM9CWIsf6oyU0Z3
 1dZloiu96zkO4yLly7yGZzWRM7Ey3AOnIRJamgeArszwQYlpQPTe0e/P85soXGS2q9niyE
 QbragJ4lhI8mncAWp4Pjnnow8Orwy4I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-B3pw8yMyMauE5q5vR1YHTQ-1; Thu,
 20 Feb 2025 10:54:37 -0500
X-MC-Unique: B3pw8yMyMauE5q5vR1YHTQ-1
X-Mimecast-MFC-AGG-ID: B3pw8yMyMauE5q5vR1YHTQ_1740066876
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E85D19783B6; Thu, 20 Feb 2025 15:54:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 853A219412A3; Thu, 20 Feb 2025 15:54:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9B4A21E6A28; Thu, 20 Feb 2025 16:54:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Ard Biesheuvel
 <ardb@kernel.org>,  Michael Roth <michael.roth@amd.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  graf@amazon.com,  Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [PATCH v4 14/24] hw/uefi: add var-service-json.c + qapi for NV
 vars.
In-Reply-To: <20250219071431.50626-15-kraxel@redhat.com> (Gerd Hoffmann's
 message of "Wed, 19 Feb 2025 08:14:16 +0100")
References: <20250219071431.50626-1-kraxel@redhat.com>
 <20250219071431.50626-15-kraxel@redhat.com>
Date: Thu, 20 Feb 2025 16:54:29 +0100
Message-ID: <87tt8or4qy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Gerd Hoffmann <kraxel@redhat.com> writes:

> Define qapi schema for the uefi variable store state.
>
> Use it and the generated visitor helper functions to store persistent
> (EFI_VARIABLE_NON_VOLATILE) variables in JSON format on disk.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

[...]

> diff --git a/qapi/meson.build b/qapi/meson.build
> index e7bc54e5d047..eadde4db307f 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -65,6 +65,7 @@ if have_system
>      'pci',
>      'rocker',
>      'tpm',
> +    'uefi',
>    ]
>  endif
>  if have_system or have_tools
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b1581988e4eb..2877aff73d0c 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -81,3 +81,4 @@
>  { 'include': 'vfio.json' }
>  { 'include': 'cryptodev.json' }
>  { 'include': 'cxl.json' }
> +{ 'include': 'uefi.json' }
> diff --git a/qapi/uefi.json b/qapi/uefi.json
> new file mode 100644
> index 000000000000..c268ed11b70c
> --- /dev/null
> +++ b/qapi/uefi.json
> @@ -0,0 +1,45 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +#
> +

This ends up in section "CXL devices", which is not what you want.  I
guess you want a suitable heading right here, like

   ##
   # UEFI mumble mumble
   ##

> +##
> +# @UefiVariable:
> +#
> +# UEFI Variable

Overview text is optional.  Is this one worthwhile?

> +#
> +# @guid: variable namespace guid

How is guid usually capitalized in UEFI documentation?  GUID maybe?

> +#
> +# @name: variable name (utf-8)

UTF-8

> +#
> +# @attr: variable attributes

These are encoded as int.  How?

> +#
> +# @data: variable content (base64)

I'm not a native speaker...  for what it's worth, "contents" feels
better to me.

(base64 encoded) and (encoded in base64) are the common phrasings.

> +#
> +# @time: variable modification time (EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS).

Long line, please break it like

   # @time: variable modification time
   #     (EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)

What's the unit and the anchor?  Seconds since the epoch?

What is EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS trying to
tell the reader?

> +#
> +# @digest: variable certificate digest (EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS).

Long line, please break it like

   # @digest: variable certificate digest
   #     (EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)

What kind of digest is this?

> +#
> +# Since: 10.0
> +##
> +{ 'struct' : 'UefiVariable',
> +  'data' : { 'guid'  : 'str',
> +             'name'  : 'str',
> +             'attr'  : 'int',
> +             'data'  : 'str',
> +             '*time' : 'str',
> +             '*digest' : 'str'}}
> +
> +##
> +# @UefiVarStore:
> +#
> +# UEFI Variable Store

Overview is optional.  Is this one worthwhile?

> +#
> +# @version: 2

What about "currently always 2"?

> +#
> +# @variables: list of uefi variables

UEFI

> +#
> +# Since: 10.0
> +##
> +{ 'struct' : 'UefiVarStore',
> +  'data' : { 'version'   : 'int',
> +             'variables' : [ 'UefiVariable' ] }}


