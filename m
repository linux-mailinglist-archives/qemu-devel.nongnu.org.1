Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A453978761D
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:55:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDbO-0003S3-4Q; Thu, 24 Aug 2023 12:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZDbG-0003RE-8u; Thu, 24 Aug 2023 12:54:26 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZDbE-0002ip-01; Thu, 24 Aug 2023 12:54:25 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-500913779f5so4660448e87.2; 
 Thu, 24 Aug 2023 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692896061; x=1693500861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMHvbuc2zY3isHaLJbx7XNfQkDZlZMB8BJIfCF7eZQQ=;
 b=khq0+xYoW/AsGpCZ/QvIfrTLTWloVf4w5IHHLSJUzZFPXWEVuqDSZRJejIZqIdoA0O
 TTpgqiXx52GrBggVNJH+P4IkgmAfxfe4SCtROy/ZsS6SXVz45hgt9KR0CecdTAamKZ/m
 zg/pM/mL2DweUNLdg2l2QSMv0qucTNSd3zA9oWLV9UTtri2M5EvoFogHQiVhznKNlPnr
 QPg+UKMPy52tiUvmavK+cJJpyWLbg2hOfWlyvHHs/+vkN03flpTJxYzRiGYEJ4bWAvTI
 DjWtihSSNctOUD17f6SKd5PSTCUaK6eNxaF2++NlCqtO6xO8UKPxrMbr/nKvGWf5DaLr
 5sGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692896061; x=1693500861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMHvbuc2zY3isHaLJbx7XNfQkDZlZMB8BJIfCF7eZQQ=;
 b=S2FrN3u/GGVlVSF7Tf/UAGmtv0mh0LOE11ZKuyKzOa19DVP4+lp45O12pKJgvIAZal
 lnGXM1K9bm5l85OSrFiUR+7QNBaPMepIQgLUAqN16ONH2QnTFJL2TLvCqxiNxaewt/Oi
 Xds9mOU2EVoh74kjrm0jPl2/o5xnUgkaElpC/QJjn1+SrFP/wTe/YvrAdbVKTxEuAotq
 PWjo7FLe0J2IyL4WTPWDmpApZGF1t3LZtbqAX/Z5ZAofgMms6KYHit9/2pyLlqjrdnLp
 jVpEW/c96nihxuBS03Y7b2IB2/T6dqVaDdHObbOILg/b8lx5lFt4P12E9wYdV3FRZWgm
 XoaQ==
X-Gm-Message-State: AOJu0YzN+x1mX0mv0+5xcmTspstvLsCCQXVn0kX0wKLI4sQKzpCQDcVc
 7ENOTuuFaDcMxhpNDy1Sy+mrBN1mge0ol7YBSM0lSRjpxYD6IZWR
X-Google-Smtp-Source: AGHT+IEJc4rqEaTUTGY5zVZ2gQd4HwfcMgGr+wLvhLlpdbIwTrL7xWvQ4Fgwk7O0fs9njVIQYl55RxmZBUMEq+X7e88=
X-Received: by 2002:a05:6512:3b28:b0:4fe:ecd:4959 with SMTP id
 f40-20020a0565123b2800b004fe0ecd4959mr15062042lfv.32.1692896060047; Thu, 24
 Aug 2023 09:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230824155345.109765-1-hreitz@redhat.com>
In-Reply-To: <20230824155345.109765-1-hreitz@redhat.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Fri, 25 Aug 2023 00:53:50 +0800
Message-ID: <CAAAx-8LvtrD66Mj11EuUhNFTQM4_cFcEQpsi52TgAvtsez5U3g@mail.gmail.com>
Subject: Re: [PATCH 0/5] file-posix: Clean up and fix zoned checks
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=faithilikerun@gmail.com; helo=mail-lf1-x132.google.com
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

Hi Hanna,

Hanna Czenczek <hreitz@redhat.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8824=E6=97=
=A5=E5=91=A8=E5=9B=9B 23:53=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> As presented in [1] there is a bug in the zone code in raw_co_prw(),
> specifically we don=E2=80=99t check whether there actually is zone inform=
ation
> before running code that assumes there is (and thus we run into a
> division by zero).  This has now also been reported in [2].

Thanks for catching the bugs and your work.

>
> I believe the solution [1] is incomplete, though, which is why I=E2=80=99=
m
> sending this separate series: I don=E2=80=99t think checking bs->wps and/=
or
> bs->bl.zone_size to determine whether there is zone information is
> right; for example, we do not have raw_refresh_zoned_limits() clear
> those values if on a refresh, zone information were to disappear.
>
> It is also weird that we separate checking bs->wps and bs->bl.zone_size
> at all; raw_refresh_zoned_limits() seems to intend to ensure that either
> we have information with non-NULL bs->wps and non-zero bs->bl.zone_size,
> or we don=E2=80=99t.
>
> I think we should have a single flag that tells whether we have valid
> information or not, and it looks to me like bs->bl.zoned !=3D BLK_Z_NONE
> is the condition that fits best.

The former way only checks zone information when it is being used to
avoid divide-by-zero or nullptr errors. Putting the error path with
non-zoned model implies a zoned device must have non-zero zone size
and allocated write pointers. Given that no other parts are changing
the zone_size to 0 and free wps, It does simplify the code path.

Thanks,
Sam

