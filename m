Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 759DD77A624
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 13:17:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qV94r-0004Tl-Ku; Sun, 13 Aug 2023 07:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qV94p-0004T5-0B
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 07:16:07 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qV94m-00088V-0h
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 07:16:06 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b9338e4695so52201041fa.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691925362; x=1692530162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wGARFZCaM/IrJ8hkRIL4fPLH3yjFiKC/1R3PVADx6+I=;
 b=aT7H7FjXGIgZcx0a3TXH4VE9hgBczRA1lU2Tr7Szk5ZUp2XxalegLMDpCZIgiMFnCJ
 7UMclTMQDr75hkOxHkq0BdA2QJWmJNgaZH3B7Psi7vwl7z6V+BqnNUz4P0WGTPa9VEkd
 IcE+0W0DPZjk/DyOyS5907mnZ9otrKH6F6qAWfTuoAV7Qd1P+hNmXU3tEyD5djkQUMLB
 ygRvmv1Q+YbcRS7m4sF5MO/KUsDEq+0ELtZRvozHzIWrHUpVGFNR2bWoe4cEr1uhdWk7
 gni057WsLmA1OAYRRyfEMcalTL5t49AXzJwuQ1VrlHwbMQHUhy5eSzGmrzQJxehQcGsu
 GrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691925362; x=1692530162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wGARFZCaM/IrJ8hkRIL4fPLH3yjFiKC/1R3PVADx6+I=;
 b=BIrPJ9TwXjcGM/aDcPl5RAYAMbb2JPEnX3uVD0CNLPFpmroynyQSg9efDgDVXpuoIP
 PoPIIpHj3Q+ZqdtGIicP5RYocR4v9UT4GCw8R9saUk6ERLJwLzutksiosKpYkhOBX7oF
 eLi3rOTUImdAXb19jwiAQCpNWcloyG1NT+aoxY33uKplEfwNpYTsRvojU6O4YFzXufR/
 MjRFCZ7K2/jkydzE0HJH+dL2xG1WMpG4LEx7VvxzuoFpjoUxYKC7SyQriMcVjXJ4wzHT
 X13AWzoWipQ85meOYw2CM28MSy7EDmFV3luuR691to1qBJSVk3Z7SAeOz8M3JRA17/IM
 eelQ==
X-Gm-Message-State: AOJu0YziSoYeVgJNGJDp5tBuDXCibS/Vm26K5XWwS7hKRX+HtZqnuFgZ
 6khFGoqMs1Ovm9LANBxbWSgpD8ePtaJspPLeiSw=
X-Google-Smtp-Source: AGHT+IFFQldmknNkN1FZtKx77+Ab3HGivkW1Fak3S3kENnFg9SiNo3PvZLH0QPFmMo2Q/yRUWVktD+2iz5bbPBNbSzU=
X-Received: by 2002:a2e:b0dc:0:b0:2b9:dfd1:3803 with SMTP id
 g28-20020a2eb0dc000000b002b9dfd13803mr5028859ljl.30.1691925361271; Sun, 13
 Aug 2023 04:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691766252.git.yin31149@gmail.com>
 <93d5d82f0a5df71df326830033e50358c8b6be7a.1691766252.git.yin31149@gmail.com>
In-Reply-To: <93d5d82f0a5df71df326830033e50358c8b6be7a.1691766252.git.yin31149@gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sun, 13 Aug 2023 19:15:49 +0800
Message-ID: <CAKrof1MvRBGTAc2ETModAtkRh6_Hn-v72+P2MvMbJ3EsVUX3Aw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] vdpa: Restore receive-side scaling state
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com
Cc: qemu-devel@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2023/8/11 23:28, Hawkins Jiawei wrote:
> This patch reuses vhost_vdpa_net_load_rss() with some
> refactorings to restore the receive-side scaling state
> at device's startup.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>   net/vhost-vdpa.c | 53 ++++++++++++++++++++++++++++++++----------------
>   1 file changed, 35 insertions(+), 18 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 4c8e4b19f6..7870cbe142 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -820,17 +820,28 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
>       }
>
>       cfg.hash_types = cpu_to_le32(n->rss_data.hash_types);
> -    /*
> -     * According to VirtIO standard, "Field reserved MUST contain zeroes.
> -     * It is defined to make the structure to match the layout of
> -     * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
> -     *
> -     * Therefore, we need to zero the fields in struct virtio_net_rss_config,
> -     * which corresponds the `reserved` field in
> -     * struct virtio_net_hash_config.
> -     */
> -    memset(&cfg.indirection_table_mask, 0,
> -           sizeof_field(struct virtio_net_hash_config, reserved));
> +    if (do_rss) {
> +        /*
> +         * According to VirtIO standard, "Number of entries in indirection_table
> +         * is (indirection_table_mask + 1)".
> +         */
> +        cfg.indirection_table_mask = cpu_to_le16(n->rss_data.indirections_len -
> +                                                 1);
> +        cfg.unclassified_queue = cpu_to_le16(n->rss_data.default_queue);
> +        cfg.max_tx_vq = cpu_to_le16(n->curr_queue_pairs);
> +    } else {
> +        /*
> +         * According to VirtIO standard, "Field reserved MUST contain zeroes.
> +         * It is defined to make the structure to match the layout of
> +         * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
> +         *
> +         * Therefore, we need to zero the fields in
> +         * struct virtio_net_rss_config, which corresponds the `reserved` field
> +         * in struct virtio_net_hash_config.
> +         */
> +        memset(&cfg.indirection_table_mask, 0,
> +               sizeof_field(struct virtio_net_hash_config, reserved));
> +    }
>       /*
>        * Consider that virtio_net_handle_rss() currently does not restore the
>        * hash key length parsed from the CVQ command sent from the guest into
> @@ -866,6 +877,7 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
>
>       r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>                                   VIRTIO_NET_CTRL_MQ,
> +                                do_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG :
>                                   VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
>                                   data, ARRAY_SIZE(data));
>       if (unlikely(r < 0)) {
> @@ -899,13 +911,18 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>           return r;
>       }
>
> -    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_HASH_REPORT)) {
> -        return 0;
> -    }
> -
> -    r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, false);
> -    if (unlikely(r < 0)) {
> -        return r;
> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_RSS)) {
> +        /* Load the receive-side scaling state */
> +        r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, true);
> +        if (unlikely(r < 0)) {
> +            return r;
> +        }
> +    } else if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_RSS)) {

The correct feature to be used here is VIRTIO_NET_F_HASH_REPORT, rather
than VIRTIO_NET_F_RSS. I will correct this in the v2 patch.

Thanks!


> +        /* Load the hash calculation state */
> +        r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, false);
> +        if (unlikely(r < 0)) {
> +            return r;
> +        }
>       }
>
>       return 0;

