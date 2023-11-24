Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CCE7F79F8
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:01:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ZX5-0001lu-E4; Fri, 24 Nov 2023 11:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r6ZX3-0001k0-It; Fri, 24 Nov 2023 11:59:57 -0500
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r6ZX1-000488-S6; Fri, 24 Nov 2023 11:59:57 -0500
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-67a12079162so4686356d6.1; 
 Fri, 24 Nov 2023 08:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700845194; x=1701449994; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6e2TglBi+lJq4NZlVYfJRw7pzIANBEwswwOaV+z0X0=;
 b=GDT8uJ4y7h/aSc0kOl4u3q4N1sH7Vxs85v4q+vjcz5z0Q0r1Ol7ZhsaT1pMejOON4t
 Vbxj0Xbol0BSpzffke0Z7tWDv+7xlqpD9bjsb0u7HthWy487CZEXaeFflhfcYC/Hn/Ip
 NoTFnK0K7qdeen7kqhVEZCkfv3J4bS9OPqcCSt71UmYCP8cx0Ly9o15WbipSpIRvdH1p
 vqf+wq/JVg3KWk97OR2hc47CUr7jJbR+bmNfUfsaxUdwQG8NCbXqMYw22iXjRI+Vtw6l
 J13z917cmcxMYHu+0ycRYCE0QBCUCVb12dKZ7Hd02jRkix46YIocL3JJDImaSvyl7Sew
 /VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700845194; x=1701449994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6e2TglBi+lJq4NZlVYfJRw7pzIANBEwswwOaV+z0X0=;
 b=kqa1QopLsx5vgVTfpLtb3zKcmT9v9UzbPe2Br+XQcKioDGgm50w13OlG4MZAyAPHgs
 hYO132XArhjBoQbIFlZPK4rfnL2xTgIzBdZBP+DjVgUWHFWxs/CeF1cDCHZowQWIbKaW
 PdYJThxybXauvnC8SiVZsS9tLOJBDg2micmsAerwaHwtfcnDQfG6qo0+cVRurUWOeur+
 UlN+jxzcpfTqZutZQqpaxfTqfN4VXRiuqWiCLICHaxQhkn8pk5YToXy3xWyAPFSl9qvR
 z5LbXGSvSJ0zZ+V0qqcQeFlWliMUATIts/96741i69kKgk4XZq6JUL13YDGC2jty5D3C
 gUlQ==
X-Gm-Message-State: AOJu0YzlDu8cb/7d5Q4YQHPhU1fUfbM+MRFrL4R14Isnr4m1BpdAamnC
 3HG0VAC+kELEnPDaaVZbJD3FnfdTzWwbREP+r2E=
X-Google-Smtp-Source: AGHT+IHuIPiaEbnXQ0d+efEaY39AIdz4cW9nEkh1G0jo4pimO74C4J/a5WsaTsZ13vSFEu3gobmgwZq7B29eIX6TSgs=
X-Received: by 2002:a05:6214:19ef:b0:67a:21a6:75db with SMTP id
 q15-20020a05621419ef00b0067a21a675dbmr1028543qvc.55.1700845194464; Fri, 24
 Nov 2023 08:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20231124015312.544422-1-dhoff749@gmail.com>
 <93f7ee3e-a92f-4b18-bf16-2169c8b2791d@linaro.org>
 <87sf4vgtir.fsf@pond.sub.org> <87edgfgsg0.fsf@pond.sub.org>
In-Reply-To: <87edgfgsg0.fsf@pond.sub.org>
From: Dan Hoffman <dhoff749@gmail.com>
Date: Fri, 24 Nov 2023 10:59:44 -0600
Message-ID: <CAFXChKJ+OoxXH0Krvvc0-84VwTkat1CciOL=59+gyH+WYWEV_A@mail.gmail.com>
Subject: Re: [PATCH] hw/core: define stack variable to NULL to fix qtest with
 sanitizers
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=dhoff749@gmail.com; helo=mail-qv1-xf2a.google.com
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

Yes, that fixes my issue. I was receiving two errors with the sanitizers:
1. UBsan complaining that the (garbage) value didn't have the required
alignment of the type
2. ASan complaining about some memory failure by read/write/accessing it

On Fri, Nov 24, 2023 at 8:02=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Daniel, please have a look at Kevin's patch:
>
>     Subject: [PATCH for-8.2 1/2] qdev: Fix crash in array property getter
>     Date: Tue, 21 Nov 2023 18:34:15 +0100 (2 days, 20 hours, 26 minutes a=
go)
>     Message-ID: <20231121173416.346610-2-kwolf@redhat.com>
>     https://lore.kernel.org/qemu-devel/20231121173416.346610-2-kwolf@redh=
at.com/
>
> Does it fix your sanitizer run?
>

