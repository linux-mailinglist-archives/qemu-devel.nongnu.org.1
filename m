Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EC87ABAB8
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 22:57:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjnCc-0005Np-1Y; Fri, 22 Sep 2023 16:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qjnCZ-0005Ng-PR
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 16:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qjnCY-00051B-3i
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 16:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695416197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWAOP3CbJ/07K4yiik6OFmQrO/zwE7mV2TLrJCQE//Y=;
 b=WSnsra5KwfAHPkxoWFUW955wypVWPfbwBmobBBB9kqiU1RzUNJqU1NwVJ50pnNQUdS7aw2
 eEGZPE2rBBVXoJyuC22UM8T+LMuxpmK9LM1hwb4Ur1zHs5dgurbGYI20fchuskCjBHH25z
 r62McXMUzwudeP2WlD5KTWLoGjEDdxI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-_OZECsOQMwqNjWhOS99hAA-1; Fri, 22 Sep 2023 16:56:35 -0400
X-MC-Unique: _OZECsOQMwqNjWhOS99hAA-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7983537d6c1so206657739f.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 13:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695416194; x=1696020994;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MWAOP3CbJ/07K4yiik6OFmQrO/zwE7mV2TLrJCQE//Y=;
 b=tjneSXqzznu6i3ACO9ENU0AdjfHeMY8WACNgMiT+o1XewSO9C/mPZ5W2F0BENNWrJr
 b830JukvvZ1vMsd8DxBwr2Li2YrtfKKg67Fbr15ZNcky7mV0nJhT6IjqVcVu+0ePvala
 EZENqchNoRj/JqMfz81pzoePz2U5F10vmFhnGnH4vPm4RKvIed2ACiXVv3MSRhUjNqzo
 dtz5MHbNB3irn5JaBuTC2oB2dPZiRf/VGjvikOLjW6zdx4i3yQ2kUgO9pfs5jzMiYFph
 kjG30KxjuE9h1XsU4ktQHOq7F2DAyejvE8viOF9rDL3xWGbMTE9WmpQzRkjkw38QERjh
 VdDA==
X-Gm-Message-State: AOJu0YwLQ89zjHymGHnZdlAEeYJj3s/creg7A1gEJymyg7ykMfSrzzw3
 JWEY9+jp0lXBLT+gXtJzMyGLfUK9LV51Kh3tLAkghnKNkk5VljQpcwyG95gCycYNjfc5GsS0hf1
 iy8AZb4S1JXX5D3A=
X-Received: by 2002:a6b:7515:0:b0:79f:99b8:336 with SMTP id
 l21-20020a6b7515000000b0079f99b80336mr468307ioh.18.1695416194264; 
 Fri, 22 Sep 2023 13:56:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtWDlB4u84NFrynDTRnE/bJ2b82vXo+yFSP3Uhp8N/OFdj0qFqlmFcXPyO5QLbifaSg8rUZA==
X-Received: by 2002:a6b:7515:0:b0:79f:99b8:336 with SMTP id
 l21-20020a6b7515000000b0079f99b80336mr468293ioh.18.1695416193962; 
 Fri, 22 Sep 2023 13:56:33 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 g21-20020a6b6b15000000b007836c7e8dccsm1146242ioc.17.2023.09.22.13.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 13:56:33 -0700 (PDT)
Date: Fri, 22 Sep 2023 14:56:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jing Liu <jing2.liu@intel.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@linux.intel.com
Subject: Re: [PATCH v2 0/4] Support dynamic MSI-X allocation
Message-ID: <20230922145631.2bdc67dd.alex.williamson@redhat.com>
In-Reply-To: <20230918094507.409050-1-jing2.liu@intel.com>
References: <20230918094507.409050-1-jing2.liu@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Mon, 18 Sep 2023 05:45:03 -0400
Jing Liu <jing2.liu@intel.com> wrote:

> Changes since v1:
> - v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg982842.html
> - Revise Qemu to QEMU. (C=C3=A9dric)
> - Add g_free when failure of getting MSI-X irq info. (C=C3=A9dric)
> - Apply C=C3=A9dric's Reviewed-by. (C=C3=A9dric)
> - Use g_autofree to automatically release. (C=C3=A9dric)
> - Remove the failure message in vfio_enable_msix_no_vec(). (C=C3=A9dric)
>=20
> Changes since RFC v1:
> - RFC v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg978637.ht=
ml
> - Revise the comments. (Alex)
> - Report error of getting irq info and remove the trace of failure
>   case. (Alex, C=C3=A9dric)
> - Only store dynamic allocation flag as a bool type and test
>   accordingly. (Alex)
> - Move dynamic allocation detection to vfio_msix_early_setup(). (Alex)
> - Change the condition logic in vfio_msix_vector_do_use() that moving
>   the defer_kvm_irq_routing test out and create a common place to update
>   nr_vectors. (Alex)
> - Consolidate the way of MSI-X enabling during device initialization and
>   interrupt restoring that uses fd =3D -1 trick. Create a function doing
>   that. (Alex)
>=20
> Before kernel v6.5, dynamic allocation of MSI-X interrupts was not
> supported. QEMU therefore when allocating a new interrupt, should first
> release all previously allocated interrupts (including disable of MSI-X)
> and re-allocate all interrupts that includes the new one.
>=20
> The kernel series [1] adds the support of dynamic MSI-X allocation to
> vfio-pci and uses the existing flag VFIO_IRQ_INFO_NORESIZE to guide user
> space, that when dynamic MSI-X is supported the flag is cleared.
>=20
> This series makes the behavior for VFIO PCI devices when dynamic MSI-X
> allocation is supported. When guest unmasks an interrupt, QEMU can
> directly allocate an interrupt on host for this and has nothing to do
> with the previously allocated ones. Therefore, host only allocates
> interrupts for those unmasked (enabled) interrupts inside guest when
> dynamic MSI-X allocation is supported by device.
>=20
> When guests enable MSI-X with all of the vectors masked, QEMU need match
> the state to enable MSI-X with no vector enabled. During migration
> restore, QEMU also need enable MSI-X first in dynamic allocation mode,
> to avoid the guest unused vectors being allocated on host. To
> consolidate them, we use vector 0 with an invalid fd to get MSI-X
> enabled and create a common function for this. This is cleaner than
> setting userspace triggering and immediately release.
>=20
> Any feedback is appreciated.
>=20
> Jing
>=20
> [1] https://lwn.net/Articles/931679/
>=20
> Jing Liu (4):
>   vfio/pci: detect the support of dynamic MSI-X allocation
>   vfio/pci: enable vector on dynamic MSI-X allocation
>   vfio/pci: use an invalid fd to enable MSI-X
>   vfio/pci: enable MSI-X in interrupt restoring on dynamic allocation
>=20
>  hw/vfio/pci.c        | 121 +++++++++++++++++++++++++++++++++----------
>  hw/vfio/pci.h        |   1 +
>  hw/vfio/trace-events |   2 +-
>  3 files changed, 96 insertions(+), 28 deletions(-)
>=20

Some minor comments on 2/ but otherwise:

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


