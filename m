Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB067A82F6
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 15:10:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwxQ-0008BP-3e; Wed, 20 Sep 2023 09:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qiwxO-0008BH-1s
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qiwxC-0000AL-Vm
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695215357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2w+RBdsHWC02aMHCn8yCdwIBL50/+BLd2LAPU886+Zg=;
 b=gvhAGbOQhz31K2SHVYEBB5m5P3RYCi8IK46Jd94oEJkQfof63viFjFlr5fU2HN+/XqvFVx
 sIVEyfT8sMZs/Ea198x7wuYgJEuJ5SWYnqgZad/2HjjH9vBa2tNm9yCJy7/NVwy1Izko0u
 Xnruvu0mKLZMOk9uuGY9RbHCehN5GRc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-Nn7yqYVQNQ6xT46sJv7heA-1; Wed, 20 Sep 2023 09:09:16 -0400
X-MC-Unique: Nn7yqYVQNQ6xT46sJv7heA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-531373ea109so2288739a12.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 06:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695215355; x=1695820155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2w+RBdsHWC02aMHCn8yCdwIBL50/+BLd2LAPU886+Zg=;
 b=JOKpiJEHd+BuWryTPxKY5T/Y22hNzO/vghiuc0tIc/hvej0oAVnQ9mPpZeUWQxxh1G
 rklexLwZCCE5faXF1awai6BzDk5zN7qS6zvD+uE3yz6uVFjUbF9npLVVq+PTJw74cxBX
 vpHPUAvJjIMG0pg7nSbuUHmsnPIGrZc/b71t/NoXlQWfy41ugBamEQGmabWvLwxntFVy
 /8GQOSfNswxWi0ot0OWJE5OvAD7RVXJNZEGV98PRaZUxulVrOaw2MiiN0gdzoA12XSPd
 mkmI12kyDmFU/PwAfMyq1nN3DXhshHYSsBXwupA0AhXkO5gkTmJFibxu2DP8EdonRn3E
 BELA==
X-Gm-Message-State: AOJu0YwIzGigTUl+4BuOCbTsG7P25symW16hAtkn1lifQwpvw4pyuJzv
 4ZmyBL2ZnBG/I7pIlH2KmyxEiBEdGhVO861+YeJ/C5WPew/+snnfMjWkGXkjLq8Q9ND2gDIRd4h
 pgOpOYYwPDu5qz90wGgYLnvbz/SlCNZo=
X-Received: by 2002:a05:6402:184e:b0:523:3fff:5ce2 with SMTP id
 v14-20020a056402184e00b005233fff5ce2mr2144660edy.41.1695215355026; 
 Wed, 20 Sep 2023 06:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFycnpgfBh/vfktVDve5oGl2hy3NQ36q3xLo9eeh461GRcVnPEysZekX2JzkVVO7l7KzPlfUjOM3OQuOp0QW3c=
X-Received: by 2002:a05:6402:184e:b0:523:3fff:5ce2 with SMTP id
 v14-20020a056402184e00b005233fff5ce2mr2144647edy.41.1695215354757; Wed, 20
 Sep 2023 06:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230915170836.3078172-1-eperezma@redhat.com>
In-Reply-To: <20230915170836.3078172-1-eperezma@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 20 Sep 2023 21:08:37 +0800
Message-ID: <CAPpAL=z1JQBsJbPXxLvXS1mYAkNTWdO7EJWR7nfT3oZh=nthfA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Follow VirtIO initialization properly at vdpa net
 cvq isolation probing
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Hawkins Jiawei <yin31149@gmail.com>,
 qemu-stable@nongnu.org, 
 si-wei.liu@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

QE tested this series with regression testing, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, Sep 16, 2023 at 1:08=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This series solves a few issues.  The most obvious is that the feature se=
t was
> done previous to ACKNOWLEDGE | DRIVER status bit set.  Current vdpa devic=
es are
> permissive with this, but it is better to follow the standard.
>
> Apart from that it fixes two issues reported by Peter Maydell:
> * Stop probing CVQ isolation if cannot set features (goto missed).
> * Fix incorrect error message statis "error setting features", while it s=
hould
> say status.
>
> v2: add forgotten Fixes tag
>
> Eugenio P=C3=A9rez (3):
>   vdpa net: fix error message setting virtio status
>   vdpa net: stop probing if cannot set features
>   vdpa net: follow VirtIO initialization properly at cvq isolation
>     probing
>
>  net/vhost-vdpa.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> --
> 2.39.3
>
>


