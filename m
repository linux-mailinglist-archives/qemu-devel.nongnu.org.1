Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1A80A258
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 12:36:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBZ8G-0003Yw-L9; Fri, 08 Dec 2023 06:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rBZ8E-0003Yn-30
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:34:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rBZ8A-0002fy-Bs
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702035292;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1B1maFPPqFgin+2zCtuv6pVj7mTedmDKhfNu1c8Twc=;
 b=Uv3ztx2xoDFcNKNpGZDDlWAj/JgHuug0DByoxR/dAEb9Kq/0Mo0RoLkA6F1jwV6sxlYPUU
 4kw4nSSSUqFGJsg7ih/draLL1fvb9KjkkisahYB+/YyIFLUmV08RyXe+sES97s7UCrVfMP
 l3BvasbRV+Dfum+5jn/mp2h+dhkB8jQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-B9NAYgWjPBqo2Zc7OrdLLQ-1; Fri, 08 Dec 2023 06:34:49 -0500
X-MC-Unique: B9NAYgWjPBqo2Zc7OrdLLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2B8885A589;
 Fri,  8 Dec 2023 11:34:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA1692166B35;
 Fri,  8 Dec 2023 11:34:47 +0000 (UTC)
Date: Fri, 8 Dec 2023 11:34:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Young <m.a.young@durham.ac.uk>, qemu-devel@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH] fix qemu build with xen-4.18.0
Message-ID: <ZXL_VWhSsTG8Sugj@redhat.com>
References: <277e21fc78b75ec459efc7f5fde628a0222c63b0.1701989261.git.m.a.young@durham.ac.uk>
 <ZXLg_YCHM-P6drQV@redhat.com>
 <CAFEAcA8HXWEPbx2fKEg_kscdEnNpGCJVO9jqgD1YDpULYp_yDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8HXWEPbx2fKEg_kscdEnNpGCJVO9jqgD1YDpULYp_yDw@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Dec 08, 2023 at 10:59:03AM +0000, Peter Maydell wrote:
> On Fri, 8 Dec 2023 at 09:25, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > CC'ing the Xen folks
> >
> > On Thu, Dec 07, 2023 at 11:12:48PM +0000, Michael Young wrote:
> > > diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
> > > index 6f09c48823..04b1ef4d34 100644
> > > --- a/include/hw/xen/xen_native.h
> > > +++ b/include/hw/xen/xen_native.h
> > > @@ -532,7 +532,7 @@ static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
> > >  }
> > >  #endif
> > >
> > > -#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41700
> > > +#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 41700
> >
> > This change is not correct
> >
> > We can see the upstream change was introduced in 4.17:
> >
> >   $ git describe  2128143c114
> >   4.16.0-rc4-967-g2128143c11
> >
> > IOW, if we have 4.17 or newer these constants already
> > exist. If we have 4.16 or older, then we need to define
> > them to provide back compat.
> 
> Wouldn't that suggest we want "< 41700" ? Or did 4.17 have
> some issue that means we need the back-compat there too?

Oh yes, and if we change it from '<=' to '<', then we get the same
build problem for  qemu-system-aarch64 on x86_64 host, when built
against xen-devel 4.17, which is what I'd expect.

So our accident <= instead of < has masked the pre-existing flaw.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


