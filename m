Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10136750AB7
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 16:22:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJaiW-00047B-VW; Wed, 12 Jul 2023 10:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJaiU-00046c-6x
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 10:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJaiS-0004bs-It
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 10:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689171674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EczEn/QZT0UNDQndUq23zxvPioEXkz8LDWAC9w3gIag=;
 b=LU0x4W+SkkZma6qjqCRZtZH8u88XD8I1uqhhh+7QXHnQF9fj2+s7p9/lUMD+pBRW7/B6zo
 J1EGJmUDKJG1Htd5BlisWrZDsBYdr/NbJHBOpiENnIKzy9LzTB6X6lZe9q+xf2i87ZgTwB
 aNvYaebXz+fX3xE9c6UnpGEoRyOUEkc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-2Sbyg315OWaxpXsDwd4pNw-1; Wed, 12 Jul 2023 10:21:13 -0400
X-MC-Unique: 2Sbyg315OWaxpXsDwd4pNw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5766e49b802so68744267b3.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 07:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689171670; x=1691763670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EczEn/QZT0UNDQndUq23zxvPioEXkz8LDWAC9w3gIag=;
 b=k/XZiU/IFZi/j1F8ephlNQKfdlgyxvH9+uMJa8v5y8XqISvDSOEGC0nGVXR/KR4FTl
 JhjV4UJh+91sKm0usoCuIYMXrT0sT+5mtB7c7Yk/hD28f+up5AUl9yjY56oJDmo8QKlo
 Ogp0JwbZ6HiAXm3OJYxS4H1CDSIH5rtLaNPszlnLzXk1qbyvSW90Pu1H1FqgGGTWi9m2
 U0uzxQFh+atPVOKjA0JGFQUoXQoYIZ2Pf0bh+4YwLWNDTtCUMyL4+MCWiNoCTH2pY/qU
 tDSKn/EYaqFs1oYzPtzmKurjlKCSetH+v4GQSl14UnzPPNgSMsMPDRcwxwLbNARg7RJ5
 ftgg==
X-Gm-Message-State: ABy/qLZaVq0ArbMoHB3GIWrKviuSOOhdXHTdkRpyehuKQ8N24Fwng6y6
 tblu9UGc2fDmqeSci2RwHIeot8heIUPk/fFZ4j7a+XHGzzObxOISuiNgD1VI1Dy4Gk/ncUe5dCY
 4j+CTf/5K8heqKxM/sSZ/QvHDkMlVbwI=
X-Received: by 2002:a81:688a:0:b0:576:8a5a:87e5 with SMTP id
 d132-20020a81688a000000b005768a5a87e5mr18516331ywc.26.1689171669953; 
 Wed, 12 Jul 2023 07:21:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG/D8pzREiR+H7EZ6lhBKgSiC/r5Yy94lIHpQ+bs5TgxVtyzTF/cpY5WTpaJXgp4dTzmrgLF7qtCXzz23NYTk8=
X-Received: by 2002:a81:688a:0:b0:576:8a5a:87e5 with SMTP id
 d132-20020a81688a000000b005768a5a87e5mr18516308ywc.26.1689171669712; Wed, 12
 Jul 2023 07:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <765f14c5-a938-ebd9-6383-4fe3d5c812ca@oracle.com>
 <10a3d00f-a3a2-91d1-0f94-9758cdc4b969@redhat.com>
 <bnitgwesvbjdkbrvnykltherzddi3zvms3ckd5yk3w4whdplu3@tv43e42wjl55>
In-Reply-To: <bnitgwesvbjdkbrvnykltherzddi3zvms3ckd5yk3w4whdplu3@tv43e42wjl55>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 12 Jul 2023 16:20:56 +0200
Message-ID: <CAGxU2F4o4cr6jaHypLs_5ma8ZuNQmx4KQVMjs4GrSYd-nnLcUw@mail.gmail.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
To: Paolo Bonzini <pbonzini@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, 
 Mark Kanda <mark.kanda@oracle.com>, linux-scsi@vger.kernel.org, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, 
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 12, 2023 at 12:14=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Wed, Jul 12, 2023 at 10:06:56AM +0200, Paolo Bonzini wrote:
> >On 7/11/23 22:21, Mike Christie wrote:
> >>What was the issue you are seeing?
> >>
> >>Was it something like you get the UA. We retry then on one of the
> >>retries the sense is not setup correctly, so the scsi error handler
> >>runs? That fails and the device goes offline?
> >>
> >>If you turn on scsi debugging you would see:
> >>
> >>
> >>[  335.445922] sd 0:0:0:0: [sda] tag#15 Add. Sense: Reported luns data =
has changed
> >>[  335.445922] sd 0:0:0:0: [sda] tag#16 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00
> >>[  335.445925] sd 0:0:0:0: [sda] tag#16 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00
> >>[  335.445929] sd 0:0:0:0: [sda] tag#17 Done: FAILED Result: hostbyte=
=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D0s
> >>[  335.445932] sd 0:0:0:0: [sda] tag#17 CDB: Write(10) 2a 00 00 db 4f c=
0 00 00 20 00
> >>[  335.445934] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00
> >>[  335.445936] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00
> >>[  335.445938] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00
> >>[  335.445940] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00
> >>[  335.445942] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00
> >>[  335.445945] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00
> >>[  335.451447] scsi host0: scsi_eh_0: waking up 0/2/2
> >>[  335.451453] scsi host0: Total of 2 commands on 1 devices require eh =
work
> >>[  335.451457] sd 0:0:0:0: [sda] tag#16 scsi_eh_0: requesting sense
> >
> >Does this log come from internal discussions within Oracle?
> >
> >>I don't know the qemu scsi code well, but I scanned the code for my co-=
worker
> >>and my guess was commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2 had a =
race in it.
> >>
> >>How is locking done? when it is a bus level UA but there are multiple d=
evices
> >>on the bus?
> >
> >No locking should be necessary, the code is single threaded.  However,
> >what can happen is that two consecutive calls to
> >virtio_scsi_handle_cmd_req_prepare use the unit attention ReqOps, and
> >then the second virtio_scsi_handle_cmd_req_submit finds no unit
> >attention (see the loop in virtio_scsi_handle_cmd_vq).  That can
> >definitely explain the log above.
>
> Yes, this seems to be the case!
> Thank you both for the help!
>
> Following Paolo's advice, I'm preparing a series for QEMU to solve the
> problem!

Series posted here:
https://lore.kernel.org/qemu-devel/20230712134352.118655-1-sgarzare@redhat.=
com/

Stefano


