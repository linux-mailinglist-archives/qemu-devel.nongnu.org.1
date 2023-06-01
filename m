Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28324719F85
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:16:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4j5w-0000z3-Pd; Thu, 01 Jun 2023 10:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4j5r-0000u7-Kg
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4j5q-0005mZ-7n
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685628957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQQD92V21pZwkxSjlYI5nxuIXlm3f68Ca6uJ8aXyimw=;
 b=Ej7NwkOrTR/R54nMu3UdETEltoSnGboeINww+RqmjiIw5Zv0bw7bD6Q5NulkrjP7RqkeEV
 nBale/JpaGan/5CEsOjdAKzaaTsjl+4hw32Db2+RW3W4o8GCeGdwTvQnOiJ6E4CpFDT7Rj
 StkoLAIXQZizF6+2qdA/LSicXEWT4Xw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-5EWWZoE2OLOEQaeMOFgYvQ-1; Thu, 01 Jun 2023 10:15:54 -0400
X-MC-Unique: 5EWWZoE2OLOEQaeMOFgYvQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-568fd72993cso37325047b3.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685628954; x=1688220954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQQD92V21pZwkxSjlYI5nxuIXlm3f68Ca6uJ8aXyimw=;
 b=FokEonLIJd/xNovmHgdbgYou7qw/CtqxW260YAhDrGpZLI0iP69FkeLMmUzsXmPyW+
 Xsgj8f1xqyXJsnO/PEJZZwx17XYZlHR5n52UJWAfZeYKnksAIXo0haW/pnn/JmXGHrYl
 C++eGZqz7Eqnx6HOQqUsICG44/m7ILCWUuLeDImXXwBLn0Q4vBrwTyV2MKFy9GHmiEVg
 0YGDVMQlQ0+fMt4iZEaWEuPYNoUUdTHT0CqR0qrI7EtJFEQ8FoawdPUs1eKn52SLrNuU
 eUsNsJrK1NsvEis6RZDfj6m8/FYwJBPw+4W7MCoqS5+QIF6n28uJevYbF0P8CEb6oab1
 ybLQ==
X-Gm-Message-State: AC+VfDwrhS89C3F9QJP1AFQ/twdtmcXv3VvOToYdk/MvfUY9p98MEj2H
 SRR6JAwkS10N21bwtRBFawEct48j10jjgvnWCE1+d1ytYarE/sTSK35GEXOuOL3iGaRQv0m9J8u
 BGU1i1zp6rYjVX2lFZPpu9KvMfvSfpDo=
X-Received: by 2002:a0d:dfd5:0:b0:559:d78f:db64 with SMTP id
 i204-20020a0ddfd5000000b00559d78fdb64mr2259910ywe.3.1685628954276; 
 Thu, 01 Jun 2023 07:15:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4xhMBWquy55JxOfNu0K+n0sIOZGDB6455C9PXlupPWdlbx3N88H1BR24ZxGcxQcn7/86dFJsgoe0zUkMg2f9c=
X-Received: by 2002:a0d:dfd5:0:b0:559:d78f:db64 with SMTP id
 i204-20020a0ddfd5000000b00559d78fdb64mr2259887ywe.3.1685628954060; Thu, 01
 Jun 2023 07:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685623090.git.yin31149@gmail.com>
 <91f7437bab18dff4b1bb300c80f1367e492db7ca.1685623090.git.yin31149@gmail.com>
In-Reply-To: <91f7437bab18dff4b1bb300c80f1367e492db7ca.1685623090.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 1 Jun 2023 16:15:17 +0200
Message-ID: <CAJaqyWcqDfooTL9eDfUasW1zL+jPjuTfrsN3F_wo+c3UmznWgg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] hw/net/virtio-net: make some VirtIONet const
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Jun 1, 2023 at 3:49=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> The VirtIONet structure is not modified in
> virtio_net_supported_guest_offloads().
> Therefore, make it const to allow this function to
> accept const variables.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  hw/net/virtio-net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 6df6b7329d..7b27dad6c4 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_features=
(uint32_t features)
>      return guest_offloads_mask & features;
>  }
>
> -static inline uint64_t virtio_net_supported_guest_offloads(VirtIONet *n)
> +static inline uint64_t virtio_net_supported_guest_offloads(const VirtION=
et *n)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>      return virtio_net_guest_offloads_by_features(vdev->guest_features);
> --
> 2.25.1
>


