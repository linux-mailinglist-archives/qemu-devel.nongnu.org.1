Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD816833579
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 18:23:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRF2T-0003ry-Ni; Sat, 20 Jan 2024 12:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRF2S-0003rE-2e
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 12:21:48 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRF2P-0005hc-U9
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 12:21:47 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55ad2a47b7aso423136a12.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705771304; x=1706376104; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=El1IPxVATvZQF2SL5cuZmYnuw3i+5lISk/7v+eW+mVQ=;
 b=Xi6fLxx9A0JarUFrtKGVkqSP6c01MjKzHojC7vEFGr/YZIa8dQ5YTD1dLmOhdsFLS5
 zz8Hqxiiu6zYqk4jvq43y6UKNfy7AUZ8+7+er3vh9KSTdXHO9uZW5naQ8KMSrwQL1ZTM
 bw1r1CLvShfMXfgPx89nzJDZmjPcpfuuY0YZOH7e8VSw0cKBKJHrzEMW8kP36OxTRAaW
 LkhLFjfYymx019l4pUFKQtJlzmgNoUnHMDB7IFV0vAjx8Hel/CzUp4SvmItXTOE0dztC
 QX50H4lHNHwOOG+pezzQYEiDauQ7C/kxqEgolcm4JWFvubIb1dVm4n5IJ8RaPsh51FZw
 /3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705771304; x=1706376104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=El1IPxVATvZQF2SL5cuZmYnuw3i+5lISk/7v+eW+mVQ=;
 b=eAMx6n2n4ifjUvmef8VTXsyMa83cRliXwLsyb7BmXQls7PJSGWceWfLVk/mjD19T3k
 jGUQxQoXknL71rWdkwR5fR1HnfhZTP8LskJxSCthZw1FzftdK8XOzBRDxHDEqn1+zKOK
 LL85k1pLba3Q5TbHaAvNT08f88ic6EL6GXRfrhRcPC1znq7GjXj4eLNSubBoUhryp3H7
 uwXtRtenA2k8L5qSC3yU3tgbIm8FlQP/2yhFnW6kVTuergc4VC8jRGciJg/SOx1wv3Gm
 EQrjI+DB2RiIVpFHk3PpddMH0zbJZAsM+Yx/TovCvDLryn42o1Ds/cjXCQAyOuIeibx1
 mJzQ==
X-Gm-Message-State: AOJu0YyaTJZdTjcA9Id+rPbRpMadl32tir7pazcprRwHFbK7o7oucivu
 zt+jxNUpC5QV5vu/WdO/dvow59y+cZ6CG7EY5RBNJZMQG4nxZl5FCF9CSU9bC0YsIKC9kYvhC1e
 WjlLnjcwQ13+PsklLRWM1PUCm9rt9aXVKDRF9Kw==
X-Google-Smtp-Source: AGHT+IGKyTfHUu70C6Rib/jhywPObrggqGXKXAxcgmQurS8J2x3g29vW0ZDtj7tYs/olPbKjqUauGkL377j18ofKC6E=
X-Received: by 2002:a05:6402:2d0:b0:55b:fe4f:eed2 with SMTP id
 b16-20020a05640202d000b0055bfe4feed2mr211508edx.121.1705771304171; Sat, 20
 Jan 2024 09:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20240119181327.236745-1-kwolf@redhat.com>
In-Reply-To: <20240119181327.236745-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 20 Jan 2024 17:21:12 +0000
Message-ID: <CAFEAcA9eR1Hs9CUu7MTdMsc93kUXt_btzS364AaO6V1axn5P8g@mail.gmail.com>
Subject: Re: [PULL 00/14] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 19 Jan 2024 at 18:15, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 3f2a357b95845ea0bf7463eff6661e43b97d1a=
fc:
>
>   Merge tag 'hw-cpus-20240119' of https://github.com/philmd/qemu into sta=
ging (2024-01-19 11:39:38 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to ced0d71c5270bed828ed2bd4b116ddfb12862bf9:
>
>   block/blklogwrites: Protect mutable driver state with a mutex. (2024-01=
-19 18:45:44 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - virtio-blk: Multiqueue fixes and cleanups
> - blklogwrites: Fixes for write_zeroes and superblock update races
> - commit/stream: Allow users to request only format driver names in
>   backing file format
> - monitor: only run coroutine commands in qemu_aio_context
>
> ----------------------------------------------------------------

Got some compile failures on this one; looks like the compiler
on our s390 box didn't like this:

https://gitlab.com/qemu-project/qemu/-/jobs/5973441293
https://gitlab.com/qemu-project/qemu/-/jobs/5973441291
https://gitlab.com/qemu-project/qemu/-/jobs/5973441330

In file included from ../include/qemu/host-utils.h:33,
from ../include/qemu/bitops.h:16,
from ../include/qemu/timer.h:4,
from ../include/block/aio.h:24,
from ../include/block/aio-wait.h:28,
from ../include/block/block-io.h:27,
from ../block/blklogwrites.c:15:
../block/blklogwrites.c: In function =E2=80=98blk_log_writes_co_do_log=E2=
=80=99:
../include/qemu/bswap.h:148:36: error: left shift count >=3D width of
type [-Werror=3Dshift-count-overflow]
148 | ((((_x) & 0x00000000000000ffU) << 56) | \
| ^~
../block/blklogwrites.c:409:27: note: in expansion of macro =E2=80=98const_=
le64=E2=80=99
409 | .nr_entries =3D const_le64(0),
| ^~~~~~~~~~
../include/qemu/bswap.h:149:36: error: left shift count >=3D width of
type [-Werror=3Dshift-count-overflow]
149 | (((_x) & 0x000000000000ff00U) << 40) | \
| ^~
../block/blklogwrites.c:409:27: note: in expansion of macro =E2=80=98const_=
le64=E2=80=99
409 | .nr_entries =3D const_le64(0),
| ^~~~~~~~~~
cc1: all warnings being treated as errors

thanks
-- PMM

