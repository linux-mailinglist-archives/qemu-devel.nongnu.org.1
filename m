Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B9A78CA7F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:15:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2Iv-0001dx-PZ; Tue, 29 Aug 2023 13:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qb2Ia-0001bD-2m
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qb2IW-0007aG-Dt
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693329273;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bcW8HMxcozzht+hLxbD54lzKDPnFihUpCSfh5v+EQj8=;
 b=S+5ggvZZUJYRMNUNuz+zBkkasI+gnipJyFNOqiJgqmvIBBo4UajFOAtLE+7FPl6yTkL67F
 PW6Lfa1tD222U6RAgMr5E47kGsAXNQp6vdjAPG0pUMW1IqnT5snD3QNN+SwAuJnhoe4yUA
 JXYs8sMdnSHaPlc5K3z/XHBRg5kUNCY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-ekl7btRaMjO5BdT-d908iA-1; Tue, 29 Aug 2023 13:14:31 -0400
X-MC-Unique: ekl7btRaMjO5BdT-d908iA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2403C85C6F4
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 17:14:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A415D9A;
 Tue, 29 Aug 2023 17:14:30 +0000 (UTC)
Date: Tue, 29 Aug 2023 18:14:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 04/10] configure: create native file with contents of
 $host_cc
Message-ID: <ZO4ndKXdF5oQSHlU@redhat.com>
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230829082931.67601-5-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 29, 2023 at 10:29:25AM +0200, Paolo Bonzini wrote:
> The argument of --host-cc is not obeyed when cross compiling.  To avoid
> this issue, place it in a configuration file and pass it to meson
> with --native-file.
> 
> While at it, clarify that --host-cc is not obeyed anyway when _not_
> cross compiling.

I presume that's refering to this piece of code

if test -z "${CC}${cross_prefix}"; then
  cc="$host_cc"
else
  cc="${CC-${cross_prefix}gcc}"
fi

which is using $host_cc *before* --host-cc is processed, thus
meaning it is always at its default value of 'cc'.

Perhaps the above code snippet should just be changed to

  if test -z "${CC}${cross_prefix}"; then
    cc="cc"
  else
    cc="${CC-${cross_prefix}gcc}"
  fi

to make it clear that we were not intending to honour the
--host-cc value for this code.

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

None the less, this patch is correct, so with or without
that above change:

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/configure b/configure
> index 3423f008d5c..b2bc1ff5f7b 100755
> --- a/configure
> +++ b/configure
> @@ -922,7 +922,7 @@ Advanced options (experts only):
>    --cross-prefix=PREFIX    use PREFIX for compile tools, PREFIX can be blank [$cross_prefix]
>    --cc=CC                  use C compiler CC [$cc]
>    --host-cc=CC             use C compiler CC [$host_cc] for code run at
> -                           build time
> +                           build time when cross compiling
>    --cxx=CXX                use C++ compiler CXX [$cxx]
>    --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
>    --extra-cflags=CFLAGS    append extra C compiler flags CFLAGS
> @@ -1886,7 +1886,6 @@ if test "$skip_meson" = no; then
>    echo "windres = [$(meson_quote $windres)]" >> $cross
>    echo "windmc = [$(meson_quote $windmc)]" >> $cross
>    if test "$cross_compile" = "yes"; then
> -    cross_arg="--cross-file config-meson.cross"
>      echo "[host_machine]" >> $cross
>      echo "system = '$targetos'" >> $cross
>      case "$cpu" in
> @@ -1903,6 +1902,14 @@ if test "$skip_meson" = no; then
>      else
>          echo "endian = 'little'" >> $cross
>      fi
> +    cross_arg="--cross-file config-meson.cross"
> +
> +    native="config-meson.native.new"
> +    echo "# Automatically generated by configure - do not modify" > $native
> +    echo "[binaries]" >> $native
> +    echo "c = [$(meson_quote $host_cc)]" >> $native
> +    mv $native config-meson.native
> +    cross_arg="$cross_arg --native-file config-meson.native"
>    else
>      cross_arg="--native-file config-meson.cross"
>    fi
> -- 
> 2.41.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


