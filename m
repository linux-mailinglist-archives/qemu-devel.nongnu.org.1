Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE3C7B9BE5
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 10:46:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoJyu-0004KX-JW; Thu, 05 Oct 2023 04:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qoJys-0004KP-Jp
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 04:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qoJyq-0007EJ-S0
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 04:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696495512;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wh4nUKq4cIEz7xPEvukv7TNeI1hD3aUAVDuqpe3YZmU=;
 b=Z0NzDQYmxLiIvjnw6R2fRtLF1O+7tcwR3t33LwJ6tEwUeURDqTtIAjNFh6sSy1aY3vGIKh
 cPjOWxJkQ8PzYS6s1b+v/7INRiLfWjK45V8zvb1JZxSJGXUUPUcTz0AtuqSXFVwlOzw5gr
 51h3vCg3Deqc/uUZPXe2lB+T1dsM2vU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-u9i_kukOMryHOXcjp-Y2Ig-1; Thu, 05 Oct 2023 04:44:58 -0400
X-MC-Unique: u9i_kukOMryHOXcjp-Y2Ig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 454373823329;
 Thu,  5 Oct 2023 08:44:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43229111CD23;
 Thu,  5 Oct 2023 08:44:57 +0000 (UTC)
Date: Thu, 5 Oct 2023 09:44:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Wshadow: Better name for 'optarg'?
Message-ID: <ZR53h75UYpSCdp7k@redhat.com>
References: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
 <d688281c-d019-c1ff-6927-d1791911c57d@linaro.org>
 <e13885b5-06a2-599f-e0fe-c5e8f0671742@redhat.com>
 <b8b28fa6-6224-cf6c-9aa9-016083ed994f@linaro.org>
 <87lechabs2.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lechabs2.fsf@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

On Thu, Oct 05, 2023 at 07:17:17AM +0200, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> > On 4/10/23 19:35, Thomas Huth wrote:
> >> On 04/10/2023 19.23, Richard Henderson wrote:
> >>> On 10/4/23 03:05, Philippe Mathieu-Daudé wrote:
> >>>> Hi,
> >>>>
> >>>> I'm getting a bunch of errors for 'optarg' declared in <unistd.h>:
> >>>
> >>> I thought things like this is why we were trying -Wshadow=local.
> >>>
> >>> I think it's unlikely that we'll be able to prevent all such cases.
> >> Given the broad range of operating systems and libraries that we support in QEMU, I agree with Richard - it will likely be impossible to enable that option without =local by default without risking that compilation breaks on some exotic systems or new versions of various libraries.
> >
> > -Wshadow=local doesn't seem to work here which is why I switched
> > to -Wshadow. I probably misunderstood something from Markus cover
> > letter. My setup is:
> >
> > C compiler for the host machine: clang (clang 14.0.3 "Apple clang version 14.0.3 (clang-1403.0.22.14.1)")
> >
> > I suppose we'll figure that out when eventually enabling -Wshadow=local
> > on CI. Meanwhile I already cleaned the 'optarg' warnings that were
> > bugging me, see:
> > https://lore.kernel.org/qemu-devel/20231004120019.93101-1-philmd@linaro.org/
> > I'll try to get -Wshadow=local, but the other series still seems a
> > good cleanup, as I used more meaningful variable names.
> 
> I'm aiming just for -Wshadow=local now.  If somebody else gets us all
> the way to -Wshadow, I'll clap from the sidelines.
> 
> I'm mildly skeptical about -Wshadow without =local when targeting a wide
> range of toolchains over a long time.

We don't need to claim that QEMU will build warning-free on all possible
toolchains, only our CI covered platforms get that expectation. If users
see warnings on untested toolchains they can either send further patches,
or turn off -Werror, and/or contribute to CI coverage.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


