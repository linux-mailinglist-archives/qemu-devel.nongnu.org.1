Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EE575A8F9
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 10:19:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMOrT-0008EA-HY; Thu, 20 Jul 2023 04:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMOrQ-0008E2-Q7
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 04:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMOrO-0000jl-Pg
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 04:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689841085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BkJcBhterqJQe2+3qrAMP0UTjGeXsBDDHpT1PCLLapY=;
 b=grmN8A3xApwtf40COxX2deTmM7W/jtuOdDsRnYN0IsrurG9dZn0/B9SFSZnERnBsAyX9Z5
 5Ycy8Mo/kduG5753uBJjvb77OZtbDC7AG1wAP1YW171FwI9FvRuUYuFw3BXeCMaqeJtnR2
 CHJl1HIMaPLRkhglR1+WPb+rwLMuvxw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-XW3lmaKLPE-uo_iPkp_Wpw-1; Thu, 20 Jul 2023 04:18:04 -0400
X-MC-Unique: XW3lmaKLPE-uo_iPkp_Wpw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-765ab532883so86485185a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 01:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689841084; x=1690445884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BkJcBhterqJQe2+3qrAMP0UTjGeXsBDDHpT1PCLLapY=;
 b=bG4J2Km9mRRWPxi9ywTx13jP4JKqX1PH7Li83tsZCsSnMx5+lJw7Mb452olCbNnJ1B
 3dFVSSq8S5WFw/1ZeptnOxYeFXJtBhcamRfzdcLkzrfL7CA+lzD/cfEteoDASzhCccEJ
 LLGWCvrjUcQSY/t6iiAn1F3ZTcnipI2AX8cMkiSwOafhvFZtMDxbgwuREoqaeVleTIB8
 yRUweKkXXpi9CSIZu0Yt7/vb/G/BCBD4mW2Cn58aL3iYMri94UzECu2xtNqZyoHtmgi0
 g8lpfRQ0npJFhMLSMexMs9mCl9MWo9Yix2SR6BTK62Z67ARF1urp1N5kPSn8L/ZfFGfs
 WNXg==
X-Gm-Message-State: ABy/qLaqFXiG2IxXOsJA+M7IwFUQpC1yRVVTfE+UFzqjgtUnDcAI2IEc
 HJHChss63I8wk7jUhK949cAD++o1N1J5aeWVq7qcajcSh7X17eB7fndrpovHyU4oDygSA0wretk
 qkpnD9SoOo3VaW58X9J5VkpNVdIbjdiE=
X-Received: by 2002:a05:620a:91a:b0:765:8642:a223 with SMTP id
 v26-20020a05620a091a00b007658642a223mr1985094qkv.23.1689841083763; 
 Thu, 20 Jul 2023 01:18:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEFXL1dOq91WnqIxusViDt4y4LkBaDOvVdoLokB3QTyF6uP2vrAlXeqXIUzIHZScC9hxpue0RPtil/daaPFi1U=
X-Received: by 2002:a05:620a:91a:b0:765:8642:a223 with SMTP id
 v26-20020a05620a091a00b007658642a223mr1985083qkv.23.1689841083553; Thu, 20
 Jul 2023 01:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230706191227.835526-1-eperezma@redhat.com>
 <20230706191227.835526-7-eperezma@redhat.com>
 <CACGkMEtjbYCGNLLO+HDhtbA7QqZALr-cEpkjX=ETy=j3eCkTVA@mail.gmail.com>
 <CAJaqyWcS6O+GNYsjuWo7Z85pq5Ls7_WWjLdM4z8eYGSSUMVc9Q@mail.gmail.com>
In-Reply-To: <CAJaqyWcS6O+GNYsjuWo7Z85pq5Ls7_WWjLdM4z8eYGSSUMVc9Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 20 Jul 2023 10:17:27 +0200
Message-ID: <CAJaqyWchexS5Gq9Ot88mBPp1nPnZYS3=q+GaE+DNBfeP1a+Rug@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] vdpa: remove net cvq migration blocker
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>,
 si-wei.liu@oracle.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Shannon Nelson <snelson@pensando.io>,
 Gautam Dawar <gdawar@xilinx.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Parav Pandit <parav@mellanox.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
 Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Mon, Jul 10, 2023 at 9:37=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Jul 10, 2023 at 5:54=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, Jul 7, 2023 at 3:12=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > Now that we have add migration blockers if the device does not suppor=
t
> > > all the needed features, remove the general blocker applied to all ne=
t
> > > devices with CVQ.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > I wonder what's the difference compared if we just start cvq first in
> > vhost_net_start()?
> >
>
> That's interesting. It would complicate the for loop in
> vhost_net_start, but I think it's less complicated than
> should_start_op.
>
> It would be something like moving from:
>
> for (i =3D 0; i < nvhosts; i++) {
>     if (i < data_queue_pairs) {
>         peer =3D qemu_get_peer(ncs, i);
>     } else {
>         peer =3D qemu_get_peer(ncs, n->max_queue_pairs);
>     }
>
>     ...
>
>     r =3D vhost_net_start_one(get_vhost_net(peer), dev);
>     if (r < 0) {
>         goto err_start;
>     }
> }
>
> To:
>
> for (i =3D 0; i < nvhosts; i++) {
>     if (i =3D=3D 0 && cvq) {
>         peer =3D qemu_get_peer(ncs, n->max_queue_pairs);
>     } else {
>         peer =3D qemu_get_peer(ncs, i - cvq);
>     }
>
>     ...
>
>     r =3D vhost_net_start_one(get_vhost_net(peer), dev);
>     if (r < 0) {
>         goto err_start;
>     }
> }
>
> Is this what you have in mind?
>

Friendly ping.

Thanks!


