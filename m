Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 656B2761EB9
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 18:39:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOL3W-0002cC-K5; Tue, 25 Jul 2023 12:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOL3R-0002ZS-HI
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOL3N-0006ST-73
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690303108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IzTnFezmduXy5PxftTjyKolAi1O3STVU3EgCWv/uKnA=;
 b=eaGZ4sKRaUXtGgPerbcZVQcepS9Wrfojk8vtehLuKHeBboXu4c/eZuCpiBlXEDEIQ0AffV
 uvXEGUut1c8fp2MUPinmX7gH7WiJSH8Q5pj8wwcdyClBpxqHxldUJ6es+BSoPjGE/ymwRo
 yfSEm52tjBBN3618z9T6ccQCmOIDMPI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-4bjqmrIcMFyqeH6sqw87VQ-1; Tue, 25 Jul 2023 12:38:26 -0400
X-MC-Unique: 4bjqmrIcMFyqeH6sqw87VQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-767c4cc8d84so113530885a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 09:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690303106; x=1690907906;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IzTnFezmduXy5PxftTjyKolAi1O3STVU3EgCWv/uKnA=;
 b=dFXwCsYe0b921vywPvGzYvLHarNFTdaEebnC2hKFbUJAOTuQss81X7FgiRqsWNt1iG
 QCW8cTGnTsYCR5egeulsJeYUW9VYSDEO0mVFaluFpgO8X81dBhMfFTvZlENZLAw0korh
 TY2UqrkqIzE0lF5yY3nj+u1427hY8Q8g//owh8TNsHuYFqhL7rAQyWEErjkRRP1+rbvm
 f8yRH2oDCWQ/GutoU3PN9RN6rRx+0IA0I3qlhmi1acrqSSx2qeW3pQmQcXLNOFqgz/xz
 Fg/06lkNPJ1tg1aZUrEd2JqOlQm/Zv6tt+Aufu+e87z+G9SCq4mhMcJnr4q/lubqjpQI
 kvHA==
X-Gm-Message-State: ABy/qLZz1To8nI84PAUWkBNxCZQ+vUCx8yJOixj3yhEBa24Z6dF1V2Tm
 TYreW9ibv1cGLe0aibuWy3OdhrYtUIhcpFbyeMZZCYNIglxXy8VbInAUCB4lnB4oLGi4um52juo
 WfStM1EJcaWOiAKw=
X-Received: by 2002:a05:620a:2545:b0:767:e5ae:85cf with SMTP id
 s5-20020a05620a254500b00767e5ae85cfmr13834666qko.5.1690303106047; 
 Tue, 25 Jul 2023 09:38:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE2eXsMQ4IAKelzZHWDLgSxEd6x2W9LLAEp8asCeCzFXxGRrEVEpPsyfte0/zm+HXk3QiH4iw==
X-Received: by 2002:a05:620a:2545:b0:767:e5ae:85cf with SMTP id
 s5-20020a05620a254500b00767e5ae85cfmr13834649qko.5.1690303105721; 
 Tue, 25 Jul 2023 09:38:25 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w11-20020ae9e50b000000b00767721aebc0sm3799658qkf.32.2023.07.25.09.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 09:38:25 -0700 (PDT)
Date: Tue, 25 Jul 2023 12:38:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
Message-ID: <ZL/6f7nNLw+iVHYL@x1n>
References: <20230724170755.1114519-1-peterx@redhat.com>
 <ZL69LTVHhNzEjqGM@redhat.com> <ZL7VZsaFxkIq4+cP@x1n>
 <ZL+TBBtL+RiMrOXJ@redhat.com> <ZL/wTBP/7ZdM9Xd4@x1n>
 <ZL/z1e/VATzZN10E@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZL/z1e/VATzZN10E@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jul 25, 2023 at 05:09:57PM +0100, Daniel P. Berrangé wrote:
> On Tue, Jul 25, 2023 at 11:54:52AM -0400, Peter Xu wrote:
> > We can make the semantics specific, no strong opinion here.  I wished it
> > can be as generic / easy as possible but maybe I went too far.
> > 
> > Though, is there anything else we can choose from besides
> > "max-convergence-bandwidth"? Or am I the only one that thinks it's hard to
> > understand when put "max" and "convergence" together?
> > 
> > When I take one step back to look at the whole "bandwidth" parameters, I am
> > not sure why we'd even need both "convergence" and "postcopy" bandwidth
> > being separate.  With my current understanding of migration, we may
> > actually need:
> > 
> >   - One bandwidth that we may want to run the background migration, aka,
> >     precopy migration, where we don't rush on pushing data.
> > 
> >   - One bandwidth that is whatever we can have maximum; for dedicated NIC
> >     that's the line speed.  We should always use this full speed for
> >     important things.  I'd say postcopy falls into this, and this
> >     "convergence" calculation should also rely on this.
> 
> I don't think postcopy should be assumed to run at line speed.
> 
> At the point where you flip to post-copy mode, there could
> conceivably still be GB's worth of data still dirty and
> pending transfer.
> 
> The migration convergance step is reasonable to put at line
> speed, because the max downtime parameter caps how long this
> burst will be, genrally to some fraction of a second.
> 
> Once in post-copy mode, while the remaining data to transfer
> is finite, the wall clock time to complete that transfer may
> still be huge. It is unreasonable to assume users want to
> run at max linespeed for many minutes to finish post-copy
> at least in terms of the background transfer. You could make
> a  case for the page fault handling to run at a higher bandwidth
> cap than the background transfer, but I think it is still probably
> not reasonable to run page fault fetches at line speed by default.
> 
> IOW, I don't think we can put the same bandwidth limit on the
> short convergance operation, as on the longer post-copy operation.

Postcopy still heavily affects the performance of the VM for the whole
duration, and afaiu that's so far the major issue (after we fix postcopy
interruptions with recovery capability) that postcopy may not be wanted in
many cases.

If I am the admin I'd want it to run at full speed even if the pages were
not directly requested just to shrink the duration of postcopy; I'd just
want to make sure requested pages are queued sooner.

But that's okay if any of us still thinks that three values would be
helpful here, because we can simply have the latter two having the same
value when we want.  Three is the superset of two anyway.

I see you used "convergance" explicitly even after PeterM's reply, is that
what you prefer over "convergence"?  I do see more occurances of
"convergence" as a word in migration context, though.  Any better name you
can come up with, before I just go with "max-convergence-bandwidth" (I
really cannot come up with anything better than this or available-bandwidth
for now)?

Thanks,

-- 
Peter Xu


