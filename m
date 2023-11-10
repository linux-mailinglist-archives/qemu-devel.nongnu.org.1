Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8877E7A7B
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 10:11:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1NXL-0007TG-QE; Fri, 10 Nov 2023 04:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1NXJ-0007SV-83
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:10:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1NXH-0001Rz-Jq
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 04:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699607442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WkXYyOz6KUXXh6+ps/WE0RZqlCy3Hj7YMRK38k9LQOQ=;
 b=cO5bzyWG4m0UomGSDub5nMGYSR/NhbW4+Il9TZMs/t93z811ieeSQ0VCUrkF0FQB3eaUxc
 F50K88VrkX+CGMJgsWWxBoxMedk4De++R3R9F/52gZ3N6pmFA1TZ03RSTA4jnQjhq+rt64
 8fW0qf5F7mvUCnCNqcdbcvFtNId79UE=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-JQpEDxoPOgeKtVYZMAQc5w-1; Fri, 10 Nov 2023 04:10:40 -0500
X-MC-Unique: JQpEDxoPOgeKtVYZMAQc5w-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7b9b2b08b42so2358113241.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 01:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699607440; x=1700212240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WkXYyOz6KUXXh6+ps/WE0RZqlCy3Hj7YMRK38k9LQOQ=;
 b=QaaTyUwbJXTAOmFrUSQtCB70DBal+heEtmkbhEmz6I6G+pddqR6AQBTiDoW4ShZECA
 2nATTZ5hc4mSj9Nu2I1BEtZHK6Vsx7TXR3kFovB/kxRz2ULzdffeXik3c8sACQsGTMQF
 6ySLiT4arrJuHlW1Q0QtblsbBt/zUTIyS1ILE1fTU58vkkHd5EGE7NyhuGDwlVr0eJRj
 eY9Me7Cz531hI5GOQZYvqNnV8ITxRVNSVNRWGFeEYcs/uUkPzHrfaZ8rEuQulIrk+mvC
 03gY7xxtXLO2M6UmsGHHURAN1PNg0WXmXOWvPjgc5yz+4z9tUoXrACGjnQ+vRFFOPCqO
 Sd8Q==
X-Gm-Message-State: AOJu0YygvagZmspMFc+GQlEbC1HRoe0e5IVeuIA6FKDPz3Mv/ct9salt
 /O9lYh04L4g6Nt55udU6wgpbUeA71XYnAsAh8SEo/kukjGiDA3Rr9oLJZcIXHRcr1oKcqZ3AtMe
 E3DssXqdBpXT3Vaa5iNGPreocq6lHYL0=
X-Received: by 2002:a05:6102:5587:b0:455:f04d:7b64 with SMTP id
 dc7-20020a056102558700b00455f04d7b64mr1037095vsb.8.1699607440370; 
 Fri, 10 Nov 2023 01:10:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbe2F8Xq042C3532u4p52vvyaYzdwqoEHRM6fIpQVgWgu9F5d6Bu29VyJ6UtAJ6NIXaGH9E0UhpdAAHVQ6qtw=
X-Received: by 2002:a05:6102:5587:b0:455:f04d:7b64 with SMTP id
 dc7-20020a056102558700b00455f04d7b64mr1037088vsb.8.1699607440126; Fri, 10 Nov
 2023 01:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20231109155855.844630-1-pbonzini@redhat.com>
 <CAFn=p-YZ=sMJ0=C71wX1x6NXcK8rSZfVO+f3TQQExADGJhEJdg@mail.gmail.com>
 <CAFn=p-YB9QawiXd2newm1itooNpnU_4QY29zC2aFp2mN4beTHg@mail.gmail.com>
In-Reply-To: <CAFn=p-YB9QawiXd2newm1itooNpnU_4QY29zC2aFp2mN4beTHg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 Nov 2023 10:10:27 +0100
Message-ID: <CABgObfZddB2cTe2Ka9kh9rRYn1zkJQJcGiVZXMTF1cod=9tCyA@mail.gmail.com>
Subject: Re: [PATCH] docs: document what configure does with virtual
 environments
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Nov 9, 2023 at 10:35=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
> > > +The venv resides in the ``pyvenv`` directory in the build tree,
> > > +and provides consistency in how the build process runs Python code.
> > > +In particular it avoids a potential mismatch, where Meson and Sphinx
> >
> > I think you can drop the comma. This is so pedantic that if you left
> > it in to spite me, I'd not blame you. :)

I'll keep it then. :)

> > should we say ``--sphinx-build``?

Yes, typo.

> > I also might say "does not ^necessarily pick the ..." because they
> > could be the same, it just isn't the criteria it uses to choose them.

I'll replace "pick" with "look for".

> > > +If QEMU does not find a dependency, check that it was installed in t=
he
> > > +right ``site-packages`` directory or with the right ``pip`` program.
> >
> > I don't actually know what this means. >_>

It's meant to explain what happened with homebrew. Rephrased in v2:

This avoids a potential mismatch, where Meson and Sphinx binaries on the
PATH might operate in a different Python environment than the one chosen
by the user during the build process.  On the other hand, it introduces
a potential source of confusion where the user installs a dependency but
``configure`` is not able to find it.  When this happens, the dependency
was installed in the ``site-packages`` directory of another interpreter,
or with the wrong ``pip`` program.

Paolo


