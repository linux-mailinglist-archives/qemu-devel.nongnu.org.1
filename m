Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C561A70F57A
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 13:41:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1mqM-0004RL-Gk; Wed, 24 May 2023 07:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1q1mqK-0004Mb-DF
 for qemu-devel@nongnu.org; Wed, 24 May 2023 07:39:48 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1q1mqI-0004XP-QZ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 07:39:48 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9700219be87so133719966b.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684928385; x=1687520385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QU1OUFMa9LvvX/4CvrNeSgAOUyR+3gY2/wElraRccjI=;
 b=DKKspkOWtmcRd4jpkMoTMmXA/TKswzXcP8LuN/uNSTFzq1x4F3/xuAU5hXVv19MnP9
 UxlbrtCiQsxvdwhWwLIWuftJPINDLjInbNWAu3LEXOVykwj0khAjTsGEa9RwdN6SrXux
 wVbYV6eqgCj6zYS1LB1xMipwe0/+IE27NtgFEauKj8dSefaQ1QCtp12QxsWZKtLbIpzC
 d4HODDYGXinNsFCDM29/nUyhsqpFvi/Y4DLqEOC7n4X6k8yG4QPSgjDJ7CEIeXOaGbpD
 6bX/ONnFW6bgpFHdZ6/2yRyuZBAhUVXAhLZXUmb4gQmb19PBqpRzDLqFilTc1dtz6P6K
 1TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684928385; x=1687520385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QU1OUFMa9LvvX/4CvrNeSgAOUyR+3gY2/wElraRccjI=;
 b=WVVoysuwymYQcjpArYjOxoYSdMCXLPZfE59MjcnVjBLjGwWKjPw23wq/G+qmrWKwmd
 +Necy1i7bfHHZvpsywcfjJcy6GsBXEMqb3xbCD8go+H4WBKSw9hsji4uk8NUiMSIwc+7
 oOPS118ik8kQ5Mm7AkatkVfx+ejJIiZIIldBatGpZqoYSWg7EofLD6aEKYCzNd1z51ZU
 D7nGZkZHfcm7BjEaRexxFcF4nbNBLKKUmbhgBxzEPz7h5x2SKEKO+vkzJaOf6sBQspVF
 CVCetFXR159j3i8ljL8jEeDdLFMi7t9YNXNS1bimQNqg/BZlgmIfW3y1TBuUtZGx5RVI
 GTHw==
X-Gm-Message-State: AC+VfDw2cvsOh6hykjeAuKMFRGbI6utDiRIVdw8jGQNZRhPGem4AbA6Q
 akDj7/RUcK5jSeed5Psj/4ih2JhZE+NPW1ORJo0=
X-Google-Smtp-Source: ACHHUZ52HIRWOrEqqKmia0SXM+grohk9klInoO8wU65CeWN/FUOWJa2hUFrKEesR27C10w0Wevq6uLRtYfzkOUWbciU=
X-Received: by 2002:a17:906:4784:b0:96f:4fc4:f5ab with SMTP id
 cw4-20020a170906478400b0096f4fc4f5abmr16325423ejc.18.1684928384536; Wed, 24
 May 2023 04:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230510202654.225689-1-iii@linux.ibm.com>
 <20230510202654.225689-6-iii@linux.ibm.com>
 <87sfbmvxbm.fsf@linaro.org>
In-Reply-To: <87sfbmvxbm.fsf@linaro.org>
From: Dominik Czarnota <dominik.b.czarnota@gmail.com>
Date: Wed, 24 May 2023 13:39:08 +0200
Message-ID: <CABEVAa0PEg-5T-5TFtRPY60=eKa+ih3P9sFxB3cSQcer=yNb5g@mail.gmail.com>
Subject: Re: [PATCH RESEND 5/6] docs: Document security implications of
 debugging
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Andreas Arnez <arnez@linux.ibm.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d513f005fc6ef5f5"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=dominik.b.czarnota@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000d513f005fc6ef5f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Just to add two cents here: the commit message is a bit not true because
the qemu-user GDB stub could always read host files by just changing the
emulated code to open and read those files. Apart from that, I like the
documentation additions.

Best regards,
Dominik 'Disconnect3d' Czarnota

On Wed, 24 May 2023 at 12:27, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:

>
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>
> > Now that the GDB stub implements reading host files, concerns may arise
> > that it undermines security. Document the status quo, which is that the
> > users are already responsible for securing the GDB connection
> > themselves.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--000000000000d513f005fc6ef5f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Just to add two cents here: the com=
mit message is a bit not true because the qemu-user GDB stub could always r=
ead host files by just changing the emulated code to open and read those fi=
les. Apart from that, I like the documentation additions.</div><div><br></d=
iv><div>Best regards,</div><div>Dominik &#39;Disconnect3d&#39; Czarnota</di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, 24 May 2023 at 12:27, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex=
.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><br>
Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com" target=3D"_blank"=
>iii@linux.ibm.com</a>&gt; writes:<br>
<br>
&gt; Now that the GDB stub implements reading host files, concerns may aris=
e<br>
&gt; that it undermines security. Document the status quo, which is that th=
e<br>
&gt; users are already responsible for securing the GDB connection<br>
&gt; themselves.<br>
&gt;<br>
&gt; Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.co=
m" target=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--000000000000d513f005fc6ef5f5--

