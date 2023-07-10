Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D2074D910
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:32:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrvU-000739-52; Mon, 10 Jul 2023 10:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qIrv7-000726-RA
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:31:37 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qIruz-0006VT-Oo
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:31:16 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b717e9d423so19572411fa.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688999471; x=1691591471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7BnYYVbqCZbCImwv26l4xwUgYElEOPqCXBIFNONq+aw=;
 b=F/wfsQj4golORjNTs+RSjryAf+mMSkwbp8LdyJV7fFNg/o5cMZUhIWyQI0/gBtD7vr
 9kqaFOLp7Txl+OC1DlAFdNwC/O6hTMtS4XVliKkbrPPfqwS5l1EGrqnUGBf1IqZU8Q1E
 XgGzywRS3EOTUEMDK9zAAc5S6yhAEAE1BrHK93l9npcnKpStQzeljynOBab/gA7sZkp1
 aJAivDNI+dvgM2XaQu5z/WUPHTkkgVzaIbfwD7yrT7VD0T3si3NSOKlIaqPnRUvqmdm0
 ClfzYw0+0FRbnCq06jyT9ZcSPEFQElZKJwpiHguZhGZu4YNUttg86SuEkqeTLKbAhwjq
 wtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688999471; x=1691591471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7BnYYVbqCZbCImwv26l4xwUgYElEOPqCXBIFNONq+aw=;
 b=ixujDJ5X3RB8jX81GiOKN82aEnM5eta8qTN5LwfmP/H9G4DhLQRBwK/TC11+eiNwsn
 DNCn8xlSFAA/cAHp0zesX/boCM6saAnVs70T6LzmC0yM4NLpd/HOReLF50pPJ7CokW0a
 di3IoCVHpYSgSOfh1GUHrVq6zuYgT9WAeGUBVQV+cAQF3ttwbG+Lc+6EluQNCWdwNUTS
 dT77ZC+Rmh1/ENUwmxLqxS2P9WrmgKI6O9BXAceVIPSZPgWiTDuUOpV/HEwD0wrBJdbM
 Acvi69rWNfMTFfHj4fC0uOQ5uFfTBoKz8Xt7OQ4jQBQEwfuTUAZrGFbOKKcBVSe1kkQu
 0/ww==
X-Gm-Message-State: ABy/qLZfHPeqJUiMY1bqzW7uBIq5JKHHK8l39oy/w89EVplxQMGmgmHg
 AB1AztAb6qBHVWcmFAoQ6aURrKeq5KUkm45Z+gUThw==
X-Google-Smtp-Source: APBJJlEVT59iWIhNHygWUpZ9MFAhouQZ1xvhI/DMzQtAaZg749nZ2VUIKiPR3DqlEZ81OTb0/t5n0mhKRRiXeUzGBHA=
X-Received: by 2002:a05:651c:2059:b0:2b6:dbb3:65a0 with SMTP id
 t25-20020a05651c205900b002b6dbb365a0mr6197565ljo.3.1688999471253; Mon, 10 Jul
 2023 07:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230626091258.24453-1-viktor@daynix.com>
 <CAPv0NP5LrA4XzG8xOsQj=7BHJdd=dJf5QMLCf-r6PyWtx4X6hg@mail.gmail.com>
In-Reply-To: <CAPv0NP5LrA4XzG8xOsQj=7BHJdd=dJf5QMLCf-r6PyWtx4X6hg@mail.gmail.com>
From: Viktor Prutyanov <viktor@daynix.com>
Date: Mon, 10 Jul 2023 17:31:00 +0300
Message-ID: <CAPv0NP46EK1qZPLPKgGxupozXXgV1EXiUxQEG2omQY7cQJYw5A@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] vhost: register and change IOMMU flag depending on
 ATS state
To: mst@redhat.com, jasowang@redhat.com
Cc: qemu-devel@nongnu.org, yan@daynix.com, yuri.benditovich@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::235;
 envelope-from=viktor@daynix.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ping

On Mon, Jul 3, 2023 at 11:25=E2=80=AFAM Viktor Prutyanov <viktor@daynix.com=
> wrote:
>
> On Mon, Jun 26, 2023 at 12:13=E2=80=AFPM Viktor Prutyanov <viktor@daynix.=
com> wrote:
> >
> > When IOMMU and vhost are enabled together, QEMU tracks IOTLB or
> > Device-TLB unmap events depending on whether Device-TLB is enabled. But
> > even if Device-TLB and PCI ATS is enabled, the guest can reject to use
> > it. For example, this situation appears when Windows Server 2022 is
> > running with intel-iommu with device-iotlb=3Don and virtio-net-pci with
> > vhost=3Don. The guest implies that no address translation info cached i=
n
> > device IOTLB and doesn't send device IOTLB invalidation commands. So,
> > it leads to irrelevant address translations in vhost-net in the host
> > kernel. Therefore network frames from the guest in host tap interface
> > contains wrong payload data.
> >
> > This series adds checking of ATS state for proper unmap flag register
> > (IOMMU_NOTIFIER_UNMAP or IOMMU_NOTIFIER_DEVIOTLB_UNMAP).
> >
> > Tested on Windows Server 2022, Windows 11 and Fedora guests with
> >  -device virtio-net-pci,bus=3Dpci.3,netdev=3Dnd0,iommu_platform=3Don,at=
s=3Don
> >  -netdev tap,id=3Dnd0,ifname=3Dtap1,script=3Dno,downscript=3Dno,vhost=
=3Don
> >  -device intel-iommu,intremap=3Don,eim=3Don,device-iotlb=3Don/off
> > Tested on Fedora guest with
> >  -device virtio-iommu
> >
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2001312
> >
> > v5: add vhost_toggle_device_iotlb to vhost-stub
> > v4: call vhost_toggle_device_iotlb regardless of vhost backend,
> >     move vhost_started check to generic part
> > v3: call virtio_pci_ats_ctrl_trigger directly, remove
> >     IOMMU_NOTIFIER_UNMAP fallbacks
> > v2: remove memory_region_iommu_notify_flags_changed, move trigger to
> >     VirtioDeviceClass, use vhost_ops, use device_iotlb name
> >
> > Viktor Prutyanov (2):
> >   vhost: register and change IOMMU flag depending on Device-TLB state
> >   virtio-net: pass Device-TLB enable/disable events to vhost
> >
> >  hw/net/virtio-net.c       |  1 +
> >  hw/virtio/vhost-stub.c    |  4 ++++
> >  hw/virtio/vhost.c         | 38 ++++++++++++++++++++++++++------------
> >  include/hw/virtio/vhost.h |  1 +
> >  4 files changed, 32 insertions(+), 12 deletions(-)
> >
> > --
> > 2.21.0
> >
>
> ping

