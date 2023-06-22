Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FE9739DD3
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:55:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCH1e-0004Rh-Ee; Thu, 22 Jun 2023 05:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCH1b-0004Qv-0l; Thu, 22 Jun 2023 05:54:47 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCH1Z-0005tI-8b; Thu, 22 Jun 2023 05:54:46 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-543ae674f37so3885807a12.1; 
 Thu, 22 Jun 2023 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687427683; x=1690019683;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Pl4GLvZmSfREtzoMGfOyW3M0f6st1J46o/YELite2k=;
 b=YGbRS70sNRCCcPC4rWWwq+f0IJO6pU0cziV+7+hp4q7jYiI0fD666d2CXiv4L3k5lb
 Vck5TxplCI0+46YI6cgBHDk9eltGTA7EsHTdCJNxn6jrUZW+76aJZ4aD2zd6ZygdlT2D
 s1bU2ws5bzsXByp17vOa4J8hmZxDMx9H9mOqCsEfgdvGNzWOeQUasENjqJ+8YucEj4/4
 eQNR7Mrdy5HF/V17RA7KfZIWEWrbZcB3pXu7Wj4pecR9hBoOpP99WpmWyeK5Z4GYOJGL
 EZDQENKKWNAqhs/lYZ2m5xineGuJ3Q5lSnKPAvE33q4smutfNixLzDOctF1zcRmNm2Zc
 G0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687427683; x=1690019683;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9Pl4GLvZmSfREtzoMGfOyW3M0f6st1J46o/YELite2k=;
 b=Psn0sLoFLpEc11cw/BqmH2akWWRxQ97X9l46lVElk+OoML+XUolRT+I+dXngEtvun/
 UBX+bC+AKrqb1dE/nkpHSqQpgVBOodYBKpASLuvg26t2WgEFhe5j4Nh0eMpqWC6P5CbW
 3z/B5/Q7aUuvINATL0lJG9fRg10PXQrohAR2O/XJ7OpdsVePRNmJga8nfqyLdHQYFgo5
 Xij0cJnDXcyLE2ZR70OdZ9sWsDfOu6U/ujomQJkpeckgQrabyTTIGnFtWcG1hTm47QU3
 phfeau9T0b26pgBbxQhmmAkkL+PSL+xYVFdqyZfqW9UGcLLwGRw95lk88DZmnG/h4LY3
 iVBA==
X-Gm-Message-State: AC+VfDyigRdA1+b/070T8mTjKUB24W1sSNlpqQpnKkyX+ZXlM3rPoLPh
 VG+Xmmxikfo0IHrwarF8twfUt13FOWI=
X-Google-Smtp-Source: ACHHUZ675i9JGGpxqo1Hdc5MpsX4E6arcrULTvgShlNCla/Rbm7Oxnl1vahndni3bQAP4IphmthXzA==
X-Received: by 2002:a17:903:228f:b0:1b6:4bbd:c3a3 with SMTP id
 b15-20020a170903228f00b001b64bbdc3a3mr9688230plh.52.1687427683360; 
 Thu, 22 Jun 2023 02:54:43 -0700 (PDT)
Received: from localhost (193-116-203-37.tpgi.com.au. [193.116.203.37])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902cec500b001b54d064a4bsm4920415plg.259.2023.06.22.02.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 02:54:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jun 2023 19:54:35 +1000
Message-Id: <CTJ36SK7E9VG.1ZUMJOOTJGGWA@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH 0/4] ppc/pnv: Add chiptod and core timebase state
 machine models
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230603233612.125879-1-npiggin@gmail.com>
 <35689504-df1e-0590-b393-a65673562404@kaod.org>
In-Reply-To: <35689504-df1e-0590-b393-a65673562404@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
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

On Thu Jun 22, 2023 at 5:30 PM AEST, C=C3=A9dric Le Goater wrote:
> On 6/4/23 01:36, Nicholas Piggin wrote:
> > This adds support for chiptod and core timebase state machine models in
> > the powernv POWER9 and POWER10 models.
> >=20
> > This does not actually change the time or the value in TB registers
> > (because they are alrady synced in QEMU), but it does go through the
> > motions. It is enough to be able to run skiboot's chiptod initialisatio=
n
> > code that synchronises core timebases (after a patch to prevent skiboot
> > skipping chiptod for QEMU, posted to skiboot mailing list).
> >=20
> > Sorry there was some delay since the last posting. There is a bit more
> > interest in this recently but feedback and comments from RFC was not
> > forgotten and is much appreciated.
> >=20
> > https://lists.gnu.org/archive/html/qemu-ppc/2022-08/msg00324.html
> >=20
> > I think I accounted for everything except moving register defines to th=
e
> > .h file. I'm on the fence about that but if they are only used in the .=
c
> > file I think it's okay to keep them there for now. I cut out a lot of
> > unused ones so it's not so cluttered now.
> >=20
> > Lots of other changes and fixes since that RFC. Notably:
> > - Register names changed to match the workbook names instead of skiboot=
.
> > - TFMR moved to timebase_helper.c from misc_helper.c
> > - More comprehensive model and error checking, particularly of TFMR.
> > - POWER10 with multi-chip support.
> > - chiptod and core timebase linked via specific state instead of TFMR.
> >=20
> > There is still a vast amount that is not modeled, but most of it relate=
d
> > to error handling, injection, failover, etc that is very complicated an=
d
> > not required for normal operation.
> >=20
> > Thanks,
> > Nick
> >=20
> > Nicholas Piggin (4):
> >    pnv/chiptod: Add POWER9/10 chiptod model
> >    target/ppc: Tidy POWER book4 SPR registration
> >    target/ppc: add TFMR SPR implementation with read and write helpers
> >    target/ppc: Implement core timebase state machine and TFMR
>
> patch 2-4 could be merged in the next PR. Could you please rebase on
> ppc-next and resend ?

Good idea, I have a couple of other minor register additions that
depend on patch 1 too.

> Then we still have 2+ weeks to polish pnv/chiptod which would be a
> nice addition to QEMU 8.1.

Yeah. Been trying to get to it... Hopefully pseries SMT is close
now so I will have some more time.

Thanks,
Nick

