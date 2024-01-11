Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 844F182B7F0
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 00:18:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO4IP-0004PC-OW; Thu, 11 Jan 2024 18:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rO4IK-0004Ou-Cp
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 18:17:04 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rO4IH-00019t-9R
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 18:17:03 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so4886955b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 15:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705015019; x=1705619819; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RNPCSOWv/u1Jtplu9z7EWUMPQ6AEzJHAYRX1DmebeZA=;
 b=kj55Yx+I5U+hoyxA+brvWy7YWxpYIU+oJF43NjKNWErWCnF4LW4x4b/djWHBzvWZ0U
 fTVKG46InygA6ClItKy28P0HoKUuaIFADeA8hhK6SR5va1H4hroUfhSQsctRoIeWI6Gv
 Icv6cdTbO2iyGfiYgiDbzoETeLaWuCCDpigmDo2BIsPgMJePabRynX0upLTkpgB8vYHv
 MmVPYnKPH6GtOYPUwqPhfczDHKWczd+KncgfDhJb6DVlUoGPGoli0U0kjoE+och3AGvx
 friTaI2fCdZMyW4lVbdag6SphdysqHWBE0TSC6ElzTJ7aY2UZPTbhztzvg7B7mTDkYeQ
 RZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705015019; x=1705619819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNPCSOWv/u1Jtplu9z7EWUMPQ6AEzJHAYRX1DmebeZA=;
 b=c/yIvu4kn836+0+wFDBKwgArWgmRo3AnbrIrdc7Wl3rpy0hI+KkS5TvaAAm5cQmLRg
 Oxbyhh2DKbRBOIFTpEMYhzj6FUL9VV3jJBNSzZmFbWTSNKS8vkG7NAMezNKVs626ebrp
 0RebR34crGAxje2aGOjvYfe5nyABA3ppPjm/SvBBfpW1tc1+U6IN/R1fQ2F8VGiYkdwP
 fZwsN7NIMiJkB4AccC5ownugxrqalbkZgUsxuFdsbDTE4R1NPQMS7f6b8vmqxfYBQb9S
 2tpJ+Zz/oRgCqHrqGmqfPcmhYps28chyQOjAKMKg+cx0IJfRVcDRKG93oXfMYtFVaFXQ
 /Zxw==
X-Gm-Message-State: AOJu0YzSxPw3XgtKJ82aFir/4o1GV405IU3rgo/ZNYCoLiZ0mFgj/Ka3
 WhpligwnuPgGj0h1szhPuMk=
X-Google-Smtp-Source: AGHT+IHv5O/5kI6GqoB6sQ2gkZAPNz0D6rhBhuYsr+xFddwJuBDeJ0R5aKFjCR//yTg9ONQp0ylmjg==
X-Received: by 2002:a62:ce83:0:b0:6d9:8453:e040 with SMTP id
 y125-20020a62ce83000000b006d98453e040mr73888pfg.1.1705015019397; 
 Thu, 11 Jan 2024 15:16:59 -0800 (PST)
Received: from debian (c-71-202-83-215.hsd1.ca.comcast.net. [71.202.83.215])
 by smtp.gmail.com with ESMTPSA id
 y187-20020a62cec4000000b006dab86e675esm1798768pfg.185.2024.01.11.15.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 15:16:58 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 11 Jan 2024 15:16:42 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Fan Ni <fan.ni@samsung.com>,
 linuxarm@huawei.com
Subject: Re: [PATCH v2 qemu] hw/cxl/device: read from register values in
 mdev_reg_read()
Message-ID: <ZaB22v-pqAYFfJMS@debian>
References: <20240111145905.19797-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111145905.19797-1-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 11, 2024 at 02:59:05PM +0000, Jonathan Cameron wrote:
> From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> In the current mdev_reg_read() implementation, it consistently returns
> that the Media Status is Ready (01b). This was fine until commit
> 25a52959f99d ("hw/cxl: Add support for device sanitation") because the
> media was presumed to be ready.
> 
> However, as per the CXL 3.0 spec "8.2.9.8.5.1 Sanitize (Opcode 4400h)",
> during sanitation, the Media State should be set to Disabled (11b). The
> mentioned commit correctly sets it to Disabled, but mdev_reg_read()
> still returns Media Status as Ready.
> 
> To address this, update mdev_reg_read() to read register values instead
> of returning dummy values.
> 
> Note __toggle_media() was overwriting the mailbox capability
> register, but nothing was reading that after this so that bug had no
> obvious effect unless the driver was reloaded.
> 
> Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Link: https://lore.kernel.org/r/20231222090051.3265307-3-42.hyeyoo@gmail.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> --
> 
> Hyeonggon - I've kept your sign-off. Let me know if this is ok.
> Dropped RBs etc as this has changed quite a bit.
> 
> I plan to send out a group of fixes including this soon, but given
> I've been pointing out the original fix didn't work thought I'd send
> this one out for early review!
> 
> ---
>  include/hw/cxl/cxl_device.h |  9 +++++++--
>  hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index befb5f884b..31d2afcd3d 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -202,6 +202,9 @@ typedef struct cxl_device_state {
>          };
>      };
>  
> +    /* Stash the memory device status value */
> +    uint64_t memdev_status;
> +
>      struct {
>          bool set;
>          uint64_t last_set;
> @@ -353,8 +356,10 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
>  {
>      uint64_t dev_status_reg;
>  
> -    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
> -    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
> +    dev_status_reg = cxl_dstate->memdev_status;
> +    dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
> +                                val);
> +    cxl_dstate->memdev_status = dev_status_reg;
>  }
>  #define cxl_dev_disable_media(cxlds)                    \
>          do { __toggle_media((cxlds), 0x3); } while (0)
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 61a3c4dc2e..40b619ffd9 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -229,12 +229,9 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
>  
>  static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size)
>  {
> -    uint64_t retval = 0;
> -
> -    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
> -    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
> +    CXLDeviceState *cxl_dstate = opaque;
>  
> -    return retval;
> +    return cxl_dstate->memdev_status;
>  }
>  
>  static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
> @@ -371,7 +368,15 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
>      cxl_dstate->mbox_msi_n = msi_n;
>  }
>  
> -static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
> +static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
> +{
> +    uint64_t memdev_status_reg;
> +
> +    memdev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
> +    memdev_status_reg = FIELD_DP64(memdev_status_reg, CXL_MEM_DEV_STS,
> +                                   MBOX_READY, 1);
> +    cxl_dstate->memdev_status = memdev_status_reg;
> +}
>  
>  void cxl_device_register_init_t3(CXLType3Dev *ct3d)
>  {
> -- 
> 2.39.2
> 

