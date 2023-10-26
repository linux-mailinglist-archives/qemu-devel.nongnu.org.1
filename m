Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2E67D8616
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:37:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2PV-0007BM-AW; Thu, 26 Oct 2023 11:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qw2PS-0007Av-Ic
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:36:34 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qw2PQ-0004Wv-M5
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:36:34 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso1601554a12.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698334590; x=1698939390; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3n9llgosqxqes5D9tlDuLIiGtCdA8SI9000y5sAhhl0=;
 b=OVtiQlsX7yxf0Z6o418o/SohTarE/CrP0fPMdZ412AEO1FD/9EQ1DeGYH7oqNpgZxz
 yKLHIFKDE0SI8MPz0rhb/PajJh2vequ/M62LRPXnUo+Lv+uxmk6qAehNUWzG6Qn0qtj+
 c8C3LyhvJRLlJWna8898RBjrv5Mp2FfgmnEIEBlQAYZO1Quna1lgJyeZRoN9nCAcXJMr
 bfI6wI+rKaEXo7YYg3lsuEEi4Fru6GJ1LPODQoVdvs2IkuxfK7PzhHciGvEI/Z94JI+Y
 MYLZNnFTm2H4ZBY7StWYCdXEBGXvr4ER6t3FvjH79G0AACKLgdCkIv2U6D3LnlS3rJP1
 WeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698334590; x=1698939390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3n9llgosqxqes5D9tlDuLIiGtCdA8SI9000y5sAhhl0=;
 b=j9yGyJc7hSVORvP3ha2q2S1yzCyPsH6gjoMNSpu+61wu0w1SW2Co1m81VPyCh/9TI5
 fo8iv3yDlHcc4zkJQ+2BWKBQUGBxlfB/ZJ1RZewNo2T5HMM243mHc+TBpTKTlWtpEnNA
 KBOS4Fx+yUUQGpfMH/v1B5kQ3+jlUHdGoYbLNf8VMPUSL0UNPYZMv0FApMzryqm7Ejv7
 4erZfb17ufBxq14PgQ2IsQckH/cpc1O/psU618lqJ5Xa4kRnjuspTkh89M6m6jeMBjb5
 zol9/3ywMkGxgDA/y0zkwkr2TQEh/JxiE3pjmzBelpWRr+jK488KjUGAz+C4smw/IgSh
 sfsA==
X-Gm-Message-State: AOJu0YyweZrXxxJ3pTufxY0aHxYWGWZ4CdK1D9UKRKwYIdIr4Y/NUghb
 LSrV1AefPshxQBqx4k9wlvSlU+xwg5bSbBbAPcv/vQ==
X-Google-Smtp-Source: AGHT+IFFSgg76VAEmmtAe1alCDuC8ImIxXQO9McQffZW6s1Kq+ZxHDG5AmzA1cADMZVLoV2/KFbzO5K/1Iqbhvi1KN0=
X-Received: by 2002:a50:cc88:0:b0:530:a186:f8a8 with SMTP id
 q8-20020a50cc88000000b00530a186f8a8mr122730edi.37.1698334590397; Thu, 26 Oct
 2023 08:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231026070636.1165037-1-clg@redhat.com>
 <5d9ab399-c5b2-41cd-9f2d-73d478e3c72a@virtuozzo.com>
 <bad03ec1-049c-46e2-a4da-dd2d6d88bad1@redhat.com>
 <53411f8f00c7abf3915d9f6e425e588d25740ded@linux.dev>
In-Reply-To: <53411f8f00c7abf3915d9f6e425e588d25740ded@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Oct 2023 16:36:18 +0100
Message-ID: <CAFEAcA-ygyBeVJbRqjdYBy9rC-c+MnXmp-EK1ik0z27k=1H1Bw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] vfio/pci: Fix buffer overrun when writing the VF
 token
To: Konstantin Ryabitsev <konstantin.ryabitsev@linux.dev>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>, 
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 26 Oct 2023 at 16:06, Konstantin Ryabitsev
<konstantin.ryabitsev@linux.dev> wrote:
>
> October 26, 2023 at 5:58 AM, "C=C3=A9dric Le Goater" <clg@redhat.com> wro=
te:
> > >  Reviwed-by: Denis V. Lunev <den@openvz.org>
> > >
> >
> > I changed that to "Reviewed-by".
> >
> > Interesting to see that b4 was ok with this new tag.
>
> When we see an email address in the trailer contents, we don't check it a=
gainst a known-trailers list, because there are just too many things like "=
Co-developed-by", "Reviewed-and-acked-by", etc. We could add some kind of l=
ogic to break these apart and compare individual parts to a list of known p=
erson-trailers (e.g. ["co", "reviewed", "developed", "and", "by", ...]), bu=
t we currently don't, which is why typos like this one sneak through.

From the QEMU development perspective, I would be mildly in favour
of having checkpatch at least warn about unusual trailers, because
I don't think the profusion of oddball stuff is actually helpful,
and nudging towards standardization and guarding against typos in
the tag string would be better (eg if you want to do both a review
and an ack, provide both tags, not an -and- tag that no tooling
that might be asking "did this get review?" will be looking for).
But I don't care enough to have actually looked at getting our
checkpatch to do this :-)

-- PMM

