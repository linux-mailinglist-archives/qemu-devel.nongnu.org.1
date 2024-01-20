Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C8F83353A
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 16:25:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRDBy-00083Y-Fr; Sat, 20 Jan 2024 10:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rRDBv-00083Q-V6
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 10:23:27 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rRDBt-0007Kn-Uy
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 10:23:27 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d73066880eso2882845ad.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 07:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705764204; x=1706369004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=QpuU/fFh7kDMZS3Lrr/Md7q6lvt2jJoRJoQMk5qGeb4=;
 b=P3jQxj+Cpe8EP+keivoNvOYUiSS7gEbn0w2QjI3D86gT+VBs4UMsosZWycT7YexU0U
 M//EoZvfuzqyBYHUmL8BS5BZmOH9E5hG4oy/SEbHoeujS1n5aBQoXUKy+//n/r7f1q4f
 lrBPJNfcXDUIsYz24wKgneqXCGk4DkFwVUW15hFnhJ3sgqabH5bThuv5wtfVjklP3rPx
 /9Vadg9cPIZ2cvBJYcrEcRsSqxklLlTm2nUtPCrtXjUkGQDOaR339OYvqIvDWENqpicx
 +YCWr0ZMJs3Tq+6Hfc2CxMtQjpi+v4Idg/TPJsCg6U/7/ACVUWdO4z7M9D/1rwY3ditA
 JzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705764204; x=1706369004;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QpuU/fFh7kDMZS3Lrr/Md7q6lvt2jJoRJoQMk5qGeb4=;
 b=JnTs6kkBLqkSIGtnYnM76caGfwvBascfFyXRiBYhROn0D8UiX/UB3VFgF90qv+P/Bg
 CN1DAG3NuvNmPoX3AugXDaauDhnCYSK7RVchdsqUY2sH6uTRPskCoXttRNHtlJ83FIVQ
 4/8mc5dzAk7wXQxs/lMZfkRSB5vbOZFaPmOlULDM1Uzf3bRY1z7o/JWwe9YKFdYTv0YN
 xslViWsli16dwEe28y6QuwoYnmYUWcBvp7gV3Ln0y7vczeNyuGiI+kp//SRe1VCX3kS5
 M7EFhZrgvxWM4ci2p5FAF2ASGc6+qLg+nTX50QLpqj27YEAGzzTMMjAQkkT8HrcZXCMr
 PJcg==
X-Gm-Message-State: AOJu0YwvuleF/rngowqcJW6/3z2yhGyIiKxAjy2JqIpazCvpTv7YiWlJ
 B76pazvo5Zn1Zj/aBlMNCZFedOXqFv+qTxajXtT4pGJR1f5jB1K2
X-Google-Smtp-Source: AGHT+IF9YOMgTk8zvDg1GziUadd6iGCotT/DrOb1NobyOvRmlEiYe+McBocF9G81pdETtLmHGC6agw==
X-Received: by 2002:a17:902:b708:b0:1d5:ae9f:251d with SMTP id
 d8-20020a170902b70800b001d5ae9f251dmr1642676pls.95.1705764204366; 
 Sat, 20 Jan 2024 07:23:24 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 sm9-20020a17090b2e4900b0028ffea988a2sm6255095pjb.37.2024.01.20.07.23.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jan 2024 07:23:23 -0800 (PST)
Message-ID: <c57fb786-2ba9-476a-8314-04caf5fc29da@roeck-us.net>
Date: Sat, 20 Jan 2024 07:23:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] esp-pci: fixes for Linux and MS-DOS
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, hpoussin@reactos.org, deller@gmx.de, qemu-devel@nongnu.org
References: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
 <9ceaeead-107a-4766-b5da-a9060ddeddf4@tls.msk.ru>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <9ceaeead-107a-4766-b5da-a9060ddeddf4@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/20/24 05:09, Michael Tokarev wrote:
> 12.01.2024 16:15, Mark Cave-Ayland:
>> This series contains fixes for the esp-pci device (am53c974 or dc390) for a
>> few issues spotted whilst testing the previous ESP series.
>>
>> Patches 1-3 are fixes for issues found by Helge/Guenter whilst testing the
>> hppa C3700 machine with the amd53c974/dc390 devices under Linux, whilst patch
>> 4 fixes an issue that was exposed by testing MS-DOS and Windows drivers.
>>
>> With this series applied on top of the reworked ESP device, it is possible to
>> boot Linux under qemu-system-hppa without any errors and also boot and install
>> Win98SE from a DC390 PCI SCSI controller (no IDE!) using an MS-DOS boot floppy.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Based-on: 20240112125420.514425-1-mark.cave-ayland@ilande.co.uk
>>
>>
>> Mark Cave-Ayland (4):
>>    esp-pci.c: use correct address register for PCI DMA transfers
>>    esp-pci.c: generate PCI interrupt from separate ESP and PCI sources
>>    esp-pci.c: synchronise setting of DMA_STAT_DONE with ESP completion
>>      interrupt
>>    esp-pci.c: set DMA_STAT_BCMBLT when BLAST command issued
> 
> Is it worth to pick up for stable?  Especially the first one.
> It's interesting this bug is here for a very long time.. :)
> 

FWIW, I never observed the first one with Linux. I had carried variants
of the other three in my tree for a long time, but they were never
in a shape to be sent upstream and I never bothered trying to find
the root cause. All those _can_ be observed when booting Linux. So,
if anything, I'd argue that they should all be taken into stable
releases.

Thanks,
Guenter


