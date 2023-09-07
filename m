Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E279762A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:03:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHSp-0007Rq-SE; Thu, 07 Sep 2023 12:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qeHSn-0007L4-Jq
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qeHSk-0001nq-3p
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694102552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3YxNXmx73vMO/UEOiLu5VQTU0Rx861Tvbn/RUzDTlb0=;
 b=N/hESItYecxkyh48H7fXXYqHcT6eOnquMIOULqHzKiiZLuzK7O9dpNsCp7/HPFZFpp8i3o
 vSuMjEecbK7/v6Aia6Fcv0rOV5mr2ZuC01PNR1Qp9qh6ZiN2kSxPiMtLW2QSHt8MLMf7jm
 U3G3e08RFXKLgg+x6p3aE1RG6gwxlIk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-hu0z4kMpPYS0QyjDmJ7ldA-1; Thu, 07 Sep 2023 12:02:30 -0400
X-MC-Unique: hu0z4kMpPYS0QyjDmJ7ldA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-d7ba833ef2aso1156430276.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102550; x=1694707350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YxNXmx73vMO/UEOiLu5VQTU0Rx861Tvbn/RUzDTlb0=;
 b=Hg+iUNKuhb3Zp1iUWwT1WlHG9eY1sHIn43BexrEBz4OVJKd42u+dgSo/WiEC/EQVWi
 lXFYAVBowPIVgKez00qtJu4l32E7tOzppXSU8yz2zRYE5nha7JmEAn3ldxJIljfKcCxw
 Zt3aB8nwYvSdBzXyzDy31bEok+j3k8n9C6QbGkfdoSFpN4rXze0XUdtvgN8ybTmtD7g7
 qdbgm+5oFeAlrgmxZ66xWrgdv+IFtpzsbc6RewERQ2Yt11gl5PRncwxLBJgfLgBGWzcb
 jRMR1agoTGd15wWyHFGvfkN2DOnnNftojoPzRMuRhIQj6CO3dcasSpC4NRjGgqDJBuuN
 wkrQ==
X-Gm-Message-State: AOJu0Yw1/ICGq2NfxVF+BWjPQkw4rYBlrYrl4h95AnUx+bcVl68+KuUY
 M23soz42s+aZPj60i/WGtsRQ2XDz3947v0O//dEnROf8yBJv1wvXK5bjEFpQ51/93KGN4Ax3PDu
 ojdZdW/WnvCRLCwuTw/TsxVmevfNAzIg=
X-Received: by 2002:a25:3c7:0:b0:d7f:edb6:e0e8 with SMTP id
 190-20020a2503c7000000b00d7fedb6e0e8mr2143203ybd.26.1694102550404; 
 Thu, 07 Sep 2023 09:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq4MphF9O5beOU2nXsJtXQKTA4Uj9M2SuzXBhMt3w3huW+GqoFf9FTzwDfGAY9FYGoJcuKmXm++207kTirzY0=
X-Received: by 2002:a25:3c7:0:b0:d7f:edb6:e0e8 with SMTP id
 190-20020a2503c7000000b00d7fedb6e0e8mr2143171ybd.26.1694102550185; Thu, 07
 Sep 2023 09:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230830134055.106812-1-lersek@redhat.com>
In-Reply-To: <20230830134055.106812-1-lersek@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 7 Sep 2023 18:01:54 +0200
Message-ID: <CAJaqyWf6M2d67g8twnt2FjiMPkXKKF6P-RaYBE_k8QjOAaofTw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>, 
 Sergio Lopez Pascual <slp@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 30, 2023 at 3:41=E2=80=AFPM Laszlo Ersek <lersek@redhat.com> wr=
ote:
>
> v1:
>
> - http://mid.mail-archive.com/20230827182937.146450-1-lersek@redhat.com
> - https://patchwork.ozlabs.org/project/qemu-devel/cover/20230827182937.14=
6450-1-lersek@redhat.com/
>
> v2 picks up tags from Phil and Stefano, and addresses feedback from
> Stefano. Please see the Notes section on each patch, for the v2 changes.
>
> I've not CC'd the stable list, as we've not figured out what prior
> releases to target. Applying the series to 8.1 is easy; to 8.0 -- not so
> much.
>
> Retested.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> Cc: German Maglione <gmaglione@redhat.com>
> Cc: Liu Jiang <gerry@linux.alibaba.com>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Thanks,
> Laszlo
>
> Laszlo Ersek (7):
>   vhost-user: strip superfluous whitespace
>   vhost-user: tighten "reply_supported" scope in "set_vring_addr"
>   vhost-user: factor out "vhost_user_write_sync"
>   vhost-user: flatten "enforce_reply" into "vhost_user_write_sync"
>   vhost-user: hoist "write_sync", "get_features", "get_u64"
>   vhost-user: allow "vhost_set_vring" to wait for a reply
>   vhost-user: call VHOST_USER_SET_VRING_ENABLE synchronously
>
>  hw/virtio/vhost-user.c | 216 ++++++++++----------
>  1 file changed, 108 insertions(+), 108 deletions(-)
>
>
> base-commit: 813bac3d8d70d85cb7835f7945eb9eed84c2d8d0


