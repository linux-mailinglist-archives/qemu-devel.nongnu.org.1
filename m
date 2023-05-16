Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C83687054AF
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 19:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyy6W-0006HO-Nc; Tue, 16 May 2023 13:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1pyy6P-0006Gq-3s
 for qemu-devel@nongnu.org; Tue, 16 May 2023 13:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1pyy6N-0002FS-1s
 for qemu-devel@nongnu.org; Tue, 16 May 2023 13:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684256680;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DE0crb5nt/lDpVbr+ZJbSAYYi2flBYNvwiznu7TOMQ=;
 b=B6kjRehGFmo97/5zM5mRoq6EGmzHrBqiWYB0pPBvHg3kMugw9S/Lq9JSqozrF+jJnJmeo9
 cyTpYouf4wAA70Xaz0DuQmHRI5Z7KYmftJGYjqozicXSlr9TkWedIomPLsUAxBlxy+7qQf
 eBe8VV0nqkKqR8dGSsPvYTs0egAFPT8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-XRo24hxtPQK50pbhzcmmaw-1; Tue, 16 May 2023 13:04:39 -0400
X-MC-Unique: XRo24hxtPQK50pbhzcmmaw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f4deee3ec6so83652931cf.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 10:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684256678; x=1686848678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4DE0crb5nt/lDpVbr+ZJbSAYYi2flBYNvwiznu7TOMQ=;
 b=XEl26j5pd5y7s5xjV5ICuRWmDu8p846rO6HMtcLwyww95FQzxVGjeACTm2QNGsPEkp
 gB0TTd6/Wmu96n91gTsWoM6qLr68/MDu4XZLD2viDb2ZqNovULHsz8FOP0laa/HqUL5a
 Awj00EqL80YAoGjDXRF0d1/oofzZLQaePvkisyKc5Q27MEpOivPcXDg1ngqxlwGWGCPF
 QGa2uKvgTQik5COOANyFprAZpbnqNIcgGoKmzoCKKK3l0qdAa95IhOSouqov8ecFQZFi
 /5beZOl9njMoRyI7OI73Lmix85Q07fmVVAkXf97w+MAe3/iqwGrU3wDs0w+AcIHAFTCJ
 FuWg==
X-Gm-Message-State: AC+VfDz8M4vw7SgS3MYX8leAgJaqGcNfrsQ/ODoJFKLc5/akfCkPk0y+
 D9h6Ll0EZlw24YEcIryst8WDOFSY2V2YhsQCRWbDEu4Xkn7/zM2SvWUOqX02MqJwHNFSn1ceM3U
 nOyCOXZna/2ZGblA=
X-Received: by 2002:ac8:5bca:0:b0:3f3:87c5:6d2d with SMTP id
 b10-20020ac85bca000000b003f387c56d2dmr57849719qtb.5.1684256678374; 
 Tue, 16 May 2023 10:04:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Ijw64nnv04EVGTyFBKRmRKXC31Ot8VMCAKesA7vHOQw441gRcbGwLRoj+85Zfnhh5ZHDAHg==
X-Received: by 2002:ac8:5bca:0:b0:3f3:87c5:6d2d with SMTP id
 b10-20020ac85bca000000b003f387c56d2dmr57849670qtb.5.1684256677855; 
 Tue, 16 May 2023 10:04:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 c25-20020ae9e219000000b0075939692d18sm713956qkc.83.2023.05.16.10.04.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 10:04:36 -0700 (PDT)
Message-ID: <3ffa498c-9702-e905-fcd9-9357ad9aee1c@redhat.com>
Date: Tue, 16 May 2023 19:04:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH v3 08/10] hw/arm/smmuv3: Add CMDs related to stage-2
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-devel@nongnu.org, jean-philippe@linaro.org,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, richard.henderson@linaro.org
References: <20230401104953.1325983-1-smostafa@google.com>
 <20230401104953.1325983-9-smostafa@google.com>
 <ee890a2b-946e-1a04-4f00-b7c60b31af76@redhat.com>
 <ZGJQdp5nVVEGlOzt@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ZGJQdp5nVVEGlOzt@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.666, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Mostafa,

On 5/15/23 17:32, Mostafa Saleh wrote:
> Hi Eric,
>
> On Mon, May 15, 2023 at 04:14:16PM +0200, Eric Auger wrote:
>> Hi Mostafa,
>> On 4/1/23 12:49, Mostafa Saleh wrote:
>>> CMD_TLBI_S2_IPA: As S1+S2 is not enabled, for now this can be the
>>> same as CMD_TLBI_NH_VAA.
>>>
>>> CMD_TLBI_S12_VMALL: Added new function to invalidate TLB by VMID.
>>>
>>> For stage-1 only commands, add a check to throw CERROR_ILL if used
>>> when stage-1 is not supported.
>>>
>>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>>> ---
>>> Changes in v3:
>>> - Log guest error for all illegal commands.
>>> Changes in v2:
>>> - Add checks for stage-1 only commands
>>> - Rename smmuv3_s1_range_inval to smmuv3_range_inval
>>> ---
>>>  hw/arm/smmu-common.c         | 16 +++++++++++
>>>  hw/arm/smmuv3.c              | 53 ++++++++++++++++++++++++++++++------
>>>  hw/arm/trace-events          |  4 ++-
>>>  include/hw/arm/smmu-common.h |  1 +
>>>  4 files changed, 65 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>> index 72ed6edd48..45e9d7e752 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -135,6 +135,16 @@ static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
>>>  
>>>      return SMMU_IOTLB_ASID(*iotlb_key) == asid;
>>>  }
>>> +
>>> +static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
>>> +                                         gpointer user_data)
>>> +{
>>> +    uint16_t vmid = *(uint16_t *)user_data;
>>> +    SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>>> +
>>> +    return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
>>> +}
>>> +
>>>  static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
>>>                                                gpointer user_data)
>>>  {
>>> @@ -187,6 +197,12 @@ void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
>>>      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
>>>  }
>>>  
>>> +inline void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
>>> +{
>>> +    trace_smmu_iotlb_inv_vmid(vmid);
>>> +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
>>> +}
>>> +
>>>  /* VMSAv8-64 Translation */
>>>  
>>>  /**
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index d7e7003da9..3b5b1fad1a 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -1069,7 +1069,7 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova,
>>>      }
>>>  }
>>>  
>>> -static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
>>> +static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
>>>  {
>>>      dma_addr_t end, addr = CMD_ADDR(cmd);
>>>      uint8_t type = CMD_TYPE(cmd);
>>> @@ -1094,7 +1094,7 @@ static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
>>>      }
>>>  
>>>      if (!tg) {
>>> -        trace_smmuv3_s1_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
>>> +        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
>>>          smmuv3_inv_notifiers_iova(s, asid, addr, tg, 1);
>>>          smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
>>>          return;
>>> @@ -1112,7 +1112,7 @@ static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
>>>          uint64_t mask = dma_aligned_pow2_mask(addr, end, 64);
>>>  
>>>          num_pages = (mask + 1) >> granule;
>>> -        trace_smmuv3_s1_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
>>> +        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
>>>          smmuv3_inv_notifiers_iova(s, asid, addr, tg, num_pages);
>>>          smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
>>>          addr += mask + 1;
>>> @@ -1246,12 +1246,22 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>>          {
>>>              uint16_t asid = CMD_ASID(&cmd);
>>>  
>>> +            if (!STAGE1_SUPPORTED(s)) {
>>> +                cmd_error = SMMU_CERROR_ILL;
>>> +                break;
>>> +            }
>>> +
>>>              trace_smmuv3_cmdq_tlbi_nh_asid(asid);
>>>              smmu_inv_notifiers_all(&s->smmu_state);
>>>              smmu_iotlb_inv_asid(bs, asid);
>>>              break;
>>>          }
>>>          case SMMU_CMD_TLBI_NH_ALL:
>>> +            if (!STAGE1_SUPPORTED(s)) {
>>> +                cmd_error = SMMU_CERROR_ILL;
>>> +                break;
>>> +            }
>>> +            QEMU_FALLTHROUGH;
>>>          case SMMU_CMD_TLBI_NSNH_ALL:
>>>              trace_smmuv3_cmdq_tlbi_nh();
>>>              smmu_inv_notifiers_all(&s->smmu_state);
>>> @@ -1259,7 +1269,34 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>>              break;
>>>          case SMMU_CMD_TLBI_NH_VAA:
>>>          case SMMU_CMD_TLBI_NH_VA:
>>> -            smmuv3_s1_range_inval(bs, &cmd);
>>> +            if (!STAGE1_SUPPORTED(s)) {
>>> +                cmd_error = SMMU_CERROR_ILL;
>>> +                break;
>>> +            }
>>> +            smmuv3_range_inval(bs, &cmd);
>>> +            break;
>>> +        case SMMU_CMD_TLBI_S12_VMALL:
>>> +            uint16_t vmid = CMD_VMID(&cmd);
>> I get
>> ../hw/arm/smmuv3.c: In function ‘smmuv3_cmdq_consume’:
>> ../hw/arm/smmuv3.c:1295:13: error: a label can only be part of a
>> statement and a declaration is not a statement
>>              uint16_t vmid = CMD_VMID(&cmd);
>>
>> you should put the case into a block.
> Thanks for spotting this, I will fix it.
> Can you please let me know your config/build commands?
> as I didn't get errors when compiling it.
I used a very basic config:

configure --target-list=aarch64-softmmu --enable-kvm
--enable-trace-backends=log

Eric
>
> Thanks,
> Mostafa
>


