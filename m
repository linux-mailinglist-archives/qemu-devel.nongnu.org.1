Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B047E7BE7
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 12:44:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Pv2-0000bf-3A; Fri, 10 Nov 2023 06:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r1Pv0-0000Zi-0K
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:43:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r1Puy-0001DK-85
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699616599;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRDjhwXQPNA+kVSRNZpHD99Z3R7j3cn2QnEVdGD2Zz4=;
 b=RUTch5ughZTHNFpKKVbEGbz1+K8IqwJDaqa5fX/buSVLmpuiWBhksZJmGNu72dtMIZGXk8
 HWPt33l5sZhmltr9STql0Knu9Hne5ZYQA/LV1Ot1Mizik37OP2ev2H6BOt/qKQa6rtmK7P
 59XJ47/o5b9JxCZsfwam29nzt9r2HiQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-exXiCJa1M82OprgTR86-OQ-1; Fri,
 10 Nov 2023 06:43:17 -0500
X-MC-Unique: exXiCJa1M82OprgTR86-OQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 326AE3C1CC24;
 Fri, 10 Nov 2023 11:43:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7935492BE7;
 Fri, 10 Nov 2023 11:43:15 +0000 (UTC)
Date: Fri, 10 Nov 2023 11:43:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 2/2] Add warn_unused_result attr to AUD_register_card
Message-ID: <ZU4XUqSxQUCKPOG0@redhat.com>
References: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
 <4b040fc18cb0e563e92ce084ca18b89a050a8aaa.1699606819.git.manos.pitsidianakis@linaro.org>
 <CAFEAcA80sv6ewJ+LoROn-9ooEyLGQwiqYpL3=fqrK7gA0oZG-A@mail.gmail.com>
 <3wmne.fhuf28sb5yfg@linaro.org> <ZU4R+08zuo8xvlg8@redhat.com>
 <02562baf-3d92-f5b4-2592-a9d868586451@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02562baf-3d92-f5b4-2592-a9d868586451@eik.bme.hu>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

On Fri, Nov 10, 2023 at 12:35:56PM +0100, BALATON Zoltan wrote:
> On Fri, 10 Nov 2023, Daniel P. Berrangé wrote:
> > On Fri, Nov 10, 2023 at 12:44:56PM +0200, Manos Pitsidianakis wrote:
> > > On Fri, 10 Nov 2023 12:21, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > > This kind of thing is why Coverity's unused-result warning has a
> > > > lot of false positives. We shouldn't introduce extra code like
> > > > this to work around the fact that the tooling doesn't understand
> > > > our error-handling convention (i.e. error_fatal, and the way
> > > > that some functions report errors both via the return value and
> > > > also via the Error** argument).
> > > 
> > > I respect that :). But I personally believe that clinging to C's
> > > inadequacies, instead of preventing bugs statically just because it adds
> > > some lines of code, is misguided. Proper code should strive to make bugs
> > > impossible in the first place. At least that is my perspective and I would
> > > like there to be constructive discussions about different approaches in the
> > > mailing list. Perhaps something good might come out of it!
> > 
> > Your approach to the problem:
> > 
> >  if (!AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal)) {
> >    exit(1);
> >  }
> > 
> > is adding dead-code because the exit(1) will never be reachable. So while
> > it lets you squelch the unused result warning, it is verbose and misleading
> > to anyone who sees it.
> > 
> > Perhaps a more viable option is to pull in gnulib's ignore_value macro
> > 
> >  #define ignore_value(x) \
> >    (__extension__ ({ __typeof__ (x) __x = (x); (void) __x; }))
> > 
> > and then we would have just this:
> > 
> > ignore_value(AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal));
> 
> I wonder if just casting to (void) without assigning to a value could avoid
> the warning? In that case you would not need a macro just
> 
> (void)AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal);

Casting to void is not sufficient, which is why I suggested the
ignore_value macro, which does enough to fool the compiler into
thinking the return value is used.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


