Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE6A9E4F93
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Dec 2024 09:19:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ750-0000Cx-Hk; Thu, 05 Dec 2024 03:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJ74x-0000Bu-Vo; Thu, 05 Dec 2024 03:19:20 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tJ74w-00046e-88; Thu, 05 Dec 2024 03:19:19 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 61F17A420AE;
 Thu,  5 Dec 2024 08:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74755C4CED1;
 Thu,  5 Dec 2024 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733386756;
 bh=JhiphLgWiCNfU2elVpuwBoY3t+FHsdzdxyELcgnhNNI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ed/a/koEM7nuMGLarG44D9RLXHxcLryGUfOLiuP8BxrlWBK0XjjxHncEkZatuuVYx
 XXdUUf2pd/V9Ed2JvRSa51z9g/lbDlPltAkIMKDe9/irTfAhrGCdDynO7BbogtGq4b
 d97z8ebzyBTzL/yezLGrvM5z5eAYlQDsOJG8boLGcl5+hBjd7SZjOkJkZv/Eu4kU+S
 BC2UFVhMu9aoXdQeyx8etMdljW7rIeGopkry93cs0rIZL1AWDUe/wiWTOyjqoPZbny
 +Ccbq54CF5gcgoq1HA+vXvVPSy6wZt+jMMH8bSpA2am0pRI2ilEdPjDdmIfk7y00k6
 CR/cMzP+9QVhA==
Date: Thu, 5 Dec 2024 09:19:09 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v5 10/16] acpi/ghes: better name GHES memory error function
Message-ID: <20241205091909.66f803c5@foz.lan>
In-Reply-To: <20241204174025.52e3756a@imammedo.users.ipa.redhat.com>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
 <1f16080ef9848dacb207ffdbb2716b1c928d8fad.1733297707.git.mchehab+huawei@kernel.org>
 <20241204174025.52e3756a@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Wed, 4 Dec 2024 17:40:25 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Wed,  4 Dec 2024 08:41:18 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The current function used to generate GHES data is specific for
> > memory errors. Give a better name for it, as we now have a generic
> > function as well.
> > 
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> not that it matters but for FYI
> Sign off of author goes 1st and then after it other tags
> that were added later

Yes, that's what I usually do, when I'm using my developer's hat. 
Placing reviews before SoB is what I do with my maintainer's hat
at the Kernel :-)

I'll address it for the next (and hopefully final) version.

> 
> > ---
> >  hw/acpi/ghes-stub.c    | 2 +-
> >  hw/acpi/ghes.c         | 2 +-
> >  include/hw/acpi/ghes.h | 4 ++--
> >  target/arm/kvm.c       | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> > index 2b64cbd2819a..7cec1812dad9 100644
> > --- a/hw/acpi/ghes-stub.c
> > +++ b/hw/acpi/ghes-stub.c
> > @@ -11,7 +11,7 @@
> >  #include "qemu/osdep.h"
> >  #include "hw/acpi/ghes.h"
> >  
> > -int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> > +int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
> >  {
> >      return -1;
> >  }
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index 4b5332f8c667..414a4a1ee00e 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -415,7 +415,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> >      return;
> >  }
> >  
> > -int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> > +int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
> >  {
> >      /* Memory Error Section Type */
> >      const uint8_t guid[] =
> > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > index 8859346af51a..21666a4bcc8b 100644
> > --- a/include/hw/acpi/ghes.h
> > +++ b/include/hw/acpi/ghes.h
> > @@ -74,15 +74,15 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> >                       const char *oem_id, const char *oem_table_id);
> >  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
> >                            GArray *hardware_errors);
> > +int acpi_ghes_memory_errors(uint16_t source_id, uint64_t error_physical_addr);
> >  void ghes_record_cper_errors(const void *cper, size_t len,
> >                               uint16_t source_id, Error **errp);
> > -int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
> >  
> >  /**
> >   * acpi_ghes_present: Report whether ACPI GHES table is present
> >   *
> >   * Returns: true if the system has an ACPI GHES table and it is
> > - * safe to call acpi_ghes_record_errors() to record a memory error.
> > + * safe to call acpi_ghes_memory_errors() to record a memory error.
> >   */
> >  bool acpi_ghes_present(void);
> >  #endif
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 7b6812c0de2e..b4260467f8b9 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -2387,7 +2387,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> >               */
> >              if (code == BUS_MCEERR_AR) {
> >                  kvm_cpu_synchronize_state(c);
> > -                if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
> > +                if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
> >                      kvm_inject_arm_sea(c);
> >                  } else {
> >                      error_report("failed to record the error");  
> 



Thanks,
Mauro

