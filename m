Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D79599842A
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Oct 2024 12:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syqjo-00017g-Vu; Thu, 10 Oct 2024 06:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syqjm-00017J-Eo
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:49:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1syqji-0000Rk-Hs
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728557376;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/xoM8qUbw0rN2/fxymj9vxYQw7PqRTlmPrwk2GM4ys=;
 b=c9b78YaD6A7o9YtyGi3GXLn6H3t2trsD/6dNRfLr3PXCC5DI3Q9Uh8ezpSuyME8JwsjbS+
 0iGdVRgP4V/3bXblvhLqu9NL7p7aE0F4xgaa+nNs2LX4mOcigxxskmifPthrWseBn9/3C2
 ShymHcuDdg+/M/+9tZxPMIC0QmNz83M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-54aPbH2QOBqY6rcnlRorLQ-1; Thu,
 10 Oct 2024 06:49:31 -0400
X-MC-Unique: 54aPbH2QOBqY6rcnlRorLQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5223819560AA; Thu, 10 Oct 2024 10:49:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B58FD19560AE; Thu, 10 Oct 2024 10:49:26 +0000 (UTC)
Date: Thu, 10 Oct 2024 11:49:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com,
 peter.maydell@linaro.org, Alejandro Zeise <alejandro.zeise@seagate.com>
Subject: Re: [PATCH v5 05/16] crypto/hash-nettle: Implement new hash API
Message-ID: <ZwexMpP8SidNul6G@redhat.com>
References: <20241008075724.2772149-1-clg@redhat.com>
 <20241008075724.2772149-6-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008075724.2772149-6-clg@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Oct 08, 2024 at 09:57:12AM +0200, Cédric Le Goater wrote:
> From: Alejandro Zeise <alejandro.zeise@seagate.com>
> 
> Implements the new hashing API in the nettle hash driver.
> Supports creating/destroying a context, updating the context
> with input data and obtaining an output hash.
> 
> Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
> [ clg: - Dropped qcrypto_hash_supports() in qcrypto_nettle_hash_new() ]
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  crypto/hash-nettle.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
> index 8b08a9c67531..07e18ce26cba 100644
> --- a/crypto/hash-nettle.c
> +++ b/crypto/hash-nettle.c

> +static
> +int qcrypto_nettle_hash_update(QCryptoHash *hash,
> +                               const struct iovec *iov,
> +                               size_t niov,
> +                               Error **errp)
> +{
> +    union qcrypto_hash_ctx *ctx = hash->opaque;
> +
> +    for (int i = 0; i < niov; i++) {
> +        /*
> +         * Some versions of nettle have functions
> +         * declared with 'int' instead of 'size_t'
> +         * so to be safe avoid writing more than
> +         * UINT_MAX bytes at a time
> +         */

This is copying the pre-existing code, and I've just
realized this is now obsolete. We bumped min nettle
to 3.4 ages ago and >= 3.0 is using size_t, so we can
simplify now.

No need to change this though. I'll do that as a 
distinct patch to make it a visible change.

> +        size_t len = iov[i].iov_len;
> +        uint8_t *base = iov[i].iov_base;
> +        while (len) {
> +            size_t shortlen = MIN(len, UINT_MAX);
> +            qcrypto_hash_alg_map[hash->alg].write(ctx, len, base);
> +            len -= shortlen;
> +            base += len;
> +        }
> +    }
> +
> +    return 0;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


