Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9486ABE18B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 19:08:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQQt-0007jS-VF; Tue, 20 May 2025 13:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHQQn-0007ix-99
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:07:11 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHQQl-0000yk-4G
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:07:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-742c9563fafso2578038b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747760825; x=1748365625; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8q+EYA2c9WPJk2TN75JC+fehQQGo9FQiZD7bYilPvpw=;
 b=gzqVsCyPsROEyrMuUc4j8vGHT4mJKLNJu6Jn4Yl+YWXWGCNthfXvA2+ua3aaFKUA1a
 mYGFjR55ymeRFeW4JADjk50cnqCtnspnC4FoTpXAa2F9LlsuauN1slAByekh/vmjrC7W
 yEx/71hC1leLcfgtaOUvx6ESeuXC9iZtyNp1co6H+zZ8YfWeXh0up18O+VcaWhaz8HAK
 qe5MArLLPfWOZd6dfr1IVN6D5/1nONIGrKMprmYynLXI/QNQxUYMVXwpUzNm12wueWdM
 n7jDPca1GRqUT463j+peciWGdXhx7bkTTVb4LNa88zutwoa8oMccqYLx39y+EiqyYO1i
 7A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760825; x=1748365625;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8q+EYA2c9WPJk2TN75JC+fehQQGo9FQiZD7bYilPvpw=;
 b=AqOzBof2QrqliFYZcAKms7H2tOUN7+5HCY22qCIFdUpYP8BqH2bNBtllWrxepO//nH
 GPSA5aTcIxDdbYWuu7UKqr16jm2I0D5djcxHqa2Jp3lG9vISX0FnKF0XBy4w+/Jaq7Ip
 gqXGa1t6fQsn/EQr/J0MqSnvdeCX1H/EZcRLy1YjHvd6TCAcg9fW/96ykhT6y3P1UwYq
 An3dO0vMIoNfZvk2PYQpKrtvQ5gTwvV2w3XFH2S0OHOv04rJkdTvKY6ZqjMa7wFNoEKN
 zesA/gyh6eOP1oqF6tRFEm9PGKlNy4pZU/8FSfVwU4acYHko0/P1nOmXniiPzlk17QMC
 4Vmw==
X-Gm-Message-State: AOJu0YyXeGRYQc6b4zIl/v2fGND/jg10omSgK7sW4GqZJaO8typIPQ7K
 Trm9Xj8K6Wb4ZZ3cdOCn0QElDhFghceTGpt0AbZWHCamQj7BTpHKKliej8IS7w==
X-Gm-Gg: ASbGncsGTI/z/K2LuS1a0NZOi7fLioI3hgf6vXRZx46CmOLNCG6nbYwvkXL+q1vPxoE
 l+akA4TyeS69bZ8D6WTQvHRqEW3EcgXOhMH8yJDNuGR+DcVxBaMyzKFrW7bGvTV2GI2IgQgyHBh
 anZz3tKoKFV6T9dQGzQFnt2w3zE7N1bVJOAzoC6G5cOV6xbkfsjfWEV8c7F+PhqEfYJPpGKUOj6
 hFvhtCr3VDT5JfEW/Q4fZ8v9zZc+ZfcEwxFqD4okeAziaXANY4SHfUQ4WnimxpPyisKQrCR94xR
 gxuTpBx0bTCRkCHxgx27cEHKjTWCX6va6YI0yuQ9Y4TcuVy6LMru
X-Google-Smtp-Source: AGHT+IFmtzOivtQLt/MERhxfivImekdEeQkNMQgXIoMpA3EnIyZnt3/tYApwH0vBzkOXESYF+llakw==
X-Received: by 2002:a05:6a20:d705:b0:215:e43a:29b9 with SMTP id
 adf61e73a8af0-216219bd612mr24255820637.33.1747760825446; 
 Tue, 20 May 2025 10:07:05 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf8e13csm8230164a12.45.2025.05.20.10.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:07:04 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 10:07:02 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 07/10] cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region
 Config
Message-ID: <aCy2thqeJ7DnD-7K@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-8-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508001754.122180-8-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, May 08, 2025 at 12:01:03AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c   | 97 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |  2 +-
>  include/hw/cxl/cxl_device.h  |  3 ++
>  include/hw/cxl/cxl_mailbox.h |  6 +++
>  include/hw/cxl/cxl_opcodes.h |  1 +
>  5 files changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 6afc45833d..fe38a13f71 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3426,6 +3426,96 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void cxl_mbox_dc_event_create_record_hdr(CXLType3Dev *ct3d,
> +                                                CXLEventRecordHdr *hdr)
> +{
> +    /*
> +     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
> +     *
> +     * All Dynamic Capacity event records shall set the Event Record Severity
> +     * field in the Common Event Record Format to Informational Event. All
> +     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> +     * Event Log.
> +     */
> +    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> +
> +    st24_le_p(&hdr->flags, flags);
> +    hdr->length = sizeof(struct CXLEventDynamicCapacity);
> +    memcpy(&hdr->id, &dynamic_capacity_uuid, sizeof(hdr->id));
> +    stq_le_p(&hdr->timestamp, cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +}

This function does the same thing as cxl_assign_event_header(), maybe we
can move the cxl_assign_event_header() to header file so it can be used by
both cxl_type3.c and cxl-mailbox-utils.c and then this function is not
needed or simplified by calling cxl_assign_event_header().

Fan
> +
> +/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602) */
> +static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
> +                                              uint8_t *payload_in,
> +                                              size_t len_in,
> +                                              uint8_t *payload_out,
> +                                              size_t *len_out,
> +                                              CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t reg_id;
> +        uint8_t rsvd[3];
> +        uint64_t block_sz;
> +        uint8_t flags;
> +        uint8_t rsvd2[3];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLEventDynamicCapacity dcEvent = {};
> +    CXLDCRegion *region;
> +
> +    region = &ct3d->dc.regions[in->reg_id];
> +
> +    /*
> +     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
> +     * This command shall fail with Unsupported when the Sanitize on Release
> +     * field does not match the region’s configuration... and the device
> +     * does not support reconfiguration of the Sanitize on Release setting.
> +     *
> +     * Currently not reconfigurable, so always fail if sanitize bit
> +     * doesn't match.
> +     */
> +    if ((in->flags & 0x1) != (region->flags & 0x1)) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    if (in->reg_id >= DCD_MAX_NUM_REGION) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* Check that no extents are in the region being reconfigured */
> +    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_size)) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* Check that new block size is supported */
> +    if (!test_bit(BIT((int) log2(in->block_sz)),
> +                  &region->supported_blk_size_bitmask)) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    /* Free bitmap and create new one for new block size. */
> +    qemu_mutex_lock(&region->bitmap_lock);
> +    g_free(region->blk_bitmap);
> +    region->blk_bitmap = bitmap_new(region->len / in->block_sz);
> +    qemu_mutex_unlock(&region->bitmap_lock);
> +    region->block_size = in->block_sz;

If the new block size equals to region->block_size, we can avoid the free
and allocation of the bitmap?

Fan

> +
> +    /* Create event record and insert into event log */
> +    cxl_mbox_dc_event_create_record_hdr(ct3d, &dcEvent.hdr);
> +    dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
> +    dcEvent.validity_flags = 1;
> +    dcEvent.host_id = 0;
> +    dcEvent.updated_region_id = in->reg_id;
> +
> +    if (cxl_event_insert(&ct3d->cxl_dstate,
> +                         CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                         (CXLEventRecordRaw *)&dcEvent)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3552,6 +3642,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>          cmd_fm_get_dcd_info, 0, 0 },
>      [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
>          cmd_fm_get_host_dc_region_config, 4, 0 },
> +    [FMAPI_DCD_MGMT][SET_DC_REGION_CONFIG] = { "SET_DC_REGION_CONFIG",
> +        cmd_fm_set_dc_region_config, 16,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>  };
>  
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b5b3df5edf..edc29f1ccb 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1695,7 +1695,7 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>      pcie_aer_inject_error(PCI_DEVICE(obj), &err);
>  }
>  
> -static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> +void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                                      const QemuUUID *uuid, uint32_t flags,
>                                      uint8_t length, uint64_t timestamp)
>  {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 9cfd9c5a9f..22823e2054 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -821,4 +821,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                     uint64_t len);
>  bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                    uint64_t len);
> +void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> +                             const QemuUUID *uuid, uint32_t flags,
> +                             uint8_t length, uint64_t timestamp);
>  #endif
> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> index 8e1c7c5f15..820c411cbb 100644
> --- a/include/hw/cxl/cxl_mailbox.h
> +++ b/include/hw/cxl/cxl_mailbox.h
> @@ -8,6 +8,7 @@
>  #ifndef CXL_MAILBOX_H
>  #define CXL_MAILBOX_H
>  
> +#define CXL_MBOX_CONFIG_CHANGE_COLD_RESET (1)
>  #define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -15,6 +16,11 @@
>  #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
>  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
> +#define CXL_MBOX_SECONDARY_MBOX_SUPPORTED (1 << 8)
> +#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OP_SUPPORTED (1 << 9)
> +#define CXL_MBOX_CEL_10_TO_11_VALID (1 << 10)
> +#define CXL_MBOX_CONFIG_CHANGE_CONV_RESET (1 << 11)
> +#define CXL_MBOX_CONFIG_CHANGE_CXL_RESET (1 << 12)
>  
>  #define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
>  #define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
> diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> index 68ad68291c..ed4be23b75 100644
> --- a/include/hw/cxl/cxl_opcodes.h
> +++ b/include/hw/cxl/cxl_opcodes.h
> @@ -64,5 +64,6 @@ enum {
>      FMAPI_DCD_MGMT = 0x56,
>          #define GET_DCD_INFO 0x0
>          #define GET_HOST_DC_REGION_CONFIG 0x1
> +        #define SET_DC_REGION_CONFIG 0x2
>      GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
>  };
> -- 
> 2.47.2
> 

-- 
Fan Ni

