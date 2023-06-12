Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 940C372D48A
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 00:39:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8qBu-0005H1-JA; Mon, 12 Jun 2023 18:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8qBs-0005GF-MA
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:39:12 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8qBr-00006p-3G
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 18:39:12 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5187351abfeso196692a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686609549; x=1689201549;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dsiK36Zmt5H1wOfBHduVkUzN18Q3uds4WkgDgIT11Dg=;
 b=JzNYK1WYZVWCQsccl2kYJD9XqRuFny1WpDqQAw/o5ltNT4dJ+98j6uJUPSi00lj2j1
 1Kc1mB0bP74mi022ajaOYeqSE7MB4SI40LOrLW4F5RWvm6a/z1iRweGf8PFGA8BsILjQ
 MT+Kl130XtIQpZUXicHp8gBjvnUH8Abn33qycy0KX1kq1Ee4eZVldjKRnqAB4JOiZ9eD
 z/zrfnWzz4rwKa0CLcGB7d5vvPq1clW4nkmD6RS2aL2shUVo2pjwf1S4PhUIlBcVK6FP
 vPEOIGXMRbT2a4SEze3/FmkSn6Mhi+cEpMYeDKLpKVDgyDzrVwpyu0CXMf4Ot+/b8qby
 sQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686609549; x=1689201549;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dsiK36Zmt5H1wOfBHduVkUzN18Q3uds4WkgDgIT11Dg=;
 b=I5EV+V21paSXSCkyp8U8VrJVX0uaZx4S5ws7QYSOCs1R6yp4THZBxkfGE8p4FlJFyX
 WKhTvmUuVqJ36Wk6PRhT24XapgDpI23Hs7GA5fjBLEtfr1uzNWmIHydiwuaNgto3M3QI
 ANpbN05nuWmNKYwiUNd4r38i0+XdzrzNQq51xsIzJAfbZLr1CTOprf83qMa8BTWreWQ1
 R4QTORPvyklIxNoS8+vaO/oVQhFAjdqbV5tW2tzD0AtK5kT7kckL1RS/BTlmYq95N7Z7
 KwRMN35OaKre4+RJHtv3FFFgWuSCsdZSQnZH83O9Zzh7EBS1fjQAKFa7MA7HLm+HQwXj
 vlAg==
X-Gm-Message-State: AC+VfDzwOjGPKszYSEO2dB1bmp/IqffL3nLi9P6z/ZIvL9ulxqw+6MmY
 u3gz5AIkvN0M0Om1coPMSImYTg==
X-Google-Smtp-Source: ACHHUZ5rvg8MjC3nTz1SBoyVmPk1VddPcu34DqrRuBOBaa19+JbTdDyh8AhxZ5b07J9A7B83QSgApg==
X-Received: by 2002:a50:fe98:0:b0:514:9b60:ea65 with SMTP id
 d24-20020a50fe98000000b005149b60ea65mr1778754edt.16.1686609549710; 
 Mon, 12 Jun 2023 15:39:09 -0700 (PDT)
Received: from [10.10.0.115] ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 o13-20020aa7d3cd000000b005083bc605f9sm5598276edr.72.2023.06.12.15.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 15:39:09 -0700 (PDT)
Message-ID: <b2226d76-7c93-3623-69f0-5029ddc42aa3@linaro.org>
Date: Tue, 13 Jun 2023 00:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 5/5] cmd646: move device-specific BMDMA registers to
 separate memory region
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
 <20230609185119.691152-6-mark.cave-ayland@ilande.co.uk>
 <76F6648A-47D8-4975-8344-93BE5DD6A071@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <76F6648A-47D8-4975-8344-93BE5DD6A071@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 12/6/23 21:28, Bernhard Beschow wrote:
> 
> 
> Am 9. Juni 2023 18:51:19 UTC schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
>> The aim here is to eliminate any device-specific registers from the main BMDMA
>> bar memory region so it can potentially be moved into the shared PCI IDE device.
>>
>> For each BMDMA bus create a new cmd646-bmdma-specific memory region representing
>> the device-specific BMDMA registers and then map them using aliases onto the
>> existing BMDMAState memory region.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>> hw/ide/cmd646.c         | 111 +++++++++++++++++++++++++++++++---------
>> include/hw/ide/cmd646.h |   4 ++
>> 2 files changed, 90 insertions(+), 25 deletions(-)


>> struct CMD646IDEState {
>>      PCIIDEState parent_obj;
>> +
>> +    MemoryRegion bmdma_mem[2];
>> +    MemoryRegion bmdma_mem_alias[2][2];
> 
> The added complexity of a two-dimensional alias array seems like a tough call for me. I'm not totally against it but I'm reluctant.

Alternative:

         struct {
             MemoryRegion mem;
             MemoryRegion mem_alias[2];
         } bmdma[2];

>> };
>>
>> #endif
> 


