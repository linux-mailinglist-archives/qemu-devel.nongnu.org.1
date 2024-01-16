Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 355FE82F228
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 17:11:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPm1o-0004uc-K5; Tue, 16 Jan 2024 11:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPm1k-0004mi-Sz
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:11:00 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPm1i-000839-Ol
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:11:00 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cdc1af60b2so27508391fa.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 08:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705421456; x=1706026256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4P4dkecuozc2SVvuN1YwzuSnDMHEyegohOZ1bvfj1hI=;
 b=nndv35qQmnYq94xob/Z2PdPqBi+SzIVzXjm+8cNmIjuI0CQodsJzatr8kxLAAClXDs
 mZlbv3gsDG9+Zaxy2MzWuB0mQAup/QBJPU4cJQYoo6C3XAuyIx6mAQCooAshqoKGE9Xa
 9J7dsmtD0t6jIjaVHXsQJtyOlzy60jJIsS661NjiOkllUuiWsXwNfArj8OB50VtU6P4f
 baqZjJyitzS1Eur7CDYjRMSA683ybvjU+3uzUkNIAC9D8JNKZ06A/8cEspQM3bgl+4aP
 I2954SNzGAp/KQ/Bk8OlkMm9u08TzRQzCTcym4Lcrj5iZ9Hlajxh9uD6gE534ixbgDWn
 n4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705421456; x=1706026256;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4P4dkecuozc2SVvuN1YwzuSnDMHEyegohOZ1bvfj1hI=;
 b=f6lGA+ZCrMbqRGB10vorzsg/xyrYRMxieiqazUAP6O5407Im5uXuFPLgb7ivgOF+hd
 4yODb+YHkzQh5JeSUlh93FfleCa57P5mL8juhs6b7tIEnhCnCa10j72HI/4E65m9qanL
 1diVNvjbJf0tDZBT4RW/3gzi9ChTR2/hPx8nJkNCXWVWLDjxOFEvT26BNTa1eAdjxF3n
 Wreiw+JA1ivICiTgzAlgpItDRA3T5VbCMGSHdLfqeV2cRZVD6i+hvPiBTI7rpoQA8pH3
 gEjgYb4XJ5+kWuZo7Tad3BNmb/V3/dG/BDer/+rorCWHImJaCYFKZ9g3nGF0CjVqGsih
 r83A==
X-Gm-Message-State: AOJu0YzCJu4NeW98KT7ZvNT1nUndUSKzFccS6zm3vHmt1H3zPHwpzCHX
 rKPZEZL8MiuXXCsv1qqgmG1Hme9ILBGoPg==
X-Google-Smtp-Source: AGHT+IGL/IibVAkAtCvXnIROoj344EV/DaEPGIF1517cPKd+b4IhWujWRnJUVqkIh2I5rBpAGFHclA==
X-Received: by 2002:a2e:a37b:0:b0:2cc:6c58:bfef with SMTP id
 i27-20020a2ea37b000000b002cc6c58bfefmr3311048ljn.67.1705421456100; 
 Tue, 16 Jan 2024 08:10:56 -0800 (PST)
Received: from [192.168.1.102] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 cf28-20020a0564020b9c00b00559b6ab71b8sm615988edb.91.2024.01.16.08.10.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 08:10:55 -0800 (PST)
Message-ID: <269f7c8b-df8c-4871-8423-c7a20a8d755e@linaro.org>
Date: Tue, 16 Jan 2024 17:10:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] esp-pci: fixes for Linux and MS-DOS
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, hpoussin@reactos.org, deller@gmx.de, linux@roeck-us.net,
 qemu-devel@nongnu.org
References: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/1/24 14:15, Mark Cave-Ayland wrote:
> This series contains fixes for the esp-pci device (am53c974 or dc390) for a
> few issues spotted whilst testing the previous ESP series.
> 
> Patches 1-3 are fixes for issues found by Helge/Guenter whilst testing the
> hppa C3700 machine with the amd53c974/dc390 devices under Linux, whilst patch
> 4 fixes an issue that was exposed by testing MS-DOS and Windows drivers.
> 
> With this series applied on top of the reworked ESP device, it is possible to
> boot Linux under qemu-system-hppa without any errors and also boot and install
> Win98SE from a DC390 PCI SCSI controller (no IDE!) using an MS-DOS boot floppy.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Based-on: 20240112125420.514425-1-mark.cave-ayland@ilande.co.uk
> 
> 
> Mark Cave-Ayland (4):
>    esp-pci.c: use correct address register for PCI DMA transfers
>    esp-pci.c: generate PCI interrupt from separate ESP and PCI sources
>    esp-pci.c: synchronise setting of DMA_STAT_DONE with ESP completion
>      interrupt
>    esp-pci.c: set DMA_STAT_BCMBLT when BLAST command issued
> 
>   hw/scsi/esp-pci.c | 61 +++++++++++++++++++++++++++++++----------------
>   1 file changed, 41 insertions(+), 20 deletions(-)

Series queued to my hw-misc tree, thanks!



