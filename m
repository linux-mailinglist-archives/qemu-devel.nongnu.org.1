Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F13788274D8
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 17:17:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMsIO-00022d-K5; Mon, 08 Jan 2024 11:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rMsI4-00021J-PM
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:15:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rMsI1-000661-Q4
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704730548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtJkDedwDHeF/y7ha9RF4keG1FriyOywCLFXDPSGFgg=;
 b=gElPLcuuYDkNTB2+SMovuJX7WetFp5xhDRCpcSuPE7z01aheGb1n3a6qJZX7BBk4B55SaY
 i78lZ2yk2DEHvjXg40z3tH0fAx9/TdQIkeog3WpqHdspw2b/OWzFIYtF8ndmR1dAKjmIy/
 QfV5jKkybJCb2W+y+JO68v7bfROnIoU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-Ecuw40gPNEulI4lE6Z1Pvg-1; Mon, 08 Jan 2024 11:15:45 -0500
X-MC-Unique: Ecuw40gPNEulI4lE6Z1Pvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEEBE85A589;
 Mon,  8 Jan 2024 16:15:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC9045191;
 Mon,  8 Jan 2024 16:15:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A24AA21E680D; Mon,  8 Jan 2024 17:15:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: inesvarhol <inesvarhol@proton.me>,  =?utf-8?Q?In=C3=A8s?= Varhol
 <ines.varhol@telecom-paris.fr>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Peter Maydell
 <peter.maydell@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,  Paolo
 Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Alistair Francis
 <alistair@alistair23.me>,  Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v5 2/3] tests/qtest: Add STM32L4x5 EXTI QTest testcase
In-Reply-To: <805ca196-5464-4023-a1c1-97d5a6699c1b@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 5 Jan 2024 11:19:12
 +0100")
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-3-ines.varhol@telecom-paris.fr>
 <61fd13b3-7cc9-4e27-bf91-bd2b4aedf97b@linaro.org>
 <ZjC6phtwjcDoQP-NDP6GF-dvCVK8Ctk9EeW_JezuNBqnQq4-V6NU6eAhECMqxJzMDRxwjbb-LPcHTvysc6YGuLD7ckWhbtpqD1g9lnklofI=@proton.me>
 <5f624a13-0ba0-4d9a-8910-2ef1c784a295@linaro.org>
 <805ca196-5464-4023-a1c1-97d5a6699c1b@linaro.org>
Date: Mon, 08 Jan 2024 17:15:43 +0100
Message-ID: <87v883by34.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 5/1/24 11:13, Philippe Mathieu-Daud=C3=A9 wrote:
>> (+Mark & Eduardo)
>> On 4/1/24 14:37, inesvarhol wrote:
>>>
>>> Le jeudi 4 janvier 2024 =C3=A0 14:05, Philippe Mathieu-Daud=C3=A9 <phil=
md@linaro.org> a =C3=A9crit=C2=A0:
>>>
>>> Hello,
>>>
>>>>> +static void test_edge_selector(void)
>>>>> +{
>>>>> + enable_nvic_irq(EXTI0_IRQ);
>>>>> +
>>>>> + / Configure EXTI line 0 irq on rising edge */
>>>>> + qtest_set_irq_in(global_qtest, "/machine/unattached/device[0]/exti",
>>>>
>>>>
>>>> Markus, this qtest use seems to expect some stability in QOM path...
>>>>
>>>> In=C3=A8s, Arnaud, having the SoC unattached is dubious, it belongs to
>>>> the machine.
>>>
>>> Noted, we will fix that.
>>> Should we be concerned about the "stability in QOM path" ?
>>
>> Don't worry about this In=C3=A8s, I wanted to raise Markus attention on =
this.
>>
>> You showed a legit use of stable QOM path, and Markus told me recently
>> there is no contract for QOM paths (it shouldn't be considered as a
>> stable API). IIRC Markus explanation, "/unattached" container was
>> added as a temporary hack to allow migrating QDev objects to QOM (see
>> around commit da57febfed "qdev: give all devices a canonical path",
>> 11 years ago).

I'm not sure the hack was intended to be temporary.  Doesn't matter now.

The connection between parent and child is a child property of the
parent.  Like all properties, it has a name.  These names are the
components of the canonical path.

When the code that creates the child makes the connection, it can give
the property a sensible name.

When it doesn't, we sometimes do it in generic code, using the
/machine/unattached orphanage, and a name that contains a counter, like

    /machine/unattached/device[N]
    /machine/unattached/non-qdev-gpio[N]

The actual name depends on execution order, because the counter value
does.  Brittle.

> Hmm am I getting confused with "/peripheral-anon" (commit 8eb02831af
> "dev: add an anonymous peripheral container")?

Not the same, but related.  Devices added with -device / device_add go
into /machine/peripheral/ID when they have id=3DID, else into
/machine/peripheral/anon/device[N].  Before the commit you quoted, the
latter were orphaned I believe.

>> I agree anything under "/unattached" can be expected to be stable
>> (but we need a community consensus). Then the big question remaining
>> is "can any qom-path out of /unattached be considered stable?"

Backwards?  Keeping /machine/unattached/FOO[N] stable is harder then the
paths the code picks explicitly.


