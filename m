Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDCD7C9866
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 10:44:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrwhv-0006nI-D7; Sun, 15 Oct 2023 04:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qrwhr-0006k1-UA
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 04:42:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qrwhq-0001Hk-1J
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 04:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697359356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hDzQTce44LDieCvwm72V4ZF+6bqSUwNujHwda0Mh2oY=;
 b=CiIU/RC5tmJU9dsd7s84cDFCS5U1Q/oo4zCaev2NEAWmLfcGdMbbFMlmA7wFlwyvF+nmoW
 VyLPUAmnWqNSn2Huh19emPbpsid+jUHR69w94WVeUKvIcGHqJQfbUOSsaEjViXhNBr5MgH
 5hhX3bH/w2yycsHtY+6+FRBiQbi2DBo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-asKTnkkJNfSq510MBkNJLg-1; Sun, 15 Oct 2023 04:42:24 -0400
X-MC-Unique: asKTnkkJNfSq510MBkNJLg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d9602824dso1715000f8f.2
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 01:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697359343; x=1697964143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDzQTce44LDieCvwm72V4ZF+6bqSUwNujHwda0Mh2oY=;
 b=Fr3dkedwyhJORRYs2kFAr/YKuANKRuIgAdUCSk9pJHkBMIh0Z9HYHxrGOWOuT7bqej
 z6BjAoDRhTBZ16eDbdFhM1Mca983xr2e0o4eCxwF0JZi8M1+DpIOE9OqFyYz18HxYfrZ
 s25qviZgETg2wfFUPyc3fgZ2IuT3eP38cz+MlzMYG+uO8OVyy3KwqvZvCITiI/eqGmjM
 +Tg4PTScKIHzFzO0izqFZbkqxf8mkwxojX1y5HJ9ovYJToU/p3ddW8Nz7sPNIJpkJOZC
 Zexs2E5dYTmFi1xudVG1gXHEFMdIXssy4fZLkDSLbXrqIzDsaK1Ar3ecma3Z8e9ysV8o
 ZLlw==
X-Gm-Message-State: AOJu0YwaIyPI/CG9EFcjnn8gA2hK2WHW8EU7STtdQVtYXdnk2Hv+m0m9
 dCCcK+Sup/RO7VOqptL0scBEXLQMVwaXR6WX2lqDu6WEB995kXxsQAFDxacHjSAv7Xo+TVW57FO
 JCe/7vbqBfYOno0i0T9y6vIg=
X-Received: by 2002:adf:9dcb:0:b0:32d:87df:6ded with SMTP id
 q11-20020adf9dcb000000b0032d87df6dedmr9971565wre.27.1697359343311; 
 Sun, 15 Oct 2023 01:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkJJh1UGhg/FQWw2uUu2Pp7EH6Nf4LY1G7eqzFNP3bnp2Mb9PvtRvAjIf6Pf0l4lPkXBXMdw==
X-Received: by 2002:adf:9dcb:0:b0:32d:87df:6ded with SMTP id
 q11-20020adf9dcb000000b0032d87df6dedmr9971552wre.27.1697359342906; 
 Sun, 15 Oct 2023 01:42:22 -0700 (PDT)
Received: from redhat.com ([109.253.179.214]) by smtp.gmail.com with ESMTPSA id
 p9-20020a5d4e09000000b0032196c508e3sm3839919wrt.53.2023.10.15.01.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 01:42:21 -0700 (PDT)
Date: Sun, 15 Oct 2023 04:42:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vincent Jardin <vincent.jardin@ekinops.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [RFC] virtio: enforce link up
Message-ID: <20231015034428-mutt-send-email-mst@kernel.org>
References: <20231014162234.153808-1-vincent.jardin@ekinops.com>
 <20231014123635-mutt-send-email-mst@kernel.org>
 <8f110502-7ab7-4db2-9702-3717cf6afc58@ekinops.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f110502-7ab7-4db2-9702-3717cf6afc58@ekinops.com>
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

On Sat, Oct 14, 2023 at 09:06:09PM +0000, Vincent Jardin wrote:
> On 10/14/23 18:37, Michael S. Tsirkin wrote:
> > On Sat, Oct 14, 2023 at 06:22:34PM +0200, Vincent Jardin wrote:
> >> Using interface's settings, let's enforce an always on link up.
> >>
> >> Signed-off-by: Vincent Jardin <vincent.jardin@ekinops.com>
> > 
> > What is going on here? Just don't set it down.
> 
> The purpose is to have a stable vLink for the VMs that don't support 
> such sysctl arp_evict_nocarrier:
> https://patchwork.kernel.org/project/netdevbpf/patch/20211101173630.300969-2-prestwoj@gmail.com/
> 
> We are facing some users of vSwitches that use vhost-user and that 
> disconnect and reconnect during some operations. For most of the VMs on 
> their deployments with such vSwitches, those VMs' vLink should not flap.
> 
> For those VMs, the flaps are critical and they can lead to some 
> convergence issues.
> 
> If this capability is not at the virtio-net level, should it be at 
> qemu's net_vhost_user_event() ?
> For instance, from 
> https://github.com/qemu/qemu/blob/63011373ad22c794a013da69663c03f1297a5c56/net/vhost-user.c#L266 
> ?
> 
> best regards,
>    Vincent


makes sense

> 
> > 
> >> ---
> >>   hw/net/virtio-net.c            | 8 ++++++++
> >>   include/hw/virtio/virtio-net.h | 2 ++
> >>   2 files changed, 10 insertions(+)
> >>
> >> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> index 29e33ea5ed..e731b4fdea 100644
> >> --- a/hw/net/virtio-net.c
> >> +++ b/hw/net/virtio-net.c
> >> @@ -78,6 +78,9 @@
> >>      tso/gso/gro 'off'. */
> >>   #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
> >>   
> >> +/* force always link up */
> >> +#define VIRTIO_NET_LINK_UP false
> >> +
> >>   #define VIRTIO_NET_RSS_SUPPORTED_HASHES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
> >>                                            VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
> >>                                            VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
> >> @@ -447,6 +450,9 @@ static void virtio_net_set_link_status(NetClientState *nc)
> >>       else
> >>           n->status |= VIRTIO_NET_S_LINK_UP;
> >>   
> >> +    if (n->net_conf.link_up)
> >> +        n->status |= VIRTIO_NET_S_LINK_UP;
> >> +
> >>       if (n->status != old_status)
> >>           virtio_notify_config(vdev);
> >>   
> >> @@ -3947,6 +3953,8 @@ static Property virtio_net_properties[] = {
> >>                         VIRTIO_NET_F_GUEST_USO6, true),
> >>       DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> >>                         VIRTIO_NET_F_HOST_USO, true),
> >> +    DEFINE_PROP_BOOL("link_up", VirtIONet, net_conf.link_up,
> >> +                       VIRTIO_NET_LINK_UP),
> >>       DEFINE_PROP_END_OF_LIST(),
> >>   };
> >>   
> >> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> >> index 55977f01f0..385bebab34 100644
> >> --- a/include/hw/virtio/virtio-net.h
> >> +++ b/include/hw/virtio/virtio-net.h
> >> @@ -56,6 +56,7 @@ typedef struct virtio_net_conf
> >>       char *duplex_str;
> >>       uint8_t duplex;
> >>       char *primary_id_str;
> >> +    bool link_up; /* if set enforce link up, never down */
> >>   } virtio_net_conf;
> >>   
> >>   /* Coalesced packets type & status */
> >> @@ -180,6 +181,7 @@ struct VirtIONet {
> >>       size_t guest_hdr_len;
> >>       uint64_t host_features;
> >>       uint32_t rsc_timeout;
> >> +    uint32_t link_up; /* if set enforce link up, never down */
> >>       uint8_t rsc4_enabled;
> >>       uint8_t rsc6_enabled;
> >>       uint8_t has_ufo;
> >> -- 
> >> 2.34.1
> > 
> 


