Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C387A08B2
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:10:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgnzO-0005v5-Ie; Thu, 14 Sep 2023 11:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgnzA-0005o5-RP
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgnz7-0007Oc-4J
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694704224;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cj7TfJSgD/9gMQtdU9YLLwtjxP7NVxTAqouEZm9fb0U=;
 b=VbPn/7wYrXrSod+Asylibq0SgGYSm1rkJT27zoXD3Oc5QQVRaP2nDU+qV9h73oyxsEDC3g
 u3vQePY0LJ+Mvvs2tI6SfssGX+gLgFBiiYxU119KtNWsTGWjcgwJEoIhUpBccGxEYqwDvA
 EPNXS+PG5jqQ5Sik5imbeMJqZOrHBnw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-aNoqjrSNOySIHVAmIEsJdg-1; Thu, 14 Sep 2023 11:10:20 -0400
X-MC-Unique: aNoqjrSNOySIHVAmIEsJdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4524685570E;
 Thu, 14 Sep 2023 15:10:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C40A40C6EBF;
 Thu, 14 Sep 2023 15:10:17 +0000 (UTC)
Date: Thu, 14 Sep 2023 16:10:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: =?utf-8?B?0JzQuNGA0L7QvdC+0LIg0KHQtdGA0LPQtdC5INCS0LvQsNC00LjQvNC40YA=?=
 =?utf-8?B?0L7QstC40Yc=?= <mironov@fintech.ru>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "sdl.qemu@linuxtesting.org" <sdl.qemu@linuxtesting.org>,
 "libvirt-security@redhat.com" <libvirt-security@redhat.com>
Subject: Re: [sdl-qemu] [PATCH 1/1] No checks, dereferencing possible
Message-ID: <ZQMiVrok25txP4mH@redhat.com>
References: <59e6590ea8a04de788f69709ea4c54f8@fintech.ru>
 <ZQLe4uI2xu1cKkB5@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQLe4uI2xu1cKkB5@angien.pipo.sk>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 14, 2023 at 12:22:26PM +0200, Peter Krempa wrote:
> On Thu, Sep 14, 2023 at 09:44:16 +0000, Миронов Сергей Владимирович wrote:
> > No checks, dereferencing possible.
> > 
> > 
> > Return value of a function 'virDomainChrSourceDefNew'
> > is dereferenced at qemu_command.c without checking
> > for NULL, but it is usually checked for this function.
> 
> This description here doesn't make sense. You are checking the presence
> of 'privateData' in 'virDomainVideoDef'.
> 
> > 
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > 
> > Fixes: 1f85f0967b ("ci: jobs.sh: Add back '--no-suite syntax-check --print-errorlogs'")
> > 
> > Signed-off-by: Sergey Mironov <mironov@fintech.ru>
> > 
> > ---
> > src/qemu/qemu_command.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/src/qemu/qemu_command.c b/src/qemu/qemu_command.c
> > index e84374b4cf..8d11972c88 100644
> > --- a/src/qemu/qemu_command.c
> > +++ b/src/qemu/qemu_command.c
> > @@ -4698,6 +4698,8 @@ qemuBuildVideoCommandLine(virCommand *cmd,
> >              g_autofree char *name = g_strdup_printf("%s-vhost-user", video->info.alias);
> >              qemuDomainChrSourcePrivate *chrsrcpriv = QEMU_DOMAIN_CHR_SOURCE_PRIVATE(chrsrc);
> > 
> > +           if (chrsrc == NULL)
> > +                   return -1;
> 
> This addition doesn't make sense as it's dead code. The private data is
> always allocated and checked that it's non-NULL in the qemu driver via
> the callback in virDomainVideoDefNew.


This is checking the result of  virDomainChrSourceDefNew(), which can
fail as virDomainChrSourceDefInitialize() can fail if virClassNew()
fails its sanity checks.

The check is too late though, as we de-referenced chrsrc in the line
above when we accessed the private data.

> 
> Do you have a call trace that would prove me otherwise?
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


