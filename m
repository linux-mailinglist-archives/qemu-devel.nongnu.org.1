Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 553967CB9E8
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 07:17:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qscQY-0007Yl-HQ; Tue, 17 Oct 2023 01:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qscQR-0007Wy-5S
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 01:15:27 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qscQO-0006my-0r
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 01:15:26 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-77574c6cab0so380790385a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 22:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697519722; x=1698124522; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+tT6xZrPn3aG3uPJbm2P8o7N/iESQamTnh+oVp1bCk=;
 b=KUOrxl+fcGnhC6SsYZnt4pIMBlYyFvOJCYV0Ei1QNxC3YjifZCw7qhkYLIyk/AYXic
 +uCRac+TDECxXCHppGEJEVh0iBUL6KE1z504CASGfx/P+TDG/5rizbHdlflI52s9rjd0
 lloiFS3T+0IguPbVlFW5rTmo9nkc43fUILKqDLJlGUHRIKjx7o8pAMLVqwIckiFfanA4
 Jr0CQZcmAdexPDP58T+WQBsNjMS+kCCmHjRZvUIIvP1gFON3eODXOFMN3G4IaraFkN4Y
 vzk4nhzL10/C62geJHuK31UYBxKX/WA1GZo0QC8jGhIx2z8GIT8cmsfTYcHSAUpIy6+S
 p3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697519722; x=1698124522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+tT6xZrPn3aG3uPJbm2P8o7N/iESQamTnh+oVp1bCk=;
 b=geW0A/nhkc9mOlVGAJWiZl5zoyD/qMo5xt27RJcwQ/h0dXTWdNOnVBpk6YL6+nmoQu
 JO+prpOuW6n7in8OwR59MMIhQuLd2fpOhK7YoVMQdzEEQ6nffl89bA0VZCy/R8oCkywR
 cKMyrD5XcuF5TryPgr7LlVjp7gDUlkJgfF1BLt8DzwsT/ajVBkj7kkmiNIPgvw5VDSyB
 8qr90RzfJzvMIhMK5nq5DDcTvJa6+ERAD5N7ZZM+7VlIvnKQtPWDyFXIpQPY52d2KHGE
 r01fRh/COXmPRHFW44AjMHZMFUBrh5KRslFXIWE7tomWqDLCU5iynxd/9lqpqU5OlYiD
 LAqA==
X-Gm-Message-State: AOJu0YzEV4XuqnCS+iVWHiPsFDl+rL3cRGdv4eNaTRgwOQ7Q2wblPI7/
 eBHs/4f/02ZBA2zLi1YHSoSvWHazgb9Vowfbz8Q=
X-Google-Smtp-Source: AGHT+IGvCw1cN2BeWC2rTeNXC0L/GJWu+Txabk80gzqqijvXmSOc9k+NxOOnweb2WIw/DL1mzEmLRt6xLgchOxWP4UE=
X-Received: by 2002:ac8:7f86:0:b0:416:5e11:f7ec with SMTP id
 z6-20020ac87f86000000b004165e11f7ecmr1197381qtj.52.1697519722143; Mon, 16 Oct
 2023 22:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231006010835.444-1-gurchetansingh@chromium.org>
 <CAMxuvay04ZF7awEG0Hv9mhPvUTnjMmQ+TL4a=hMEkFwrgcR5Vw@mail.gmail.com>
 <CAAfnVBkaU7NRwbkgC3tuf5R4U5vVX2rvj-1=0AE5wyQjT0-=Rw@mail.gmail.com>
In-Reply-To: <CAAfnVBkaU7NRwbkgC3tuf5R4U5vVX2rvj-1=0AE5wyQjT0-=Rw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Oct 2023 09:15:10 +0400
Message-ID: <CAJ+F1CKDK2O_sCSwR_CWy__3S-KRhMECcQ6L=UfsOQkm5hDE5A@mail.gmail.com>
Subject: Re: [PATCH v17 0/9] gfxstream + rutabaga_gfx
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 akihiko.odaki@gmail.com, 
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, 
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, 
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72d.google.com
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

On Tue, Oct 17, 2023 at 5:27=E2=80=AFAM Gurchetan Singh
<gurchetansingh@chromium.org> wrote:
>
>
>
> On Mon, Oct 9, 2023 at 12:15=E2=80=AFAM Marc-Andr=C3=A9 Lureau <marcandre=
.lureau@redhat.com> wrote:
>>
>> Hi
>>
>> On Fri, Oct 6, 2023 at 5:08=E2=80=AFAM Gurchetan Singh
>> <gurchetansingh@chromium.org> wrote:
>> >
>> > From: Gurchetan Singh <gurchetansingh@google.com>
>> >
>> > Branch containing changes:
>> >
>> > https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v17
>> >
>> > Changes since v16:
>> >
>> > - Fixed typo mentioned here:
>> >
>> > https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01407.html
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
>> >
>> > Gurchetan Singh (5):
>> >   gfxstream + rutabaga prep: added need defintions, fields, and option=
s
>> >   gfxstream + rutabaga: add initial support for gfxstream
>> >   gfxstream + rutabaga: meson support
>> >   gfxstream + rutabaga: enable rutabaga
>> >   docs/system: add basic virtio-gpu documentation
>> >
>>
>> Except for a few misc style issues, the series looks good to me.
>>
>> Gerd, as the virtio-gpu "odd fixes" maintainer, any chance you take a
>> quick look and ack the series? Even better if you send a PR :)
>
>
> Ping.  Branch containing latest series with the minor fixes Marc suggeste=
d is here:
>
> https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v18
>

I sent a PR yesterday:
https://patchew.org/QEMU/20231016135404.899743-1-marcandre.lureau@redhat.co=
m/

--=20
Marc-Andr=C3=A9 Lureau

