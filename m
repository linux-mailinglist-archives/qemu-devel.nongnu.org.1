Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BC1785B50
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 17:00:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpKl-00054Q-Ms; Wed, 23 Aug 2023 10:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qYpJm-0004mO-H2
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:58:46 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qYpJk-0007sf-Km
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:58:46 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5008faf4456so2866868e87.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692802723; x=1693407523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jo8ZweHS9ci2E0JEvObb1LSNfnffu2Bn7kIn8EFZDkY=;
 b=byrvy5uM+ZhZNiuMd+YM2dyIMFUexj6BsQdVJwq5L5RifmFCUVNqYimXO3ApIrj0eF
 /XL4HCalxCYzvZ2iCP8iefcJ+2rcF+ViTyF6zq+AkybwuvPvc0u3RUFwPOg/dWni0/ax
 uzVdWEzf6sLLCkqaSjFemFzaaFNdcJXFO8UeUh14s5ay0xP9MHxDp654ggEvLE50xTyM
 c7SkDzTuWOrQQp4yQQXyHRA1C07TTAL0w74w2EjyhGDIG5pn8jWl/r5KdttS0uP8KHCf
 MxKkaK/tAGMD9uaUSuElD+/iFbYAlDIJgUVZdOEf0bNrQJDaj8ngFlXRtOuz/E9e630w
 re6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802723; x=1693407523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jo8ZweHS9ci2E0JEvObb1LSNfnffu2Bn7kIn8EFZDkY=;
 b=LQdHRDOZITCxQjT85FqVvPfb0lcpdMnslFhtbQlLUhaxxsNSb62wzpKa2nE2RsWVO5
 HOXPp/W1io4axWfng3DkJyQ9iUVOMfgGdo5+bq5sZhxdTZTIdaxxVv7Q9TsLTC3uzdZN
 AYt11gsjTt3Pokr/DkelAoU+CHKvCqV8IIuAnL4pDi5+3+9XGB6Nc70XV6S4L4+2CxZy
 3D92ArfN3apshl7SGV622fjOXQxQEk0NLvyU/rv/mhZ2EbOmJSuIU2kTay5Bs7HEXyJu
 lXV1JR6vXRhMWWYw15an0k/y2QkOz6lSxVb6B1u5di5ty3LuEo0E711ciZI4ys8sAd4c
 nrHQ==
X-Gm-Message-State: AOJu0YyavvLIDEO5NpokoW/2LnVIAJqHMEPyrcugLOsVOmHi5vOJmMBO
 dF6IHFoO98LmLlX23nzFXCsgTMT4fSjXHVCKV54=
X-Google-Smtp-Source: AGHT+IESkj2YMtY0o1xRctwqkuVx1UYyi7/Gnu0k3MkS7t0CpAfNwXtPPfEmJXfj1JiWVZ7w/o3dU9u+V4xxjw9z1mE=
X-Received: by 2002:ac2:551b:0:b0:500:9a29:bcb0 with SMTP id
 j27-20020ac2551b000000b005009a29bcb0mr799280lfk.42.1692802721954; Wed, 23 Aug
 2023 07:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU7gp1OjmrGhV1Y4jLRF0DYQAG=vn7LTS8SOa0eADW70Q@mail.gmail.com>
 <CAAAx-8KKesRCK1-4-1Yx=SvsmMgxBZKLaCZXPZkKk4vyDkEOVg@mail.gmail.com>
 <CAJSP0QVsStbxhxRJZjNhfEcXbUUaL1d-Qq1g9QtpH762R3CE6Q@mail.gmail.com>
In-Reply-To: <CAJSP0QVsStbxhxRJZjNhfEcXbUUaL1d-Qq1g9QtpH762R3CE6Q@mail.gmail.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Wed, 23 Aug 2023 22:58:10 +0800
Message-ID: <CAAAx-8+ugwD4a3NEs36afYREKpf8LPj1jUpLNrO7gFugdVs+fg@mail.gmail.com>
Subject: Re: NVMe ZNS last zone size
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Val Adler <spantamd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=faithilikerun@gmail.com; helo=mail-lf1-x129.google.com
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

Stefan Hajnoczi <stefanha@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=B8=89 22:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 23 Aug 2023 at 10:24, Sam Li <faithilikerun@gmail.com> wrote:
> >
> > Hi Stefan,
> >
> > Stefan Hajnoczi <stefanha@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=B8=89 21:26=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hi Sam and Klaus,
> > > Val is adding nvme-io_uring ZNS support to libblkio
> > > (https://gitlab.com/libblkio/libblkio/-/merge_requests/221) and asked
> > > how to test the size of the last zone when the namespace's total size
> > > is not a multiple of the zone size.
> >
> > I think a zone report operation can do the trick. Given zone configs,
> > the size of last zone should be [size - (nr_zones - 1) * zone_size].
> > Reporting last zone on such devices tells whether the value is
> > correct.
>
> In nvme_ns_zoned_check_calc_geometry() the number of zones is rounded dow=
n:
>
>   ns->num_zones =3D le64_to_cpu(ns->id_ns.nsze) / ns->zone_size;
>
> Afterwards nsze is recalculated as follows:
>
>   ns->id_ns.nsze =3D cpu_to_le64(ns->num_zones * ns->zone_size);
>
> I interpret this to mean that when the namespace's total size is not a
> multiple of the zone size, then the last part will be ignored and not
> exposed as a zone.

I see. Current ZNS emulation does not support this case.

>
> >
> > >
> > > My understanding is that the zoned storage model allows the last zone
> > > to be smaller than the zone size in this case. However, the NVMe ZNS
> > > emulation code in QEMU makes all zones a multiple of the zone size. I
> > > think QEMU cannot be used for this test case at the moment.
> > >
> > > Are there any plans to allow the last zone to have a different size?
> > > Maybe Sam's qcow2 work will allow this?
> >
> > Yes, the zone report in qcow2 allows smaller last zone.
> > Please let me know if there is any problem.
>
> Great. Val can try your qcow2 patches and see if that allows her to
> test last zone size !=3D zone_size.

Not sure how the test is set up. If requiring nvme passthrough, maybe
zns patches need to be on top of qcow2 patches. There are still some
cases to be fixed up. So just let me know any problem is on my side.

In case Val needs it, the lastest branch is:
https://github.com/sgzerolc/qemu/blob/dev-zns-v3/

Thanks,
Sam

