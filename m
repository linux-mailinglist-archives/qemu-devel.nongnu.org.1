Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E4772A49
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:15:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2sf-0004LS-1N; Mon, 07 Aug 2023 12:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qT2sd-0004L2-Du
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qT2sb-0006Bd-U8
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691424889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lSeNlh+WXjXUEQvSjoP3YXDT4fG7Wgtst4AgoLr64DE=;
 b=a4oeJGGWBLG8VqBnPCA98X4hNoio+GBcW+P7QrUUfGfQJMAwG3ITNuZOHgTOifjdEWCUsj
 HlPKFhi23Rswv28s8oXpwbHtlRxIneGE/ZfEzA1puIAVn3H90I9V1ft9EsGwTNSrhMnv4y
 6nEef8dmURR2NkATrzWx1qgYVFWyuAc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-L-f_b_naMue4hTXmzBcOLw-1; Mon, 07 Aug 2023 12:14:47 -0400
X-MC-Unique: L-f_b_naMue4hTXmzBcOLw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3175b757bbfso2593796f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691424886; x=1692029686;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lSeNlh+WXjXUEQvSjoP3YXDT4fG7Wgtst4AgoLr64DE=;
 b=kdDn3d1nq6xeyfW5665Gzex5xctuHlUJF2Hui0AnmHpMxu6BYkLDv2pBoRUwpEOrHa
 s6/dGiHtUe5jp9rVwdQ/l1t8XmdDVMOXQx1i1X0z+5VzJkCAJTfompAIG5JLb4rl3VRt
 5w12vc192DSHr8SDtvSbGD542faAarPlaTMLEPvfDvbG0VmOfLO4Bmxkwokn/5jKXxDd
 Kd3CamO7y//RQXnEgmJspLFle+Oc8YJOv/jqhQacQORarT1hY2LPvBE9+gEzNMLCbKiN
 mW3lhbzdZNsmiK7WX1GANXeVWNu+9HNzbfqA+8tQ2twSZ11W7rJEIWndUblRQDPqKzDR
 a3lw==
X-Gm-Message-State: AOJu0YwQ5Lw2XmX2UZGIzc1zSOzmgXPwadvxfk2HssbLVJ2+3PsrtFdE
 LWKFI8ILckHKKG/CNLqoE0o/eYb9Fb7Rdsgib7KnKNfzG4ETU+xIIvYDDhDp40zjlOut6cAeUGp
 K/DF4iBloRw6tI51IJtbnUd4=
X-Received: by 2002:a5d:4584:0:b0:317:e515:d624 with SMTP id
 p4-20020a5d4584000000b00317e515d624mr3181130wrq.45.1691424885866; 
 Mon, 07 Aug 2023 09:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeCxpewBKwOeoLlzJbWvW44bV0/uXngExlV20Hjz1MxneUla3rlTidhjXvNy97tnSXbo7+sA==
X-Received: by 2002:a5d:4584:0:b0:317:e515:d624 with SMTP id
 p4-20020a5d4584000000b00317e515d624mr3181117wrq.45.1691424885507; 
 Mon, 07 Aug 2023 09:14:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:5d00:5143:1cd2:a300:ceff?
 (p200300cbc7405d0051431cd2a300ceff.dip0.t-ipconnect.de.
 [2003:cb:c740:5d00:5143:1cd2:a300:ceff])
 by smtp.gmail.com with ESMTPSA id
 c17-20020adffb11000000b00317efb41e44sm2191589wrr.18.2023.08.07.09.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 09:14:45 -0700 (PDT)
Message-ID: <365db0ec-4997-f561-f327-0fb2f1eee017@redhat.com>
Date: Mon, 7 Aug 2023 18:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] target/s390x: Define TARGET_HAS_PRECISE_SMC
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20230807114921.438881-1-iii@linux.ibm.com>
 <6961d8e4-7b26-b205-1ffd-4d4b721fe2e2@redhat.com>
 <983d4a7e033b5f1ee455468354d85dfa5f1306b6.camel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <983d4a7e033b5f1ee455468354d85dfa5f1306b6.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 07.08.23 18:13, Ilya Leoshkevich wrote:
> On Mon, 2023-08-07 at 17:31 +0200, David Hildenbrand wrote:
>> On 07.08.23 13:48, Ilya Leoshkevich wrote:
>>> PoP (Sequence of Storage References -> Instruction Fetching) says:
>>>
>>>       ... if a store that is conceptually earlier is
>>>       made by the same CPU using the same effective
>>>       address as that by which the instruction is subse-
>>>       quently fetched, the updated information is obtained ...
>>>
>>> QEMU already has support for this in the common code; enable it for
>>> s390x.
>>
>>
>> Figuring out what TARGET_HAS_PRECISE_SMC is all about, I only learned
>> from git history
>>
>> commit d720b93d0bcfe1beb729245b9ed1e5f071a24bd5
>> Author: Fabrice Bellard <fabrice@bellard.org>
>> Date:   Sun Apr 25 17:57:43 2004 +0000
>>
>>       precise self modifying code support
>>
>>
>>       git-svn-id: svn://svn.savannah.nongnu.org/qemu/trunk@745
>> c046a42c-6fe2-441c-8c8c-71466251a162
>>
>>
>>
>> AFAIU, precise SMC is stricter compared to what we have right now. So
>> i
>> suspect that this patch is actually fixing SMC behavior: for example,
>> when a basic block ends up modifying itself.
>>
>> Were there any BUG reports? (does patch #2 test for that and can
>> reproduce the original issue?)
> 
> There were no bug reports, I found this issue with fuzzing.
> 
> Patch #2 tests a TB modifying itself.
> Reverting this commit makes the test fail.
> 
> [...]
> 

Cool, thanks. Worth adding to the patch description.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


