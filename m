Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEECA80738B
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 16:16:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAtcn-0000JK-9d; Wed, 06 Dec 2023 10:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAtch-0000Gi-Tb
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:15:39 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAtce-0005ri-Td
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:15:39 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1fb13a0951bso1724490fac.3
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 07:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701875719; x=1702480519; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s1kk+h1eDgOGv7pajgZjKWXzsaF5JcEUHNKenInbI64=;
 b=KA7SewVWgraSsz/ViOjBE4V34f5fbgqByXHZviS7ffrf1+IMgBOSsAXZnkqdGDGKGf
 PsSTXxPfYoglg3/1RatAZm/HG0jftVTh018fK2O/O3Ys1pEbaN12sYJPtdgIPb88KTaI
 6xJRSEAmosuDedd96x4xqP8G5qsDzQ6YERclJmC59EhvrQJ9sqMMQoCBpVACXxly7e2P
 s1LelP1A37X7pESdENScLPh1LiD57ZZ/MaijQf4xMls3x8JApwXI1qEDX3DNE3cHKmXl
 AY2Bjqk+3+DshqeLlIpEiFHA6cIkEEIHeNV5JN0gm7fO7xRcnW6KotO07VKAVRf/fOyl
 IGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701875719; x=1702480519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1kk+h1eDgOGv7pajgZjKWXzsaF5JcEUHNKenInbI64=;
 b=PnERP26jh2FIfP/byqQxYFxXAOAvL3iT2YdBdxpwGB+TLNKAemRQ5xc7Els2ntAMNk
 qRym5enw98tjYtKQWaY3VHJlJ4Rp+ooKSJ5R9dlJTbD+PaHC+b3FRhRi7SMwVGKEe0CK
 BKfFY6+O1gJuDjJnY5cldSNyIc90/pqRqf2n59X6EFupndk1DCt74r3PoR/xueSCgPem
 zinjnCue8ZDgRpsLcF6XjkBogoAhn5UzPY11C/lB17VBJozVNBY/7vO0MQM2vD/8O8ee
 UVrd9SRz6Btdy3y8y8fBzu4a1ef/b9DDLEfyDNGtUD5V/bFg2kT8rpEfexTDKZYi0sUw
 bP4w==
X-Gm-Message-State: AOJu0YzRJm/QnykhNKyOBUtILd/IxojDv7fmi6LxYRECwvoI+2/QUoxa
 ZcdwuqyHZF/M/UVW73onHyTILbU45109B9fNstw=
X-Google-Smtp-Source: AGHT+IHfbVF9EzdXL+mbO0jzJdi07gPazZ1iuUR9ytlhs6eY/vfrrN7z22k9SZij37lokXCc+iZG1r4H37EspKIrI4s=
X-Received: by 2002:a05:6871:610:b0:1fb:75b:2ba8 with SMTP id
 w16-20020a056871061000b001fb075b2ba8mr934596oan.100.1701875719618; Wed, 06
 Dec 2023 07:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20231204194039.56169-1-philmd@linaro.org>
 <CAJSP0QUjZQQCk+VSJyxLq2jzuK=nxXDCiBn-r4dVzNPOCgH67w@mail.gmail.com>
 <20231204200937.GA9696@kitsune.suse.cz>
 <caa90c99-aada-467b-a005-84642cd55a86@linaro.org>
 <20231205100959.GB9696@kitsune.suse.cz>
 <20231206125619.GH9696@kitsune.suse.cz>
 <189df9b0-7271-4463-98e4-e6e938a0cf6f@linaro.org>
In-Reply-To: <189df9b0-7271-4463-98e4-e6e938a0cf6f@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 6 Dec 2023 10:15:07 -0500
Message-ID: <CAJSP0QVRRQRxs38dibZnUe3CCFurLM9J2VCxPYj4TeGAURytoQ@mail.gmail.com>
Subject: Re: [RFC PATCH-for-8.2?] accel/tcg: Implement tcg_unregister_thread()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x2d.google.com
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

On Wed, 6 Dec 2023 at 09:29, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi Stefan,
>
> On 6/12/23 13:56, Michal Such=C3=A1nek wrote:
> > On Tue, Dec 05, 2023 at 11:09:59AM +0100, Michal Such=C3=A1nek wrote:
> >> On Mon, Dec 04, 2023 at 03:02:45PM -0800, Richard Henderson wrote:
> >>> On 12/4/23 12:09, Michal Such=C3=A1nek wrote:
> >>>> On Mon, Dec 04, 2023 at 02:50:17PM -0500, Stefan Hajnoczi wrote:
> >>>>> On Mon, 4 Dec 2023 at 14:40, Philippe Mathieu-Daud=C3=A9 <philmd@li=
naro.org> wrote:
> >>>>>> +void tcg_unregister_thread(void)
> >>>>>> +{
> >>>>>> +    unsigned int n;
> >>>>>> +
> >>>>>> +    n =3D qatomic_fetch_dec(&tcg_cur_ctxs);
> >>>>>> +    g_free(tcg_ctxs[n]);
> >>>>>> +    qatomic_set(&tcg_ctxs[n], NULL);
> >>>>>> +}
> >>>>>
> >>>>> tcg_ctxs[n] may not be our context, so this looks like it could fre=
e
> >>>>> another thread's context and lead to undefined behavior.
> >>>
> >>> Correct.
> >>>
> >>>> There is cpu->thread_id so perhaps cpu->thread_ctx could be added as
> >>>> well. That would require a bitmap of used threads contexts rather th=
an a
> >>>> counter, though.
> >>>
> >>> Or don't free the context at all, but re-use it when incrementing and
> >>> tcg_ctxs[n] !=3D null (i.e. plugging in a repacement vcpu).  After al=
l, there
> >>> can only be tcg_max_ctxs contexts.
> >>
> >> But you would not know which contexts are in use and which aren't with=
out
> >> tracking the association of contexts to CPUs.
> >>
> >> Unless there is a cpu array somewhere and you can use the same index f=
or
> >> both to create the association.
> >
> > I tried to use cpu_index for correlating the tcg_ctx with cpu. I added
> > some asserts that only null contexts are allocated and non-null context=
s
> > released but qemu crashes somewhere in tcg sometime after the guest get=
s
> > to switch root.
>
> Since this isn't trivial and is a long standing issue, let's not
> block the 8.2 release with it.

Sounds good.

Thanks,
Stefan

