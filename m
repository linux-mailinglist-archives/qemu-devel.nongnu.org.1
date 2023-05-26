Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F307124D7
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 12:37:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Up8-0000sH-PC; Fri, 26 May 2023 06:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2Up3-0000ri-9T
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2Uoo-0008AM-GN
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685097429;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybziAUuXd4rs2HF9ALTbq9GtRNRO33R2vNw/2q48sug=;
 b=gdZXpt4hndTj96opOP2xgLikrTUAJJwoSBg6VFgnII5TMVhyNmds785BNCN9DON9jxv4cW
 ADHUitd+CjDruqMR2FZvy7AxDxIpKuEmFD2OmVggyzIjO0EztND5I2cHXWCwW9DVpvY5wv
 45At+wFCyEEAajN1jnGfrLNoblrVa/k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-pSHIIYJvOGWQ0RhJSzgAmg-1; Fri, 26 May 2023 06:37:07 -0400
X-MC-Unique: pSHIIYJvOGWQ0RhJSzgAmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 878F62A2AD42;
 Fri, 26 May 2023 10:37:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6B3AC154D1;
 Fri, 26 May 2023 10:37:06 +0000 (UTC)
Date: Fri, 26 May 2023 11:37:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] crypto: Always initialize splitkeylen
Message-ID: <ZHCLz47myVu/h7uk@redhat.com>
References: <20230522114737.32686-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230522114737.32686-1-akihiko.odaki@daynix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, May 22, 2023 at 08:47:37PM +0900, Akihiko Odaki wrote:
> When _FORTIFY_SOURCE=2, glibc version is 2.35, and GCC version is
> 12.1.0, the compiler complains as follows:
> 
> In file included from /usr/include/string.h:535,
>                  from /home/alarm/q/var/qemu/include/qemu/osdep.h:99,
>                  from ../crypto/block-luks.c:21:
> In function 'memset',
>     inlined from 'qcrypto_block_luks_store_key' at ../crypto/block-luks.c:843:9:
> /usr/include/bits/string_fortified.h:59:10: error: 'splitkeylen' may be used uninitialized [-Werror=maybe-uninitialized]
>    59 |   return __builtin___memset_chk (__dest, __ch, __len,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    60 |                                  __glibc_objsize0 (__dest));
>       |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../crypto/block-luks.c: In function 'qcrypto_block_luks_store_key':
> ../crypto/block-luks.c:699:12: note: 'splitkeylen' was declared here
>   699 |     size_t splitkeylen;
>       |            ^~~~~~~~~~~
> 
> It seems the compiler cannot see that splitkeylen will not be used
> when splitkey is NULL. Suppress the warning by initializing splitkeylen
> even when splitkey stays NULL.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  crypto/block-luks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

and queued.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


