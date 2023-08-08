Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1E0773670
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 04:20:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCJf-0004ov-5o; Mon, 07 Aug 2023 22:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qTCJd-0004oh-7k
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qTCJb-0000zM-Ge
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691461157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+UB1m08yxPkEskaYBItwwq2cjhRHewYpkdRS/RlsIo=;
 b=faAQ87zmqOiMnrpJ/XuM4fJm44NXjiSeh3PJ0yXnnX8z0/YOhw75pu8jZcPZYFhf6opNHn
 XugRp5ZVPDMKb9G/urjBblV/IvLxutCgDSf0AAeJIQMRsIu/i+VFmPXkA8EhAr90YNnn91
 +20/PYlrUm1Y29cpFuoRuILH7Ox0CR0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-i1UK3Lb9MzapJf-j0GaaQg-1; Mon, 07 Aug 2023 22:19:16 -0400
X-MC-Unique: i1UK3Lb9MzapJf-j0GaaQg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b980182002so35138711fa.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 19:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691461154; x=1692065954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U+UB1m08yxPkEskaYBItwwq2cjhRHewYpkdRS/RlsIo=;
 b=HDd/9K2IVFOiglFNFPTfk9LsCgJa32cTQqw8bXjy+QC1EOj0Awj55Omim64lv628eU
 kt+2gw0r8u9zeLnMNXUVcg11p4TBivhXlMpgEO1ebTP9G52thWG2cz/xOigOyjTikv8+
 4l5h3sjiJxg8b7m7Yp3NTsUzQQg+YXRO4m5OvVcrm6ooMvogNEIrzmAknp6IMjMOhAwW
 u6/JYoK0QsfQicFeiQNqwGX6Kb4bK2nmwgkmoVM7QzCrl7WBhfjc3KmqU1Nb+R+Od4VO
 yDICX2KATz9JxI5EOX20+ALlX10DDEhAFIZ+sIWR8QIwbzkVV5YQL16rZUUHfU6B4ab/
 W1SQ==
X-Gm-Message-State: AOJu0YwXcxYQw3oT14UTBDfRVKrWZh5EIV0kpRWgCPTnbaLCCcG5urNv
 wvktq4qh26iVUBxjl+644xHYsxSvSgFZX7K6GoBzPPMJ1dc8Z/zQzHP+HhLsA04bPubENvglXHm
 asDnX7VyCDULjTQ2r41vtsqv0pKrpA/o=
X-Received: by 2002:a2e:b53b:0:b0:2b9:dd64:8415 with SMTP id
 z27-20020a2eb53b000000b002b9dd648415mr2888186ljm.24.1691461154813; 
 Mon, 07 Aug 2023 19:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5tT8TQxJOw7wMmcp6L3oSKJF8X6nZ3UcXxhzm14bHuBwSPHniRvVdSOYbO56qcp/txlO20sHG6h/gh47lKpg=
X-Received: by 2002:a2e:b53b:0:b0:2b9:dd64:8415 with SMTP id
 z27-20020a2eb53b000000b002b9dd648415mr2888175ljm.24.1691461154644; Mon, 07
 Aug 2023 19:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230529140202eucas1p1920add7c8fd0a0c4efdfac6e9bdf5a7f@eucas1p1.samsung.com>
 <20230529140153.4053-1-t.dzieciol@partner.samsung.com>
 <7f1ea2a7-aef1-f090-01ab-218747b167c6@daynix.com>
 <000201d9c93e$c36323f0$4a296bd0$@partner.samsung.com>
In-Reply-To: <000201d9c93e$c36323f0$4a296bd0$@partner.samsung.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 10:19:03 +0800
Message-ID: <CACGkMEvE5nBKqvwok5GBX2fda0b9F8hFow2sZqXJ5AvhFTWyMQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] igb: packet-split descriptors support
To: "Tomasz Dzieciol/VIM Integration (NC) /SRPOL/Engineer/Samsung Electronics"
 <t.dzieciol@partner.samsung.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org, 
 sriram.yagnaraman@est.tech, k.kwiecien@samsung.com, m.sochacki@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 7, 2023 at 10:52=E2=80=AFPM Tomasz Dzieciol/VIM Integration (NC=
)
/SRPOL/Engineer/Samsung Electronics <t.dzieciol@partner.samsung.com>
wrote:
>
> Hi,
>
> It's been a while since review was done and nothing happened with those p=
atches since then.
>
> As I understand from guide: https://www.qemu.org/docs/master/devel/submit=
ting-a-patch.html#is-my-patch-in I should wait. Is that correct?

I've queued this for 8.2.

Thanks

>
> -----Original Message-----
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> Sent: wtorek, 30 maja 2023 04:49
> To: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>; qemu-devel@nongnu.o=
rg
> Cc: sriram.yagnaraman@est.tech; jasowang@redhat.com; k.kwiecien@samsung.c=
om; m.sochacki@samsung.com
> Subject: Re: [PATCH v10 0/7] igb: packet-split descriptors support
>
> On 2023/05/29 23:01, Tomasz Dzieciol wrote:
> > Purposes of this series of patches:
> > * introduce packet-split RX descriptors support. This feature is used b=
y Linux
> >    VF driver for MTU values from 2048.
> > * refactor RX descriptor handling for introduction of packet-split RX
> >    descriptors support
> > * fix descriptors flags handling
> >
> > Tomasz Dzieciol (7):
> >    igb: remove TCP ACK detection
> >    igb: rename E1000E_RingInfo_st
> >    igb: RX descriptors guest writting refactoring
> >    igb: RX payload guest writting refactoring
> >    igb: add IPv6 extended headers traffic detection
> >    igb: packet-split descriptors support
> >    e1000e: rename e1000e_ba_state and e1000e_write_hdr_to_rx_buffers
> >
> >   hw/net/e1000e_core.c     |  78 +++--
> >   hw/net/igb_core.c        | 730 ++++++++++++++++++++++++++++----------=
-
> >   hw/net/igb_regs.h        |  20 +-
> >   hw/net/trace-events      |   6 +-
> >   tests/qtest/libqos/igb.c |   5 +
> >   5 files changed, 592 insertions(+), 247 deletions(-)
> >
>
> Thanks for keeping working on this. For the entire series:
>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>


