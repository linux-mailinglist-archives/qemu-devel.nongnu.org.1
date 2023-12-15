Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A1F81479E
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 13:06:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6wt-0002o3-Nf; Fri, 15 Dec 2023 07:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rE6wr-0002nm-Cr
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:05:45 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rE6wp-0006nw-SJ
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:05:45 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4257ba1bc5fso4690171cf.0
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 04:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702641943; x=1703246743; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6D8QU9WISmKrPGhZZCFPmJDEfgj9UnQ1X+dCG0bYLss=;
 b=l83cmCvcIqDVVlIqN3GjUv3W4K9L/wV8KtJUKLDcxK1K3SQeeaH3L8OfyhZeHpACSI
 qAcv5/7L0JQ3ExXHSC5zYDZGbjqjBQLh3EUnpkyZdQHt0AUAOOl9Ak/SGYySD3i0vPCh
 Ji72+5B9lkAXiGKxxDJRCehkJUAg47F6zF1crvG/7HeRl+HJtcj/yB9zFFvm6pI4kPUr
 6XVNnTR1GnrgSRq09TXaCHafV0DQk+xG/DGi+q2lOzqpBBRExherN4rDHtsMfPhM6xFu
 8fUIWakMY+1UOmVvqNlDEtDBFq8YUafElrBxUDH6wmMWqezdgPBLgP2SmzI/AsLMUiD3
 AHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702641943; x=1703246743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6D8QU9WISmKrPGhZZCFPmJDEfgj9UnQ1X+dCG0bYLss=;
 b=AWaWptDGpmR0sM2Yb96M9lnfVXtFi99FaipHyZRBVZSri8XRIwz6qVS61tJbiFD3uW
 ifD45I1Ej86AQhLNRsgmeEfmw56sjYnPBSwaDy4QsbL0tbuoeaRJBY0/TP5cjSPPHXke
 2PCRwwUy357JWWhhamajKtQjyvMaGR51Jx87z6Li7ohNTdmt+HBZCi+ysQvCmAbJqukN
 dvpAF47DZPRgpJEDUeUVPRwgdL9b2v+hUyA7Dg6MS4r+5Adx2NtP5C+U9Gy2HU+Ax7K9
 NVcLqRfWOATO1/JF9nZ8oNq9gT1vCNMxFW/w5i/+9Z3i5jvuA7YKZqqtMLHQpII/xh05
 LReg==
X-Gm-Message-State: AOJu0Yx0vNE8mUTST+p/Oz/wwY33OME10DKAaQJMl/IJpOXMYM3BVTFs
 0IOhjFPWKX9GpLpA+0+JByMqIkI81qZlrOq7bQo=
X-Google-Smtp-Source: AGHT+IEvaomqG1QTtY4a+syVPo+/9iSvsNJJUlGvMWA6eZSo9uSeXlaPWbMoYFl078Ce9psNDuX8+vCwLhjNZbAdGgw=
X-Received: by 2002:a05:622a:1113:b0:425:4043:96da with SMTP id
 e19-20020a05622a111300b00425404396damr16293156qty.103.1702641942968; Fri, 15
 Dec 2023 04:05:42 -0800 (PST)
MIME-Version: 1.0
References: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
 <20231215-dbus-v2-3-1e2e6aa02115@daynix.com>
In-Reply-To: <20231215-dbus-v2-3-1e2e6aa02115@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 15 Dec 2023 16:05:32 +0400
Message-ID: <CAJ+F1CLVxp+h5pfLa3oMDQD1Vg5erwZmWEwzpgvkv+vHRHew+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] meson: Explicitly specify dbus-display1.h
 dependency
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

On Fri, Dec 15, 2023 at 3:29=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Explicitly specify dbus-display1.h as a dependency so that files
> depending on it will not get compiled too early.
>
> Fixes: 1222070e7728 ("meson: ensure dbus-display generated code is built =
before other units")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

ok, hopefully this finally fixes the problem.. I have the feeling the
solution applied in this commit isn't the right one..

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index 5e1b25a47184..c31168e11cfb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2032,7 +2032,7 @@ if dbus_display
>                                            '--c-namespace', 'QemuDBus',
>                                            '--generate-c-code', '@BASENAM=
E@'])
>    dbus_display1_lib =3D static_library('dbus-display1', dbus_display1, d=
ependencies: gio)
> -  dbus_display1_dep =3D declare_dependency(link_with: dbus_display1_lib,=
 include_directories: include_directories('.'))
> +  dbus_display1_dep =3D declare_dependency(link_with: dbus_display1_lib,=
 sources: dbus_display1[0])
>  endif
>
>  have_virtfs =3D get_option('virtfs') \
>
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

