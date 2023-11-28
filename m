Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 254EC7FBF1B
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 17:21:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r80pD-0007Tn-HB; Tue, 28 Nov 2023 11:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r80pB-0007SR-Pp
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:20:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r80pA-0004U0-16
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701188434;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSLJ7sfAbCtzsJw9UpWUsFVaixD0bh9s0OS9MCa78zY=;
 b=OwUrAkI/V7m6Cl4xv91jNaRIXWxp+oJQrPFjRR+PdPWJdIX1tcoCcl4gNjZM8V7hbGfNt2
 SXYl0e1YrZXHoGxZH1W59Vd8dVBza1kGRVDZeIDqr1OOwxD6QDX4NptV0f6Mhw/cU7GHqk
 5U7/dmzR0lRUYuLuF7oz19aclmW3wJA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-wl8EtfmHPISWq9bOgGYmoA-1; Tue,
 28 Nov 2023 11:20:31 -0500
X-MC-Unique: wl8EtfmHPISWq9bOgGYmoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D021A3806708;
 Tue, 28 Nov 2023 16:20:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CA8140C6EB9;
 Tue, 28 Nov 2023 16:20:29 +0000 (UTC)
Date: Tue, 28 Nov 2023 16:20:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Hyman Huang <yong.huang@smartx.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2] crypto: Introduce SM4 symmetric cipher algorithm
Message-ID: <ZWYTSrfRL-iXM1LX@redhat.com>
References: <4413f00465bda93eda7a7560afb990ca01191062.1701185032.git.yong.huang@smartx.com>
 <6776b07c-f1a8-4b96-9527-de8e0ed16980@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6776b07c-f1a8-4b96-9527-de8e0ed16980@linaro.org>
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

On Tue, Nov 28, 2023 at 04:57:20PM +0100, Philippe Mathieu-Daudé wrote:
> Hi Hyman,
> 
> On 28/11/23 16:24, Hyman Huang wrote:
> > Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
> > 
> > SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> > Organization of State Commercial Administration of China (OSCCA)
> > as an authorized cryptographic algorithms for the use within China.
> > 
> > Use the crypto-sm4 meson build option for enabling this feature.
> > 
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >   crypto/block-luks.c             | 11 ++++++++
> >   crypto/cipher-gcrypt.c.inc      |  8 ++++++
> >   crypto/cipher-nettle.c.inc      | 49 +++++++++++++++++++++++++++++++++
> >   crypto/cipher.c                 |  6 ++++
> >   meson.build                     | 23 ++++++++++++++++
> >   meson_options.txt               |  2 ++
> >   qapi/crypto.json                |  5 +++-
> >   scripts/meson-buildoptions.sh   |  3 ++
> >   tests/unit/test-crypto-cipher.c | 13 +++++++++
> >   9 files changed, 119 insertions(+), 1 deletion(-)
> 
> 
> > diff --git a/meson.build b/meson.build
> > index ec01f8b138..256d3257bb 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1480,6 +1480,7 @@ endif
> >   gcrypt = not_found
> >   nettle = not_found
> >   hogweed = not_found
> > +crypto_sm4 = not_found
> >   xts = 'none'
> >   if get_option('nettle').enabled() and get_option('gcrypt').enabled()
> > @@ -1514,6 +1515,26 @@ if not gnutls_crypto.found()
> >         xts = 'private'
> >       endif
> >     endif
> > +  if get_option('crypto_sm4').enabled()
> 
> We want to detect it by default (not only when explicitly enabled) ...
> 
> > +    if get_option('gcrypt').enabled()
> > +      # SM4 ALG is available in libgcrypt >= 1.9
> > +      crypto_sm4 = dependency('libgcrypt', version: '>=1.9',
> > +                              method: 'config-tool',
> > +                              required: get_option('gcrypt'))
> > +      # SM4 ALG static compilation
> > +      if crypto_sm4.found() and get_option('prefer_static')
> > +        crypto_sm4 = declare_dependency(dependencies: [
> > +          crypto_sm4,
> > +          cc.find_library('gpg-error', required: true)],
> > +          version: crypto_sm4.version())
> > +      endif
> > +    else
> > +      # SM4 ALG is available in nettle >= 3.9
> > +      crypto_sm4 = dependency('nettle', version: '>=3.9',
> > +                              method: 'pkg-config',
> > +                              required: get_option('nettle'))
> > +    endif
> 
> ... and if it was forced with --enable-crypto_sm4 AND not found,
> display an error.
> 
> IIUC your config you try to find the best effort implementation then
> if not found, keep going silently.

Yes, ignore the get_option() calls, and instead look at .found()
in the library we just detected

ie

  if nettle.found()
      ....check sm4 in nettle
  endif

  if gcrypt.found()
      ....check sm4 in crypt
  endif


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


