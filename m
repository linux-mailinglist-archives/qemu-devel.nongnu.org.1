Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C488B5AD8
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Apr 2024 16:03:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Rab-0002Bf-1O; Mon, 29 Apr 2024 10:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1RaZ-0002BX-6a
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1RaW-0005ZH-Vv
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714399355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhHwTMeuLgn8YWXUwPdpVnY0QjCwRoSzG6U+J1nWd9Y=;
 b=ElWXRyilGxMyWO8uIiOT4ciJfybk0xJcDvhbANwDAp/23RDqFi1/A62U2cpmYtGSgYHAYH
 H8LGmCOZdQeg5vNSgsId5QBWi/YAJXVWUPJKG/yh+v9ugOh2ApgEwwFfFLms/A1IlgfRls
 56Nd2BiRtW4y/vlmQit/lJqdPVlvi5Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-llG11ZM7NLCgveYwLFgBQA-1; Mon, 29 Apr 2024 10:02:32 -0400
X-MC-Unique: llG11ZM7NLCgveYwLFgBQA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADA7C8FDD28;
 Mon, 29 Apr 2024 14:02:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B2A31C060D1;
 Mon, 29 Apr 2024 14:02:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7AEDA21E66E5; Mon, 29 Apr 2024 16:02:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-devel@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] mc146818rtc: add a way to generate RTC interrupts via QMP
In-Reply-To: <40bee8cc-6cad-4c5b-a319-49dcbb2b82f1@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 29 Apr 2024 15:39:57
 +0200")
References: <20240425133745.464091-1-d-tatianin@yandex-team.ru>
 <87v844y0ul.fsf@pond.sub.org>
 <11c78645-e87b-4a43-8191-a73540c364a9@linaro.org>
 <87plu8ieut.fsf@pond.sub.org>
 <40bee8cc-6cad-4c5b-a319-49dcbb2b82f1@linaro.org>
Date: Mon, 29 Apr 2024 16:02:16 +0200
Message-ID: <87zftcfes7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> (+Peter who has more experience on such design).
>
> On 29/4/24 13:32, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

[...]

>>> IMO to avoid any future ambiguity (in heterogeneous machines), this
>>> command must take a QOM device path (or a list of) and only notify
>>> those.
>>=20
>> Let's compare:
>>=20
>> =E2=80=A2 With QOM path:
>>=20
>>    =C2=B7 You need to know the machine's RTC device(s).
>>=20
>>      Unfortunately, this is bothersome, as the QOM path is not stable.
>
> But we'll need more of that with dynamic machines...

I view /machine/unattached a technical debt (see "hate" right below).

It saved us the trouble of coming up with sensible names for onboard
devices.

And now the interest is about to be due.

>>      For Q35, it's generally "/machine/unattached/device[N]/rtc", but N
>>      varies with configuration (TCG N=3D2, KVM N=3D3 for me), and it mig=
ht
>>      vary with machine type version.  That's because the machine code
>>      creates ICH9-LPC without a proper name.  We do that a lot.  I hate
>>      it.
>>=20
>>      Likewise for i440FX with PIIX3 instead of ICH9-LPC.
>>=20
>>      For isapc, it's /machine/unattached/device[3].  I suspect the 3
>>      isn't reliable there, either.
>>=20
>>      microvm doesn't seem to have an RTC by default.

[...]


