Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C85E71568E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 09:21:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3tf6-0001VC-Cu; Tue, 30 May 2023 03:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q3tep-0001SS-1w
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:20:39 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q3tem-0005Oa-BX
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:20:38 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2af1822b710so42711391fa.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685431220; x=1688023220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+evcmuzGbeYpAPGOeOCaGXBD/2THRj0w9dX0C8REvmk=;
 b=c99qcRwtNGAjXke/Cdo8FRgPYLLAPxSeonjPkjuxU0xUOeq65dnirXLxA3aerq+GgQ
 NMlhS3jfbMwF1UmsPqNeCqANUIsPBhhfsEODbQif+Zo5SbuUWg/vz6WmN7+/O1XMljpL
 ekDhPJhGaT/0OwnjxAKdamXzK60VKKb7J4q8RRSNxt1tbY/B7knoagBhjSiCEC8w5YED
 T18VGNitUjhQMh4w6mJc0VGzYfsira2Ie7/JTpd/gHB9Fdd6BTrPyTKz4MYCkbewUyV1
 RB4TeqTstyRNTm4lqnNmSpb8pwyC13aCNCxvqqjpK1WLULU03TEGMfSBAMsatTnavAdJ
 rufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685431220; x=1688023220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+evcmuzGbeYpAPGOeOCaGXBD/2THRj0w9dX0C8REvmk=;
 b=F2lxWUuunOTRzw1RfotXG+7El5B7r/55P29AYs7qHS9pSIHs3qi9qf3ZR7V+Q/0Jhw
 z4sVMDs6krgqOzpwf4wa1J53K/11DDN9FoFObdAUkMEaRucQ1pddPzQdZSItoVGwgi6/
 c+sPrgTZ7h4lHnnmxZKgdGUdL3zbr57IVnpHU3VMce7BGhXPcyUEO11v1Lbws12DGQpi
 p6X5oi8qmwPi7YbHGDbOafNPUjucqs4wV6RYx+MmoyXe8GgCrVNdyg6pCYyViKDEyVTl
 jXBxy4wphTzWqAwfN6mEJCeOFGKqe3lQqC7QAJd/gjy4asIAy6HMNZ4H1+Efef5u7Kky
 L7rA==
X-Gm-Message-State: AC+VfDwN6pP0LiTZILibsujP41KBjhv6K41biU3+R+6MWX3NulMka0+U
 B14Af6+sEGvRlZpsNcXXRIocR/lLERxVT9bx6MM=
X-Google-Smtp-Source: ACHHUZ72CsXZ39hMNz1WuTO/VLUiDLY6fGrA+6k4sVFjV1SJWosnB6OOZBWpCMcrALkSfBpW58JxJKes20gJ5ZCsw9M=
X-Received: by 2002:a2e:a1d0:0:b0:2ad:94cd:3cb7 with SMTP id
 c16-20020a2ea1d0000000b002ad94cd3cb7mr379530ljm.51.1685431219718; Tue, 30 May
 2023 00:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685359572.git.yin31149@gmail.com>
 <CAJaqyWdeV8WP+C9FYXtaAVfvm=rD4dxvUEdVD=XPrY8bChqYTw@mail.gmail.com>
In-Reply-To: <CAJaqyWdeV8WP+C9FYXtaAVfvm=rD4dxvUEdVD=XPrY8bChqYTw@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Tue, 30 May 2023 15:20:07 +0800
Message-ID: <CAKrof1O7vfPcp=6+XLDkawx2sawhHvx6E56911pTx92Sf28qww@mail.gmail.com>
Subject: Re: [PATCH 0/2] Vhost-vdpa Shadow Virtqueue Offloads support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: 18801353760@163.com, qemu-devel@nongnu.org, 
 Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2023/5/30 0:55, Eugenio Perez Martin wrote:
> On Mon, May 29, 2023 at 3:18=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> This series enables shadowed CVQ to intercept Offloads commands
>> through shadowed CVQ, update the virtio NIC device model so qemu
>> send it in a migration, and the restore of that Offloads state
>> in the destination.
>>
>> Hawkins Jiawei (2):
>>    vdpa: Add vhost_vdpa_net_load_offloads
>>    vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
>>
>>   net/vhost-vdpa.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>
> CCing MST too.

OK, I will cc MST in the future patches for this part.

Thanks!

>
> Thanks!
>

