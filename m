Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 080AD7CC8E6
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 18:32:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsmzp-0004bl-P0; Tue, 17 Oct 2023 12:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amit251098@gmail.com>)
 id 1qsmzj-0004YO-O6
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:32:36 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amit251098@gmail.com>)
 id 1qsmzi-0003LG-7G
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:32:35 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-65af7d102b3so38224706d6.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697560352; x=1698165152; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7S10lM7WUQpoKOJGHz3DIwJOChhseewGJRF/HhvU0CY=;
 b=M/Drgyitvf5Mq61NPT6uOBD7m2c4LINauB1aoRCKLtC/NGdz/FmZNc8zUFJD/ibhuY
 uGVe9qZXxWURz2Jw27aoDuFaMT3Uu3IZ33Zxad3OVm7Byprw1dmbZlbRsf9QlAYD9zJr
 iwUKEOnqL9SbCQ0QJcCHMoQE5OMn9CgpJmX3jgfmw5jjOPYjWkG3Jzh23gO08s5gyYSX
 g2gkMa6mX9gHg1Z6n4hOtjEVpfqnKPNQcbh9jt1N3JWZAwBTvircvcRfridA/E/eIbca
 QfvGp5UWwKmsa74PMcf19n+W/pzql28vAU6/zjdz/TrOOtw0SN3tqcD2wcs3Xqe5ygna
 UarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697560352; x=1698165152;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7S10lM7WUQpoKOJGHz3DIwJOChhseewGJRF/HhvU0CY=;
 b=lz3nyvW+VKCmV4OjDycXyiBCJkLaliqXi7wtmiSUgpbpN864tNYW9ATTEWbznXcrFu
 gwpJ3S5ZS+lB8E/BcRer7cTGbF5QEtc/WPQYtWKr5yVlxfd0kgB18eWbWOW6X1k8Y2m3
 24Q/Vl3xTEcjJfixuWZWCf/m04Wq3UGwBsughRAKTqwtYw/u5G0rIMpVdugaruDn1xo8
 GdCzEh0HAPceZd0OZXc2rl1Djfru7drjZP2zZCCCk1TQfJ3VZfTY/NtXj0emMMyxVoKg
 Lf3g5f0PIgCbedxnchMs/1Z+CDx/y3D9/lD/pJUk+UEUhvlUc4YWALahWxTizlr+tgFR
 cfnA==
X-Gm-Message-State: AOJu0YyXBPlq8Ezd8OI6jyVBRQvpHelIQErpHi2cndT1Qd6JN4yLmpzv
 c7bwdjswMlYS6ABJI06qMp1INTTHGzWTs8X4BPetMF0N
X-Google-Smtp-Source: AGHT+IE9FzzE7inmna90JmwcLBm7x/ztPim4xnweP/eA8nWjgJUtUf/sXeuyaW7TMJAQ5dsOEBtABp5C08fxqvXca4E=
X-Received: by 2002:a05:6214:27c2:b0:66d:43be:7e45 with SMTP id
 ge2-20020a05621427c200b0066d43be7e45mr3592240qvb.43.1697560352304; Tue, 17
 Oct 2023 09:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhcV8-HHG36Ndv7Y-K5FrUTb-WwVoRW3PPzaiM4hEesGA-iWw@mail.gmail.com>
In-Reply-To: <CAHhcV8-HHG36Ndv7Y-K5FrUTb-WwVoRW3PPzaiM4hEesGA-iWw@mail.gmail.com>
From: Amit Kumar <amit251098@gmail.com>
Date: Tue, 17 Oct 2023 22:02:21 +0530
Message-ID: <CAHhcV89tKJiFz6CW5Xm6XP5pDs1uLBew=kjC5qd-k+fNVmdt1g@mail.gmail.com>
Subject: Re: [Beginner-Help] Help understanding the migration Code
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c8b3620607ec115a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=amit251098@gmail.com; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000c8b3620607ec115a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Following up on the previous email I sent. I want to understand the
migration code, I have read a couple of papers on how it works in theory,
but I am finding it hard to find a starting point where I can start to
understand the code.

Any help would be appreciated.

Thank you

On Wed, Oct 11, 2023 at 9:40=E2=80=AFAM Amit Kumar <amit251098@gmail.com> w=
rote:

> Hi
> I am trying to understand how migration, more specifically live-migration
> works in QEMU. I've tried going through the source code but didn't
> understand much, and couldn't find documentation either. I want to work o=
n
> live migration and need help getting to know the code.
> More specifically I want to understand
> - where the pre/post copy algorithms are implemented
> - which files/data-structures that I should look at
> - should I need to make changes, where and how should I start?
>
> I am new to working with such large code bases, hence need some guidance.
>
> Thanks
>
> Amit Kumar
>

--000000000000c8b3620607ec115a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Following up on the previous email I sent. I want to =
understand the migration code, I have read a couple of papers on how it wor=
ks in theory, but I am finding it hard to find a starting point where I can=
 start to understand the code. <br></div><div><br></div><div>Any help=C2=A0=
would be appreciated.</div><div><br></div><div>Thank you<br></div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, O=
ct 11, 2023 at 9:40=E2=80=AFAM Amit Kumar &lt;<a href=3D"mailto:amit251098@=
gmail.com">amit251098@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi</div><div>I am tr=
ying to understand how migration, more specifically live-migration works in=
 QEMU. I&#39;ve tried going through the source code but didn&#39;t understa=
nd much, and couldn&#39;t find documentation either. I want to work on live=
 migration and need help getting to know the code. <br></div><div>More spec=
ifically I want to understand</div><div>- where the pre/post copy algorithm=
s are implemented</div><div>- which files/data-structures that I should loo=
k at</div><div>- should I need to make changes, where and how should I star=
t?</div><div><br></div><div>I am new to working with such large code bases,=
 hence need some=C2=A0guidance.</div><div><br></div><div>Thanks</div><div><=
br></div><div>Amit Kumar<br></div></div>
</blockquote></div>

--000000000000c8b3620607ec115a--

