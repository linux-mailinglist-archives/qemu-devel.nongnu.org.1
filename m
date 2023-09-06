Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8966E79353E
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 08:26:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdlzH-0005Sc-4O; Wed, 06 Sep 2023 02:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qdlz8-0005SC-2E
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:25:54 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qdlz5-00087q-Jf
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 02:25:53 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41243a67b62so22513851cf.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 23:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693981550; x=1694586350; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+Iwid3XyiaRNLUM8EVMUG/09fGCNsZblDGZ5opM6gc=;
 b=pR/64VGxWkHouQV3BwsEIRSJWdKbd5ao9sAKeIMgYT3TLV7T593WemBMhV7FzKf68S
 HU3NZ3UQ7aB5jL1YE7i3Lj+DqPB/C5WtHGYEAidyN2zxKoSTvREct/YMKYqMS67SvgfO
 N0n3cHS+KoZllwfYzHKJApRY6acHJES2hcDKL4wZyGLqJfK/ksLDWACQfYNuLcr9QUXt
 eEucdqXtygePTOcKqBSOmftpq/ToDi0v/YIorfoFNzFEDT3n/K1/zGL0I4fS61ArND8L
 hntH8ZNr1iQY+Z5fPxVJYa8OkqofaFGQUxJfOR5xeQIkU/+FsalBoj5qA9+qLFiyy69H
 /0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693981550; x=1694586350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+Iwid3XyiaRNLUM8EVMUG/09fGCNsZblDGZ5opM6gc=;
 b=CaZD4d9+H8ipTZBAFclBTZv/If+UVkAlHFIv0FnXagi6OV+HlgCvo7CJf46+vpvXY8
 6h+LRJhI2Qy4Gp0A+jTkT049ROjnWTD+54IKY3AOcWdnP3xsB+hixDmXo14F6QDGZZJ8
 xjM3bsxzZQQ3v0Mp2FhYn3Ox4DZYT8U6GXp5BIJvBa1fDSxaiWGfLliKq8xu03k4zRWY
 yebtvyzHGimP/7gNZBYHeNLgbpykfsO9KCwP5y9cjvljfDvMaTKnlwzlw1EUHS6TszWr
 6D1WX/Ym5Kh1B6IsdQrAmg0GY8/HcD7RwVeJ3SmYtHBSVreSmB4b/KaFlpYm0Jxb6NRr
 xfqw==
X-Gm-Message-State: AOJu0Yyt5Ig6I3Qt0nosirJOah7ORmT8YnjNsWKHuHtCVMD/SoXr82Tz
 t8d0st4GlOesjnhXZa8jCcffkjd2+3Nu5KKFn3I=
X-Google-Smtp-Source: AGHT+IHYABo0mC1ucJkMWid7Tqf/TdM2xHhOijFHMnyXCl9bszcRdKD9lAVnuSyfpJJxzXA4x/o6cVrLiW6AtxF76gE=
X-Received: by 2002:a05:622a:110:b0:412:6db3:eda9 with SMTP id
 u16-20020a05622a011000b004126db3eda9mr20891754qtw.58.1693981550570; Tue, 05
 Sep 2023 23:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230829003629.410-1-gurchetansingh@chromium.org>
 <ZO/6JXmYm/lW9dSZ@amd.com>
 <CAAfnVBmxaAbEX-0wVVwE94cKrGtoCRWKv58X73P+_hKM8-_hkQ@mail.gmail.com>
In-Reply-To: <CAAfnVBmxaAbEX-0wVVwE94cKrGtoCRWKv58X73P+_hKM8-_hkQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Sep 2023 10:25:39 +0400
Message-ID: <CAJ+F1CJk9CTusH4t0pPMzSiN5B0we_zVje+j=azbSXoVzUR+Fw@mail.gmail.com>
Subject: Re: [PATCH v13 0/9] rutabaga_gfx + gfxstream
To: Gurchetan Singh <gurchetansingh@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Huang Rui <ray.huang@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "akihiko.odaki@gmail.com" <akihiko.odaki@gmail.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, 
 "shentey@gmail.com" <shentey@gmail.com>, "hi@alyssa.is" <hi@alyssa.is>, 
 "ernunes@redhat.com" <ernunes@redhat.com>, 
 "manos.pitsidianakis@linaro.org" <manos.pitsidianakis@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
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

Hi

On Wed, Sep 6, 2023 at 5:22=E2=80=AFAM Gurchetan Singh
<gurchetansingh@chromium.org> wrote:
>
>
>
> On Wed, Aug 30, 2023 at 7:26=E2=80=AFPM Huang Rui <ray.huang@amd.com> wro=
te:
>>
>> On Tue, Aug 29, 2023 at 08:36:20AM +0800, Gurchetan Singh wrote:
>> > From: Gurchetan Singh <gurchetansingh@google.com>
>> >
>> > Changes since v12:
>> > - Added r-b tags from Antonio Caggiano and Akihiko Odaki
>> > - Removed review version from commit messages
>> > - I think we're good to merge since we've had multiple people test and=
 review this series??
>> >
>> > How to build both rutabaga and gfxstream guest/host libs:
>> >
>> > https://crosvm.dev/book/appendix/rutabaga_gfx.html
>> >
>> > Branch containing this patch series:
>> >
>> > https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v13
>> >
>> > Antonio Caggiano (2):
>> >   virtio-gpu: CONTEXT_INIT feature
>> >   virtio-gpu: blob prep
>> >
>> > Dr. David Alan Gilbert (1):
>> >   virtio: Add shared memory capability
>> >
>> > Gerd Hoffmann (1):
>> >   virtio-gpu: hostmem
>>
>> Patch 1 -> 4 are
>>
>> Acked-and-Tested-by: Huang Rui <ray.huang@amd.com>
>
>
> Thanks Ray, I've rebased https://gitlab.com/gurchetansingh/qemu/-/commits=
/qemu-gfxstream-v13 and added the additional acks in the commit message.
>
> UI/gfx maintainers, since everything is reviewed and there hasn't been an=
y additional review comments, may we merge the gfxstream + rutabaga_gfx ser=
ies?  Thank you!
>

I can take it, or Michael (since Gerd is not focused on QEMU atm).

Michael, are you prepping a virtio PR?

thanks

--=20
Marc-Andr=C3=A9 Lureau

