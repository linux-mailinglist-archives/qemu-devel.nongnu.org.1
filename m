Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C997454AC
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 06:53:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGBYB-0001aV-1a; Mon, 03 Jul 2023 00:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qGBY6-0001Xs-7L
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 00:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qGBY4-0002Fz-JI
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 00:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688359944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ckWEcNsLM/l/TF6jCrzg2aOhNVqzMlAU3u2qLUjzOD4=;
 b=XIqwDE1gCiuaDXa0sGnQv4FjkFFDguYu4SU41RSzWEtTH7BuYEp1B5xU6iIaRTacDyMf+r
 1VxSFiDKOUzQyxS1opb+dkWA4HqyQw9Tf15RiACDXQfuBwohNB7cbqNAaxspK/QWVZZoLW
 fi3vDgi1uw8o8xeUEpNmXYGdHp6fZzA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-qq3hXk83OkunoDMuxGmJaw-1; Mon, 03 Jul 2023 00:52:22 -0400
X-MC-Unique: qq3hXk83OkunoDMuxGmJaw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31114af5e45so2345206f8f.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 21:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688359941; x=1690951941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckWEcNsLM/l/TF6jCrzg2aOhNVqzMlAU3u2qLUjzOD4=;
 b=PGpRQouKhFvSLLny+Ss3rFxLIxFIkKFgsi641u/ey1qoDBfKDSNcdVZ266TQoAY7Nx
 gLjMOol7XUx0ujl4guH82HcfJ+flxCUio15S6KPeArS6BkkAJTuGQOf0J9YNlcgJRSva
 OFb0+8TkARA4Ix6oA0P/b6yMdO2piKhp0Lew4zuEzf4k7+v8htAfLhGThZQKIBOPFHB1
 hP0NR9IRromZLungSyCB/ldRTKUUMqNhCkQROzlN4lFv6LmxI4LK2S02TWQcQ5kfWVvr
 JOrt8QfV+lkkPWt8KcruiA+GmhvvEvvhS12gsG2iBywgvnJE00xd6BQcgfGB3TDFo1uo
 mtbw==
X-Gm-Message-State: ABy/qLaGNrvscBSwZcEMZcQ3xkhEXpWPWj8jgVc3OM/oFtZ6rvgV3o6O
 udxEg6ynkklhWoD9Jm+Mcbla31gz1DkiWRNR/Bgh5WV5KbUX+TpUVp2LgQyAj1KlRCHu2E9UlhI
 zvacLIOSEf6o0lD8=
X-Received: by 2002:a5d:4e46:0:b0:314:393a:17ca with SMTP id
 r6-20020a5d4e46000000b00314393a17camr660080wrt.59.1688359941431; 
 Sun, 02 Jul 2023 21:52:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFBcIAiDUumYtN5Dhc7qaXhykzKygJDPVcP0JnAiM4OFBvaqqC+ZG3MDeTSeAjtmlD5r7HzgA==
X-Received: by 2002:a5d:4e46:0:b0:314:393a:17ca with SMTP id
 r6-20020a5d4e46000000b00314393a17camr660064wrt.59.1688359941153; 
 Sun, 02 Jul 2023 21:52:21 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 w10-20020adfcd0a000000b003141f96ed36sm8275601wrm.0.2023.07.02.21.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 21:52:20 -0700 (PDT)
Date: Mon, 3 Jul 2023 00:52:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v3 0/2] pcie: Fix ARI next function numbers
Message-ID: <20230703005201-mutt-send-email-mst@kernel.org>
References: <20230702120229.66978-1-akihiko.odaki@daynix.com>
 <20230702084251-mutt-send-email-mst@kernel.org>
 <0a6bd04c-8364-2735-0ee6-060550bea77b@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a6bd04c-8364-2735-0ee6-060550bea77b@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 03, 2023 at 12:17:16PM +0900, Akihiko Odaki wrote:
> On 2023/07/02 21:43, Michael S. Tsirkin wrote:
> > On Sun, Jul 02, 2023 at 09:02:25PM +0900, Akihiko Odaki wrote:
> > > The ARI next function number field is undefined for VF. The PF should
> > > end the linked list formed with the field by specifying 0.
> > > 
> > > Supersedes: <20230701070133.24877-1-akihiko.odaki@daynix.com>
> > > ("[PATCH 0/4] pci: Compare function number and ARI next function number")
> > 
> > Thanks! How was this patch tested?
> 
> I brought VFs up with igb and performed link up for a fresh VM and a VM
> migrated from 8.0.2.

Which guest?

> > 
> > 
> > > V2 -> V3:
> > >    Moved the logic to PCI common infrastucture (Michael S. Tsirkin)
> > > 
> > > V1 -> V2:
> > >    Fixed migration. (Michael S. Tsirkin)
> > >    Added a caveat comment. (Michael S. Tsirkin)
> > > 
> > > Akihiko Odaki (2):
> > >    pcie: Use common ARI next function number
> > >    pcie: Specify 0 for ARI next function numbers
> > > 
> > >   docs/pcie_sriov.txt   | 4 ++--
> > >   include/hw/pci/pci.h  | 2 ++
> > >   include/hw/pci/pcie.h | 2 +-
> > >   hw/core/machine.c     | 1 +
> > >   hw/net/igb.c          | 2 +-
> > >   hw/net/igbvf.c        | 2 +-
> > >   hw/nvme/ctrl.c        | 2 +-
> > >   hw/pci/pci.c          | 2 ++
> > >   hw/pci/pcie.c         | 4 +++-
> > >   9 files changed, 14 insertions(+), 7 deletions(-)
> > > 
> > > -- 
> > > 2.41.0
> > 


