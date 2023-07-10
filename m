Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C436874CF27
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:53:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlht-0006XI-8v; Mon, 10 Jul 2023 03:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qIlho-0006WV-Lq
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qIlhl-00081r-2t
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688975588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ppCDH5s9hgdvzofUxaKiE1IEcHOw2l2o05wgjuQMJOI=;
 b=iDZdef/g5w8BLwneivE7MulRWVf+1KQ6DFwWmi80vpZOahqh/yAA/q8b7k/7H6OcT/IfRb
 djk22PTxfVEoNnxohvasf5Bi4wRhEmbDs2ec2c7ajhrfunMmSDWquhDWTalLyzpz/DQY1u
 IkdrjxWVSV4l0Llkw/r0BYV5r52avCg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-xvk_J70CNn-4pCiygDrqUA-1; Mon, 10 Jul 2023 03:53:07 -0400
X-MC-Unique: xvk_J70CNn-4pCiygDrqUA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-765986c0521so368268185a.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 00:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688975586; x=1691567586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ppCDH5s9hgdvzofUxaKiE1IEcHOw2l2o05wgjuQMJOI=;
 b=WJExCe9wNc29QILguoFCsokPGi7vmUh85vq/hLAjZQBVuaqXbL38iMOrfjle6AcIGo
 TRy94tp0Zy0XeokGP1xGlVNWwcEP/3gad/Y9fWjt+ijU4tJsHUMpaIF0JOqp5QUpIz03
 qUqT5u+3YXYQG0xPvfEUxHjG3Ofs8jNfOWYRtftO1DUGlIoUTx+MGS9tE8gmkJ/kF2qv
 wW6f6l9Hfvg7ZM7T6AS4eadyP3GIR7z7PZq5lP26KoksG2SIJT82XGTPQWm/cpP21muH
 ASTsaa3+Czksni4djs6+i7Jm50w1GYSki8/NVkEe/H9964gpPQFnnlh/Sn203NsSekP8
 C90Q==
X-Gm-Message-State: ABy/qLaVK1PVEknj2tw4QZMf7DXQOuzJHREKnMyhkxbP6qy7Uc6Zt6U6
 /bUcZfj32r+NZrjXzdaaKAKUORkkZ8xWdp8vfAg5JEFKS7SEB9g4ZuUysjOZDfnw0zaIC7hFZVV
 HVJIfieoJnkn+gL+kac1D+ZcjB+voUDE=
X-Received: by 2002:a37:f613:0:b0:767:2b0d:49e6 with SMTP id
 y19-20020a37f613000000b007672b0d49e6mr9151592qkj.58.1688975586672; 
 Mon, 10 Jul 2023 00:53:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHDlZv21Gk/3tmG6H52CaUVDXPiZPMiiKXAmj1HHs+wlDtJHHcqiObIaOPv7qGBzw07hr8LI/+ehGSImBmU4lo=
X-Received: by 2002:a37:f613:0:b0:767:2b0d:49e6 with SMTP id
 y19-20020a37f613000000b007672b0d49e6mr9151586qkj.58.1688975586469; Mon, 10
 Jul 2023 00:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688746840.git.yin31149@gmail.com>
 <e3f2d7db477734afe5c6a5ab3fa8b8317514ea34.1688746840.git.yin31149@gmail.com>
In-Reply-To: <e3f2d7db477734afe5c6a5ab3fa8b8317514ea34.1688746840.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 10 Jul 2023 09:52:30 +0200
Message-ID: <CAJaqyWd2ExO3MByT-MYEowpBfw5_yGFr+QtxdmYyBduW-Pesmw@mail.gmail.com>
Subject: Re: [PATCH 1/1] vdpa: Fix possible use-after-free for VirtQueueElement
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-stable@nongnu.org, 
 qemu-devel@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 7, 2023 at 6:44=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> QEMU uses vhost_handle_guest_kick() to forward guest's available
> buffers to the vdpa device in SVQ avail ring.
>
> In vhost_handle_guest_kick(), a `g_autofree` `elem` is used to
> iterate through the available VirtQueueElements. This `elem` is
> then passed to `svq->ops->avail_handler`, specifically to the
> vhost_vdpa_net_handle_ctrl_avail(). If this handler fails to
> process the CVQ command, vhost_handle_guest_kick() regains
> ownership of the `elem`, and either frees it or requeues it.
>
> Yet the problem is that, vhost_vdpa_net_handle_ctrl_avail()
> mistakenly frees the `elem`, even if it fails to forward the
> CVQ command to vdpa device. This can result in a use-after-free
> for the `elem` in vhost_handle_guest_kick().
>
> This patch solves this problem by refactoring
> vhost_vdpa_net_handle_ctrl_avail() to only freeing the `elem` if
> it owns it.
>
> Fixes: bd907ae4b0 ("vdpa: manual forward CVQ buffers")
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Good catch!

> ---
>  net/vhost-vdpa.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 373609216f..d8f37694ac 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -825,7 +825,16 @@ out:
>          error_report("Bad device CVQ written length");
>      }
>      vhost_svq_push_elem(svq, elem, MIN(in_len, sizeof(status)));
> -    g_free(elem);
> +    /*
> +     * `elem` belongs to vhost_vdpa_net_handle_ctrl_avail() only when
> +     * the function successfully forwards the CVQ command, indicated
> +     * by a non-negative value of `dev_written`. Otherwise, it still
> +     * belongs to SVQ.
> +     * This function should only free the `elem` when it owns.
> +     */
> +    if (dev_written >=3D 0) {
> +        g_free(elem);
> +    }
>      return dev_written < 0 ? dev_written : 0;
>  }
>
> --
> 2.25.1
>


