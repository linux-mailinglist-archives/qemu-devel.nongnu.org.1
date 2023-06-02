Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8332671FA61
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 08:54:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4yg4-0006Rx-1j; Fri, 02 Jun 2023 02:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4yg1-0006R5-74; Fri, 02 Jun 2023 02:54:21 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4yfz-0001a6-JY; Fri, 02 Jun 2023 02:54:20 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-53063897412so1657194a12.0; 
 Thu, 01 Jun 2023 23:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685688857; x=1688280857;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhsP7kPghhCnOJGguJUOYnjJ0tIplNDiIlEM7LnbqiI=;
 b=Se02nxvupDaRaP3noQSi7VwUJy1BcnQKe/UmMkDZHb9MK10DBAAZz+G4p1sZsEnrcr
 tY7IF6Mjjne2uYm+DXg+pAdSwdRlfFUfMHhb8AatjTrS1GIo+3YOQOsuVEhYRwbzpssf
 C97RCiobw06N943ne0boxw0lm3E7FNJH20cKf4bp5azCP5hLsAUyshShxdkwjX22yayB
 NxqwRCT05ub5herre4rNRUwNqDwB4oI4tyEONyhFyVj2BbWpi3DnA9E/u7v4zUBWheY9
 kVoQEGCKl9cJYa1oR0C5/cBHo73pYSpfwqxzMADgoxXbdvdwznlVHRM/SkBWERy9mfpN
 Qouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685688857; x=1688280857;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mhsP7kPghhCnOJGguJUOYnjJ0tIplNDiIlEM7LnbqiI=;
 b=OEqw7WG7kXzEaEimIT5qWquFngHZ7T/nfE5NZHWsUuwHnoMht/R9N30c4OXPeSZLV6
 N6cCzv7hl7QSVwCyBQBR/p192y2bjSX5XTw75IDdzOm+QvHjo6ESox6nuCGnUtCoRpIJ
 NduQW1d6fYYOAf2zNvo+8xpULgekUYUpYgI+OMt1MnLi79jzysplsxgx7Ih8KCW9Ueku
 IgoaVoK0rxuWbn41V6f3vLINmk3Ik+KdGT2Y05CbeLUWxGWGuXIdCVh0vF3PUSfEdY2A
 +L/44rgIdNcj77raNUCBG5Hq1QojmFp/HnzPB0zo4ZBcPUyLRrXJ2ffRmVXel4vYo7Mh
 h4Jw==
X-Gm-Message-State: AC+VfDyWr6DyoYuE3ojsJn0pFHuDFxmC6xQ0Ch+IWe6Yv9Qj+nzM9BwU
 l1Qo7cUBcOS3cPa9rJywDho=
X-Google-Smtp-Source: ACHHUZ6YYSzczIRm7Rur7m9u4VfQdfVdfR/KU1Pz329IYm7wWjcGr6P9PpvBirMZIEY+EBU21vxFSA==
X-Received: by 2002:a17:90a:9d87:b0:258:9174:20ca with SMTP id
 k7-20020a17090a9d8700b00258917420camr1612560pjp.15.1685688857039; 
 Thu, 01 Jun 2023 23:54:17 -0700 (PDT)
Received: from localhost ([1.146.22.171]) by smtp.gmail.com with ESMTPSA id
 10-20020a17090a194a00b00250cf4e7d25sm2553326pjh.41.2023.06.01.23.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 23:54:16 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Jun 2023 16:54:10 +1000
Message-Id: <CT1YTR278291.2FJPGF168R0VU@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
Subject: Re: [RFC PATCH 2/5] target/ppc: Add initial flags and helpers for
 SMT support
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230531012313.19891-1-npiggin@gmail.com>
 <20230531012313.19891-3-npiggin@gmail.com>
 <fa528286-13f7-ef7c-0472-8e02d0340c10@kaod.org>
In-Reply-To: <fa528286-13f7-ef7c-0472-8e02d0340c10@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
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

On Wed May 31, 2023 at 5:25 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/31/23 03:23, Nicholas Piggin wrote:
> > SMT TCG emulation needs to be able to iterate over siblings in a core,
> > and needs to serialise core access to shared SPRs and state.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   target/ppc/cpu.h       |  9 +++++++++
> >   target/ppc/cpu_init.c  |  5 +++++
> >   target/ppc/translate.c | 20 ++++++++++++++++++++
> >   3 files changed, 34 insertions(+)
> >=20
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index 1f23b81e90..b594408a8d 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -672,6 +672,8 @@ enum {
> >       POWERPC_FLAG_TM       =3D 0x00100000,
> >       /* Has SCV (ISA 3.00)                                            =
        */
> >       POWERPC_FLAG_SCV      =3D 0x00200000,
> > +    /* Has >1 thread per core                                         =
       */
> > +    POWERPC_FLAG_SMT      =3D 0x00400000,
> >   };
> >  =20
> >   /*
> > @@ -1266,6 +1268,13 @@ struct CPUArchState {
> >       uint64_t pmu_base_time;
> >   };
> >  =20
> > +#define _CORE_ID(cs)                                            \
> > +    (POWERPC_CPU(cs)->env.spr_cb[SPR_PIR].default_value & ~(cs->nr_thr=
eads - 1))
> > +
> > +#define THREAD_SIBLING_FOREACH(cs, cs_sibling)			\
> > +    CPU_FOREACH(cs_sibling)                                     \
> > +        if (_CORE_ID(cs) =3D=3D _CORE_ID(cs_sibling))
> > +
>
>
> May be introduce these helpers when needed (and if needed).

Yeah that's a good idea, I tried to structure it so you could see
the main components first, but for a real patch it might indeed be
better add them as needed.

Thanks,
Nick

