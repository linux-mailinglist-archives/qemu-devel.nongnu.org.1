Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D2B8147A5
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 13:06:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6xA-0003K1-V2; Fri, 15 Dec 2023 07:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rE6x8-0003Ei-Kz
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:06:02 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rE6x4-0007MQ-2i
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:06:00 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6d9ac148ca3so508563a34.0
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 04:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702641956; x=1703246756; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8icaTXd9tnDyI4He0sOccNg5y632CRXh3dzT5ryQBnU=;
 b=lPhh/FKRoYma5fgiFlcTa3gheFB1F4JQA/lwbWdffl8ueMLWJKN/C5jiL+4ddz+3Oo
 EM8ifPUvlfAh3PgQU86gblDN63z0YvRyP0Xfcb5hCfVcC2U5SJ6H08BPLlHG/oNN1xZN
 CKcZOPOBFxtDE5+ENdCmI1gqNKP64DJ94bZ7mp92b4n0UOcdX73puFzWbVvnTeBwewXn
 O3lJveSyF0nwrOubfX3zkqruYILljTynyr+AOMNPTaUs+HZCBvVkgu+Yj8c8F0MOl/6I
 AkM70B7gH+RHJLFr8VO0AToOn5bmYfj4Uc1X9p85gGlUiKiYFkvdp7Ryx3yP8UTlL1e5
 5ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702641956; x=1703246756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8icaTXd9tnDyI4He0sOccNg5y632CRXh3dzT5ryQBnU=;
 b=LlS/FhyUV0rLWX/bb8M08mLGIvHQB3e+RwoO0rC7sc2I9k7g4MlcLiQUomuoDtyyYq
 Q9pRXOJMiVl+rMpvXYR8CdxLh+NvKaKPTaDK8MFquhLEmDIDAd2iTwFyetdnAFkPoQYF
 cgKwPlCPuSmEdNTw0nJunMo26TUmJ3dLvahfK7Ivu5n7L93pyEvo6Ad8jqVMIB35bacg
 R/YxegQNGqAHVQZyuO492rC37H7Z9AE593CwQH0V8M7tPQFNt6H1bp/rE17QmXPjKOef
 7RP5My4LNNZNbcsB9yf/ptpy+Z4+SGNg6aGFlja5iLQYzZ3IpDlC3LvG9hDxa0pvIpGy
 DjKg==
X-Gm-Message-State: AOJu0YyZBTpvbQNz4sSK2zCrkeINF2S4dJKMPaW4uFtPOzKt5BqzkOm3
 UQE25a0CR/GCi0nETrcjF6u51NXltrbNs/AF2w0=
X-Google-Smtp-Source: AGHT+IE02cTWr5ut3Bw50ARKzaBXd/aByuAHXUadT/wFChJ1s9n9YzP132vQZBk88pq/j3NiItSXqzlf3jd2zDgCyyA=
X-Received: by 2002:a05:6870:1f13:b0:203:2e9c:eeb2 with SMTP id
 pd19-20020a0568701f1300b002032e9ceeb2mr4353597oab.32.1702641956658; Fri, 15
 Dec 2023 04:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
 <20231215-dbus-v2-4-1e2e6aa02115@daynix.com>
In-Reply-To: <20231215-dbus-v2-4-1e2e6aa02115@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 15 Dec 2023 16:05:45 +0400
Message-ID: <CAJ+F1CJYcnJRoKfDqJxxmpo2=7vd7pY4SSPcKQvqWMr4a6ZuLA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] tests/qtest: Depend on dbus_display1_dep
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ot1-x329.google.com
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

On Fri, Dec 15, 2023 at 3:29=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> It ensures dbus-display1.c will not be recompiled.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/qtest/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 47dabf91d048..3a1a79d7c72e 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -332,7 +332,7 @@ if vnc.found()
>  endif
>
>  if dbus_display
> -  qtests +=3D {'dbus-display-test': [dbus_display1, gio]}
> +  qtests +=3D {'dbus-display-test': [dbus_display1_dep, gio]}
>  endif
>
>  qtest_executables =3D {}
>
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

