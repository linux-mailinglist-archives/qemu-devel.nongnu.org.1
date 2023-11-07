Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 908497E38D7
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:20:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J8W-0000RT-KP; Tue, 07 Nov 2023 05:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0J8T-0000LR-BD
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:16:41 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0J8R-0003dl-Lq
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:16:41 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-41cd4cc515fso37718511cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699352198; x=1699956998; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KvMhR2dqu2rUF7Djc7xov+j7e/EILkq2ly95RTlPvYg=;
 b=bmmJyeutswRkCZFpfNLSHUxQTU72B9f5tzI5a/EUhyevePd3VgnsRjI/bd9iohulXc
 HJ1sesMu0ghJ1gm/DxMovhNOZFJhSJDD1NscNWxHQku2KFZI7+gcij5SJ1gmRMCxSd1a
 6GkuZ8/18DVonQCvtSH3Gwj04deeIv0eQN+JvqR//tiJjMHCMcGaXgVwk1flQQ5w0Jd6
 MpX+ajTVHnhxYlE+ewBMI4RsUtbMjX0TfKuDTKWi/ps+Y3iXtfNKplSaoq/54LCkedeM
 t+7Fy8v2ahrMM4ksy7GkZiFqVXTLNdPcDciVj3Omx2FMN+EdtGS0dTeMk12R/tROsIkA
 w8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352198; x=1699956998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KvMhR2dqu2rUF7Djc7xov+j7e/EILkq2ly95RTlPvYg=;
 b=WYtJmfvcoYE15/yJRCGMgoSbeMUicBj5USMunD2bCQ7W8WSp7zA+UvxhuXRlwc4gzQ
 tI/XMj9/HI1AMrEdsYRAXuPihGOfi6yjOEYzonj1CokI+rE06Ktg+CTumIogyR2qCWX2
 QuFBerKtOattteurNM9Qjix1GGsrIPRHF0zernQPKB3L1l8kP3rQ6Gezfjgkm2fcwIl8
 eJMDluM6T/+ZNDgWqgmE5+DawSXPOxJeUJDQ3D/7v2onalBF2/u23n1H5Mlt2Yodl2KX
 H3DdGeemDKlNE/fdq5Viabog7x/Hb2HTQA4LYSBcc5lJwWCBR18J1A5D3Xtrm26H+ueX
 9jyg==
X-Gm-Message-State: AOJu0YypRtR63zo5S7VI0MmNcSfPgZ8wmRVuxf4YqqElGY9PWQg7954Y
 iJiQejWOZHqsBDmXCUVwPEkRj3vQjnj1cUxAv40=
X-Google-Smtp-Source: AGHT+IGVo0BsbHhlJkJ/QX/jRyQFMLdcHuE+tUZjVI55O+bl2d8m/U6YC4/sa2p/GrSD1EaGMK5mYccn2fg9CYxIWjY=
X-Received: by 2002:a05:622a:3d0:b0:418:110e:6179 with SMTP id
 k16-20020a05622a03d000b00418110e6179mr37559140qtx.1.1699352198311; Tue, 07
 Nov 2023 02:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20231104-pvpanic-shutdown-v1-0-02353157891b@t-8ch.de>
 <20231104-pvpanic-shutdown-v1-2-02353157891b@t-8ch.de>
In-Reply-To: <20231104-pvpanic-shutdown-v1-2-02353157891b@t-8ch.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Nov 2023 14:16:26 +0400
Message-ID: <CAJ+F1CJymrkXbUinkr1n=ssS5Lbdkd4PDJj958gkHgbr+gYw2A@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] tests/qtest/pvanic: use centralized definition of
 supported events
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sat, Nov 4, 2023 at 3:26=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> Avoid the necessity to update all tests when new events are added
> to the device.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>

In the title: pvanic -> pvpanic.

> ---
>  tests/qtest/pvpanic-pci-test.c | 5 +++--
>  tests/qtest/pvpanic-test.c     | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tests/qtest/pvpanic-pci-test.c b/tests/qtest/pvpanic-pci-tes=
t.c
> index 2c05b376ba72..b372caf41dc0 100644
> --- a/tests/qtest/pvpanic-pci-test.c
> +++ b/tests/qtest/pvpanic-pci-test.c
> @@ -16,6 +16,7 @@
>  #include "qapi/qmp/qdict.h"
>  #include "libqos/pci.h"
>  #include "libqos/pci-pc.h"
> +#include "hw/misc/pvpanic.h"
>  #include "hw/pci/pci_regs.h"
>
>  static void test_panic_nopause(void)
> @@ -34,7 +35,7 @@ static void test_panic_nopause(void)
>      bar =3D qpci_iomap(dev, 0, NULL);
>
>      qpci_memread(dev, bar, 0, &val, sizeof(val));
> -    g_assert_cmpuint(val, =3D=3D, 3);
> +    g_assert_cmpuint(val, =3D=3D, PVPANIC_EVENTS);
>
>      val =3D 1;
>      qpci_memwrite(dev, bar, 0, &val, sizeof(val));
> @@ -67,7 +68,7 @@ static void test_panic(void)
>      bar =3D qpci_iomap(dev, 0, NULL);
>
>      qpci_memread(dev, bar, 0, &val, sizeof(val));
> -    g_assert_cmpuint(val, =3D=3D, 3);
> +    g_assert_cmpuint(val, =3D=3D, PVPANIC_EVENTS);
>
>      val =3D 1;
>      qpci_memwrite(dev, bar, 0, &val, sizeof(val));
> diff --git a/tests/qtest/pvpanic-test.c b/tests/qtest/pvpanic-test.c
> index 78f1cf8186b0..ccc603472f5d 100644
> --- a/tests/qtest/pvpanic-test.c
> +++ b/tests/qtest/pvpanic-test.c
> @@ -10,6 +10,7 @@
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
>  #include "qapi/qmp/qdict.h"
> +#include "hw/misc/pvpanic.h"
>
>  static void test_panic_nopause(void)
>  {
> @@ -20,7 +21,7 @@ static void test_panic_nopause(void)
>      qts =3D qtest_init("-device pvpanic -action panic=3Dnone");
>
>      val =3D qtest_inb(qts, 0x505);
> -    g_assert_cmpuint(val, =3D=3D, 3);
> +    g_assert_cmpuint(val, =3D=3D, PVPANIC_EVENTS);
>
>      qtest_outb(qts, 0x505, 0x1);
>
> @@ -43,7 +44,7 @@ static void test_panic(void)
>      qts =3D qtest_init("-device pvpanic -action panic=3Dpause");
>
>      val =3D qtest_inb(qts, 0x505);
> -    g_assert_cmpuint(val, =3D=3D, 3);
> +    g_assert_cmpuint(val, =3D=3D, PVPANIC_EVENTS);
>
>      qtest_outb(qts, 0x505, 0x1);
>
>
> --
> 2.42.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

