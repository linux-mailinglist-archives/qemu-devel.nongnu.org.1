Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3EE81F9D0
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 17:02:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIsnx-00071J-9S; Thu, 28 Dec 2023 11:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <0102018cb1278a4a-1b74ddef-8edd-46ca-a51c-5284f9df4a40-000000@eu-west-1.amazonses.com>)
 id 1rIsnu-00070h-IP; Thu, 28 Dec 2023 11:00:14 -0500
Received: from a7-10.smtp-out.eu-west-1.amazonses.com ([54.240.7.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from
 <0102018cb1278a4a-1b74ddef-8edd-46ca-a51c-5284f9df4a40-000000@eu-west-1.amazonses.com>)
 id 1rIsns-0005YI-OK; Thu, 28 Dec 2023 11:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=we7ia3fxgawvchs62qr3tqnz7sf6mlor; d=ipxe.org; t=1703779207;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=dxibOQJQwxEMu1DSy3K1l2h2CrvRQrCpyo9oXA7UGUg=;
 b=nzCxT4tJpwmcFMfl1i6/TR1MAm28UUObYV19uTlAo0wq4zN7oT3Fvzd/KkU0SP8+
 QwIh+0Eu8SgxBkNCqjrc/mg8NrJOUgxVan55Ft6Fd2k1DVsbLDUwYYTKVJFW3GNSQaC
 1gx+zwQI3CWYSD5xgUI90s+imzVKO2v3bZCWKUX6XCcbxL4znTISycdz6Ac+TOV+ulK
 WoW+kmZRZcWakbjDoEMd0EDZpNlS4ieraKmgWlvBMsidyne+Anc0hkum6PAR382lLeA
 1RdsUbO1bdzCG1rcQp1c/mxKAxc2tczDCutR6/2wu9kPcIWjP7Ezwg/bNo5UlhC6XEF
 Ml4wCctXsA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1703779207;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
 bh=dxibOQJQwxEMu1DSy3K1l2h2CrvRQrCpyo9oXA7UGUg=;
 b=OKDacC9xGfKoacRojTuBiF9cZdPIjMUAMmdZWC5qQKhqcwt9wY+Vsk/wLljsktrh
 O2KH1U+WlAA6HSLPovcPw6+vtuGoBnpfjevHp9HDoavMXmiSsAwTbQ7+8beje1dctUL
 tX3nHahNU3susOsa3LAj5UkDM9akyeF5OrzE3qmM=
Message-ID: <0102018cb1278a4a-1b74ddef-8edd-46ca-a51c-5284f9df4a40-000000@eu-west-1.amazonses.com>
Date: Thu, 28 Dec 2023 16:00:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/i386: Fix physical address truncation
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 qemu-stable <qemu-stable@nongnu.org>
References: <20231222175951.172669-1-pbonzini@redhat.com>
 <20231222175951.172669-4-pbonzini@redhat.com>
 <0102018c963dbec6-062a7a68-53b9-4325-9137-8cee657053b2-000000@eu-west-1.amazonses.com>
 <CABgObfbgVgQu5oYqtatVjA50FCWxvANtXAYHnV70iFOCu8DniQ@mail.gmail.com>
From: Michael Brown <mcb30@ipxe.org>
Autocrypt: addr=mcb30@ipxe.org; keydata=
 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
In-Reply-To: <CABgObfbgVgQu5oYqtatVjA50FCWxvANtXAYHnV70iFOCu8DniQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.eu-west-1.fspj4M/5bzJ9NLRzJP0PaxRwxrpZqiDQJ1IF94CF2TA=:AmazonSES
X-SES-Outgoing: 2023.12.28-54.240.7.10
Received-SPF: pass client-ip=54.240.7.10;
 envelope-from=0102018cb1278a4a-1b74ddef-8edd-46ca-a51c-5284f9df4a40-000000@eu-west-1.amazonses.com;
 helo=a7-10.smtp-out.eu-west-1.amazonses.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

On 23/12/2023 11:47, Paolo Bonzini wrote:
> The linear address is the one that has the segment base added, and it is 
> not truncated to 16 bits (otherwise the whole A20 thing would not 
> exist). The same should be true of e.g. an FSAVE instruction; it would 
> allow access slightly beyond the usual 1M+64K limit that is possible in 
> real mode with 286 and later processors.
> 
> In big real mode with 32-bit addresses, it should not be possible to go 
> beyond 4G physical address by adding the segment base, it should wrap 
> around and that's what I implemented. However you're probably right that 
> this patch has a hole for accesses made from 32-bit code segments with 
> paging enabled. I think LMA was the wrong bit to test all the time, and 
> I am not even sure if the masking must be applied even before the call 
> to mmu_translate(). I will ponder it a bit and possibly send a revised 
> version.

You are of course correct that the linear address is not truncated to 16 
bits when the address size is 16 bits - my mistake.

I've been looking through the SDM for any definitive statement on the 
topic.  The closest I can find is in volume 3 table 4-1, which states 
that the linear address width is:

  - 32 bits with paging disabled

  - 32 bits with 32-bit paging

  - 32 bits with PAE paging

  - 48 bits with 4-level paging

  - 57 bits with 5-level paging

My previous experiment seems to show that the linear address *does* also 
get truncated to 32 bits for an instruction with a 32-bit address size 
even when running in long mode with 4-level paging (on a Core i7-6600U), 
so this table definitely isn't telling the complete story.

My best guess at this point is that the linear address gets truncated to 
32 bits when the address size is 32 bits (which will always be the case 
when paging is disabled, or when using 32-bit paging or PAE paging).

Thanks,

Michael


