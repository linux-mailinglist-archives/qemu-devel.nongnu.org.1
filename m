Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5177B106CB
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Jul 2025 11:45:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uesWC-0007G7-QN; Thu, 24 Jul 2025 05:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1uesVs-00079m-Le; Thu, 24 Jul 2025 05:45:24 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1uesVp-0007T9-Us; Thu, 24 Jul 2025 05:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y2jcGMuO6H+K/tUbDCBgfnN9ONaVPnlEx9RHeJk89pE=; b=h+86T8zLCsT8vdOYop6xgKwxw6
 589EObP7eO7ewA+/ykrZ0GJk48JB12F09bGi3EaXbQfOnn41VXbNQuia+zlzJtaL3lQTGgQe57p6h
 sXxi88Z9aArMqtrb/MeqhnWzEdCLwZ1x5YVKOAyC7Uao/NwD5nT3mFuVzktwa8nGMZ2qY07Akr+Pb
 PQe/RbhrDKJBE/oW1650GoZM7ckfCR49eyIXqBba9AaDH5a1HAesUlLsOZaZ2E6b1nlvpGC/5qhyV
 U8sDweFVC+k3QhgBPQZtngut5N8CDCDjUkH/FtAXu0SfWAM+QoteY2dFgJj7lUeaRAB3sUdWIrJ/K
 ECXQIV4A==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uesVj-001Wwg-EX; Thu, 24 Jul 2025 10:45:11 +0100
Message-ID: <32edcc36-1d89-4814-a7ea-9157af15aacc@codethink.co.uk>
Date: Thu, 24 Jul 2025 10:45:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd: print bad s->arglen in unexpected response
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
References: <20250722090547.109117-1-ben.dooks@codethink.co.uk>
 <87seinulb7.fsf@draig.linaro.org>
 <CAFEAcA8c0GRxvXUANBbNvMdTqBwBgCjTZkqc2RNjE8bRQo772w@mail.gmail.com>
 <197dd05a-eda5-44e0-9592-b886e953086f@codethink.co.uk>
 <f20200a3-1391-45d9-961d-df2fc5996341@linaro.org>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <f20200a3-1391-45d9-961d-df2fc5996341@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 23/07/2025 17:30, Philippe Mathieu-Daudé wrote:
> Hi Ben,
> 
> On 23/7/25 16:55, Ben Dooks wrote:
> 
>> I am currently trying to track down two errors with mmc-spi.
>>
>> The first looks like u-boot is sending a couple of CMDs (9, 10)
>> in the wrong state (currently this works however with a real SD
>> card) so I have a tmp-fix in to just ignore the two checks in
>> these and u-boot is now working.
>>
>> I'm also getting multiple versions of linux failing with QEMU10
>> on Debian/testing and my own close to the current git tree with
>> Linux and CMD13...
>>
>> [    0.579845] EXT4-fs (mmcblk0): INFO: recovery required on readonly 
>> filesystem
>> [    0.580222] EXT4-fs (mmcblk0): write access will be enabled during 
>> recovery
>> ssi_sd: error: Unexpected response to cmd 13, arglen=16
>> ssi_sd: error: Unexpected response to cmd 13, arglen=16
>> ssi_sd: error: Unexpected response to cmd 13, arglen=16
>> ssi_sd: error: Unexpected response to cmd 13, arglen=16
> 
> CMD13's arg len should be 2 in SSI mode.
> 
>> Then the system stops working.
>>
>> Systems are riscv sifive_u and my own cva6 machine
> Do you mind sharing a reproducer?

Currently buildroot riscv64 with the sifive_u machine is the
test case.

It looks to be a qemu issue, v8.x works, v9.0 works and v9.1
does not. Currently doing a bisect to see if there's an obvious
issue to point at.

> Even better if contributed as a functional test :)
> (see tests/functional/test_arm_sx1.py for example).

I'll see, but I am off next week at FOSSY and then not sure if
this project will be continued.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

