Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A17956811
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Aug 2024 12:17:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfzRT-0003Zv-TQ; Mon, 19 Aug 2024 06:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sfzRB-0003Yf-9r
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 06:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sfzR9-0003ih-Cb
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 06:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724062586;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NrYdhJuPyThQJoGe+0Qtqk0vIBk10a1YH9q49E/rcNw=;
 b=SZoYhSJ+84T38ozQen+kehVRtx2035Xx27TYBELmSyFmyicVIl4hn/wRvHo0n0wUS51OVK
 h2+N75EETnB7AdgDEjEwDXGG+H3uzz9Ken9BgZf/24ogwPU3KQC4yyLXKuKgRe2/1cj1or
 NDp9B86CWxIY+6K2swVnTJ5c4FUzsKQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-hIlVr05uM72uOk_OLdHRgA-1; Mon,
 19 Aug 2024 06:16:22 -0400
X-MC-Unique: hIlVr05uM72uOk_OLdHRgA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 800CC1955F28; Mon, 19 Aug 2024 10:16:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 963F319560A3; Mon, 19 Aug 2024 10:16:15 +0000 (UTC)
Date: Mon, 19 Aug 2024 11:16:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v4 5/6] crypto: Support SHA384 hash when using glib
Message-ID: <ZsMbbAnSIHC8IYHi@redhat.com>
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
 <20240818114257.21456-6-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240818114257.21456-6-dorjoychy111@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sun, Aug 18, 2024 at 05:42:56PM +0600, Dorjoy Chowdhury wrote:
> QEMU requires minimum glib version 2.66.0 as per the root meson.build
> file and per glib documentation[1] G_CHECKSUM_SHA384 is available since
> 2.51.
> 
> [1] https://docs.gtk.org/glib/enum.ChecksumType.html
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>  crypto/hash-glib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
> index 82de9db705..18e64faa9c 100644
> --- a/crypto/hash-glib.c
> +++ b/crypto/hash-glib.c
> @@ -29,7 +29,7 @@ static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALG__MAX] = {
>      [QCRYPTO_HASH_ALG_SHA1] = G_CHECKSUM_SHA1,
>      [QCRYPTO_HASH_ALG_SHA224] = -1,
>      [QCRYPTO_HASH_ALG_SHA256] = G_CHECKSUM_SHA256,
> -    [QCRYPTO_HASH_ALG_SHA384] = -1,
> +    [QCRYPTO_HASH_ALG_SHA384] = G_CHECKSUM_SHA384,
>      [QCRYPTO_HASH_ALG_SHA512] = G_CHECKSUM_SHA512,
>      [QCRYPTO_HASH_ALG_RIPEMD160] = -1,
>  };

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


