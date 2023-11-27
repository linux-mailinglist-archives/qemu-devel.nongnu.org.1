Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6B7FA5C9
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 17:11:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7eCh-0007Bg-BT; Mon, 27 Nov 2023 11:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r7eCd-0007BS-7R
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 11:11:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r7eCZ-0002Yr-JG
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 11:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701101468;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jJi1pXCz2FTajYxahtgyuVng9v+pFevLOt3ydLdO0fo=;
 b=KzGDV1Fwb0bA2+tFb49HqukWVJfzxpug/3o008kotHE/sjbQCDkcf5NRBIE9gP+ESWbZ9F
 zOgGEP8FgFPYFhRj+wbwYDj/AIvZWg8tQF7zb9VTk3tP8Czo/bckZ7qg11RTvUdUnHcE/O
 gb2n+XQ04AR4zY9y4iBv/GqsQ0N76Og=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-3zlCwMRwMtiEQmAJORMD_A-1; Mon,
 27 Nov 2023 11:11:05 -0500
X-MC-Unique: 3zlCwMRwMtiEQmAJORMD_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4E99381AE4D;
 Mon, 27 Nov 2023 16:11:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE8D240C6EBB;
 Mon, 27 Nov 2023 16:11:04 +0000 (UTC)
Date: Mon, 27 Nov 2023 16:11:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] crypto: Introduce SM4 symmetric cipher algorithm
Message-ID: <ZWS_lTYeKTLNfDrn@redhat.com>
References: <386ee33ff8f1dc4e8416b037e548ae36c983d054.1701100272.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <386ee33ff8f1dc4e8416b037e548ae36c983d054.1701100272.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Nov 27, 2023 at 11:55:34PM +0800, Hyman Huang wrote:
> Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
> 
> SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> Organization of State Commercial Administration of China (OSCCA)
> as an authorized cryptographic algorithms for the use within China.

Just out of interest, what part of QEMU are you needing to use
SM4 with ? Is it for a LUKS block driver cipher ?

> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  crypto/block-luks.c             |  7 ++++++
>  crypto/cipher-gcrypt.c.inc      |  4 ++++

Looking at the gcrypt code, SM4 is only supported in >= 1.9.0 

QEMU min version is 1.8.0, so you'll need to modify meson.build
to check whether SM4 is supported and put conditionals in this
file

>  crypto/cipher-nettle.c.inc      | 42 +++++++++++++++++++++++++++++++++

Looking at the nettle code, SM4 is only supported in unreleased
versions thus far.

So again will need a meson.build check and conditionals.

>  crypto/cipher.c                 |  2 ++
>  qapi/crypto.json                |  5 +++-
>  tests/unit/test-crypto-cipher.c | 11 +++++++++
>  6 files changed, 70 insertions(+), 1 deletion(-)


> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index fd3d46ebd1..95fa10bb6d 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -94,6 +94,8 @@
>  #
>  # @twofish-256: Twofish with 256 bit / 32 byte keys
>  #
> +# @sm4: SM4 with 128 bit / 16 byte keys (since 8.2)

We're in feature freeze for 8.2, so mark this 9.0 as that'll be the
next available release this could be merged for.

> +#
>  # Since: 2.6
>  ##
>  { 'enum': 'QCryptoCipherAlgorithm',
> @@ -102,7 +104,8 @@
>             'des', '3des',
>             'cast5-128',
>             'serpent-128', 'serpent-192', 'serpent-256',
> -           'twofish-128', 'twofish-192', 'twofish-256']}
> +           'twofish-128', 'twofish-192', 'twofish-256',
> +           'sm4']}
>  
>  ##
>  # @QCryptoCipherMode:
> diff --git a/tests/unit/test-crypto-cipher.c b/tests/unit/test-crypto-cipher.c
> index d9d9d078ff..80a4984e43 100644
> --- a/tests/unit/test-crypto-cipher.c
> +++ b/tests/unit/test-crypto-cipher.c
> @@ -382,6 +382,17 @@ static QCryptoCipherTestData test_data[] = {
>          .plaintext = "90afe91bb288544f2c32dc239b2635e6",
>          .ciphertext = "6cb4561c40bf0a9705931cb6d408e7fa",
>      },
> +    {
> +        /* SM4, GB/T 32907-2016, Appendix A.1 */
> +        .path = "/crypto/cipher/sm4",
> +        .alg = QCRYPTO_CIPHER_ALG_SM4,
> +        .mode = QCRYPTO_CIPHER_MODE_ECB,
> +        .key = "0123456789abcdeffedcba9876543210",
> +        .plaintext  =
> +            "0123456789abcdeffedcba9876543210",
> +        .ciphertext =
> +            "681edf34d206965e86b3e94f536e4246",
> +    },
>      {
>          /* #1 32 byte key, 32 byte PTX */
>          .path = "/crypto/cipher/aes-xts-128-1",
> -- 
> 2.39.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


