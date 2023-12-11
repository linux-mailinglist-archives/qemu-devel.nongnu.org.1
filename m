Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5A480DDB9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:59:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCoJN-000331-NH; Mon, 11 Dec 2023 16:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rCoIk-00032m-Rn
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:58:59 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rCoIe-0003ra-Qh
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:58:58 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c9f4bb2e5eso69169651fa.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1702331931; x=1702936731;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ag5QWYGMr8OKDlGLjEjdsqgHLAGNFiobL7ohMrWWdmY=;
 b=vr98vJrmfF/6lDU6WLt9tB+dM5rJXnmBzoDHbhYbaCvvnpx1qp5CKryCgMc18SRNod
 R5jNwPfHVnnTi2EkU3+tRzEYQ7BCeb+YAa0lJn1rZ9A+K5gWmuv86TjK7ephi/55F0cG
 FBCn9FGti3kuQbwJYHpU2nUXWwFlo7lX5XXCsFmd0DVMvss4Bm0OARgZpE+cnhDvlnu/
 xDLHtaYRi2Sk/Wn7GuVl2R1PaXok2Q1+MNAAo6GpruUE1UrQ1dZoumGrXZ3V5yLDDv/t
 5mp+vn/sWHsuBLocH8CocAcah4UuMGXLqGyLmYw38paKsgIVmvrj2sMS6iB694w6ILaW
 /qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702331931; x=1702936731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ag5QWYGMr8OKDlGLjEjdsqgHLAGNFiobL7ohMrWWdmY=;
 b=W3AKGcQoxPDkq7/Yc3MCtOkb3blm2U2Fh6SMlFejrXf7OMJWQk9Q3lKzPyJIPjnFrg
 2TnwhhV+TgDDdObQeBNmGwVxlLjvncxzhEH51CI7xYZ1HEISuHBDbQ2TJZp6yC0DYP3K
 p7N6Vk/Q5FIdhauNU8zqWx7uIx3Y2+xvrmCzjdbR93vjOSNXbJkiQtOatz47nGUjcy0P
 IMnTsGFyzzNfpgvExFHRkd0bKEXGHFAyB230ZiHG6Yd3VyduRqBoUbStJNE2hfTUrTsg
 hB8pL5V2TR65mA09HgvXjlbD5vvCe0A+EwbotkE8f+JC06sc58+v2UZl9JNLXTlHXjf0
 t+vA==
X-Gm-Message-State: AOJu0YwSActPJbqjNzWlrfA278n/ysRFTFIyY2Q4KNPyux6qmVuRHL0L
 kQ6slU+OLhPn7aGosuLp8ATm8TNhXbncJyOY+dA0Nw==
X-Google-Smtp-Source: AGHT+IFu/22NNlvmuVBdx9iabaMrIHvkDXx66MwkobR7MrmOmMSaJs6J/KH39V4umYutXtJdGJyBQN/nUFu6T2uzLIU=
X-Received: by 2002:a2e:9a83:0:b0:2ca:1d0:498f with SMTP id
 p3-20020a2e9a83000000b002ca01d0498fmr2043981lji.102.1702331931024; Mon, 11
 Dec 2023 13:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-25-philmd@linaro.org>
In-Reply-To: <20231211212003.21686-25-philmd@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 11 Dec 2023 14:58:40 -0700
Message-ID: <CANCZdfouN2MtZOeEXi0jaXrG7_TqhupoDM98FzC_q=EPZghn6Q@mail.gmail.com>
Subject: Re: [PATCH 24/24] target: Restrict 'sysemu/reset.h' to system
 emulation
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
 Thomas Huth <thuth@redhat.com>, Song Gao <gaosong@loongson.cn>
Content-Type: multipart/alternative; boundary="00000000000009f55e060c430a26"
Received-SPF: none client-ip=2a00:1450:4864:20::22e;
 envelope-from=wlosh@bsdimp.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

--00000000000009f55e060c430a26
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 2:23=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> vCPU "reset" is only possible with system emulation.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/i386/cpu.c      | 2 +-
>  target/loongarch/cpu.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--00000000000009f55e060c430a26
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 11, 2023 at 2:23=E2=80=AF=
PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">vCPU &quot;reset&quot; is only possible with system emulation=
.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0target/i386/cpu.c=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0target/loongarch/cpu.c | 2 ++<br>
=C2=A02 files changed, 3 insertions(+), 1 deletion(-)<br></blockquote><div>=
<br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.co=
m">imp@bsdimp.com</a>&gt;=C2=A0</div></div></div>

--00000000000009f55e060c430a26--

