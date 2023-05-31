Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D60718055
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:50:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LFf-0004We-5i; Wed, 31 May 2023 08:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q4LFa-0004W0-Bs
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q4LFX-0005Z3-5i
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685537300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntEs0IbJ1p9DsSVR/9Jj4j/fTMNsMK8VjE8hCwcD2pQ=;
 b=NVsBuXKXH2nBKy1K/3PYVFq/6YKTD4GQAMvkk6mfpUdYYG4pYbcaGFEEWX6qSvbqZMD/wn
 jVDM1Wf7ALeCR/1CEiS0jUex3iT3MAUNcqeINIBvh2yk/IE1e+IFCr5stIP4q68J+doREW
 g7mwWIkFkUS+XvlrV6XMBsnGQ1KQVw4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-MlmSzYEqPnKTkoaViWtN3A-1; Wed, 31 May 2023 08:48:18 -0400
X-MC-Unique: MlmSzYEqPnKTkoaViWtN3A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96fe843f61eso576394166b.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 05:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685537297; x=1688129297;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ntEs0IbJ1p9DsSVR/9Jj4j/fTMNsMK8VjE8hCwcD2pQ=;
 b=MQZ1z9ZRzf4aKIImCeh+TF8eG2GDXsQGOJCihTQGl4bRAf9PAmdHE/xI4jvTEr0gxU
 vxinXw0kVtVbWmNJhYVlnOBsK0KPa8kjQTOsU/hYOOAi+pOTL1GVNaeSPzikJgkrqXFz
 hUi3qFChBz9smndGp7ZMIeFGJzUAu4YUTEw71h9jfef69k06n+E9ejYS/VmEu6zYx/TZ
 vQi7RNmNSINOR8GjMdnN25nkoKuvBX+L7wOouTRnyHJ1uV8lgOG+vDwDg/AROMIyjlul
 WC++T6Ds6OHtN+6EdWDTWBH/vvW3OmbXGgW+/LL5pnoTcKMJj/8LbPnZ67bUTNom45Cp
 Zs5Q==
X-Gm-Message-State: AC+VfDwFAd8zi6ruFc04Xc9fuZwUyD8D7YcdjtrQfPA2GHGRVddoYsOT
 wJ6/USxFZKoEAPGn5uBsAH5Y7hTjvxIfahyxGmmoYbsrg7a7ExmraNO7dvGhM38OMyK17tPDFE/
 8FWaH02sseAmba/g=
X-Received: by 2002:a17:907:74d:b0:96f:cb23:daf6 with SMTP id
 xc13-20020a170907074d00b0096fcb23daf6mr4709150ejb.40.1685537297716; 
 Wed, 31 May 2023 05:48:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uL3sCHCFryu5rFspuv+5w1K1e5LlJv0mEq9BHG3jSB/8SDHJ8fyFtw5CDAihX0ygYnPCT8A==
X-Received: by 2002:a17:907:74d:b0:96f:cb23:daf6 with SMTP id
 xc13-20020a170907074d00b0096fcb23daf6mr4709133ejb.40.1685537297362; 
 Wed, 31 May 2023 05:48:17 -0700 (PDT)
Received: from ?IPV6:2003:cf:d72e:f7e0:1010:46a4:2212:92f9?
 (p200300cfd72ef7e0101046a4221292f9.dip0.t-ipconnect.de.
 [2003:cf:d72e:f7e0:1010:46a4:2212:92f9])
 by smtp.gmail.com with ESMTPSA id
 os5-20020a170906af6500b0094e62aa8bcesm8861624ejb.29.2023.05.31.05.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 05:48:16 -0700 (PDT)
Message-ID: <4c0ae8fa-7a57-b71a-652c-36405604bdac@redhat.com>
Date: Wed, 31 May 2023 14:48:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] qcow2: add discard-no-unref option
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 kwolf@redhat.com
References: <20230515073644.166677-1-jean-louis@dupond.be>
 <592e1caf-851a-7af0-2182-b70a62b6f826@redhat.com>
 <065a97d8-f1e5-d87b-06ef-989910b033ee@dupond.be>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <065a97d8-f1e5-d87b-06ef-989910b033ee@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26.05.23 16:30, Jean-Louis Dupond wrote:
> On 26/05/2023 15:31, Hanna Czenczek wrote:
>>
[...]

>> I don’t follow how this patch is cleaner than the “block: Add zeroes 
>> discard option” patch.  That patch’s diff stat is +14/-5, this one’s 
>> is 120+/57-.
> Multiple reasons :)
> - It's made for this use-case only, as there might be no other 
> use-cases except this one so the scope for discard=zeroes might be to big

That sounds either like a disadvantage (only usable for qcow2), or like 
it makes no practical difference because even with the other approach, 
only qcow2 would support this kind of zeroing anyway.  In terms of 
complexity, I don’t really see the difference whether this is a global 
flag for all formats or just for qcow2.

> - This one still handles the discards and passes it to the lower 
> layer, which might be an important reason for the fact you enable 
> discards

Indeed this is an important benefit that probably conflicts with and 
outweighs point 1 above, though not really a reason why this patch would 
be “cleaner”.

> - The diffstat is mostly bigger because of indention changes in 
> update_refcount

The fact that update_refcount() is updated at all is reason for caution 
to me.  Changing how refcounts are updated is generally more on the 
dangerous side of things.

Furthermore, going from a net total of +9 to +63 can’t be explained 
solely through indentation changes.  I understand some of it is also 
comments and documentation, but, well.

Now that I understand this patch better, I can see that it probably 
better fulfills the intended purpose, but it still seems less clean to 
me.  Not that it really matters; I was just wondering because you 
advertised it as cleaner. O:)

>>
>> As for better, I don’t want to discount that, but at the same time I 
>> don’t know the reasoning for it.  As far as I understand, this patch 
>> makes qcow2 retain the cluster mapping as-is, and only discards on 
>> the lower layer.  So effectively, instead of marking the cluster as 
>> zero on the qcow2 level, we do so on the filesystem level.  I’m not 
>> sure I see all the implications of that difference.
> We want to keep the cluster mapping to avoid creating holes in the 
> qcow2 cluster.
> But we still want to do discards for 2 reasons:
> - Mark the cluster as ZERO, so that incremental backups using dirty 
> bitmaps can just skip this block
> - Discard the data on the lower layer for efficiency reasons (for 
> example if the lower layer has some dedup/compression/whatever), we 
> still want the lower layer to know the block has been emptied

Agreed, I missed that the cluster is stilled marked as ZERO.

>>
>> The advantage I see is that this free up disk space, which the 
>> discard=zeroes wouldn’t do.  I wonder whether that couldn’t be solved 
>> with an orthogonal qcow2-only option, though, which would have the 
>> qcow2 driver always discard zeroed clusters.
> This is an option also indeed. But we will end up with a similar patch 
> (also in size).
>>
>> On the other hand, one thing to note is that we’ve had performance 
>> problems in the past with holes in the filesystem level (on tmpfs at 
>> least).  qemu generally can get the information on which clusters are 
>> zero quicker from qcow2 than from the filesystem, which suggests that 
>> even if we want to discard something on the filesystem layer, we 
>> probably also want to mark it as zero on the qcow2 layer.
> This is what we do in discard_in_l2_slice, we mark the entry as 
> QCOW_OFLAG_ZERO when we receive a discard request.

Thanks!  I missed that.

>>
>> I also have a small concern about fragmentation on the filesystem 
>> layer – if you use these options to prevent fragmentation, with this 
>> patch, you’re only doing so on the qcow2 layer.  Because the cluster 
>> is then discarded in the filesystem, it’s possible to get 
>> fragmentation there, which might not be desirable.  I don’t think 
>> that’s too important, but I think it’d just be nice to have a 
>> configuration in which the guest can tell qemu what areas it doesn’t 
>> care about, qemu marks these as zero, so that backups are more 
>> efficient; but at the same time, everything stays allocated, so no 
>> fragmentatoin is introduced.
> That would be an additional option/improvement indeed. But it's not 
> that this patch makes the fragmentation worse then it's already the 
> case when you enable discard.

It doesn’t, but then again, it is supposed to reduce fragmentation. Only 
qcow2 fragmentation, right, but the direction is there.  On the other 
hand...

> If you really want this you might even want your lower level storage 
> to just ignore discards instead of fixing it in qcow2.

...this makes much more sense!  Agreed.


I missed the fact that this patch still marks the cluster as zero on the 
qcow2 level.  I agree that it’s better to keep the discard on the lower 
layer, which the other patch variant can’t achieve, so there is merit to 
this approach.  I’ll go about reviewing the patch in detail!

Hanna


