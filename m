Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E05E82C30E
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:49:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJlm-000860-Ph; Fri, 12 Jan 2024 10:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOJlk-00085i-2l
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:48:28 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOJli-0007Cj-AV
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:48:27 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50eabbc3dccso7487408e87.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 07:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705074504; x=1705679304; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWfUZBrpFBYLJCz0l644xS3QFaDYEE69oys2BOsjpkk=;
 b=go4+xzbpSil3/v7ncm2JjzyenTh0mxvxylNWp98vvWbpUujVdFaz+Y+IvoUl6WFwM6
 bjG9tmsbuUQdgAPtYFl9CPM6eG4K2+5HbxiHf47z2mWGh4fKaG/C98Npf4S5a38RKSqi
 YnHTcrOX822VhLAkZvQk6c7kQEQN1IeotkO+iNs6IsmlHSGKKwIpppCIUwJM6NWnuVQ/
 ToFBujmsyZEbtgzhVJFMDloXJS+Dm+qlOajwji3C0sP+yt4Jvm/YOeoMVwGrOe01WFfN
 +VOf0YsNHFai+fONfC72zgSoizTgmwR/voYMzldgX3uJ9gCXIw/y9ur9viDFn5orD0ku
 yNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705074504; x=1705679304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWfUZBrpFBYLJCz0l644xS3QFaDYEE69oys2BOsjpkk=;
 b=jbLgk+dMyYF8u79UnC+nqPC+4cPr1Kv+UK2TWU9aQ3c5xg2kB9s0YAktI+RjdipATQ
 uVe/Cjx+vBP+6Ps5dyU/Vk/KlAwKQKHnFn5UtF/bijaAdSjLVWDu2WDS9TgaGUvoSsLn
 pYCHcEIrVhE/Ss5GfPueTKKoeVT3OoDeX56mHPu4sLsKDIjB5Rm9CwDQcYqoGqtymBS8
 Gw45GgGD8cTu44Z143NYKZj6B+tWMBk2D1EmWNHuBAB9vSt3Vpo+JZpZHs3QqdMItMg6
 KnOF8D4lNC4+WkHeSm4rW3OmniVPlPhNCvBqQrrtq1zRoEzLDiFWjnyqy2RFVoMLl9dj
 GRww==
X-Gm-Message-State: AOJu0YyY/Thjefv+OJn3TG+aAZXQDHI7Q4R43kt243By1ftmy98JaPj5
 jmSNufSfUCe153LJXMoB6S6IvFupnR6u41Z8urNyI/DyUw0uPA==
X-Google-Smtp-Source: AGHT+IGE86OX4KgQzLWq+VSCBwIu5IxUbwAz8Xb3YUbcTrxGZWNPSC3x6NtxZDKLqfGLpauhiqAFOM3AK6bg3tnsYLI=
X-Received: by 2002:a05:6512:1596:b0:50e:8eae:3c4d with SMTP id
 bp22-20020a056512159600b0050e8eae3c4dmr396126lfb.254.1705074504368; Fri, 12
 Jan 2024 07:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
 <20231211071204.30156-2-tomoyuki.hirose@igel.co.jp>
In-Reply-To: <20231211071204.30156-2-tomoyuki.hirose@igel.co.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 15:48:13 +0000
Message-ID: <CAFEAcA9Sp0fVBkAyKFwVwt6F+Bzt4X6UfqhyqFkn25Z14TjZSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] system/memory.c: support unaligned access
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Mon, 11 Dec 2023 at 07:14, Tomoyuki HIROSE
<tomoyuki.hirose@igel.co.jp> wrote:
>
> The previous code ignored 'impl.unaligned' and handled unaligned accesses
> as is. But this implementation cannot emulate specific registers of some
> devices that allow unaligned access such as xHCI Host Controller Capabili=
ty
> Registers.
> This commit checks 'impl.unaligned' and if it is false, QEMU emulates
> unaligned access with multiple aligned access.
>
> Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>

Sorry this has taken me so long to get to reviewing.

So, first of all, I think this is definitely a cleaner looking
patch than the other one that C=C3=A9dric posted a link to: if we
can have access_with_adjusted_size() cope with the unaligned
case that seems nicer than having different functions for the
aligned and the unaligned cases.

My review comments below are basically about fiddly corner case
details.

> ---
>  system/memory.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/system/memory.c b/system/memory.c
> index 798b6c0a17..b0caa90fef 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -539,6 +539,9 @@ static MemTxResult access_with_adjusted_size(hwaddr a=
ddr,
>      unsigned i;
>      MemTxResult r =3D MEMTX_OK;
>      bool reentrancy_guard_applied =3D false;
> +    hwaddr aligned_addr;
> +    unsigned corrected_size =3D size;
> +    signed align_diff =3D 0;
>
>      if (!access_size_min) {
>          access_size_min =3D 1;
> @@ -560,18 +563,25 @@ static MemTxResult access_with_adjusted_size(hwaddr=
 addr,
>          reentrancy_guard_applied =3D true;
>      }
>
> -    /* FIXME: support unaligned access? */
>      access_size =3D MAX(MIN(size, access_size_max), access_size_min);
>      access_mask =3D MAKE_64BIT_MASK(0, access_size * 8);
> +    if (!mr->ops->impl.unaligned) {
> +        aligned_addr =3D addr & ~(access_size - 1);
> +        align_diff =3D addr - aligned_addr;
> +        corrected_size =3D size < access_size ? access_size :
> +                            size + (align_diff > 0 ? access_size : 0);

I don't think this calculation of corrected_size is right for
the case when size < access_size. Consider:
 * size =3D 2, access_size =3D 4, addr =3D 3, little-endian:
memory contents from 0 are bytes AA BB CC DD EE FF ...

We calculate corrected_size of 4, and we will then do a
single 4-byte read of 0xDDCCBBAA. But we need to do two
4-byte reads, because the final result we want to return
is 0xEEDD.

I think also that we don't really get the optimal behaviour
here because we select access_size assuming the aligned case,
rather than selecting it specifically for the combination
of input size and align_diff in the unaligned case.
Consider: access_size_min =3D 2, access_size_max =3D 8, size =3D 4,
addr =3D 2. We'll compute access_size to be 4, and then do
the unaligned access with two 4-byte reads. But we could
better have done it with two 2-byte reads. This matters
especially for the write case, because two 2-byte writes
allows us to avoid the problem of "what do we write for
the parts of the 4-byte writes that we don't have data
from the caller for". (See below for more on that.)

> +        addr =3D aligned_addr;
> +    }
>      if (memory_region_big_endian(mr)) {
> -        for (i =3D 0; i < size; i +=3D access_size) {
> +        for (i =3D 0; i < corrected_size; i +=3D access_size) {
>              r |=3D access_fn(mr, addr + i, value, access_size,
> -                        (size - access_size - i) * 8, access_mask, attrs=
);
> +                        (size - access_size - i + align_diff) * 8,
> +                        access_mask, attrs);
>          }
>      } else {
> -        for (i =3D 0; i < size; i +=3D access_size) {
> -            r |=3D access_fn(mr, addr + i, value, access_size, i * 8,
> -                        access_mask, attrs);
> +        for (i =3D 0; i < corrected_size; i +=3D access_size) {
> +            r |=3D access_fn(mr, addr + i, value, access_size,
> +                        ((signed)i - align_diff) * 8, access_mask, attrs=
);
>          }

So, with these loops, for unaligned accesses we now load an
extra chunk and adjust the shifts so we get the right parts
of the chunks we read. However I think we also need to be
careful with the access mask for the final access (or the
first access in the big-endian case).

Consider:
 * access_size =3D 2, size =3D 4, align_diff =3D 1, little endian,
   addr =3D 1 initially (so aligned down to 0), read:
and the memory being bytes AA BB CC DD EE FF ... starting at 0.
We'll load:
 * from addr 0, 0xBBAA, which we shift right by 1 for 0xBB
 * from addr 2, 0xDDCC, shift left 1, for 0xDDCC00
 * from addr 4, 0xFFEE, shift left 3, for 0xFFEE000000
and then we OR those together for
  0xFFEEDDCCBB
so we will have written into *value an extra 0xFF byte that
we should not have done. That last access from addr 4 should
have an access_mask that says we only want part of it.

For writes, things are worse, because we'll do a 2 byte
write that writes whatever garbage might have been in the
high part of *value. If the device permits an access of
smaller size (in this case byte) we can do the end part at
that size (or even do the whole write at that size if it's
simpler). If the device doesn't permit that smaller size
write it's not clear to me what the behaviour should be.
(I was going to suggest maybe we should just rule that as
not permitted until we run into it, but then your patch 2
puts the xhci-usb device into this category, although
harmlessly because it happens to implement writes as ignored.)

thanks
-- PMM

