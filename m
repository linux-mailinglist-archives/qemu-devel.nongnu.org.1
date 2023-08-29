Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D31E578CB4B
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:32:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2Z5-0000ZX-5H; Tue, 29 Aug 2023 13:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qb2Yv-0000Ui-2R
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:31:34 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qb2Yr-0003Ni-Jo
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:31:32 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5734f54dc44so2404555eaf.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693330287; x=1693935087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eyQFQdfR4E01U9ynFjh5THrb2KCxoLfpxG4C3KkGWek=;
 b=MuRu78q7tpaWsku/2pNDfxwHzZwFeakKMD+vfvICtvPtrjqDgiY1lh3v7tLgedZrJa
 PZ4I09yPL9B25kAE+S1hkH1E4+zGaZJLEXXkNbzJn37T1hpO6gl9YpCShs0DZcjAJ3ac
 9EjV+OuPWwZqM4v3M/GwmPs2GPlf2OQPTGA+j17EnEY5MbZII7OQDkO95SRQUACb8W16
 /FhNwXzuPH9Faz5s5sy2nRa/Wt1UTmtR5BmBnKHVYFXA6VvkZ0bILPHrx7aB7LF0GPEh
 bfYpMMU15x4drm+mytDjtIxX1feWm3SiaCmS8q4iyvIIb2ek/6fACU331ndl6N8uQxHc
 MieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693330287; x=1693935087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eyQFQdfR4E01U9ynFjh5THrb2KCxoLfpxG4C3KkGWek=;
 b=kvAbJRp6X4tOCXPni/7qWnbzDNnHhO565kH4/E6s6ps04sD/rVVap5grBcYVyjstpB
 WCkHgMRqYjWCat5MmoQBZlq+knSExR3tX5xuIUe9v0d9/kFgm6wQj4kVL2KuJdv9/nYZ
 NaFUXRr9tWh72Ut/debGGj67sQSVMxrY73KmHELp1ogn15vCrJYIisZRP1rfKMrGDZJK
 f2cpq6urAP6ulPHa9YGdWsBZ1KMzrxYmSoWsMu91MJ0CaepRaYxcXRvt6a1BtBdWcagA
 LxoNMQvBTrE3uPIqck1ul8UkxH1ejKMVwyc9g0HMrOp5hOZ9MXbtzeYEUXQN7dR9rTm7
 SUPA==
X-Gm-Message-State: AOJu0Yzwux8Ax2y80bysReNcRVU+mE3AG9TQweH+QaiquX3sanuf5IyG
 NOWrtRTZTmatCX2CaoRnbjjaIrxI6IqNI+I+uVQ=
X-Google-Smtp-Source: AGHT+IEZIiKcd/XS2jOZPu17pZFWMvmC4vY3G+XJPgRM/hhny4oQSHg05xqyyGmwC4WAg/+KgYI7GaDH7ule3mAzUlg=
X-Received: by 2002:a4a:6c1d:0:b0:571:1fad:ebdd with SMTP id
 q29-20020a4a6c1d000000b005711fadebddmr15398611ooc.1.1693330287341; Tue, 29
 Aug 2023 10:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693228686.git.yong.huang@smartx.com>
 <CAJSP0QXLticPp0DOS=7bYQf0R0MiYpRXYu_dCRE9JVUbZd2nsw@mail.gmail.com>
 <CAK9dgmai9Q0cSYudyM8PBb1AZyxcv6G6BTrRAeJL2EaaR8CNUg@mail.gmail.com>
In-Reply-To: <CAK9dgmai9Q0cSYudyM8PBb1AZyxcv6G6BTrRAeJL2EaaR8CNUg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 29 Aug 2023 13:31:15 -0400
Message-ID: <CAJSP0QXa1mn-W9pAhRmFYU0V3Y2C_K4Ca=KXsmaZ-bheiVB_+Q@mail.gmail.com>
Subject: Re: [PULL 0/3] Dirty page rate and dirty page limit 20230828 patches
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Andrei Gudkov <gudkov.andrei@huawei.com>, 
 "alloc . young" <alloc.young@outlook.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2b.google.com
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

On Tue, 29 Aug 2023 at 12:30, Yong Huang <yong.huang@smartx.com> wrote:
> On Tue, Aug 29, 2023 at 4:01=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.c=
om> wrote:
>>
>> On Mon, 28 Aug 2023 at 10:36, Hyman Huang <yong.huang@smartx.com> wrote:
>> >
>> > From: Hyman <yong.huang@smartx.com>
>> >
>> > The following changes since commit 50e7a40af372ee5931c99ef7390f5d3d6fb=
f6ec4:
>> >
>> >   Merge tag 'pull-target-arm-20230824' of https://git.linaro.org/peopl=
e/pmaydell/qemu-arm into staging (2023-08-24 10:08:33 -0400)
>> >
>> > are available in the git repository at:
>> >
>> >   https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-fixe=
s-pull-request
>>
>> Hi,
>> This is not a signed tag. Please use "git tag -s" so the tag is signed
>> with your GPG key.
>>
>> I also noticed that this pull request email thread only has a cover
>> letter. Please also send the individual patches along with the pull
>> request email. This makes it easier for people to reply if they have
>> comments about a patch.
>>
>> After pushing a signed tag, please send the pull request again with
>> "PULL v2" in the subject line. Thanks!
>
>
> Sorry for not noticing this earlier and I have sent a pull request with "=
PULL"
> in the subject line instead of "PULL v3" that you mentioned above, please
> ping me if PULL request resending is required indeed.

I have applied the pull request. To make it easier to verify future
pull requests, please publish your public key to a keyserver:

  $ gpg --send-keys DFF223D6B3FECB9C

Thanks!

Stefan

