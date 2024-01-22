Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB57835A71
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 06:47:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRn9t-0007Uq-S3; Mon, 22 Jan 2024 00:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rRn9r-0007Uh-Tl
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 00:47:43 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rRn9o-000559-TA
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 00:47:43 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7ce55932330so273061241.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 21:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705902459; x=1706507259; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LKJQdkjIADnOBOAtPA6xxokDrIg1kBmWLkAgWDRSFg=;
 b=haPS1pT67HwINHbtJOSR/7VxoKHUQLXcHhRPpVx7kX5QIN8iaejggiYv1/ES4XxYoV
 9aigZ8NrbQbYlOKm9zv57Guzq6/Tb7zW3wv94fZdwZJ5TjaoCFMzCNcwo66Ur/62yuGH
 9tgiJg5qGW+/R0LMLXnCKxr9EcuJuHJ6A1Td57jXAp2yu5q6n39CBYS+XEfngmQ53b1N
 ApEFA2PgT16uA/szzvEXubUAe+tuaGFs/swQbycaCjsTN4th1Sf7uHgU6jw2Hl+2iQ6S
 w9EXnyGBTvCNXE7Ex/p94y4XpXyWpoqSzYLlEZJMo7w7Z8PQjf0qVVt9izCArkraq74y
 L1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705902459; x=1706507259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LKJQdkjIADnOBOAtPA6xxokDrIg1kBmWLkAgWDRSFg=;
 b=krtLkCVZV72ulvrXlJXeJ5ve9P6WcfbgfbuBi1UsjsM2sGcqQHoEtSMgyCLRFBiN8c
 WArwVg9bFR5qP/X/jZ4zp18xy2g0BG/58cDiuXXTzP1gIaFkFV2a8H6Ep0rEgEyzNR3m
 p+zrM0x0ee770EF1C5O4UM8OAOghhyst1VYWN5FRpGGKJ4yFsc32FJPBdSh9KQ8xLd72
 oh3ilFQjJGMkMB7jUiLarlBPdeIpHo3bbqABHOhyYhtFLaDGvBiznQ3hTvETisI2XFJS
 7BDVyxbPcl08rlwU702s1GAwA0tDcdV33MNcUk9W2nVlVjBhC1nT1h/s9wJP6Dso0tMK
 hBEQ==
X-Gm-Message-State: AOJu0Yz3EhvzX3S20x7Oo5dKgPAvBQAPrlN8XumKXxQP/zj5UK1ZRH5v
 75BPlOUodfgdNrpqkrCaS02H8nTfnVSdpqQyKXZor1NIpLmimw2cMpJHt7jZvA0QMNwvJIAVFsC
 nNqeQ5xjlrX0TWI5GwlBtdw307CU=
X-Google-Smtp-Source: AGHT+IEnp7aWj+bUSIyR0aacqEa3i13XX5PPNOkBhFAOy142I/y+WXDMD7lkzfRk3bCAfMlPIsw3cgIh7XqbZRehQXo=
X-Received: by 2002:a05:6122:4127:b0:4b6:ea3a:f87a with SMTP id
 ce39-20020a056122412700b004b6ea3af87amr814525vkb.4.1705902459677; Sun, 21 Jan
 2024 21:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20240112220348.49021-1-richard.henderson@linaro.org>
In-Reply-To: <20240112220348.49021-1-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jan 2024 15:47:13 +1000
Message-ID: <CAKmqyKOe9o-LYcA1GNCvjy-6CcB22e7EHGpnjdDpTpFXA=+9SA@mail.gmail.com>
Subject: Re: [PATCH] linux-user/riscv: Fix sizeof_reg typo in vdso unwind info
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Vineet Gupta <vineetg@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Jan 13, 2024 at 8:04=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reported-by: Vineet Gupta <vineetg@rivosinc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  linux-user/riscv/vdso-32.so | Bin 2900 -> 2900 bytes
>  linux-user/riscv/vdso-64.so | Bin 3856 -> 3856 bytes
>  linux-user/riscv/vdso.S     |   2 +-
>  3 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/riscv/vdso-32.so b/linux-user/riscv/vdso-32.so
> index 1ad1e5cbbbb8b1fe36b0fe4bcb6c06fab8219ecd..5829c1dc90f1c1aafde69f5b9=
f5bc9afb85251f7 100755
> GIT binary patch
> delta 112
> zcmV-$0FVFF7StB71OXHyD|k<wiZ(XN!ME<$oE!73r-+KP7y<qQJ!67mgJFbVg<pnV
> zhh2zViCc<Vi&>0VjaQCVk5!OVkyDaVlTnmVl~0yVmra;VnM;~Vn@OBVokyNVpGC7%
> S1ndF^OjB%HZ#A<;2M+}Mt1p-U
>
> delta 112
> zcmV-$0FVFF7StB71OXI7ek-E|Z8Fh9(G%V1AYqwmRqNri7y<qQJz|1jgI<JOg<6JK
> zhgOJGiBgJCi%yJ8jY^J4k4BJ0kwTI{lRlI@l{%I<mo}I*nKGI%n=3DYIzohqIvpC+?Y
> S1ndF^P;+@qVQaHR2M+{CwJgd2
>
> diff --git a/linux-user/riscv/vdso-64.so b/linux-user/riscv/vdso-64.so
> index 83992bebe6d0182f24edfffc531015fd2f4e1cfb..de18e35537a493ba35307e93a=
2d33faaf489c0b3 100755
> GIT binary patch
> delta 118
> zcmV-+0Ez#Q9*`cepaB$miap5s7G5`$2#eqLH6<vG8d2V}v;pe_KY{^*fB}PkgnWg1
> zhIof|h;)f^ig1f=3DjBJf+j%bf&kYtf!l3<fwlw6fsmROfom{gfknoyfgoJ^fco=3DBfY
> YlidYEvmgdT0|snTdTn?%vuO#Z1^ZDlW&i*H
>
> delta 117
> zcmV-*0E+*R9*`cepaB$}OC4Olbn*vwtO;!U^UJ?5jVB4Sv;pe_K7av&e1mv|bcJw+
> zY=3D>xwWQkykT#HzYRE<!MOpi#AM3F#}Jd-$-G?g%xESD&lB$*(Z9Ge)N6rB*B44(*-
> X-UULl9|lAN23SxxMKVLPX$hwVbapOM
>
> diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
> index a86d8fc488..4b4e34aeea 100644
> --- a/linux-user/riscv/vdso.S
> +++ b/linux-user/riscv/vdso.S
> @@ -101,7 +101,7 @@ endf __vdso_flush_icache
>         .cfi_startproc simple
>         .cfi_signal_frame
>
> -#define sizeof_reg     (__riscv_xlen / 4)
> +#define sizeof_reg     (__riscv_xlen / 8)
>  #define sizeof_freg    8
>  #define B_GR   (offsetof_uc_mcontext - sizeof_rt_sigframe)
>  #define B_FR   (offsetof_uc_mcontext - sizeof_rt_sigframe + offsetof_fre=
g0)
> --
> 2.34.1
>
>

