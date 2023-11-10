Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B847E79F8
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 09:07:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1MWZ-0003NT-HH; Fri, 10 Nov 2023 03:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r1MWV-0003NI-Jw
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 03:05:51 -0500
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r1MWU-00059s-4b
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 03:05:51 -0500
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4ac89e8e964so758102e0c.3
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 00:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699603548; x=1700208348; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jBgUb3TDI7cfBZsBt8qoBLfWa8t6l3O66vVJjZyNWU=;
 b=c/SfA7D4+9h9ZqD7oC4fZdEPP+PRUoxSxjzcdWsxzbZRCk5Ev+kvcPclCLpCLc0w53
 UKJ4fwC6QosXaL0BFma1RfKXHRxNXEsbga7D8fDi46SEkLl00AIpQnl1qtHrZzWkwKwR
 Nc4WQFC7Ftdb1uP4qWZG8itmsDRa/w/l61G38U4GFto/g+7Wv9dsAnBvkyejl3OOSIlB
 BfhyNrX7YY70fxxceAVvkWcYaup6ruYBLQi/s7qjAIpd7XLpPACGOqiVZ6JGSEmr3+Yb
 Trdd3hoZfKMgvxeMJnLSktCC9nx5ksvwvmkRDnY+v2/ni+b0N7hGQT1DGfVK528Oc6+w
 db1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699603548; x=1700208348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jBgUb3TDI7cfBZsBt8qoBLfWa8t6l3O66vVJjZyNWU=;
 b=Tc5T+UONWZiq+Zx8dMG+q/uksU+EL1DqVEA+nAFEuIYAuWaOdhi+Qa1drtvr4yG+77
 fLYJKL5Ot/56jqe0vAq0MreUX/qMMNj+9S6iZOwyIUvQzAk0aTHMQYujNMgirklWr+1a
 wjODFLSzmakLpXEgnOR9kvIs9iHSGXxYPjKjQ8aRfWjLj56DMPxvh8L4d1l8I6Ar1X1+
 M84IlO6W8c4lBbIlHOxXNklkIua0EUc0J90mp/OxOZinbvVu/9jJZyMovav8HW361yP4
 eQjRaawsLDqyvPXu1+TpWoMDeakY0wEnZqYFJcSFkJhCT137mdHy+ttJd4blS9ROXid1
 Mwsg==
X-Gm-Message-State: AOJu0YxxZddU3gGpP9D2QYnvh3O5CWaMcOQVyxOWiXlnOQhZP/Y1uOSG
 ztyZfmS/5rm/D15NR5PfFIDrjC+brJvqlykXaIYpWeRrslg=
X-Google-Smtp-Source: AGHT+IHyzExODykvA90S1Cs0lmWCbcmoqvsPkzVin29ELW9i9HlZBQJUVRHDgalXCEUeqjtKO6bYEouh/DRpNHLGuRY=
X-Received: by 2002:a05:6122:1da6:b0:49a:466c:199e with SMTP id
 gg38-20020a0561221da600b0049a466c199emr4204137vkb.2.1699603548410; Fri, 10
 Nov 2023 00:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20231102141010.300310-1-marcandre.lureau@redhat.com>
In-Reply-To: <20231102141010.300310-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 10 Nov 2023 12:05:36 +0400
Message-ID: <CAJ+F1CLs3sDf+=Ky4ohecVewMNnAOKBj7qJ18RSO9Y6ufR_UJg@mail.gmail.com>
Subject: Re: [PATCH] build-sys: fix meson project version usage
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Thu, Nov 2, 2023 at 6:11=E2=80=AFPM <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Program wixl found: YES (/usr/bin/wixl)
>
> ../qga/meson.build:149:16: ERROR: Unknown variable "project".
>
> Fixes: e20d68aa0b9 ("configure, meson: use command line options to config=
ure qemu-ga")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

ping

> ---
>  qga/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qga/meson.build b/qga/meson.build
> index 940a51d55d..ff7a8496e4 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -146,7 +146,7 @@ if targetos =3D=3D 'windows'
>        libpcre =3D 'libpcre2'
>      endif
>      qga_msi_version =3D get_option('qemu_ga_version') =3D=3D '' \
> -      ? project.version() \
> +      ? meson.project_version() \
>        : get_option('qemu_ga_version')
>      qga_msi =3D custom_target('QGA MSI',
>                              input: files('installer/qemu-ga.wxs'),
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

