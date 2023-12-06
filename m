Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4868076CF
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 18:42:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAvtg-0008JO-Rp; Wed, 06 Dec 2023 12:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rAvte-0008JC-1U
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:41:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rAvtX-0007WL-B1
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701884470;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RjVbYlaJfMj01EmF7wBNfPlhYKkQPcCqb3Va57/keWw=;
 b=aOmXI9fgpmqownkCHSaXr1x0IWZIZjzylnH+tsyXOGzuhG5G5JLpSEGX1+s3afKhw+/sGM
 mZmL1wtkPNhbq+7XSYZP89bKn1IzGUE7gfkUsII5sRYr/jcZvVtl3PlvzHcNgXfp7iIAnd
 Lm1BR9DJ6tgjCW1WNo/3XtY2+Ptyang=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-B6aJKpLJNdmKajpYxbX4Zg-1; Wed, 06 Dec 2023 12:41:08 -0500
X-MC-Unique: B6aJKpLJNdmKajpYxbX4Zg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BA92101A551;
 Wed,  6 Dec 2023 17:41:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E49E492BE6;
 Wed,  6 Dec 2023 17:41:06 +0000 (UTC)
Date: Wed, 6 Dec 2023 17:41:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3] crypto: Introduce SM4 symmetric cipher algorithm
Message-ID: <ZXCyL9TDaQXXwaoT@redhat.com>
References: <3c9608d818225af1e20478f98501594a5fea9353.1701270110.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c9608d818225af1e20478f98501594a5fea9353.1701270110.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 29, 2023 at 11:17:49PM +0800, Hyman Huang wrote:
> Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
> 
> SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> Organization of State Commercial Administration of China (OSCCA)
> as an authorized cryptographic algorithms for the use within China.
> 
> Use the crypto-sm4 meson build option to explicitly control the
> feature, which would be detected by default.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  crypto/block-luks.c             | 11 ++++++++
>  crypto/cipher-gcrypt.c.inc      |  8 ++++++
>  crypto/cipher-nettle.c.inc      | 49 +++++++++++++++++++++++++++++++++
>  crypto/cipher.c                 |  6 ++++
>  meson.build                     | 42 ++++++++++++++++++++++++++++
>  meson_options.txt               |  2 ++
>  qapi/crypto.json                |  5 +++-
>  scripts/meson-buildoptions.sh   |  3 ++
>  tests/unit/test-crypto-cipher.c | 13 +++++++++
>  9 files changed, 138 insertions(+), 1 deletion(-)
> 

> diff --git a/meson.build b/meson.build
> index ec01f8b138..765f9c9f50 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1480,6 +1480,7 @@ endif
>  gcrypt = not_found
>  nettle = not_found
>  hogweed = not_found
> +crypto_sm4 = not_found
>  xts = 'none'
>  
>  if get_option('nettle').enabled() and get_option('gcrypt').enabled()
> @@ -1505,6 +1506,28 @@ if not gnutls_crypto.found()
>           cc.find_library('gpg-error', required: true)],
>          version: gcrypt.version())
>      endif
> +    crypto_sm4 = gcrypt
> +    # SM4 ALG is available in libgcrypt >= 1.9
> +    if gcrypt.found() and not cc.links('''
> +      #include <gcrypt.h>
> +      int main(void) {
> +        gcry_cipher_hd_t handler;
> +        gcry_cipher_open(&handler, GCRY_CIPHER_SM4, GCRY_CIPHER_MODE_ECB, 0);
> +        return 0;
> +      }''', dependencies: gcrypt)
> +      crypto_sm4 = not_found
> +      if get_option('crypto_sm4').enabled()
> +        error('could not link sm4')
> +      else
> +        warning('could not link sm4, disabling')
> +      endif

IMHO we don't need to have an option for 'crypto_sm4', just
silently disable it if not present in the host provideed
library.

> +    endif
> +    if crypto_sm4.found() and get_option('prefer_static')
> +      crypto_sm4 = declare_dependency(dependencies: [
> +        gcrypt,
> +        cc.find_library('gpg-error', required: true)],
> +        version: gcrypt.version())
> +    endif

This last if/endif block is redundant. We already have earlier
logic that detects gpg-error, and we never use the 'crypto_sm4'
object after this point anyway

>    endif
>    if (not get_option('nettle').auto() or have_system) and not gcrypt.found()
>      nettle = dependency('nettle', version: '>=3.4',
> @@ -1513,6 +1536,23 @@ if not gnutls_crypto.found()
>      if nettle.found() and not cc.has_header('nettle/xts.h', dependencies: nettle)
>        xts = 'private'
>      endif
> +    crypto_sm4 = nettle
> +    # SM4 ALG is available in nettle >= 3.9
> +    if nettle.found() and not cc.links('''
> +      #include <nettle/sm4.h>
> +      int main(void) {
> +        struct sm4_ctx ctx;
> +        unsigned char key[16] = {0};
> +        sm4_set_encrypt_key(&ctx, key);
> +        return 0;
> +      }''', dependencies: nettle)
> +      crypto_sm4 = not_found
> +      if get_option('crypto_sm4').enabled()
> +        error('could not link sm4')
> +      else
> +        warning('could not link sm4, disabling')
> +      endif

Likewise no need for an option, just silently disable it.

> +    endif
>    endif
>  endif
>  
> @@ -2199,6 +2239,7 @@ config_host_data.set('CONFIG_GNUTLS_CRYPTO', gnutls_crypto.found())
>  config_host_data.set('CONFIG_TASN1', tasn1.found())
>  config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
>  config_host_data.set('CONFIG_NETTLE', nettle.found())
> +config_host_data.set('CONFIG_CRYPTO_SM4', crypto_sm4.found())
>  config_host_data.set('CONFIG_HOGWEED', hogweed.found())
>  config_host_data.set('CONFIG_QEMU_PRIVATE_XTS', xts == 'private')
>  config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
> @@ -4273,6 +4314,7 @@ summary_info += {'nettle':            nettle}
>  if nettle.found()
>     summary_info += {'  XTS':             xts != 'private'}
>  endif
> +summary_info += {'SM4 ALG support':   crypto_sm4}
>  summary_info += {'AF_ALG support':    have_afalg}
>  summary_info += {'rng-none':          get_option('rng_none')}
>  summary_info += {'Linux keyring':     have_keyring}
> diff --git a/meson_options.txt b/meson_options.txt
> index c9baeda639..db8de4ec5b 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -172,6 +172,8 @@ option('nettle', type : 'feature', value : 'auto',
>         description: 'nettle cryptography support')
>  option('gcrypt', type : 'feature', value : 'auto',
>         description: 'libgcrypt cryptography support')
> +option('crypto_sm4', type : 'feature', value : 'auto',
> +       description: 'SM4 symmetric cipher algorithm support')

Drop this.

>  option('crypto_afalg', type : 'feature', value : 'disabled',
>         description: 'Linux AF_ALG crypto backend driver')
>  option('libdaxctl', type : 'feature', value : 'auto',

> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 680fa3f581..f189f34829 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -106,6 +106,7 @@ meson_options_help() {
>    printf "%s\n" '  colo-proxy      colo-proxy support'
>    printf "%s\n" '  coreaudio       CoreAudio sound support'
>    printf "%s\n" '  crypto-afalg    Linux AF_ALG crypto backend driver'
> +  printf "%s\n" '  crypto-sm4      SM4 symmetric cipher algorithm support'
>    printf "%s\n" '  curl            CURL block device driver'
>    printf "%s\n" '  curses          curses UI'
>    printf "%s\n" '  dbus-display    -display dbus support'
> @@ -282,6 +283,8 @@ _meson_option_parse() {
>      --disable-coroutine-pool) printf "%s" -Dcoroutine_pool=false ;;
>      --enable-crypto-afalg) printf "%s" -Dcrypto_afalg=enabled ;;
>      --disable-crypto-afalg) printf "%s" -Dcrypto_afalg=disabled ;;
> +    --enable-crypto-sm4) printf "%s" -Dcrypto_sm4=enabled ;;
> +    --disable-crypto-sm4) printf "%s" -Dcrypto_sm4=disabled ;;
>      --enable-curl) printf "%s" -Dcurl=enabled ;;
>      --disable-curl) printf "%s" -Dcurl=disabled ;;
>      --enable-curses) printf "%s" -Dcurses=enabled ;;

This can go away too


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


