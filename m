Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5E37AE73E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 10:01:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql2zo-0006js-R7; Tue, 26 Sep 2023 04:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ql2zg-0006jY-Pv
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:00:34 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ql2ze-00079A-Io
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:00:31 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4181e268447so15748341cf.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 01:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695715229; x=1696320029; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzef6+OLYU9+x5ulSAXFhc7EI4OUgUY6x8D0726PIUA=;
 b=VEtLB7W+7cjex3kp5GaHXmgW9cZaEl4uBUSCnselrxf7BT1WGP96/zMk5HkJyiLLbB
 3iB53DDLbV9RRQDZLQ644UIVTLvW5nWLKbz4LzCj4YoDxQOFgvs2ziSUkiNDvqcvS9wI
 UNf+UjvNj6tdAuxtg1zyctQTBf5iynbxLc0hoGq+O1l4oR8NM3URIs3+uWL+++ElqBTm
 DgbK4aw1jyS8HWRJqNK2AKPlC1p/ok0P5MYAG8zHAbff0Y53L16RFui9LzlKCj9a6sRf
 DHeB76h/uDw+d9+pIBRzDHThc8e1fGOuj8a8NzxaT+YqWWj+xRu3QyHBFyVKFwJyo+vz
 /KVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695715229; x=1696320029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzef6+OLYU9+x5ulSAXFhc7EI4OUgUY6x8D0726PIUA=;
 b=ualoWB0Gmhso6kxVpmzSiHqaTmbnNhlQuz9tckV2Jw63gdS/3s2EwUT+yofQXFNEWm
 cN1kuXur7j6wOHSPDcEgI4yn88+3YseIv5yojB5aoXHVUxZCdhE2JivSW/HKJf1Id6x4
 Lp5xQKqy+6156DQUZ3+WY5Cy5S0EeqdLtRQ3VUWKwLngDDdTDtosp2rmdc2YDn7zZLwY
 XvRq/NxGVZCI3tFrnTyHlNi4WE/rWSzWeAWiwPSIMLjMJXsaDQ0f+MTQJ1/Z7Cr/j3O4
 1Yz6GgQIlLclbOomwO92c6Utn8u9PDTOa8s5If0HUwTfRVcljZyfv07Kcz8oo+3zJeHo
 bQxQ==
X-Gm-Message-State: AOJu0YwrQexNcsugvIL6OfgUYMyDQkYHEREd13SL83eV3Dof3Q5y4BXQ
 8zGGEKzWuyRSqAHjBg2usGK/jNgE1pEgQPpETMA=
X-Google-Smtp-Source: AGHT+IFwJpIeJZro0/Etti5bDAAYlRRfYh8EQx/WtUGk+hpBSYZN8WGLZw1CsT6d6NhQrfJ9lvwGmPmOEia+x+54lOA=
X-Received: by 2002:ac8:5dcd:0:b0:417:cca3:d0ed with SMTP id
 e13-20020ac85dcd000000b00417cca3d0edmr11205627qtx.48.1695715229333; Tue, 26
 Sep 2023 01:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230913144959.41891-1-lersek@redhat.com>
 <CAJ+F1CJfROA9ezKi6Tzs1hLun8jpnWhrQCjreQdWhGro97CAyA@mail.gmail.com>
 <4c36a1eb-9a76-2231-4ead-d8daab657d84@redhat.com>
In-Reply-To: <4c36a1eb-9a76-2231-4ead-d8daab657d84@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Sep 2023 12:00:17 +0400
Message-ID: <CAJ+F1CKPaU5z8mnnFJWvw4CmFyEenFQ679A5Nf3CAqzJMqdqVA@mail.gmail.com>
Subject: Re: [PATCH 0/4] ui/console: multihead: fix crash, simplify logic
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

Hi Laszlo

On Mon, Sep 25, 2023 at 7:36=E2=80=AFPM Laszlo Ersek <lersek@redhat.com> wr=
ote:
> Has this been queued by someone? Both Gerd and Marc-Andr=C3=A9 are "odd
> fixers", so I'm not sure who should be sending a PR with these patches
> (and I don't see a pending PULL at
> <https://lists.gnu.org/archive/html/qemu-devel/2023-09/threads.html>
> with these patch subjects included).

I have the series in my "ui" branch. I was waiting for a few more
patches to be accumulated. But if someone else takes this first, I'll
drop them.


--=20
Marc-Andr=C3=A9 Lureau

