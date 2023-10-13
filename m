Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B590A7C8665
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHuB-0005bX-UN; Fri, 13 Oct 2023 09:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qrHu9-0005ar-8M
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qrHu5-0005BM-T6
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697202512;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JstFsuHAy2VN/QFwYN9mac2Jc+5eGk9mit6jNKsIjnc=;
 b=WysMzxcEvEfrEpYuAJ5lJvCVaXCBXFwQHFgn1lZNyG2JXFQPI+b2MfHZUkp2uHJ9Qv5jfB
 ayD4BBAMwr6bK51n/eN1seUrs51MyJqN+jCFUkCdWae0GjzeRAyzox2boRa98m7ya4E61M
 qytwJs5Lg9I+Tk7EBrRZyaGr6fQzEkg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-9YjHUZQZOwG2O5TD64u9IQ-1; Fri, 13 Oct 2023 09:08:21 -0400
X-MC-Unique: 9YjHUZQZOwG2O5TD64u9IQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0168981D9ED;
 Fri, 13 Oct 2023 13:08:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DBE240C6F79;
 Fri, 13 Oct 2023 13:08:20 +0000 (UTC)
Date: Fri, 13 Oct 2023 14:08:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org
Subject: Re: [RFC PATCH 00/78] Strict disable implicit fallthrough
Message-ID: <ZSlBQvyVMiJ6h5R3@redhat.com>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
 <ZSj8YEc0ARdUqFLG@redhat.com> <2gxf2.nr1cq95buqhq@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2gxf2.nr1cq95buqhq@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 13, 2023 at 03:51:22PM +0300, Manos Pitsidianakis wrote:
> On Fri, 13 Oct 2023 11:14, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
> > On Fri, Oct 13, 2023 at 10:47:04AM +0300, Emmanouil Pitsidianakis wrote:
> > > 
> > > Main questions this RFC poses
> > > =============================
> > > 
> > > - Is this change desirable and net-positive.
> > 
> > Yes, IMHO it is worth standardizing on use of the attribute. The allowed
> > use of comments was a nice thing by the compiler for coping with pre-existing
> > code, but using the attribute is best long term for a consistent style.
> > 
> > > - Should the `fallthrough;` pseudo-keyword be defined like in the Linux
> > >   kernel, or use glib's G_GNUC_FALLTHROUGH, or keep the already existing
> > >   QEMU_FALLTHROUGH macro.
> > 
> > As a general rule, if glib provides functionality we aim o use that
> > and not reinvent the wheel. IOW, we should just use G_GNUC_FALLTHROUGH.
> 
> I agree. My reasoning was:
> 
> - The reinvented wheel is only an attribute and not a big bunch of NIH  code

It isn't just about the amount of code, it is the familiarity of the
code. QEMU's codebase is glib based, by using glib functionality we
leverage developers' general familiarity with / knowledge of glib,
as opposed to custom QEMU approaches which need learning.

> - The macro def in glib depends on the glib version you use

If we need to depend on something that is newer than our min glib version,
then we add back compat definitino to 'include/glib-compat.h' for the older
version.

> - G_GNUC_FALLTHROUGH looks kind of abrasive to my eye, while  `fallthrough`
> blends in with other switch keywords like break.

My impression seeing this series, was exactly the opposite. I did not
like 'fallthrough' blending in with the rest of code, and also did not
like that it is a macro in lowercase, thus hiding that it is a macro

> - C23 standardises fallthrough. We might not ever support C23 but it's  good
> to be consistent with standards and other, larger projects (linux  kernel).

We're at least a decade away from being able to use anything from C23.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


