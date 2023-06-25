Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9949173D02F
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 12:52:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDNLZ-0007b4-UV; Sun, 25 Jun 2023 06:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDNLP-0007am-No
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:51:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDNLO-0005Nv-Cm
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687690305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17nHElCbVB4azE8ZcbPwr9+owOBVkpOd37EnWMWFo0U=;
 b=WGmzK8yez8bkU9ccZgqcwFr6HcldWGZJxLsZR+6eqmamFyC6E8DCNIdsW6vNc+1TWiGPs1
 5TnA8SScAohLP8dkFp5c0W6X6/AKaB2dp7ZtmtFtTD+oGRJ6hP3aTKye6HblR4+TIrC0dp
 Ur1qpJAMA5u4ovYgX/605klpuoQc1vk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-gY1PxeZiNwiRD2iSfWxKyg-1; Sun, 25 Jun 2023 06:51:43 -0400
X-MC-Unique: gY1PxeZiNwiRD2iSfWxKyg-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-bd69bb4507eso3284498276.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 03:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687690303; x=1690282303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17nHElCbVB4azE8ZcbPwr9+owOBVkpOd37EnWMWFo0U=;
 b=JsvICrokkwX1fmkvQgynTOc1HDCzX+/eVCM22F1vXcLyvwi+LTn/1iLTlyHJUIcY1J
 gSpw8liCH2RR1FkURmgzBhqIhsRyQqdHloPMcJZBT+VDX6fzB/UyefMBVwANSe7QnHzq
 mNQ4f8VKDLJYTGUElzsUOOShItE+gJKCQBHLR2UCFF2wXE3NkClKQmjg8hzvc9IA63M+
 Hh2zBHxw13N6//fWfV8feSUqwlcS7ZDMx7275N6Bc24pANiwSbkMnrEj89pSds91drw3
 jy+ZKkbupsI0SIOQ0VcFL8TkK4zELIPSoVpmulowIudhJOPA9mwghSAyNLECtx5zdbDu
 VdQw==
X-Gm-Message-State: AC+VfDzb5rzjMRZWFvB211MYCfW47tl1qVaD/S6wBuAwQrNC9WFowER3
 w/XDWSmJHtTqUJf3ke5oNL8+QfGe4seAlUJ1Fo7x8wmL5FpmbdfHiSX5Qr1wreZ0jbyzWAuMXe4
 ojqsDy7fU/NlJn0Md8ET9ysS0aj411rI=
X-Received: by 2002:a25:c746:0:b0:b9e:889:420f with SMTP id
 w67-20020a25c746000000b00b9e0889420fmr26571821ybe.12.1687690303238; 
 Sun, 25 Jun 2023 03:51:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ys6JFdRTkzVEpR4jHGnUrDOT/z3XTW1tbtYvC7M/LvSe0NHQcA57ApUks5THi+fDpfuaXYxAwQHhMqju+PcA=
X-Received: by 2002:a25:c746:0:b0:b9e:889:420f with SMTP id
 w67-20020a25c746000000b00b9e0889420fmr26571814ybe.12.1687690303000; Sun, 25
 Jun 2023 03:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687402580.git.yin31149@gmail.com>
 <32ae7e729449bde7a4252dd354e27d41f7ad1dac.1687402580.git.yin31149@gmail.com>
In-Reply-To: <32ae7e729449bde7a4252dd354e27d41f7ad1dac.1687402580.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Sun, 25 Jun 2023 12:51:07 +0200
Message-ID: <CAJaqyWeC69wmphBD5+Z_7G2e3ZeM6_=zHiw8wjf5ba3k9XMmeA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] vdpa: Allow VIRTIO_NET_F_CTRL_RX in SVQ
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Jun 22, 2023 at 5:02=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> Enable SVQ with VIRTIO_NET_F_CTRL_RX feature.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  net/vhost-vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 355a6aef15..ca800f97e2 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -99,6 +99,7 @@ static const uint64_t vdpa_svq_device_features =3D
>      BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
>      BIT_ULL(VIRTIO_NET_F_STATUS) |
>      BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
> +    BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
>      BIT_ULL(VIRTIO_NET_F_MQ) |
>      BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
>      BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
> --
> 2.25.1
>


