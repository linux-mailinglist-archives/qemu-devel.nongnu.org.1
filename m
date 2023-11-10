Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC047E7BC9
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 12:21:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1PYz-0000Rd-Nt; Fri, 10 Nov 2023 06:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r1PYy-0000Qp-55
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:20:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r1PYw-0004Io-A1
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699615233;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FYEExTG++zZcIiBNOBVw0uzaEZ/hBoydOib+mEuHdPY=;
 b=Guj014MHy5wSfGu9eY2o7GSjkdF3Q3mylxh22rzInH70JuoEMooD1Sa9czKMaEnyArJFFi
 DmwDzgBOfE3fq/1cbnaENnJdpCKM5Powf2TIy4msluWQwFGe14SbJiRd2R6gAgIjuWxvXp
 pKUUGVTr4Wf1EOEp1GDRor1wrDH2Euk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-zXEzkwZcP6eLJ0yDbSTvUA-1; Fri, 10 Nov 2023 06:20:30 -0500
X-MC-Unique: zXEzkwZcP6eLJ0yDbSTvUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5ED1885A58B;
 Fri, 10 Nov 2023 11:20:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34D4B1C060AE;
 Fri, 10 Nov 2023 11:20:29 +0000 (UTC)
Date: Fri, 10 Nov 2023 11:20:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 2/2] Add warn_unused_result attr to AUD_register_card
Message-ID: <ZU4R+08zuo8xvlg8@redhat.com>
References: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
 <4b040fc18cb0e563e92ce084ca18b89a050a8aaa.1699606819.git.manos.pitsidianakis@linaro.org>
 <CAFEAcA80sv6ewJ+LoROn-9ooEyLGQwiqYpL3=fqrK7gA0oZG-A@mail.gmail.com>
 <3wmne.fhuf28sb5yfg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3wmne.fhuf28sb5yfg@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

On Fri, Nov 10, 2023 at 12:44:56PM +0200, Manos Pitsidianakis wrote:
> On Fri, 10 Nov 2023 12:21, Peter Maydell <peter.maydell@linaro.org> wrote:
> > This kind of thing is why Coverity's unused-result warning has a
> > lot of false positives. We shouldn't introduce extra code like
> > this to work around the fact that the tooling doesn't understand
> > our error-handling convention (i.e. error_fatal, and the way
> > that some functions report errors both via the return value and
> > also via the Error** argument).
> 
> I respect that :). But I personally believe that clinging to C's
> inadequacies, instead of preventing bugs statically just because it adds
> some lines of code, is misguided. Proper code should strive to make bugs
> impossible in the first place. At least that is my perspective and I would
> like there to be constructive discussions about different approaches in the
> mailing list. Perhaps something good might come out of it!

Your approach to the problem:

  if (!AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal)) {
    exit(1);
  }

is adding dead-code because the exit(1) will never be reachable. So while
it lets you squelch the unused result warning, it is verbose and misleading
to anyone who sees it.

Perhaps a more viable option is to pull in gnulib's ignore_value macro

  #define ignore_value(x) \
    (__extension__ ({ __typeof__ (x) __x = (x); (void) __x; }))

and then we would have just this:

 ignore_value(AUD_register_card("OMAP EAC", &s->codec.card, &error_fatal));

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


