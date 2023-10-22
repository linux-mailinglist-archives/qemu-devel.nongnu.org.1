Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E737D2274
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 12:03:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quVGb-0006OV-CO; Sun, 22 Oct 2023 06:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quVGN-0006O0-V7
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 06:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quVGI-0006Mz-Ih
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 06:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697968845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bFwt9iJl7rs8NZzpZFEfHgPhHEz0RSsvTneYPgS8AcI=;
 b=Ug715eXDW4/7DOYgShJA1ThlmO2F3HDuQRaTVRvwJnbah+wDPSIZPvaafns0PrQoqfcgQ+
 9VNl96jSaGOT2Q5Rbv7aOr3v9KtFYLM8lybUT1QA1xgfkS/oTeKLuXXXjTxUWqtQACWk/H
 l+PRX8mGJnKSKyczNIB9sPE5ifYNMBk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-CKmkisZFNDuXO7cjvKRKVg-1; Sun, 22 Oct 2023 06:00:40 -0400
X-MC-Unique: CKmkisZFNDuXO7cjvKRKVg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso14411065e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 03:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697968839; x=1698573639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFwt9iJl7rs8NZzpZFEfHgPhHEz0RSsvTneYPgS8AcI=;
 b=u1GLJ7V+J6OTcH/r3/vKNzhrJfnrQWJCvFD4T7cV0YLWjcsxcMVELNPzGNBvn9gl+6
 GzrCXU1WpRJewlHJWQAkGm+eapTW89SCCvXosS52LIZj8xSte8IQrkxID/TyTqF5LGhe
 ZDwc2fysPIS5a0kTWYRQ/+qlJImLBNDVTnyKEvBvWFNDJTvtTFQBL6Mk8NsQOG3ekRz3
 25CvXtCVy8VEryky7TJuLoDV2+neS1vGUOPCmISknVGZX94ctszfsrRaVhI+JbEMhj64
 3N/Ws8gek0jlbT+RJfdkfj0d6jFufc9SdtXWhdKd3ASROHZ013V6B8vV3O667rboSSvH
 Bnog==
X-Gm-Message-State: AOJu0YwoMkrbBqe/N9qRF4Wn8J+LXJnx7B/vgemFJo6l0julxbVQCBCx
 oNwUrkcpE0hf/3dqKNf2fZWf+9BUwZ3ncEtOERndG2m5AMQHoXtrEPVkkv1+8a0zlRj6rJNuLEW
 YvmMOKyiHtxnzS14=
X-Received: by 2002:adf:ee46:0:b0:317:70da:abdd with SMTP id
 w6-20020adfee46000000b0031770daabddmr4250575wro.59.1697968838866; 
 Sun, 22 Oct 2023 03:00:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXIuXeXJ8GE4CjsiToHHmqmENNNZbY5QGAeeCdvmLY0W3Q65+lSsGxwonB4ziBnKowGmPQKg==
X-Received: by 2002:adf:ee46:0:b0:317:70da:abdd with SMTP id
 w6-20020adfee46000000b0031770daabddmr4250559wro.59.1697968838417; 
 Sun, 22 Oct 2023 03:00:38 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:e88f:2c2c:db43:583d:d30e])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b00326dd5486dcsm5341987wrm.107.2023.10.22.03.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 03:00:37 -0700 (PDT)
Date: Sun, 22 Oct 2023 06:00:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org,
 18801353760@163.com
Subject: Re: [PATCH v3 1/2] vdpa: Restore hash calculation state
Message-ID: <20231022055541-mutt-send-email-mst@kernel.org>
References: <cover.1697902949.git.yin31149@gmail.com>
 <b7cd0c8d6a58b16b086f11714d2908ad35c67caa.1697902949.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7cd0c8d6a58b16b086f11714d2908ad35c67caa.1697902949.git.yin31149@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Oct 22, 2023 at 10:00:48AM +0800, Hawkins Jiawei wrote:
> This patch introduces vhost_vdpa_net_load_rss() to restore
> the hash calculation state at device's startup.
> 
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v3:
>   - remove the `do_rss` argument in vhost_vdpa_net_load_rss()
>   - zero reserved fields in "cfg" manually instead of using memset()
> to prevent compiler "array-bounds" warning
> 
> v2: https://lore.kernel.org/all/f5ffad10699001107022851e0560cb394039d6b0.1693297766.git.yin31149@gmail.com/
>   - resolve conflict with updated patch
> "vdpa: Send all CVQ state load commands in parallel"
>   - move the `table` declaration at the beginning of the
> vhost_vdpa_net_load_rss()
> 
> RFC: https://lore.kernel.org/all/a54ca70b12ebe2f3c391864e41241697ab1aba30.1691762906.git.yin31149@gmail.com/
> 
>  net/vhost-vdpa.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 4b7c3b81b8..2e4bad65b4 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -817,6 +817,86 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
>      return 0;
>  }
>  
> +static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
> +                                   struct iovec *out_cursor,
> +                                   struct iovec *in_cursor)
> +{
> +    struct virtio_net_rss_config cfg;
> +    ssize_t r;
> +    g_autofree uint16_t *table = NULL;
> +
> +    /*
> +     * According to VirtIO standard, "Initially the device has all hash
> +     * types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.".
> +     *
> +     * Therefore, there is no need to send this CVQ command if the
> +     * driver disable the all hash types, which aligns with

disables? or disabled

> +     * the device's defaults.
> +     *
> +     * Note that the device's defaults can mismatch the driver's
> +     * configuration only at live migration.
> +     */
> +    if (!n->rss_data.enabled ||
> +        n->rss_data.hash_types == VIRTIO_NET_HASH_REPORT_NONE) {
> +        return 0;
> +    }
> +
> +    table = g_malloc_n(n->rss_data.indirections_len,
> +                       sizeof(n->rss_data.indirections_table[0]));
> +    cfg.hash_types = cpu_to_le32(n->rss_data.hash_types);
> +
> +    /*
> +     * According to VirtIO standard, "Field reserved MUST contain zeroes.
> +     * It is defined to make the structure to match the layout of
> +     * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
> +     *
> +     * Therefore, we need to zero the fields in struct virtio_net_rss_config,
> +     * which corresponds the `reserved` field in

corresponds to

> +     * struct virtio_net_hash_config.
> +     */
> +    cfg.indirection_table_mask = 0;
> +    cfg.unclassified_queue = 0;
> +    table[0] = 0; /* the actual indirection table for cfg */
> +    cfg.max_tx_vq = 0;

Wouldn't it be easier to just do cfg = {} where it is defined?

> +
> +    /*
> +     * Consider that virtio_net_handle_rss() currently does not restore the
> +     * hash key length parsed from the CVQ command sent from the guest into
> +     * n->rss_data and uses the maximum key length in other code, so we also
> +     * employthe the maxium key length here.

two typos

> +     */
> +    cfg.hash_key_length = sizeof(n->rss_data.key);
> +
> +    const struct iovec data[] = {
> +        {
> +            .iov_base = &cfg,
> +            .iov_len = offsetof(struct virtio_net_rss_config,
> +                                indirection_table),
> +        }, {
> +            .iov_base = table,
> +            .iov_len = n->rss_data.indirections_len *
> +                       sizeof(n->rss_data.indirections_table[0]),
> +        }, {
> +            .iov_base = &cfg.max_tx_vq,
> +            .iov_len = offsetof(struct virtio_net_rss_config, hash_key_data) -
> +                       offsetof(struct virtio_net_rss_config, max_tx_vq),
> +        }, {
> +            .iov_base = (void *)n->rss_data.key,

cast to void * should not be needed here.

> +            .iov_len = sizeof(n->rss_data.key),
> +        }
> +    };
> +
> +    r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> +                                VIRTIO_NET_CTRL_MQ,
> +                                VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
> +                                data, ARRAY_SIZE(data));
> +    if (unlikely(r < 0)) {
> +        return r;
> +    }
> +
> +    return 0;
> +}
> +
>  static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>                                    const VirtIONet *n,
>                                    struct iovec *out_cursor,
> @@ -842,6 +922,15 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>          return r;
>      }
>  
> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_HASH_REPORT)) {
> +        return 0;
> +    }
> +
> +    r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor);
> +    if (unlikely(r < 0)) {
> +        return r;
> +    }
> +
>      return 0;
>  }
>  
> -- 
> 2.25.1


