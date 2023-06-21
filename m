Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA69737E24
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:15:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtvI-0006UB-02; Wed, 21 Jun 2023 05:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtvE-0006TP-2K
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:14:40 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtvC-0004Tc-7n
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s8gAWWQ3yPzKzwInyUQ+XwslVjP6fQiUmc7wRqZiBc8=; b=g5yvVE7QyIa2nCLMylaRU1YTGh
 t9EywSx7VWV91O2O3OlhU0jrhH/o2PJa0fLU6o6Yv6SnXttNvzPSFpk8kSTwYzLZUDsl1SsOuoLIu
 ONCqYV2as04H5UPVcqjdVzjsyuysdH9T3/UqQPZMxmnENR+aoF5GuKJIYgRu4mwL9mGj2T+Nq/Vj2
 ExC4zVOHkIMgxHA3NTXNSlgYzrL7n/hqV/0nU79mg+KeWu79/RBwPInGuVGwMQMKhzta4tz7VJ47y
 VOMJYZ4Ud4bKo6JXJyz9cNJ0GI1K830dugODeSKYJHM194Ax3avJI/TBxENrb76+Do32q8FUa1HkT
 DKkt1c3aHEBxMig02bahmSk52RKJjiJc3f+r7e+dv+jIlm+U78rulmR9qO0TzO9700U1pWDDfMMio
 Rr0TNSyjQSSzMxfC6treKRqRVjPW6tCodVyCeVWmnFm5QDGhi4U6d0eScNq0s53ho/D7HGpgfKP7y
 b7IRqHRwDZzzGB3gbB/ndFMUc51SPPd0s6iZtFY5IldqAi1AOGdVcZuwC6EY8MwRP2NHDp0E1wu9B
 m4j8BTzTB+7VBz6Q/ixmSpGGzDMIeRBgd59tOL0JpCc/dsCN/uJJZWx9N7vbSsGR6oy3ne2iWJwDo
 9pRv5aLf52CDL0A+qtsBFXv3ze+FSTpDaNb8G5zq0=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtv0-0001oD-Ga; Wed, 21 Jun 2023 10:14:29 +0100
Message-ID: <0489cb19-8d5e-7cdd-4c98-12fea8afa0d1@ilande.co.uk>
Date: Wed, 21 Jun 2023 10:14:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230405185922.2122668-1-richard.henderson@linaro.org>
 <2d46a274-8234-a635-81ca-c79c2969cb7b@linaro.org>
 <fc35257d-8af0-8aa1-af88-982c7506bfa5@ilande.co.uk>
 <a5c261f4-b3e5-314f-b28f-dfac54a0bed8@linaro.org>
 <f7d45693-78db-261b-f016-c198a7c98d97@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <f7d45693-78db-261b-f016-c198a7c98d97@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH for-8.1] target/sparc: Use tcg_gen_lookup_and_goto_ptr
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

On 19/06/2023 16:41, Richard Henderson wrote:

> On 5/11/23 13:02, Richard Henderson wrote:
>> On 5/11/23 09:40, Mark Cave-Ayland wrote:
>>> Obviously nothing notionally against this patch, however if you could give me a 
>>> few days to run my OpenBIOS SPARC32/SPARC64 boot tests against git master with 
>>> this patch applied to double-check there are no regressions, that would be great.
>>
>> No problem.  I just didn't want it to get lost.
> 
> Ping for results?
>  
> r~

Sorry I haven't had a chance to test this yet - I'll try and get to it later today.


ATB,

Mark.


