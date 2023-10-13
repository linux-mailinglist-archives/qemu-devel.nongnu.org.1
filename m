Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 898C97C8D6B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 21:02:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrNPn-0003oJ-Ij; Fri, 13 Oct 2023 15:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1qrLT1-0005Fy-Ay
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:56:51 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1qrLSy-0002My-1s
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:56:51 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-578d0dcd4e1so1648511a12.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697216206; x=1697821006; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IgV73/bZCE+j0pcmpLO58sQXuQXF3ja23XLyZlWF1ew=;
 b=dtniG0T18rLNH49V+/HogkHaW7vD/41L9RUz7kYJo4NEUNiYpi3Q1GNgoZCtqfMHrL
 R7U9yXQ6rsngJ/bbjhidM6n8vCQ9h/Rud/HuP6nHfXPCiX1nANlcv9gIzJ2XD/qjXY7B
 ftKGiTiSCGH2HcPvMBw6FSRjA9NFwGNogTxkkGmuhpTsLNXoao7yxDGU1h9BzlB2WPit
 i+SYZ7F9S2gWGs8vMCXISHgNuDGJUcaqfk+0uzZPOzn+vxgASC+bPH399bNlUTrNCqpD
 LWI32AkHFN8yzeBXm6sNQUG2NUVQj4T1S+3FnyemG2CdgoQnisiatALk+utNjg/UoaJz
 9vQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216206; x=1697821006;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IgV73/bZCE+j0pcmpLO58sQXuQXF3ja23XLyZlWF1ew=;
 b=MHPs6EZLrzPkEEfibfy8CrETj/QV2ev04X6GusekGdVJpwaLuaVMvwa5oW4XhQY+iR
 OY4EvaJbAkvAcVVEMlVMgdaIsS2xtcgioDePp17OO1CmsCsNcm0FFr8+uFp0PrE+XVmN
 YWuacm4BpnQ4cYN6OLD5jlB10LE9QNgyjELr7ZOu5b7lp1alb8RmEsHy28Hz6tzMu86u
 +TBV8R2FghAi1PqzngopOgbX3zDtjOPVroQa59T3oa5HE6Ltq9bmq/aY7w2wtwtoRLhH
 N7QRGS0W0LHPKtyjXHw9FIZGHDHsFoUMvbrzND1BDLgjQztM3X0ZAkO4T3ZPuToTwqiu
 +oKQ==
X-Gm-Message-State: AOJu0Yxn7Of6lf4yHZjp3muIrl5MWHM7oCStUf0amYVFSOZbVKw3/cHN
 9+n3phKlWnOjujFNGPp2VZ4=
X-Google-Smtp-Source: AGHT+IFncI/OCutdaHnUhGVL+zFM1t5prtTsGtePoM6du2LSGUuNHMw9Ml2EEe+dn1yZUdX1ZJc6zw==
X-Received: by 2002:a05:6a20:734b:b0:14c:de3:95d6 with SMTP id
 v11-20020a056a20734b00b0014c0de395d6mr28410653pzc.45.1697216206080; 
 Fri, 13 Oct 2023 09:56:46 -0700 (PDT)
Received: from debian (99-13-228-231.lightspeed.snjsca.sbcglobal.net.
 [99.13.228.231]) by smtp.gmail.com with ESMTPSA id
 l18-20020a170902d35200b001c74df14e6esm4124080plk.51.2023.10.13.09.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:56:45 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 13 Oct 2023 09:56:09 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Michael Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 linuxarm@huawei.com, Fan Ni <fan.ni@samsung.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 4/4] hw/cxl: Line length reductions
Message-ID: <ZSl2k_-hyzcC60CX@debian>
References: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
 <20231012140514.3697-5-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012140514.3697-5-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Oct 2023 15:01:36 -0400
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

On Thu, Oct 12, 2023 at 03:05:14PM +0100, Jonathan Cameron wrote:
> Michael Tsirkin observed that there were some unnecessarily
> long lines in the CXL code in a recent review.
> This patch is intended to rectify that where it does not
> hurt readability.
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  include/hw/cxl/cxl_component.h |  3 ++-
>  include/hw/cxl/cxl_device.h    |  5 +++--
>  include/hw/cxl/cxl_events.h    |  3 ++-
>  hw/cxl/cxl-cdat.c              |  3 ++-
>  hw/cxl/cxl-component-utils.c   | 14 ++++++++------
>  hw/cxl/cxl-events.c            |  9 ++++++---
>  hw/cxl/cxl-mailbox-utils.c     | 21 ++++++++++++++-------
>  hw/mem/cxl_type3.c             | 31 +++++++++++++++++++------------
>  hw/mem/cxl_type3_stubs.c       |  5 +++--
>  9 files changed, 59 insertions(+), 35 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 3c795a6278..e52dd8d2b9 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -175,7 +175,8 @@ HDM_DECODER_INIT(3);
>      (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
>  #define CXL_SNOOP_REGISTERS_SIZE   0x8
>  
> -QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE) >= 0x1000,
> +QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET +
> +                    CXL_SNOOP_REGISTERS_SIZE) >= 0x1000,
>                     "No space for registers");
>  
>  typedef struct component_registers {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 51cd0d9ce3..007ddaf078 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -192,7 +192,7 @@ void cxl_device_register_init_common(CXLDeviceState *dev);
>   * Documented as a 128 bit register, but 64 bit accesses and the second
>   * 64 bits are currently reserved.
>   */
> -REG64(CXL_DEV_CAP_ARRAY, 0) /* Documented as 128 bit register but 64 byte accesses */
> +REG64(CXL_DEV_CAP_ARRAY, 0)
>      FIELD(CXL_DEV_CAP_ARRAY, CAP_ID, 0, 16)
>      FIELD(CXL_DEV_CAP_ARRAY, CAP_VERSION, 16, 8)
>      FIELD(CXL_DEV_CAP_ARRAY, CAP_COUNT, 32, 16)
> @@ -361,7 +361,8 @@ struct CXLType3Class {
>                          uint64_t offset);
>      void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>                      uint64_t offset);
> -    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
> +    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset,
> +                          uint8_t *data);
>  };
>  
>  MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 089ba2091f..d778487b7e 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -92,7 +92,8 @@ typedef enum CXLEventIntMode {
>      CXL_INT_RES      = 0x03,
>  } CXLEventIntMode;
>  #define CXL_EVENT_INT_MODE_MASK 0x3
> -#define CXL_EVENT_INT_SETTING(vector) ((((uint8_t)vector & 0xf) << 4) | CXL_INT_MSI_MSIX)
> +#define CXL_EVENT_INT_SETTING(vector) \
> +    ((((uint8_t)vector & 0xf) << 4) | CXL_INT_MSI_MSIX)
>  typedef struct CXLEventInterruptPolicy {
>      uint8_t info_settings;
>      uint8_t warn_settings;
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index d246d6885b..639a2db3e1 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -60,7 +60,8 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>          return;
>      }
>  
> -    cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf, cdat->private);
> +    cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
> +                                                 cdat->private);
>  
>      if (!cdat->built_buf_len) {
>          /* Build later as not all data available yet */
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 8ab04dbb01..80efbf6365 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -240,7 +240,8 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 1);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 1);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
> -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> +                     POISON_ON_ERR_CAP, 0);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
>                       HDM_DECODER_ENABLE, 0);
>      write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
> @@ -263,15 +264,16 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>      }
>  }
>  
> -void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk,
> +void cxl_component_register_init_common(uint32_t *reg_state,
> +                                        uint32_t *write_msk,
>                                          enum reg_type type)
>  {
>      int caps = 0;
>  
>      /*
> -     * In CXL 2.0 the capabilities required for each CXL component are such that,
> -     * with the ordering chosen here, a single number can be used to define
> -     * which capabilities should be provided.
> +     * In CXL 2.0 the capabilities required for each CXL component are such
> +     * that, with the ordering chosen here, a single number can be used to
> +     * define which capabilities should be provided.
>       */
>      switch (type) {
>      case CXL2_DOWNSTREAM_PORT:
> @@ -448,7 +450,7 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
>          default: /* Registers are RO for other component types */
>              break;
>          }
> -        /* There are rw1cs bits in the status register but never set currently */
> +        /* There are rw1cs bits in the status register but never set */
>          break;
>      }
>  
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index 3ddd6369ad..e2172b94b9 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -170,8 +170,10 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
>      if (log->overflow_err_count) {
>          pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
>          pl->overflow_err_count = cpu_to_le16(log->overflow_err_count);
> -        pl->first_overflow_timestamp = cpu_to_le64(log->first_overflow_timestamp);
> -        pl->last_overflow_timestamp = cpu_to_le64(log->last_overflow_timestamp);
> +        pl->first_overflow_timestamp =
> +            cpu_to_le64(log->first_overflow_timestamp);
> +        pl->last_overflow_timestamp =
> +            cpu_to_le64(log->last_overflow_timestamp);
>      }
>  
>      pl->record_count = cpu_to_le16(nr);
> @@ -180,7 +182,8 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> -CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds, CXLClearEventPayload *pl)
> +CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
> +                                   CXLClearEventPayload *pl)
>  {
>      CXLEventLog *log;
>      uint8_t log_type;
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 434ccc5f6e..ab082ec9de 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -366,9 +366,12 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
>  
>      snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
>  
> -    stq_le_p(&id->total_capacity, cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
> -    stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
> -    stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
> +    stq_le_p(&id->total_capacity,
> +             cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
> +    stq_le_p(&id->persistent_capacity,
> +             cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
> +    stq_le_p(&id->volatile_capacity,
> +             cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
>      stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
>      /* 256 poison records */
>      st24_le_p(id->poison_list_max_mer, 256);
> @@ -396,13 +399,15 @@ static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> -    stq_le_p(&part_info->active_vmem, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
> +    stq_le_p(&part_info->active_vmem,
> +             cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
>      /*
>       * When both next_vmem and next_pmem are 0, there is no pending change to
>       * partitioning.
>       */
>      stq_le_p(&part_info->next_vmem, 0);
> -    stq_le_p(&part_info->active_pmem, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
> +    stq_le_p(&part_info->active_pmem,
> +             cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
>      stq_le_p(&part_info->next_pmem, 0);
>  
>      *len = sizeof(*part_info);
> @@ -681,8 +686,10 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>      [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
>          cmd_firmware_update_get_info, 0, 0 },
>      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
> -    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDIATE_POLICY_CHANGE },
> -    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0, 0 },
> +    [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
> +                         8, IMMEDIATE_POLICY_CHANGE },
> +    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
> +                              0, 0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>      [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
>          cmd_identify_memory_device, 0, 0 },
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c02be4ce45..18ad853f5b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -208,10 +208,9 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      }
>  
>      if (nonvolatile_mr) {
> +        uint64_t base = volatile_mr ? memory_region_size(volatile_mr) : 0;
>          rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
> -                                           nonvolatile_mr, true,
> -                                           (volatile_mr ?
> -                                            memory_region_size(volatile_mr) : 0));
> +                                           nonvolatile_mr, true, base);
>          if (rc < 0) {
>              goto error_cleanup;
>          }
> @@ -514,7 +513,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>      case A_CXL_RAS_UNC_ERR_STATUS:
>      {
>          uint32_t capctrl = ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL);
> -        uint32_t fe = FIELD_EX32(capctrl, CXL_RAS_ERR_CAP_CTRL, FIRST_ERROR_POINTER);
> +        uint32_t fe = FIELD_EX32(capctrl, CXL_RAS_ERR_CAP_CTRL,
> +                                 FIRST_ERROR_POINTER);
>          CXLError *cxl_err;
>          uint32_t unc_err;
>  
> @@ -533,7 +533,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>                   * closest to behavior of hardware not capable of multiple
>                   * header recording.
>                   */
> -                QTAILQ_FOREACH_SAFE(cxl_err, &ct3d->error_list, node, cxl_next) {
> +                QTAILQ_FOREACH_SAFE(cxl_err, &ct3d->error_list, node,
> +                                    cxl_next) {
>                      if ((1 << cxl_err->type) & value) {
>                          QTAILQ_REMOVE(&ct3d->error_list, cxl_err, node);
>                          g_free(cxl_err);
> @@ -1072,7 +1073,8 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>          if (((start >= p->start) && (start < p->start + p->length)) ||
>              ((start + length > p->start) &&
>               (start + length <= p->start + p->length))) {
> -            error_setg(errp, "Overlap with existing poisoned region not supported");
> +            error_setg(errp,
> +                       "Overlap with existing poisoned region not supported");
>              return;
>          }
>      }
> @@ -1085,7 +1087,8 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>      p = g_new0(CXLPoison, 1);
>      p->length = length;
>      p->start = start;
> -    p->type = CXL_POISON_TYPE_INTERNAL; /* Different from injected via the mbox */
> +    /* Different from injected via the mbox */
> +    p->type = CXL_POISON_TYPE_INTERNAL;
>  
>      QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
>      ct3d->poison_list_cnt++;
> @@ -1222,7 +1225,8 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>          return;
>      }
>      /* If the error is masked, nothting to do here */
> -    if (!((1 << cxl_err_type) & ~ldl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK))) {
> +    if (!((1 << cxl_err_type) &
> +          ~ldl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK))) {
>          return;
>      }
>  
> @@ -1372,7 +1376,8 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>                                 bool has_bank, uint8_t bank,
>                                 bool has_row, uint32_t row,
>                                 bool has_column, uint16_t column,
> -                               bool has_correction_mask, uint64List *correction_mask,
> +                               bool has_correction_mask,
> +                               uint64List *correction_mask,
>                                 Error **errp)
>  {
>      Object *obj = object_resolve_path(path, NULL);
> @@ -1473,7 +1478,7 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>                                          int16_t temperature,
>                                          uint32_t dirty_shutdown_count,
>                                          uint32_t corrected_volatile_error_count,
> -                                        uint32_t corrected_persistent_error_count,
> +                                        uint32_t corrected_persist_error_count,
>                                          Error **errp)
>  {
>      Object *obj = object_resolve_path(path, NULL);
> @@ -1513,8 +1518,10 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>      module.life_used = life_used;
>      stw_le_p(&module.temperature, temperature);
>      stl_le_p(&module.dirty_shutdown_count, dirty_shutdown_count);
> -    stl_le_p(&module.corrected_volatile_error_count, corrected_volatile_error_count);
> -    stl_le_p(&module.corrected_persistent_error_count, corrected_persistent_error_count);
> +    stl_le_p(&module.corrected_volatile_error_count,
> +             corrected_volatile_error_count);
> +    stl_le_p(&module.corrected_persistent_error_count,
> +             corrected_persist_error_count);
>  
>      if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&module)) {
>          cxl_event_irq_assert(ct3d);
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 8ba5d3d1f7..3e1851e32b 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -33,7 +33,8 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
>                                 bool has_bank, uint8_t bank,
>                                 bool has_row, uint32_t row,
>                                 bool has_column, uint16_t column,
> -                               bool has_correction_mask, uint64List *correction_mask,
> +                               bool has_correction_mask,
> +                               uint64List *correction_mask,
>                                 Error **errp) {}
>  
>  void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> @@ -45,7 +46,7 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>                                          int16_t temperature,
>                                          uint32_t dirty_shutdown_count,
>                                          uint32_t corrected_volatile_error_count,
> -                                        uint32_t corrected_persistent_error_count,
> +                                        uint32_t corrected_persist_error_count,
>                                          Error **errp) {}
>  
>  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> -- 
> 2.39.2
> 

