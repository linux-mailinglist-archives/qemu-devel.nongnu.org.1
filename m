Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6812E70319D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 17:32:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyaBN-0001E1-Je; Mon, 15 May 2023 11:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1pyaBL-0001Cb-KD
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:32:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1pyaBJ-0002eD-Or
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:32:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f42397f41fso365025e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1684164732; x=1686756732;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tfPMKicn6lKSmTgfVTGZRT9lB9q0BAQYSeSm0pWVGCU=;
 b=Q9GQf1bmReXkkgOOmAjFOohiZHHu6nMq60F2UQJ4U7tQkfkpRRGWcLMl1y8jwFaGVW
 SIp9HextRaeTXU8UGJoI35mPcBDoEb2fPAoWxULboDwu8ErqUbF/3T13Zu6y0GKpSPIR
 fjLotBJopv0xYMrxnR92LvzLNbgu6BrX5f8pZl5ObQoALvPQzuK/INWwSD9Gy/V1SPKt
 gk92OT9o4eMESnUILSflNDXVUwH+6W/SZMOtpfDNpjkaxkHNOtldkp/X7QW+Y5c9wRLS
 5ZMYJFgr76gHXM3blBmC0oG2N200S4mhEkGeYsuzpt3hjDRtdIfTqYaE1QEqsNGZUq8W
 J5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684164732; x=1686756732;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tfPMKicn6lKSmTgfVTGZRT9lB9q0BAQYSeSm0pWVGCU=;
 b=RmOAFGJpgDaNbm5sDymegGkqYfHx1lbdNdmlO9K2KvsEIGH59bgdZ9s/AL9ykDyTTs
 iePWpleLiBmmILX1PZZ2hYiP5VHfge2Gp10ddWegCETTcAYqbPJkoOMG54Qsd2sM9xXr
 G62CjTTfbYF0iECXON+edtOKICmy1vBAlES2ZRPsae59lxM3VTVkaJvkHRYP0plvOkT7
 +KPTMr3SIFoRTVd+3YTmTyVzsTNqFO2PueMYXtuFDQRrpLewQmiM/PFFTiZUjQ/HOSWv
 7izQvEmtoJHaHtySjTr/r4nz4UBxi0NuDG/lq5/5hoBu7PR8exYQLPEcycZUuSB0EY2I
 7Qxg==
X-Gm-Message-State: AC+VfDxNpi/sNIlO80kE0/4izNzOafMBfGTjrucww52kMm765Hsc8DIk
 B8BoIPHuY5PrhTo+LdOCi7bESw==
X-Google-Smtp-Source: ACHHUZ5u2m+ReQM0WKoluqacpTNG7KkeClVUTbcPBtjwBuCiD1vEqZ7PCGKRq297isrAF6a4DCI6bg==
X-Received: by 2002:a05:600c:1c81:b0:3f3:3855:c5d8 with SMTP id
 k1-20020a05600c1c8100b003f33855c5d8mr16529wms.6.1684164731794; 
 Mon, 15 May 2023 08:32:11 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com.
 [34.78.232.44]) by smtp.gmail.com with ESMTPSA id
 s6-20020adff806000000b0030732d6e104sm34762wrp.105.2023.05.15.08.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 08:32:11 -0700 (PDT)
Date: Mon, 15 May 2023 15:32:06 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, jean-philippe@linaro.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, richard.henderson@linaro.org
Subject: Re: [RFC PATCH v3 08/10] hw/arm/smmuv3: Add CMDs related to stage-2
Message-ID: <ZGJQdp5nVVEGlOzt@google.com>
References: <20230401104953.1325983-1-smostafa@google.com>
 <20230401104953.1325983-9-smostafa@google.com>
 <ee890a2b-946e-1a04-4f00-b7c60b31af76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee890a2b-946e-1a04-4f00-b7c60b31af76@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=smostafa@google.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Hi Eric,

On Mon, May 15, 2023 at 04:14:16PM +0200, Eric Auger wrote:
> Hi Mostafa,
> On 4/1/23 12:49, Mostafa Saleh wrote:
> > CMD_TLBI_S2_IPA: As S1+S2 is not enabled, for now this can be the
> > same as CMD_TLBI_NH_VAA.
> >
> > CMD_TLBI_S12_VMALL: Added new function to invalidate TLB by VMID.
> >
> > For stage-1 only commands, add a check to throw CERROR_ILL if used
> > when stage-1 is not supported.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> > Changes in v3:
> > - Log guest error for all illegal commands.
> > Changes in v2:
> > - Add checks for stage-1 only commands
> > - Rename smmuv3_s1_range_inval to smmuv3_range_inval
> > ---
> >  hw/arm/smmu-common.c         | 16 +++++++++++
> >  hw/arm/smmuv3.c              | 53 ++++++++++++++++++++++++++++++------
> >  hw/arm/trace-events          |  4 ++-
> >  include/hw/arm/smmu-common.h |  1 +
> >  4 files changed, 65 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > index 72ed6edd48..45e9d7e752 100644
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -135,6 +135,16 @@ static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
> >  
> >      return SMMU_IOTLB_ASID(*iotlb_key) == asid;
> >  }
> > +
> > +static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
> > +                                         gpointer user_data)
> > +{
> > +    uint16_t vmid = *(uint16_t *)user_data;
> > +    SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
> > +
> > +    return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
> > +}
> > +
> >  static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
> >                                                gpointer user_data)
> >  {
> > @@ -187,6 +197,12 @@ void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
> >      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
> >  }
> >  
> > +inline void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
> > +{
> > +    trace_smmu_iotlb_inv_vmid(vmid);
> > +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
> > +}
> > +
> >  /* VMSAv8-64 Translation */
> >  
> >  /**
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index d7e7003da9..3b5b1fad1a 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -1069,7 +1069,7 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova,
> >      }
> >  }
> >  
> > -static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
> > +static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
> >  {
> >      dma_addr_t end, addr = CMD_ADDR(cmd);
> >      uint8_t type = CMD_TYPE(cmd);
> > @@ -1094,7 +1094,7 @@ static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
> >      }
> >  
> >      if (!tg) {
> > -        trace_smmuv3_s1_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
> > +        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
> >          smmuv3_inv_notifiers_iova(s, asid, addr, tg, 1);
> >          smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
> >          return;
> > @@ -1112,7 +1112,7 @@ static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
> >          uint64_t mask = dma_aligned_pow2_mask(addr, end, 64);
> >  
> >          num_pages = (mask + 1) >> granule;
> > -        trace_smmuv3_s1_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
> > +        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
> >          smmuv3_inv_notifiers_iova(s, asid, addr, tg, num_pages);
> >          smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
> >          addr += mask + 1;
> > @@ -1246,12 +1246,22 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
> >          {
> >              uint16_t asid = CMD_ASID(&cmd);
> >  
> > +            if (!STAGE1_SUPPORTED(s)) {
> > +                cmd_error = SMMU_CERROR_ILL;
> > +                break;
> > +            }
> > +
> >              trace_smmuv3_cmdq_tlbi_nh_asid(asid);
> >              smmu_inv_notifiers_all(&s->smmu_state);
> >              smmu_iotlb_inv_asid(bs, asid);
> >              break;
> >          }
> >          case SMMU_CMD_TLBI_NH_ALL:
> > +            if (!STAGE1_SUPPORTED(s)) {
> > +                cmd_error = SMMU_CERROR_ILL;
> > +                break;
> > +            }
> > +            QEMU_FALLTHROUGH;
> >          case SMMU_CMD_TLBI_NSNH_ALL:
> >              trace_smmuv3_cmdq_tlbi_nh();
> >              smmu_inv_notifiers_all(&s->smmu_state);
> > @@ -1259,7 +1269,34 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
> >              break;
> >          case SMMU_CMD_TLBI_NH_VAA:
> >          case SMMU_CMD_TLBI_NH_VA:
> > -            smmuv3_s1_range_inval(bs, &cmd);
> > +            if (!STAGE1_SUPPORTED(s)) {
> > +                cmd_error = SMMU_CERROR_ILL;
> > +                break;
> > +            }
> > +            smmuv3_range_inval(bs, &cmd);
> > +            break;
> > +        case SMMU_CMD_TLBI_S12_VMALL:
> > +            uint16_t vmid = CMD_VMID(&cmd);
> I get
> ../hw/arm/smmuv3.c: In function ‘smmuv3_cmdq_consume’:
> ../hw/arm/smmuv3.c:1295:13: error: a label can only be part of a
> statement and a declaration is not a statement
>              uint16_t vmid = CMD_VMID(&cmd);
> 
> you should put the case into a block.

Thanks for spotting this, I will fix it.
Can you please let me know your config/build commands?
as I didn't get errors when compiling it.

Thanks,
Mostafa


