Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CE081BA80
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:22:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKqf-0002QS-KT; Thu, 21 Dec 2023 10:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <0102018c8cf69def-cbb33026-1ea6-4326-93d7-5ec61572ac9f-000000@eu-west-1.amazonses.com>)
 id 1rGKqd-0002Q5-QL; Thu, 21 Dec 2023 10:20:31 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from
 <0102018c8cf69def-cbb33026-1ea6-4326-93d7-5ec61572ac9f-000000@eu-west-1.amazonses.com>)
 id 1rGKqZ-0008W5-La; Thu, 21 Dec 2023 10:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=we7ia3fxgawvchs62qr3tqnz7sf6mlor; d=ipxe.org; t=1703172021;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=llijkMh6ZMAhEkwjFl1x81djmhlJSY6gCYMevIxWQSY=;
 b=qpqvuWFw8DJFEYjSrJiBdP5gpWKZ2Q19YQIGp63zhucEGCgSGBjAogfzr0MOv9bv
 aiU3cTRlewujZqRNeCmCL2h7R7foM36U05IzUYHg839+OqQZlkAV/mbB8wl4TPn8Jeo
 Qz7S5gyat/kzRSrhRn1V6dCylb4fSBzG2DASZU9dyqs368w5qpQ9Zf4XPNE+8EDzsFj
 nmJcfmMohGBf3wuiVCQY8xJn3fbeVBeeLfvmzQzro97w4e8pM+rZaZmIglHqj6DRoLC
 WXEDvgnbw9KtZg1AulB1XtYJ7sRbww0zEaFgX0mtFtSYiQ6ke22WEK3GoUi1oIbM240
 6dCmIM7iJA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1703172021;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
 bh=llijkMh6ZMAhEkwjFl1x81djmhlJSY6gCYMevIxWQSY=;
 b=VKVGfy5xxFLcJbRa7yFtEPNs7QtUgl86ih/EXdSryGxPhiwfecyyTq1CYBJZtQJJ
 Cn5o0zW7sb1jxuyU+dcByi+xbn+SIR7jR6nOKu/0elOUxYwv0icJIrtbuz7oWOmgFyN
 XwVUqVAsXc2rPOP6lSGALPRXMtkzsnOVGiXQ5Fek=
Message-ID: <0102018c8cf69def-cbb33026-1ea6-4326-93d7-5ec61572ac9f-000000@eu-west-1.amazonses.com>
Date: Thu, 21 Dec 2023 15:20:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Fix physical address truncation when PAE is
 enabled
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
References: <0102018c7d0026c1-fd5f0b50-48fd-4552-be0a-cbb6070b5e14-000000@eu-west-1.amazonses.com>
 <49047cf7-de12-4761-9082-dc5638d249a2@linaro.org>
 <0102018c86e4f17c-5e356421-08c8-4d3a-a149-5897437892ac-000000@eu-west-1.amazonses.com>
 <bc0694ff-49a7-4fc0-9cd9-ac139f310bd8@linaro.org>
From: Michael Brown <mcb30@ipxe.org>
Autocrypt: addr=mcb30@ipxe.org; keydata=
 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
In-Reply-To: <bc0694ff-49a7-4fc0-9cd9-ac139f310bd8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.fspj4M/5bzJ9NLRzJP0PaxRwxrpZqiDQJ1IF94CF2TA=:AmazonSES
X-SES-Outgoing: 2023.12.21-54.240.7.12
Received-SPF: pass client-ip=54.240.7.12;
 envelope-from=0102018c8cf69def-cbb33026-1ea6-4326-93d7-5ec61572ac9f-000000@eu-west-1.amazonses.com;
 helo=a7-12.smtp-out.eu-west-1.amazonses.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 20/12/2023 21:51, Richard Henderson wrote:
> On 12/20/23 22:03, Michael Brown wrote:
>> For the default case, I think it would make sense to unconditionally 
>> truncate the address to 32 bits if paging is disabled.  (I am not sure 
>> why the original commit 33dfdb5 included a test for long mode, since I 
>> do not see how it is possible to get the CPU into long mode with 
>> paging disabled.)
> 
> You are correct that paging is mandatory for LMA -- indeed, setting 
> CR0.PG is the final step in 10.8.5 Initializing IA-32e Mode, which 
> copies EFER.LME to EFER.LMA.
> 
> The commit 33dfdb5 that you reference is definitely wrong.

I have done some further investigation, and come to the conclusion that 
we should just delete the truncation code entirely.

With paging disabled, there is (as far as I know) no way to execute an 
instruction with an address size of 64 bits.  With the instruction 
address size being 32 bits, the linear address will already be truncated 
to 32 bits anyway.

A quick userspace test program confirms that on a physical CPU a 32-bit 
address size will result in the linear address being truncated to 32 bits:

     #include <stdint.h>
     #include <stdio.h>

     uint8_t val = 42;

     int main ( void ) {
	uint8_t *ptr = ( &val + 0x80000001 );
	uint8_t res;

	printf ( "&val = %p\n", &val );  // will be around 0x400000
	printf ( "ptr = %p\n", ptr );

	printf ( "addr32 read via 0x7fffffff(%p)...\n", ptr );
	__asm__ ( "addr32 movb 0x7fffffff(%k1), %b0\n\t"
		  : "=r" ( res ) : "r" ( ptr ) );
	printf ( "...got %d\n", res );

	printf ( "addr64 read via 0x7fffffff(%p)...\n", ptr );
	__asm__ ( "movb 0x7fffffff(%1), %b0\n\t"
		  : "=r" ( res ) : "r" ( ptr ) );
	printf ( "...got %d\n", res );

	return 0;
     }

produces the expected output:

$ cc -o test test.c && ./test
&val = 0x40400c
ptr = 0x8040400d
addr32 read via 0x7fffffff(0x8040400d)...
...got 42
addr64 read via 0x7fffffff(0x8040400d)...
Segmentation fault (core dumped)

which I believe shows that the addr32 instruction experiences wraparound 
of the linear address (and so accesses the correct location), while the 
addr64 instruction with the same base and offset does not experience 
wraparound of the linear address (and so segfaults).

The original commit 33dfdb5 describes 32-bit code relying on the linear 
address wraparound to access memory below the segment base.  This is 
what iPXE also does: the iPXE code is physically copied to somewhere 
high in 32-bit memory, the segment base is set to point to the location 
of iPXE (thereby avoiding the need to apply relocation records), and 
wraparound is relied upon to access all memory below this.  I have 
tested removing the truncation code from get_physical_address() and 
verified that iPXE continues to work as expected.

I have also verified that removing the truncation code from 
get_physical_address() does seem to fix the problem with PAE mode (i.e. 
is able to boot Windows 10 with RAM above 4G).

I will send a v2 patch shortly.

Thanks,

Michael


