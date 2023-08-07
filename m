Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 219A1772BFD
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 19:04:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3eO-0007px-U7; Mon, 07 Aug 2023 13:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qT3eK-0007pH-GZ
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 13:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qT3eI-00085Q-L8
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 13:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691427845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EOC0cIWqit8+VnN+yik+93vfcol5V46C2JZ8YnnZLk=;
 b=IjI5TqitYXhpm+cd/TEh60+dNO62XbrFO0AieKsZPcgoJ5/v0mas8t50ZKS9aaISt69qG9
 BbtkLNJBHsSipFSR0htQbZGH1Zk799pO2LDUfYw9Ys2WzI8vGojTwKQYvsqT3BVsMnxr2K
 ZKczL5iPNW3rhKUVz5LcuvPp8GPDuZQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-ZhjG7tfOPmqDEoQPiCtHKg-1; Mon, 07 Aug 2023 13:04:03 -0400
X-MC-Unique: ZhjG7tfOPmqDEoQPiCtHKg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ba0f27a4c9so17481751fa.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 10:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691427842; x=1692032642;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9EOC0cIWqit8+VnN+yik+93vfcol5V46C2JZ8YnnZLk=;
 b=cZ925qswfrqQdUXcWVjqY2tctHvkCxXe7cZHvlcqOuqKW6PLuroAkTEnI9DYPvAb77
 0w7PbxTpu9qVMYue18Bdhe6TGPGN8o5VsVC/pngq1Mg9k0n1NuxTUwQLBJrPJZNpxxNu
 SZX6sG5FStaHn1jTIQMRoXbqMod3htFCPTgyTpriyNnSGjyzcOmEL9pgDdH7ktb6SLcX
 xZWgAnV0TU6+sIadjF7TinxKBDTCiVpw24owpiKurgqObOPcYcU+zwH7RHrc1fxhMZLs
 EoaRDg/CMLchCqSiSHvMFlkud4p69fGCh9c7ir10leSxzIq0g6Ra9CSUgvhgSscWYcd7
 X/yg==
X-Gm-Message-State: AOJu0YyNOix3WpX/rg3/wQbjN/hPmyZJ45EqOI9CzPX4mSTA+PBEWr1N
 ZDGJxkWpR54ib9E7S4HfVge5d17lBqqOpJ4UE3KDtLUXXwWmiNvq8GOivNY0p9IpSAY7hfdqhjS
 CvutAyN4CSXN8vxo=
X-Received: by 2002:a2e:3c04:0:b0:2b6:cdfb:d06a with SMTP id
 j4-20020a2e3c04000000b002b6cdfbd06amr7294292lja.22.1691427842448; 
 Mon, 07 Aug 2023 10:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0BP6vIJReQmi3kkket1mrRBfTffPHTzTYZDWmQB059JhLYbLagkRZoc975p5syE6r8hlN0Q==
X-Received: by 2002:a2e:3c04:0:b0:2b6:cdfb:d06a with SMTP id
 j4-20020a2e3c04000000b002b6cdfbd06amr7294264lja.22.1691427842053; 
 Mon, 07 Aug 2023 10:04:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:5d00:5143:1cd2:a300:ceff?
 (p200300cbc7405d0051431cd2a300ceff.dip0.t-ipconnect.de.
 [2003:cb:c740:5d00:5143:1cd2:a300:ceff])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a1c7208000000b003fe11148055sm11185623wmc.27.2023.08.07.10.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 10:04:01 -0700 (PDT)
Message-ID: <f4d98473-1ddd-e45c-ba01-767bde208a77@redhat.com>
Date: Mon, 7 Aug 2023 19:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] target/s390x: Use a 16-bit immediate in VREP
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230807163459.849766-1-iii@linux.ibm.com>
 <baa436ac-ffe4-8c7d-6eee-af9c26fe3c0f@redhat.com>
 <558af8b33fa9164b0a5a21f61aa583a3776784f7.camel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <558af8b33fa9164b0a5a21f61aa583a3776784f7.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 07.08.23 19:02, Ilya Leoshkevich wrote:
> On Mon, 2023-08-07 at 19:00 +0200, David Hildenbrand wrote:
>> On 07.08.23 18:34, Ilya Leoshkevich wrote:
>>> Unlike most other instructions that contain an immediate element
>>> index,
>>> VREP's one is 16-bit, and not 4-bit. The code uses only 8 bits, so
>>> using, e.g., 0x101 does not lead to a specification exception.
>>>
>>> Fix by checking all 16 bits.
>>>
>>> Cc: qemu-stable@nongnu.org
>>
>> Just curious, why stable? Are there valid programs that set invalid
>> element size and they are fixed by this?
> 
> None that I know of, but I thought this was still nice to have, and at
> the same time small enough to not cause any trouble.

Yes, I was just curious. From my recollection, we didn't backport all 
specification exception checks.

-- 
Cheers,

David / dhildenb


