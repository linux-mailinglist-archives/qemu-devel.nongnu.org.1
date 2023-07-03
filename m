Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7438A7461C5
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 20:06:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGNv9-0001Q0-Cb; Mon, 03 Jul 2023 14:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qGNv5-0001Ps-BU
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 14:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qGNv0-0002e1-Ni
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 14:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688407497;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Lv8n/SM6xt47u4h0qEXC+QQdfRxD0OlJBx7GJHm/PyA=;
 b=csFKmFoCy1/TlXJ7xz3n7bdSp5920QCYHQLOp5auQtA9JIgHi/iFxLV4vEt1UUpr72j5Fn
 d2MVX9iurm7w+gJOdqSx2qDCM0eNI6OS9ZE8jgIf58FGAi9IbfPA5SHCprFlAJvOfA02rz
 2e24bFUUbqLpCW4D1UL/uTeBIcEZjzU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-MZ9Y3ed4OWqcpjhsqWeaUw-1; Mon, 03 Jul 2023 14:04:56 -0400
X-MC-Unique: MZ9Y3ed4OWqcpjhsqWeaUw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECCF23803515;
 Mon,  3 Jul 2023 18:04:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27927492B01;
 Mon,  3 Jul 2023 18:04:55 +0000 (UTC)
Date: Mon, 3 Jul 2023 19:04:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 laurent@vivier.eu
Subject: Re: qemu-user self emulation broken with default CPU on x86/x64
Message-ID: <ZKMNxYM7+3hREvMd@redhat.com>
References: <c0a35ed3-7e4a-aea6-a3bd-9f0e4079f4e0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0a35ed3-7e4a-aea6-a3bd-9f0e4079f4e0@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
> Any guidance would be welcome.

Yes, it appears that dcache info being reported by the 'max' CPU is
bogus. We can simply the test case with 'getconf'

With 'max' CPU model:

# getconf -a | grep DCACHE
LEVEL1_DCACHE_SIZE                 7273809
LEVEL1_DCACHE_ASSOC                1
LEVEL1_DCACHE_LINESIZE             2697

with 'qemu64' CPU model

# getconf -a | grep DCACHE
LEVEL1_DCACHE_SIZE                 0
LEVEL1_DCACHE_ASSOC                0
LEVEL1_DCACHE_LINESIZE             0

OR with Nehalem:

# getconf -a | grep DCACHE
LEVEL1_DCACHE_SIZE                 32768
LEVEL1_DCACHE_ASSOC                8
LEVEL1_DCACHE_LINESIZE             64

> 
> I know it's not the most important problem on earth, but it's still
> surprising to meet this when you try to use qemu to emulate itself.
> 
> Regards,
> Pierrick
> 
> [1] https://gitlab.com/qemu-project/qemu/-/commit/d135f781405f7c78153aa65e0327b05a4aa72e50
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


