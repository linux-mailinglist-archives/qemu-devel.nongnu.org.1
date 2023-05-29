Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B12A714EB4
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 18:57:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3g9x-0001JF-8t; Mon, 29 May 2023 12:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q3g9v-0001J2-8E
 for qemu-devel@nongnu.org; Mon, 29 May 2023 12:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q3g9t-0004v6-Ra
 for qemu-devel@nongnu.org; Mon, 29 May 2023 12:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685379349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tbxw8Gpuqh754XteIs7VpEYJfeND1fP0BS3N3tiiuGk=;
 b=N5zcnU2t7TyiTCkKbHoExZH/p/cyu48Hbc9NA6XFyRbD6gBOEjowZKKI4yGgJqMp95oQ3m
 HR9cqEedHr0Mz64WBEUIlE5ILn1QazrRTXPb40d0rJN50Wdob2RW9XhQsvnt6wt5YI30dT
 7SZ2N1wSBmYsIaSVVPS49OjlelpxGmM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-kk241FZ0O6m_iO1aruqlYA-1; Mon, 29 May 2023 12:55:47 -0400
X-MC-Unique: kk241FZ0O6m_iO1aruqlYA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-565c380565dso63142457b3.1
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 09:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685379347; x=1687971347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tbxw8Gpuqh754XteIs7VpEYJfeND1fP0BS3N3tiiuGk=;
 b=aH2fUEnC2HilNVHk2OqHRrDjACOi9q/qa6gBMJJUl0mYv3tcGCI4w6NO1PiH17AjCZ
 Ko1ckIpXwxu3zYrtmOQdirqcRxFD0AfDVZxb/wW7rW4WLv7VLpA4lO5zJPH7xkZjW0p5
 hYX1yYcOvHEAkb384hpWAd6EoBtzPLRrUgN7giR2GFYBYJDMIbKSN2iPhvd8QiydCht+
 WLVkeIRbadiHn8WyjrVpa8+EDMhR5rR0IdUODwWZ+j/tG2m3E7M+VHj7Oi+22peacV1F
 JNaZLvhZfrCo4xEaNduO2SLZvlf/d+s6P32kl+E3KT93Bp01L88Y69JZVMpFrD22tCts
 Qb0Q==
X-Gm-Message-State: AC+VfDyirTgTn0jQJPkooLCbdgx5gwlNVc1Sg88+BaeigNZPlif7++Ms
 kv8i3chkRzjqgUPGbGbinS6oM6Bbx4dTOWD8cQjARwfKrMQNFMa3DDN8YM200BhypkIxPmtcyAE
 +3LWdpJ6yHj5jt41gehs8XH+mVzzs8NY=
X-Received: by 2002:a81:fe15:0:b0:561:b5c7:d764 with SMTP id
 j21-20020a81fe15000000b00561b5c7d764mr8714224ywn.18.1685379347326; 
 Mon, 29 May 2023 09:55:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4L3hRpX6w2b6NwSTLTYCtHAb0QVvPlgCtthVlnq0MUSlElSkYaUA5cAKnkTtaUMvEsaQrIK1QNLPGhZQI/wYU=
X-Received: by 2002:a81:fe15:0:b0:561:b5c7:d764 with SMTP id
 j21-20020a81fe15000000b00561b5c7d764mr8714215ywn.18.1685379347120; Mon, 29
 May 2023 09:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685359572.git.yin31149@gmail.com>
In-Reply-To: <cover.1685359572.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 May 2023 18:55:11 +0200
Message-ID: <CAJaqyWdeV8WP+C9FYXtaAVfvm=rD4dxvUEdVD=XPrY8bChqYTw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Vhost-vdpa Shadow Virtqueue Offloads support
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: 18801353760@163.com, qemu-devel@nongnu.org, 
 Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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

On Mon, May 29, 2023 at 3:18=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This series enables shadowed CVQ to intercept Offloads commands
> through shadowed CVQ, update the virtio NIC device model so qemu
> send it in a migration, and the restore of that Offloads state
> in the destination.
>
> Hawkins Jiawei (2):
>   vdpa: Add vhost_vdpa_net_load_offloads
>   vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
>
>  net/vhost-vdpa.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>

CCing MST too.

Thanks!


