Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F7579F1F5
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 21:24:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgVRr-0007Bk-4h; Wed, 13 Sep 2023 15:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgVRo-0007BY-CM
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgVRm-0003yY-9Z
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694632964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9sjXHzBZ0fOFfH0n6h/o7khG3MxgaoL/tgjqpEAKU2g=;
 b=cJx+w6l0zvKj6jGhqExhKP5G4DTgjIzkT1jqwB51ElxoY+CA+7N/r44bP9gG/lnlO8iMIQ
 uuX+pbgGw0fK9d04cMehLSXApX1ajDnb23gCuqQqdIOj/ZMYez19KR4HdatOWOBfUs0ZuZ
 i6ym/vl0DC3bmoziTSM3hb796G44OQY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-erdZig3ZOJqyPoAqYHIBWw-1; Wed, 13 Sep 2023 15:22:43 -0400
X-MC-Unique: erdZig3ZOJqyPoAqYHIBWw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-63d2b88325bso407846d6.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 12:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694632963; x=1695237763;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sjXHzBZ0fOFfH0n6h/o7khG3MxgaoL/tgjqpEAKU2g=;
 b=dAmsIWRWdoo0rAt911/rCd15SOM46kylDEVtHbKNb+c/m/YaYBI4d+v7ApMpGjgl6H
 ut1dV6+WRoXpNfogmtDeYZ/CNsvyQ7dYAEIDT1C0BLp0M4lUr7oVTzV9L3fkwUjEQk7E
 Do9TZ/rpJy7TGsFblKDNkNir1RCNIEJABKluM5VCVYXy626zPd8CkOri3LhZuR9zei+Y
 lyQoM7oQH4jO8I1XJvO8VgHwkrtlhGNsRvTpteKVpUfhy1U3Iah9RHVC0PI8gpVp2u/k
 leRUjRz5DWBYyRYerCMcZXqT2fdugUqq3SswO24tk1yccbG5mAUuPS/6O0nJgpr165lg
 UuDA==
X-Gm-Message-State: AOJu0Yw/EzslS0oMoU7iMNCwMkX9vjImzNfJfVDTyfJV+DY4ZgGwzYf5
 P4+84iVFEoGfBGZxbZyy6vzgu5qXVtw88EV8ilxgBpV9l4bw1kw3FORzhfBE0JzhsDPhZPMTGlc
 7veZYalVs2Ia0AvA=
X-Received: by 2002:a05:6214:234c:b0:64a:8d39:3378 with SMTP id
 hu12-20020a056214234c00b0064a8d393378mr3470396qvb.4.1694632962849; 
 Wed, 13 Sep 2023 12:22:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGhXccB8OZ7EhRVSzbadZLV5uhmL4u8fyYvDPbWALfA14ux6IAsKTBoQO020esizLPoc9V5A==
X-Received: by 2002:a05:6214:234c:b0:64a:8d39:3378 with SMTP id
 hu12-20020a056214234c00b0064a8d393378mr3470382qvb.4.1694632962607; 
 Wed, 13 Sep 2023 12:22:42 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 x15-20020ad4458f000000b00655e5724eebsm2852278qvu.66.2023.09.13.12.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 12:22:42 -0700 (PDT)
Date: Wed, 13 Sep 2023 15:22:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru
Subject: Re: [PATCH v1 0/2] i386/a-b-bootblock: zero the first byte of each
 page on start
Message-ID: <ZQIMAdfjmwGsxeME@x1n>
References: <20230907193051.1609310-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907193051.1609310-1-d-tatianin@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Sep 07, 2023 at 10:30:49PM +0300, Daniil Tatianin wrote:
> This series fixes an issue where the outcome of the migration qtest
> relies on the initial memory contents all being the same across the
> first 100MiB of RAM, which is a very fragile invariant.
> 
> We fix this by making sure we zero the first byte of every testable page
> in range beforehand.
> 
> Daniil Tatianin (2):
>   i386/a-b-bootblock: factor test memory addresses out into constants
>   i386/a-b-bootblock: zero the first byte of each page on start

Thanks, sorry for being slow on review.

Reviewed-by: Peter Xu <peterx@redhat.com>

How about other archs (arm/s390)?   It seems to me arm is all fine, but not
sure about s390.

-- 
Peter Xu


