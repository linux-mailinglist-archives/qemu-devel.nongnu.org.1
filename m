Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5F172CEA6
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 20:42:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8mTb-0004YR-0V; Mon, 12 Jun 2023 14:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q8mTO-0004Xk-1x
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 14:41:02 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q8mTM-0002Yg-4T
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 14:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v6in0Kd7TNVfrog6hZgbtbEZ5BYfrMf+UpXWzMV1NAc=; b=g+zKCt2jEJtqb7amEO1Fi3A8ir
 wv0KBhvGEAcIUJLgOIAB2VTK75Eij3gupfBz6Re/NGOsfPgX8ZRSxjfAAisxwdmXEGqazY68AP2SM
 uUrWq9d/BYe6mONk4/SaKHa0exWNN8/x1aKbGc+1uPTgGVEzF+7jY+rh4AsC168sOO6FXzO8CKfYT
 XZ2gRElEJPggll91SnybKhAss+o9BZshIQwaZ2tCe1FQcFwNxkea29fpjf4w7rst9bY8QPa2dGQmG
 qciCtImDn2D3gcX8cFgfQ6qBx53/qlmlbaiGqqRzI4SvuPFE8nRu8MpSPmwELfQWj8fPmEis4PHOV
 qiBUiLl/+APtTFt5S48gOxXcMrN7YmXudccEq3eD3gNQDsi7heXlQXjhGmkpV5bj6oVTswJyM+kz+
 1kdozOVtjKinyFS2+Hu2hNowYz/0+NEF013cV/LSiFJ0hsmVkFwaSnUGA9wdvMQ7pRl1NmU7Gz+5R
 1k82PqLAFhoq0Ly5dYfyJpeMIajDOYFc4BZprkWHeq1A2D5I1ODGCTL2eM6vI+MoPpEmd1XUtR/IZ
 q1bplakz9cVUHbU13I2dum41xI85hGJUYrT+Kbkd8ygbtI6yXtBe5hKN0Nu1zLxjYjpsSkLVvUKZA
 CcmqNI1G9V1BzJs0Dn2bYO7C0dh/btRqEAV5xMq1c=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q8mSq-00097n-DO; Mon, 12 Jun 2023 19:40:32 +0100
Message-ID: <805feb0f-2511-65b8-80c9-8607bf6e57ab@ilande.co.uk>
Date: Mon, 12 Jun 2023 19:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
 <20230606094814.3581397-27-peter.maydell@linaro.org>
 <20230612162044.00002fdc@huawei.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230612162044.00002fdc@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PULL 26/42] target/arm: Use tcg_gen_qemu_{ld, st}_i128 in
 gen_sve_{ld, st}r
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 12/06/2023 16:20, Jonathan Cameron via wrote:

> On Tue,  6 Jun 2023 10:47:58 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> Round len_align to 16 instead of 8, handling an odd 8-byte as part
>> of the tail.  Use MO_ATOM_NONE to indicate that all of these memory
>> ops have only byte atomicity.
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-id: 20230530191438.411344-8-richard.henderson@linaro.org
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Early in debugging but a git bisect pointed at this patch causing:
> 
> ERROR:../../tcg/tcg.c:4317:temp_load: code should not be reached
> Bail out! ERROR:../../tcg/tcg.c:4317:temp_load: code should not be reached
> Aborted
> 
> Just after Run /sbin/init arm64 / virt running on an x86 host.
> cpu max.
> 
> Just reverting this patch results in length check failures.
> I reverted as follows
> 
> 
> revert: Revert "target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r"
> revert: Revert "target/arm: Sink gen_mte_check1 into load/store_exclusive"
> revert: Revert "target/arm: Load/store integer pair with one tcg operation"
> revert: Revert "target/arm: Hoist finalize_memop out of do_gpr_{ld, st}"
> revert: Revert "target/arm: Hoist finalize_memop out of do_fp_{ld, st}"
> revert: Revert "target/arm: Pass memop to gen_mte_check1*"
> revert: Revert "target/arm: Pass single_memop to gen_mte_checkN"
> revert: Revert "target/arm: Check alignment in helper_mte_check"
> revert: Revert "target/arm: Add SCTLR.nAA to TBFLAG_A64"
> revert: Revert "target/arm: Relax ordered/atomic alignment checks for LSE2"
> revert: Revert "target/arm: Move mte check for store-exclusive"
> 
> and all is good - obviously that's probably massive overkill.
> 
> Jonathan

Could this possibly be the same as https://gitlab.com/qemu-project/qemu/-/issues/1704?


ATB,

Mark.


