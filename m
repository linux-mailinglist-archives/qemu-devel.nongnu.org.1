Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE6779D30A
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:59:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3vF-0004KZ-QV; Tue, 12 Sep 2023 09:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qg3vE-0004K0-6B
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:59:20 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qg3vB-00010c-PW
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:59:19 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-412091b9035so38713401cf.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694527156; x=1695131956; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAkym61TqbJicVlsUALVULd7bT11BCn03Z83m05NlXc=;
 b=FjB2YU8Po/RP4hR2hOBwUQodNWCDKRdKryDnQEr9OOo0Q+I3kA7F2OYAc9DXhSJpxG
 L/MfSijK1bj/z45HdEUhv0d3wEfgQEwSjQR4Zs50YsUN18ii/txlCEbOnVMs2crKp6Ii
 oIEbFrihIwdXR1GDjX2go+5iALaIvi8+AJQVRByhuS3iMMsRWEdJwXv77tMLG3falkvc
 NxNxgzWTsnjTxI9AwSiVz0Z2sXgHL8+x47+UZydQJL0tqZl7m02Q4tQkUO9Sbg4UpDjo
 nzj7wTP5sZVWl83OCAUsbGxuNKUHd1Y9CTjDCU+2/Pv0U2UOxOqGnGFS3iwAZNJsj4p0
 qbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527156; x=1695131956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAkym61TqbJicVlsUALVULd7bT11BCn03Z83m05NlXc=;
 b=uyH5eHx18N76/+C+TmZQXaTtakgYpwlSb1DJXhxH9FyVsT6h+bS/UcXwzGnR76kxFQ
 fvzIyXXTpUKI/d2E/K107cbc0UBqb6VSe3k4WSCJsBJEMFvKb1/unBs0KcBMlMhFTsVd
 hDF4yHhpfHPLz1jYKVbArMmOYYlUb3vdyo/iEaWHz9T99o9yOL7MZMm789dJfLPm8web
 E7mwgDzsqsyih08vUev3/4uEIPNzJhqT9b2t1hq7ToBfLcUmj/IR5fyLApCHJTGdt6Ze
 8LzGGNiOAkPS4Zlh7xwSDNn/M1n/IUKsEGCA0peZb4dQZBKsYiUfuKpElTjHWOXO4KIV
 pnWw==
X-Gm-Message-State: AOJu0YyjSkkvvUGYEZSHSpJlWtlhCTQs8BhhsMFiwYEWTtqA1RgWKzqk
 Dml+gZDJusUByFAdoJxuuAhIgFu+c2c5WqPjVUA=
X-Google-Smtp-Source: AGHT+IFIpcSaFhnJ6fB+m7b8RWCUrFIIzdxNgmbAL6WoXxOoBzoQtZTK8NU7uzSbF5bpxjG4UOIRjOhnReBCdpprhwo=
X-Received: by 2002:a05:622a:68c5:b0:415:2011:9890 with SMTP id
 ic5-20020a05622a68c500b0041520119890mr6699133qtb.40.1694527156625; Tue, 12
 Sep 2023 06:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230829003629.410-1-gurchetansingh@chromium.org>
 <ZO/6JXmYm/lW9dSZ@amd.com>
 <CAAfnVBmxaAbEX-0wVVwE94cKrGtoCRWKv58X73P+_hKM8-_hkQ@mail.gmail.com>
In-Reply-To: <CAAfnVBmxaAbEX-0wVVwE94cKrGtoCRWKv58X73P+_hKM8-_hkQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 12 Sep 2023 17:59:04 +0400
Message-ID: <CAJ+F1CJwATzG8by1tZucq15KbDHfE9OJEGq1jZ71UHivoTRsXQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/9] rutabaga_gfx + gfxstream
To: Gurchetan Singh <gurchetansingh@chromium.org>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

Hi Gurchetan

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
>

Packaging aemu and gfxstream is a bit problematic. I have some WIP
Fedora packages.

AEMU:
- installs files under /usr/include/host-common and
/usr/include/snapshot. Can this be moved under /usr/include/aemu
instead?
- builds only static versions of libaemu-host-common.a and
liblogging-base.a (distros don't like static libs much)
- could liblogging-base(.a,.so,..) also have "aemu" name in it?
- libaemu-base.so is not versioned
- I can't find a release tarball, nor the (v0.1.2) release tag
- could have a README file

I am not very familiar with cmake, so it's not obvious how to make the
required changes. Would you like me to open an issue (where?) or try
to make some patches?

gfxstream:
- libgfxtream_backend.so is not versioned
- I can't find a release tarball, nor the (v0.1.2) release tag


(packaging is important so we can build the new code in CI too!)

thanks

--=20
Marc-Andr=C3=A9 Lureau

