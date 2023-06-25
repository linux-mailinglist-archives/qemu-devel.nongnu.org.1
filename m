Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D98FD73CE4B
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 05:43:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDGeZ-0000sQ-9a; Sat, 24 Jun 2023 23:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas@osdyne.com>) id 1qDGeW-0000qm-QA
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 23:43:04 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucas@osdyne.com>) id 1qDGeV-00054q-7I
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 23:43:04 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-25eabe8b5fcso413088a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 20:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osdyne.com; s=google; t=1687664581; x=1690256581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=btRCrFdiAQ6utPzCLjUxjVDbNA8YKZ7oAKcDGXjmwSY=;
 b=IX80fcd1ovjsVCfmhANr9aDzwjanWMYixNE9+YhSroY8ihZ25rnVWSnaNm2Hgq4Svz
 O8UI/ytidCe+r7C+oM195dncJGveVAU6fHT0l1VxQJtaGLAX0x1ebQhKQtNx/XG72xRX
 1xer3XkDPhs2se8PcAQ9LppXtbtFoXDiNC9ZSWYuGLE5Y0thMgvkzaPXTinvXb4JLSI5
 S+qBWkjFTa1ckXtDlxb0qgytVnlNfNKiT28vBjWTPa3o+aVxYg1FbA+k6HKqkHGUENcK
 Q/5iJD6QRb9G9p3OtztvjKgJWs/j+XNbgKFXDfcBOY+V+cNNn6oYXyZ7ZqWL/QExxuSV
 rxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687664581; x=1690256581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=btRCrFdiAQ6utPzCLjUxjVDbNA8YKZ7oAKcDGXjmwSY=;
 b=eyNAh489+WmDZFmRH9U41gbKmU25L37BdLMxdPCLzBTSp3akvGr1kq83EDNArjIOYy
 bdPMYbyS3XOvtAbJEa9fOZhiwGZtInYgh4JVGIuR3uRgoTirUpebENbnxJaZc67t8s8J
 7rBDGr+ujWHn14h65YryzvQX7WUAmpNaBDmcDuDy44UjzLzydvdjpWVyGjtxQ/rJBDBd
 tKMgEvAsqwJUOblC4He67XjrqGZSxVZgBGPjGnIikTcb55KNk7/f5RnFzzCr92J42AOb
 CfQJYwPpwFhYSSv4Kh5GrrDO2Z0fO6oviGsooF7Y2Xq3lA05S+08HpUTsSHe/xdqMKR0
 y9kA==
X-Gm-Message-State: AC+VfDy1qvbQ+YGa8Po7OsC2n55jd6wULnbdYVWa1RXLcUjjZ73eDZmS
 8t47iYxhVAUXC7G45Ia1N+OB0JBuGrvv51HY1cV0YQ==
X-Google-Smtp-Source: ACHHUZ4p1qsXhcVG2Eqb9gEdt6lZ6feI3GxRXlMOzkz2oE0M32aDGru6AgywRTaVxTvNafLzYpxOBxTKiACMIeH7hbc=
X-Received: by 2002:a17:90b:1b0c:b0:252:b342:a84a with SMTP id
 nu12-20020a17090b1b0c00b00252b342a84amr30320376pjb.0.1687664581693; Sat, 24
 Jun 2023 20:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230619221819.6882-1-lucas@osdyne.com>
 <CAKmqyKMGcsD7XQokTLTdr7X89WJaJq_g+7kf8Co_E-19j1J8Ww@mail.gmail.com>
In-Reply-To: <CAKmqyKMGcsD7XQokTLTdr7X89WJaJq_g+7kf8Co_E-19j1J8Ww@mail.gmail.com>
From: "Lucas C. Villa Real" <lucas@osdyne.com>
Date: Sun, 25 Jun 2023 00:42:50 -0300
Message-ID: <CAL+Dfo4pcJAcyovOVUyEcOXH7iRXeH_vnvN06ofbhqZe5d_3FA@mail.gmail.com>
Subject: Re: [PATCH] STM32F100: support different density lines
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, erdnaxe@crans.org
Content-Type: multipart/alternative; boundary="000000000000e46a2805feec0762"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=lucas@osdyne.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000e46a2805feec0762
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 10:30=E2=80=AFPM Alistair Francis <alistair23@gmail=
.com>
wrote:

> > +
> > +    object_class_property_add_str(oc, "density", stm32f100_get_density=
,
> > +        stm32f100_set_density);
> > +    object_class_property_set_description(oc, "density",
> > +        "Set the STM32F100 density line device. "
> > +        "Valid values are 'low', 'medium', and 'high' (default).");
> >  }
>
> This should be split into a separate commit from adding the machine
>

Ok, I'll do that.


> Isn't this exactly the same as the stm32vldiscovery board? Which is
> already very similar to the netduino2 machine. I'm not sure we need
> another machine.
>
> It could make more sense to deprecate the stm32vldiscovery machine and
> replace it with this generic one. At least we could keep everything in
> the one file and reuse a lot of the code.
>

What is the protocol for deprecating a machine? Should I just submit a
patch that removes it along with the corresponding entry in the MAINTAINERS
file? Should I coordinate that offline with the maintainer of the machine
that's to be retired?

Thanks,
Lucas

--000000000000e46a2805feec0762
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Thu, Jun 22, 2023 at 10:30=E2=80=AFPM Alistair Francis =
&lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt; wr=
ote:<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_class_property_add_str(oc, &quot;density&quot;, =
stm32f100_get_density,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 stm32f100_set_density);<br>
&gt; +=C2=A0 =C2=A0 object_class_property_set_description(oc, &quot;density=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Set the STM32F100 density line devi=
ce. &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Valid values are &#39;low&#39;, &#3=
9;medium&#39;, and &#39;high&#39; (default).&quot;);<br>
&gt;=C2=A0 }<br>
<br>
This should be split into a separate commit from adding the machine<br></bl=
ockquote><div><br></div><div>Ok, I&#39;ll do that.<br></div><div>=C2=A0<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
Isn&#39;t this exactly the same as the stm32vldiscovery board? Which is<br>
already very similar to the netduino2 machine. I&#39;m not sure we need<br>
another machine.<br>
<br>
It could make more sense to deprecate the stm32vldiscovery machine and<br>
replace it with this generic one. At least we could keep everything in<br>
the one file and reuse a lot of the code.<br></blockquote><div><br></div><d=
iv>What is the protocol for deprecating a machine? Should I just submit a p=
atch that removes it along with the corresponding entry in the MAINTAINERS =
file? Should I coordinate that offline with the maintainer of the machine t=
hat&#39;s to be retired?</div><div><br></div><div>Thanks,</div><div>Lucas<b=
r></div></div></div>

--000000000000e46a2805feec0762--

