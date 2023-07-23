Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7175E102
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 11:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNVbq-000065-Rq; Sun, 23 Jul 2023 05:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNVbo-00005m-Pg
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:42:36 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNVbm-0005JN-GQ
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:42:36 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b703cbfaf5so47869801fa.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690105352; x=1690710152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhj8oRP2QB7u5U/3GexP3r2qjxrC6ACTyfhdXb5bHT8=;
 b=QaesnNNCqU0XfHZD7eQ1artBJp0CD96uan4Dle5zo3AEdEUMziAwCDjDcJWY4aSZtA
 x5hfUoEYxlodBwyktDO/lbqK23cUpAa6T3hIPu7vM1cPyMu1YzJ8s5cbus1e/VCPwcft
 gzRugjwp/PXLSbK3Fi+AMtX+rKOhGvI5kaRyB9yAchEFAr5ME7cuR4M4su4Ay75X4eia
 qJzTRs3n4pW4C39W8EvsN776niGqC5lx1nHL02N+wyxnuzv3epAs8JpusmLCZ9AomywZ
 VC/K3Zd2owjlyghGgL5veySgtygdQNcA4RWaXGgzE5HhyR+WWOBH4B7tkCm93qlD45yu
 51hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690105352; x=1690710152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhj8oRP2QB7u5U/3GexP3r2qjxrC6ACTyfhdXb5bHT8=;
 b=Hip1DfU1iD7xsApUGzUrXwR/ujbly4dt44kFFFiw0p69rnGlVkOi/X3gqYAN3DrLGQ
 41/5zR7sl0sewubdDUU1rfs0DULBZiib5W6Z9SPogpPWTcaqDWvpTkJQcKgxiW2AKX2V
 nlFMMVUp0cX3VkBR9Dpw7Zta8n3BNXtvt/goa1uDK4Y64BG8zsjl3FIxomE8534zS1X7
 1u0xfaZuf3kmNTCs9ckTehcwG3WnONBWaRP6cGYiZKEADXQfbJbNv3o46Psu9HuHzx7C
 OPlOOfqu4Abmw0YrR1on8WX/Ib5P0Vy0fFg9NTI+vCAE7QIgXrm6jNGL20ATGqhCNoV5
 uYJQ==
X-Gm-Message-State: ABy/qLZYRlpPDvBZOwMGsb+LoDoXZW+dXDPgZqTrczVmIPMnnXvwAd/Q
 6Uenj7DWJl6dC6vN7lIyu6f3vXBSulbuwREoctA=
X-Google-Smtp-Source: APBJJlG4l85NX7F9K4phB1zPO+98b+aCXk6BF7YHn8IGH5z+xmXsR40CEeKz192w5IYcGkqwel/GmUd7XVGfFLtk5eI=
X-Received: by 2002:a2e:b6cd:0:b0:2b6:e9e1:f62f with SMTP id
 m13-20020a2eb6cd000000b002b6e9e1f62fmr4034711ljo.5.1690105351182; Sun, 23 Jul
 2023 02:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690100802.git.yin31149@gmail.com>
 <95af0d013281282f48ad3f47f6ad1ac4ca9e52eb.1690100802.git.yin31149@gmail.com>
In-Reply-To: <95af0d013281282f48ad3f47f6ad1ac4ca9e52eb.1690100802.git.yin31149@gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sun, 23 Jul 2023 17:42:19 +0800
Message-ID: <CAKrof1P+eEAArdYT+Qb0xMozpG_uPbU6GoWvm-grYOhHAq689A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] virtio-net: do not reset vlan filtering at
 set_features
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com
Cc: qemu-devel@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22a.google.com
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

On 2023/7/23 17:26, Hawkins Jiawei wrote:
> From: Eugenio P=C3=A9rez <eperezma@redhat.com>

There was a wrong "From" line by mistake, I will send the v3 patch to
fix this.

Thanks!


>
> This function is called after virtio_load, so all vlan configuration is
> lost in migration case.
>
> Just allow all the vlan-tagged packets if vlan is not configured, and
> trust device reset to clear all filtered vlans.
>
> Fixes: 0b1eaa8803 ("virtio-net: Do not filter VLANs without F_CTRL_VLAN")
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Reviewed-by: Hawkins Jiawei <yin31149@gmail.com>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>   hw/net/virtio-net.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7102ec4817..d20d5a63cd 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1006,9 +1006,7 @@ static void virtio_net_set_features(VirtIODevice *v=
dev, uint64_t features)
>           vhost_net_save_acked_features(nc->peer);
>       }
>
> -    if (virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
> -        memset(n->vlans, 0, MAX_VLAN >> 3);
> -    } else {
> +    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
>           memset(n->vlans, 0xff, MAX_VLAN >> 3);
>       }
>

