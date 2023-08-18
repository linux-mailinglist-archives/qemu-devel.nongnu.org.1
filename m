Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC917812D8
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 20:25:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX49q-0001mI-UK; Fri, 18 Aug 2023 14:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qX49o-0001m9-IQ
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 14:25:12 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qX49l-0002ER-Cc
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 14:25:11 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c4923195dso152343366b.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692383106; x=1692987906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DLh2CMWCkN4Zti0P11RzKF35M0KWchDodnwEyTQvmS4=;
 b=zWVi9/m0dlrgLBDgFyE7X8NNBNqFE71iLxpNy5MjHtizBF/d+ImW60f4Fd/jdQNKGC
 3bElU9Tmx/WsH7473aNtJ4HsV0KnSTmwGp/41qBhjQVYwVuKXrWx4l4V2Jl56Un/+bkm
 gXGNQlkNV+GS7aBUR7fnBqaxcOrX4xTCCWf9Isw1H9pbQAchOP4LuZgo3ZRKhzwpmCyo
 /UUMhQ1rO/367vcYcgzEsU91PUajNRq7AyFidmOSUFX26NqcIeWzy6HkAfI+stOQBAfR
 9XoDw/o32nqW8vEidOlEd1+ucjZj4/PqCuh6N0OqH+KjICqGaLfe9fXi/lt2XEhvJAv7
 a2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692383106; x=1692987906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DLh2CMWCkN4Zti0P11RzKF35M0KWchDodnwEyTQvmS4=;
 b=YkVmjQqAabMWnpIv26ryzBoHtqgVH7OiUdMMpAtD5y3gjHLeaXqbcfAOdvBkBr32C4
 SZTpzK8g8Jxsc2DDHZR/PZ5LraIQjvN83U9HTQ5axEmDRhzDg0oBdgIrY4jVURWXBgYq
 UO1oKvHoVpGPMtLQaFH997Tv7Tk0sZS4Z16kfS5dTwVsYWc4umgQ7BVCkXTlT87ENNvS
 Deb3+PPwiFcx1HqS563Ezwl69nRZJzx6hzGcCTBkNxqGApBNkatj1Fb0LlHPVFXa05LY
 mjFaEKB8tSPPOKlpsmHrP5pPaGCG5qdku4LBpvyz6AI5cQL3DKsaLgI3HIXO5EDsa4Ql
 5yYg==
X-Gm-Message-State: AOJu0YxKwTQoJAzk/jtWKz/TPXwtEsVQ/A4FY/AMAP6v5d/zJrsfJyb5
 lijPc3QSndb4TjbOD/1n7fayObAvXmdWqrbWR9z+vay7z2MWbVzS
X-Google-Smtp-Source: AGHT+IFq8Cif5rHBHyAZFB9qvwX9kFH37a6/7qDwEluIGOou/1OFD73JuhTgZuswxpCTDygcE09/QNdnqPEKpRbyHhk=
X-Received: by 2002:a17:907:2714:b0:99c:d05d:4b2 with SMTP id
 w20-20020a170907271400b0099cd05d04b2mr2104450ejk.10.1692383106486; Fri, 18
 Aug 2023 11:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230818175736.144194-1-richard.henderson@linaro.org>
In-Reply-To: <20230818175736.144194-1-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 18 Aug 2023 12:24:55 -0600
Message-ID: <CANCZdfpQApwnk-BZO-bR7KfRB8+bc+AZV7i0qcexCmwzewgeMQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] bsd-user: image_info cleanups
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e2e4fa060336a5d7"
Received-SPF: none client-ip=2a00:1450:4864:20::636;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000e2e4fa060336a5d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

These all look good. Right now I'm planning on queueing them for the next
pull request I have, which is all the reviewed changes from my GSoC
student's work and one submission from another user in the bsd-user fork (I
think, that one's up in the air). So next week sometime after the release
(since last time I did a pull request on a late rc, it caused rebase issues
and there's no reason for me not to wait).

Warner

On Fri, Aug 18, 2023 at 11:57=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> This mirrors some changes I've posted for linux-user,
> removing stuff from image_info which is unused.
>
>
> r~
>
>
> Richard Henderson (3):
>   bsd-user: Remove ELF_START_MMAP and image_info.start_mmap
>   bsd-user: Remove image_info.mmap
>   bsd-user: Remove image_info.start_brk
>
>  bsd-user/arm/target_arch_elf.h    | 1 -
>  bsd-user/i386/target_arch_elf.h   | 1 -
>  bsd-user/qemu.h                   | 3 ---
>  bsd-user/x86_64/target_arch_elf.h | 1 -
>  bsd-user/elfload.c                | 4 +---
>  bsd-user/main.c                   | 2 --
>  6 files changed, 1 insertion(+), 11 deletions(-)
>
> --
> 2.34.1
>
>

--000000000000e2e4fa060336a5d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">These all look good. Right now I&#39;m planning on queuein=
g them for the next pull request I have, which is all the reviewed changes =
from my GSoC student&#39;s work and one submission from another user in the=
 bsd-user fork (I think, that one&#39;s up in the air). So next week someti=
me after the release (since last time I did a pull request on a late rc, it=
 caused rebase issues and there&#39;s no reason for me not to wait).<div><b=
r></div><div>Warner</div></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Fri, Aug 18, 2023 at 11:57=E2=80=AFAM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">This mirrors some changes I&#39;ve posted for linux-user,<br>
removing stuff from image_info which is unused.<br>
<br>
<br>
r~<br>
<br>
<br>
Richard Henderson (3):<br>
=C2=A0 bsd-user: Remove ELF_START_MMAP and image_info.start_mmap<br>
=C2=A0 bsd-user: Remove image_info.mmap<br>
=C2=A0 bsd-user: Remove image_info.start_brk<br>
<br>
=C2=A0bsd-user/arm/target_arch_elf.h=C2=A0 =C2=A0 | 1 -<br>
=C2=A0bsd-user/i386/target_arch_elf.h=C2=A0 =C2=A0| 1 -<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 3 ---<br>
=C2=A0bsd-user/x86_64/target_arch_elf.h | 1 -<br>
=C2=A0bsd-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 4 +---<br>
=C2=A0bsd-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 2 --<br>
=C2=A06 files changed, 1 insertion(+), 11 deletions(-)<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000e2e4fa060336a5d7--

