Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2E982B0B4
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:36:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNw9c-0006K8-CY; Thu, 11 Jan 2024 09:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNw9V-0006Ha-0P
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:35:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNw9R-0007pm-E5
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704983718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Js2dBMaEYhRIMzqUdIm+LYrSS2gZP5wjTtFQEOAJa5U=;
 b=ELOelr3wM/8n9lP39UznbcPF3AXpoiaEtuIAwonNSc8lxdo9TeWOgk21UpUpqcStZXJXik
 dQCar8Jzl4bXYBD3e9jAkIpMy6MZgFYE9dA3lCT8gWZ0dLcAxghnszd2OORRCgmXuyc/Vh
 I6hEpXGYGt4yCjApFsLYPAT+DzPl0Ns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-JhdSBrtBM3qomkE3sB7yVA-1; Thu, 11 Jan 2024 09:35:12 -0500
X-MC-Unique: JhdSBrtBM3qomkE3sB7yVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0160084AE42;
 Thu, 11 Jan 2024 14:35:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D56B840C6EB9;
 Thu, 11 Jan 2024 14:35:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1E4821E6691; Thu, 11 Jan 2024 15:35:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Kevin Wolf <kwolf@redhat.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RESEND v3 01/10] crypto: Introduce option and structure
 for detached LUKS header
In-Reply-To: <a34c12048198cea06d5d1a69a3fa8b76ab13cbba.1703482349.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Mon, 25 Dec 2023 13:45:03 +0800")
References: <cover.1703482349.git.yong.huang@smartx.com>
 <a34c12048198cea06d5d1a69a3fa8b76ab13cbba.1703482349.git.yong.huang@smartx.com>
Date: Thu, 11 Jan 2024 15:35:10 +0100
Message-ID: <87h6jkuee9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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

Hyman Huang <yong.huang@smartx.com> writes:

> Add the "header" option for the LUKS format. This field would be
> used to identify the blockdev's position where a detachable LUKS
> header is stored.
>
> In addition, introduce header field in struct BlockCrypto
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Message-Id: <5b99f60c7317092a563d7ca3fb4b414197015eb2.1701879996.git.yong=
.huang@smartx.com>
> ---
>  block/crypto.c       | 1 +
>  qapi/block-core.json | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/block/crypto.c b/block/crypto.c
> index 921933a5e5..f82b13d32b 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -39,6 +39,7 @@ typedef struct BlockCrypto BlockCrypto;
>  struct BlockCrypto {
>      QCryptoBlock *block;
>      bool updating_keys;
> +    BdrvChild *header;  /* Reference to the detached LUKS header */
>  };
>=20=20
>=20=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ca390c5700..10be08d08f 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3352,11 +3352,15 @@
>  #     decryption key (since 2.6). Mandatory except when doing a
>  #     metadata-only probe of the image.
>  #
> +# @header: optional reference to the location of a blockdev
> +#     storing a detached LUKS header. (since 9.0)

This will come out like

    "header": "BlockdevRef" (optional)
       optional reference to the location of a blockdev storing a detached
       LUKS header. (since 9.0)

in the manual.  Scratch "optional".

Moreover, a BlockdevRef is a "Reference to a block device" (quote from
its doc comment), not a "reference to the location of a blockdev".
Better simplify to something like "block device holding a detached LUKS
header".

But that's just phrasing.  The contents could perhaps use improvement,
too.  Let's start with this question: what's a detachable LUKS header,
and why would anybody want to use it?

> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsLUKS',
>    'base': 'BlockdevOptionsGenericFormat',
> -  'data': { '*key-secret': 'str' } }
> +  'data': { '*key-secret': 'str',
> +            '*header': 'BlockdevRef'} }
>=20=20
>  ##
>  # @BlockdevOptionsGenericCOWFormat:


