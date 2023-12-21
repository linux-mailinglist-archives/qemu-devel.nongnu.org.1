Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E50081AB8D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 01:11:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG6dV-0003Ac-UA; Wed, 20 Dec 2023 19:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rG6dT-0003AK-Rv
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 19:09:59 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rG6dS-00041u-8h
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 19:09:59 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5918709c630so122941eaf.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 16:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703117396; x=1703722196; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cfWKvMIiKKRXZOewHfx4KxugSPhjjpFLVvEcQjPsug=;
 b=LHRCNp1vhBMUv+w9piCjw7DBVLnaxumJnLO/LXJ1FZbAi7b/K0oSK4BxiS1f8mqFly
 qR3mcZVxdIgasvV9D31YhlMQl22+jCzJNYMqnR7Qr8/J2p+eU9SZqolh7XlA9VyUpgrQ
 xllWoea6Z71c6qwTU5G4rqxqifWqfGc+JqmPQ80K/cHeYKOWhITdH91sfgHJJmZLv65Z
 FJ3lDcg1YcKT+QhIq0JPB46dEv3ixIQYaUyIVFG/AkYkmCflwZFWk9Xz1n4ZuQhiZRem
 5xvGr7pbzcR+mOvjYIljbbj/I+hLN/+6h6KM+hrvDffHP2fG2A6FrAECCMaJbcHQeMQe
 VvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703117396; x=1703722196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+cfWKvMIiKKRXZOewHfx4KxugSPhjjpFLVvEcQjPsug=;
 b=DqJGuUTd3yLaA5Qbe9D6xv3WWGRk8bj20AbM/Sdzm2u2c5RRAwuFhIV1pWIgDprn+n
 J1NkNDPYP6jto5NygyE/5lajmi1PgK9aHmrqUpcuqiSj9pXNAPrN5/I6ADiMY5izr+Pe
 MYrMw2ybJw4uarNueKjFyys+tt6+bkYEWwDmBqfLtYVqENbUSWwCAS070PJKenhnS97H
 freyzRN9iy5fV95Jgk8ExWvGX1d2zfkzdG3MwUOYS9+resVsxJlD3U1v5OplQ5Wbk4vd
 +3w7CLyxxeL/Dn652UOjFEYHaBNxbCrLTbBUoMy0bsvw5GMPe1fm26awA1eCRVIzi2on
 ovFQ==
X-Gm-Message-State: AOJu0Yx0tVoMZYGU5OfnzzCRTvbI+V8pCF79y/zI8XIwTBhhsjNukUdR
 hyFsP/MtJChxeloB9SdN+cDOBomtNQi9ZNquozA=
X-Google-Smtp-Source: AGHT+IFzfnDwfG/oHWWCPPAosSuVWISKlTEsTsmGlh3NUfy4lIQLGCwiQ0LmJifeuORg058/uA9EoVwXpdIsIXdI3RM=
X-Received: by 2002:a05:6820:1687:b0:594:1bb4:93e9 with SMTP id
 bc7-20020a056820168700b005941bb493e9mr533277oob.5.1703117396619; Wed, 20 Dec
 2023 16:09:56 -0800 (PST)
MIME-Version: 1.0
References: <20231220094105.6588-1-thuth@redhat.com>
 <20231220160349.GA843298@fedora> <87msu41nc3.fsf@draig.linaro.org>
In-Reply-To: <87msu41nc3.fsf@draig.linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 20 Dec 2023 19:09:44 -0500
Message-ID: <CAJSP0QXnZe33gsx2HpqN1hu5QQtwUeF4X0uBeKdoh1AzK-oKOA@mail.gmail.com>
Subject: Re: [PULL 00/19] First batch of misc patches for QEMU 9.0
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 20 Dec 2023 at 18:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>
> > Applied, thanks.
> >
> > Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for
> > any user-visible changes.
>
> might need to change the template for that ;-)

Done, thanks!

Stefan

