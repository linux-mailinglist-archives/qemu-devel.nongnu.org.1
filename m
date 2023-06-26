Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D40673E379
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:36:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoFh-0006nW-Te; Mon, 26 Jun 2023 11:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDoFW-0006k3-P4
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDoFT-0002Cz-NA
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687793726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qO4aZAlTsWFonkxrUZF2kdlhOCoPYbdMHPz2ySgunGQ=;
 b=KcMTIneou9wNZtIu9YXP+xw0UdspH8VjG5rF7ZLmq9DgkrxH9VRrHViWf3uKfIx0sJgkjB
 qhM35GtJQw1p0IVEFEkcUqjCjtVzESqbqSZ1mI4a2zZkf68ysGHK8o8u+DCnLrJ2e6Yls0
 IbY6mSgmVlqtJAnDOEgA8Nem+qLx+uY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-MJAzKG2TMvGUeGKq9inSew-1; Mon, 26 Jun 2023 11:35:23 -0400
X-MC-Unique: MJAzKG2TMvGUeGKq9inSew-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-313f59eba37so329594f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793722; x=1690385722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qO4aZAlTsWFonkxrUZF2kdlhOCoPYbdMHPz2ySgunGQ=;
 b=kKE9gCyXeGT3PpalQiH44GpmMD9Je3VF0DBx8P1KZHmT93fAEiAWynukF4b7hkL/sv
 pCKos323H283sIA/x7cAjvLle7J+PQq4mXNQrT37R8ESogd4VS697Zn7EndDkU9vPPDV
 REREtQrqaF+mHNA6id3V9z2aOaT9v/q6tZgERanOag4lQ/VepGfd6dfnBowfX7+4edDp
 EtPCIGbL1IqmGiDE9jv8p5VFYtjtb56QUOaoESlXXmhd+OuMj7i7QmpT9lrfh/eY1NSs
 9AYHNSjDrsF4MWguKGZEQTPLhWCiVp2fSvv3dA6ZZBubz3tKE27ER3Qw4efgOaIo2DBv
 JuYg==
X-Gm-Message-State: AC+VfDzhFdSDJxCY+zHJCn5bfolKqBYVmgGFwmQum+lAKDAL+8iKeSAQ
 kyNwPeiYsX0WgJecGDJl8ezhA44kx7GzQJkNptOhSvHmZBnYhrReUFqsET0jZDE3umZQDZNGMb+
 TNUSmp+QX2GNrkvI=
X-Received: by 2002:a5d:4402:0:b0:30f:bb83:e6f4 with SMTP id
 z2-20020a5d4402000000b0030fbb83e6f4mr18951502wrq.0.1687793722149; 
 Mon, 26 Jun 2023 08:35:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5PLBfll/zC81ywPNSii49qFhN0nGALVSiqrQzEb8bJvdgunDtDkr8EIJF23SpTSigbP7rrQw==
X-Received: by 2002:a5d:4402:0:b0:30f:bb83:e6f4 with SMTP id
 z2-20020a5d4402000000b0030fbb83e6f4mr18951489wrq.0.1687793721864; 
 Mon, 26 Jun 2023 08:35:21 -0700 (PDT)
Received: from redhat.com ([2.52.141.236]) by smtp.gmail.com with ESMTPSA id
 l7-20020a5d4bc7000000b003113dc327fbsm7728774wrt.22.2023.06.26.08.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:35:21 -0700 (PDT)
Date: Mon, 26 Jun 2023 11:35:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, michael.labiuk@virtuozzo.com
Subject: Re: [PATCH v4 0/5] test and QEMU fixes to ensure proper PCIE device
 usage
Message-ID: <20230626110750-mutt-send-email-mst@kernel.org>
References: <20230626135324.10687-1-anisinha@redhat.com>
 <20230626095407-mutt-send-email-mst@kernel.org>
 <97BD632C-527A-4FF7-9D49-DB298F761DEB@redhat.com>
 <B8BD1664-1BAD-4D47-AE4C-FA6C3C25EBFE@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8BD1664-1BAD-4D47-AE4C-FA6C3C25EBFE@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Mon, Jun 26, 2023 at 07:29:26PM +0530, Ani Sinha wrote:
> 
> 
> > On 26-Jun-2023, at 7:26 PM, Ani Sinha <anisinha@redhat.com> wrote:
> > 
> > 
> > 
> >> On 26-Jun-2023, at 7:24 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> 
> >> Ani, two versions a day is too much,
> > 
> > So you suggesting I slow down my CPU freq? :-) 
> 
> Btw, the libvirt guys does this better in this respect I think. The maintainer takes the patchset but if small rework in commit logs or comments etc is needed, the maintainer does this himself and pushes the patch. That way there is less churn.

I can do that too sometimes. I'm less of a dictator, prefer to get
acks from others :)

> > 
> >> pls don't unless first one
> >> has been sent by mistake or something. then explain what
> >> it was pls.
> > 
> > I did say 
> > 
> > v4: reword commit log for patch 4

Oh, missed that. it's ok then, just make this a bit more prominent:
note: no changes to patches, just commit log tweaks.

> >> 
> >> On Mon, Jun 26, 2023 at 07:23:19PM +0530, Ani Sinha wrote:
> >>> Patches 1-4:
> >>> Fix tests so that devices do not use non-zero slots on the pcie root
> >>> ports. PCIE ports only have one slot, so PCIE devices can only be
> >>> plugged into slot 0 on a PCIE port.
> >>> 
> >>> Patch 5:
> >>> Enforce only one slot on PCIE port.
> >>> 
> >>> The test fixes must be applied before the QEMU change that checks for use
> >>> of a single slot in PCIE port.
> >>> 
> >>> CC: mst@redhat.com
> >>> CC: imammedo@redhat.com
> >>> CC: jusual@redhat.com
> >>> CC: thuth@redhat.com
> >>> CC: lvivier@redhat.com
> >>> CC: michael.labiuk@virtuozzo.com
> >>> 
> >>> Changelog:
> >>> v4: reword commit log for patch 4.
> >>> v3: tags added. reword the error description in patch 5. Reword commit log in patch 4. 
> >>> v2: add hd-geo-test fix as well as the actual QEMU code fix to the patchset.
> >>> The patches are added in the right order.
> >>> 
> >>> Ani Sinha (5):
> >>> tests/acpi: allow changes in DSDT.noacpihp table blob
> >>> tests/acpi/bios-tables-test: use the correct slot on the
> >>>   pcie-root-port
> >>> tests/acpi/bios-tables-test: update acpi blob q35/DSDT.noacpihp
> >>> tests/qtest/hd-geo-test: fix incorrect pcie-root-port usage and
> >>>   simplify test
> >>> hw/pci: ensure PCIE devices are plugged into only slot 0 of PCIE port
> >>> 
> >>> hw/pci/pci.c                      |   6 ++++++
> >>> tests/data/acpi/q35/DSDT.noacpihp | Bin 8248 -> 8241 bytes
> >>> tests/qtest/bios-tables-test.c    |   4 ++--
> >>> tests/qtest/hd-geo-test.c         |  18 ++++++++----------
> >>> 4 files changed, 16 insertions(+), 12 deletions(-)
> >>> 
> >>> -- 
> >>> 2.39.1
> >> 
> > 


