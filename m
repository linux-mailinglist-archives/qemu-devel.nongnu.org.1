Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BDE717F14
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:52:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4KNN-000503-9C; Wed, 31 May 2023 07:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4KNK-0004zg-Ss
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4KNI-0003fU-By
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685533938;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ute4tRgCg3fRlGbQ5tav9WY69OSnnAb7Bsv0zxr64jo=;
 b=R7Qi5xH33xu2IqbM2Iqjfvp4b7bKFoOmCZGGJZj+ByaKV9g3SwC8q3SdZXpj0Mnud73n5b
 vrdbZSIV7kHpME95JRueUOq+ooTv38jRqNx6CgriIaJrPGeVq+Pn2wL8WHnKW87HxFN31W
 5Nt/Mfjsvs5oTKqt5fqLt8nSaArqYtY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-lD9TcysgPlqMD3P3W3XuSA-1; Wed, 31 May 2023 07:52:14 -0400
X-MC-Unique: lD9TcysgPlqMD3P3W3XuSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7124E85A5B5;
 Wed, 31 May 2023 11:52:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D57C840CFD46;
 Wed, 31 May 2023 11:52:10 +0000 (UTC)
Date: Wed, 31 May 2023 12:52:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Erik Skultety <eskultet@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Subject: Re: How do you represent a host gcc and a cross gcc in lcitool?
Message-ID: <ZHc06CG9SYVOz7VD@redhat.com>
References: <87wn0obuk6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wn0obuk6.fsf@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 31, 2023 at 12:23:34PM +0100, Alex Bennée wrote:
> Hi,
> 
> While trying to convert the debian-riscv64-cross docker container to an
> lcitool based one I ran into a problem building QEMU. The configure step
> fails because despite cross compiling we still need a host compiler to
> build the hexagon codegen tooling.
> 
> After scratching my head for a while I discovered we did have host GCC's
> in our cross images despite there being no explicit request for them in
> the docker description. It turned out that the gcovr requirement pulled
> in lcov which itself had a dependency on gcc. However this is a bug:
> 
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=987818
> 
> which has been fixed in bookworm (and of course sid which is the only
> way we can get a riscv64 build of QEMU at the moment). Hence my hacky
> attempts to get gcc via side effect of another package failed.
> 
> Hence the question in $SUBJECT. I tried to add a mapping to lcitool for
> a pseudo hostgcc package:
> 
> +  hostgcc:
> +    default: gcc
> +    pkg:
> +    MacOS:
> +    cross-policy-default: skip
> 
> however this didn't work. Do we need a new mechanism for this or am I
> missing a way to do this?

The last case we had this was with glib2 and in that case we
modified mappings.yml so that it has both 'glib2' and 'glib2-native'

I guess we want the same for gcc in this case.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


