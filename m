Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 179BB8935BE
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Mar 2024 22:22:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rr1fg-0001dM-Lv; Sun, 31 Mar 2024 16:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rr1fZ-0001d6-Gt
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 16:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rr1fX-00020J-SD
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 16:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711916441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FRRVj/JjKizxzXFDRSo3l/T54pHZqeXumE93BFWpnkg=;
 b=dwEQXYEGH0YB+fDeXVH7gGwKA45ulahfDCZOP+GVq4aXoIU5LRKQjIbpWK9hOlcuVe/7K6
 +Z37tFSU8ZviF/ivDUMyT7f8BkENemiKi6ER5lE2fIOWq+SrVBcFIE/7doOkAmZjVTvIMW
 AJ7uHenA7DeA/NRGcLTcCXQR20z5nVo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-qi3prPipOlyDhvlyOXFLWQ-1; Sun, 31 Mar 2024 16:20:39 -0400
X-MC-Unique: qi3prPipOlyDhvlyOXFLWQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a4df17773a5so276001566b.1
 for <qemu-devel@nongnu.org>; Sun, 31 Mar 2024 13:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711916438; x=1712521238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRRVj/JjKizxzXFDRSo3l/T54pHZqeXumE93BFWpnkg=;
 b=F1Mtd05T074+8fqnGDDEPu5imiZZm5NXMaHnb8UQUHy0xhbs9F6qsXW0XvRii6ynkK
 ez6WzZjsFZskUxzFyAw7/GTQ6K59oeU4YlXIC3AF7rsvKNzw7nNhVzm2hJCayrgx658f
 /F91Uyv+vOSY2lXi2kmxJcnOVfgZm4VsJHY9rWBsQ7jKlErVWXdKC0HDky7eYq+ezqUr
 /FLNHiH57xkwjQV11LvA9znN4HbK8ZS8QbisNcbpVO24X9jWXoackGt//pHPBATYBWNQ
 Y7XDrVA5nAJmyK9rdH/yw+uacMAs9vAYYLzArmbwo+sdC4MDFKBMxzAs3w47QTaBRzE2
 EGEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlNz+MJUj77YOZyNO+9qRMEiPEpRYIMeBncDui09+Iv7ZkYt7cvmMUFYjq9WxbS7svyRGJLIRG7G3i4C17egFXqv4i+Hg=
X-Gm-Message-State: AOJu0YxPj65cF7wi7DWjG1C846P6l05dp9eA6fzOv+HMyGQsrQ/j77b4
 iLDZeLhmE/8iQq2r0IKg5YWRInp8IhXRs3NSq1o8OVIDM0WrIdGQynmwRD8I76PneVJTsuNDLOb
 kZ9KV+aSuIirtN1BD9m0LFXQcxx9Pt1E++FAbJZkQM0qjNrWYgREJ
X-Received: by 2002:a17:907:3181:b0:a4e:663a:3cf4 with SMTP id
 xe1-20020a170907318100b00a4e663a3cf4mr1328720ejb.6.1711916438437; 
 Sun, 31 Mar 2024 13:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpknzv8VBlqoGJZhO+j/gEtYVNu8noUyOMoh3rGDewOFPJPPTVRdkL5QIIU1wPMo3a8degxA==
X-Received: by 2002:a17:907:3181:b0:a4e:663a:3cf4 with SMTP id
 xe1-20020a170907318100b00a4e663a3cf4mr1328694ejb.6.1711916437852; 
 Sun, 31 Mar 2024 13:20:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:9c27:9486:684f:de6:8ab8])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a170906b28200b00a4655976025sm4495364ejz.82.2024.03.31.13.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 13:20:37 -0700 (PDT)
Date: Sun, 31 Mar 2024 16:20:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: hengqi@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>, rbc@meta.com,
 riel@surriel.com, stable@vger.kernel.org, qemu-devel@nongnu.org,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <20240331160618-mutt-send-email-mst@kernel.org>
References: <20240329171641.366520-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329171641.366520-1-leitao@debian.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Mar 29, 2024 at 10:16:41AM -0700, Breno Leitao wrote:
> There is a bug when setting the RSS options in virtio_net that can break
> the whole machine, getting the kernel into an infinite loop.
> 
> Running the following command in any QEMU virtual machine with virtionet
> will reproduce this problem:
> 
>     # ethtool -X eth0  hfunc toeplitz
> 
> This is how the problem happens:
> 
> 1) ethtool_set_rxfh() calls virtnet_set_rxfh()
> 
> 2) virtnet_set_rxfh() calls virtnet_commit_rss_command()
> 
> 3) virtnet_commit_rss_command() populates 4 entries for the rss
> scatter-gather
> 
> 4) Since the command above does not have a key, then the last
> scatter-gatter entry will be zeroed, since rss_key_size == 0.
> sg_buf_size = vi->rss_key_size;
> 
> 5) This buffer is passed to qemu, but qemu is not happy with a buffer
> with zero length, and do the following in virtqueue_map_desc() (QEMU
> function):
> 
>   if (!sz) {
>       virtio_error(vdev, "virtio: zero sized buffers are not allowed");
> 
> 6) virtio_error() (also QEMU function) set the device as broken
> 
>     vdev->broken = true;
> 
> 7) Qemu bails out, and do not repond this crazy kernel.
> 
> 8) The kernel is waiting for the response to come back (function
> virtnet_send_command())
> 
> 9) The kernel is waiting doing the following :
> 
>       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> 	     !virtqueue_is_broken(vi->cvq))
> 	      cpu_relax();
> 
> 10) None of the following functions above is true, thus, the kernel
> loops here forever. Keeping in mind that virtqueue_is_broken() does
> not look at the qemu `vdev->broken`, so, it never realizes that the
> vitio is broken at QEMU side.
> 
> Fix it by not sending RSS commands if the feature is not available in
> the device.
> 
> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> Cc: stable@vger.kernel.org

net has its own stable process, don't CC stable on net patches.


> Cc: qemu-devel@nongnu.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changelog:
> 
> V2:
>   * Moved from creating a valid packet, by rejecting the request
>     completely
> V3:
>   * Got some good feedback from and Xuan Zhuo and Heng Qi, and reworked
>     the rejection path.
> 
> ---
>  drivers/net/virtio_net.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..c4a21ec51adf 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3807,6 +3807,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
>  			    struct netlink_ext_ack *extack)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> +	bool update = false;
>  	int i;
>  
>  	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
> @@ -3814,13 +3815,24 @@ static int virtnet_set_rxfh(struct net_device *dev,
>  		return -EOPNOTSUPP;
>  
>  	if (rxfh->indir) {
> +		if (!vi->has_rss)
> +			return -EOPNOTSUPP;
> +
>  		for (i = 0; i < vi->rss_indir_table_size; ++i)
>  			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
> +		update = true;
>  	}
> -	if (rxfh->key)
> +
> +	if (rxfh->key) {
> +		if (!vi->has_rss && !vi->has_rss_hash_report)
> +			return -EOPNOTSUPP;


What's the logic here? Is it || or &&? A comment can't hurt.

> +
>  		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
> +		update = true;
> +	}
>  
> -	virtnet_commit_rss_command(vi);
> +	if (update)
> +		virtnet_commit_rss_command(vi);
>  
>  	return 0;
>  }
> @@ -4729,13 +4741,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
>  		vi->has_rss_hash_report = true;
>  
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
>  		vi->has_rss = true;
>  
> -	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_indir_table_size =
>  			virtio_cread16(vdev, offsetof(struct virtio_net_config,
>  				rss_max_indirection_table_length));
> +	}
> +
> +	if (vi->has_rss || vi->has_rss_hash_report) {
>  		vi->rss_key_size =
>  			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
>  
> -- 
> 2.43.0


