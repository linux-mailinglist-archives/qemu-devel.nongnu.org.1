Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF54785AFB
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:43:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYp3n-00037Z-VX; Wed, 23 Aug 2023 10:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qYp3T-00036u-IX
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:41:55 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qYp3R-0004j6-Sz
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:41:55 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-570c36ec14bso2310354eaf.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692801711; x=1693406511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jha2v+ZMs1dIHdJTsMyu5PZqo8ox2cafr9qOk8hvLmE=;
 b=adpHHLJL/NZu2lq4UzdcfNzwJtdDhlHRD2XavAgiLaqLoWYMT/i/2dwwa7hlNATCOy
 VIMPsYn8QKLRLV+AN7aPVDKOFOv4aIuw5J3lmqj9fI89viyi92T86rKM32F1sjwfuxso
 H/xf5FpzqcnJM+8bbEXpLjckSzo72Ch89gNKzO5TZIirHlEsYeDuMlAw1T1/S5Lgsgun
 CT4QN9qDPweVcmkQqKh8YroZ1ODvGyNUKWvolT/gibMlBA8Z5U1d9Cwn7/TmLJpoDnwA
 0VjHARoB116sHuUTCzMu23S8ATrq0pcfD1W3F6sl7JvF938CepnPFnRbROfOwBWqVN2Z
 rrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801711; x=1693406511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jha2v+ZMs1dIHdJTsMyu5PZqo8ox2cafr9qOk8hvLmE=;
 b=dIZ3JjrnFXf0g6NXpTbcA9oCexarmO7dRYGOwfgf5i9ISBsL4069AkqocHBtteCsse
 yUR9tm8Kzf4CsnxVL7PaP3gN9H4Uiml9TVNWFCwA5RBrlABcS/F8wsg6paYckjtZr/ux
 oAeRcaK4HM+piVoF+SHhtJK0wJWRP5/SYW7RqsnIS+BOS7t61/3G0eBj2xIgDteQU3HA
 Nt9460sHrCCVFdVP7PFr644T3aqDBwmNvUEpFmOVzCMeLNA4475cleiHu4wFcg7Zf71P
 KO8ZxN0i+Yc9aeXE9JAPQyRUA4mYUI59oY4TIqiNUuWCn6RT9wEtYX8gbybkpHLMcVM4
 XTqw==
X-Gm-Message-State: AOJu0YzuxGYrMpVKMw0i0BwmOT++7R9CdJn3SYcqwxjYwHlonYN3bWIi
 TeAxnB7vjKYXvQw9u1R9bndsFwAKFmPblyglo9s=
X-Google-Smtp-Source: AGHT+IHWMgB8ahhCmQe4kD8Ac8iTbSe4qihQWzKvqXswo9aUVsYMrYhp9iiEXaOBBli+KVOORusFQk4SI316JUbciuI=
X-Received: by 2002:a4a:3515:0:b0:570:be00:5e14 with SMTP id
 l21-20020a4a3515000000b00570be005e14mr10318349ooa.8.1692801711539; Wed, 23
 Aug 2023 07:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU7gp1OjmrGhV1Y4jLRF0DYQAG=vn7LTS8SOa0eADW70Q@mail.gmail.com>
 <CAAAx-8KKesRCK1-4-1Yx=SvsmMgxBZKLaCZXPZkKk4vyDkEOVg@mail.gmail.com>
In-Reply-To: <CAAAx-8KKesRCK1-4-1Yx=SvsmMgxBZKLaCZXPZkKk4vyDkEOVg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 23 Aug 2023 10:41:39 -0400
Message-ID: <CAJSP0QVsStbxhxRJZjNhfEcXbUUaL1d-Qq1g9QtpH762R3CE6Q@mail.gmail.com>
Subject: Re: NVMe ZNS last zone size
To: Sam Li <faithilikerun@gmail.com>
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Val Adler <spantamd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc33.google.com
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

On Wed, 23 Aug 2023 at 10:24, Sam Li <faithilikerun@gmail.com> wrote:
>
> Hi Stefan,
>
> Stefan Hajnoczi <stefanha@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=B8=89 21:26=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi Sam and Klaus,
> > Val is adding nvme-io_uring ZNS support to libblkio
> > (https://gitlab.com/libblkio/libblkio/-/merge_requests/221) and asked
> > how to test the size of the last zone when the namespace's total size
> > is not a multiple of the zone size.
>
> I think a zone report operation can do the trick. Given zone configs,
> the size of last zone should be [size - (nr_zones - 1) * zone_size].
> Reporting last zone on such devices tells whether the value is
> correct.

In nvme_ns_zoned_check_calc_geometry() the number of zones is rounded down:

  ns->num_zones =3D le64_to_cpu(ns->id_ns.nsze) / ns->zone_size;

Afterwards nsze is recalculated as follows:

  ns->id_ns.nsze =3D cpu_to_le64(ns->num_zones * ns->zone_size);

I interpret this to mean that when the namespace's total size is not a
multiple of the zone size, then the last part will be ignored and not
exposed as a zone.

>
> >
> > My understanding is that the zoned storage model allows the last zone
> > to be smaller than the zone size in this case. However, the NVMe ZNS
> > emulation code in QEMU makes all zones a multiple of the zone size. I
> > think QEMU cannot be used for this test case at the moment.
> >
> > Are there any plans to allow the last zone to have a different size?
> > Maybe Sam's qcow2 work will allow this?
>
> Yes, the zone report in qcow2 allows smaller last zone.
> Please let me know if there is any problem.

Great. Val can try your qcow2 patches and see if that allows her to
test last zone size !=3D zone_size.

Thanks,
Stefan

