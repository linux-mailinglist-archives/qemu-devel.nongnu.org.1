Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47F7237C7
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 08:35:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6QGS-0008F8-TM; Tue, 06 Jun 2023 02:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q6QGF-0008CH-Gt
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 02:33:48 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q6QGD-0006aF-W2
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 02:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EF47ppOL8jDNmu+X7cwLWimIUKBzUMWbrgIeeyEVGUQ=; b=ebwPgyD7KypXt7OaAnTJ9+TH3O
 qJFSWOTR2AiO0dRAW0lCIPP/HbSyUS3OaV5G+4i41j5f6WJHw7wdygHb7VasHqqQ6gX3l2ZYMk55z
 5YJk09rS4qbTMjoz+EX3hqo4cpeMAy5K9hsoPBvWOu1c1fOuP8RXvt9VpIgz5wH+cv/db5kBgsZMX
 5usx44skv/29qpzlfAIap7gck9BYDsrMTz+U+8cSk4a3GffzU5iJrPoA6XF9L0UVDD4i2PWCUR9Lp
 QDfmzBua14gm5vHkyGvEsd6dAaOzc6uU7wvOd5yCtS0v3SZxSZamZwqZWKeKWRr5bORkNoIB+/wWT
 46z4oppZynMIyE5ZH7lGpdEgIiGwCZWTmeKIBMRhE/z1wxl63fe5lxE3fmu5cWkYtnXRXPBv+tu+T
 D2L8E4utocmESSfArdEl+zjvM3YMyGeRkmBBY5dD9JGWz1Iaw8VMT6iQIAvyyB9PLyTcdXqW1zGyw
 KJZXWJwtbBPALqbcfxqN2MgdZJIovDAwFGbl9pQDQJqGiHuYRFcoYMlGiIgdrccM0B4p6Hbh2O86f
 JBqVbPVQkVn9lum5+JrxDGk7TK8Xdn5t2/ENMJU8pNXy4Z6dCB2phGsASQ9Xlxuy+zBtcoPly/cL0
 zXYPIpNd/WSU9+ljF+zZFPWuKHMZ7dfNaACoxaZDo=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q6QG4-000528-G7; Tue, 06 Jun 2023 07:33:36 +0100
Message-ID: <24b2dd19-e002-d616-cf07-6a63cc18fcb2@ilande.co.uk>
Date: Tue, 6 Jun 2023 07:33:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-11-mark.cave-ayland@ilande.co.uk>
 <7d321bc5-c54e-3584-efd2-0c9401da8655@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <7d321bc5-c54e-3584-efd2-0c9401da8655@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 10/23] q800: reimplement mac-io region aliasing using
 IO memory region
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 05/06/2023 13:43, Philippe Mathieu-Daudé wrote:

> On 4/6/23 15:14, Mark Cave-Ayland wrote:
>> The current use of aliased memory regions causes us 2 problems: firstly the
>> output of "info qom-tree" is absolutely huge and difficult to read, and
>> secondly we have already reached the internal limit for memory regions as
>> adding any new memory region into the mac-io region causes QEMU to assert
>> with "phys_section_add: Assertion `map->sections_nb < TARGET_PAGE_SIZE'
>> failed".
>>
>> Implement the mac-io region aliasing using a single IO memory region that
>> applies IO_SLICE_MASK representing the maximum size of the aliased region and
>> then forwarding the access to the existing mac-io memory region using the
>> address space API.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   hw/m68k/q800.c         | 100 +++++++++++++++++++++++++++++++++--------
>>   include/hw/m68k/q800.h |   1 +
>>   2 files changed, 82 insertions(+), 19 deletions(-)
> 
> Out of curiosity, is mac-io an I/O bus, rather than a MMIO device?

Well for PPC it is currently modelled as a bus, but having worked on the q800 machine 
which is the forerunner to the integrated PPC CUDA/PMU version my best guess now is 
that it is an MMIO device with partial address decoding.


ATB,

Mark.


