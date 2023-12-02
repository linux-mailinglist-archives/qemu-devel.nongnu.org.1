Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78534801E8C
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 22:00:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9X4j-00086N-6s; Sat, 02 Dec 2023 15:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r9X4g-000868-UW
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 15:58:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r9X4f-00005A-4U
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 15:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701550730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1flwtrAM7rThkoBstSzlBCIYJsmzakCF6vCmgssTGNY=;
 b=AKjrc3L4D/MW8MDtCZ82mM6WwHs6jPhZNMXGALLKiwIIz1dcIvTAPo+pdqNrGfOQs+Zmvv
 wL4EdZtdiRbvyv2tETf2/SHon79YBhBsoNLm/bBsH/Znx2hedNPLRS4KfEe9nkDD2rgztV
 2G0g7hhDrV+WRCmC6uDdlbfyB1t0eig=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-uRoyFsuRNBS5U3nX5k7UAA-1; Sat, 02 Dec 2023 15:58:49 -0500
X-MC-Unique: uRoyFsuRNBS5U3nX5k7UAA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33335c6d495so752889f8f.2
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 12:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701550727; x=1702155527;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1flwtrAM7rThkoBstSzlBCIYJsmzakCF6vCmgssTGNY=;
 b=s2ZdHBEdyNuuQLI9j5Hugp/ARgrfNpBOmH1DjPmgI2tE5P5qNhPTc4hAMalHd3sA+Z
 KAP3YnrQY/dVC8jTHpvcDtjc9LW4BOrZ+So2J88jRQkWmPGe/EzlAj9ZseOC0ADjYMOg
 Lj9ozMgvbOwDFJFmyDOygLU3VZ34TNKee9K7x55Ue8B38YNrHD87kUE0XdQebDgS6HDy
 Pq4bo9W0OH8BotNKQtU+dFcZ0IBxWz0YfKgIOW1RNUEXiz1t9rt1F5DiPSIZGz1Z+c2+
 9oAr7B/K5CQmSZZu1jKni1Hr2Xo2PB6WmiSxKOBsxem06BjeCy9xpVlyM0ZHPKsnZb8j
 wwiw==
X-Gm-Message-State: AOJu0Ywh1dcSVyTQRgQyKg6gNiqKEbLx4A1WmMFdSHD2x1L/Vg09sjp9
 Lu6/TvY0Jfk/QCBHw6XNTa+9A/JwoUquA7Bdx6hGxPO4ZUV72rxvjLNMvgHEQW82S1LxIBaufZD
 0st+9mieBtKVcu6hBi3H9Ev4Hv/wxr48LKtSqRos0o7TOcop85RDa7goFIl2fWw/jpc5r
X-Received: by 2002:a5d:65d0:0:b0:333:145e:d820 with SMTP id
 e16-20020a5d65d0000000b00333145ed820mr1911298wrw.39.1701550727583; 
 Sat, 02 Dec 2023 12:58:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGG7iGbgdwz6+aygMAkXrGiklKzl1zbp1Xde2n7fEZALACBLqlBw80XGct7UhH4QDSvRrWPAA==
X-Received: by 2002:a5d:65d0:0:b0:333:145e:d820 with SMTP id
 e16-20020a5d65d0000000b00333145ed820mr1911294wrw.39.1701550727201; 
 Sat, 02 Dec 2023 12:58:47 -0800 (PST)
Received: from redhat.com ([2.55.11.133]) by smtp.gmail.com with ESMTPSA id
 k9-20020adfe3c9000000b0033339027c89sm2712812wrm.108.2023.12.02.12.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Dec 2023 12:58:46 -0800 (PST)
Date: Sat, 2 Dec 2023 15:58:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/15] virtio,pc,pci: fixes
Message-ID: <20231202155758-mutt-send-email-mst@kernel.org>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Dec 01, 2023 at 12:15:11PM -0500, Michael S. Tsirkin wrote:
> We have a reported regression because of the switch to
> smbios 3.0, and maybe need to revert that, but Igor asked
> for a bit more time to investigate.
> 
> The following changes since commit abf635ddfe3242df907f58967f3c1e6763bbca2d:
> 
>   Update version for v8.2.0-rc2 release (2023-11-28 16:31:16 -0500)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to d4ad718733df4c87b9133bb57ea77b0040923541:

95e1019a4a9b4b6e2caeb3fd392525e522a747db now - teaked some tags

>   vhost-user-scsi: free the inflight area when reset (2023-12-01 12:01:45 -0500)
> 
> ----------------------------------------------------------------
> virtio,pc,pci: fixes
> 
> Fixes all over the place
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------



> Akihiko Odaki (1):
>       pcie_sriov: Remove g_new assertion
> 
> Ani Sinha (1):
>       tests/acpi/bios-tables-test: do not write new blobs unless there are changes
> 
> Daniel Hoffman (1):
>       hw/i386: fix short-circuit logic with non-optimizing builds
> 
> Eric Auger (1):
>       virtio-iommu: Remove useless !sdev check in virtio_iommu_probe()
> 
> Li Feng (2):
>       vhost-user: fix the reconnect error
>       vhost-user-scsi: free the inflight area when reset
> 
> Manos Pitsidianakis (2):
>       virtio-snd: check AUD_register_card return value
>       virtio-sound: add realize() error cleanup path
> 
> Michael S. Tsirkin (2):
>       osdep: add getloadavg
>       netdev: set timeout depending on loadavg
> 
> Philippe Mathieu-Daudé (1):
>       hw/acpi/erst: Do not ignore Error* in realize handler
> 
> Robert Hoo (1):
>       msix: unset PCIDevice::msix_vector_poll_notifier in rollback
> 
> Volker Rümelin (3):
>       hw/audio/virtio-snd-pci: fix the PCI class code
>       hw/audio/hda-codec: fix multiplication overflow
>       hw/audio/hda-codec: reenable the audio mixer
> 
>  include/qemu/osdep.h           | 10 ++++++++++
>  hw/acpi/erst.c                 | 10 ++++++++++
>  hw/audio/hda-codec.c           | 41 ++++++++++++++++++++++++++--------------
>  hw/audio/virtio-snd-pci.c      |  2 ++
>  hw/audio/virtio-snd.c          | 43 ++++++++++++++++++++++++------------------
>  hw/block/vhost-user-blk.c      |  8 +++-----
>  hw/i386/x86.c                  | 15 ++++++++++++---
>  hw/pci/msix.c                  |  1 +
>  hw/pci/pcie_sriov.c            |  1 -
>  hw/scsi/vhost-user-scsi.c      | 19 ++++++++++++++++++-
>  hw/virtio/vhost-user-gpio.c    |  3 ++-
>  hw/virtio/virtio-iommu.c       |  3 ---
>  hw/virtio/virtio.c             |  2 +-
>  tests/qtest/bios-tables-test.c | 14 +++++++++++++-
>  tests/qtest/netdev-socket.c    | 28 ++++++++++++++++++++++++++-
>  meson.build                    |  1 +
>  16 files changed, 152 insertions(+), 49 deletions(-)
> 


