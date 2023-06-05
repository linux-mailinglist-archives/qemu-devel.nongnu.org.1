Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ED8722497
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:30:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68PB-0002kz-CW; Mon, 05 Jun 2023 07:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q68P4-0002kL-RE
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q68P2-0007WA-Fz
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685964575;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8ZGE0sYmvt+0tDRJngbQdorJQF0zpneVsMrV2BDoF+E=;
 b=LF1gN7/54oLpAX5wUr+AKf66f5k2adl1a68sv1crbdZsPRUEkVWqwOfotCrlwVSpCscfcG
 CIq0YgHNeUd84LG1QttCx0+hkfnG5RfbBw/6wwH4OYckQdVe1puxLqyiLxQxArXrBI7WTm
 CiLrmnX7NAedAUlaL0bgOzxWvkjS5s4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-PcDonqTbOBO3NL_LiYkAsg-1; Mon, 05 Jun 2023 07:29:34 -0400
X-MC-Unique: PcDonqTbOBO3NL_LiYkAsg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D594E85A5BA;
 Mon,  5 Jun 2023 11:29:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.224])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13E3A48205E;
 Mon,  5 Jun 2023 11:29:32 +0000 (UTC)
Date: Mon, 5 Jun 2023 12:29:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: vmovqdu/vmovqda inline asm doesn't compile on macos catalina
Message-ID: <ZH3HGs8DNQg/Pnlt@redhat.com>
References: <CAFEAcA8oS7fOr9Ro6Z9G5UW6FbgwTo3BTcGL4ELdVc_G7O5Obg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8oS7fOr9Ro6Z9G5UW6FbgwTo3BTcGL4ELdVc_G7O5Obg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jun 05, 2023 at 11:55:43AM +0100, Peter Maydell wrote:
> I just noticed that the recent atomicity changes introduce a build
> failure on x86 macos (Catalina). Now if we wanted to, we can say "this
> is too old and outside our support policy", of course...

Catalina is version 10.

Current Ventura is version 13.

So it fails our 'two latest releases" requirement.

More importantly, IIUC, Apple have discontinued support for Catalina
with its EOL date being Sep 2022.

Having said all that, what matters more for macOS is the toolchain
version rather than the OS version. We have very little that is
directly dependent on the OS version. Most of our library deps come
from HomeBrew, so it is mostly compiler compatibility that we are
targetting for macOS.

What clang version are you seeing this failure with ?

> (I don't know if newer x86 macos is OK -- this machine can't
> upgrade to anything newer than Catalina. So it's due to be
> decommissioned pretty soon anyway.)

x86 macOS is also now a testing void for our CI too, since
Cirrus CI switched exclusively to aarch64 :-(

So we're entirely reliant on someone having macOS x86 hardware
and being personally willing& able to send us testing reports
of any compile bugs.


> In file included from ../../accel/tcg/cputlb.c:1673:
> In file included from ../../accel/tcg/ldst_atomicity.c.inc:12:
> /Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:38:13:
> error: couldn't allocate output register for constraint 'x'
>         asm("vmovdqu %1, %0" : "=x" (r.i) : "m" (*ptr_align));
>             ^
> /Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:40:13:
> error: couldn't allocate output register for constraint 'x'
>         asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
>             ^
> In file included from ../../accel/tcg/cputlb.c:34:
> In file included from /Users/pm215/src/qemu/include/qemu/atomic128.h:62:
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
> error: couldn't allocate output register for constraint 'x'
>     asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr));
>         ^
> In file included from ../../accel/tcg/cputlb.c:1673:
> In file included from ../../accel/tcg/ldst_atomicity.c.inc:12:
> /Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:38:13:
> error: couldn't allocate output register for constraint 'x'
>         asm("vmovdqu %1, %0" : "=x" (r.i) : "m" (*ptr_align));
>             ^
> /Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:40:13:
> error: couldn't allocate output register for constraint 'x'
>         asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
>             ^
> In file included from ../../accel/tcg/cputlb.c:34:
> In file included from /Users/pm215/src/qemu/include/qemu/atomic128.h:62:
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
> error: couldn't allocate output register for constraint 'x'
>     asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr));
>         ^
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
> error: couldn't allocate output register for constraint 'x'
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
> error: couldn't allocate output register for constraint 'x'
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:55:13:
> error: couldn't allocate input reg for constraint 'x'
>         asm("vmovdqa %1, %0" : "=m"(*ptr_align) : "x" (new.i));
>             ^
> In file included from ../../accel/tcg/cputlb.c:1673:
> In file included from ../../accel/tcg/ldst_atomicity.c.inc:12:
> /Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:38:13:
> error: couldn't allocate output register for constraint 'x'
>         asm("vmovdqu %1, %0" : "=x" (r.i) : "m" (*ptr_align));
>             ^
> /Users/pm215/src/qemu/host/include/x86_64/host/load-extract-al16-al8.h:40:13:
> error: couldn't allocate output register for constraint 'x'
>         asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr_align));
>             ^
> In file included from ../../accel/tcg/cputlb.c:34:
> In file included from /Users/pm215/src/qemu/include/qemu/atomic128.h:62:
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
> error: couldn't allocate output register for constraint 'x'
>     asm("vmovdqa %1, %0" : "=x" (r.i) : "m" (*ptr));
>         ^
> /Users/pm215/src/qemu/host/include/x86_64/host/atomic128-ldst.h:31:9:
> error: couldn't allocate output register for constraint 'x'
> 13 errors generated.
> 
> -- PMM
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


