Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6FAA79527
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Apr 2025 20:35:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u02vY-0007nV-NE; Wed, 02 Apr 2025 14:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasha.tatashin@soleen.com>)
 id 1u02vW-0007mP-0o
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 14:35:02 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pasha.tatashin@soleen.com>)
 id 1u02vS-0002Hd-J7
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 14:35:00 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4774193fdffso687661cf.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1743618897; x=1744223697;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNl0q6evdV5xRsuU2Vf0jWdZxdKiEYW9cgQ6bPtYH/Q=;
 b=VX+6cPut0JBREBaVq3iLI9IRpp6c2+LTebX1NprPrDhQdS4TCCJwDI4qxlS1oDFYXa
 yg4c1Blsq6yxE4MFCKf644UMxx56MvIfe2uD7asBsLkT9irBeioL2S36OiD2ctoXI7Eq
 EbYkSU/Uwpss1icazSSGtT63OnH2l+vs0YqCdJxMcbEIghski+srYUoiFOCqTJYjHIb+
 FW1P94tzTgMq4YKTrAiLuHBg+rPztTrzjC2hLDM3e/TP4PBNzHqjTqrUDBkaPN7cRMSa
 fBxPpSuE1xCgIYph+t1gr0uOkBWMvgW2OBcghnddpgofsmmQL2GYho1hM6lYl8SSL2Fb
 ZOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743618897; x=1744223697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNl0q6evdV5xRsuU2Vf0jWdZxdKiEYW9cgQ6bPtYH/Q=;
 b=l2RLGWQ9nrKpCuLwNJFaiwqmRzVA8TX24F44IPrceC5EnNulzwX7btcRAZvPLgQp6J
 XV+0YfFQRCjWeoXc5N7qHZpihwm4ShOAXlK28GiU9viWh9bLziG6J+31qary25BceR1l
 O8ACA1zpaonUfx2bXRr6yNz3ESv/G7/0D650hnC3dnyOdV4Qu6dS4YbyAm+hgDz0ylYy
 S/QhtJp1+Km0POyhH6oLb2OSiDOwkTCEPuvuygoc3IE4Fvj7Xc8QE1NLv0DGbBrCq2MY
 tM8/isYCMZFIkYF6LXx2KCVbVdA3ACddg8tppyVL0P6MQ39T2Slts1WUKThXJXlr+VSp
 sVUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUovsnrFzuQHoPvJGVpagsqtQN9SrxsYF2xiCyHbWgjOzQ0VeaBrw0LVW/2Ms9st2aCBaP3RN3sXAeD@nongnu.org
X-Gm-Message-State: AOJu0YykBZ9NizaQ+5YZuDbAbgL2dc/qUX3XfdhI760XzYUGhhJoMC6/
 diSen4mn69AyxRDNsTcy/TRLUdTHhAg7au1auoGUwbom1TEHljQen6Z71wAk5RWCWeIB+OJP4Rm
 KAaCyWWIi3NlG+dqJTr2SzZyKg8K+Nevod0kgQw==
X-Gm-Gg: ASbGncvYiBJ0zZDclKpo23at3wk2/M1HombuM64mnRkWuNDuHsOh6DXwYoDu5P994Qa
 hQXKdt9DLSlkkWOnwTC2uXfYZ5Wi5WE2a0xQCZVR45TzrTP1zzOFJwETskryXewV4OblFD86loC
 WRnFWVUF/RsfmwIdi+Xl2c0Z4=
X-Google-Smtp-Source: AGHT+IGoVpIt4mr4VkY68hF3irtPh4CJ5sDWbyyHNDDsAPgPIs44WAor/0UEuvrIMM/0gK4sK3q3nBFlBPPBsAkahDk=
X-Received: by 2002:ac8:7f82:0:b0:476:7327:383d with SMTP id
 d75a77b69052e-477e4ae5875mr216706351cf.9.1743618896664; Wed, 02 Apr 2025
 11:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
In-Reply-To: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 2 Apr 2025 14:34:18 -0400
X-Gm-Features: AQ5f1Jr_zDi6o8LxPJW9DwULyLr5ZxWziy735c-tNJKHfxxa7jpz3wGOjQkpWEI
Message-ID: <CA+CK2bBcU2y7jMc8tQ5+Gx39L-3QB3zm74bjdOvAC+EcT8Xc3g@mail.gmail.com>
Subject: Re: [PATCH for-10.1 v9 0/9] virtio-net: add support for SR-IOV
 emulation
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 devel@daynix.com, Yui Washizu <yui.washidu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=pasha.tatashin@soleen.com; helo=mail-qt1-x831.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 14, 2025 at 2:15=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Based-on: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
> ("[PATCH v18 00/14] hw/pci: SR-IOV related fixes and improvements")
>
> Introduction
> ------------
>
> This series is based on the RFC series submitted by Yui Washizu[1].
> See also [2] for the context.
>
> This series enables SR-IOV emulation for virtio-net. It is useful
> to test SR-IOV support on the guest, or to expose several vDPA devices
> in a VM. vDPA devices can also provide L2 switching feature for
> offloading though it is out of scope to allow the guest to configure
> such a feature.

I have been using these patches for live update orchestrator
development work. Having virtualized SR-IOV helps tremendously.

Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>

>
> The PF side code resides in virtio-pci. The VF side code resides in
> the PCI common infrastructure, but it is restricted to work only for
> virtio-net-pci because of lack of validation.
>
> User Interface
> --------------
>
> A user can configure a SR-IOV capable virtio-net device by adding
> virtio-net-pci functions to a bus. Below is a command line example:
>   -netdev user,id=3Dn -netdev user,id=3Do
>   -netdev user,id=3Dp -netdev user,id=3Dq
>   -device pcie-root-port,id=3Db
>   -device virtio-net-pci,bus=3Db,addr=3D0x0.0x3,netdev=3Dq,sriov-pf=3Df
>   -device virtio-net-pci,bus=3Db,addr=3D0x0.0x2,netdev=3Dp,sriov-pf=3Df
>   -device virtio-net-pci,bus=3Db,addr=3D0x0.0x1,netdev=3Do,sriov-pf=3Df
>   -device virtio-net-pci,bus=3Db,addr=3D0x0.0x0,netdev=3Dn,id=3Df
>
> The VFs specify the paired PF with "sriov-pf" property. The PF must be
> added after all VFs. It is user's responsibility to ensure that VFs have
> function numbers larger than one of the PF, and the function numbers
> have a consistent stride.
>
> Keeping VF instances
> --------------------
>
> A problem with SR-IOV emulation is that it needs to hotplug the VFs as
> the guest requests. Previously, this behavior was implemented by
> realizing and unrealizing VFs at runtime. However, this strategy does
> not work well for the proposed virtio-net emulation; in this proposal,
> device options passed in the command line must be maintained as VFs
> are hotplugged, but they are consumed when the machine starts and not
> available after that, which makes realizing VFs at runtime impossible.
>
> As an strategy alternative to runtime realization/unrealization, this
> series proposes to reuse the code to power down PCI Express devices.
> When a PCI Express device is powered down, it will be hidden from the
> guest but will be kept realized. This effectively implements the
> behavior we need for the SR-IOV emulation.
>
> Summary
> -------
>
> Patch 1 disables ROM BAR, which virtio-net-pci enables by default, for
> VFs.
> Patch 2 makes zero stride valid for 1 VF configuration.
> Patch 3 and 4 adds validations.
> Patch 5 adds user-created SR-IOV VF infrastructure.
> Patch 6 makes virtio-pci work as SR-IOV PF for user-created VFs.
> Patch 7 allows user to create SR-IOV VFs with virtio-net-pci.
>
> [1] https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu=
@gmail.com/
> [2] https://lore.kernel.org/all/5d46f455-f530-4e5e-9ae7-13a2297d4bc5@dayn=
ix.com/
>
> Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v9:
> - Rebased.
> - Link to v8: https://lore.kernel.org/r/20250104-sriov-v8-0-56144cfdc7d9@=
daynix.com
>
> Changes in v8:
> - Rebased.
> - Link to v7: https://lore.kernel.org/r/20240813-sriov-v7-0-8515e3774df7@=
daynix.com
>
> Changes in v7:
> - Removed #include <error-report.h>, which is no longer needed.
> - Rebased.
> - Link to v6: https://lore.kernel.org/r/20240802-sriov-v6-0-0c8ff49c4276@=
daynix.com
>
> Changes in v6:
> - Added ARI extended capability.
> - Rebased.
> - Link to v5: https://lore.kernel.org/r/20240715-sriov-v5-0-3f5539093ffc@=
daynix.com
>
> Changes in v5:
> - Dropped the RFC tag.
> - Fixed device unrealization.
> - Rebased.
> - Link to v4: https://lore.kernel.org/r/20240428-sriov-v4-0-ac8ac6212982@=
daynix.com
>
> Changes in v4:
> - Added patch "hw/pci: Fix SR-IOV VF number calculation" to fix division
>   by zero reported by Yui Washizu.
> - Rebased.
> - Link to v3: https://lore.kernel.org/r/20240305-sriov-v3-0-abdb75770372@=
daynix.com
>
> Changes in v3:
> - Rebased.
> - Link to v2: https://lore.kernel.org/r/20231210-sriov-v2-0-b959e8a6dfaf@=
daynix.com
>
> Changes in v2:
> - Changed to keep VF instances.
> - Link to v1: https://lore.kernel.org/r/20231202-sriov-v1-0-32b3570f7bd6@=
daynix.com
>
> ---
> Akihiko Odaki (9):
>       hw/pci: Do not add ROM BAR for SR-IOV VF
>       hw/pci: Fix SR-IOV VF number calculation
>       pcie_sriov: Ensure PF and VF are mutually exclusive
>       pcie_sriov: Check PCI Express for SR-IOV PF
>       pcie_sriov: Allow user to create SR-IOV device
>       virtio-pci: Implement SR-IOV PF
>       virtio-net: Implement SR-IOV VF
>       docs: Document composable SR-IOV device
>       pcie_sriov: Make a PCI device with user-created VF ARI-capable
>
>  MAINTAINERS                    |   1 +
>  docs/system/index.rst          |   1 +
>  docs/system/sriov.rst          |  37 ++++++
>  include/hw/pci/pci_device.h    |   6 +-
>  include/hw/pci/pcie_sriov.h    |  21 +++
>  include/hw/virtio/virtio-pci.h |   1 +
>  hw/pci/pci.c                   |  76 +++++++----
>  hw/pci/pcie_sriov.c            | 294 +++++++++++++++++++++++++++++++++--=
------
>  hw/virtio/virtio-net-pci.c     |   1 +
>  hw/virtio/virtio-pci.c         |  24 +++-
>  10 files changed, 378 insertions(+), 84 deletions(-)
> ---
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> change-id: 20231202-sriov-9402fb262be8
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>

