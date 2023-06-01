Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C745571948F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 09:43:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4cwS-00020c-Ow; Thu, 01 Jun 2023 03:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q4cwQ-0001zu-Ky
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 03:41:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q4cwN-0001Er-Jh
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 03:41:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d293746e0so699654b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 00:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685605306; x=1688197306;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bc1VxBw2ts7gzODbDt725l/y9yXi0D1Tw4esM7ANdJo=;
 b=YDujPal7wEEBLnpAJsvdWRdpTPTHWkcgLybiafBwUGy8Gv4A9m7mFoizaRlbqOxVAf
 03TR1Kk/2g2omrqvungoh3GSuN6YGNnQ6+SC/j2J0RV9XQL4RlXW1yU3OPhywzp3Jf//
 9b6khcU6Pts1pUs9oG4fuoQOnQCbreK6yl0+QmtMj5pxtbUdsoixB1RGMWMD7rYbgX9M
 qFEUyRjOuqJ6OHPGLRC4g1LVzc0fxo5FFO71B3bljyarT6gj2y+dhL21gOSzKxZqqKJX
 WjvAeU8+st8NK021a35W+pNz1SaePj0A6/zFrLF9k9tA5OTc6g+RSqyHAXZHG0FZ/TDN
 ZmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685605306; x=1688197306;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bc1VxBw2ts7gzODbDt725l/y9yXi0D1Tw4esM7ANdJo=;
 b=BQkD+Hnfb6mliGc3BxXBGlN/8UDTA8VbUh0Fc2xiHbnpgVzrhRCGSmzd6oiRYBkUJg
 1hUr/21BRxwC4VdFMCn3w82jvhFtQjiG3RT7+ZkvYHuuu9mSCYQG95795OINzbXNU/JT
 e3sVmvC6Z6pDvqf1mr4l/o0xQgrTMMBcwSGcGyI0vMsibo0mCuXdaKxpEbFNczPK8oQh
 INB0U1VF+9rBliDBAfJwQ+R21CcrPlnitW/WxOEuNN9wWmywgofF8uqJLHMaYoAWtjPw
 iEOYRw2ISD7kvI0IVNRJDtuIF1K36D+I47eRdasv/hbPe0VjukleXfqkw94h/cTx14W+
 utAg==
X-Gm-Message-State: AC+VfDwm8gKwFHKj4SWPPJr6/flox9cHp8gGMetcAId6BnwWJpGrqGYT
 WWeQcR+4JZHMJimiwY8S7PGHmg==
X-Google-Smtp-Source: ACHHUZ7TDkTXVGJ/r9kX7PKwjBkqfm4bwdAX6ZtU3aCnPohgVAZ1rbRjP2ABSRQr4SAKEAvK6nYpfA==
X-Received: by 2002:a05:6a20:3d0c:b0:10b:4539:fa0a with SMTP id
 y12-20020a056a203d0c00b0010b4539fa0amr11339542pzi.1.1685605305794; 
 Thu, 01 Jun 2023 00:41:45 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 h22-20020a62b416000000b0064d1349dc31sm4424818pfn.199.2023.06.01.00.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 00:41:45 -0700 (PDT)
Message-ID: <233b42b2-6fbb-3882-6158-d2a82bf88be1@daynix.com>
Date: Thu, 1 Jun 2023 16:41:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/2] net: Update MemReentrancyGuard for NIC
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Mauro Matteo Cascella <mcascell@redhat.com>, P J P
 <pj.pandit@yahoo.co.in>, Alexander Bulekov <alxndr@bu.edu>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>, Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sven Schnelle <svens@stackframe.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Rob Herring <robh@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20230601031859.7115-1-akihiko.odaki@daynix.com>
 <72ccd4c2-7c60-e015-2322-721d09a8334b@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <72ccd4c2-7c60-e015-2322-721d09a8334b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/06/01 16:16, Philippe Mathieu-Daudé wrote:
> On 1/6/23 05:18, Akihiko Odaki wrote:
>> Recently MemReentrancyGuard was added to DeviceState to record that the
>> device is engaging in I/O. The network device backend needs to update it
>> when delivering a packet to a device.
>>
>> This implementation follows what bottom half does, but it does not add
>> a tracepoint for the case that the network device backend started
>> delivering a packet to a device which is already engaging in I/O. This
>> is because such reentrancy frequently happens for
>> qemu_flush_queued_packets() and is insignificant.
>>
>> This series consists of two patches. The first patch makes a bulk 
>> change to
>> add a new parameter to qemu_new_nic() and does not contain behavioral 
>> changes.
>> The second patch actually implements MemReentrancyGuard update.
> 
> /me look at the 'net' API.
> 
> So the NetReceive* handlers from NetClientInfo process the HW NIC
> data flow, independently from the CPUs.
> 
> IIUC MemReentrancyGuard is supposed to protect reentrancy abuse from
> CPUs.
> 
> NetReceive* handlers aren't restricted to any particular API, they
> just consume blob of data. Looking at e1000_receive_iov(), this data
> is filled into memory using the pci_dma_rw() API. pci_dma_rw() gets
> the AddressSpace to use calling pci_get_address_space(), which returns
> PCIDevice::bus_master_as. Then we use the dma_memory_rw(), followed
> by address_space_rw(). Beh, I fail to see why there is reentrancy
> checks from this NIC DMA HW path.
> 
> Maybe the MemoryRegion API isn't the correct place to check for
> reentrancy abuse and we should do that at the AddressSpace level,
> keeping DMA ASes clear and only protecting CPU ASes?

The involvement of CPU is not essential in my understanding. A typical 
scenario of DMA reentrancy is like the following:
1) The guest configures the DMA destination address register the device 
has to the address of another device register.
2) The DMA gets triggered.
3) The device performs the DMA, writing its own register.
4) The write causes reentrancy.
5) The re-entered device code corrupts the device state.

I guess 2) is done by CPU in most cases, but sometimes it happen with 
another cause. In fact, the current reentrancy protection code covers 
the case that bottom half handlers triggers DMA. The intention of this 
series is to extend the coverage and handles the case that incoming 
network traffic triggers DMA.

The essence of DMA reentrancy is in 3). This happens when the DMA 
address space contains the MMIO region of the device and there is no 
involvement of CPU here.

