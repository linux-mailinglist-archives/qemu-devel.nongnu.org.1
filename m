Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DA97DEC58
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 06:37:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyQNQ-0003bX-J3; Thu, 02 Nov 2023 01:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leohou1402@gmail.com>)
 id 1qyQNI-0003b7-OF
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:36:12 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leohou1402@gmail.com>)
 id 1qyQNH-0007IH-4c
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:36:12 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc7077d34aso4290145ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 22:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698903369; x=1699508169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3EQPZ+53daYZDLmyOKchtGaFy6eJO4MgoGn5GBWHPPs=;
 b=HCOEEuavcVFTN8MOvXLdsd6oDpnR8/y6OyxxzNowA4MHmavTdC+qF8FntzkSvYsEi9
 JHdk7JDb5tOoWwO99bSS/YKC74qOngqWW18YD1gkg/IZ8mQUDk9fdfOhqP+vIWUxg7va
 1jFxaK96OqaACiqFGljEESMJwyJ6wy0xOwgx4RZpnWB8HOXaP0aDlSnGXYQVoSJmykmy
 ldXSNeWDBqj/F+mczNq0oicYmsazxBgHeGS9R4pauSftjYli1gfvMB1Doh1QhMN25Yr2
 FUiXF173+3+MLFEkEyB88IxPukTe71/D2+f36ak70wzOtoVSFzoPKu+E4ULlz626xuV1
 n2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698903369; x=1699508169;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3EQPZ+53daYZDLmyOKchtGaFy6eJO4MgoGn5GBWHPPs=;
 b=OcvTO5PhH1t+iCdKLd7eSsY1MqhkPD3hG3tZMdjl7gAdugXq0CK5UKZ8oS3XZ5To3U
 nMB1xOMit7DGNIIeZl52kYRkkiPHWUjyA2SrxKHOembzisebHED/HcxbqfjF8/Nc/R3l
 a4Y/nluCbhHLYt8eFvMvDQjXYcdC7D5M+kcJuS681iQVwHeBWglGFgJQcif2pNy2gLAY
 VuodHcOYf97lcY7q1OHVMr0lW0y6NesQfcwEdVbNLcVDaXnkVurDqw4ukzABFykJaiu+
 OYnOpkt2lsmw+Bb6J+BBXrYGFH7p4oAdZAoobffitRUiCoHBatB4agkzwTs8/CsyMo8j
 dZmw==
X-Gm-Message-State: AOJu0YzeJaFUFDRLG4yl2i711uI8Ysj3syESThBslDPhhPNetNOtxyTh
 sjHo4J2KfPOTMsdhIbS+YD0oAe4FezNnL8Fx
X-Google-Smtp-Source: AGHT+IG1DLNhb+WkKi7CN1sUSJgyySHU9am19eXZq/P0qeVT5wOyIloWWyDt0k3HF5IcL+KRk1rgNQ==
X-Received: by 2002:a17:902:ab43:b0:1c9:c3a7:f96d with SMTP id
 ij3-20020a170902ab4300b001c9c3a7f96dmr12335643plb.62.1698903369167; 
 Wed, 01 Nov 2023 22:36:09 -0700 (PDT)
Received: from [10.100.201.23] ([40.83.119.27])
 by smtp.gmail.com with ESMTPSA id
 kb14-20020a170903338e00b001cc5225c220sm2185459plb.15.2023.11.01.22.36.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 22:36:08 -0700 (PDT)
Message-ID: <e96c2abc-ead3-4b3b-992e-e5a2c48a8fa3@gmail.com>
Date: Thu, 2 Nov 2023 13:36:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogRnc6IOadpeiHqkxlbyBIb3XnmoTpgq7ku7Y=?=
Content-Language: en-US
From: leohou <leohou1402@gmail.com>
To: qemu-devel@nongnu.org
References: <3ab81ab1.1faf.18b8df8f26e.Coremail.leohou163@163.com>
 <202311021133346289459@gmail.com>
 <0a514711-41cc-43ec-ba2d-16109eae783d@gmail.com>
In-Reply-To: <0a514711-41cc-43ec-ba2d-16109eae783d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=leohou1402@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 2023/11/2 12:46, leohou wrote:
> On 2023/11/2 11:33, leohou1402@gmail.com wrote:
>> On 31/10/23 16:13:32 Philippe Mathieu-Daudé wrote:
>>> Hi Leo,
>>>
>>> On 31/10/23 04:10, Leo Hou wrote:
>>>> hi , all
>>>>          Does qemu plan to support CPU heterogeneity?
>>> Short answer is yes. When will this be available is yet to
>>> be determined, as a lot of work is required.
>>
>>
>>> I'm going to talk about the challenges and possible roadmap
>>> later today, feel free to join the call scheduled at 2pm CET
>>> on https://meet.jit.si/kvmcallmeeting.
>>> (See
>>> https://lore.kernel.org/qemu-devel/calendar-1ad16449-09cc-40fb-ab4a-24eafcc62d2a@google.com/) 
>>>
>>
>> Hi Philippe
>>
>>
>> Thank you for your reply. I didn't check my email in time
>>   because of the mailbox problem. Now I will reply to you
>>   by changing my email address.
>>
>> With regard to your discussion, is it convenient to announce
>> the results of the discussion now?
>
> Is there a need for the architecture of the main cpu and several 
> coprocessors?
>
>
Examples include SCP and MCP in the ARM N2 platform, or an ARM host 
machine containing a risc-v coprocessor.

