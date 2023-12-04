Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 735B2803AE6
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:52:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rACB3-0003yx-9q; Mon, 04 Dec 2023 11:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rACB1-0003yg-FO
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:52:11 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rACAz-0008Ip-V4
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:52:11 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b845ba9ba9so2860075b6e.3
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 08:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701708728; x=1702313528; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFmbaQH3lX83bteTnNrddWO6y5/FgkOIfgmix++zT+w=;
 b=M2TDhfvony/1LNHp1pDy/Q/Lw15jLd28RbZGcl2zzAAvb889V3ghV67XNETS2eBWk9
 CbRcIjyYzi65FQ05ayifsw6mge3eBtO7XJ4qCBiViLwkqS7zcclVwOtks18Rqfj5FhhS
 wZ7MfEg3I0xGFnVGmezsZ+3pecNmulkWAuoDKMT/7Q+YN20LpR7rxHNahgIlPLpBSh3j
 xPRJRo0g16wTzpZOmWzFrtVYlcgmcU8B7k6XANA1xT24hshFVQGzFqlF8vQgagwPoWx6
 OPaJwd9d6V4miunnKaMGGfHZtkST883APdRBSfPqXpounGmpVt23QCbMlYk1CyCTepih
 7bTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701708728; x=1702313528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SFmbaQH3lX83bteTnNrddWO6y5/FgkOIfgmix++zT+w=;
 b=vjmmrolE2oWo72Q6HhiO3HdsMk+axaqbIg3OvOaOxKBmt8bXtE7A5CTp7l+OzKb5GJ
 WNwGAC11kprKCdvgO2crPgQGB4A1oH9eLj7M6rotdH8L7gBkR9Hk+pw1hivjLQK/Jqsa
 Pq+JwGAESl8YiBs/luWfOolV7uoDLCgntoQb4wOC365xoSKfxji/SKEIH1JEvhIU5ZBX
 HSc9l9yjMbFIp8ZokAhTcyjySHBp0x92DBrRAr1uQbxsAloHeXIhy7+llSLKXDy/pRqj
 qg+iBKPDCy2QM5/a1c+bp6xSaGT1ErUs4ez1eQqPTxOJQ1yEP6U73hmEt5DBr4dKoG9b
 0w0w==
X-Gm-Message-State: AOJu0YyIjNCxsLuTupC6t9kPXM9Rwyf/PHftLMJC2MHDOUGqWwlTJRzD
 OS4mEpfirKlcXFpIhLIo8sTNkGOvwp0+nS9ErWE=
X-Google-Smtp-Source: AGHT+IHrdBKkB3oG40xIAt1pEMPEY2yzkwFZ/7hpZgKJvIwyjNQYnVr7W5KM4L2tVp7y2nb8Z/dL7+3ZSGfJcTytKXc=
X-Received: by 2002:a05:6870:b86:b0:1fb:2eb6:37f with SMTP id
 lg6-20020a0568700b8600b001fb2eb6037fmr3184717oab.46.1701708728553; Mon, 04
 Dec 2023 08:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20231204163257.1011556-1-andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20231204163257.1011556-1-andrey.drobyshev@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Dec 2023 20:51:56 +0400
Message-ID: <CAJ+F1CKni6vzAfPDefU8c-kRuhPDbzOohpC0bZ40WGOxLGGtmQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "test/qga: use G_TEST_DIR to locate os-release
 test file"
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com, 
 den@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x22d.google.com
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

Hi

On Mon, Dec 4, 2023 at 8:33=E2=80=AFPM Andrey Drobyshev
<andrey.drobyshev@virtuozzo.com> wrote:
>
> Since the commit a85d09269b QGA_OS_RELEASE variable points to the path
> relative to the build dir.  Then on qemu-ga startup this path can't be
> found as qemu-ga cwd is somewhere else, which leads to the test failure:
>
>   # ./tests/unit/test-qga -p /qga/guest-get-osinfo
>   # random seed: R02S3a90c22d77ff1070fbd844f4959cf4a4
>   # Start of qga tests
>   **
>   ERROR:../tests/unit/test-qga.c:906:test_qga_guest_get_osinfo: 'str' sho=
uld not be NULL
>   Bail out! ERROR:../tests/unit/test-qga.c:906:test_qga_guest_get_osinfo:=
 'str' should not be NULL
>
> Let's obtain the absolute path again.

Can you detail how the build and the test is done?

If I recall correctly, this change was done in order to move qga to a
subproject(), but isn't strictly required at this point. Although I
believe it is more correct to lookup test data relative to
G_TEST_DIST.

>
> This reverts commit a85d09269bb1a7071d3ce0f2957e3ca9dba7c047.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  tests/unit/test-qga.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
> index 671e83cb86..47cf5e30ec 100644
> --- a/tests/unit/test-qga.c
> +++ b/tests/unit/test-qga.c
> @@ -1034,10 +1034,12 @@ static void test_qga_guest_get_osinfo(gconstpoint=
er data)
>      g_autoptr(QDict) ret =3D NULL;
>      char *env[2];
>      QDict *val;
> +    g_autofree gchar *cwd =3D NULL;
>
> +    cwd =3D g_get_current_dir();
>      env[0] =3D g_strdup_printf(
> -        "QGA_OS_RELEASE=3D%s%c..%cdata%ctest-qga-os-release",
> -        g_test_get_dir(G_TEST_DIST), G_DIR_SEPARATOR, G_DIR_SEPARATOR, G=
_DIR_SEPARATOR);
> +        "QGA_OS_RELEASE=3D%s%ctests%cdata%ctest-qga-os-release",
> +        cwd, G_DIR_SEPARATOR, G_DIR_SEPARATOR, G_DIR_SEPARATOR);
>      env[1] =3D NULL;
>      fixture_setup(&fixture, NULL, env);
>
> --
> 2.39.3
>
>


--=20
Marc-Andr=C3=A9 Lureau

