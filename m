Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 596788294DB
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 09:11:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNTfI-0005hd-E5; Wed, 10 Jan 2024 03:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNTf6-0005fJ-M4
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:10:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNTf3-000722-9T
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704874199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HC1mmrR/hNPTO8t9wijLNFaNcSLwsWEDAclfCoIYZ8=;
 b=Kre2d7q0pT6vd81cIZKg0AbqgFBveh1Z+QJR+uvgRnhjcRiuiJId5mXGQMYISemWPTbYYK
 zXHGbGozP4Yy5KVzEASeb800nLdlaoM2aRWIAazMAHxTwIguVbmgluix8+pDni/Be0sVS/
 xb+I2yIC/mp9CMhJ/hPlmtrILafQgYU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-QaRung1SOSueSZ8ZBTGplQ-1; Wed, 10 Jan 2024 03:09:55 -0500
X-MC-Unique: QaRung1SOSueSZ8ZBTGplQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB91B185A782;
 Wed, 10 Jan 2024 08:09:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 013BDC15E6A;
 Wed, 10 Jan 2024 08:09:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ECCC921E6806; Wed, 10 Jan 2024 09:09:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Fabiano Rosas
 <farosas@suse.de>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Tyrone Ting <kfting@nuvoton.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 Joel Stanley <joel@jms.id.au>,  Alistair Francis
 <alistair@alistair23.me>,  Anton Johansson <anjo@rev.ng>,  Andrey Smirnov
 <andrew.smirnov@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Hao Wu <wuhaotsh@google.com>,  Jean-Christophe Dubois
 <jcd@tribudubois.net>,  Igor Mitsyanko <i.mitsyanko@gmail.com>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
In-Reply-To: <ZZ44iQRPrdDpfov7@x1n> (Peter Xu's message of "Wed, 10 Jan 2024
 14:26:17 +0800")
References: <38cfa9de-874b-41dd-873e-5ad1f5a5805e@kaod.org>
 <fe4d463f-b646-4b7b-9063-d16ad5dbb128@linaro.org>
 <87y1d6i47m.fsf@suse.de>
 <597186d9-af21-46e8-8075-f21d36c01c07@kaod.org>
 <87plya76cu.fsf@suse.de>
 <d5c0b9fb-8b09-4f68-b3ab-c8adffd484a9@kaod.org>
 <87bk9u8dhs.fsf@suse.de>
 <2fa344b7-ccd2-4e6a-8c32-5ad7e4c960d6@linaro.org>
 <ZZ4Qrfis4XHWGN0j@x1n> <87cyu9hgit.fsf@pond.sub.org>
 <ZZ44iQRPrdDpfov7@x1n>
Date: Wed, 10 Jan 2024 09:09:51 +0100
Message-ID: <87sf35ehio.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Jan 10, 2024 at 07:03:06AM +0100, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > On Tue, Jan 09, 2024 at 10:22:31PM +0100, Philippe Mathieu-Daud=C3=A9 =
wrote:
>> >> Hi Fabiano,
>> >>=20
>> >> On 9/1/24 21:21, Fabiano Rosas wrote:

[...]

>> >> > No one wants
>> >> > to be policing QOM hierarchy changes in every single series that sh=
ows
>> >> > up on the list.
>> >> >=20
>> >> > Anyway, thanks for the pointers. I'll study that code a bit more, m=
aybe
>> >> > I can come up with some way to handle these cases.
>> >> >=20
>> >> > Hopefully between the analyze-migration test and the compat tests w=
e'll
>> >> > catch the next bug of this kind before it gets merged.
>> >
>> > Things like that might be able to be detected via vmstate-static-check=
er.py.
>> > But I'm not 100% sure, also its coverage is limited.
>> >
>> > For example, I don't think it can detect changes to objects that will =
only
>> > be created dynamically, e.g., I think sometimes we create objects after
>> > some guest behaviors (consider guest enables the device, then QEMU
>> > emulation creates some objects on demand of device setup?),
>>=20
>> Feels nuts to me.
>>=20
>> In real hardware, software enabling a device that is disabled by default
>> doesn't create the device.  The device is always there, it just happens
>> to be inactive unless enabled.  We should model the device just like
>> that.
>
> It doesn't need to be the device itself to be dynamically created, but so=
me
> other sub-objects that do not require to exist until the device is enable=
d,
> or some specific function of that device is enabled.  It is logically doa=
ble.
>
> Is the example Cedric provided looks like some case like this?  I am not
> sure, that's also why I'm not sure the static checker would work here.  B=
ut
> logically it seems possible, e.g. with migration VMSD needed() facilities.
> Consider a device has a sub-function that requires a sub-object.  It may
> not need to migrate that object if that sub-feature is not even enabled.
> If that object is very large, it might be wise to do so if possible to not
> send chunks of junk during the VM downtime.
>
> But then after a 2nd thought I do agree it's probably not sensible, becau=
se
> even if the src may know whether the sub-object will be needed, there's
> probably no good way for the dest QEMU to know.  It can only know in
> something like a post_load() hook, but logically that can happen only aft=
er
> a full load of that device state, so might already be too late.
>
> Thanks,

If an object has state that needs to be migrated only sometimes, and
that part of the state is large enough to bother, we can put it in an
optional subsection, can't we?

Destination: if present, take it.  If absent, initialize to default.

Source: send unless (known to be) in default state.


