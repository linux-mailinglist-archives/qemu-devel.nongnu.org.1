Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3981180F928
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 22:24:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDAEB-0004cw-HG; Tue, 12 Dec 2023 16:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rDAEA-0004ch-2d
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:23:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rDAE8-00033A-Lo
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702416218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSSMkNzpyWtEBkgB4TPeNJIaacH09Nc6XEfTUsQxN5Y=;
 b=IrlZtN4vPLR8aaRkIn/nrxUK2rOx15p+f2aXMAE1kZmD5jcMG43n2Ij0Ay7l4LdGN4frEy
 JM2PQfk5igGRuifvMjGbTmLe8dH2td1k5BU2MI9HjtlJD+hF5HWmpz0cwwGtexGfvHwP+M
 Bp0GX+WjUYkR6S24nwtPFjW3OFT9Lnc=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-jEHFtNTuN9SkbBhzoqwlYw-1; Tue, 12 Dec 2023 16:23:35 -0500
X-MC-Unique: jEHFtNTuN9SkbBhzoqwlYw-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-4647f7d949dso1624735137.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 13:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702416215; x=1703021015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gSSMkNzpyWtEBkgB4TPeNJIaacH09Nc6XEfTUsQxN5Y=;
 b=kGaI7aaLb9SNyiadv/7JgGjoLk6zNouEDX+bsZKqO1yaQ0SibD79tTyZIXkemRSB/O
 Dn0jwRiHPftzm6VaSDxcSHPVYrO10fNPwkqOZg3tKmu28Vcp/ReDqVX14C00V90wipV4
 dwJqxBVekFnN4oIKQ8WUUZ4vJcRN6cACuDujc25x5u01pMJoYXaKwxXQSirq+yByDO8+
 Ffj56HGers2ek0w3U6h2N+yqzlD/DMwCknISkgBUfsTbqdJYKV+3gQQFUDPiSb5SUSKl
 3csAKd53NmL14ngR/DpHywl8E7MHESopRce+/Uq5PrW1seEsBlQqL67o8lHLuZpzUSBY
 OrUQ==
X-Gm-Message-State: AOJu0YzB8qzQv9h4bDqtqlndtUy5GNvSPmrSqRt9LN1tWWhp0ZVJzdXb
 ElTSMACZXApnWO/2sUTDg4zr/cIKzPjMQ3m9BhmMeCp8Wyrd74tqVN1KavuWoUDX82RM2KBMLX7
 2PnqutNIjDfnoLZNF254lG8ki4yes0r8=
X-Received: by 2002:a67:ecd3:0:b0:465:8269:6586 with SMTP id
 i19-20020a67ecd3000000b0046582696586mr3934666vsp.45.1702416214601; 
 Tue, 12 Dec 2023 13:23:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbMG+POoxuuEAkBN5JisrJ8YLCqx3E/+3MdQGrJJJDSwMQeU9MLSi7EjIagHV8XlWVf9a7M5a41ThYrZFGFQ4=
X-Received: by 2002:a67:ecd3:0:b0:465:8269:6586 with SMTP id
 i19-20020a67ecd3000000b0046582696586mr3934659vsp.45.1702416214055; Tue, 12
 Dec 2023 13:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20231212172510.103305-1-richard.henderson@linaro.org>
 <CABgObfauRJmT5hS9nv1nORwAYj3biZm_xrqoMfADdqJN9_+UYg@mail.gmail.com>
 <0d42f12f-3af7-403e-9c0e-db462a3139b1@linaro.org>
In-Reply-To: <0d42f12f-3af7-403e-9c0e-db462a3139b1@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Dec 2023 22:23:21 +0100
Message-ID: <CABgObfbLiqY+GQk6yAfMVke8fbz0PW2-JTKbTzDLmbyBRos02g@mail.gmail.com>
Subject: Re: [PATCH for-8.2?] target/i386: Fix 32-bit wrapping of pc/eip
 computation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Dec 12, 2023 at 10:22=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> > Looks good, but perhaps you could also squash the following?
> >
> > diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
> > index 2c6a12c8350..83ee89579b8 100644
> > --- a/target/i386/tcg/tcg-cpu.c
> > +++ b/target/i386/tcg/tcg-cpu.c
> > @@ -52,7 +52,11 @@ static void x86_cpu_synchronize_from_tb(CPUState *cs=
,
> >       /* The instruction pointer is always up to date with CF_PCREL. */
> >       if (!(tb_cflags(tb) & CF_PCREL)) {
> >           CPUX86State *env =3D cpu_env(cs);
> > -        env->eip =3D tb->pc - tb->cs_base;
> > +        if (tb->flags & HF_CS64_MASK) {
> > +            env->eip =3D tb->pc;
> > +        } else {
> > +            env->eip =3D (uint32_t) (tb->pc - tb->cs_base);
> > +        }
> >       }
> >   }
> >
> >
> > It wouldn't be the same bug as 2022 (it wouldn't be new with the vaddr
> > change) so it's okay to sort out this extra case after release.
>
> Good catch, I'll squash it.  Thanks.

BTW,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


