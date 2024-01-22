Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6472F836538
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 15:20:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRv8a-0000xQ-Kb; Mon, 22 Jan 2024 09:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRv8Z-0000wx-3B
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:18:55 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRv8W-0000gW-FS
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 09:18:54 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55c33773c0aso983550a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 06:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705933130; x=1706537930; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRWvhIFT3K5FYkwfKQZANlw0/6MnU5gH7CMC4lMEBTA=;
 b=W/PNptJnLD6JPVeN+q95HCficcCKyxfh7/xfhO0JkxGiz1XuZUKnjTxHDBWL0Q7TpS
 P8qc533YXyoSRZpVg6D4CK96SV2GhRWuVWL60mYQDchwX0E/uZk9oWTPsev+Pbc0B7yu
 XDr8J/Qu4uAgj2CtEpKiRwZboEsVht9OIaGVFyW4SlD86kbeeQJnTMw6F5FYrk1tm52B
 7DGQ3U4KvnEkZid6Z8AfwBVEBC3YoNUrA8PsTkj89828zAFiqPYLIHBwA2uD8cs5nJbY
 1zk+CAFfE+4ngTYsTsGAaFcmj3pHZXBiZLBTKrUmftF2YjTzYITDAoLfw2/YYPtOduhV
 Q5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705933130; x=1706537930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRWvhIFT3K5FYkwfKQZANlw0/6MnU5gH7CMC4lMEBTA=;
 b=VTQkLTdRuWYP243oVd1bgzbhN6qwfVRHqMXOBVNi2u5M5WGiJpdIZ2NRwkUlK8Jw55
 FS1hDu1RXwoNwsVV7GFWDqe/W2sppCFTx0OjrL5LElSjt1Ta3N5/jp/q1AzYHJBH7zDP
 1RmnnHEBYaSZXtiIA5USi3RLNpgkKOVR3m8uD9lYmOZ0Ivi7fvz5ppg3ml0BlF4YJo75
 HkbY+/coZX6AHHCsz+tBFJFrjKdyfpbhnD+LOC6l+rfDM1tZzwBVwfUC1OfTpCdwTSu1
 Bjp8WmUqmUCwySEaD31d7/yGl9+Z5hXPu1yYR5DEdmzIS0bG+VWLq8zVNm406FYjEoJC
 XvlA==
X-Gm-Message-State: AOJu0Yy02qElLEXLm1Gy8Yp1kY7uJSZqkMaD5aEy1GJ4AOHSEfr+Rwub
 tMmSY1isZMB9V1e05t+mP8gj9kQuuth+2zW9RXHQckzyxzdq626heZ8/hNoYwDnmaVXsW9gN3WQ
 XX+rGRMR2JsXfdRSijmTLXhV6sL9v36hzTUd6zrjzOeQuhEPz
X-Google-Smtp-Source: AGHT+IFVdGWwN201u8RYqyYfyaW+bGg4QOUdvIoBcvxus00hIDetGiFydmIiDA9tBjZKbSRnqhJ8lwegnpS7mg/+h4o=
X-Received: by 2002:a05:6402:270c:b0:55c:2609:e3c8 with SMTP id
 y12-20020a056402270c00b0055c2609e3c8mr1878649edd.19.1705933130484; Mon, 22
 Jan 2024 06:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20240122094230.283653-1-pbonzini@redhat.com>
 <aa777c77-c55a-4737-afc6-d8c2a3111814@linaro.org>
In-Reply-To: <aa777c77-c55a-4737-afc6-d8c2a3111814@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 14:18:38 +0000
Message-ID: <CAFEAcA8VP9eo8i1kXyJGGtw5QhMvxw3FJHN+i39MNEafLLPm9A@mail.gmail.com>
Subject: Re: [PATCH] hw/xtensa: require libfdt
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 22 Jan 2024 at 11:10, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
> On 22/1/24 10:42, Paolo Bonzini wrote:
> > Always allow -dtb in qemu-system-xtensa.  Basically all other targets r=
equire
> > it if it can be used (including for example i386/x86_64).

> I've been wondering for some time why not requires libfdt
> for all sysemu targets. It gives some pain with MIPS machines,
> and I wonder if there is any value in not including it.

I think traditionally we wanted to avoid the dependency
for the common case of "I only care about x86 guests",
back when fdt was mostly limited to ppc or arm, but since
these days even x86 sets TARGET_NEED_FDT there's something
to be said for just making it obligatory.

Guest archs which *don't* use fdt:
 alpha cris hppa m68k s390x sh4 sparc tricore xtensa.

Of those, s390x is the only one with KVM support and
so the only one where maybe somebody might care about
the extra dependency for security auditing purposes.
But given it's already in x86 binaries I don't think that's
a very strong argument. The rest are all "minor" architectures.
So if making fdt mandatory makes our lives easier for
development purposes I think we should go ahead and do it.

(mips is a bit odd because only mips64el-softmmu sets
TARGET_NEED_FDT, not the other mips configs. Since upstream
Linux has an arch/mips/boot/dts/mti/malta.dts, presumably
in theory the 32-bit boards also ought to support -dtb and
friends; though CONFIG_MIPS_RAW_APPENDED_DTB makes this
not a problem in practice.)

thanks
-- PMM

