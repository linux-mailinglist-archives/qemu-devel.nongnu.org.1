Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E299170BEA3
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:46:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14uz-0006mF-L9; Mon, 22 May 2023 08:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q14uD-0006h3-RT
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q14u4-0001NF-Tg
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684759477;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bR6j1xkWB8o4B8a2NjzYw0/QOvC4ezqNvjmSQaNVsjA=;
 b=AGlNcwjR6CnfITFRY8VlNIvMsQ1vTdyfYvzbep849xsQfs9jM2+Ww8KS4uGbRO8BXDz2NM
 zZWueCtk8h81e03UDj3X502RKiBEPlAUlZ2CHNDEs8HZqflB/34OvsftMcPFhllf1E2N+U
 tiuMhpdv6mR8WtDD/VbCLlZtB8KYr6k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-A4XkPaBGOCmh7GvjuB_lDA-1; Mon, 22 May 2023 08:44:35 -0400
X-MC-Unique: A4XkPaBGOCmh7GvjuB_lDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 605843825BA6;
 Mon, 22 May 2023 12:44:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AEC67B7C;
 Mon, 22 May 2023 12:44:33 +0000 (UTC)
Date: Mon, 22 May 2023 13:44:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH] util/vfio-helpers: Use g_file_read_link()
Message-ID: <ZGtjrWPItBSV6wQi@redhat.com>
References: <20230522114943.33024-1-akihiko.odaki@daynix.com>
 <ccdf88d1-54de-453f-b600-1f0f562aae31@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccdf88d1-54de-453f-b600-1f0f562aae31@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 22, 2023 at 02:38:44PM +0200, Philippe Mathieu-Daudé wrote:
> On 22/5/23 13:49, Akihiko Odaki wrote:
> > When _FORTIFY_SOURCE=2, glibc version is 2.35, and GCC version is
> > 12.1.0, the compiler complains as follows:
> > 
> > In file included from /usr/include/features.h:490,
> >                   from /usr/include/bits/libc-header-start.h:33,
> >                   from /usr/include/stdint.h:26,
> >                   from /usr/lib/gcc/aarch64-unknown-linux-gnu/12.1.0/include/stdint.h:9,
> >                   from /home/alarm/q/var/qemu/include/qemu/osdep.h:94,
> >                   from ../util/vfio-helpers.c:13:
> > In function 'readlink',
> >      inlined from 'sysfs_find_group_file' at ../util/vfio-helpers.c:116:9,
> >      inlined from 'qemu_vfio_init_pci' at ../util/vfio-helpers.c:326:18,
> >      inlined from 'qemu_vfio_open_pci' at ../util/vfio-helpers.c:517:9:
> > /usr/include/bits/unistd.h:119:10: error: argument 2 is null but the corresponding size argument 3 value is 4095 [-Werror=nonnull]
> >    119 |   return __glibc_fortify (readlink, __len, sizeof (char),
> >        |          ^~~~~~~~~~~~~~~
> > 
> > This error implies the allocated buffer can be NULL. Use
> > g_file_read_link(), which allocates buffer automatically to avoid the
> > error.
> > 
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >   util/vfio-helpers.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> > index 2d8af38f88..e482ab22e2 100644
> > --- a/util/vfio-helpers.c
> > +++ b/util/vfio-helpers.c
> > @@ -106,15 +106,17 @@ struct QEMUVFIOState {
> >    */
> >   static char *sysfs_find_group_file(const char *device, Error **errp)
> >   {
> > +    g_autoptr(GError) gerr;
> 
> Shouldn't this also be NULL-initialized (other picky compilers)?

Yes, *all* use of g_auto* must have an initializer at time of
declaration.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


