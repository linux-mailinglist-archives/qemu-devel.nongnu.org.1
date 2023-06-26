Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB6373E341
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:27:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDo64-00011O-9x; Mon, 26 Jun 2023 11:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDo5z-00010g-49
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:25:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDo5x-0008Pj-FD
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:25:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3112f5ab0b1so3035703f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793135; x=1690385135;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3CaNalVW2/DOyUM7C1C59z+I1zyLCsJDQ2qfnVKgVow=;
 b=bGXUg9JXW5UpaUOb44ondjn94oNrlWh2Upy9w3yyvHIAEn/diStDjTx66uYsJT+NUa
 7MnfgIqaKVn3I2Iz9eV+Gagrj+bGrTqN/WReQu6KfvHgIMuwvjVewf3rnd2Og+U7QQUA
 Cyd3+GvPdKHgam0+WhBLNDcVcXE6p+Gg9fg93Q9biYNJ+PvWnwiIKxRz7AxgrxAT5BbL
 oVjj9OBfZte5QyXVS4lTtDWBJ5uKZ/TmAYoMVYX07AZxUNatSOf8N5hh0U2M2RXTNDi4
 IbptAFw8MTMUY8l2tJfbwjXkMR2ay6KZPOiutIasU2emx/ItSUHW3LwqLFwHpYclows/
 KTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793135; x=1690385135;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3CaNalVW2/DOyUM7C1C59z+I1zyLCsJDQ2qfnVKgVow=;
 b=fTa8GztOkEWd1ZCgON1PRR+pm9SAJaBdm5I/UQO78xtsiQXabrou3DvB7s9dppH7hm
 TmMCOk4W/159IorYuL4l+JZilQYGb7p9gFwn4O1VbkEncG6liZzn0QGOMvCkJYpEbFbu
 0K3fl2HuFCELUQgXVARjVMGZdg/mVySr/gAzX83LVo6ikv1JleBSRsWFySIWMTKRixB8
 a0QK8I8A5vt24GaXf9nAnyBRp/+ZWY/YcXnR17IfQSFYqlTrYGZ/+z/b4s+4Ys5Ll6Mo
 g+EDzcYzEfY/xc8XW5dohXi34S2eXXHfZ0P5ErXrObxf4cP6jjLe8hje5xUwPqTUa3qO
 b7LA==
X-Gm-Message-State: AC+VfDwgxqKH6BlM6Twfisk8sCufwVt3QMJyqur2D5RXhWc2SxwtV5sA
 E/49lRMEDyz45rDlirWUcejZkA==
X-Google-Smtp-Source: ACHHUZ5mOC7Ha33UlBPC7SVM+2mnwp72yWXtHM88t6BgxHueBukBZI3OVk4q7ZmmJNNFGDGMjrWLLQ==
X-Received: by 2002:adf:fac8:0:b0:313:eb8d:78e5 with SMTP id
 a8-20020adffac8000000b00313eb8d78e5mr3246975wrs.63.1687793135510; 
 Mon, 26 Jun 2023 08:25:35 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 m9-20020adff389000000b00313f551b032sm1920968wro.53.2023.06.26.08.25.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 08:25:35 -0700 (PDT)
Message-ID: <a7ebe361-6b16-2af9-0dfe-ae2e06b6a819@linaro.org>
Date: Mon, 26 Jun 2023 17:25:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] pc-bios/s390-ccw: Move the stack array into start.S
Content-Language: en-US
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mrezanin@redhat.com,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230626132138.87668-1-thuth@redhat.com>
 <20230626132138.87668-4-thuth@redhat.com>
 <a807476d-fe97-3c05-32d2-371b0a82b92a@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a807476d-fe97-3c05-32d2-371b0a82b92a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/26/23 16:54, Christian Borntraeger wrote:
> 
> Am 26.06.23 um 15:21 schrieb Thomas Huth:
> 
>> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
>> index 29b0a9ece0..47ef6e8aa8 100644
>> --- a/pc-bios/s390-ccw/start.S
>> +++ b/pc-bios/s390-ccw/start.S
>> @@ -120,3 +120,8 @@ external_new_mask:
>>       .quad   0x0000000180000000
>>   io_new_mask:
>>       .quad   0x0000000180000000
>> +
>> +.bss
>> +
>> +    .align  16
>> +    .lcomm  stack,STACK_SIZE
> 
> IIRC, the ELF ABI defines the stack to be 8 byte aligned, but 16 certainly does not hurt.

This doesn't do what you think it does.

.lcomm produces a COMMON symbol, which is merged with .bss at link time.  Thus the .align 
does nothing.  Even switching to .bss section does nothing here.

You want

.bss
	.align 16
stack:
	.space	STACK_SIZE
	.size	stack, STACK_SIZE


r~


