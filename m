Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BBEBE31D1
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Oct 2025 13:38:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MGN-0005qp-Sk; Thu, 16 Oct 2025 07:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9MGF-0005nd-Vk
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 07:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9MGC-0002S5-6l
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 07:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760614504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oOxmtAQenqgzcEIxzoGonW0P67z8RPPovLFZK8o4C98=;
 b=QpQQvewPKU3E4kRq17emJuIVuwY6KNoomfrFiuf1PWQknEBC11tUYz4r1Y7rUpxXsRJzCa
 FU/jjkn0zqKVYlkeKyHF/5o3+cv0ts+ews1Q8ygz+I1+GRZOnmLdvCwa/lvO+1qpiDLXV5
 y0BUXHIpD3GomzGXCQjtZy1ZNSAfZhY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Ak7WBmZAONah5BUgTsOrrw-1; Thu, 16 Oct 2025 07:35:02 -0400
X-MC-Unique: Ak7WBmZAONah5BUgTsOrrw-1
X-Mimecast-MFC-AGG-ID: Ak7WBmZAONah5BUgTsOrrw_1760614502
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42421b15185so342585f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 04:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760614502; x=1761219302;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oOxmtAQenqgzcEIxzoGonW0P67z8RPPovLFZK8o4C98=;
 b=R4uF2JuIVM2lrBmsJOGC8zxLCcqg2TMHneCey3l8N7uO63QDS66oXkL7zzyK2WKgrJ
 xC/1M6DuJGx9DzeO1L9R0V0LZNP0bfq2AIysGs39+1n3fX9EP8NwjcTtTr06NK2e36x8
 OvtpjVpqi+h4kX9qaHQPswqnVGOcTXymlbTjtGHzo7Hr4ISgPx1RhynpZmbSD5Tw1PXF
 I2BYY61Zc72iNIrhb8aVMgFmn82LgmlqUt+aHZZWApJC1NEp8GjOG8vnyldhmy+/sS5m
 +GdF/3IfmPe2GL+uw51NI8JcpFvy2XSrq2Y0vGV42YOou9j2Iuu9g957m1n3QUi/WFve
 f8Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAesE58yYierzkk6eF++iKUbIulccdLA1B08VYT2ANj2lh3Fua0SXj7jyKADXFs7Afn+5+ZWU06aIA@nongnu.org
X-Gm-Message-State: AOJu0YxdaDFYf3E8gOQ8iXoaDKorjrjJK00w0W62ZzfCP22JEy6BtQSa
 de+8JocZQ5Wp+FZsAL8bhYZTOFsgNb+yNEjIqHo3EZ58Pa/AwoGnGH5cjn4Kr0TWaC7ughFrF0n
 +vWR2I/dcAQsSatqQVW1yiGM0w3aM4xh3AVKUntcdBaNjZjJh9NtudIgk
X-Gm-Gg: ASbGncvvnPSYQ7LUjjsNb2ttVD8neFD78P0J51eudQTRupo3t94daFufn12lDWHarMW
 ePOtacEhWxK8Pn3gK0hQcAeSYwKYrxeF8iC7XHRzP536z+6g+0e9Z5kNLDuY4lJ7TqFKgnUnss9
 9+8qA3olAj9vc6ICfd6TdeR6nNjbVg1mxWAUDJH1ZqTLGOyu5M6/RDEO4PjX2oZzvxEI+LgJSti
 bEId35oK5eohCpciIUlNaXFgcoL/1Av4cnH6bXychRO83ogk364vLeX1hjxX3rbrwhp6+YcsdmA
 mMKSIwX9JslsUxA+hHStHFMaLT+e5AxZT+WuF7Tr2xE6hkl23kNYYJs34QZo/FwRbDxpsPjdVyJ
 JzXP5878zFihdWS69ytl4zckTgwccJew9+YFJs8Tm
X-Received: by 2002:a05:6000:1842:b0:3eb:2428:4a05 with SMTP id
 ffacd0b85a97d-42666ac470dmr21846008f8f.3.1760614501661; 
 Thu, 16 Oct 2025 04:35:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsAmOKEjQGw9LohT3L4YnmUDaPBYZ7rCvuqnmzFm+F4LM303R5rIyjHqW4gk0pQxzuzyRw4g==
X-Received: by 2002:a05:6000:1842:b0:3eb:2428:4a05 with SMTP id
 ffacd0b85a97d-42666ac470dmr21845983f8f.3.1760614501235; 
 Thu, 16 Oct 2025 04:35:01 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47114428dedsm21230695e9.7.2025.10.16.04.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 04:35:00 -0700 (PDT)
Message-ID: <9dd0f243-961f-4e6c-b73a-9fe7fc521fc4@redhat.com>
Date: Thu, 16 Oct 2025 13:34:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/s390x: Fix missing clock-comparator
 interrupts after reset
From: Thomas Huth <thuth@redhat.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20251015142141.3238-1-iii@linux.ibm.com>
 <20251015142141.3238-3-iii@linux.ibm.com>
 <54485257-164e-485d-b82b-baae4b175a9c@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <54485257-164e-485d-b82b-baae4b175a9c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/10/2025 11.53, Thomas Huth wrote:
>   Hi Ilya!
> 
> On 15/10/2025 16.21, Ilya Leoshkevich wrote:
>> After reset, CKC value is set to 0, so if clock-comparator interrupts
>> are enabled, one should occur very shortly thereafter.
>>
>> Currently the code does not set tod_timer, so this does not happen.
>>
>> Fix by adding a tcg_s390_tod_updated() call. Initialize TOD clock
>> before CPUs in order to ensure that the respective object exists
>> during the CPU reset.
> 
> Can this really happen? Looking at CPUS390XState in target/s390x/cpu.h, the 
> ckc is next to the cregs[] in the start_initial_reset_fields section, so if 
> ckc gets cleared, the cregs get cleared, too. I.e. if ckc gets set to 0 
> here, there is no way that the clock comparator interrupt could trigger 
> immediately without the guest writing to the control registers first. So I 
> think this patch is not really necessary. Or do I miss something?

... but it looks like your TCG test is failing without this second patch.

Ok, I think I understood it now: We don't re-arm the CKC timer in case the 
guest writes to the CR0. So we need to have the timer started during reset 
already to make the interrupt pending, so that it can fire when the guest 
changes CR0.

So I guess this patch is fine. Or alternatively you could maybe re-arm the 
CKC during stctg, would that be better? What do you think?

  Thomas


