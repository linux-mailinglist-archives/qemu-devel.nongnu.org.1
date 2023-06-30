Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4647434B1
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 08:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF7DD-0003Eo-Sf; Fri, 30 Jun 2023 02:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF7D9-0002xZ-ER
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF7D7-00071G-TE
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688104944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXUXVxgndvijIk8J5S0mM5AqeRDeJ4fepXjXrrQBASs=;
 b=Ix2NOJ+leceZWeA6RYzVGKXwl5GtSr5IZZB1TeY89Kz89BIHj/0SfyQRfFaeiR4cshljdB
 kIEbinQpE7o1E6OIMFKVATwreBvbKqcN1hr2nTq++TTS9Oq7n+JfR2M/LR7oQQPgkWNxYh
 BKwW32lP1Wt/CUKx2GbkOofZALOqm28=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-gRE79BTwPf6zhobmgb6gJA-1; Fri, 30 Jun 2023 02:02:21 -0400
X-MC-Unique: gRE79BTwPf6zhobmgb6gJA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6b9eeaa3fso8327051fa.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 23:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688104940; x=1690696940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UXUXVxgndvijIk8J5S0mM5AqeRDeJ4fepXjXrrQBASs=;
 b=Vq/PuI36TvzwFUbRq1JU8kRcw7kFsgDdsAmTnauVe/Bn8WQmeeYjKSkn8lk3hipW5S
 0Vj7yhItzMMrcC/9tZrrGFLOnWnRnQMzA6U7tF1sQa4k7Xfn8QPe0lMWQTaTkbVFGp4U
 65ypjTC/LjukhQlwalmRwiHM4WNfJkDNM/VNs//t3XBh1NQ1TKV0kJ9llxaQ2tvLaT8C
 7FUqR2OPT9c7ldvRn60OTustbWFX6PnAnF+Vjo5zMXonZ+Ex23xQAiYWuj8omdcTsdM8
 DgiIrgdN6Fsbhxhk7SjS/++tnQHKjJInHTcNCg2xgur0doE3EBwPHr44JoiPuIYRzgxo
 mTJA==
X-Gm-Message-State: AC+VfDzoBoWup0clCGLgQ4nHPAYoEKfrsBhg17xyqr5nq4JNlsOKo43R
 vyJ7fVmc6mk5VaZ2iyxh9gN+2bKgbjxO8NQ6pGAokTXDe28v6wWZLbuja3uN7BgL6qRSnuylyii
 a9uDLiAUm0lnMoxOYrDE5YchEw7akgY8=
X-Received: by 2002:a2e:b98d:0:b0:2b6:a238:1970 with SMTP id
 p13-20020a2eb98d000000b002b6a2381970mr2486113ljp.16.1688104940537; 
 Thu, 29 Jun 2023 23:02:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4eAok/9nJ5+Mt/mgl/gs/+DcCcmk5doxtKNkqvILo6uSFp31ocAU/mps2jc++yfJg0AsoreOBIXznE+Xd7cv8=
X-Received: by 2002:a2e:b98d:0:b0:2b6:a238:1970 with SMTP id
 p13-20020a2eb98d000000b002b6a2381970mr2486110ljp.16.1688104940222; Thu, 29
 Jun 2023 23:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230609072748.4179873-1-lvivier@redhat.com>
In-Reply-To: <20230609072748.4179873-1-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jun 2023 14:02:09 +0800
Message-ID: <CACGkMEvFQcvcf=2on_Jxd5NaLSiECr_vkibVuJ8Edcb9Y4fEpg@mail.gmail.com>
Subject: Re: [PATCH 0/3] net: socket: do not close file descriptor if it's not
 a socket
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <dgibson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 9, 2023 at 3:28=E2=80=AFPM Laurent Vivier <lvivier@redhat.com> =
wrote:
>
> The socket netdev with a file descriptor (fd) cannot be removed
> and then added again because the fd is closed when the backend is
> removed and thus is not available anymore when we want to add the
> backend again.
>
> But this can bring to a core dump:
> 1- boot a VM with an fd socket netdev
> 2- remove the netdev
> 3- reboot
> 4- add the netdev again, it fails because the fd is not a
>    socket, and then closed
> 5- stop QEMU -> core dump
>
> On reboot (step 3) the fd is allocated to another use in QEMU, and when
> we try to use it with a socket netdev, it fails. But the netdev backend
> closes the file descriptor that is in use by another part of QEMU.
> We can see the core dump on QEMU exit because it tries to close
> an invalid file descriptor.
>
> It happens for instance when we have a PCI device and the fd is allocated
> to a VirtIOIRQFD on reboot.
>
> Moreover, using "netdev socket,fd=3DX" allows an user to close any QEMU
> internal file descriptor from an HMP or QMP interface.
>
> Laurent Vivier (3):
>   net: socket: prepare to cleanup net_init_socket()
>   net: socket: move fd type checking to its own function
>   net: socket: remove net_init_socket()
>
>  net/socket.c | 53 +++++++++++++++++++++++++++-------------------------
>  1 file changed, 28 insertions(+), 25 deletions(-)

Queued.

Thanks

>
> --
> 2.39.2
>
>


