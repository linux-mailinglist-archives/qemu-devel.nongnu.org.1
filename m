Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1732B94BC99
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Aug 2024 13:55:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc1iZ-0008Cw-Mm; Thu, 08 Aug 2024 07:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc1iY-0008B0-0f
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sc1iW-0000AB-5Q
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723118042;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LliZeF9//nODySI40QD/AChiQPaPnchmIz31scbPlIg=;
 b=KD8HH0UZ6ORkSYCk9dHN8t48d44BMUoF0c8KIjgq/jn73xHkBWOsPA2aJkp4vB6CdW58AJ
 iqAKMRjHb9ZMsjHEiJuOZKUxgTSQjShkqEQGnqNbRF/NxCZC3rb4cMoEaRCoW1+4W71R+c
 oLCf29SRHAjQjGkHUIwN0XMbxUR8H+s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-iv60DxAoPhKndKOb76j2dg-1; Thu,
 08 Aug 2024 07:54:00 -0400
X-MC-Unique: iv60DxAoPhKndKOb76j2dg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 182C21874466; Thu,  8 Aug 2024 11:48:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.163])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87F3E195606B; Thu,  8 Aug 2024 11:48:43 +0000 (UTC)
Date: Thu, 8 Aug 2024 12:48:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH-for-9.1? 1/2] target/arm: Move
 qmp_query_gic_capabilities() to hw/intc/
Message-ID: <ZrSwl0VBX4_1Tc71@redhat.com>
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-2-philmd@linaro.org>
 <f82397e9-3be4-49be-b291-5598acdaf39b@linaro.org>
 <CAFEAcA9emwsK07+itUzMxReOLG8gHaxNdDE8ymuwyuBfsoY2Pg@mail.gmail.com>
 <87bk23skhq.fsf@pond.sub.org>
 <CAFEAcA8J4i-81rOEHBpqbV=c4F26o6qd3Lg9dZV+BuNyZPGg7Q@mail.gmail.com>
 <87ed6z1j77.fsf@pond.sub.org>
 <CAFEAcA_=GYBGpbvfKMGsYrUKWgcTLrriBKd37jOVFV1YMfy8Mw@mail.gmail.com>
 <ZrSqsEedC3rmVbD9@redhat.com>
 <CAFEAcA-c7bYaWdOp0ShzUE83kKaYmqoH5DpW+EnU_sVzJgdu4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-c7bYaWdOp0ShzUE83kKaYmqoH5DpW+EnU_sVzJgdu4A@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Thu, Aug 08, 2024 at 12:32:35PM +0100, Peter Maydell wrote:
> On Thu, 8 Aug 2024 at 12:23, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > On Thu, Aug 08, 2024 at 11:15:17AM +0100, Peter Maydell wrote:
> > > It's not possible to use KVM with that machine type, so the
> > > question is a bit moot. (This also indicates that the
> > > interface is not very helpful -- it purports to tell the
> > > management layer whether it can use an accelerated in-kernel
> > > GIC, but because it doesn't specifiy the board type there's
> > > no way to provide an accurate answer. It would be useful
> > > to know exactly what libvirt/etc actually use this for...)
> >
> > Libvirt uses this exclusively with the arm 'virt' machine type.
> >
> > If the user didn't express any GIC preference, then if KVM is in use,
> > we'll pick the highest GIC version QEMU reports as supported.
> 
> You can get that without querying QEMU by asking for 'gic-version=max'
> if you like.

This isn't in the VM startup path. It is when we expand the user
provided XML config into an ABI stable XML config by filling in
the blanks left by the user. So we need to actually query the
values available.

> > If TCG
> > is in use we'll always pick v2, even if QEMU reports v3 is emulatable
> > due to the v3 impl lacking MSI controller which we need for PCI-e
> 
> Our emulated GICv3 supports the ITS which has MSI support, so I'm not
> sure what forcing GICv2 is getting you here. Looking at the linked
> RHEL bugzilla bug, I suspect this is an out-of-date policy from before
> we added the ITS emulation in 2021 (it's present by default
> in virt-2.8 and later machine types). So that is something that
> libvirt should update I think.

It looks like it is virt-6.2 or later, and libvirt can probe it
by looking for existence of the arm-gicv3-its QOM type IIUC.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


