Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FFC79A2BD
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 07:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfZGV-0006Bv-T3; Mon, 11 Sep 2023 01:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qfZGU-0006BR-08
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 01:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qfZGQ-00061B-0D
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 01:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694409307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNbxxBqnkoojh1Dbq6zLoTMIBuRK++76eXar4F+n9gc=;
 b=Ibsc6RkekTSqHdDeWkp8EnjzaJA5imTb3qbSUasXQ/7yLBDbtvBTfCM62V0oS35KrldxmY
 98b6s93EqLyjp8P+IKJOao0FKN9bHkJT+yzPlyvGE7heP6jDV3xcLwBJgpptFM8hojyeGk
 7m60NXUK9wJcZgNBzCnVaSViOziRcMQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-2LiqmCZ6MA-5kuGdvTojbA-1; Mon, 11 Sep 2023 01:15:02 -0400
X-MC-Unique: 2LiqmCZ6MA-5kuGdvTojbA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 533E2181A6E0;
 Mon, 11 Sep 2023 05:15:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C04F76B595;
 Mon, 11 Sep 2023 05:15:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9E06D21E66D2; Mon, 11 Sep 2023 07:15:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  laurent@vivier.eu,
 qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Peter
 Maydell <peter.maydell@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 10/21] q800: add easc bool machine class property to
 switch between ASC and EASC
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-11-mark.cave-ayland@ilande.co.uk>
 <e3fe143f-2c07-2d59-3dca-4534a767391d@linaro.org>
 <f639b4b1-965a-fe9d-a988-2dbd2c1c0e68@ilande.co.uk>
 <44e50cdb-37f0-c18d-4d64-0f34777a193d@linaro.org>
Date: Mon, 11 Sep 2023 07:15:00 +0200
In-Reply-To: <44e50cdb-37f0-c18d-4d64-0f34777a193d@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 8 Sep 2023 11:42:53
 +0200")
Message-ID: <87ledd1eaz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 8/9/23 08:54, Mark Cave-Ayland wrote:
>> On 07/07/2023 09:29, Philippe Mathieu-Daud=C3=A9 wrote:
>>=20
>>> On 2/7/23 17:48, Mark Cave-Ayland wrote:
>>>> This determines whether the Apple Sound Chip (ASC) is set to enhanced =
mode
>>>> (default) or to original mode. The real Q800 hardware used an EASC chi=
p however
>>>> a lot of older software only works with the older ASC chip.
>>>>
>>>> Adding this as a machine parameter allows QEMU to be used as an develo=
per aid
>>>> for testing and migrating code from ASC to EASC.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> ---
>>>> =C2=A0 hw/m68k/q800.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 30 +++++++++++++++++++++++++++++-
>>>> =C2=A0 include/hw/m68k/q800.h |=C2=A0 1 +
>>>> =C2=A0 2 files changed, 30 insertions(+), 1 deletion(-)
>>>
>>>
>>>> +static bool q800_get_easc(Object *obj, Error **errp)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 Q800MachineState *ms =3D Q800_MACHINE(obj);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return ms->easc;
>>>> +}
>>>
>>> Is the getter useful? Otherwise:
>> Isn't it a requirement? Otherwise I can see that if we decide to enumera=
te machine properties (similar as to how device properties appear in "info =
qtree") then it would be impossible to display its value. Certainly at the =
moment we consider that adding an object property to an underlying struct e=
ffectively makes it "public".
>
> Just FYI this is not a requirement, per "qom/object.h":
>
>   /**
>    * object_property_add_bool:
>    * @obj: the object to add a property to
>    * @name: the name of the property
>    * @get: the getter or NULL if the property is write-only.
>    * @set: the setter or NULL if the property is read-only
>
> I'm not sure when we want a write-only QOM boolean property, so I
> genuinely ask, since I agree introspecting QOM object fields from
> the monitor is helpful.

I suspect write-only properties came out of QOM's generality curse.  Do
we have even one?  QOM's design makes this somewhat to tell.


