Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 401A778D420
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGcp-0007xh-Vm; Wed, 30 Aug 2023 04:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGcj-0007wN-Pi
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGcg-0003zu-NC
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693384341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZM3zikpU9+8LyM1WpWDo4DmgUTwr2FY1jEVbnijp4FY=;
 b=H8U/YURlkqjAZLliSZEh+MoXTGrNI64DDQtbKxfh9h84Lm1kdqYdHB7FSkUmiwXZGkMEPD
 G0Uc7rqjYow/Ckxw25HoVgmy9WJHj4BYxoUhKxCxFOPTbOybLBKwUe1dPm25g6fSDvIMGJ
 eaC7ei++cxW2+5LYGfOWYAkAo+DDkr4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-cHp1hA2cOTe6jt99ie0KtA-1; Wed, 30 Aug 2023 04:31:47 -0400
X-MC-Unique: cHp1hA2cOTe6jt99ie0KtA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-500b5dbf113so3417024e87.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 01:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693384306; x=1693989106;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZM3zikpU9+8LyM1WpWDo4DmgUTwr2FY1jEVbnijp4FY=;
 b=MlWi1iMStp3QcKJomnlj6G7DLRb8x1iSPysN+lX55wDZvQN0CDJzgicib0yizH5pu2
 L09BtM8DCSgd9bDCxZi84Lh7kR9H/bpdySgZQD4Li1HUC6nHLX5OfCfq7oTlbWAJON9z
 WqMHBAFe/s3bdD3C6Pwf3MDSW9gtHEAXbilsz18VhnjetHM8VA2Ak2aUsHZ2JvOQYKxt
 cY75SFxKpjEk9cqgGgt6QZOq6G7XPxOUXvOqjkqp6n0qZ/V4SS8QIwk+ctfb30bYDXCp
 GXENeIcI6Qvrspjvt2IBNTlMgcGd9m2mAB3oqDwhZ0DKjwlFnHP/Hrtzaf+jxBItnqYx
 s4WQ==
X-Gm-Message-State: AOJu0Yz1qrhNsNW3+C+0n5KcakWet28OZQEYTWFgJ444CPA2YT58puDj
 TEOYn/x7VynyfHivzD4bu4xkzoxOQPVjwUtyWvWGb4s5jBBQYEg0G0ziidHf+6yq6cf2DUi6+jv
 vTHxG78sIUGVLdaY=
X-Received: by 2002:a05:6512:3b8a:b0:500:a41d:354c with SMTP id
 g10-20020a0565123b8a00b00500a41d354cmr1214670lfv.28.1693384306351; 
 Wed, 30 Aug 2023 01:31:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPRdNPi7F25YJjA1reU3cLPRPJdU62LI4AR00LEq4dZYAzJ1M49xLD9QxDLyEcdzbgVmH+xw==
X-Received: by 2002:a05:6512:3b8a:b0:500:a41d:354c with SMTP id
 g10-20020a0565123b8a00b00500a41d354cmr1214648lfv.28.1693384306040; 
 Wed, 30 Aug 2023 01:31:46 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 w24-20020a17090649d800b009930308425csm6906126ejv.31.2023.08.30.01.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 01:31:45 -0700 (PDT)
Date: Wed, 30 Aug 2023 10:31:43 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH 4/7] vhost-user: flatten "enforce_reply" into
 "vhost_user_write_msg"
Message-ID: <vozya5zd2bcywhcdbthkxrl2kmc6qs7cgox7vszm6blxlw6cnu@ag3xhfy54q6l>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-5-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230827182937.146450-5-lersek@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

On Sun, Aug 27, 2023 at 08:29:34PM +0200, Laszlo Ersek wrote:
>At this point, only "vhost_user_write_msg" calls "enforce_reply"; embed
>the latter into the former.
>
>This is purely refactoring -- no observable change.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>Cc: Eugenio Perez Martin <eperezma@redhat.com>
>Cc: German Maglione <gmaglione@redhat.com>
>Cc: Liu Jiang <gerry@linux.alibaba.com>
>Cc: Sergio Lopez Pascual <slp@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>---
> hw/virtio/vhost-user.c | 32 ++++++++------------
> 1 file changed, 13 insertions(+), 19 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


