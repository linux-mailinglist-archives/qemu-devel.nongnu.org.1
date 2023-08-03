Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FE576F3AD
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 21:52:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qReLV-0008OW-MG; Thu, 03 Aug 2023 15:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qReLU-0008OO-5w
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 15:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qReLS-00036K-M9
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 15:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691092249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u9kUw/B0mtdv9pmq2m073k5N+yIRPfyZjUYK3LTIG74=;
 b=DqJT/IuEB6EDmiN14B4lXRM4b3M1uhWRzRFFcdI5tjsP3+YN1Qf2bkK2PdbyXBFRevByVK
 KIjwozgYl4Z6xUi7NdxMhS1QLjlZ5CzvwuG8RwC1Z0KhG5klrnFXr/YR2TiSXkv9xGK4oK
 nsmkwozKbR4SEEkNYN1fVy54Yh7dZ5o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-doQOKBh_OWO7AkhfKRy4cg-1; Thu, 03 Aug 2023 15:50:48 -0400
X-MC-Unique: doQOKBh_OWO7AkhfKRy4cg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe2a5ced6dso8404285e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 12:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691092247; x=1691697047;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9kUw/B0mtdv9pmq2m073k5N+yIRPfyZjUYK3LTIG74=;
 b=VLuTDIzuZ47+x1e1ezIu909exh5vUSOYNJcZNhPoVunMcEnfZGxAHCQ6T5iATtcnE4
 1KD9BxtsZKt0FjJ/qlOgaUDXCJMOlbbSg8FTsT+DYSccr3Mw0QSZTeriOXqzfiq4OT2k
 XXhVw6PaJzts6YQAq8LVvSSJBvDet+Us8tS7fuR6ajQLP5qtpqbG2aGahr3rwGkOXNGY
 TgCC2o9uWRly90m8328lCj6EVt5IntqYAgW2TpqVlkvWX0wYdxka/KJc3DG7jTvKOwuf
 JBHxTgHBxzOHqhsU4viQczWUam0CJrR6mTp9cG8+fmeltRmC6PpKJVzuy5bVkmIlPczR
 YTAg==
X-Gm-Message-State: ABy/qLZANOpliF0JKAh8MDweEBkmE9bR/PxCiLInSqIthAF03INh0mbk
 PPTrAAAn11iMzjPTcbHBZ4mBcvVL3zmmKxKyq4nDoYtAuNkfeC/SB4gnSvgID556OoGthpVEV+U
 9y790LwtgmC69sSk=
X-Received: by 2002:a5d:464c:0:b0:313:f1c8:a968 with SMTP id
 j12-20020a5d464c000000b00313f1c8a968mr8545148wrs.2.1691092247071; 
 Thu, 03 Aug 2023 12:50:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFwtqIOS0y/KvOzZlGhcL/XY5pSagRNfOnuGTonzbKyr0CJVNTb4e8XPtS6ytVYAiM52sWfZQ==
X-Received: by 2002:a5d:464c:0:b0:313:f1c8:a968 with SMTP id
 j12-20020a5d464c000000b00313f1c8a968mr8545136wrs.2.1691092246724; 
 Thu, 03 Aug 2023 12:50:46 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 k14-20020adfd84e000000b003177e9b2e64sm618670wrl.90.2023.08.03.12.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 12:50:46 -0700 (PDT)
Date: Thu, 3 Aug 2023 15:50:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net
Subject: Re: [PATCH v3 0/3] qmp,vhost-user: Remove virtio_list & update
 virtio introspection
Message-ID: <20230803155022-mutt-send-email-mst@kernel.org>
References: <20230803145500.2108691-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803145500.2108691-1-jonah.palmer@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Aug 03, 2023 at 10:54:57AM -0400, Jonah Palmer wrote:
> These patches update a few things related to virtio introspection via.
> QMP/HMP commands.
> 
> 1. Remove 'virtio_list' and instead query the QOM composition tree to
> find any active & realized virtio devices.
> 
> The 'virtio_list' was duplicating information about virtio devices that
> was already available in the QOM composition tree, so there was no need
> to keep this list.
> 
> 2. Add new transport, protocol, and device features as well as support
> to introspect vhost-user-gpio devices.
> 
> Vhost-user-gpio previously had no support for introspection. Support for
> introspecting its vhost-user device is now available in these patches.
> 
> 3. Move VhostUserProtocolFeature definition to its corresponding header
> file (vhost-user.h). Cleanup previous definitions in other files.
> 
> VhostUserProtocolFeature was being defined in 3 separate files. Instead
> of 3 separate definitions, use one instead and add it to the
> vhost-user.h header file.
> 
> New virtio transport feature:
> -----------------------------
>  - VIRTIO_F_RING_RESET
> 
> New vhost-user protocol feature:
> --------------------------------
>  - VHOST_USER_PROTOCOL_F_STATUS
> 
> New virtio device features:
> ---------------------------
> virtio-blk:
>  - VIRTIO_BLK_F_SECURE_ERASE
> 
> virtio-net:
>  - VIRTIO_NET_F_NOTF_COAL
>  - VIRTIO_NET_F_GUEST_USO4
>  - VIRTIO_NET_F_GUEST_USO6
>  - VIRTIO_NET_F_HOST_USO
> 
> virtio/vhost-user-gpio:
>  - VIRTIO_GPIO_F_IRQ
>  - VHOST_F_LOG_ALL
>  - VHOST_USER_F_PROTOCOL_FEATURES

VHOST_F_LOG_ALL likely does not make sense.

> v3: use recursion and type casting to find realized virtio devices
>     remove virtio scmi & bluetooth feature mappings
>     revert virtio scmi & bluetooth case changes in qmp_decode_features
>     change config define for VIRTIO_GPIO to CONFIG_VHOST_USER_GPIO
>     move VhostUserProtocolFeature definition to header file
> 
> v2: verify virtio devices via. 'TYPE_VIRTIO_DEVICES'
>     verify path is a virtio device before checking if it's realized
>     remove 'VIRTIO_BLK_F_ZONED' update (already exists)
>     add cover letter
> 
> Jonah Palmer (3):
>   qmp: remove virtio_list, search QOM tree instead
>   qmp: update virtio feature maps, vhost-user-gpio introspection
>   vhost-user: move VhostUserProtocolFeature definition to header file
> 
>  hw/scsi/vhost-user-scsi.c      |   4 -
>  hw/virtio/vhost-user-gpio.c    |   7 ++
>  hw/virtio/vhost-user.c         |  21 -----
>  hw/virtio/virtio-qmp.c         | 154 ++++++++++++++++-----------------
>  hw/virtio/virtio-qmp.h         |   7 --
>  hw/virtio/virtio.c             |   6 --
>  include/hw/virtio/vhost-user.h |  21 +++++
>  7 files changed, 105 insertions(+), 115 deletions(-)
> 
> -- 
> 2.39.3


