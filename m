Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9185C7EB4B2
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:23:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wBX-0007w0-5T; Tue, 14 Nov 2023 11:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1r2wBU-0007vs-Nz
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:22:40 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1r2wBS-0004RK-8T
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:22:40 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9e1021dbd28so869262666b.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 08:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699978955; x=1700583755; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=17OWCKNteEZnPtSBAMz416mwgkRZ2xtydLSUih9AZ5E=;
 b=cgHhq6/wl8Xf48Tauc1Dhgmal/HuLr7uMc9U2f4Hjp/DhdzWwqZ8BtCuIA9vJMQtRG
 SHbwjpnM7i4HspF9E06w+csr/C6A+V1wrDmHPUorhfu86QtilGs1F3v4cQ7PfW5k2LAy
 w9wQlI8uwG4llV7osnJPevlRGLDYl14Xj3y4rLW1m1nxqs/EhyVbUBlS+Gdh79DlPoTr
 HKQiNnT/F8Jb6j6HZgVNGgBac7XgG99yIkFeSg+9TRKwA7fKpStdnuryN+hR2FBojNNc
 YimAxGZHYpo9TZClvUQuqcG9jBDMlZEn9QvUnn8f7g83Pd540+tzyPrRiJk09PzxejME
 vP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699978955; x=1700583755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=17OWCKNteEZnPtSBAMz416mwgkRZ2xtydLSUih9AZ5E=;
 b=Sxaq3tb1y8QOZdZszPzGWY8iw9Jv0k+ptOWoE+Olacf+jzE+NLYhGy8OgwRUSvsajX
 BPlvSvamSYH57WdMNuu2yJ3E1nUyX6hdCHHW/I+Hieha4Szw+2UQG33c3EPKjvx2DIJ3
 7JsVpUwmO5Uq/hWf1rHGdTa8caV6xaZG68ANLgNbDyyhOh0t9Ul1Pc/cLhISPhIWFRVH
 QQvShRvDLPmF1mL0xYGP7I35IlPR7RHHMeujMatiRGMVb4dwbGB4xcoyebG1ONUx0bqO
 ZyGfMMY5cTy9Cnxf/6XlNO2P5msqOiAcdTcPsM+G7nhvCAnuiLmVYv4MPxy3WAyiCkHt
 8HdQ==
X-Gm-Message-State: AOJu0YwbZYaC9vtFV2y6ZbT9h1qdTBkixWr+ssymcXGyw1N6HyNMRQNx
 BXmFAlLkaA+gyXlO1StJW7VMpy71yUSbIx8WXHc=
X-Google-Smtp-Source: AGHT+IEJ4UHXAfqY1VfEFKB6JjjFLZ7xGkeaEbvtSVpBZEryasX2pImQsCzfeM3/CECUcZowI04qDGZVe5FfojHSmQI=
X-Received: by 2002:a17:906:f6d4:b0:9be:30c2:b8fd with SMTP id
 jo20-20020a170906f6d400b009be30c2b8fdmr7171436ejb.66.1699978954793; Tue, 14
 Nov 2023 08:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
 <20230730064057.357598-4-dinahbaum123@gmail.com> <87tttix39v.fsf@pond.sub.org>
 <CAH50XRepiYcR9_e0AtuwTk1Nn34TXvZ87F5VVWg3aSx8BRJHPg@mail.gmail.com>
 <87edkmt397.fsf@pond.sub.org>
In-Reply-To: <87edkmt397.fsf@pond.sub.org>
From: Dinah B <dinahbaum123@gmail.com>
Date: Tue, 14 Nov 2023 11:22:23 -0500
Message-ID: <CAH50XRcOF2Sa0psZt_trCM-F68iR_pgyb8VsqJ_byFtPPgJRaw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] cpu, softmmu/vl.c: Change parsing of -cpu argument
 to allow -cpu cpu,
 help to print options for the CPU type similar to how the
 '-device' option works.
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b9e8a0060a1f314b"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=dinahbaum123@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000b9e8a0060a1f314b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Is there a way to distinguish between qemu-system-* vs qemu-* builds?
At first I thought #CONFIG_LINUX_USER might be it but not all non-mmu
builds set this.

Thanks,
-Dinah

On Wed, Aug 2, 2023 at 1:36=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Dinah B <dinahbaum123@gmail.com> writes:
>
> > Thanks, I will fix this. I somehow didn't catch that you had replied to
> the
> > old one.
>
> Happens :)
>
>

--000000000000b9e8a0060a1f314b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Is there a way to distin=
guish between qemu-system-* vs qemu-* builds?</div><div>At first I thought =
#CONFIG_LINUX_USER might be it but not all non-mmu builds set this.</div><d=
iv><br></div><div><div>Thanks,</div><div>-Dinah<br></div></div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug =
2, 2023 at 1:36=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@r=
edhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Dinah B &lt;<a href=3D"mailto=
:dinahbaum123@gmail.com" target=3D"_blank">dinahbaum123@gmail.com</a>&gt; w=
rites:<br>
<br>
&gt; Thanks, I will fix this. I somehow didn&#39;t catch that you had repli=
ed to the<br>
&gt; old one.<br>
<br>
Happens :)<br>
<br>
</blockquote></div>

--000000000000b9e8a0060a1f314b--

