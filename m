Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 846D77464AD
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 23:07:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGQkC-0008H3-Kw; Mon, 03 Jul 2023 17:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qGQkA-0008DB-9o
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 17:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qGQk7-0001Gr-9z
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 17:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688418354;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8hCPYuhpD7fHReInU3/HZRT6E248d9IXMZYDX1Er6NI=;
 b=Y/yfghsMZRYKfy/sETeAv38zhYqFCfxxVG4+9V5hNNC4KRhmox1flUTZwiE2WECc5gr/ZO
 4Q96mRZfQuoTPiJExuJGAFvojC057ROiGqANtBpLKRABzdWaIIq58R6OmzDUFJBLHgZ68a
 9LwUOth/Mnn6ZdqTZbKr0JGSYlc2T1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-nJ5TL8arPl6n89NyEO-GYw-1; Mon, 03 Jul 2023 17:05:52 -0400
X-MC-Unique: nJ5TL8arPl6n89NyEO-GYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3430C185A791;
 Mon,  3 Jul 2023 21:05:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34D384087C6B;
 Mon,  3 Jul 2023 21:05:51 +0000 (UTC)
Date: Mon, 3 Jul 2023 22:05:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 laurent@vivier.eu, Florian Weimer <fweimer@redhat.com>,
 Sajan Karumanchi <sajan.karumanchi@amd.com>
Subject: GLibC AMD CPUID cache reporting regression (was Re: qemu-user self
 emulation broken with default CPU on x86/x64)
Message-ID: <ZKM4LV5UboN7PGni@redhat.com>
References: <c0a35ed3-7e4a-aea6-a3bd-9f0e4079f4e0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0a35ed3-7e4a-aea6-a3bd-9f0e4079f4e0@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

On Mon, Jul 03, 2023 at 06:03:08PM +0200, Pierrick Bouvier wrote:
> Hi everyone,
> 
> Recently (in d135f781 [1], between v7.0.0 and v8.0.0), qemu-user default cpu
> was updated to "max" instead of qemu32/qemu64.
> 
> This change "broke" qemu self emulation if this new default cpu is used.
> 
> $ ./qemu-x86_64 ./qemu-x86_64 --version
> qemu-x86_64: ../util/cacheflush.c:212: init_cache_info: Assertion `(isize &
> (isize - 1)) == 0' failed.
> qemu: uncaught target signal 6 (Aborted) - core dumped
> Aborted
> 
> By setting cpu back to qemu64, it works again.
> $ ./qemu-x86_64 -cpu qemu64 ./qemu-x86_64  --version
> qemu-x86_64 version 8.0.50 (v8.0.0-2317-ge125b08ed6)
> Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
> 
> Commenting assert does not work, as qemu aligned malloc fail shortly after.
> 
> I'm willing to fix it, but I'm not sure what is the issue with "max" cpu
> exactly. Is it missing CPU cache line, or something else?

I've observed GLibC is issuing CPUID leaf 0x8000_001d

QEMU 'max' CPU model doesn't defnie xlevel, so QEMU makes it default
to the same as min_xlevel, which is calculated to be 0x8000_000a.

cpu_x86_cpuid() in QEMU sees CPUID leaf 0x8000_001d is above 0x8000_000a,
and so  considers it an invaild CPUID and thus forces it to report
0x0000_000d which is supposedly what an invalid CPUID leaf should do.


Net result: glibc is asking for 0x8000_001d, but getting back data
for 0x0000_000d.

This doesn't end happily for obvious reasons, getting garbage for
the dcache sizes.


The 'qemu64' CPU model also gets CPUID leaf 0x8000_001d capped back
to 0x0000_000d, but crucially qemu64 lacks the 'xsave' feature bit,
so QEMU returns all-zeroes for CPUID leaf 0x0000_000d. Still not
good, but this makes glibc report 0 for DCACHE_*, which in turn
avoids tripping up the nested qemu which queries DCACHE sysconf.

So the problem is thus more widespread than just 'max' CPU model.

Any QEMU CPU model with vendor=AuthenticAMD and the xsave feature,
and the xlevel unset, will cause glibc to report garbage for the
L1D cache info

Any QEMU CPU model with vendor=AuthenticAMD and without the xsave
feature, and the xlevel unset, will cause glibc to report zeroes
for L1D cache info

Neither is good, but the latter at least doesn't trip up the
nested QEMU when it queries L1D cache info.

I'm unsure if QEMU's behaviour is correct with calculating the
default 'xlevel' values for 'max', but I'm assuming the xlevel
was correct for Opteron_G4/5 since those are explicitly set
in the code for along time.

Over to the GLibC side, I see there was a recent change:

commit 103a469dc7755fd9e8ccf362f3dd4c55dc761908
Author: Sajan Karumanchi <sajan.karumanchi@amd.com>
Date:   Wed Jan 18 18:29:04 2023 +0100

    x86: Cache computation for AMD architecture.
    
    All AMD architectures cache details will be computed based on
    __cpuid__ `0x8000_001D` and the reference to __cpuid__ `0x8000_0006` will be
    zeroed out for future architectures.
    
    Reviewed-by: Premachandra Mallappa <premachandra.mallappa@amd.com>


This introduced the use of CPUID leaf 0x8000_001D. Before this point
glibc would use 0x8000_0000 and 0x8000_0005 to calculate the cache
size.  QEMU worked correctly with this implementation.

  https://sourceware.org/pipermail/libc-alpha/2023-January/144815.html

The reporter said

   "Though we have done the testing on Zen and pre-Zen architectures,
    we recommend to carryout the tests from your end too."

it is unclear if their testing would have covered Opteron_G4/Opteron_G5
architectures, and I not expecting to have had QEMU testing of course ?

I don't have any non-virtual pre-Zen silicon I could verify CPUID
behaviour on. I've not found historic versions of the AMD architecture
reference to see when they first documented 0x8000_001d as a valid
CPUID leaf for getting cache info.

IOW it is still unclear to me whether the root cause bug here is in
QEMU's emulation of CPUID 0x8000_001d, or whether this was actually
a real regression introduced in glibc >= 2.37

I'm tending towards glibc regression though.

Copying Florian and the original AMD patch author

Brief summary

With old glibc 2.36, using QEMU's  qemu64/max CPU models:

# qemu-x86_64-static -cpu qemu64 /bin/getconf -a | grep DCACHE
LEVEL1_DCACHE_SIZE                 65536
LEVEL1_DCACHE_ASSOC                2
LEVEL1_DCACHE_LINESIZE             64

# qemu-x86_64-static -cpu Opteron_G4 /bin/getconf -a | grep DCACHE
LEVEL1_DCACHE_SIZE                 65536
LEVEL1_DCACHE_ASSOC                2
LEVEL1_DCACHE_LINESIZE             64

# qemu-x86_64-static -cpu max /bin/getconf -a | grep DCACHE
LEVEL1_DCACHE_SIZE                 65536
LEVEL1_DCACHE_ASSOC                2
LEVEL1_DCACHE_LINESIZE             64


With new glibc 2.37:

# qemu-x86_64-static -cpu qemu64 /bin/getconf -a | grep DCACHE
LEVEL1_DCACHE_SIZE                 0
LEVEL1_DCACHE_ASSOC                0
LEVEL1_DCACHE_LINESIZE             0

# qemu-x86_64-static -cpu Opteron_G4 /bin/getconf -a | grep DCACHE
LEVEL1_DCACHE_SIZE                 693889
LEVEL1_DCACHE_ASSOC                1
LEVEL1_DCACHE_LINESIZE             833

# qemu-x86_64-static -cpu max /bin/getconf -a | grep DCACHE
LEVEL1_DCACHE_SIZE                 7273809
LEVEL1_DCACHE_ASSOC                1
LEVEL1_DCACHE_LINESIZE             2697

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


