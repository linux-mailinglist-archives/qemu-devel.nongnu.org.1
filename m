Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C87E77D0126
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:09:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXR3-0001wu-BK; Thu, 19 Oct 2023 14:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXR1-0001wF-8c
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXQz-00068f-3W
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697738867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZrF2Nj17aU0hVVuu4+CPkDQeS6IQVNcMZh4fTkpCac=;
 b=UV+XM9Bo/EgQhjSobsVrQpvXup5IIhtXdmsYtG38iHa20zQ/TxuXc8OzMMUuL1S7klbbut
 hZ6TkTVJGbtib3gzM3KFIInUHGEJNVllN+1BMxt17il3t7CDP28THV599prQ3RFVk0Rhqw
 +MraYCx84B5JWBS17yKHdwBpUlQHkJg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-sVDnav_XOG-AQSirTcfCCQ-1; Thu, 19 Oct 2023 14:07:40 -0400
X-MC-Unique: sVDnav_XOG-AQSirTcfCCQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c5032ab59eso68833861fa.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697738859; x=1698343659;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lZrF2Nj17aU0hVVuu4+CPkDQeS6IQVNcMZh4fTkpCac=;
 b=CdQQu9PoNBB0F5KA+y1rCpALreL2KSqnwzDNbbb10aBJOla5xQDWI2dJpjTiLt/4y1
 rMrjgWPaxL2WylArvitSenkvcV4IanKNsHNuylYP6Amulw+bBkLhRxkD92h8vM/dYPbM
 i+1KSKX9rVQhQmfYYH1TXUvac8a25X4rKBNw/WxfcE6Us1xbu7kh/BxygAnhZz6etvbX
 MU2yCY0wemBX/0TlvCExo/mQ8gV6Jy82uZmQb6BoGF5/btMPxfji3lPWABtnQCWAzpn/
 WNevomrB5Fq0vnP4BkQaLHCzPEDHyqtGcZEK8b5YyZTfTImCeJG8TIMl+75jI0KZFqCP
 6PTQ==
X-Gm-Message-State: AOJu0YzGsV5wfFCUTu3xI3YOhSBKb24NdL22pEJlsqiPRhz6RgfUg+0H
 YZVt9JGRCIEE2NyVfhvB84b1rC9kUDNUlcBf3f4VA5IsFOvsbCcj70XK0+KRi86uu2bre6k7Tg5
 kiE3DnH0xLrPYHQM=
X-Received: by 2002:a05:651c:b29:b0:2c5:1388:e369 with SMTP id
 b41-20020a05651c0b2900b002c51388e369mr2378443ljr.43.1697738858819; 
 Thu, 19 Oct 2023 11:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFltIQa0FvIy6Zfj6a/Bb+EuTKH/xla+XFPym08fY1RKyI3zjWlyl/BvNWRz/O28B8bJDZTaA==
X-Received: by 2002:a05:651c:b29:b0:2c5:1388:e369 with SMTP id
 b41-20020a05651c0b2900b002c51388e369mr2378428ljr.43.1697738858419; 
 Thu, 19 Oct 2023 11:07:38 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 e38-20020a05600c4ba600b004075d5664basm4918333wmp.8.2023.10.19.11.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:07:37 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:07:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PULL 08/83] vdpa: Restore hash calculation state
Message-ID: <20231019140406-mutt-send-email-mst@kernel.org>
References: <cover.1697644299.git.mst@redhat.com>
 <1908cfd6e1748d94680e468b9df6321087b8fcf2.1697644299.git.mst@redhat.com>
 <CAJSP0QVTi2QxMdzmPoPF2w5xm-r19W_0GtTaqJzGnoibT9iDNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QVTi2QxMdzmPoPF2w5xm-r19W_0GtTaqJzGnoibT9iDNg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Thu, Oct 19, 2023 at 09:32:28AM -0700, Stefan Hajnoczi wrote:
> On Wed, 18 Oct 2023 at 08:56, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Hawkins Jiawei <yin31149@gmail.com>
> >
> > This patch introduces vhost_vdpa_net_load_rss() to restore
> > the hash calculation state at device's startup.
> >
> > Note that vhost_vdpa_net_load_rss() has `do_rss` argument,
> > which allows future code to reuse this function to restore
> > the receive-side scaling state when the VIRTIO_NET_F_RSS
> > feature is enabled in SVQ. Currently, vhost_vdpa_net_load_rss()
> > could only be invoked when `do_rss` is set to false.
> >
> > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > Message-Id: <f5ffad10699001107022851e0560cb394039d6b0.1693297766.git.yin31149@gmail.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  net/vhost-vdpa.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 4b7c3b81b8..40d0bcbc0b 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -817,6 +817,88 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n,
> >      return 0;
> >  }
> >
> > +static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n,
> > +                                   struct iovec *out_cursor,
> > +                                   struct iovec *in_cursor, bool do_rss)
> > +{
> > +    struct virtio_net_rss_config cfg;
> > +    ssize_t r;
> > +    g_autofree uint16_t *table = NULL;
> > +
> > +    /*
> > +     * According to VirtIO standard, "Initially the device has all hash
> > +     * types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.".
> > +     *
> > +     * Therefore, there is no need to send this CVQ command if the
> > +     * driver disable the all hash types, which aligns with
> > +     * the device's defaults.
> > +     *
> > +     * Note that the device's defaults can mismatch the driver's
> > +     * configuration only at live migration.
> > +     */
> > +    if (!n->rss_data.enabled ||
> > +        n->rss_data.hash_types == VIRTIO_NET_HASH_REPORT_NONE) {
> > +        return 0;
> > +    }
> > +
> > +    cfg.hash_types = cpu_to_le32(n->rss_data.hash_types);
> > +
> > +    /*
> > +     * According to VirtIO standard, "Field reserved MUST contain zeroes.
> > +     * It is defined to make the structure to match the layout of
> > +     * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
> > +     *
> > +     * Therefore, we need to zero the fields in struct virtio_net_rss_config,
> > +     * which corresponds the `reserved` field in
> > +     * struct virtio_net_hash_config.
> > +     */
> > +    memset(&cfg.indirection_table_mask, 0,
> > +           sizeof_field(struct virtio_net_hash_config, reserved));
> 
> Please take a look at the following CI failure:
> 
> In file included from /usr/include/string.h:495,
> from /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/include/qemu/osdep.h:116,
> from ../net/vhost-vdpa.c:12:
> In function ‘memset’,
> inlined from ‘vhost_vdpa_net_load_rss’ at ../net/vhost-vdpa.c:874:9:
> /usr/include/s390x-linux-gnu/bits/string_fortified.h:71:10: error:
> ‘__builtin_memset’ offset [7, 12] from the object at ‘cfg’ is out of
> the bounds of referenced subobject ‘indirection_table_mask’ with type
> ‘short unsigned int’ at offset 4 [-Werror=array-bounds]
> 71 | return __builtin___memset_chk (__dest, __ch, __len, __bos0 (__dest));
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/5329820077

Hmm yes - the trick it's trying to implement is this:


struct virtio_net_rss_config {
        uint32_t hash_types;
        uint16_t indirection_table_mask;
        uint16_t unclassified_queue;
        uint16_t indirection_table[1/* + indirection_table_mask */];
        uint16_t max_tx_vq;
        uint8_t hash_key_length;
        uint8_t hash_key_data[/* hash_key_length */];
};


...

struct virtio_net_hash_config {
        uint32_t hash_types;
        /* for compatibility with virtio_net_rss_config */
        uint16_t reserved[4];
        uint8_t hash_key_length;
        uint8_t hash_key_data[/* hash_key_length */];
};


as you see layout matches.



Using a union is probably the right way to address this.


Dropped for now, thanks!



> > +
> > +    table = g_malloc_n(n->rss_data.indirections_len,
> > +                       sizeof(n->rss_data.indirections_table[0]));
> > +    for (int i = 0; i < n->rss_data.indirections_len; ++i) {
> > +        table[i] = cpu_to_le16(n->rss_data.indirections_table[i]);
> > +    }
> > +
> > +    /*
> > +     * Consider that virtio_net_handle_rss() currently does not restore the
> > +     * hash key length parsed from the CVQ command sent from the guest into
> > +     * n->rss_data and uses the maximum key length in other code, so we also
> > +     * employthe the maxium key length here.
> > +     */
> > +    cfg.hash_key_length = sizeof(n->rss_data.key);
> > +
> > +    const struct iovec data[] = {
> > +        {
> > +            .iov_base = &cfg,
> > +            .iov_len = offsetof(struct virtio_net_rss_config,
> > +                                indirection_table),
> > +        }, {
> > +            .iov_base = table,
> > +            .iov_len = n->rss_data.indirections_len *
> > +                       sizeof(n->rss_data.indirections_table[0]),
> > +        }, {
> > +            .iov_base = &cfg.max_tx_vq,
> > +            .iov_len = offsetof(struct virtio_net_rss_config, hash_key_data) -
> > +                       offsetof(struct virtio_net_rss_config, max_tx_vq),
> > +        }, {
> > +            .iov_base = (void *)n->rss_data.key,
> > +            .iov_len = sizeof(n->rss_data.key),
> > +        }
> > +    };
> > +
> > +    r = vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> > +                                VIRTIO_NET_CTRL_MQ,
> > +                                VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
> > +                                data, ARRAY_SIZE(data));
> > +    if (unlikely(r < 0)) {
> > +        return r;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
> >                                    const VirtIONet *n,
> >                                    struct iovec *out_cursor,
> > @@ -842,6 +924,15 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
> >          return r;
> >      }
> >
> > +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_HASH_REPORT)) {
> > +        return 0;
> > +    }
> > +
> > +    r = vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, false);
> > +    if (unlikely(r < 0)) {
> > +        return r;
> > +    }
> > +
> >      return 0;
> >  }
> >
> > --
> > MST
> >
> >


