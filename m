Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB9177323D
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 00:03:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT8IR-0005Sm-K3; Mon, 07 Aug 2023 18:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbagley@ventanamicro.com>)
 id 1qT8IN-0005SV-Lr
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 18:01:48 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbagley@ventanamicro.com>)
 id 1qT8IL-0000aR-0l
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 18:01:46 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-40feecefa84so20399031cf.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1691445700; x=1692050500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iKl9lsH1P1fo5svgWafgkJpB7I9OEKFXSUNGXWdOsJM=;
 b=f4f4wQx4mEnl4QfSNsizykkxi/l6tSMOr212pxsggTZMGpPMHesK9Au2xGy7XTVSxm
 F5VUHGVXeIGMc5oGsTF9BG9MBArDDhpxFurwvW88v0H5mzIF8wOK/QGyOVYtoOtS92at
 7JXHM82c0UhWeG+1k8eIMtHUZ3YMHHCUpEZni4YXuCuzKD2ANPhH2o5DqHaBYRTeApVw
 b+Ybryn9IfOsHA0Q/H05EZLZckzN9eV4BIVpw6fSnX0qLExYp2804wuN+orPiSq+sGmM
 TGTdNayEhIxK4GY+90qN/gsnXyLEo+YVqcXxHxWqzbY9jG0bAGgjDkWuIsx8b7YDwhVo
 KIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691445700; x=1692050500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iKl9lsH1P1fo5svgWafgkJpB7I9OEKFXSUNGXWdOsJM=;
 b=IJ4wk4XOvfuXH2M1wh/GorMizsrkvzMXMzwy3h/NCWyWwTKvMXyZQoDIonhvejgRCz
 4UHPv3po1iASfInFbr5d7nfANaenHyvMBBxzYAfXX97JZYKr641rngRb6TlgH67I+A7t
 2ITccKB4w1I5aaNZHd4BvZRf+iX7+YqDFCrsJ+yThWLp0NwhLLSHBlB9i34OYbdJzOlr
 YwJKFAsXwdrfP5nW04d4azYg8kn7PuzcH7GIEnIRUmuKL3ltPnpV4mb8aicSddEJS5wB
 X3QQofGjCoAFJBMNt9w8L35Wk7gUJNcMyuCXUhtheJ7Cu2QAu+ROjPecs9mtcqUNzluT
 qqTw==
X-Gm-Message-State: AOJu0YzI2NzcPsxcsNXfZFFI5VFGGruOCu+ePacVZhGKHLydiD2RPK6U
 tY2PEkpX3JAhlSUdwfMWTBlfDYPpp87gYxTDJX1n4Q==
X-Google-Smtp-Source: AGHT+IEmHqWDEuVC7sazCZxWOannpM445FAblBhXu9M7Ps8juI5u9vZgqpgGd/NgQx5zqjoXSi961Rq1kHLRMtRshOc=
X-Received: by 2002:a05:622a:148f:b0:403:a0a4:97d5 with SMTP id
 t15-20020a05622a148f00b00403a0a497d5mr8791660qtx.36.1691445699926; Mon, 07
 Aug 2023 15:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230731183320.410922-1-rbagley@ventanamicro.com>
 <4b38596d-1db6-e03f-8b42-65c4464132ab@linaro.org>
In-Reply-To: <4b38596d-1db6-e03f-8b42-65c4464132ab@linaro.org>
From: Richard Bagley <rbagley@ventanamicro.com>
Date: Mon, 7 Aug 2023 15:01:28 -0700
Message-ID: <CAARkPA_6=u6fM6F4RYC9Zdfw0iQ6sE5Zp1649gAr3_BBR-GRMg@mail.gmail.com>
Subject: Re: [PATCH] disas/riscv: Further correction to LUI disassembly
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, dbarboza@ventanamicro.com
Content-Type: multipart/alternative; boundary="00000000000019f21306025c648d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=rbagley@ventanamicro.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000019f21306025c648d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I do apologize, but I do not understand your remark at all. Could I trouble
you to spell this out.

In:
+                snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12 & 0xfffff)=
;
0xfffff is a mask which recovers the 20 bit field used to represent the
immediate in the instruction encoding.

You seem to be responding to the syntax, which is unrelated to my change.
But I did notice it is the case that both GCC and LLVM disassemblers do not
accept signed integer arguments to LUI:
lui r1, -1
but instead require
lui r1, 0xfffff
I don't see why the former is more accurate, but it would be an aid to the
assembly programmer.

I have recommended internally that if the current format cannot support
both, then it might be worthwhile to propose a pseudo instruction for RISCV
for precisely this syntax variant:
lui.s r1.-1

Richard

On Mon, Jul 31, 2023 at 1:37=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/31/23 11:33, Richard Bagley wrote:
> > The recent commit 36df75a0a9 corrected one aspect of LUI disassembly
> > by recovering the immediate argument from the result of LUI with a
> > shift right by 12. However, the shift right will left-fill with the
> > sign. By applying a mask we recover an unsigned representation of the
> > 20-bit field (which includes a sign bit).
>
> Why would you want that?  Surely
>
>      lui r1, -1
>
> is more accurate than
>
>      lui r1, 0xfffff
>
>
> r~
>

--00000000000019f21306025c648d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I do apologize, but I do not understand your remark at all=
. Could I trouble you to spell this out.<br><br>In:<br>+=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(tmp, sizeof(tmp), &quot;%d&=
quot;, dec-&gt;imm &gt;&gt; 12 &amp; 0xfffff);<br>0xfffff is a mask which=
=C2=A0recovers the 20 bit field used to represent the immediate in the inst=
ruction encoding.<br><br>You seem to be responding to the syntax, which is =
unrelated to my change.<br>But I did notice it is the case that both GCC an=
d LLVM disassemblers do not accept signed integer arguments to LUI:<br>lui =
r1, -1<br>but instead require<br>lui r1, 0xfffff<br>I don&#39;t see why the=
 former is more accurate, but it would be an aid to the assembly programmer=
.<br><br>I have recommended internally that if the current format cannot su=
pport both, then it might be worthwhile=C2=A0to propose a pseudo instructio=
n for RISCV for precisely this syntax variant:<br>lui.s r1.-1<br><br>Richar=
d</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Mon, Jul 31, 2023 at 1:37=E2=80=AFPM Richard Henderson &lt;<a href=3D"m=
ailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 7/31/23 =
11:33, Richard Bagley wrote:<br>
&gt; The recent commit 36df75a0a9 corrected one aspect of LUI disassembly<b=
r>
&gt; by recovering the immediate argument from the result of LUI with a<br>
&gt; shift right by 12. However, the shift right will left-fill with the<br=
>
&gt; sign. By applying a mask we recover an unsigned representation of the<=
br>
&gt; 20-bit field (which includes a sign bit).<br>
<br>
Why would you want that?=C2=A0 Surely<br>
<br>
=C2=A0 =C2=A0 =C2=A0lui r1, -1<br>
<br>
is more accurate than<br>
<br>
=C2=A0 =C2=A0 =C2=A0lui r1, 0xfffff<br>
<br>
<br>
r~<br>
</blockquote></div>

--00000000000019f21306025c648d--

