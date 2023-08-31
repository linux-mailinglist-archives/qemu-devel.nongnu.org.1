Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F41D978E74E
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 09:43:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbcJN-0005z6-3y; Thu, 31 Aug 2023 03:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1qbcJK-0005yf-Jr
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:41:50 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1qbcJG-00088L-GO
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 03:41:50 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bd0d135ca3so10366841fa.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 00:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693467704; x=1694072504; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vHyyz5Qzcn1KAW8TqPNDVyfgN6Lih+6klE89jhJswgQ=;
 b=b83QAW60oNsacCP8izrZggccaXov90of93e+HGSnNCQftn3LFo7op3kTPdTmW/Qc/r
 8gKA25PdwQqyxuV11pzW2DL4G5/8UTAmU1hG5eklf5yPxvH1jxUp0cMH4e1Eh4n1vynh
 FCswlif17Pzdg65AdXvtSoatUzeREvIQwj+i2vKOM/VUSGs9YMXYTwAU5CaBV+LKpTdP
 xajRrnEc0+XSfLGIZPSHBk6KRe7zBm52IrjStJ78nsbw3vV8aYe+h1K/uBbcLG2H8oPP
 CYfTrRV6vYaIGrGHtAtcR95dWereLfPgqM3aWX5VKf7DuJF8egTx2lf2y8u6Bp91TKX7
 JVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693467704; x=1694072504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vHyyz5Qzcn1KAW8TqPNDVyfgN6Lih+6klE89jhJswgQ=;
 b=CHoCaOSnanfWWn5y6EUOeAP19mlpZtjE6CZVN8I0W2H5K/Rq8dJRl5CzuvUOckjFXl
 QhUq47n2fRa+/wkfha+5rQqAqfzj9TQ5/6NRrqH9Cw/DfhM17i6Jpu0j+LWDW18GW2Wi
 HqffNUDAQ85fEYvU00eod64Hcgjc5nj5mk9iFOpeB6TsrKxVdVbZsx/NQsOViFdVP+mJ
 2Wm71j7Etb2Y37W2xGzAHGw5Goc306hpQPZfiEfG532hEgu96XmOCW/z9hD2lPHgCsIx
 A1PO52hyNFzz4jIAYS6vBpJrLDpoOh9rst73eaNzNvzpXuQqoF8v7m+X2/yFGi5G7g5o
 EVtw==
X-Gm-Message-State: AOJu0YwN6xVc2emrDA3/DPwZMkygBQ6zENNO8Z863jnBDvK3IBX3PAv3
 r5AZg1dPG4Ic9m78JKjd9ZdkqWjGApT+9SagoA==
X-Google-Smtp-Source: AGHT+IFBEkedhUr9ygPSOKW43EQ/wFujvNh2V4AwKf3TIbhlftc6YK3OXsGt8sEzqA/bYs29/GHp/4ub7y6T2viicWw=
X-Received: by 2002:a2e:b046:0:b0:2ba:2cf8:9334 with SMTP id
 d6-20020a2eb046000000b002ba2cf89334mr3467043ljl.19.1693467704195; Thu, 31 Aug
 2023 00:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYM0N0o2SdiaAqtBm5md4z_FQnnP2csPrapc+5L47Qcaiw3Kg@mail.gmail.com>
 <a4ef9f54-7a57-af6f-c947-5383a7559288@linaro.org>
In-Reply-To: <a4ef9f54-7a57-af6f-c947-5383a7559288@linaro.org>
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Thu, 31 Aug 2023 15:41:47 +0800
Message-ID: <CAOYM0N2L+piWiPVtJ=hni_+dkerDgEr1TAHj1XpiXc91Y6NoYg@mail.gmail.com>
Subject: Re: About "PC_MACHINE_CLASS" definition.
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f27d8c0604332cd8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000f27d8c0604332cd8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot.

On Thu, Aug 31, 2023 at 2:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi,
>
> On 31/8/23 05:15, Liu Jaloo wrote:
> > Where actually defined the "PC_MACHINE_CLASS", I can't find it in sourc=
e
> > code, please help to point out the file.
>
> It is defined in include/hw/i386/pc.h:
>
> OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, PC_MACHINE)
>
> The macro itself is defined in include/qom/object.h:
>
> /**
>   * OBJECT_DECLARE_TYPE:
>   * @InstanceType: instance struct name
>   * @ClassType: class struct name
>   * @MODULE_OBJ_NAME: the object name in uppercase with underscore
> separators
>   *
>   * This macro is typically used in a header file, and will:
>   *
>   *   - create the typedefs for the object and class structs
>   *   - register the type for use with g_autoptr
>   *   - provide three standard type cast functions
>   *
>   * The object struct and class struct need to be declared manually.
>   */
>
> See the QOM documentation:
>
> https://qemu-project.gitlab.io/qemu/devel/qom.html
>
> Regards,
>
> Phil.
>

--000000000000f27d8c0604332cd8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks a lot. <br></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 31, 2023 at 2:11=E2=80=AFPM =
Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd=
@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi,<br>
<br>
On 31/8/23 05:15, Liu Jaloo wrote:<br>
&gt; Where actually defined the &quot;PC_MACHINE_CLASS&quot;, I can&#39;t f=
ind it in source <br>
&gt; code, please help to point out the file.<br>
<br>
It is defined in include/hw/i386/pc.h:<br>
<br>
OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, PC_MACHINE)<br>
<br>
The macro itself is defined in include/qom/object.h:<br>
<br>
/**<br>
=C2=A0 * OBJECT_DECLARE_TYPE:<br>
=C2=A0 * @InstanceType: instance struct name<br>
=C2=A0 * @ClassType: class struct name<br>
=C2=A0 * @MODULE_OBJ_NAME: the object name in uppercase with underscore <br=
>
separators<br>
=C2=A0 *<br>
=C2=A0 * This macro is typically used in a header file, and will:<br>
=C2=A0 *<br>
=C2=A0 *=C2=A0 =C2=A0- create the typedefs for the object and class structs=
<br>
=C2=A0 *=C2=A0 =C2=A0- register the type for use with g_autoptr<br>
=C2=A0 *=C2=A0 =C2=A0- provide three standard type cast functions<br>
=C2=A0 *<br>
=C2=A0 * The object struct and class struct need to be declared manually.<b=
r>
=C2=A0 */<br>
<br>
See the QOM documentation:<br>
<br>
<a href=3D"https://qemu-project.gitlab.io/qemu/devel/qom.html" rel=3D"noref=
errer" target=3D"_blank">https://qemu-project.gitlab.io/qemu/devel/qom.html=
</a><br>
<br>
Regards,<br>
<br>
Phil.<br>
</blockquote></div>

--000000000000f27d8c0604332cd8--

