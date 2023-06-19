Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86722735CD5
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 19:15:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBISw-0003Of-5P; Mon, 19 Jun 2023 13:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBISu-0003Nw-2F
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:56 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBISs-00028F-24
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:14:55 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-519c0ad1223so4629577a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687194892; x=1689786892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xW38XoaIUZGWYFWVtKArUDluNB4ysuZpnmcvlXzwMXc=;
 b=y2XzSQnu/6vIEqcdM4r6L3NuvQpO/PRit+4MnPN4e8NpGdqgKjSq6qOhQdYgM5wPcf
 6xa3/+xhwlodqpA+VAO2dwfW2yA5D3bDy+kdm629JLcNgzqwBEoBJQJrUJF93BDIh9xk
 8SnBKCBTukqzXBhvFduAnSvRs06O1w/wddsmvj9Qb0wNpRzTWaA2r5V9WvIsq602Lr6V
 qdUROQcDZ/d7VtT0mun+iOTSemY0KOA5pLhUW2UyWLPRj0+J3BDc09bZ9ab4HzK4lTqg
 tih8x0Z2IDvJDjyIz2SfesgZu1ngUsDVLqT5KnrnPyRDhf7S8/LOLHBo5ggVhYX/GxL/
 gwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687194892; x=1689786892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xW38XoaIUZGWYFWVtKArUDluNB4ysuZpnmcvlXzwMXc=;
 b=C5PdHPwtYpUhoV/KSdTOGzGJ7W375NiUKVu5MLMZ3sxh6RRjrArakAFKKs8I0NHJvo
 e9QgF9lTSbjFkdnyWAaWcoEMSLbWir4EceRxySI3c7+tWPRcfdABrL8CtIcHVHe+FEgr
 lzuBcqj7Mb9VhYx0tKX4WvV7rl39f6wI7fPgpMJxsTEfIDQLxh+EimYVq8xRRQsXtW1j
 qULw2nTRlzPYN61NmxskWDBF2t2uHUW87UZqDTCddqaUKJCYh5fyDCJ+CpYXvAzVpTNB
 BHCxVGSGjVckcWVYqbe2bRCqNUTYMYeK1SmVxmGNaO1u0XLzwVC48ovqlbNLqWY/CRk/
 sYeg==
X-Gm-Message-State: AC+VfDxQNO6vuEvkzxsSPMYCxnI9cUForReoQylEYbnkSxLyxSiryhJY
 29UZZsyD0xXLvSC0b7zz85otqAt6gtq2CXEPoAhbLg==
X-Google-Smtp-Source: ACHHUZ7UzmPz/w57IeW6Ra/S1+Zkw86HZ9ua0XtkxQX9045BJ/NJ8J+M0F8ncijyc9ZFPSZ7QDcRXhNq+jTlHncVWEU=
X-Received: by 2002:aa7:d603:0:b0:51a:4ad7:dcde with SMTP id
 c3-20020aa7d603000000b0051a4ad7dcdemr3625739edr.35.1687194892682; Mon, 19 Jun
 2023 10:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230604102858.148584-1-npiggin@gmail.com>
 <20230604102858.148584-2-npiggin@gmail.com>
 <CT4I52C30RXG.AESIFCY16U6T@wheely>
 <94a453bc-cfd5-5fb0-289d-dbb321c8b172@linaro.org>
 <CAFEAcA_hirbGc_iZUhsD22Ksjj_2OBevDJq-r1mvnVqKoTqCvA@mail.gmail.com>
 <8b14781d-f5e5-b5b1-90c3-2d6eae8ffdc9@linaro.org>
In-Reply-To: <8b14781d-f5e5-b5b1-90c3-2d6eae8ffdc9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 18:14:41 +0100
Message-ID: <CAFEAcA_9Rh8Y6aWf4SubL2niwow5J73PmXd9P6r5WZ=Mc+_GeQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/ppc: Ensure stcx size matches larx
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 19 Jun 2023 at 18:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/19/23 17:55, Peter Maydell wrote:
> > On Mon, 19 Jun 2023 at 16:49, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 6/5/23 08:27, Nicholas Piggin wrote:
> >>> On Sun Jun 4, 2023 at 8:28 PM AEST, Nicholas Piggin wrote:
> >>>> Differently-sized larx/stcx. pairs can succeed if the starting address
> >>>> matches. Add a size check to require stcx. exactly match the larx that
> >>>> established the reservation.
> >>>
> >>> Hmm, question: reserve_addr is a VMSTATE field, but reserve_val is not
> >>> (nor reserve_size after this patch).
> >>>
> >>> Blue Swirl added that with commit a456d59c20f ("VM load/save support for
> >>> PPC CPU"), and when reserve_val was added in commit 18b21a2f83a
> >>> ("target-ppc: retain l{w,d}arx loaded value") it did not get migrated.
> >>>
> >>> Could we end up with reserve_addr != -1, but with a bogus reserve_val,
> >>> which could then permit a stcx. incorrectly? Not entirely outlandish if
> >>> reserve_val starts out initialised to zero.
> >>>
> >>> Could we just clear the reserve in cpu_post_load? It is permitted to be
> >>> lost for an implementation-specific reason. Doesn't seem necessary to
> >>> try keep it alive over a migration.
> >>
> >> It's not a bad idea to flush the reservation over migrate.
> >
> > Is there any particular reason to do so? The default simple
> > thing is "if this is state that persists across instructions
> > then migrate it"; we usually reserve "do something special in
> > post-load" for oddball cases where "just copy the data" doesn't
> > work.
> >
> > target/arm migrates both the exclusive addr and value.
>
> ppc is adding "size", which arm technically should have as well.

Arm allows an implementation to require the transaction size
to match on loadexcl and storexcl, but doesn't mandate it, fwiw.
(Also, our implementation is miles away from the architectural
requirements anyway because we operate on virtual addresses,
not physical addresses.)

> > target/mips migrates lladdr but has forgotten llval
> > (and perhaps llval_wp and llnewval_wp, depending on what
> > those fields do).
>
> So, similarly, would need to handle migration for which all of the required data is not
> present.
>
> The thought is, rather than migrate this new data also, and handle compatibility, simply
> discard all reservations.

I don't see a problem for normal migration and snapshotting.
I do wonder whether this would have a bad interaction
with record-and-replay's use of snapshots. Does that
expect "execution from the loaded snapshot" to match
"execution continues from point of snapshot save" ?

-- PMM

