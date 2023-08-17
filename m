Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A222377F49D
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 13:00:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWaiY-00049V-VC; Thu, 17 Aug 2023 06:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWaiT-00048p-23
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWaiQ-0006jb-LT
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692269937;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Im/GGzpvHTOqKjV1z6PP+HdX0TPHvmP7DrQKhqyhOkQ=;
 b=B2+q3rUsjP7Go3jyE4y6Y9L5Ro9ScGoJZ/jl9wCR5Nc38emsZc8/cm3x8phaZiU1IVZRpN
 SPm+vBSyybcQqbJKp5GG9QuTRN96/+l6r4iNFENS7UtsVFSCpRJ1IBPHbzugBXRIyAt0WA
 tPhamtb6nacGbT7Hm7v2pC6lmz4YJgk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-eXr3jPoWOo6fTE1Eeivgqw-1; Thu, 17 Aug 2023 06:58:54 -0400
X-MC-Unique: eXr3jPoWOo6fTE1Eeivgqw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 053D1800C7A;
 Thu, 17 Aug 2023 10:58:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A68A1492C13;
 Thu, 17 Aug 2023 10:58:52 +0000 (UTC)
Date: Thu, 17 Aug 2023 11:58:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH][RFC] Add crash handler for qemu-linux-user
Message-ID: <ZN39ann2QV3Jsx+z@redhat.com>
References: <ZNQcQxcL/22LmrVP@p100>
 <129c90ab-14cc-04bb-493a-d4524b54c02f@linaro.org>
 <CAFEAcA_yD37zTnXNkX+qg_WtUUQPJrk72UL4vusdJrnNHz4H7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_yD37zTnXNkX+qg_WtUUQPJrk72UL4vusdJrnNHz4H7A@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Thu, Aug 10, 2023 at 10:14:06AM +0100, Peter Maydell wrote:
> On Thu, 10 Aug 2023 at 02:28, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 8/9/23 16:07, Helge Deller wrote:
> > > +            /* did qemu source code crashed? */
> > > +            if (unlikely(!h2g_valid(host_addr))) {
> > > +                qemu_show_backtrace(info);
> > > +            }
> >
> > This won't do anything at all when reserved_va == 0,
> > i.e. 64-bit guest on 64-bit host, or any 32-bit host.
> >
> > The idea of having a backtrace is nice, I suppose, we just need
> > a better detector.
> 
> I think Dan also had a look at one point at doing
> backtraces for crashes in system emulation mode?
> Certainly this would be useful for test crashes in CI.

I stopped that work as I couldn't figure out a way to get a backtrace
across all the threads, which severely limited its usefulness in the
QEMU system emulators.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


