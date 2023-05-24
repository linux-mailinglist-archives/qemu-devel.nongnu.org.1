Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4461770F054
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:11:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jac-0003AD-C2; Wed, 24 May 2023 04:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1jab-0003A4-6V
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1jaY-0002o5-Qu
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684915878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G/7YN0/EgAQNZhcWOzYnQDnc6s/74LmWiJRQZI2Rysc=;
 b=g6atmp3WFlWkhSeqVvj1QRj3Be8+aEeMrcm6KD2cyvmEvZx9f04jWHTkUHuYlhd3gZxM0q
 Xazp+7WVxVofacPeRzGZbo9+Y3CNipmgxQfu9fes74TVD73uuOOi7PYkMYbbry9DyBkwph
 o5vy4gOogqFrexE4GT4tNHfKgdHfMT0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-diB-F4aWNa-vGUpPuAeS-A-1; Wed, 24 May 2023 04:11:16 -0400
X-MC-Unique: diB-F4aWNa-vGUpPuAeS-A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30959544cbdso223065f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 01:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684915875; x=1687507875;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/7YN0/EgAQNZhcWOzYnQDnc6s/74LmWiJRQZI2Rysc=;
 b=ZrgXaMvhA8YmSXPvquFs+Sk/Wbmt0vPVBaQIoKhqAI7uach2uw8xvi/tgaZPomPFrG
 3FnuU14GWkSDbRGHHeZPzq/EAO2oKVNrnRjugyD/aAodGP0ZebgqUIxbFSl1IUah2Z3L
 dLxszp6n+ROWRz63p0VAQi6r0jOuKexoyPlvEv4dtuaxdTDWbZ7r4zVa3zV5DEqzEvaR
 u2m27ATKwrfXsi1TbFc+Uv0UDAjwZ/AWnYFojATj58yvqMP1s/0qbSxYMNQFJFiWmyGY
 h0HoQq0WHxAX7Pc2d5X6Q8hvrEhW99TxImary/v52qhBMMPbjOSHKCyPYh7pUlshBB6/
 3sDQ==
X-Gm-Message-State: AC+VfDwpwHA9KyWYS6OAYxVjqz7ug45GyE8kBI8o+udQBIgVDcUBs3NU
 Cz+oU5IriI9KBYVSozysWJuX8Ofilfk7oygu48Bc3abn15Rax5btOE+7g5Gv3zXcvvNabJVVvRq
 FP2KqFE/+I06IS8E=
X-Received: by 2002:a5d:5291:0:b0:307:f75:f581 with SMTP id
 c17-20020a5d5291000000b003070f75f581mr11985754wrv.18.1684915875677; 
 Wed, 24 May 2023 01:11:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ577uGe1zMc+ifh7kvZp70XkqxdzoAHp3sJz16D+lvdNzKzMhD8u7jKwCYMRYhN9TscLAWlwA==
X-Received: by 2002:a5d:5291:0:b0:307:f75:f581 with SMTP id
 c17-20020a5d5291000000b003070f75f581mr11985721wrv.18.1684915875357; 
 Wed, 24 May 2023 01:11:15 -0700 (PDT)
Received: from sgarzare-redhat ([134.0.5.107])
 by smtp.gmail.com with ESMTPSA id
 r14-20020adfce8e000000b00306c5900c10sm13683435wrn.9.2023.05.24.01.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 01:11:14 -0700 (PDT)
Date: Wed, 24 May 2023 10:11:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 xen-devel@lists.xenproject.org, 
 eblake@redhat.com, Anthony Perard <anthony.perard@citrix.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 2/6] block/nvme: convert to blk_io_plug_call() API
Message-ID: <5xfhgfmpnjorl4fxzm5b7ow2nijsz4qx27otj7d6jgzpca26st@jg3ah6u46cqq>
References: <20230523171300.132347-1-stefanha@redhat.com>
 <20230523171300.132347-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230523171300.132347-3-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, May 23, 2023 at 01:12:56PM -0400, Stefan Hajnoczi wrote:
>Stop using the .bdrv_co_io_plug() API because it is not multi-queue
>block layer friendly. Use the new blk_io_plug_call() API to batch I/O
>submission instead.
>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>Reviewed-by: Eric Blake <eblake@redhat.com>
>---
>v2
>- Remove unused nvme_process_completion_queue_plugged trace event
>  [Stefano]
>---
> block/nvme.c       | 44 ++++++++++++--------------------------------
> block/trace-events |  1 -
> 2 files changed, 12 insertions(+), 33 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


