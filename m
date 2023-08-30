Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D4478D421
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:33:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGdB-0008Kg-Qq; Wed, 30 Aug 2023 04:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGd9-0008KF-Hk
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGd7-0004Hg-Fi
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693384369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EK2OZOUxKkdKro3GHkOhODHiw84vZmGuiLG99FdeGuY=;
 b=iY41RAMMiIw1qU++VyH6yCqspspxkN/bKnGI3WHSqEOuiQqvUW9rf40xZZEdCmiofZo9hO
 ZztrxXKkda8wLQOtw2uH8vSqHzDCg8iTKM8p3NM/UEEi+A50jNq//x5d3zmyKMfNve5KjC
 5y9RK+/K24tQWwHsPUIYHYfhICqd1O8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-9cCRXwanMmatLqUFcahftQ-1; Wed, 30 Aug 2023 04:32:46 -0400
X-MC-Unique: 9cCRXwanMmatLqUFcahftQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-52a5e65d9b4so2764187a12.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 01:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693384365; x=1693989165;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EK2OZOUxKkdKro3GHkOhODHiw84vZmGuiLG99FdeGuY=;
 b=Zv2yTytvzWTdcczkgAilUdGBV3zvWD0Qi/s07y6P+mjPb1P7QZ69vOun7sG5usFpTH
 d5/fEFicn0ab3kkk2TCZxzoGLlzTAO7sv00yXY0HOrvQI4/HEEVPPg1bBlOUjcdtftQq
 Isav+fYUhuhrRK7pNKK/DyF5w8SY8zbe0kVG28s54EXL3v8Fv6ZmnEylhET1ktE5iqUD
 zGoGUvNSJMtwavBM3hzmcgL2imihhBu7EA9ml4VWf0q7WnQ1SXcJWa2KIkzW7g1jpuMP
 VK/6cOBSJUd44iASSznqFZg10bxvJw8SQrFh9Q0hniafTmc0ouKnKx1QLgJU8JK1NvWE
 c8qQ==
X-Gm-Message-State: AOJu0Ywan4I70Nk8wCdn3tDbPUrSOXANgpnlPP8vwnqCUS48hlqf6Gp6
 W9wwUZUuex2hf4/ceFGnMC1w5v5uJHT0lKlBtl4H6IF7IPgGI1E0Iis46pBOU37RtL5EO3uRFnD
 5k9ScYAa4P2CL9CU=
X-Received: by 2002:a17:906:20dd:b0:9a1:c89a:9260 with SMTP id
 c29-20020a17090620dd00b009a1c89a9260mr1069584ejc.51.1693384365501; 
 Wed, 30 Aug 2023 01:32:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+BRzJjNB68oJg3megIg9REgS9fX9Jp6VpXrT5xjno98Ig8ZtRWPZ0bGhabjDJCf8h62hc2Q==
X-Received: by 2002:a17:906:20dd:b0:9a1:c89a:9260 with SMTP id
 c29-20020a17090620dd00b009a1c89a9260mr1069577ejc.51.1693384365298; 
 Wed, 30 Aug 2023 01:32:45 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 h11-20020a170906590b00b00992e14af9b9sm6882503ejq.134.2023.08.30.01.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 01:32:44 -0700 (PDT)
Date: Wed, 30 Aug 2023 10:32:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH 6/7] vhost-user: allow "vhost_set_vring" to wait for a
 reply
Message-ID: <ac7zexkjvfvztxmfrhnlfoofwjzrblyctogmdhkpd527idjqpy@oxgzapdzlkgk>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-7-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230827182937.146450-7-lersek@redhat.com>
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

On Sun, Aug 27, 2023 at 08:29:36PM +0200, Laszlo Ersek wrote:
>The "vhost_set_vring" function already centralizes the common parts of
>"vhost_user_set_vring_num", "vhost_user_set_vring_base" and
>"vhost_user_set_vring_enable". We'll want to allow some of those callers
>to wait for a reply.
>
>Therefore, rebase "vhost_set_vring" from just "vhost_user_write" to
>"vhost_user_write_msg", exposing the "wait_for_reply" parameter.
>
>This is purely refactoring -- there is no observable change. That's
>because:
>
>- all three callers pass in "false" for "wait_for_reply", which disables
>  all logic in "vhost_user_write_msg" except the call to
>  "vhost_user_write";
>
>- the fds=NULL and fd_num=0 arguments of the original "vhost_user_write"
>  call inside "vhost_set_vring" are hard-coded within
>  "vhost_user_write_msg".
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>Cc: Eugenio Perez Martin <eperezma@redhat.com>
>Cc: German Maglione <gmaglione@redhat.com>
>Cc: Liu Jiang <gerry@linux.alibaba.com>
>Cc: Sergio Lopez Pascual <slp@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>---
> hw/virtio/vhost-user.c | 11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


