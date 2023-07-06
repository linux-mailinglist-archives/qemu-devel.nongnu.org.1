Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D17B074A4A1
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 22:03:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHVBG-0007PW-Fj; Thu, 06 Jul 2023 16:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHVBD-0007P1-SM
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHVBA-00048x-RV
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688673735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3d66+TvRXJkGHToXksSZ4hEEvL1mw/2JzIEndIGjPwY=;
 b=MNL8WIYL4EMipLCDZNkk5x7Kq+Qi2po4keOUUHoXz+YaaS2nUJMLW3PsTt96cjqn0EICKq
 dENavgiYXEs8qag5gkRnmnIex2scTzTJ/IRIevpE5k0QUghkZkSt7lHBgsFFQtxHVVe1Bv
 qCkoOTSleOFKIUrfV0knb7lLLd80VA4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-6yLrbcqsMkWfN7LJJAtoHw-1; Thu, 06 Jul 2023 16:02:14 -0400
X-MC-Unique: 6yLrbcqsMkWfN7LJJAtoHw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fb8284465aso7245345e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 13:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688673733; x=1691265733;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3d66+TvRXJkGHToXksSZ4hEEvL1mw/2JzIEndIGjPwY=;
 b=CykCWQBGNndYuddg5QGVg2YgqNPlDVdNwk6SuEuPMQ1sVtGa5ZnZwIR8b2VvfPG4Gf
 JN/MrBWiiQB8LrACP6RgynLJQurebw4Iol5OlLJP9l7YSpcZCt3tiaQUdsfixjfYt6c3
 4WPd6TGH+sK7nldtwvJirWi9/fkKvF/gF4zGXxCq/yMy1BNFkT0+HhPE03mI+iZ+q7JW
 ZIIhu/b9Pav7S03pq2hCOBjNgF6LTCOjUUfV2oVpXbrYBaMKHR9AC5FV7H8DwGerGWzW
 aRrJmpLLGsbozloa0VuIhqexqVJOywRF6Vcf/dgobnpjM0kGXytDHMKb7Yam8VAPPRrT
 webA==
X-Gm-Message-State: ABy/qLaeDKuncKBApjiOXWLbozm2+I9N2nuVtmWR93f6Fp0le9Z3w323
 4wgcXyokVkeesuEvrBjqYHzrF6x40qALnsC2amNbWyRwcr4SakUtIpGzYhkuogtfYcOEVUqgo0f
 FHxKIAFpQwgg1UUE=
X-Received: by 2002:a05:600c:2246:b0:3fa:8fc2:3969 with SMTP id
 a6-20020a05600c224600b003fa8fc23969mr2329489wmm.17.1688673732974; 
 Thu, 06 Jul 2023 13:02:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFyQcf8pvVoSfrm9kxa8dqrZyIMLHfwy/ivUbEwBXvORrYyngDokXVFnC28IDRZCxA1QCclVw==
X-Received: by 2002:a05:600c:2246:b0:3fa:8fc2:3969 with SMTP id
 a6-20020a05600c224600b003fa8fc23969mr2329470wmm.17.1688673732658; 
 Thu, 06 Jul 2023 13:02:12 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 m16-20020a7bcb90000000b003fbdd5d0758sm453477wmi.22.2023.07.06.13.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 13:02:12 -0700 (PDT)
Date: Thu, 6 Jul 2023 16:02:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Cindy Lu <lulu@redhat.com>, si-wei.liu@oracle.com,
 Stefano Garzarella <sgarzare@redhat.com>,
 Shannon Nelson <snelson@pensando.io>,
 Gautam Dawar <gdawar@xilinx.com>, Jason Wang <jasowang@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Parav Pandit <parav@mellanox.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>
Subject: Re: [RFC PATCH 0/6] Enable vdpa net migration with features
 depending on CVQ
Message-ID: <20230706160139-mutt-send-email-mst@kernel.org>
References: <20230706191227.835526-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706191227.835526-1-eperezma@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, Jul 06, 2023 at 09:12:21PM +0200, Eugenio Pérez wrote:
> At this moment the migration of net features that depends on CVQ is not
> possible, as there is no reliable way to restore the device state like mac
> address, number of enabled queues, etc to the destination.  This is mainly
> caused because the device must only read CVQ, and process all the commands
> before resuming the dataplane.
> 
> This RFC lift that requirement, sending the VHOST_VDPA_SET_VRING_ENABLE ioctl
> for dataplane vqs only after the device has processed all commands.  If this
> method is valid or not, or if it must be signalled by the parent driver
> somehow, is still under discussion.  In case it is valid, this code allows
> testing the vDPA device for it.

And you plan to add the reset trick too in a future version?

> Eugenio Pérez (6):
>   vdpa: export vhost_vdpa_set_vring_ready
>   vdpa: add should_enable op
>   vdpa: use virtio_ops->should_enable at vhost_vdpa_set_vrings_ready
>   vdpa: add stub vhost_vdpa_should_enable
>   vdpa: delay enable of data vqs
>   vdpa: remove net cvq migration blocker
> 
>  include/hw/virtio/vhost-vdpa.h |  9 +++++++
>  hw/virtio/vhost-vdpa.c         | 33 +++++++++++++++++++------
>  net/vhost-vdpa.c               | 45 +++++++++++++++++++++++++---------
>  hw/virtio/trace-events         |  2 +-
>  4 files changed, 68 insertions(+), 21 deletions(-)
> 
> -- 
> 2.39.3
> 


