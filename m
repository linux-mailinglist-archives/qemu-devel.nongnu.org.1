Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF682736239
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 05:40:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBSD5-00032b-De; Mon, 19 Jun 2023 23:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBSD3-00032C-2u; Mon, 19 Jun 2023 23:39:13 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBSD1-0007ee-DL; Mon, 19 Jun 2023 23:39:12 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b5452b77b4so24473335ad.3; 
 Mon, 19 Jun 2023 20:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687232349; x=1689824349;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilKhaW4H6z2ExCKfqx6DO3BNHEZuD+M/GKSxDyZrt8E=;
 b=BtcdtijHNrMHs0KILWrmZk1zZIhalykN13+ReJVbT2eZK+vDeC5kLXybVt3xX9WLXu
 JgNE9rGUMw/3FDBidX+ScUMmIHrWGxz/WlEYuGLkfyAnRScoVvRXlQpEVuqCz5sDLG1s
 3jpYQ2x9ewF4laC1oM5ozZse5U7fONWFsZrmLuQEcEUE0OCpwGY4d5sun6mjluC4ZW+/
 5hR0hJ7Y2dqzlhRg/cX5Le/Z9H/8nCNQPZv71AGj5iTGTK4RnSwb8C08r7oVDSvfUC/S
 RoTIF3gtpFPX82NCYVXUP+rqxQvC/jXajjPs3Yl97zHu53ff/rONgH3KJxbUThuWJJyM
 W9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687232349; x=1689824349;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ilKhaW4H6z2ExCKfqx6DO3BNHEZuD+M/GKSxDyZrt8E=;
 b=QQgWyCbHEVC/owkm+DHWfPx9t2i8coYsLlDnkZAob8iAo2jmS7kDPCeezP4mKNt7tO
 V+UVKbyGy8erbcfczVuiduYJ+RGnWbCEFTSiMMHTG3a2FndIzA1K7nd5pfdwcuaudRvf
 1aOB0FfeaPCfqoux71+NSpXZnDARl6jvm4CiOSIwt5xSN1C9ZvFta03SB4w0YbYHCrgi
 4/hhWenpwshqhfnVh8xtHMxNTxlM8TdkozmdzNOe56ecvk0J6HdXtZO1k/5+/fGOz5RT
 6xA3eLyn4KR0cptEjXgSgxMiMIyLCpakMBUZaTkmgPP/vxA8Erw2JhLWqz3vLb/u13Qu
 5FJw==
X-Gm-Message-State: AC+VfDybpgOZI/VF1/LZ7qJgW6BtVFmgLIyc9gKRwx0rYUazdRySl5os
 +dL/xNAnINsFRTjw5GdjeBA=
X-Google-Smtp-Source: ACHHUZ7VG7eiOXS9BoKevXx6InMkbOqAUsqvX5Z3Jbvr8/nu+dZZKmOYzJ/1nk14bKFAokcN/Nqwzw==
X-Received: by 2002:a17:902:bc42:b0:1ae:8892:7d27 with SMTP id
 t2-20020a170902bc4200b001ae88927d27mr10922300plz.42.1687232348891; 
 Mon, 19 Jun 2023 20:39:08 -0700 (PDT)
Received: from localhost ([1.146.105.3]) by smtp.gmail.com with ESMTPSA id
 y1-20020a170902b48100b001a24cded097sm477239plr.236.2023.06.19.20.39.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 20:39:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jun 2023 13:39:01 +1000
Message-Id: <CTH5Y56UH8XV.27NIMNBOJQYWK@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 2/4] target/ppc: Ensure stcx size matches larx
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Peter Maydell" <peter.maydell@linaro.org>, "Richard Henderson"
 <richard.henderson@linaro.org>
X-Mailer: aerc 0.14.0
References: <20230604102858.148584-1-npiggin@gmail.com>
 <20230604102858.148584-2-npiggin@gmail.com>
 <CT4I52C30RXG.AESIFCY16U6T@wheely>
 <94a453bc-cfd5-5fb0-289d-dbb321c8b172@linaro.org>
 <CAFEAcA_hirbGc_iZUhsD22Ksjj_2OBevDJq-r1mvnVqKoTqCvA@mail.gmail.com>
 <8b14781d-f5e5-b5b1-90c3-2d6eae8ffdc9@linaro.org>
 <CAFEAcA_9Rh8Y6aWf4SubL2niwow5J73PmXd9P6r5WZ=Mc+_GeQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_9Rh8Y6aWf4SubL2niwow5J73PmXd9P6r5WZ=Mc+_GeQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

On Tue Jun 20, 2023 at 3:14 AM AEST, Peter Maydell wrote:
> On Mon, 19 Jun 2023 at 18:03, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 6/19/23 17:55, Peter Maydell wrote:
> > > On Mon, 19 Jun 2023 at 16:49, Richard Henderson
> > > <richard.henderson@linaro.org> wrote:
> > >>
> > >> On 6/5/23 08:27, Nicholas Piggin wrote:
> > >>> On Sun Jun 4, 2023 at 8:28 PM AEST, Nicholas Piggin wrote:
> > >>>> Differently-sized larx/stcx. pairs can succeed if the starting add=
ress
> > >>>> matches. Add a size check to require stcx. exactly match the larx =
that
> > >>>> established the reservation.
> > >>>
> > >>> Hmm, question: reserve_addr is a VMSTATE field, but reserve_val is =
not
> > >>> (nor reserve_size after this patch).
> > >>>
> > >>> Blue Swirl added that with commit a456d59c20f ("VM load/save suppor=
t for
> > >>> PPC CPU"), and when reserve_val was added in commit 18b21a2f83a
> > >>> ("target-ppc: retain l{w,d}arx loaded value") it did not get migrat=
ed.
> > >>>
> > >>> Could we end up with reserve_addr !=3D -1, but with a bogus reserve=
_val,
> > >>> which could then permit a stcx. incorrectly? Not entirely outlandis=
h if
> > >>> reserve_val starts out initialised to zero.
> > >>>
> > >>> Could we just clear the reserve in cpu_post_load? It is permitted t=
o be
> > >>> lost for an implementation-specific reason. Doesn't seem necessary =
to
> > >>> try keep it alive over a migration.
> > >>
> > >> It's not a bad idea to flush the reservation over migrate.
> > >
> > > Is there any particular reason to do so? The default simple
> > > thing is "if this is state that persists across instructions
> > > then migrate it"; we usually reserve "do something special in
> > > post-load" for oddball cases where "just copy the data" doesn't
> > > work.
> > >
> > > target/arm migrates both the exclusive addr and value.
> >
> > ppc is adding "size", which arm technically should have as well.
>
> Arm allows an implementation to require the transaction size
> to match on loadexcl and storexcl, but doesn't mandate it, fwiw.
> (Also, our implementation is miles away from the architectural
> requirements anyway because we operate on virtual addresses,
> not physical addresses.)

The same as powerpc. Size *and* address within reserve granule
does not have to match the larx which established the reserve,
but the latter we always enforced and in practice no open source
software seems to hit it (or AIX).

My thinking is that it is good to tighten it because very likely
software that gets it wrong is deviating from ISA unintentionally.
Linux provides no HWCAP bit to allow code to test such
implementation details, for example.

> > > target/mips migrates lladdr but has forgotten llval
> > > (and perhaps llval_wp and llnewval_wp, depending on what
> > > those fields do).
> >
> > So, similarly, would need to handle migration for which all of the requ=
ired data is not
> > present.
> >
> > The thought is, rather than migrate this new data also, and handle comp=
atibility, simply
> > discard all reservations.
>
> I don't see a problem for normal migration and snapshotting.
> I do wonder whether this would have a bad interaction
> with record-and-replay's use of snapshots. Does that
> expect "execution from the loaded snapshot" to match
> "execution continues from point of snapshot save" ?

I don't mind the idea of moving the new state across, I wondered
if clearing the reserve would be easier for compatibility and
backporting.

I don't know the rr code but if the snapshots use this vmstate
and the replay from that is expected to match exactly the
recording, then I think you must be right.

Thanks,
Nick

