Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7BF740990
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:54:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEP3d-0004Nq-8b; Wed, 28 Jun 2023 02:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEP3b-0004Ni-5O
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEP3Z-0004mT-JB
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687935216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVyv+gDs3qL5P0vi5Zgdj13zekhuVAfUswH+FWVMbpM=;
 b=aPZEW/DFYjH9R9D0fPyzwirpzySAdY2afG7wCOu1BOFcUyzdxeqpItsxe7r4rK1sfypBuP
 QKXd+eRjx+bMNfB6C2oFfAgHx+a8PbSrRqVoV2B5tnR6gSvU/dpKjnB8HnnNM3if1OOzOL
 PhHUc6AhE0Y1GmaOPyfDCFS311Vqo5s=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-JhSUI75EMFiGMHrAGHhPWA-1; Wed, 28 Jun 2023 02:53:34 -0400
X-MC-Unique: JhSUI75EMFiGMHrAGHhPWA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b699c5f238so28057561fa.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 23:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687935212; x=1690527212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVyv+gDs3qL5P0vi5Zgdj13zekhuVAfUswH+FWVMbpM=;
 b=HT+pBJEqFVac3pcNk/eIj+Y5gfNEX0j6BqCtU3qoD549tCPU7U05iU416i3hIAKpqt
 qEfhYImkUdUzvO9VpPksPEybCJMcfzhXiVw+5uNkV2oRUQYUIP42n1cfS/vRiDUhlmui
 CYVn/qWmquTOMP+QzbDbtbcE/RyhVzf/vBo/wddyI5cWh6zdMEGIraDlXjVoUkKGZoBz
 YLuNk2w25qnR7OtJWAujCN5uZqT7kSZFRxXFkw+dRc/x2u1kFxThkdGZeDxlLKsyw64W
 Z7lOpEaufME2qrrdZDw4XV76Akzv5uTqFYabBB+O+rfmJCLP9F37agfj/AaZs0zubIPv
 JnZg==
X-Gm-Message-State: AC+VfDxQQ6DXuKVTrkyEwAwYKHFPQTdU5/E46y0d1rlkjGEuLw/G2CUK
 yOEYseBDBF3ShJA7LrmzI8AR9K/4WfGNwNUB+B+9cT4/z5UWNGx2HpgovIkOjitHbUaEDZfodqv
 c/SfeaOHGXOBElVdTxPPIb+MiMEXV6b7GuxYbHBzBWHYM
X-Received: by 2002:a2e:9e4f:0:b0:2b1:b4e9:4c3 with SMTP id
 g15-20020a2e9e4f000000b002b1b4e904c3mr23371187ljk.2.1687935212639; 
 Tue, 27 Jun 2023 23:53:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74njz1EoXv0JSfOdUZ52ASXUjQfcVovmUvXAO3FPgxZ2VxNl+6GKQ9UHMBn54I7WUebWbEi8PiO5lJaiTJrvI=
X-Received: by 2002:a2e:9e4f:0:b0:2b1:b4e9:4c3 with SMTP id
 g15-20020a2e9e4f000000b002b1b4e904c3mr23371166ljk.2.1687935212208; Tue, 27
 Jun 2023 23:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <ACCE3C63-50B6-4310-9DF6-F1BE759F5B1E@redhat.com>
 <20230627103454-mutt-send-email-mst@kernel.org>
 <25A57CF2-5027-48B7-A879-8DE8BDEF60B3@redhat.com>
In-Reply-To: <25A57CF2-5027-48B7-A879-8DE8BDEF60B3@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 14:53:21 +0800
Message-ID: <CACGkMEtjPqWYcF_bPoSu9AjrYJFVsXMh+q4ADtdz5HMG64dVcg@mail.gmail.com>
Subject: Re: ARI and igb emulation
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, akihiko.odaki@daynix.com, 
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 27, 2023 at 10:41=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wr=
ote:
>
>
>
> > On 27-Jun-2023, at 8:09 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 27, 2023 at 08:02:46PM +0530, Ani Sinha wrote:
> >> Hi :
> >> I am proposing a patch in QEMU [1] which may or may not break ARI but =
I wanted to give my best shot in making sure I am not breaking anything wit=
h ARI enabled. I see that your igb emulation code enables ARI with its SRIO=
V emulation. I ran the qtest and avocado tests that are mentioned in [2] an=
d they both pass. Is there anything else/any tweaks that I should be doing =
to make sure I am not breaking ARI with igb?
> >>
> >> Thanks for information,
> >> Ani
> >>
> >> 1. https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05478.html
> >> 2. https://www.qemu.org/docs/master/system/devices/igb.html
> >>
> >
> > I think that just creates igb. to test ARI you need to add
> > igbvf devices. Jason maintains it. But really pls go back on-list.
>
> +Jason
> +qemu-devel
>

Yes, you need to at least create VFS and test some throughput on it
(probably need a vIOMMU).

Thanks


