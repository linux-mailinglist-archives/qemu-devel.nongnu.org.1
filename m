Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6388778B547
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 18:22:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaez7-0004U1-Vh; Mon, 28 Aug 2023 12:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DaUQ=EN=kaod.org=clg@ozlabs.org>)
 id 1qaez6-0004Tb-Hw; Mon, 28 Aug 2023 12:21:00 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DaUQ=EN=kaod.org=clg@ozlabs.org>)
 id 1qaez2-0002eD-Hg; Mon, 28 Aug 2023 12:21:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RZG4y6RPSz4wxy;
 Tue, 29 Aug 2023 02:20:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZG4s0r2Lz4wxQ;
 Tue, 29 Aug 2023 02:20:44 +1000 (AEST)
Message-ID: <288159df-3136-5091-b083-7f32f9f2cedc@kaod.org>
Date: Mon, 28 Aug 2023 18:20:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tests/avocado/machine_aspeed.py: Update SDK images
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Hang Yu <francis_yuu@stu.pku.edu.cn>
References: <20230828090101.74357-1-clg@kaod.org>
 <CACPK8XfMn5PJaM9dBkck=jxhLuusJmGnAv_RE3Dp-kdezYM+-A@mail.gmail.com>
 <7930d670-8d1d-04a2-d8c8-83fa48b19681@kaod.org>
 <eda0f3ba-d000-e3e0-0edb-cba9761a89bf@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <eda0f3ba-d000-e3e0-0edb-cba9761a89bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=DaUQ=EN=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-2.169, SPF_HELO_PASS=-0.001,
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

On 8/28/23 17:50, Philippe Mathieu-Daudé wrote:
> On 28/8/23 16:33, Cédric Le Goater wrote:
>> On 8/28/23 15:54, Joel Stanley wrote:
>>> On Mon, 28 Aug 2023 at 09:01, Cédric Le Goater <clg@kaod.org> wrote:
>>>>
>>>> Switch to the latest v8.06 release which introduces interesting
>>>> changes for the AST2600 I2C and I3C models. Also take the AST2600 A2
>>>> images instead of the default since QEMU tries to model The AST2600 A3
>>>> SoC.
>>>
>>> Is there any value in testing both the old and the new images?
>>
>> For QEMU default tests, I think using the latest version of a test image
>> is just fine, or we will end up with a very long avocado test run. That
>> said we could make an exception when a HW feature is only activated in a
>> specific version.
>>
>> I run pre-PR tests with more images (buildroot, mainline, sdk, openbmc,
>> provided by other vendors) but only the SDK v08.X images have decent
>> results. v07.02 and v04.05 have issues. It could be a software issue.
> 
> I'd rather keep all tests committed in the repository, only having the
> latest one picked up by default. That way other developer can reproduce
> maintainers pre-PR suites.
I could add a few static images but not all. Most flash and eMMC images
are generated on the fly for test purposes with the latest kernel
(OpenBMC and mainline), U-Boot (OpenBMC and mainline), rootfs (OpenBMC
and buildroot). This is a large zoo. PPC is similar.

C.


