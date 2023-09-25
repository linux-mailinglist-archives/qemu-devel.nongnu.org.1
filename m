Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4777AD9F3
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmOs-0007Oo-Uk; Mon, 25 Sep 2023 10:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qkmOo-0007OJ-JU
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qkmOd-0002Ql-I7
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695651430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+LhlsXh51BiH0ZAXqB2Z17Sb5XSU5+xpDyFuAFPTls=;
 b=BARnXSEvmRZzjCjMUe+YzfFFSPO0DjhVowQMKS8qdq5MjyroEWRY0D7ImPxq6ZSBnkuS3f
 BhsWnS2ew0DIGmJmNR+qmGpCHb0NvP2nKQ/+a8opUbu0IvmCL65kdd13ZobtLZFmoe4pXy
 GDD9SmkJHdLzg9LPE6L4dYQtVZoOGdQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-xrn55z7hPFWCuRKVKXDykw-1; Mon, 25 Sep 2023 10:17:08 -0400
X-MC-Unique: xrn55z7hPFWCuRKVKXDykw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9ae70250ef5so1129058266b.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695651427; x=1696256227;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l+LhlsXh51BiH0ZAXqB2Z17Sb5XSU5+xpDyFuAFPTls=;
 b=dBnES9eNpMU5F3FJ9RWFiGdVnsnreqmfo9m+AF8jXDfpygU8AzmTgqaIkOXGNWKQP0
 1WVnREl6m4VfiPYvaWbuZoiAwpoABcuFg/iO/Zq1JSbAQwnrD32pITPf98b9wk+hDvCR
 U6SA7GUrcgA7SYoAYEIY1Oqv40GH24uSo30a3ZFO/MhQKHPG8Wujhi5UcOBmDpSkjA8q
 2HxX4yl/MGHH+FHeb/wP6LlZhKrR9nzVoaZsvgom5n+9SnKV0CmVxaI92ruQVxtj/HK4
 oOTZiR8dqd22Y6NpPok1wACaHZIcOOFcQk3NjzzN62rrUwyvkMzPo0UgY2FOrwenWr9G
 2Nsw==
X-Gm-Message-State: AOJu0YygjHhaNNXstJR6OJOIuwWbKBTwYy/JEspiQQfg4+cJoi4/ejbd
 PhCju0Ap2L6KPdhC8SjqBFI5KZuQuJ/qpMlEi2ljMQAbF+ogECOCECWcnhpFb53WZGDCNLd7DeA
 Ol6eWb9eyF2IBaWS3TOO12Mc=
X-Received: by 2002:a17:906:5357:b0:993:eee4:e704 with SMTP id
 j23-20020a170906535700b00993eee4e704mr9879978ejo.38.1695651426786; 
 Mon, 25 Sep 2023 07:17:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1vdhSSeDIr5oWGfzOq2/la83y9H8xOyd1uczc2ZciyZyNxB/BsR+U5DNK/YhQs4TfkU4lHg==
X-Received: by 2002:a17:906:5357:b0:993:eee4:e704 with SMTP id
 j23-20020a170906535700b00993eee4e704mr9879951ejo.38.1695651426482; 
 Mon, 25 Sep 2023 07:17:06 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 dt11-20020a170906b78b00b009ae482d70besm6311081ejb.134.2023.09.25.07.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Sep 2023 07:17:05 -0700 (PDT)
Message-ID: <ce017f83-672c-392f-7be9-12ec5fe52166@redhat.com>
Date: Mon, 25 Sep 2023 16:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] qcow2: keep reference on zeroize with discard-no-unref
 enabled
Content-Language: en-US
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 kwolf@redhat.com
References: <20230905130839.923041-2-jean-louis@dupond.be>
 <1088caf4-3f59-84be-25d4-f2574674cb2a@redhat.com>
 <0208337f-92ac-4019-909b-2c3d333c46de@dupond.be>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <0208337f-92ac-4019-909b-2c3d333c46de@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, SPF_HELO_NONE=0.001,
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

On 25.09.23 13:40, Jean-Louis Dupond wrote:
> On 15/09/2023 13:21, Hanna Czenczek wrote:
>> On 05.09.23 15:08, Jean-Louis Dupond wrote:
>>> When the discard-no-unref flag is enabled, we keep the reference for
>>> normal discard requests.
>>> But when a discard is executed on a snapshot/qcow2 image with backing,
>>> the discards are saved as zero clusters in the snapshot image.
>>>
>>> When committing the snapshot to the backing file, not
>>> discard_in_l2_slice is called but zero_in_l2_slice. Which did not had
>>> any logic to keep the reference when discard-no-unref is enabled.
>>>
>>> Therefor we add logic in the zero_in_l2_slice call to keep the 
>>> reference
>>> on commit.
>>>
>>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
>>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>>> ---
>>>   block/qcow2-cluster.c | 22 ++++++++++++++++++----
>>>   1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> The code looks OK, but the obvious problem I find is that this is not 
>> what the discard-no-unref option describes.  It talks about discards, 
>> but this now changes the zero-write path.
> But it's still touching the discard code in the zeroize code path.
> Cause we modify the way zeroize does its discard (when 
> BDRV_REQ_MAY_UNMAP)

I find there’s a difference between discard code handling discards from 
the guest, and code handling zero-writes from the guest that internally 
issues discards.  I see your POV, but the documentation isn’t clear that 
not unref'ing on discards not only affects discards issued by the guest, 
but also internal discards that have been generated upon write-zero from 
the guest.

>>
>> I’m fairly certain that you are the only one using this option for 
>> now, so we might as well change its definition to include zero writes 
>> for 8.2, but we should do that.
> I agree. How would you name the option then? Cause it still involves 
> discard-only code.

I wouldn’t change the name, just the definition (description).

Hanna

> Next to that, the option was already added to libvirt also (so this 
> needs to be fixed afterwards also).
>>
>> Hanna
>>
>


