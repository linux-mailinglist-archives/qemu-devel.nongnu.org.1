Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC9B70B95F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 11:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q12AA-0002m7-CT; Mon, 22 May 2023 05:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1q129y-0002k4-Vg
 for qemu-devel@nongnu.org; Mon, 22 May 2023 05:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1q129x-0005HI-8E
 for qemu-devel@nongnu.org; Mon, 22 May 2023 05:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684748924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9oMOJufZiEXaUZLK9IYxvnoC/t0NYLQcfgv5JvlfoY=;
 b=Xa2Rl8PoZTIU08w3WIMisnejFKqJeKeSvf0FZUvHOt7rXmc3hN4qYBQMnhZ/W7YH90rNe8
 06IPMNmXi5RP/AbZjus0mfh8MiebBPYyp8ehkJ5dsevfqCJgpmZrKy21yKZUSQxysUXqEm
 GJL0YtEbOgczvvfwLp13cSJspHWN+8o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-IHQl61GlMP28fS9EY_E1Tw-1; Mon, 22 May 2023 05:48:40 -0400
X-MC-Unique: IHQl61GlMP28fS9EY_E1Tw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E5271C03377;
 Mon, 22 May 2023 09:48:40 +0000 (UTC)
Received: from localhost (unknown [10.39.194.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2191407DEC0;
 Mon, 22 May 2023 09:48:39 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 04/29] arm/kvm: add support for MTE
In-Reply-To: <CAFEAcA9QB4YY5wKBu4eyHvy7yb8PZdvAs+tZaXDEhU+RzY=yKg@mail.gmail.com>
Organization: Red Hat GmbH
References: <20230518125107.146421-1-peter.maydell@linaro.org>
 <20230518125107.146421-5-peter.maydell@linaro.org>
 <878rdklbu2.fsf@linaro.org>
 <CAFEAcA_4ovPWkNw=KNVicD35SzJcQhi4Najt8cS3GSa-TLroKA@mail.gmail.com>
 <CAFEAcA9QB4YY5wKBu4eyHvy7yb8PZdvAs+tZaXDEhU+RzY=yKg@mail.gmail.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 22 May 2023 11:48:38 +0200
Message-ID: <874jo41ytl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 19 2023, Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 19 May 2023 at 14:31, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>>
>> On Fri, 19 May 2023 at 13:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>> >
>> >
>> > Peter Maydell <peter.maydell@linaro.org> writes:
>> >
>> > > From: Cornelia Huck <cohuck@redhat.com>
>> > >
>> > > Extend the 'mte' property for the virt machine to cover KVM as
>> > > well. For KVM, we don't allocate tag memory, but instead enable the
>> > > capability.
>> > >
>> > > If MTE has been enabled, we need to disable migration, as we do not
>> > > yet have a way to migrate the tags as well. Therefore, MTE will stay
>> > > off with KVM unless requested explicitly.
>> > >
>> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> > > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> > > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> > > Message-id: 20230428095533.21747-2-cohuck@redhat.com
>> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> >
>> > I bisected to this commit which causes a segfault on one of my test
>> > kernels (6.3.2 arm64):
>> >
>> >   =E2=9E=9C  ag MTE .config
>> >   486:CONFIG_ARM64_AS_HAS_MTE=3Dy
>> >   487:CONFIG_ARM64_MTE=3Dy
>> >   2949:CONFIG_WLAN_VENDOR_ADMTEK=3Dy
>> >   3573:# CONFIG_I2C_SIMTEC is not set
>> >   5278:# CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
>> >   9749:CONFIG_ARCH_USE_MEMTEST=3Dy
>> >   9750:CONFIG_MEMTEST=3Dy

Sigh, this patch seems to be cursed :( Apologies for the fallout.

(I'm wondering what makes this pop up, maybe the CONFIG_MEMTEST?)

>>
>> Try this entirely untested patch?
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index f6a88e52ac2..f350661a928 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1593,6 +1593,15 @@ static void arm_cpu_realizefn(DeviceState *dev,
>> Error **errp)
>>          }
>>      }
>>
>> +    /*
>> +     * For TCG, we can only present MTE to the guest if the board gave =
us
>> +     * tag RAM. Set has_mte appropriately so code below doesn't need to
>> +     * care whether we're TCG or KVM when deciding if MTE is present.
>> +     */
>> +    if (tcg_enabled() || qtest_enabled()) {
>> +        cpu->has_mte =3D cpu->tag_memory !=3D NULL;
>> +    }
>> +
>>      if (!tcg_enabled() && !qtest_enabled()) {
>>          /*
>>           * We assume that no accelerator except TCG (and the "not reall=
y an
>
> Hmm, actually I don't think that's the only fix needed. It's OK for
> TCG, but for KVM I can't see anywhere in the code that ever sets
> has_mte to false. We default it to on in the cpu.c code, but
> then the board code only sets it to true if MTE is enabled
> (via kvm_arm_enable_mte()).

Hrm, do we need explicit init of this field? Probably needless to say
that I didn't hit this problem in any of my tests... I suspect that only
specific kernels hit this?


