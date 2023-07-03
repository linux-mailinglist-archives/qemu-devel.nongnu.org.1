Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE865745CDB
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJGw-0000SY-8e; Mon, 03 Jul 2023 09:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGJGr-0000QV-BY; Mon, 03 Jul 2023 09:07:15 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGJGp-0004mn-Jh; Mon, 03 Jul 2023 09:07:13 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b89b75dc1cso4713755ad.1; 
 Mon, 03 Jul 2023 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688389630; x=1690981630;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVu9qgT+Vaw0woxVqWhiNC1+T3XTm3uTHRDvoFS2fiM=;
 b=JhrU2Dq/BdAiM9XeCREF/uzszxdko2FIruofm2RY499v5sKbn4jRbbpOOzoAkWkxUR
 pcU74TFQOEbevaijd5E2are2RU6g7Sh5ndisythVsateNoUsHwkH5dCBoala8fpf+LDS
 sTg9d63S7otL8yILEZdbLPkNNtKJfDe7h6SQPASei/AY0mBH62jx8LZLIjMkVhSCMZdo
 mGYLBj3b/h4K9axq8TTc7h2aziokNAeN/FYz2Lorddrf2+U8v6XcHMgMRmff+6CSjtVb
 KxyCbMwESCO8j5GMRWzNecNrcpj6pXV7I8IblJz5nJVqvv20NLpWFYja2kmNmSv3Nrbi
 sfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688389630; x=1690981630;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SVu9qgT+Vaw0woxVqWhiNC1+T3XTm3uTHRDvoFS2fiM=;
 b=CLKsyUdZqGKdbJf/KF+rBe4serfB7IuPd4xeOE6/OljxrXUH0gEbxyalQ+MfO5R8+5
 D+yRTErPc04CEBS+OGi/v0pqcVR5r7+r5iZwZiVf0eHKyr/jJPCgvnOJ+UaDdaHTPMhn
 EvOQYvy4J+inJEyqCV9pah7l/i4dfVc2Bu/7hVeYnt/O9QsEqUiGuU5m5VHZrHG+nL4r
 rJIBrB4bK/5yej7dJEyrAeHkWuqAo4jkksenqfHudZ/CjvWDHuKZFNZOK7Tl7wAVlL0t
 ZnjW9cGeMs8NqSxOpIeQRbUSHO8F8U+kia1epkmoS7bAjRcOTDJ93a7kGDlX829l2S5M
 KLOA==
X-Gm-Message-State: AC+VfDwvwNWnTxjxzefCmcHRtaoux04LwwPZ2qr5lju1iBPLcsTvCqSe
 YcmzbVrYpt90OTpMr8WezMMGjc1lqNc=
X-Google-Smtp-Source: ACHHUZ7nFyvsP0UC6naW/ZRKazHoWz9q2kGTSNP7Ju3HDjxTMOwOiZGY1t/XY4fCmSBRblGBM/cklA==
X-Received: by 2002:a17:90a:5a4c:b0:263:3847:e6e6 with SMTP id
 m12-20020a17090a5a4c00b002633847e6e6mr21411708pji.19.1688389629677; 
 Mon, 03 Jul 2023 06:07:09 -0700 (PDT)
Received: from localhost ([118.210.96.60]) by smtp.gmail.com with ESMTPSA id
 v8-20020a17090ad58800b00256a4d59bfasm17029313pju.23.2023.07.03.06.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 06:07:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Jul 2023 23:07:03 +1000
Message-Id: <CTSK657Y1RRB.3919QR3A490A5@wheely>
Subject: Re: [PATCH v3] target/ppc: Make checkstop actually stop the system
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz"
 <groug@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Richard
 Henderson" <richard.henderson@linaro.org>
X-Mailer: aerc 0.15.2
References: <20230703120340.45349-1-npiggin@gmail.com>
 <68789d6e-5bf8-88d6-2bd5-405339500f44@eik.bme.hu>
In-Reply-To: <68789d6e-5bf8-88d6-2bd5-405339500f44@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

On Mon Jul 3, 2023 at 10:26 PM AEST, BALATON Zoltan wrote:
> On Mon, 3 Jul 2023, Nicholas Piggin wrote:
> > checkstop state does not halt the system, interrupts continue to be
> > serviced, and other CPUs run. Stop the machine with
> > qemu_system_guest_panicked.
> >
> > Change the logging not to print separately to stderr because a
> > checkstop is a guest error (or perhaps a simulated machine error)
> > rather than a QEMU error. CPU registers are dumped.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >
> > Since v1:
> > - Fix loop exit so it stops on the checkstop-causing instruction, rathe=
r than
> >  after it.
> >
> > Since v2:
> > - Rebase on ppc-next.
>
> Is this really based on ppc-next or on my series or another patch from=20
> you? I think the patch from my series that introduces the checksrop=20
> function that this patch is changing is not yet in ppc-next so this may=
=20
> not apply there.

It is based on ppc-next unless I've done something silly. Is this
the patch you were talking about?

https://gitlab.com/danielhb/qemu/-/commit/26d089ac20080066061ed61fb58a5411e=
275e191

> I think you've posted an alternative to the patch moving=20
> checkstop handling to a function and the sc patch which may clash with th=
e=20
> not yet merged parts in my series but i could not follow all these=20
> patches. I'm not sure Daniel could so maybe you could send it as a series=
=20
> to include all patches you want to add or state what it's based on.

Things are getting a little confusing, but I think what Daniel has
is okay. Were were talking about changing checkstop with my patch,
but no big deal to take yours first, I've reworked things.

Thanks,
Nick

