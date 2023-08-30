Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BF278D419
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:28:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGXz-0005nB-5g; Wed, 30 Aug 2023 04:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGXn-0005l1-J1
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGXl-00035B-EY
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693384036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lMyn873vHbpIXXFBUk2tmUlVnSbFw+AAjNbGDTCnESs=;
 b=ZzTUZIgBco3NMWP9HFZ8Hy6+Rzhmn+6zYIy3WRy3OxHs4s5DzHJ0Bd+1ojMaXlbbtjElgP
 roSypUrraklrvufcGusy07JpHCH/jUULnn7Lgj+x0Rxu4jb/NxXvIH4QeHAWrAeDTyaqcw
 9N6VmqW81PtCbrA/k/DC8JO83vZSPLA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-xQbHsJmfM7W3AYSmK7mwXQ-1; Wed, 30 Aug 2023 04:27:15 -0400
X-MC-Unique: xQbHsJmfM7W3AYSmK7mwXQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9a57ec840e2so91672466b.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 01:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693384034; x=1693988834;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMyn873vHbpIXXFBUk2tmUlVnSbFw+AAjNbGDTCnESs=;
 b=BM0QyYdzQuVqGF58bzyv2Ls+3gljZm6Gq8sbQtLIlNT3rySZrNsPB5zkRN2Q626O8L
 Tq4BYO81cFFtsgq6b13XfNXOXGvsnA3hiHsj8yJbPZev2HCXcWd781ZRqT6JGdau9UB1
 8xWoxsJDLvD2pUgdAMaxwI+ttgASIvCu8J5Tbeq38WxW62ZQ1UlJKmJqQEkR2mrgFz6Y
 G2ek0SL+OPEephyeeQtQQp7Z7pilVT2+UFyK6wTfIcx03yrYpOgQGN4WiB9gmvFVY6Sr
 7Gl0r2CH5xOZ5q2qnAVlFjaCg88Kxr2WzM4O00YDLL8CAV+6JN7YBjZjUdFfpR4wxa8A
 sV7g==
X-Gm-Message-State: AOJu0Yxx8or7eAY+6dOSMfcXQr7suElHzLf1I1B1I+A7/NrLc9BXdNKH
 cOy9aAlCpLAb9F5BZcywYH2eGnyTIYQJu9c8JMHeX7XjbXASvcuZ6KxZto/PKGp+HxjoQl5h1pY
 f2i1JQeMEK2iQpl0=
X-Received: by 2002:a17:907:b13:b0:9a1:fda6:2e2a with SMTP id
 h19-20020a1709070b1300b009a1fda62e2amr1839391ejl.9.1693384033979; 
 Wed, 30 Aug 2023 01:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXF8ZIVgTeSO62aVVoThENt/jSoQhBNpOuIpgYKB+7WCjgjMpWvVnqKTdTnmPdxaRuXmEbxg==
X-Received: by 2002:a17:907:b13:b0:9a1:fda6:2e2a with SMTP id
 h19-20020a1709070b1300b009a1fda62e2amr1839375ejl.9.1693384033731; 
 Wed, 30 Aug 2023 01:27:13 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 d16-20020a1709061f5000b009931a3adf64sm7040951ejk.17.2023.08.30.01.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 01:27:13 -0700 (PDT)
Date: Wed, 30 Aug 2023 10:27:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH 2/7] vhost-user: tighten "reply_supported" scope in
 "set_vring_addr"
Message-ID: <5vxuuflx2wqgvotsq5mlvr3yu7k7ij3feczyueqedlu4rsnffh@tuslnbasazaz>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-3-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230827182937.146450-3-lersek@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Sun, Aug 27, 2023 at 08:29:32PM +0200, Laszlo Ersek wrote:
>In the vhost_user_set_vring_addr() function, we calculate
>"reply_supported" unconditionally, even though we'll only need it if
>"wait_for_reply" is also true.
>
>Restrict the scope of "reply_supported" to the minimum.
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
> hw/virtio/vhost-user.c | 11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


