Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C609D7C5826
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:35:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbEk-0003cn-Lu; Wed, 11 Oct 2023 11:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qqbET-0003T7-3X
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:34:46 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1qqbEQ-0000y8-2C
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:34:44 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-419628fb297so57621cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697038481; x=1697643281; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUgTTvatpJ3XxLGD2nR5U17drPlzhAEMt5UHIAR1kSE=;
 b=YPRMQf3OYxHtkLbcPyigokNb118iugx2li55ff5Mk465uLRSLqDWPHCVQyUpqRXpJH
 cW4Pwntg7EFX82aN30gTOI60tJCTrh6KXvUbSYF5RoX6RigPrujT4h384zgZGNASzs18
 vTi2AS5QvnF5Z5DL+EuYivXw6D2BW3n1Rc7qacdplAidx0K34/rmphqUG+JhZM+NPdvI
 f+T5CXSNhwZSjg1hpLCKVfyGFfjx9YbERrzqT5Mc6xebGKBXNccX3PqYMnM3rp/jgmFP
 L6hWzWJc07sV01XD0vt4Sf+I4DR/J8Sh9/8n7EwRRPtD6tfs5/yye7yv1PuSnO68EiNT
 CWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697038481; x=1697643281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qUgTTvatpJ3XxLGD2nR5U17drPlzhAEMt5UHIAR1kSE=;
 b=Hk8uJKqMKh0IPoUePtSJQfHqPNteNgrjBSFa4U6wMouK+JTVByPb0ID41rjBIci4aV
 FU+7Ssj275/kdBlRwlThByFndG5RSSlXxedRKxR3cNm6nakOf0ARcNMG4c8NBjqHrSI8
 AbAHQOh7OlK8LWxF94TgHbaQCOFUoV3U574wVm89/BMhx2jqwWa//gBynhWDR46ZMvQ2
 +chRVANuHr58mA0WKk+aQb9r1DxFE8x9+e+mt5fDW0eA3B3AfqMgtI6vP4Voy7/3p4P2
 jKjbchiJxq0B3nTEbC1QP45Hg5KmrojzWrQIv6StdFeZFPCJExcj6t+ne8t4gv1pbBxM
 of/w==
X-Gm-Message-State: AOJu0YzJd53QmIqWmJ0cDMka3g1pH8L7IgvOH8Mr5kyeuxWz3euPiO0k
 2SsvYeOpZ5Brb6v3UE854/5Fg/Fv4Eu3pLW91tcNJg==
X-Google-Smtp-Source: AGHT+IESMWXkg8EbIlKaLHITnwFeGfsDo0dubAcyJtN6whs3fb0SNTtlOasrKukUnLX1g8OMSbK7nY69nyXxmX+ID5Q=
X-Received: by 2002:ac8:5b11:0:b0:40b:784:a06c with SMTP id
 m17-20020ac85b11000000b0040b0784a06cmr30195744qtw.0.1697038480641; Wed, 11
 Oct 2023 08:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230925111025.543094-1-mchitale@ventanamicro.com>
 <CAKmqyKP5kWQRUHBhHsXOFKuiB+Ac6cJGTRq9sBXsGD9G+1SNZA@mail.gmail.com>
In-Reply-To: <CAKmqyKP5kWQRUHBhHsXOFKuiB+Ac6cJGTRq9sBXsGD9G+1SNZA@mail.gmail.com>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Wed, 11 Oct 2023 21:04:04 +0530
Message-ID: <CAN37VV7YBOn0OZ-ih4thwqNdbF9LAo9p9zJOBsWK6QsUXaDi=g@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: pmp: Ignore writes when RW=01
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=mchitale@ventanamicro.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Oct 9, 2023 at 6:56=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Mon, Sep 25, 2023 at 9:11=E2=80=AFPM Mayuresh Chitale
> <mchitale@ventanamicro.com> wrote:
> >
> > As per the Priv spec: "The R, W, and X fields form a collective WARL
> > field for which the combinations with R=3D0 and W=3D1 are reserved."
> > However currently such writes are not ignored as ought to be. The
> > combinations with RW=3D01 are allowed only when the Smepmp extension
> > is enabled and mseccfg.MML is set.
> >
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>
> Do you mind rebasing this on
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
Ok, will do that.
>
> Alistair
>
> > ---
> >  target/riscv/pmp.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > index 5b14eb511a..8e25f145e0 100644
> > --- a/target/riscv/pmp.c
> > +++ b/target/riscv/pmp.c
> > @@ -120,6 +120,11 @@ static void pmp_write_cfg(CPURISCVState *env, uint=
32_t pmp_index, uint8_t val)
> >          if (locked) {
> >              qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write - lo=
cked\n");
> >          } else {
> > +            /* If !mseccfg.MML then ignore writes with encoding RW=3D0=
1 */
> > +            if ((val & PMP_WRITE) && !(val & PMP_READ) &&
> > +                !MSECCFG_MML_ISSET(env)) {
> > +                val &=3D ~(PMP_WRITE | PMP_READ);
> > +            }
> >              env->pmp_state.pmp[pmp_index].cfg_reg =3D val;
> >              pmp_update_rule(env, pmp_index);
> >          }
> > --
> > 2.34.1
> >
> >

