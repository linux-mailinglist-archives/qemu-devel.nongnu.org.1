Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C860A3EC78
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Feb 2025 07:03:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlM7S-0003uj-Gr; Fri, 21 Feb 2025 01:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tlM7O-0003uU-0a; Fri, 21 Feb 2025 01:02:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tlM7K-0008VW-JN; Fri, 21 Feb 2025 01:02:33 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 04EF45C591A;
 Fri, 21 Feb 2025 06:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB70C4CEE2;
 Fri, 21 Feb 2025 06:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740117746;
 bh=ZuJRxKQJmNRmvEj2+idQ2Nspe3fIJitS8x63hFXCTOo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=PKm/wg2Nl0nJCSD9dhbsIv/Qv99zhl4dhOHx1o1NZDN9HlCepzsVTqpjSaWY/dt31
 /v/9TaGgpad39OygRel0Q2XixAF0Zdp8/FwyPUtrPLZDGF0rC4/0K0Fy6UpVRoRxbZ
 xurFnsvc9G9mUA/2baw1C+pVLsG8+HUOWg/izdBnaeqP31SRRnmPLoIkQ+yQRhIhu+
 I6HKHkI7sv1HjfSn2h11Xa1u6TJYT6kuE0YbMF316czrdORdJ/0iUnJ3A6DVYEkYQe
 RLpiuNLhqMm/mHjb36o4j7lIWkRKpFEPjCcYaSoMv+PtAf1CfbDil4Y8VbpimnFcOS
 rOPXOIBeMeUwg==
Date: Fri, 21 Feb 2025 07:02:21 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/14] acpi/ghes: Use HEST table offsets when
 preparing GHES records
Message-ID: <20250221070221.329bdfb0@foz.lan>
In-Reply-To: <20250203153423.3e4de17c@imammedo.users.ipa.redhat.com>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
 <9610ff88cf6fdc59cbfc8871d653fd890391be1e.1738345063.git.mchehab+huawei@kernel.org>
 <20250203153423.3e4de17c@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Mon, 3 Feb 2025 15:34:23 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Fri, 31 Jan 2025 18:42:44 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > There are two pointers that are needed during error injection:
> > 
> > 1. The start address of the CPER block to be stored;
> > 2. The address of the ack.
> > 
> > It is preferable to calculate them from the HEST table.  This allows
> > checking the source ID, the size of the table and the type of the
> > HEST error block structures.
> > 
> > Yet, keep the old code, as this is needed for migration purposes.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/ghes.c         | 132 ++++++++++++++++++++++++++++++++++++-----
> >  include/hw/acpi/ghes.h |   1 +
> >  2 files changed, 119 insertions(+), 14 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index 27478f2d5674..8f284fd191a6 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -41,6 +41,12 @@
> >  /* Address offset in Generic Address Structure(GAS) */
> >  #define GAS_ADDR_OFFSET 4
> >  
> > +/*
> > + * ACPI spec 1.0b
> > + * 5.2.3 System Description Table Header
> > + */
> > +#define ACPI_DESC_HEADER_OFFSET     36
> > +
> >  /*
> >   * The total size of Generic Error Data Entry
> >   * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> > @@ -61,6 +67,25 @@
> >   */
> >  #define ACPI_GHES_GESB_SIZE                 20
> >  
> > +/*
> > + * Offsets with regards to the start of the HEST table stored at
> > + * ags->hest_addr_le,  
> 
> If I read this literary, then offsets above are not what
> declared later in this patch.
> I'd really drop this comment altogether as it's confusing,
> and rather get variables/macro naming right
> 
> > according with the memory layout map at
> > + * docs/specs/acpi_hest_ghes.rst.
> > + */  
> 
> what we need is update to above doc, describing new and old ways.
> a separate patch.

I can't see anything that should be changed at
docs/specs/acpi_hest_ghes.rst, as this series doesn't change the
firmware layout: we're still using two firmware tables:

- etc/acpi/tables, with HEST on it;
- etc/hardware_errors, with:
	- error block addresses;
	- read_ack registers;
	- CPER records.

The only changes that this series introduce are related to how
the error generation logic navigates between HEST and hw_errors
firmware. This is not described at acpi_hest_ghes.rst, and both
ways follow ACPI specs to the letter.

The only difference is that the code which populates the CPER
record and the error/read offsets doesn't require to know how
the HEST table generation placed offsets, as it will basically
reproduce what OSPM firmware does when handling	HEST events.

Thanks,
Mauro

