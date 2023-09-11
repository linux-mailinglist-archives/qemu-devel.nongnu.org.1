Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 934C379A794
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:18:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfevX-0008IH-EI; Mon, 11 Sep 2023 07:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1qfevS-0008Hk-2P; Mon, 11 Sep 2023 07:17:54 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1qfevK-0005ZJ-Pz; Mon, 11 Sep 2023 07:17:53 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3ab7fb1172cso985140b6e.3; 
 Mon, 11 Sep 2023 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694431065; x=1695035865; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uyyP35WORJPhc34DqoK4EFV7Hiz+wLXmgadyY6G0U4s=;
 b=nwrMqbEcWGuiNqcSVi+ilUj0+oTkf7e4kMmRjX9JlwKyxfUb6aVODqvKQS+DYagNUs
 nU0+FJgZRzJhwJUqJL9Yey/zLQas3SiqbEBRSigoNWbTddgRjlBhq4X2OAT/q/KpIcyU
 SlzasCI1iBgXOaKg+Hy4Kx4TAF/kzKkZAtBuZjHlbVuo14SS5SLz4Q9SOUyPBgFsCxgq
 Z/LEfYfHKPWMh3VtzKaO2ltkyHvp15poB2m++fFqhvGQgig1CH673zwoGPaIiAzvErER
 kyGHXSdgFw2twmdnWCbLDFfAu3wRiYQIDjo87r6qhVczDJUxuf72tFJb6pzYaAUWusxo
 LJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694431065; x=1695035865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uyyP35WORJPhc34DqoK4EFV7Hiz+wLXmgadyY6G0U4s=;
 b=kl+zH/qCb+JRbBWI1qE731PhwV5KMhENfDf8obzc5WyglhQPVoVO39eC1+N5Jlx42T
 So84/AqauvhKhksTcyF/qPCdBZ85rDNRXQ7cK7Uuyse1OZ41CPUto8s9bHcFyBLHryLA
 Bp02YS0ei+YB5TZYPDeuRcJ9Ep1ewuWg9C/dHyxUvBLsCiBo9PmodDNJY1GeXQLKoIE1
 +ldF7shqwEEzc+6stkyJgluTfd6YdXXLIOIKrofzc2tuFUzmTPndps4jgUGvJnsrENf3
 l166+BF736kNMum8hSWZ94FfVJM2l8D2bOJaUfNcL4xyFZB/z8s2wzgBL1ArR83s7Xjf
 3eNw==
X-Gm-Message-State: AOJu0Yx+70bPfHMY0CwrDnMOub14f+YrG79ndCYIcv4bjmi8DS2UuOdw
 qzG+XdepFjRhtLl0fIPcx87f7tmufeGVRzD9izU=
X-Google-Smtp-Source: AGHT+IHfLSzLJ7DoisLGgPXbBMQuV2W9gGy4EzuCGlpOLGz+QL0UfCYEQ7BZEzqMDlOLutVjDy4yHBmGHDnDDidVnjU=
X-Received: by 2002:a05:6808:1795:b0:3a7:550c:635d with SMTP id
 bg21-20020a056808179500b003a7550c635dmr11058926oib.56.1694431064820; Mon, 11
 Sep 2023 04:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-7-armbru@redhat.com>
In-Reply-To: <20230831132546.3525721-7-armbru@redhat.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 11 Sep 2023 13:17:32 +0200
Message-ID: <CAOi1vP8-o_5PT4ZpHVXcF+xRb-2Wpa1JaWZxTqyXLXMCzm54mA@mail.gmail.com>
Subject: Re: [PATCH 6/7] block: Clean up local variable shadowing
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 eblake@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com, pl@kamp.de, 
 sw@weilnetz.de, sstabellini@kernel.org, anthony.perard@citrix.com, 
 paul@xen.org, pbonzini@redhat.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org, stefanha@redhat.com, 
 fam@euphon.net, quintela@redhat.com, peterx@redhat.com, leobras@redhat.com, 
 kraxel@redhat.com, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, 
 alex.bennee@linaro.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=idryomov@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 31, 2023 at 3:25=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Tracked down with -Wshadow=3Dlocal.
> Clean up: delete inner declarations when they are actually redundant,
> else rename variables.

For rbd

>  block/rbd.c          |  2 +-

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya

