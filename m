Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6447580DDA9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:58:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCoHb-0002Cf-6y; Mon, 11 Dec 2023 16:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rCoHZ-0002BY-8x
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:57:45 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rCoHV-0003fm-B1
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:57:44 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c9f8faf57bso64068421fa.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1702331859; x=1702936659;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UKPVikaa2BLezfE8Nh/92umz0KQtEqI+41mcl4l0ePw=;
 b=ewDeVlty+NacT5KASby9VXFQzjrugXfFt1BNCs+irXsTr/7cg8+zsd/uiEVDHUrnQF
 LMxSjza+p3PblaRyvh4sf0B18iGACQRq2vK7xCvJ8EQC+i/CdUofv/7lhZyV9ezItVEn
 oEjp4uQiPuT/hcompbxbXPSpbyYdFYLLuDKfH3Dzo5+6aIOZtNXxZeWBwMbj09y6Hbc4
 QoEyClt3CIetZyBQfuEbOwWQoONNVKuAYILc2Zg36nOXFe61bfV+Cqjrt9f+bd3fRogx
 vqMOoGu4twmm7lW4SaYfiY6Pntvv7ubtja4h4uq2wMOTmPyuctR4BA//pNPL9P7snKWd
 GWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702331859; x=1702936659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UKPVikaa2BLezfE8Nh/92umz0KQtEqI+41mcl4l0ePw=;
 b=S/y+m7rQ6DJDor6iqLXQuxhvnsB/X46t3YOoY1QRIEbgMCgdDTIOppud4KzPIICWCX
 cHDwlA+tQAi6jblxY06QQn/nGUFfNZUaxmCjTrIGL5lgAaaip8sK3pAgVxddFXz/ZC4k
 faOjPyIsbP4/6IG6uyhHQEJsm5/bwBPA4MBkpO3s6q/ihhhiQ4V+dRY9DvtgZsuzLeff
 Vq2SQXsn2SZHpS/UHWwAIk3c9bIGv78nU8Q/Ab6ueMxhjqWA/rozr+UvGdVn9lhzl8ag
 AyWLdIX6eU0EKzHx0xY+7C/GVfZpSTtlbz8rBgWdz30TrAGPRK4PwTr30pHXKwhvksqA
 3bFA==
X-Gm-Message-State: AOJu0Yw+I7/UEqU5/Em8xEn+H/5ZQ/TIW5Xa7cM1yX/f0G8VU7ku81j5
 mC3JA/Wlt87ADtOu+gt4UeduUiCcbHicr3ItCoePUA==
X-Google-Smtp-Source: AGHT+IG2qMuzvVV1CtWvhYnE38e244SwEqL/xcTix+Kr15BR7ZuKHiaqT3xa9LzluUeec4JTOBB8iJLUsObH0AmIbdY=
X-Received: by 2002:a05:6512:3a92:b0:50c:de34:da09 with SMTP id
 q18-20020a0565123a9200b0050cde34da09mr3009336lfu.101.1702331859299; Mon, 11
 Dec 2023 13:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-15-philmd@linaro.org>
In-Reply-To: <20231211212003.21686-15-philmd@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 11 Dec 2023 14:57:28 -0700
Message-ID: <CANCZdfoHViOt9-wnZ_HxHpKm2r2A_RH90MVjMF3tGjRvnjTd-w@mail.gmail.com>
Subject: Re: [PATCH 14/24] gdbstub: Include missing 'hw/core/cpu.h' header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>, 
 Claudio Fontana <cfontana@suse.de>, Brian Cain <bcain@quicinc.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c3897e060c430573"
Received-SPF: none client-ip=2a00:1450:4864:20::22d;
 envelope-from=wlosh@bsdimp.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000c3897e060c430573
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 2:22=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Functions such gdb_get_cpu_pid() dereference CPUState so
> require the structure declaration from "hw/core/cpu.h":
>
>   static uint32_t gdb_get_cpu_pid(CPUState *cpu)
>   {
>     ...
>     return cpu->cluster_index + 1;
>   }
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  gdbstub/gdbstub.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000c3897e060c430573
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 11, 2023 at 2:22=E2=80=AF=
PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Functions such gdb_get_cpu_pid() dereference CPUState so<br>
require the structure declaration from &quot;hw/core/cpu.h&quot;:<br>
<br>
=C2=A0 static uint32_t gdb_get_cpu_pid(CPUState *cpu)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 return cpu-&gt;cluster_index + 1;<br>
=C2=A0 }<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0gdbstub/gdbstub.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br></blockquote><div><br></div><div>Re=
viewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com=
</a>&gt;</div><div>=C2=A0</div></div></div>

--000000000000c3897e060c430573--

