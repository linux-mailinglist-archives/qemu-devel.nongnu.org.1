Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA56E7193F9
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 09:16:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4cXd-0003y0-44; Thu, 01 Jun 2023 03:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4cXb-0003xK-BP
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 03:16:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4cXZ-00048E-GN
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 03:16:11 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so5247185e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685603768; x=1688195768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WxzX/yCNlI8j55zMId0+95rQUKgWabv2ID5tlei60QM=;
 b=Gen2Cia+8jwTVAFZKVgGWlirQvMrtFyXZ9UoEsuR/bvjDIJOGRMO1lVO1gSIX4316Q
 +OJNvgZk8IX1ihXqQXwqenIpLkmpItGw5/co228wbljIfirJPEqEEgVld+V61ZA3s5zA
 Cic5VL9KIipJMomumYYWISL9cGH3jPqHF99y/q15gHBv7D12a5Mw/5ZIymC48Sm9y5sS
 qkuas5BNYbHlymXURf3sSCAO+av/DtT0fuSx5WKZ/JOXOBF75uwl7oSoOb0rAt2dV4es
 MGwK0yAJHxO7sI6vCYvZEVfTWDmIkQU2ZD82keOoDRTLpHyLMypa+6jxdJ6OWGPlyBA3
 5Bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685603768; x=1688195768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WxzX/yCNlI8j55zMId0+95rQUKgWabv2ID5tlei60QM=;
 b=k5gIBbcLNxQGiLZuLh11B1NUjIR2y/4tjSyg9gacejGiHxShO5HiDWIsMAREoelgLl
 puSlr1FNU6OznolmQxzgowtQUMq2tuvvJcNNTF9pBPGDZox4fhifbZGJDjAfjP7/5lK1
 uUtxk9L+fW07E9ahW+TrMC18l0o73fFetzD5G8wAxNWbvGYvkkEXGYV27lVsr7BJk4oo
 1Nd788I7mbN4fJfNXPMvwFaWOgEMAJmYJ06uqtHS5u7j1rt86e4I3FnLSbgMb7wS8j0U
 D7ZWDuCg1QCvFc6O09YPH4VAnIE9UqjZ++9p7/RLn8ItlppdptP6SJHiuHqaQGHRCJNn
 v2mQ==
X-Gm-Message-State: AC+VfDycphep+sk7x0FJJz/fvNgxof1jIFInhfkx/pvX32qUBMuJVSvz
 /ZiBdSWxnUpSY0nffK3TN50pcw==
X-Google-Smtp-Source: ACHHUZ4hON2fkLvrpZTHSEtZk4pe9Oj8d4QR+Z+nkJfpLOiDJ009Fgvl5JdUmRVI16HmDclpVVxrAQ==
X-Received: by 2002:a7b:c5d4:0:b0:3f6:ffe:9ef1 with SMTP id
 n20-20020a7bc5d4000000b003f60ffe9ef1mr1110012wmk.36.1685603767760; 
 Thu, 01 Jun 2023 00:16:07 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a7bcd0f000000b003f4272c2d0csm1185408wmj.36.2023.06.01.00.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 00:16:07 -0700 (PDT)
Message-ID: <72ccd4c2-7c60-e015-2322-721d09a8334b@linaro.org>
Date: Thu, 1 Jun 2023 09:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/2] net: Update MemReentrancyGuard for NIC
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230601031859.7115-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/6/23 05:18, Akihiko Odaki wrote:
> Recently MemReentrancyGuard was added to DeviceState to record that the
> device is engaging in I/O. The network device backend needs to update it
> when delivering a packet to a device.
> 
> This implementation follows what bottom half does, but it does not add
> a tracepoint for the case that the network device backend started
> delivering a packet to a device which is already engaging in I/O. This
> is because such reentrancy frequently happens for
> qemu_flush_queued_packets() and is insignificant.
> 
> This series consists of two patches. The first patch makes a bulk change to
> add a new parameter to qemu_new_nic() and does not contain behavioral changes.
> The second patch actually implements MemReentrancyGuard update.

/me look at the 'net' API.

So the NetReceive* handlers from NetClientInfo process the HW NIC
data flow, independently from the CPUs.

IIUC MemReentrancyGuard is supposed to protect reentrancy abuse from
CPUs.

NetReceive* handlers aren't restricted to any particular API, they
just consume blob of data. Looking at e1000_receive_iov(), this data
is filled into memory using the pci_dma_rw() API. pci_dma_rw() gets
the AddressSpace to use calling pci_get_address_space(), which returns
PCIDevice::bus_master_as. Then we use the dma_memory_rw(), followed
by address_space_rw(). Beh, I fail to see why there is reentrancy
checks from this NIC DMA HW path.

Maybe the MemoryRegion API isn't the correct place to check for
reentrancy abuse and we should do that at the AddressSpace level,
keeping DMA ASes clear and only protecting CPU ASes?

