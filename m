Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F967C780E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 22:48:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr2Zq-0008Mr-A5; Thu, 12 Oct 2023 16:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qr2Zj-0008Ki-Jj
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 16:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qr2Zg-0005hJ-UP
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 16:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697143587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWgRwgFvgYeKfEkwumJc+ZtHHrpydy58L7NM3LRa9LA=;
 b=Ua2OTPKCoq2zrroMp3cfP2OVsOb2aB45CgNc9fjgP1LjJLbglnvI1VuzZz8uYkiXBLRed/
 poYy+HALycl/7psahSxS5gdwM5vOZ/QgUC+d30h4A7IEP6rUCULMTYwM6YW8XPo8gQZJpk
 bUZ1VykfLQUhy3UVdpfWI3+XUUqee70=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-6tBnslNnOKmagKWl1o--FQ-1; Thu, 12 Oct 2023 16:46:26 -0400
X-MC-Unique: 6tBnslNnOKmagKWl1o--FQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1e96efd9ae0so1870281fac.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 13:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697143585; x=1697748385;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWgRwgFvgYeKfEkwumJc+ZtHHrpydy58L7NM3LRa9LA=;
 b=Ynz6CrvYTC9G8ecEY+xaxXReK/I+AzKCsZ5O2IVKzmK2/KvG4yHQo4BpQI44gmsmgW
 2Tu/0dZRshaEDopaEW44yVivh0Xn8tuUDH/kfq70mN/+y/GYrGurTzLGHFqpYDplpXGu
 2BdakZxIXTO0Atva74QBeHiy5RDRadoSGQSw9nxhIpAO7OEiWBj7yTGhQTbhOFnnkXXz
 lPK3JlhNMO4TrZ0K69lgbjYveDpmXOWgohAh5ZImvIiaNgt2grbZnYdonjDlDb37CEGf
 wjmvktMVj8HJ9pFWRw5WUdO56d17osakARadXK28rt9TfMm2zNLTnXbbci4FitSLLH87
 5tXw==
X-Gm-Message-State: AOJu0YybNQhhSsu+PxuthA3FInCKZevyGjg18CaV20mfL9czE5Mt5I0r
 rRQT8j+zyGirSkBET/a6MC/SaOuBlfaQKo6LM4HiWCMASPYV/6NTcO9QFn7gqxDQRhv8he+c5jX
 48wZuiFxgDBcuh1x7kD1CuSFEpSWpqrI=
X-Received: by 2002:a05:6870:14c1:b0:1b0:89e0:114f with SMTP id
 l1-20020a05687014c100b001b089e0114fmr30863615oab.31.1697143585613; 
 Thu, 12 Oct 2023 13:46:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnstz4g0GydjokQsQCAXfNwPagHt+wdC+V5OMLnf4HVU9hCjo0BXxmlrdBuFX97sx9yc94CFsMg+F0EgOTGQY=
X-Received: by 2002:a05:6870:14c1:b0:1b0:89e0:114f with SMTP id
 l1-20020a05687014c100b001b089e0114fmr30863592oab.31.1697143585374; Thu, 12
 Oct 2023 13:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231009100251.56019-1-philmd@linaro.org>
 <20231009100251.56019-5-philmd@linaro.org>
In-Reply-To: <20231009100251.56019-5-philmd@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 12 Oct 2023 16:46:14 -0400
Message-ID: <CAFn=p-Z4mWJXewXk7acmhMwuJ8jdso6h7x=bFUJm1Mce+C4_Og@mail.gmail.com>
Subject: Re: [PATCH 04/10] tests/cdrom-test: Clean up global variable
 shadowing in prepare_image()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Alberto Garcia <berto@igalia.com>, Hao Wu <wuhaotsh@google.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Tyrone Ting <kfting@nuvoton.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 9, 2023 at 6:03=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Rename the variable to fix:
>
>   tests/qtest/cdrom-test.c:40:50: error: declaration shadows a variable i=
n the global scope [-Werror,-Wshadow]
>   static int prepare_image(const char *arch, char *isoimage)
>                                                    ^
>   tests/qtest/cdrom-test.c:18:13: note: previous declaration is here
>   static char isoimage[] =3D "cdrom-boot-iso-XXXXXX";
>               ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  tests/qtest/cdrom-test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
> index f2a8d91929..0945383789 100644
> --- a/tests/qtest/cdrom-test.c
> +++ b/tests/qtest/cdrom-test.c
> @@ -37,17 +37,17 @@ static int exec_xorrisofs(const char **args)
>      return exit_status;
>  }
>
> -static int prepare_image(const char *arch, char *isoimage)
> +static int prepare_image(const char *arch, char *isoimagepath)
>  {
>      char srcdir[] =3D "cdrom-test-dir-XXXXXX";
>      char *codefile =3D NULL;
>      int ifh, ret =3D -1;
>      const char *args[] =3D {
>          "xorrisofs", "-quiet", "-l", "-no-emul-boot",
> -        "-b", NULL, "-o", isoimage, srcdir, NULL
> +        "-b", NULL, "-o", isoimagepath, srcdir, NULL
>      };
>
> -    ifh =3D mkstemp(isoimage);
> +    ifh =3D mkstemp(isoimagepath);
>      if (ifh < 0) {
>          perror("Error creating temporary iso image file");
>          return -1;
> --
> 2.41.0
>


