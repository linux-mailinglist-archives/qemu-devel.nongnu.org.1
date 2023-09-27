Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 463407B073F
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 16:46:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlVn4-00010N-8E; Wed, 27 Sep 2023 10:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qlVmx-0000yv-A4
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:45:19 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qlVmv-0003cn-Bs
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:45:19 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-57bab8676f9so3852591eaf.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695825915; x=1696430715; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KV48e9msA/uN1k4h+khIaUvN7lXA8JVc4QN5PFuXKoA=;
 b=eTxtid3qWtbetw+EcPoZPqewxKcVgg5IFjO+m7wiIpK95VAgR4BIvu0HFCMpW0W0Pr
 FENLZjFJyzhZt8hXyt7yJ/+4LsF7PZlXpk2Sv4sII+QjSf/QoGm6Vnu08jEBcfSOxJtp
 fysoVq11Bu1rj1dqLsDbClRzn97bvmzchq7LVOqlH3Y6a6/oE6dCHrGfrS60RfQhVyCD
 a1znCDTD0M62uRJkhsjjOn6LiKNEyftuMVnBWMqTCTVTVXhHKUcUOeE46QhMBPoIOxlU
 mImsGEgZyQJbZWInjeCLsE52NOCAcjV+DhDSDbprbN6mjf781KkWrQQcY7HlaOGH/+WK
 WyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695825915; x=1696430715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KV48e9msA/uN1k4h+khIaUvN7lXA8JVc4QN5PFuXKoA=;
 b=lR8CO8595QN4531MnXhFc93FR1nRZOp5hMVHTJHPLwDH9thTVZgWYGmvy4qNlmZ3wb
 1U3iWevns28n1v7lO/FAcfmF6W/1KL3LBfffOa5UbAiieM9ZzIDsStIDXwaS12sTeIAB
 Uj8LA1/WCd2JWuev9Ic+VzYDHZm7LQjjYYco2IjubFeFdOxMHjL6u/94nSOtyQPGeZpH
 bRBLPfn1qJVmX6nweSodNX8p3Z2vyRBrmGBOtioelr1h0Ug3yt8A97IAEWBrH3knKK3a
 xpMJn72lPHdVKbR3AuP4aIGfDW4h0N/s1JCzt3C960RwTvEjiep7OKJAEJHlVgnqZnIU
 69Yg==
X-Gm-Message-State: AOJu0YxRUKNaV1tkollZwwunnnSDROAvz2lGnKZLv3MWPGo33JrT5SLt
 mrJOXa4bZ4chj3HOgJVYNLmcXniLsDMCB1a8Hgm0t841
X-Google-Smtp-Source: AGHT+IHuG/X6lgfk/+aPMzi2zqX9nym/dYNK7xmybVbUGZ0WHwgWd6L7i9yupEByN5KNwFTuozpDB2zqJ0cmyppiq+I=
X-Received: by 2002:a4a:2759:0:b0:57b:6c85:96f with SMTP id
 w25-20020a4a2759000000b0057b6c85096fmr2151970oow.0.1695825915584; Wed, 27 Sep
 2023 07:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230927135157.2316982-1-i.maximets@ovn.org>
In-Reply-To: <20230927135157.2316982-1-i.maximets@ovn.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 27 Sep 2023 10:45:03 -0400
Message-ID: <CAJSP0QV9Uijfjmis9xOoYWJwWE-LMReSwHKUGyKTQOcQCfWUMg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: use shadow_avail_idx while checking number of
 heads
To: Ilya Maximets <i.maximets@ovn.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 27 Sept 2023 at 09:52, Ilya Maximets <i.maximets@ovn.org> wrote:
>
> We do not need the most up to date number of heads, we only want to
> know if there is at least one.
>
> Use shadow variable as long as it is not equal to the last available
> index checked.  This avoids expensive qatomic dereference of the
> RCU-protected memory region cache as well as the memory access itself.
>
> The change improves performance of the af-xdp network backend by 2-3%.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>
> Version 2:
>   - Changed to not skip error checks and a barrier.
>   - Added comments about the need for a barrier.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
>  hw/virtio/virtio.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 4577f3f5b3..8a4c3e95d2 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -999,7 +999,12 @@ void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>  /* Called within rcu_read_lock().  */
>  static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
>  {
> -    uint16_t num_heads = vring_avail_idx(vq) - idx;
> +    uint16_t avail_idx, num_heads;
> +
> +    /* Use shadow index whenever possible. */
> +    avail_idx = (vq->shadow_avail_idx != idx) ? vq->shadow_avail_idx
> +                                              : vring_avail_idx(vq);
> +    num_heads = avail_idx - idx;
>
>      /* Check it isn't doing very strange things with descriptor numbers. */
>      if (num_heads > vq->vring.num) {
> @@ -1007,8 +1012,15 @@ static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
>                       idx, vq->shadow_avail_idx);
>          return -EINVAL;
>      }
> -    /* On success, callers read a descriptor at vq->last_avail_idx.
> -     * Make sure descriptor read does not bypass avail index read. */
> +    /*
> +     * On success, callers read a descriptor at vq->last_avail_idx.
> +     * Make sure descriptor read does not bypass avail index read.
> +     *
> +     * This is necessary even if we are using a shadow index, since
> +     * the shadow index could have been initialized by calling
> +     * vring_avail_idx() outside of this function, i.e., by a guest
> +     * memory read not accompanied by a barrier.
> +     */
>      if (num_heads) {
>          smp_rmb();
>      }
> --
> 2.41.0
>
>

