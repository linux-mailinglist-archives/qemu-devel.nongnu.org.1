Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F177A0228
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:07:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkBt-0000iB-Ed; Thu, 14 Sep 2023 07:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgkBr-0000hc-J4
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgkBm-0005OP-1w
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694689633;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZo9bySxNrj3XBmV0wsyaHADAvu8Vvdurz5Q9lAPEgg=;
 b=QUiGtnBgy0WO3HplsmXTNwe4Xtt8l0v8YoAMjXCIUB4HDL33TEF2Ls5mG/+oZj2RZHbta3
 KZr6iIA/Rhn1Djco0llWftie5ImYWaDcBRkzjfWQm5EvODLsU+qF9mykdHqv54CdRLXENa
 DyM1Y5hLxhxDPT68fGTadgYVQaznUr4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-2Af44ycjPi2AJyrBxIOJGA-1; Thu, 14 Sep 2023 07:07:09 -0400
X-MC-Unique: 2Af44ycjPi2AJyrBxIOJGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48909801FA9;
 Thu, 14 Sep 2023 11:07:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE11740C2070;
 Thu, 14 Sep 2023 11:07:06 +0000 (UTC)
Date: Thu, 14 Sep 2023 12:07:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/3] linux-user/syscall.c: do_ppoll: eliminate large
 alloca
Message-ID: <ZQLpVm11Kgp9e1nS@redhat.com>
References: <20230914074337.149897-1-mjt@tls.msk.ru>
 <20230914074337.149897-4-mjt@tls.msk.ru>
 <ZQLBvThMJK7LzoOw@redhat.com>
 <33f3e825-97ba-eeef-c991-75c2317fdc11@tls.msk.ru>
 <8d43d03d-ac66-0d01-0137-d27eaac628d3@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d43d03d-ac66-0d01-0137-d27eaac628d3@tls.msk.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 14, 2023 at 02:05:21PM +0300, Michael Tokarev wrote:
> 14.09.2023 11:26, Michael Tokarev wrote:
> > 14.09.2023 11:18, Daniel P. Berrangé wrote:
> ..
> > > > -    struct pollfd *pfd = NULL;
> > > > +    struct pollfd *pfd = NULL, *heap_pfd = NULL;
> > > 
> > > g_autofree struct pollfd *heap_pdf = NULL;
> > > 
> > ...
> > > >   out:
> > > > +    g_free(heap_pfd);
> > > 
> > > This can be dropped with g_autofree usage
> > 
> > Yes, I know this, - this was deliberate choice.
> > Personally I'm just too used to old-school explicit resource deallocations.
> > Here, there's a single place where everything gets freed, so there's little
> > reason to use fancy modern automatic deallocations. To my taste anyway.
> > Maybe some future modifications adding some future ppoll3.. :)
> > 
> > Sure thing I can drop that and change it to autofree.
> 
> Should I? If that's easier in todays world :)

I prefer auto-free, but I'm fine with this commit either way, so

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


