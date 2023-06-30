Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F11D37433F6
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:08:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6LE-0004jI-Vx; Fri, 30 Jun 2023 01:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF6LC-0004j3-Jv
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF6L8-0004oH-7Z
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688101596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Ts0DwntxAspfmpPEOslhMOuUve65c0EWM89/wed8vA=;
 b=TQkDBGJz/T+ICWSri6shjdwR8Tvw9Lk7u7XFsNoj/gNsMemUUYWYaokcbNd9SZs3F17nzb
 VM/kveAAH52vJD1oPk0JusmdOEvjXNCkvf124hjkhcZVg1hStLgqhbuYuom8HKJDTpVpQ4
 QQsvm6UUFcTWNUUBkbJ0ETn3lALLaWU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-_r1URSyRPY6tDMXsp1rsww-1; Fri, 30 Jun 2023 01:06:35 -0400
X-MC-Unique: _r1URSyRPY6tDMXsp1rsww-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6b98ac356so13234641fa.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 22:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688101593; x=1690693593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Ts0DwntxAspfmpPEOslhMOuUve65c0EWM89/wed8vA=;
 b=RcoduGibt3pcUP4tDMp5ULV5fCIKtkB0t3Q64Gr2EGvl43NTg81uOfy+Y3evO4cBuS
 MJfH/Zk/cnQNEnGogqTtFcQPhZzCpA4sf9ygMOypSQF7gNmPb9rL1+kp4GHNqGRC58UP
 MRGgjWqkPDRWN6WHtk+fgBI245YDR/dckeY6T5Wx/9YvUsWYeZuO83tuxMw1yQAtWYZf
 iyH7YampCOLNMp9w+2yIO9o85LMj+ARCrO5ToslCVEnQhC6N8usaftxm0rOij4YQiGiC
 v+hT99Ue4O81Zo7HISIAZ2E/tF2Xeh1o4tnC9IMCB/XwUuUgkHLg/FgKnae5U5MxbLDH
 1JPQ==
X-Gm-Message-State: ABy/qLZvznPSIV3wW4ZzZVG3tGHuQPNPr0jx156NnCh4wBlylWAiUuH/
 ro2VrMOdr0c96WUWifzU8MxajhiUxtD7gtALozbPoQeq4n9p0IJ5vpxMBVIcQFxBoi+ESQzyOe+
 eWhyIKvhcCGYPvEJacMTWITP0QVOtW3k=
X-Received: by 2002:a2e:998e:0:b0:2b6:cd2d:388c with SMTP id
 w14-20020a2e998e000000b002b6cd2d388cmr1139092lji.22.1688101593508; 
 Thu, 29 Jun 2023 22:06:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZxd8gwwfyKhe+YR/GwakOAZ0nQhEQCkOnXDa7vtdJGsEKyozhXnuoqv+6yXb7RSCAvWhugKlgTVm7tOtRfl0=
X-Received: by 2002:a2e:998e:0:b0:2b6:cd2d:388c with SMTP id
 w14-20020a2e998e000000b002b6cd2d388cmr1139080lji.22.1688101593240; Thu, 29
 Jun 2023 22:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230614221026.56950-1-andrew@daynix.com>
In-Reply-To: <20230614221026.56950-1-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jun 2023 13:06:22 +0800
Message-ID: <CACGkMEsDw8sUeJB340f8cdqEFnQRXccDxq6pe+87KDzOBMHZpg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] eBPF RSS through QMP support.
To: Andrew Melnychenko <andrew@daynix.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yuri.benditovich@daynix.com, 
 yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Thu, Jun 15, 2023 at 6:29=E2=80=AFAM Andrew Melnychenko <andrew@daynix.c=
om> wrote:
>
> This series of patches provides the ability to retrieve eBPF program
> through qmp, so management application may load bpf blob with proper capa=
bilities.
> Now, virtio-net devices can accept eBPF programs and maps through propert=
ies
> as external file descriptors. Access to the eBPF map is direct through mm=
ap()
> call, so it should not require additional capabilities to bpf* calls.
> eBPF file descriptors can be passed to QEMU from parent process or by uni=
x
> socket with sendfd() qmp command.
>
> Possible solution for libvirt may look like this: https://github.com/dayn=
ix/libvirt/tree/RSS_eBPF (WIP)
>
> Changes since v2:
>  * moved/refactored QMP command
>  * refactored virtio-net

I've queued this series, but a question left:

mmap() support for eBPF maps is not supported from day0, should we
fallback to syscall for the OS that doesn't support that?

Thanks

>
> Changes since v1:
>  * refactored virtio-net
>  * moved hunks for ebpf mmap()
>  * added qmp enum for eBPF id.
>
> Andrew Melnychenko (6):
>   ebpf: Added eBPF map update through mmap.
>   ebpf: Added eBPF initialization by fds.
>   virtio-net: Added property to load eBPF RSS with fds.
>   ebpf: Added declaration/initialization routines.
>   qmp: Added new command to retrieve eBPF blob.
>   ebpf: Updated eBPF program and skeleton.
>
>  ebpf/ebpf.c                    |   70 ++
>  ebpf/ebpf.h                    |   31 +
>  ebpf/ebpf_rss-stub.c           |    6 +
>  ebpf/ebpf_rss.c                |  150 +++-
>  ebpf/ebpf_rss.h                |   10 +
>  ebpf/meson.build               |    2 +-
>  ebpf/rss.bpf.skeleton.h        | 1469 ++++++++++++++++----------------
>  hw/net/virtio-net.c            |   55 +-
>  include/hw/virtio/virtio-net.h |    1 +
>  qapi/ebpf.json                 |   55 ++
>  qapi/meson.build               |    1 +
>  qapi/qapi-schema.json          |    1 +
>  tools/ebpf/rss.bpf.c           |    2 +-
>  13 files changed, 1093 insertions(+), 760 deletions(-)
>  create mode 100644 ebpf/ebpf.c
>  create mode 100644 ebpf/ebpf.h
>  create mode 100644 qapi/ebpf.json
>
> --
> 2.39.1
>


