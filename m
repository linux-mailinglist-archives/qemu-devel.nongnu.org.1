Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA757854D2
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 12:04:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYki3-0007t5-Su; Wed, 23 Aug 2023 06:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qYki2-0007rX-6X
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 06:03:30 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qYki0-0005pU-A5
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 06:03:29 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4103aa6229cso30040851cf.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692785007; x=1693389807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iutk+1bfukUXy3bF772sqNmgSjd3Lsyp4QlTkRqxTE4=;
 b=KmAbtopwcVVtLryLiLflyh0MmoU8gVfeuZFqepY7uwCvgW7XOUxCCm4UFys3NUajly
 lDe2xLtZB1xhBfcM6nqQVrZzSBb9kALPypThag0zrVUoLyrwNVc/iW5Y3yQ2dE7A9Aig
 5kcr6xTfQiloFR9scUl+Gu8SyOIr2HU+2Iyf4qhQ9QYJCd/4tLUfN21V4/nfsPe8ja79
 Y+aVjbblH95apmndrqZEytqC30dqokdl6a0dQV8tZxgcIe2DR2DigMlD+IZ0Ry3ZOVZP
 h3YQq6BaEiObiK/jTPG8opBSb6GlKX19kENcn+1at4nR+ua8PKhJ//gDHpaz2CWhEa6J
 PaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692785007; x=1693389807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iutk+1bfukUXy3bF772sqNmgSjd3Lsyp4QlTkRqxTE4=;
 b=egSWOASvmCpeUuRMgdyB5uC019gF6fnbRX7aSI1hgHfwWAhntn+1zeowRU9AEM70M6
 3qd1mKvkRS931wKO+xnYt31/yz6213vBs1G2XYu6b1/FHbpD7CXZVOBw2qN+gMJNnI0W
 nV+STJ1Yg+RwT7cTi/7I+XFZXGZsSH4SELBWO1gnb4KKkNC0BhuzFK/92dpvYSavzL9l
 5Z6J/fJys/NQ250mEdWkArgoNCsF3PXQy9dxXSGwkRG+urgo3NJ/6fM16PS4atgDTsrO
 PDcWP8/83Q48oix8JEePjAz7iqRVsYL183D4RMR++iJ4BFitYQjfm6fqG7jrQfd3vCZi
 Z5og==
X-Gm-Message-State: AOJu0Yyd+Jd27+BPA/ERQ3OnThuJ3dFPKfB2W5GkZm4q2zSZhxXXsBY2
 W4HQVs0Ocl9Hg3uv+XZFLq5fB5gXhczT3v+1Zk0=
X-Google-Smtp-Source: AGHT+IG1h9rZ9dHmLFlMQ5hWtrR1QINBHGRG/Nk1f5QUXdeaOqC9UZrEzwQ9ngJ3TvZmM0Jw8laxklVimlmrkUDTDZA=
X-Received: by 2002:a05:622a:19a2:b0:411:d31b:9864 with SMTP id
 u34-20020a05622a19a200b00411d31b9864mr836433qtc.4.1692785006852; Wed, 23 Aug
 2023 03:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
 <20230717163855.7383-3-stephen.s.brennan@oracle.com>
 <CAJ+F1C+VFpU=xpqOPjJU1VLt4kofVqV8EN4pj5MjkkwWvVuxZw@mail.gmail.com>
 <87edl4d9wi.fsf@oracle.com> <87fs4aha4t.fsf@oracle.com>
In-Reply-To: <87fs4aha4t.fsf@oracle.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 23 Aug 2023 14:03:15 +0400
Message-ID: <CAJ+F1CKCdy3J8AD9EGvVO+CU6-yFPrLZ2Lum1SDgdj_kghFdQw@mail.gmail.com>
Subject: Re: [PATCH qemu 2/2] dump: Only use the makedumpfile flattened format
 when necessary
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, 
 joao.m.martins@oracle.com, Richard Henderson <richard.henderson@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

On Wed, Aug 23, 2023 at 4:31=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> >> I am a bit reluctant to change the dump format by default. But since t=
he
> >> flatten format is more "complicated" than the "normal" format, perhaps=
 we
> >> can assume all users will handle it.
> >>
> >> The change is probably late for 8.1 though..
> >
> > Thank you for your review and testing!
> >
> > I totally understand the concern about making the change by default. I
> > do believe that nobody should notice too much because the normal format
> > should be easier to work with, and more broadly compatible. I don't kno=
w
> > of any tool which deals with the flattened format that can't handle the
> > normal format, except for "makedumpfile -R" itself.
> >
> > If it's a blocker, I can go ahead and add a new flag to the command to
> > enable the behavior. However there are a few good justifications not to
> > add a new flag. I think it's going to be difficult to explain the
> > difference between the two formats in documentation, as the
> > implementation of the formats is a bit "into the weeds". The libvirt AP=
I
> > also specifies each format separately (kdump-zlib, kdump-lzo,
> > kdump-snappy) and so adding several new options there would be
> > unfortunate for end-users as well.
> >
> > At the end of the day, it's your judgment call, and I'll implement it
> > how you prefer.
>
> I just wanted to check back on this to clarify the next step. Are you
> satisfied with this and waiting to apply it until the right time? Or
> would you prefer me to send a new version making this opt-in?
>

Nobody seems to raise concerns. If it would be just me, I would change
it. But we should rather be safe, so let's make it this opt-in please.



--=20
Marc-Andr=C3=A9 Lureau

