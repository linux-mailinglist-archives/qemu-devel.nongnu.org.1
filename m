Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 671C194BC40
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Aug 2024 13:25:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc1FL-0000Do-Os; Thu, 08 Aug 2024 07:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc1FA-0000Bi-72
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc1F8-0004CX-86
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723116219;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ktQgG7j4gPl1x9yeyA1FOm/APy/ixeU6Pdcr3oq6LAA=;
 b=AYMUcYbsXzNaiXDlUtJB4yTVzyI018oXtkf1kF0fFnu2yIoxL4eYb3PVbm/Wd2MZSd9Kcg
 S4EJpLhUtHBiuXUFu2LQ2ZuBqL7K7SU6J1ytEA3duTBVGsBOryqWl4KlM+u0xEuHolEV5b
 Rqxh/or9AZAExN363Z8WdaPkA1HQQB4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-vKCvuRX6MAGYT_-gLsW_AQ-1; Thu,
 08 Aug 2024 07:23:36 -0400
X-MC-Unique: vKCvuRX6MAGYT_-gLsW_AQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D4AE195419F; Thu,  8 Aug 2024 11:23:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38596300018D; Thu,  8 Aug 2024 11:23:31 +0000 (UTC)
Date: Thu, 8 Aug 2024 12:23:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH-for-9.1? 1/2] target/arm: Move
 qmp_query_gic_capabilities() to hw/intc/
Message-ID: <ZrSqsEedC3rmVbD9@redhat.com>
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-2-philmd@linaro.org>
 <f82397e9-3be4-49be-b291-5598acdaf39b@linaro.org>
 <CAFEAcA9emwsK07+itUzMxReOLG8gHaxNdDE8ymuwyuBfsoY2Pg@mail.gmail.com>
 <87bk23skhq.fsf@pond.sub.org>
 <CAFEAcA8J4i-81rOEHBpqbV=c4F26o6qd3Lg9dZV+BuNyZPGg7Q@mail.gmail.com>
 <87ed6z1j77.fsf@pond.sub.org>
 <CAFEAcA_=GYBGpbvfKMGsYrUKWgcTLrriBKd37jOVFV1YMfy8Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_=GYBGpbvfKMGsYrUKWgcTLrriBKd37jOVFV1YMfy8Mw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 08, 2024 at 11:15:17AM +0100, Peter Maydell wrote:
> On Thu, 8 Aug 2024 at 10:02, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > > On Thu, 8 Aug 2024 at 05:32, Markus Armbruster <armbru@redhat.com> wrote:
> > >>
> > >> Peter Maydell <peter.maydell@linaro.org> writes:
> > >>
> > >> [...]
> > >>
> > >> > The QAPI command which this code is implementing is
> > >> > also (a) target-specific and (b) unfortunately
> > >> > designed so that it doesn't get passed a particular
> > >> > CPU or particular device to query, it's just assumed
> > >> > to be a part of the whole simulation.
> > >>
> > >> We can fix (b) if we care: add a suitable optional argument, default to
> > >> the sole GIC in the system, fail if there's more than one.  I assume we
> > >> have no machines with more than one now.
> > >
> > > The exynos4210 SoC (board types 'nuri', 'smdkc210') has
> > > two GICs. (It's a rather odd design -- there's the
> > > interrupt controller that's part of the main CPU
> > > cluster, and then they used a second "external" GIC
> > > that feeds into that one.)
> >
> > Then "fail if there's more than one" would be an incompatible change for
> > this machine.
> >
> > If the two GICs have identical capabilities, it doesn't matter to which
> > of the two query-gic-capabilities technically applies.
> >
> > Else, it matters, and we have an interface issue.  Do we?
> 
> It's not possible to use KVM with that machine type, so the
> question is a bit moot. (This also indicates that the
> interface is not very helpful -- it purports to tell the
> management layer whether it can use an accelerated in-kernel
> GIC, but because it doesn't specifiy the board type there's
> no way to provide an accurate answer. It would be useful
> to know exactly what libvirt/etc actually use this for...)

Libvirt uses this exclusively with the arm 'virt' machine type.

If the user didn't express any GIC preference, then if KVM is in use,
we'll pick the highest GIC version QEMU reports as supported. If TGCG
is in use we'll always pick v2, even if QEMU reports v3 is emulatable
due to the v3 impl lacking MSI controller which we need for PCI-e

  https://gitlab.com/libvirt/libvirt/-/blob/master/src/qemu/qemu_domain.c#L4456

We'll also report to mgmt apps what GIC versions are available.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


