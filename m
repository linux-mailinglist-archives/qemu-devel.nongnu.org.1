Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB27A21FCF
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Jan 2025 15:57:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9Tk-0003yR-5R; Wed, 29 Jan 2025 09:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td9Tf-0003xm-3O
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:55:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td9Td-0003F7-BP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738162535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmrRKA0ChyO0vLu9JTiC5ZPpN5pGEUANDOxIesc4B2Q=;
 b=jAQbLzYS1tHO//wCiUBERhb8kiUw9qhdsETLDUv4vvUMooacA9N5H5Y1bfu/x298lKYwHw
 mnZRUkimykTJbPUOfuQirCwGNZs1yZ4dr0wohMJmq3inGEkENFkdCoj98nvhjz6+IggItV
 yqqGlHpvJ4X1F3SY0LOzv2BOhFCzPHU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-vOK_7dkCO66zrHYIlC04Fw-1; Wed, 29 Jan 2025 09:55:33 -0500
X-MC-Unique: vOK_7dkCO66zrHYIlC04Fw-1
X-Mimecast-MFC-AGG-ID: vOK_7dkCO66zrHYIlC04Fw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e2579507so2948829f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 06:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738162532; x=1738767332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmrRKA0ChyO0vLu9JTiC5ZPpN5pGEUANDOxIesc4B2Q=;
 b=FG0jyeCNBzqiNc3bcJGWze7+obmSf10sog/l60KEc7e1yp98AJy0nczBbnHzliB5VM
 b76gbOGNC8nbRqyzh4SGkuFH58Dd4MJEZDOaX5Oc4Y/idzG4W5w+dsXCcyuAW/JhoOaQ
 wQLoCiEpCSv51bSDXvX87qELF0TD4P9utAMuTj/pC7LtlIvV32RzB65byWT6DUrnns+X
 RbQGZ0lzU3iEL1mwMdyzZ68lqEQTSPJwq0EodTfKUVd7Y+DWOIpU5WDMUd8IQLQt4gpC
 GnRwGkvKMUzNd8Nx5/DvCIPF0LGqqeBBrDU+7aXL4X/1MtxaAkcxhB9Iq8iZu7AThxLs
 i7yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmM1Ak1rhdbsDswkWjw6YX+qWAvLJJl8A4lGqm6wPRVhhVvNEyY5FPRRzvi6mmyZZwo2htyQUMlwEh@nongnu.org
X-Gm-Message-State: AOJu0Ywx8+s1r/7RkHcoUX27/vl6zNs53gK2b2K7u8CXkH9CX3L9zfIT
 C8UUte1UUzM8u+YcDbkCkuaZqNXp5Cz+tZ2rms6J0gvjGcm5BUC5zXcQeopIL1a22/yCM3B7Sb+
 7sTOl60z8ZJtbBLS1ehQ8Upp6qH381od9u9bK8lAMpq30Q7BkT05Y
X-Gm-Gg: ASbGncvtR5Kta8mrjq6chmsVqGRpoT4HaxGbXrteJezkBxNnuUVKonfE6auY1lp5Otx
 Sg5dW7T8XCEHoIvn1u+yOODdenlUWDjlukLyYowaHoJTbsO3emdvmj/y6Ml2PsjJgPgOj3uqtqM
 yVX46UefvJ4KtEKkmgLI4z018CSkQKZ24f/BaL0T8uZ2Po46rfmLRHNIUjSY7jfk8Dcb5cgTzwp
 6zSg6qlGdxXzuWQbkFvlye4UBMfVOO3ivRIIUiu84t3oEVewBvfGvRtsRRE4uyG+P2mVfy+DlNB
 2+mE93wUqPyc9JD+lW+6165pihxjVLB0+Tvn6/YgwAo130Nhly8m
X-Received: by 2002:a05:6000:1788:b0:38b:e32a:10aa with SMTP id
 ffacd0b85a97d-38c51949fbamr3141507f8f.5.1738162532009; 
 Wed, 29 Jan 2025 06:55:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYY802k1TNGiUZEBvWD3euMsSo6t1SQYXX3//x/iaE/8GbMeWVCUlbIuRNN6C4/ug0ihsZow==
X-Received: by 2002:a05:6000:1788:b0:38b:e32a:10aa with SMTP id
 ffacd0b85a97d-38c51949fbamr3141484f8f.5.1738162531533; 
 Wed, 29 Jan 2025 06:55:31 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bad16sm17727837f8f.68.2025.01.29.06.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 06:55:31 -0800 (PST)
Date: Wed, 29 Jan 2025 15:55:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/13] acpi/ghes: Cleanup the code which gets ghes
 ged state
Message-ID: <20250129155530.29455d45@imammedo.users.ipa.redhat.com>
In-Reply-To: <f40cacd977b9eae69a5b0091d3e7a2746b2892be.1738137123.git.mchehab+huawei@kernel.org>
References: <cover.1738137123.git.mchehab+huawei@kernel.org>
 <f40cacd977b9eae69a5b0091d3e7a2746b2892be.1738137123.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 29 Jan 2025 09:04:14 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Move the check logic into a common function and simplify the
> code which checks if GHES is enabled and was properly setup.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

with nits fixed:
Reviewed-by:  Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes-stub.c    |  7 ++++---
>  hw/acpi/ghes.c         | 43 ++++++++++++------------------------------
>  include/hw/acpi/ghes.h | 15 ++++++++-------
>  target/arm/kvm.c       |  8 ++++++--
>  4 files changed, 30 insertions(+), 43 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index 7cec1812dad9..40f660c246fe 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,12 +11,13 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                            uint64_t physical_address)
>  {
>      return -1;
>  }
>  
> -bool acpi_ghes_present(void)
> +AcpiGhesState *acpi_ghes_get_state(void)
>  {
> -    return false;
> +    return NULL;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 38ff95273706..849abfa12187 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -407,18 +407,12 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>          fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
>              NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
>      }
> -
> -    ags->present = true;
>  }
>  
>  static void get_hw_error_offsets(uint64_t ghes_addr,
>                                   uint64_t *cper_addr,
>                                   uint64_t *read_ack_register_addr)
>  {
> -    if (!ghes_addr) {
> -        return;
> -    }
> -
>      /*
>       * non-HEST version supports only one source, so no need to change
>       * the start offset based on the source ID. Also, we can't validate
> @@ -447,9 +441,6 @@ static void get_ghes_source_offsets(uint16_t source_id,
>      uint64_t err_source_entry, error_block_addr;
>      uint32_t num_sources, i;
>  
> -    if (!hest_entry_addr) {
> -        return;
> -    }
>  
>      cpu_physical_memory_read(hest_entry_addr, &num_sources,
>                               sizeof(num_sources));
> @@ -515,27 +506,17 @@ static void get_ghes_source_offsets(uint16_t source_id,
>  NotifierList acpi_generic_error_notifiers =
>      NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
>  
> -void ghes_record_cper_errors(const void *cper, size_t len,
> +void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
>      uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
> -    AcpiGedState *acpi_ged_state;
> -    AcpiGhesState *ags;
>  
>      if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
>          error_setg(errp, "GHES CPER record is too big: %zd", len);
>          return;
>      }
>  
> -    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> -                                                       NULL));
> -    if (!acpi_ged_state) {
> -        error_setg(errp, "Can't find ACPI_GED object");
> -        return;
> -    }
> -    ags = &acpi_ged_state->ghes_state;
> -
> -    if (!ags->hest_addr_le) {
> +    if (!ags->use_hest_addr) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>                               &cper_addr, &read_ack_register_addr);
>      } else {
> @@ -543,11 +524,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>                                  &cper_addr, &read_ack_register_addr, errp);
>      }
>  
> -    if (!cper_addr) {
> -        error_setg(errp, "can not find Generic Error Status Block");
> -        return;
> -    }
> -
>      cpu_physical_memory_read(read_ack_register_addr,
>                               &read_ack_register, sizeof(read_ack_register));
>  
> @@ -573,7 +549,8 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      notifier_list_notify(&acpi_generic_error_notifiers, NULL);
>  }
>  
> -int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                            uint64_t physical_address)
>  {
>      /* Memory Error Section Type */
>      const uint8_t guid[] =
> @@ -599,7 +576,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
>      acpi_ghes_build_append_mem_cper(block, physical_address);
>  
>      /* Report the error */
> -    ghes_record_cper_errors(block->data, block->len, source_id, &errp);
> +    ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
>  
>      g_array_free(block, true);
>  
> @@ -611,7 +588,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
>      return 0;
>  }
>  
> -bool acpi_ghes_present(void)
> +AcpiGhesState *acpi_ghes_get_state(void)
>  {
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
> @@ -620,8 +597,12 @@ bool acpi_ghes_present(void)
>                                                         NULL));
>  
>      if (!acpi_ged_state) {
> -        return false;
> +        return NULL;
>      }
>      ags = &acpi_ged_state->ghes_state;
> -    return ags->present;
> +
> +    if (!ags->hw_error_le && !ags->hest_addr_le) {

should we add a warning here?
(consider case where firmware hasn't managed to update pointers for some reason)

> +        return NULL;
> +    }
> +    return ags;
>  }
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 80a0c3fcfaca..e1b66141d01c 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -63,7 +63,6 @@ enum AcpiGhesNotifyType {
>  typedef struct AcpiGhesState {
>      uint64_t hest_addr_le;
>      uint64_t hw_error_le;
> -    bool present; /* True if GHES is present at all on this board */
>      bool use_hest_addr; /* True if HEST address is present */
>  } AcpiGhesState;
>  
> @@ -87,15 +86,17 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_memory_errors(uint16_t source_id, uint64_t error_physical_addr);
> -void ghes_record_cper_errors(const void *cper, size_t len,
> +int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                            uint64_t error_physical_addr);
> +void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp);
>  
>  /**
> - * acpi_ghes_present: Report whether ACPI GHES table is present
> + * acpi_ghes_get_state: Get a pointer for ACPI ghes state
>   *
> - * Returns: true if the system has an ACPI GHES table and it is
> - * safe to call acpi_ghes_memory_errors() to record a memory error.
> + * Returns: a pointer to ghes state if the system has an ACPI GHES table,
> + * it is enabled and it is safe to call acpi_ghes_memory_errors() to record
> + * a memory error. Returns false, otherwise.
>   */
> -bool acpi_ghes_present(void);
> +AcpiGhesState *acpi_ghes_get_state(void);
>  #endif
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index da30bdbb2349..544ff174784d 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2366,10 +2366,13 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>  {
>      ram_addr_t ram_addr;
>      hwaddr paddr;
> +    AcpiGhesState *ags;
>  
>      assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>  
> -    if (acpi_ghes_present() && addr) {
> +    ags = acpi_ghes_get_state();

> +
I'd drop this newline

> +    if (ags && addr) {
>          ram_addr = qemu_ram_addr_from_host(addr);
>          if (ram_addr != RAM_ADDR_INVALID &&
>              kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
> @@ -2387,7 +2390,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>               */
>              if (code == BUS_MCEERR_AR) {
>                  kvm_cpu_synchronize_state(c);
> -                if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
> +                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SEA,
> +                                             paddr)) {
>                      kvm_inject_arm_sea(c);
>                  } else {
>                      error_report("failed to record the error");


