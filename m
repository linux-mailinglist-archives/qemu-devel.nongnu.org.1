Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB8C8680C3
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Feb 2024 20:18:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1regT1-0008H0-G9; Mon, 26 Feb 2024 14:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1regSn-0008Fl-0o
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:16:35 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1regSj-0006j9-Th
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:16:32 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-29aa91e173dso875330a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 11:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708974988; x=1709579788; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tqppujVJJ0rI4ZpT//c1Xe6xAYyom1X8ghHe7JufE2o=;
 b=D6z+NYvHrbviOpDnuoVXHmz6GcURuJSdSNRdmo/6maQhge2G5u+Dn/OROOAlHzgpDF
 9WS81d7SVEZd6a1TVQh640P/gfqKR5UCBO/TBtWERTwRGq2RZ+rLF0AHKoXk0obsvlG0
 T8Ptcvy02as88+c9E2JCl8MpRSfN73QRsL6ZmfHPjyAoSbYTtXRklA7YqiI9oAstzsb2
 KxdlL11sYMS0+iPdZ63sn2XXVMAT5VWpH4SIbtt/YCTc6aWkmP5YHSPvI1wwfTxgjbDr
 3SSS0/zNEStpi4rACQm2HS73nXj9x9swoyrA4cIN94mtYC5bhjkCEf8zhv2Xne/mWq55
 kehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708974988; x=1709579788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqppujVJJ0rI4ZpT//c1Xe6xAYyom1X8ghHe7JufE2o=;
 b=uXYU+USWXXCmFSn0pRqmc1mgCjQERTUrJZs+vgBjGlbmLs6436B0mOXg8A3NyIawEs
 n1CCbReiCOqb67ULAzWgNY+rXrLJP2bRTGinWhe/7ihUpAPKMngOBP7qWWs4dM9O0gQx
 t5P8dqRPg9AiPpcwthvidvbmcilVhjPGs5hZFHMJ+B6XC+PO2AAnliWX3zFmgOG/OYqX
 T4YjsC1dMpM1pdOOKd/3vFQCQ1CkezkXENlMCibiB4U+yzNVJ7aNKcxHxORgVXYpupNH
 PEyBbdcYAcUKHStkIXhOrnKsBp+EsVV3/ROy3MNK2+DDxe0Q78dg5MveFxFYBtPzd616
 T+fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX69gL63pOc9u+jgjJxvjRtg17E0yB/BR6INvXfnRg8siTpsgeXXPCouuLb673OE/4V17qDUJ1IDPCXLQKPOGzAZdsJws=
X-Gm-Message-State: AOJu0YwipUJar/vgM+EHqX1G06oGlQpKdQ0DwqUGilkVepiK7rm0lhGc
 9BAS6YH1VQ0Sq4guOmoeS5IdhTv6rHhvaJxy1cW+hRzdT8nMc64P
X-Google-Smtp-Source: AGHT+IG3nXfZhAaKrbrY8fNOROq+h62rUs3DUBj9PRQx77+/PjT7OTn1l9w9lO7aQKjOuK0yzKm4NQ==
X-Received: by 2002:a17:90a:a383:b0:299:17a7:c441 with SMTP id
 x3-20020a17090aa38300b0029917a7c441mr5566446pjp.42.1708974987998; 
 Mon, 26 Feb 2024 11:16:27 -0800 (PST)
Received: from debian ([2601:641:300:14de:6185:5882:dd39:9005])
 by smtp.gmail.com with ESMTPSA id
 sh14-20020a17090b524e00b00298ca3a93f1sm7128555pjb.4.2024.02.26.11.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 11:16:27 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 26 Feb 2024 11:16:09 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <Zdzjef3y1SjRCc5L@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-3-nifan.cxl@gmail.com>
 <20240226173317.0000299d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226173317.0000299d@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pj1-x1031.google.com
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

On Mon, Feb 26, 2024 at 05:33:17PM +0000, Jonathan Cameron wrote:
> On Wed, 21 Feb 2024 10:15:55 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Per cxl spec r3.1, add dynamic capacity region representative based on
> > Table 8-165 and extend the cxl type3 device definition to include dc region
> > information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
> > Configuration' mailbox support.
> > 
> > Note: decode_len of a dc region is aligned to 256*MiB, divided by
> > 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> > mailbox command.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> Hi Fan,
> 
> A few comments inline.
> 
> Jonathan
> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 110 ++++++++++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_device.h |  16 ++++++
> >  2 files changed, 126 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index ba1d9901df..88e3b733e3 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -22,6 +22,7 @@
> >  
> >  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> >  #define CXL_DC_EVENT_LOG_SIZE 8
> > +#define CXL_SPEC_AFTER_R30
> As below. Drop this.  Kernel code needs to be able to cope with newer specs
> than it understands anyway so should be fine with the larger records (otherwise
> it's buggy and needs fixing!) 

Will remove it.
> 
> >  
> >  /*
> >   * How to add a new command, example. The command set FOO, with cmd BAR.
> > @@ -80,6 +81,8 @@ enum {
> >          #define GET_POISON_LIST        0x0
> >          #define INJECT_POISON          0x1
> >          #define CLEAR_POISON           0x2
> > +    DCD_CONFIG  = 0x48,
> > +        #define GET_DC_CONFIG          0x0
> >      PHYSICAL_SWITCH = 0x51,
> >          #define IDENTIFY_SWITCH_DEVICE      0x0
> >          #define GET_PHYSICAL_PORT_STATE     0x1
> > @@ -1238,6 +1241,103 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +/*
> > + * CXL r3.1 section 8.2.9.9.9.1: Get Dynamic Capacity Configuration
> > + * (Opcode: 4800h)
> > + */
> > +static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
> > +                                             uint8_t *payload_in,
> > +                                             size_t len_in,
> > +                                             uint8_t *payload_out,
> > +                                             size_t *len_out,
> > +                                             CXLCCI *cci)
> > +{
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    struct get_dyn_cap_config_in_pl {
> Type not needed - see below. 
> > +        uint8_t region_cnt;
> > +        uint8_t start_region_id;
> > +    } QEMU_PACKED;
>    } QEMU_PACKED *in;

Get your point, it seems I followed the wrong example like
cmd_media_clear_poison and cmd_inject_poison :-<

Fan

> 
> > +
> > +    struct get_dyn_cap_config_out_pl {
> Don't think giving this a type is necessary - see below.
> > +        uint8_t num_regions;
> > +        uint8_t regions_returned;
> > +        uint8_t rsvd1[6];
> > +        struct {
> > +            uint64_t base;
> > +            uint64_t decode_len;
> > +            uint64_t region_len;
> > +            uint64_t block_size;
> > +            uint32_t dsmadhandle;
> > +            uint8_t flags;
> > +            uint8_t rsvd2[3];
> > +        } QEMU_PACKED records[];
> > +        /*
> > +         * if cxl spec version >= 3.1, extra output payload as defined
> > +         * in struct get_dyn_cap_config_out_pl_extra comes here.
> > +         */
> > +    } QEMU_PACKED;
>     } QEMU_PACKED *out;
> > +
> > +    struct get_dyn_cap_config_in_pl *in = (void *)payload_in;
> > +    struct get_dyn_cap_config_out_pl *out = (void *)payload_out;
> 
> We've (mostly) use the (void *) casting where we haven't given the structures
> a type.  I think I'd prefer we kept to that style for consistency.
> 
> There is an argument we should have given all these types
> for readability reasons and to avoid casting via void * but
> we have gone this way now - with the exception of
> the poison list - oops.   
> 
> > +    uint16_t record_count = 0;
> > +    uint16_t i;
> > +    uint16_t out_pl_len;
> > +    uint8_t start_region_id = in->start_region_id;
> > +#ifdef CXL_SPEC_AFTER_R30
> 
> Handy for testing, but I'd drop the ifdef for the final
> version.  We don't need to support old specs.
> 
> > +    struct get_dyn_cap_config_out_pl_extra {
> > +        uint32_t num_extents_supported;
> > +        uint32_t num_extents_available;
> > +        uint32_t num_tags_supported;
> > +        uint32_t num_tags_available;
> > +    } QEMU_PACKED;
> > +    struct get_dyn_cap_config_out_pl_extra *extra_out;
> As above, anonymous structure should work ok.
> > +#endif
> > +
> > +    if (start_region_id >= ct3d->dc.num_regions) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
> > +            in->region_cnt);
> > +
> > +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> > +#ifdef CXL_SPEC_AFTER_R30
> > +    extra_out = (struct get_dyn_cap_config_out_pl_extra *)(payload_out +
> > +            out_pl_len);
> > +    out_pl_len += sizeof(struct get_dyn_cap_config_out_pl_extra);
> > +#endif
> > +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> > +
> > +    out->num_regions = ct3d->dc.num_regions;
> > +#ifdef CXL_SPEC_AFTER_R30
> > +    out->regions_returned = record_count;
> > +#endif
> > +    for (i = 0; i < record_count; i++) {
> > +        stq_le_p(&out->records[i].base,
> > +                ct3d->dc.regions[start_region_id + i].base);
> Qemu allows a couple of style choices, but don't think this matches any of them.
> https://elixir.bootlin.com/qemu/latest/source/docs/devel/style.rst#L79
> 
> My preference is immediately after opening bracket.
> 
> 
> > +        stq_le_p(&out->records[i].decode_len,
> > +                ct3d->dc.regions[start_region_id + i].decode_len /
> > +                CXL_CAPACITY_MULTIPLIER);
> > +        stq_le_p(&out->records[i].region_len,
> > +                ct3d->dc.regions[start_region_id + i].len);
> > +        stq_le_p(&out->records[i].block_size,
> > +                ct3d->dc.regions[start_region_id + i].block_size);
> > +        stl_le_p(&out->records[i].dsmadhandle,
> > +                ct3d->dc.regions[start_region_id + i].dsmadhandle);
> > +        out->records[i].flags = ct3d->dc.regions[start_region_id + i].flags;
> > +    }
> > +#ifdef CXL_SPEC_AFTER_R30
> > +    /*FIXME: need to set valid values in the future*/
> 
> We need to do that before upstreaming..
> For tags, 0 is fine for now.
> 
> For extents allow say 512 and count how many are in lists
> I guess then subtract that.
> 
> > +    stq_le_p(&extra_out->num_extents_supported, 0);
> > +    stq_le_p(&extra_out->num_extents_available, 0);
> > +    stq_le_p(&extra_out->num_tags_supported, 0);
> > +    stq_le_p(&extra_out->num_tags_available, 0);
> > +#endif
> > +
> > +    *len_out = out_pl_len;
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> >  #define IMMEDIATE_DATA_CHANGE (1 << 2)
> >  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> > @@ -1282,6 +1382,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >          cmd_media_clear_poison, 72, 0 },
> >  };
> >  
> > +static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
> > +    [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
> > +        cmd_dcd_get_dyn_cap_config, 2, 0 },
> > +};
> > +
> >  static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> >      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
> >      [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
> > @@ -1487,7 +1592,12 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
> >  
> >  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
> >  {
> > +    CXLType3Dev *ct3d = CXL_TYPE3(d);
> > +
> >      cxl_copy_cci_commands(cci, cxl_cmd_set);
> > +    if (ct3d->dc.num_regions) {
> > +        cxl_copy_cci_commands(cci, cxl_cmd_set_dcd);
> > +    }
> >      cci->d = d;
> >  
> >      /* No separation for PCI MB as protocol handled in PCI device */
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 3cf3077afa..6df7fecdf1 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -422,6 +422,17 @@ typedef struct CXLPoison {
> >  typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
> >  #define CXL_POISON_LIST_LIMIT 256
> >  
> > +#define DCD_MAX_REGION_NUM 8
> Really trivial but call this 
> 
> DCD_MAX_NUM_REGION because it's the maximum number of
> regions. The maximum region number is 7 (as zero indexed).
> 
> > +
> > +typedef struct CXLDCDRegion {
> > +    uint64_t base;
> Probably makes sense to call out that bas also aligned to 256 MiB
> as not immediately clear the comment applies to both.
> Easiest will be to duplicate it.
> > +    uint64_t decode_len; /* aligned to 256*MiB */
> > +    uint64_t len;
> > +    uint64_t block_size;
> > +    uint32_t dsmadhandle;
> > +    uint8_t flags;
> > +} CXLDCDRegion;
> > +
> >  struct CXLType3Dev {
> >      /* Private */
> >      PCIDevice parent_obj;
> > @@ -454,6 +465,11 @@ struct CXLType3Dev {
> >      unsigned int poison_list_cnt;
> >      bool poison_list_overflowed;
> >      uint64_t poison_list_overflow_ts;
> > +
> > +    struct dynamic_capacity {
> > +        uint8_t num_regions; /* 0-8 regions */
> > +        CXLDCDRegion regions[DCD_MAX_REGION_NUM];
> > +    } dc;
> >  };
> >  
> >  #define TYPE_CXL_TYPE3 "cxl-type3"
> 

