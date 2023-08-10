Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEE0776D68
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 03:13:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTuEI-0007zg-Ch; Wed, 09 Aug 2023 21:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTuEG-0007zS-9B; Wed, 09 Aug 2023 21:12:44 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTuEB-000626-LL; Wed, 09 Aug 2023 21:12:44 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68706b39c4cso291231b3a.2; 
 Wed, 09 Aug 2023 18:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691629958; x=1692234758;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bObvLbtDaNIrWm4iFgphp+ONnswS2zNEeJgGa0fjYSo=;
 b=H/WfbgIyUQIWudOz4I8A1swtQi8LLkYL6sP4ko/KsuloqS9QrDzKDDSZpGYiW8vOs3
 yuUu5RhIKkPVBWCVNYU0yi7VkMZPj48mCUHp3tSOa9hkD+GG3ug1G2yLqevNY51NZOZg
 I0lKiRdEKlmYzOFkNRU+9ZHqOj6Fzf4go5hSHc712ro6gh+bziCFHczs4jd4Ibl5FGGk
 N3hXY+eFiKuTzwgM46TTMyEeNO2Q54WeH3xZTHzwFnbrrpWXxCBSrV3VWWmQ8TDDBPeN
 tvgFD87Jfdz9IaHqomnxeAmsBzHaywqvvxIxVbh6Vcrt7LqKp1g5vZYFDTF81pVsUK7R
 KvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691629958; x=1692234758;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bObvLbtDaNIrWm4iFgphp+ONnswS2zNEeJgGa0fjYSo=;
 b=AVI554WxOfxtnGsSFcCsDfn9w757EebL6FlulC7UWKRj+ym4Uf8pJJgO/L5sxM6YkE
 ghWjTrEFnV44UxOZdit5WfxyoUbKVe0KO2apCz7Q8I9YkHvWzA00Pk7UGHOw/QypnmjY
 8s8/JDyfFycVR03D4JJPHOJnKtmZa0I+0jZaCKGVrGBisP26YveMqgit4uX/NLj1nIUi
 RnmdxC0oL5ZRmKofkZxQCQXoBtDq8fAr8daI9+TMvBcJoPB/cg/kf//sVET8psMxK8nX
 slS9Fvl5Mht53T4OytTA7D1Z7SAWhODGM18jZcL8y6DqNilB+OUhYlJmVNXn4a6F3/Vz
 CnKQ==
X-Gm-Message-State: AOJu0YwH79a4ANtduydPSeZuQBYavXhvnE9gH6WJv/J1pRc7soOTXMRr
 ib51jZpWaUqSrGgNc9yq8DI=
X-Google-Smtp-Source: AGHT+IEdd6P1DVVHWQ/2g96WVW2fUFF6DEqezDkuKq7RA9cSDmeTlBDnCssgaY6kdFOjd5tye36HqQ==
X-Received: by 2002:a05:6a00:1ad3:b0:686:be77:431c with SMTP id
 f19-20020a056a001ad300b00686be77431cmr1044215pfv.13.1691629957727; 
 Wed, 09 Aug 2023 18:12:37 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 x42-20020a056a000bea00b006661562429fsm220559pfu.97.2023.08.09.18.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 18:12:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Aug 2023 11:12:31 +1000
Message-Id: <CUOGRRDY38D9.16YFA0IGNA8ZJ@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
Cc: "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz"
 <groug@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Pavel
 Dovgalyuk" <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini"
 <pbonzini@redhat.com>, <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 10/19] target/ppc: Migrate DECR SPR
X-Mailer: aerc 0.15.2
References: <20230808042001.411094-1-npiggin@gmail.com>
 <20230808042001.411094-11-npiggin@gmail.com>
 <6732c873-7e53-26cf-49fe-fa42bc43b6d0@kaod.org>
In-Reply-To: <6732c873-7e53-26cf-49fe-fa42bc43b6d0@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed Aug 9, 2023 at 10:56 PM AEST, C=C3=A9dric Le Goater wrote:
> Hello Nick,
>
> On 8/8/23 06:19, Nicholas Piggin wrote:
> > TCG does not maintain the DEC reigster in the SPR array, so it does get
> > migrated. TCG also needs to re-start the decrementer timer on the
> > destination machine.
> >=20
> > Load and store the decrementer into the SPR when migrating. This works
> > for the level-triggered (book3s) decrementer, and should be compatible
> > with existing KVM machines that do keep the DEC value there.
> >=20
> > This fixes lost decrementer interrupt on migration that can cause
> > hangs, as well as other problems including record-replay bugs.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   target/ppc/machine.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >=20
> > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > index 8234e35d69..8a190c4853 100644
> > --- a/target/ppc/machine.c
> > +++ b/target/ppc/machine.c
> > @@ -209,6 +209,14 @@ static int cpu_pre_save(void *opaque)
> >       /* Used to retain migration compatibility for pre 6.0 for 601 mac=
hines. */
> >       env->hflags_compat_nmsr =3D 0;
> >  =20
> > +    if (tcg_enabled()) {
> > +        /*
> > +         * TCG does not maintain the DECR spr (unlike KVM) so have to =
save
> > +         * it here.
> > +         */
> > +        env->spr[SPR_DECR] =3D cpu_ppc_load_decr(env);
> > +    }
> > +
> >       return 0;
> >   }
> >  =20
> > @@ -319,6 +327,12 @@ static int cpu_post_load(void *opaque, int version=
_id)
> >           ppc_update_ciabr(env);
> >           ppc_update_daw0(env);
> >   #endif
> > +        /*
> > +         * TCG needs to re-start the decrementer timer and/or raise th=
e
> > +         * interrupt. This works for level-triggered decrementer. Edge
> > +         * triggered types (including HDEC) would need to carry more s=
tate.
> > +         */
> > +        cpu_ppc_store_decr(env, env->spr[SPR_DECR]);
> >           pmu_mmcr01_updated(env);
> >       }
>
>
> This doesn't apply. I am missing some patch ?

Oh, it's a small dependency on the debug patches, sorry forgot to
mention (see the ciabr/daw0 in the top of the context).

Thanks,
Nick

