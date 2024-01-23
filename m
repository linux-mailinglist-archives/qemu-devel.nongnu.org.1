Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D18392CB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:34:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSIlP-0003L6-Bd; Tue, 23 Jan 2024 10:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSIlK-0003J8-F2
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:32:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSIlI-0006Td-Pa
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706023948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ArdHkM2nO4tTwC0ea+IwE4+pLpboAa6kqHQ8u0RYqm0=;
 b=f4tdedRXRoutFEv5hALBMxrIZIpLEAgGG71im+QZAEUUfKOZV1Yknm25o/T9ua5S2oqdxW
 ujZWrLptYtVvbfYZJEYjcfg4jACud2pv7Sgml6uEX2paISuMVHLWrxwuRf/hFafwlWsKop
 vbuN/dFgWNfjx7pWf3KHe09qqj3HeKE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-A2OavW2mOdmHmXg8carXQQ-1; Tue, 23 Jan 2024 10:32:24 -0500
X-MC-Unique: A2OavW2mOdmHmXg8carXQQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40eb6ce1ddaso7642135e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 07:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706023943; x=1706628743;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ArdHkM2nO4tTwC0ea+IwE4+pLpboAa6kqHQ8u0RYqm0=;
 b=ZtkRp3lc4PH87+SVlAd66yQDtVD3VRrgf1CAg959og7Uku+sFkrEBx3mcTf7FI7nCy
 4350Yb0AkjvAc31sirD/VVwMoiptbHnqMW5Ce8MYnngUbKCF+c8o/CFd1DzqnnMklLeL
 F5xcQ19AgE2MHIC3dc2CJygnKpoXchi19HeZW5MhE4TCHGGEjJ/cSCvzjLFwp5BZPz5J
 J422gIYrcuCWLxRmdl7Mri/5Viug/ltE05h4GJPw0xMXBqqVjsMz1iYdrdZ6xp3uz8Vy
 bCQzmNHB8pmvks1rsupm9CJtb1RpdyaaXzZlP1t/UKy2juuxuvd+QU7M30NH8ZNoIASh
 UMdQ==
X-Gm-Message-State: AOJu0YxxiYAsRG5aJpH3FHdWAHX6T2/lP0X1tNTzwZ7PedH5F0KbP58Q
 JiR5BBcrHyjKbkdToeKkdH0SI9WI5GoPBUxLJbARoIvNjvjUKp1cj5btSpBSnFYjWoiKqXCoHKN
 NtdyZOjfZSXvb/jkZ1ibQcyd0EfGrPeunsbGbF+RTRvXFrxWW9msq
X-Received: by 2002:a05:600c:548d:b0:40e:a7d2:5a53 with SMTP id
 iv13-20020a05600c548d00b0040ea7d25a53mr351523wmb.55.1706023943269; 
 Tue, 23 Jan 2024 07:32:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3edWDcqW4Di6iB1XEOCR776ClH+JN7+aSkZbkvC5nyltEMJ6OWOVx6yTT5vLW0NmyM/AKdw==
X-Received: by 2002:a05:600c:548d:b0:40e:a7d2:5a53 with SMTP id
 iv13-20020a05600c548d00b0040ea7d25a53mr351517wmb.55.1706023942956; 
 Tue, 23 Jan 2024 07:32:22 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 m21-20020a05600c4f5500b0040e4733aecbsm42741664wmq.15.2024.01.23.07.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 07:32:21 -0800 (PST)
Message-ID: <f368d759-c87b-4389-a37a-da692e20854d@redhat.com>
Date: Tue, 23 Jan 2024 12:22:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-7.2.9 00/20] Patch Round-up for stable 7.2.9, freeze on
 2024-01-27
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <qemu-stable-7.2.9-20240123114733@cover.tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <qemu-stable-7.2.9-20240123114733@cover.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-1.327, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 1/23/24 09:48, Michael Tokarev wrote:
> The following patches are queued for QEMU stable v7.2.9:
> 
>    https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2
> 
> Patch freeze is 2024-01-27, and the release is planned for 2024-01-29:
> 
>    https://wiki.qemu.org/Planning/7.2
> 
> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.
> 
> The changes which are staging for inclusion, with the original commit hash
> from master branch, are given below the bottom line.

I would like to include a minimal revert of the PCREL enablement, since 
it is causing regressions that are not well understood.  I've just sent 
a patch for 7.2 and I am currently testing the forward port for 8.1.

Paolo

> Thanks!
> 
> /mjt
> 
> --------------------------------------
> 01* d3007d348ada Kevin Wolf:
>     block: Fix crash when loading snapshot on inactive node
> 02* 5a7f21efaf99 Kevin Wolf:
>     vl: Improve error message for conflicting -incoming and -loadvm
> 03* bb6e2511eb48 Kevin Wolf:
>     iotests: Basic tests for internal snapshots
> 04* 5cb0e7abe163 Xu Lu:
>     target/riscv: Fix mcycle/minstret increment behavior
> 05* 4ad87cd4b225 Michael Tokarev:
>     chardev/char.c: fix "abstract device type" error message
> 06* 82a65e3188ab Peter Maydell:
>     hw/intc/arm_gicv3_cpuif: handle LPIs in in the list registers
> 07* e358a25a97c7 Ilya Leoshkevich:
>     target/s390x: Fix LAE setting a wrong access register
> 08* 52a21689cd82 Peter Maydell:
>     .gitlab-ci.d/buildtest.yml: Work around htags bug when environment is large
> 09 410c2a4d75f5 Anastasia Belova:
>     load_elf: fix iterator's type for elf file processing
> 10 b5e0d5d22fbf Richard Henderson:
>     target/i386: Fix 32-bit wrapping of pc/eip computation
> 11 a58506b748b8 Richard Henderson:
>     target/i386: Do not re-compute new pc with CF_PCREL
> 12 2926eab89699 guoguangyao:
>     target/i386: fix incorrect EIP in PC-relative translation blocks
> 13 729ba8e933f8 Paolo Bonzini:
>     target/i386: pcrel: store low bits of physical address in data[0]
> 14 3b14a555fdb6 Gerd Hoffmann:
>     hw/pflash: refactor pflash_data_write()
> 15 5dd58358a570 Gerd Hoffmann:
>     hw/pflash: use ldn_{be,le}_p and stn_{be,le}_p
> 16 284a7ee2e290 Gerd Hoffmann:
>     hw/pflash: implement update buffer for block writes
> 17 84a6835e004c Mark Cave-Ayland:
>     hw/scsi/esp-pci: use correct address register for PCI DMA transfers
> 18 6b41417d934b Mark Cave-Ayland:
>     hw/scsi/esp-pci: generate PCI interrupt from separate ESP and PCI sources
> 19 1e8e6644e063 Mark Cave-Ayland:
>     hw/scsi/esp-pci: synchronise setting of DMA_STAT_DONE with ESP completion interrupt
> 20 c2d7de557d19 Mark Cave-Ayland:
>     hw/scsi/esp-pci: set DMA_STAT_BCMBLT when BLAST command issued
> 
> (commit(s) marked with * were in previous series and are not resent)
> 
> 
> 


