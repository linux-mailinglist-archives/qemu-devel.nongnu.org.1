Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C717F248B
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 04:14:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5HDO-0004MD-TA; Mon, 20 Nov 2023 22:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5HDK-0004Lq-Ih
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 22:14:14 -0500
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5HDI-0007Xx-VS
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 22:14:14 -0500
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7baba7de286so1728954241.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 19:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700536452; x=1701141252; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NZliIG7sKwUytTXZXr//RZ5woc/sHIjuCWBw/6FVPo=;
 b=WA4LEZtRLFAUCL5b2+YW8HVNVxYwZeVBURezTavb9t6YEykB/wW0V0zZPqBiAsnGnZ
 uXYxjaTbR/V3R3NrLHtvXOjQmtxowbbtPjrGl4qGBKWzkoHG98KTgANDJ5D217DSHqaW
 X38LQPmhwuE3QqW1osMbrJlQuonFe78bJ+8JoU0t9glKGO4TR+mTVQKzM2tHsdMYCwnA
 smzC1azWdQiuokAF26kkaOybeJn+U9qlqUxHLRu9s9tB/sXYi0whyqnduCqFZCqIeTeQ
 0Dj5q6znTB36T9heY13vmNXcIjmd9JCUFjB+O0F1bNvidXSx02diblzCj3F/vKX8STYq
 e1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700536452; x=1701141252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2NZliIG7sKwUytTXZXr//RZ5woc/sHIjuCWBw/6FVPo=;
 b=RrDfrfJ3AsvoVISFKo86Z/KdU6l9FkvaYKSrS+GrCRB1g3PK8Z1zxGpwEZ4gSTq7sQ
 3TjnFtGCgd/QDlko8ZJvL8+vGnAMbBhoevcPMu3UjgJ4oVMKrtUQcfJxO8el56Xa8O+i
 CtFNifte91LB+SzZ4rMKvP5R3kMAmYWSD+IQ1BiFaeBsOK5SBmOtqSrtJuznbzcMFAAL
 lC65Lh4sr0xA/Od7nlYXRIApzFKsMaLfVpbuH06p1x2lmyKur5ukz84Ss0lngc3/N4cy
 GqQ5ucpxJ8/DJwMudvS9F3M+/awvQhVKD2hbGa8lGTUvptsIdgpJUmNe0Ho3ZmrNptML
 ZRZA==
X-Gm-Message-State: AOJu0YyoKNbKS/8sQCqKgHxxiN5lmHdvv4LRCwQIbGBbMJrUBx8+HALH
 7HX8tzWqayqjnmpMM6dJMO9K3P9jI5jp9cGxXic=
X-Google-Smtp-Source: AGHT+IEUqbOKfnHZG+6Ff0deoGwMTxIOSbLdGbrXIN4PX3ee4pi7HL0Cxvjhp7I2eAgwXV9UD8AoEA61uQywxFIy2sc=
X-Received: by 2002:a67:f418:0:b0:45d:b3a9:84c5 with SMTP id
 p24-20020a67f418000000b0045db3a984c5mr6746431vsn.34.1700536451918; Mon, 20
 Nov 2023 19:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20231117114457.177308-1-thuth@redhat.com>
 <20231117114457.177308-5-thuth@redhat.com>
In-Reply-To: <20231117114457.177308-5-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Nov 2023 13:13:45 +1000
Message-ID: <CAKmqyKP9hxUtd5ycOP=A5EMJYktdfd7+omngh0Q1P4F786rNpA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] tests/unit/test-io-task: Rename "qemu:dummy" to
 avoid colon in the name
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Nov 17, 2023 at 11:08=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:
>
> Type names should not contain special characters like ":" (so that
> they are easier to use with QAPI and other parts). We are going to
> forbid such names in an upcoming patch. Thus let's replace the ":"
> here with a "-".
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/unit/test-io-task.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/unit/test-io-task.c b/tests/unit/test-io-task.c
> index 953a50ae66..115dba8970 100644
> --- a/tests/unit/test-io-task.c
> +++ b/tests/unit/test-io-task.c
> @@ -25,7 +25,7 @@
>  #include "qapi/error.h"
>  #include "qemu/module.h"
>
> -#define TYPE_DUMMY "qemu:dummy"
> +#define TYPE_DUMMY "qemu-dummy"
>
>  typedef struct DummyObject DummyObject;
>  typedef struct DummyObjectClass DummyObjectClass;
> --
> 2.42.0
>
>

