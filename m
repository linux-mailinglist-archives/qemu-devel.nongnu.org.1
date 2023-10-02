Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC37B5007
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 12:19:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnG0i-0005tD-LG; Mon, 02 Oct 2023 06:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnG0g-0005q6-11
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 06:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnG0c-0000IT-5Y
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 06:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696241914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siFIgG9BFA+OGY9CtxQULbZethKfOz7Va9Att911pzk=;
 b=dUovGoRMqcqZy2b8TM6NtFaVFdUtepGDFNH/FwkvddHlUXa87lJDqvIKGmt7Eih/R53QAr
 90Fe7jCq6gUOGbNLVauy+K2Q2vrP/J00yqvjiQ4lw+dnLZL74JOExT60dsi4fTrejXgsOy
 Se63OgLdxRWd67vcsrEfNABtFINVdy4=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-XqYHJMEZOjmMqOuAl6wd1g-1; Mon, 02 Oct 2023 06:18:18 -0400
X-MC-Unique: XqYHJMEZOjmMqOuAl6wd1g-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7b0c16b2623so1522303241.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 03:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696241897; x=1696846697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=siFIgG9BFA+OGY9CtxQULbZethKfOz7Va9Att911pzk=;
 b=Wwqh83cQMWezB5SBbU6ZRmKo5NbRFLQZJm54R959UP8B92grnx7DlNoQz1tHN5rlo4
 2HFTml/Z+jps556O7opw7he0HPnUZb9cq6f7v5YfUE7Lqc6TQS8Ji/OYINLeacr/ooc0
 XRQ7eWBmclbVx6l0Izr7flP/Jwqno92uApY+GDrTJj58q0d3+tIDnZmw6FrvP/Jorqo2
 OuKPpiw0o1V3DX81FbA5cNODhv4rOl8MinAc2DmPGiHwzpjbxc2BqxQMz2PiWQaI6coT
 1FHfh6dcIyLx88U3ZkVUAd19oeKSEUWMqAIwPtRPiw9xUKL6jSPiuamwOx7Ia2u1YAdS
 +ftA==
X-Gm-Message-State: AOJu0Yw+76P5U7XXvxWzm0sLlikIyy292O5og+SJHptZUz4BG683ze5d
 gT0ICEMfpAHzgGpXc7xNJmPwhp/RSPYWaRX3wJJ6+JhyUQ2FU8Fpf8dDzYodq9nFSOsrTAJkIGq
 BYAZidAlH+ic41cDQZiISqDM7IfZaqXY=
X-Received: by 2002:a05:6102:3f0e:b0:455:dd1c:9653 with SMTP id
 k14-20020a0561023f0e00b00455dd1c9653mr1286210vsv.1.1696241897688; 
 Mon, 02 Oct 2023 03:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+hsO5pF3chk6ueCZ8D2KxTmEE6SsMrN8GYSfgkwm4bnjeeFT8JOMKKeQ6eUXu0ykYhgrXJiGXRnnUv6N8AAI=
X-Received: by 2002:a05:6102:3f0e:b0:455:dd1c:9653 with SMTP id
 k14-20020a0561023f0e00b00455dd1c9653mr1286204vsv.1.1696241897465; Mon, 02 Oct
 2023 03:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231002095445.65311-1-pbonzini@redhat.com>
 <CAMxuvazkydMV9YP9HJrdwNnTOAyy8W8DqJykRM2civmPmk2m2Q@mail.gmail.com>
In-Reply-To: <CAMxuvazkydMV9YP9HJrdwNnTOAyy8W8DqJykRM2civmPmk2m2Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Oct 2023 12:18:04 +0200
Message-ID: <CABgObfZnG=amuS-ptruUDmLMg4=AX=63ibv_LEu6X75Qd9LOaQ@mail.gmail.com>
Subject: Re: [PATCH v2] ui: fix dpy_ui_info_supported(con) assertion
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 2, 2023 at 11:58=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Mon, Oct 2, 2023 at 1:54=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> >
> > VGA does not support getting the physical video size or refresh rate.
> > This is causing an assertion failure when the GTK+ user interface
> > calls dpy_get_ui_info().  Return NULL from dpy_get_ui_info() if the
> > information is not supported, and just ignore the request to set
> > refresh rate or size in that case.
> >
> > While the assertion failure was introduced by commit a92e7bb4cad
> > ("ui: add precondition for dpy_get_ui_info()", 2023-09-12), QEMU had
> > been using con->ui_info incorrectly since before.
> >
> > Fixes: a92e7bb4cad ("ui: add precondition for dpy_get_ui_info()", 2023-=
09-12)
> > Fixes: aeffd071ed8 ("ui: Deliver refresh rate via QemuUIInfo", 2022-06-=
14)
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Did you see my patch ?
> https://lore.kernel.org/qemu-devel/20230915113637.2127644-1-marcandre.lur=
eau@redhat.com/
>
> I think I prefer mine :)

I hadn't seen it, either is okay with me.

Paolo


