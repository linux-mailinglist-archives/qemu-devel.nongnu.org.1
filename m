Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A43775100
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 04:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZ8w-0002YY-A2; Tue, 08 Aug 2023 22:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZ8t-0002YP-Eu
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:41:47 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZ8r-00069V-6q
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:41:47 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99bf1f632b8so937776466b.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 19:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1691548903; x=1692153703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ylr/xKMFtvnpKVvGYtjAT1LyqmrvjhDWsGWvQEBoFhg=;
 b=lXOlZHxqPH3iKn+1upqSMfAC34AA9XRZTR7dTaCe86euI826efDAN7cOoMFmqcUv0C
 QLVqzxUz+uFN7mSQo24vjITb7Rv0ZX6lIPOntcRXlsCcM4q6leITovzZN8yLFicEwSvx
 aLH0KtUiIkjL4sqalLwK11p2fWMYygqWkxdIm+EkUFycvIXtdJwluP0BF37ovHi7d7cs
 HVnv/mS6baNlA+czIaSf8J3JtJ3c+bGmrOvI+aqB/8Ghcp5XMhedQxdMgWXdGz6XwTjV
 pFRpJIm5r2K5R6Y1ELZTZLOXMIGxoDYe699TOz7uQ3xABBseCJaWzaTurqw49f9ZUySg
 8ZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691548903; x=1692153703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ylr/xKMFtvnpKVvGYtjAT1LyqmrvjhDWsGWvQEBoFhg=;
 b=MVTEePiJL5fD8gsXIHq3Ri1a06AJRza6oYSBH2zBGQ5Ql899LX/HGE0F06sz406a/U
 Ypw2B8Tp8+bwE5BMxk6XfsdlHbbSlByYP3Yi2CoUotVGz98RTEj4v8TuvZVsPBlMfqx4
 txf2fgFL+d/KFG1G4inFMiuRWBg+Ekmr/TXhodrgKL2cUe0Wz8LWx4wG7NFvskI8911Y
 kdP0udjkvPyTYUsRswlzAPnXeqhnaPP2qXVTEx7grGBa4I/BmAGZgsHQo8KdYAYihqoh
 5bV1hKFtgnW4G8nBMPFunKtqJufY93npsRGofvKDwrNTx0q0QfESBWmsX/NrkApDm3wr
 KbFA==
X-Gm-Message-State: AOJu0YzY/vyKWz21oXc3gvrVP53yGtja3cQLe+adnFjH27VwzwpWErn4
 sUipGRHiBfb6DPFV16txYZOwjQOU8EcLP5Y0827uEw==
X-Google-Smtp-Source: AGHT+IGTQ8HoKO/JobRcp+3ucmTs4+ljo1WJKiXgxiJu+oJtLeV+fBMOsCwfelFM3BYSYmI6CHU5ZkmaVYd5LLNN/Nw=
X-Received: by 2002:a17:907:7757:b0:991:c9da:70da with SMTP id
 kx23-20020a170907775700b00991c9da70damr1049307ejc.61.1691548902953; Tue, 08
 Aug 2023 19:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-4-kariem.taha2.7@gmail.com>
 <d9caacde-d8ab-2fdc-372a-20988f22267c@linaro.org>
 <CANCZdfoMCNF-SuBz5Ab=rmeW+1VLbR4mcUvfYqkbuV91rdtyPg@mail.gmail.com>
 <0a5370ca-ab9e-6a35-ea14-d685e1fa0540@linaro.org>
In-Reply-To: <0a5370ca-ab9e-6a35-ea14-d685e1fa0540@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 8 Aug 2023 20:41:33 -0600
Message-ID: <CANCZdfqWsrvhqbGC79Mu=05nmMANwXxb+TrKVi_fQpyk6QpEdw@mail.gmail.com>
Subject: Re: [PATCH 03/33] Update the definitions of __put_user and __get_user
 macros
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007b29410602746b85"
Received-SPF: none client-ip=2a00:1450:4864:20::62e;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62e.google.com
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

--0000000000007b29410602746b85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 8, 2023 at 7:47=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/8/23 18:39, Warner Losh wrote:
> >      > +#define __put_user_e(x, hptr, e)
>             \
> >      > +    do {
>             \
> >      > +        PRAGMA_DISABLE_PACKED_WARNING;
>             \
> >      > +        (__builtin_choose_expr(sizeof(*(hptr)) =3D=3D 1, stb_p,
>            \
> >      > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 2,
> stw_##e##_p,            \
> >      > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 4,
> stl_##e##_p,            \
> >      > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 8, stq_##e=
##_p,
> abort))))  \
> >      > +            ((hptr), (x)), (void)0);
>             \
> >      > +        PRAGMA_REENABLE_PACKED_WARNING;
>            \
> >      > +    } while (0)
> >      > +
> >      > +#define __get_user_e(x, hptr, e)
>             \
> >      > +    do {
>             \
> >      > +        PRAGMA_DISABLE_PACKED_WARNING;
>             \
> >      > +        ((x) =3D (typeof(*hptr))(
>            \
> >      > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 1, ldub_p,
>            \
> >      > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 2,
> lduw_##e##_p,           \
> >      > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 4,
> ldl_##e##_p,            \
> >      > +        __builtin_choose_expr(sizeof(*(hptr)) =3D=3D 8, ldq_##e=
##_p,
> abort))))  \
> >      > +            (hptr)), (void)0);
>             \
> >      > +        PRAGMA_REENABLE_PACKED_WARNING;
>            \
> >      > +    } while (0)
> >
> >     Hmm.  I guess this works.  The typeof cast in __get_user_e being
> required when
> >     sizeof(x) >
> >     sizeof(*hptr) in order to get the correct extension.
> >
> >
> > This code was copied 100% from the current linux-user :)
>
> Ha ha indeed!  I should have known.
>

Yea... It's old-school crazy, and I've done a lot of that in my day, but no=
t
here :)


> >     Is it clearer with _Generic?
> >
> >           (x) =3D _Generic(*(hptr),
> >                          int8_t: *(int8_t *)(hptr),
> >                          uint8_t: *(uint8_t *)(hptr),
> >                          int16_t: (int16_t)lduw_##e##_p(hptr),
> >                          uint16_t: lduw_##e##_p(hptr),
> >                          int32_t: (int32_t)ldl_##e##_p(hptr),
> >                          uint32_t: (uint32_t)ldl_##e##_p(hptr),
> >                          int64_t: (int64_t)ldq_##e##_p(hptr),
> >                          uint64_t: ldq_##e##_p(hptr));
> >
> >     In particular I believe the error message will be much prettier.
> >
> >
> > Indeed. That looks cleaner. I'll see if I can test that against the
> latest bsd-user upstream.
>
> I'll see if we can share this code via common-user.
>

It seems to work, though I still need the pragmas for clang 16 (see another
patch for that).

I tried to implement both get and put in terms of this, but found that it
broke the blitz
branch. So why don't we land this as is for bsd-user and then one of us can
try to
put it into common-user so as to not create too many waves for our GSoC
student Kariim.
There's already enough to fix in this series... Sound fair?

Warner

--0000000000007b29410602746b85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFR1ZSwgQXVn
IDgsIDIwMjMgYXQgNzo0N+KAr1BNIFJpY2hhcmQgSGVuZGVyc29uICZsdDs8YSBocmVmPSJtYWls
dG86cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZyI+cmljaGFyZC5oZW5kZXJzb25AbGluYXJv
Lm9yZzwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+T24gOC84LzIzIDE4OjM5LCBXYXJu
ZXIgTG9zaCB3cm90ZTo8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyArI2RlZmluZSBfX3B1dF91c2Vy
X2UoeCwgaHB0ciwgZSnCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIGRv
IHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0
O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIFBSQUdNQV9ESVNBQkxFX1BBQ0tFRF9XQVJOSU5H
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgKF9fYnVpbHRpbl9jaG9vc2Vf
ZXhwcihzaXplb2YoKihocHRyKSkgPT0gMSwgc3RiX3AswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBcPGJyPg0KJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIF9fYnVpbHRpbl9jaG9vc2Vf
ZXhwcihzaXplb2YoKihocHRyKSkgPT0gMiwgc3R3XyMjZSMjX3AswqAgwqAgwqAgwqAgwqAgwqAg
XDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCBfX2J1aWx0aW5fY2hvb3NlX2V4
cHIoc2l6ZW9mKCooaHB0cikpID09IDQsIHN0bF8jI2UjI19wLMKgIMKgIMKgIMKgIMKgIMKgIFw8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgX19idWlsdGluX2Nob29zZV9leHBy
KHNpemVvZigqKGhwdHIpKSA9PSA4LCBzdHFfIyNlIyNfcCwgYWJvcnQpKSkpwqAgXDxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCAoKGhwdHIpLCAoeCkpLCAodm9pZCkw
KTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBcPGJyPg0KJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIFBSQUdNQV9SRUVOQUJM
RV9QQUNLRURfV0FSTklORzvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgfSB3aGlsZSAo
MCk8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDsgKyNkZWZp
bmUgX19nZXRfdXNlcl9lKHgsIGhwdHIsIGUpwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7ICvCoCDCoCBkbyB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgXDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCBQUkFHTUFfRElTQUJMRV9Q
QUNLRURfV0FSTklORzvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgICgoeCkg
PSAodHlwZW9mKCpocHRyKSkowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0O8KgIMKgIMKgICZndDsgK8Kg
IMKgIMKgIMKgIF9fYnVpbHRpbl9jaG9vc2VfZXhwcihzaXplb2YoKihocHRyKSkgPT0gMSwgbGR1
Yl9wLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7ICvC
oCDCoCDCoCDCoCBfX2J1aWx0aW5fY2hvb3NlX2V4cHIoc2l6ZW9mKCooaHB0cikpID09IDIsIGxk
dXdfIyNlIyNfcCzCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgwqAgwqAgX19idWlsdGluX2Nob29zZV9leHByKHNpemVvZigqKGhwdHIpKSA9PSA0LCBsZGxf
IyNlIyNfcCzCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0O8KgIMKgIMKgICZndDsgK8KgIMKg
IMKgIMKgIF9fYnVpbHRpbl9jaG9vc2VfZXhwcihzaXplb2YoKihocHRyKSkgPT0gOCwgbGRxXyMj
ZSMjX3AsIGFib3J0KSkpKcKgIFw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgKGhwdHIpKSwgKHZvaWQpMCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7ICvCoCDCoCDCoCDCoCBQUkFHTUFfUkVFTkFCTEVfUEFDS0VEX1dBUk5JTkc7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0
O8KgIMKgIMKgICZndDsgK8KgIMKgIH0gd2hpbGUgKDApPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAg
wqAgwqBIbW0uwqAgSSBndWVzcyB0aGlzIHdvcmtzLsKgIFRoZSB0eXBlb2YgY2FzdCBpbiBfX2dl
dF91c2VyX2UgYmVpbmcgcmVxdWlyZWQgd2hlbjxicj4NCiZndDvCoCDCoCDCoHNpemVvZih4KSAm
Z3Q7PGJyPg0KJmd0O8KgIMKgIMKgc2l6ZW9mKCpocHRyKSBpbiBvcmRlciB0byBnZXQgdGhlIGNv
cnJlY3QgZXh0ZW5zaW9uLjxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IFRoaXMgY29k
ZSB3YXMgY29waWVkIDEwMCUgZnJvbSB0aGUgY3VycmVudCBsaW51eC11c2VyIDopIDxicj4NCjxi
cj4NCkhhIGhhIGluZGVlZCHCoCBJIHNob3VsZCBoYXZlIGtub3duLjxicj48L2Jsb2NrcXVvdGU+
PGRpdj48YnI+PC9kaXY+PGRpdj5ZZWEuLi4gSXQmIzM5O3Mgb2xkLXNjaG9vbCBjcmF6eSwgYW5k
IEkmIzM5O3ZlIGRvbmUgYSBsb3Qgb2YgdGhhdCBpbiBteSBkYXksIGJ1dCBub3Q8L2Rpdj48ZGl2
PmhlcmUgOik8YnI+PC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29s
aWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCiZndDvCoCDCoCDCoElzIGl0
IGNsZWFyZXIgd2l0aCBfR2VuZXJpYz88YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCDCoCh4KSA9IF9HZW5lcmljKCooaHB0ciksPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGludDhfdDogKihpbnQ4X3QgKikoaHB0ciksPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVpbnQ4X3Q6ICoodWludDhfdCAq
KShocHRyKSw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
aW50MTZfdDogKGludDE2X3QpbGR1d18jI2UjI19wKGhwdHIpLDxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1aW50MTZfdDogbGR1d18jI2UjI19wKGhwdHIp
LDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnQzMl90
OiAoaW50MzJfdClsZGxfIyNlIyNfcChocHRyKSw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgdWludDMyX3Q6ICh1aW50MzJfdClsZGxfIyNlIyNfcChocHRy
KSw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaW50NjRf
dDogKGludDY0X3QpbGRxXyMjZSMjX3AoaHB0ciksPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVpbnQ2NF90OiBsZHFfIyNlIyNfcChocHRyKSk7PGJyPg0K
Jmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBJbiBwYXJ0aWN1bGFyIEkgYmVsaWV2ZSB0aGUgZXJyb3Ig
bWVzc2FnZSB3aWxsIGJlIG11Y2ggcHJldHRpZXIuPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxicj4N
CiZndDsgSW5kZWVkLiBUaGF0IGxvb2tzIGNsZWFuZXIuIEkmIzM5O2xsIHNlZSBpZiBJIGNhbiB0
ZXN0IHRoYXQgYWdhaW5zdCB0aGUgbGF0ZXN0IGJzZC11c2VyIHVwc3RyZWFtLjxicj4NCjxicj4N
CkkmIzM5O2xsIHNlZSBpZiB3ZSBjYW4gc2hhcmUgdGhpcyBjb2RlIHZpYSBjb21tb24tdXNlci48
YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SXQgc2VlbXMgdG8gd29yaywgdGhv
dWdoIEkgc3RpbGwgbmVlZCB0aGUgcHJhZ21hcyBmb3IgY2xhbmcgMTYgKHNlZSBhbm90aGVyIHBh
dGNoIGZvciB0aGF0KS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgdHJpZWQgdG8gaW1wbGVt
ZW50IGJvdGggZ2V0IGFuZCBwdXQgaW4gdGVybXMgb2YgdGhpcywgYnV0IGZvdW5kIHRoYXQgaXQg
YnJva2UgdGhlIGJsaXR6PC9kaXY+PGRpdj5icmFuY2guIFNvIHdoeSBkb24mIzM5O3Qgd2UgbGFu
ZCB0aGlzIGFzIGlzIGZvciBic2QtdXNlciBhbmQgdGhlbiBvbmUgb2YgdXMgY2FuIHRyeSB0bzwv
ZGl2PjxkaXY+cHV0IGl0IGludG8gY29tbW9uLXVzZXIgc28gYXMgdG8gbm90IGNyZWF0ZSB0b28g
bWFueSB3YXZlcyBmb3Igb3VyIEdTb0Mgc3R1ZGVudCBLYXJpaW0uPC9kaXY+PGRpdj5UaGVyZSYj
Mzk7cyBhbHJlYWR5IGVub3VnaCB0byBmaXggaW4gdGhpcyBzZXJpZXMuLi4gU291bmQgZmFpcj88
YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5XYXJuZXI8YnI+PC9kaXY+PC9kaXY+PC9kaXY+
DQo=
--0000000000007b29410602746b85--

