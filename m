Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A33808251D5
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:25:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhNQ-0007iU-7f; Fri, 05 Jan 2024 05:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLhNL-0007iE-QG
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLhNK-0004K6-7E
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704450265;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44Pwp+PjhFelFbehevxkbvLQtNBmswpxMCXTdBeXr8k=;
 b=EecjRs2BOkaJEzF9dj1J1si29JckkiYUlnLumcyxoVft3nSBUiPGf75KmR1NoXkwRvzQnw
 XjrfytjeEKAb6T6mjMc3kxr2ErFGcSFvgdGrtZ0UG8tePSAcCzegRRyKZuN9Kg0krA+fZh
 0nwKnqAMutnyyi62TcMC5GqTH1xBIkQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-6E-6JjouOIG8lyUotBQOQQ-1; Fri, 05 Jan 2024 05:24:20 -0500
X-MC-Unique: 6E-6JjouOIG8lyUotBQOQQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11AB1101A52A;
 Fri,  5 Jan 2024 10:24:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEC42492BC6;
 Fri,  5 Jan 2024 10:24:17 +0000 (UTC)
Date: Fri, 5 Jan 2024 10:24:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: inesvarhol <inesvarhol@proton.me>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v5 2/3] tests/qtest: Add STM32L4x5 EXTI QTest testcase
Message-ID: <ZZfYvlmcxBCiaeWE@redhat.com>
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-3-ines.varhol@telecom-paris.fr>
 <61fd13b3-7cc9-4e27-bf91-bd2b4aedf97b@linaro.org>
 <ZjC6phtwjcDoQP-NDP6GF-dvCVK8Ctk9EeW_JezuNBqnQq4-V6NU6eAhECMqxJzMDRxwjbb-LPcHTvysc6YGuLD7ckWhbtpqD1g9lnklofI=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjC6phtwjcDoQP-NDP6GF-dvCVK8Ctk9EeW_JezuNBqnQq4-V6NU6eAhECMqxJzMDRxwjbb-LPcHTvysc6YGuLD7ckWhbtpqD1g9lnklofI=@proton.me>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

On Thu, Jan 04, 2024 at 01:37:22PM +0000, inesvarhol wrote:
> 
> Le jeudi 4 janvier 2024 à 14:05, Philippe Mathieu-Daudé <philmd@linaro.org> a écrit :
> 
> Hello,
> 
> > > +static void test_edge_selector(void)
> > > +{
> > > + enable_nvic_irq(EXTI0_IRQ);
> > > +
> > > + / Configure EXTI line 0 irq on rising edge */
> > > + qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
> > 
> > 
> > Markus, this qtest use seems to expect some stability in QOM path...
> > 
> > Inès, Arnaud, having the SoC unattached is dubious, it belongs to
> > the machine.
> 
> Noted, we will fix that. 
> Should we be concerned about the "stability in QOM path" ?

QTest is a functional test harness that intentionally has knowledge
about QEMU internals.

IOW, usage of particular QOM path in qtest does *not* imply that
QOM path needs to be stable.  If QEMU internals change for whatever
reason, it is expected that QTests may need some updates to match.

QOM path stability only matters if there's a mgmt app facing use
case, which requires the app to have hardcoded knowledge of the
path.

Even a mgmt app can use unstable QOM paths, provided it has a way
to dynamically detect the path to be used, instead of hardcoding
it.


None the less, you may still choose to move it out of /unattached
at your discretion.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


