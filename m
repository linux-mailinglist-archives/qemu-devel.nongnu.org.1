Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C05B67C4D8A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 10:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqUsD-00060i-T0; Wed, 11 Oct 2023 04:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qqUs8-00060O-Uz
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 04:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qqUs6-0005LM-7l
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 04:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697014032;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ENPQ1lTVyHQxnFL2KZzEfITDUkI+VWEdHFl6BhcJoUE=;
 b=FLaxt9lVhUXVx3vW8tEMZv14ZEuiryZzKSOYKfr05oGd+YgP/BBI4B9glltaSuk6KkD2dy
 ta4EHczT9Ikyds+3t6yhPua6h+ld7NVhYe1glMuNuH/HG9nXNkaFVk8kh/1RkBIm+ZtxMQ
 Pg/WCa6lWqIv4aprsDXJwpFZfQ34pmk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-qIMXOjPpPGCJIrELgyLAPA-1; Wed, 11 Oct 2023 04:47:09 -0400
X-MC-Unique: qIMXOjPpPGCJIrELgyLAPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27B353C14767;
 Wed, 11 Oct 2023 08:47:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4861F170E9;
 Wed, 11 Oct 2023 08:47:07 +0000 (UTC)
Date: Wed, 11 Oct 2023 09:47:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Tyler Fanelli <tfanelli@redhat.com>
Subject: Re: [PULL 50/51] subprojects: add wrap file for libblkio
Message-ID: <ZSZhCcnn2C37uZWH@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907130004.500601-51-pbonzini@redhat.com>
 <14ff27a8-284b-66f8-097a-5d49c94dcff8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14ff27a8-284b-66f8-097a-5d49c94dcff8@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

On Wed, Oct 11, 2023 at 07:35:24AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Paolo,
> 
> On 7/9/23 14:59, Paolo Bonzini wrote:
> > This allows building libblkio at the same time as QEMU, if QEMU is
> > configured with --enable-blkio --enable-download.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   subprojects/libblkio.wrap | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >   create mode 100644 subprojects/libblkio.wrap
> > 
> > diff --git a/subprojects/libblkio.wrap b/subprojects/libblkio.wrap
> > new file mode 100644
> > index 00000000000..f77af72210c
> > --- /dev/null
> > +++ b/subprojects/libblkio.wrap
> > @@ -0,0 +1,6 @@
> > +[wrap-git]
> > +url = https://gitlab.com/libblkio/libblkio
> 
> Tyler noticed this project isn't mirrored on QEMU gitlab namespace.

Many other wraps aren't mirrored either, and I'm not convinced we
need to, unless the project is on an obscure self hosted git service
which is thought unreliable.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


