Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9419380B3C6
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Dec 2023 11:48:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBurb-0007HR-Sz; Sat, 09 Dec 2023 05:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBurZ-0007HC-VI
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 05:47:14 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBurY-0005xX-8q
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 05:47:13 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3360ae1b937so993423f8f.0
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 02:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702118830; x=1702723630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B0745HwPGaf8LJudLxxai9MHr04sbyDf8Frov0s+qp4=;
 b=S3Lr0kOMTeHvrHyabP77uSuCsfaw2EZTHX/rJCFlBkznIowFTq7sAuUMWwq/hs5d45
 4YVh3+Ep1yQ/bnQ8MWesk4rMbc0EEB+M6RQ4bHHJpS1OJzvtfPNX/MjJSpzdaP1A58Cx
 56SD5Ws86GjUvUqEi63CwNO31KmeN1Q5mRDC7V3RWIVLzOurLdRR+ZQqeyzCHSLnU5Mk
 +5nSMf9IWMXV+iKVVXTqQSyOmYtn3ajv6htkHaLXzBhVrdICZlFE9jvdvKPlMUPNscQR
 V/mhHKXrvuFHn5bmBN8bDCFLZY/b0SOGQju92A2NzpMUxxJq43JLCv0bT9OrM75ehqTS
 BAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702118830; x=1702723630;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B0745HwPGaf8LJudLxxai9MHr04sbyDf8Frov0s+qp4=;
 b=EYLFhRfsPQ9Fw++81avx1CDZIPpwQy92Bu3RzVOUmJPz3puK7TDARSNNDy/VLqpQdZ
 A+ogu8/HMzPY6VzcJxE7850vNTRFkB0UU0354+LTtgOGUux0Z9k1uA3qyvkeOLEMHcLp
 TQgAwSUfj60skvXL0z9Lbi0/oHqZI8LcDxenA8C/TscPiU6GDlr63QK3p2VNdKcdfbKx
 ZDtKzbD+OrtSkCYl6VITpgomo7oYGiuRbSvQVaRJ+YX/WmJrqvBhCAwHe+oMzYd/FlLN
 PMCb+q9CyHurNnIUkbAl84Uziu/YeeEg7a3WQ8iTkxkLHbneR+3oawoZL+GkepU1KTGB
 j+rw==
X-Gm-Message-State: AOJu0Yz4ASPnL6GOuVx7Q1j76OhXjt5MF7ivwVzEWVMyLVoPngawgZcc
 i5ifOv5Dk4cKgGyRouX8nvcRNA==
X-Google-Smtp-Source: AGHT+IForjWJxGFZLxBmm/G25duwRXAke91jGhWRWFDF2k1uKUZbxp1eB8iDw1WTiCeRXqL5HB55uA==
X-Received: by 2002:a5d:58d4:0:b0:333:2fd2:8160 with SMTP id
 o20-20020a5d58d4000000b003332fd28160mr713978wrf.125.1702118830429; 
 Sat, 09 Dec 2023 02:47:10 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.54])
 by smtp.gmail.com with ESMTPSA id
 rd12-20020a170907a28c00b00a11b2677acbsm2049956ejc.163.2023.12.09.02.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 02:47:10 -0800 (PST)
Message-ID: <364000d5-433f-4356-823f-1a4be43a4c8d@linaro.org>
Date: Sat, 9 Dec 2023 11:47:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/45] Raspberry Pi 4B machine
Content-Language: en-US
To: Sergey Kambalin <serg.oker@gmail.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Hi Sergey,

On 8/12/23 03:31, Sergey Kambalin wrote:
> Introducing Raspberry Pi 4B model.
> It contains new BCM2838 SoC, PCIE subsystem,
> RNG200, Thermal sensor and Genet network controller.
> 
> It can work with recent linux kernels 6.x.x.
> Two avocado tests was added to check that.
> 
> Unit tests has been made as read/write operations
> via mailbox properties.
> 
> Genet integration test is under development.
> 
> Every single commit
> 1) builds without errors
> 2) passes regression tests
> 3) passes style check*
> *the only exception is bcm2838-mbox-property-test.c file
> containing heavy macros usage which cause a lot of
> false-positives of checkpatch.pl.
> 
> I did my best to keep the commits less than 200 changes,
> but had to make some of them a bit more in order to
> keep their integrity.
> 
> This is v2 patchset with the most of v1 remarks fixed.
> I named it as 'v4' because of mistakes while attempts to send previous patchsets
> Please ignore all other v1...v3 patchsets except the very first one.

I really want to review your series, but I have been busy and
won't have time to look at it the next 2 weeks :/

Thanks Peter for reviewing the previous version :)

> Sergey Kambalin (45):
>    Split out common part of BCM283X classes
>    Split out common part of peripherals
>    Split out raspi machine common part
>    Introduce BCM2838 SoC
>    Add GIC-400 to BCM2838 SoC
>    Add BCM2838 GPIO stub
>    Implement BCM2838 GPIO functionality
>    Connect SD controller to BCM2838 GPIO
>    Add GPIO and SD to BCM2838 periph
>    Add BCM2838 checkpoint support
>    Introduce Raspberry PI 4 machine
>    Temporarily disable unimplemented rpi4b devices
>    Add memory region for BCM2837 RPiVid ASB
>    Add BCM2838 PCIE Root Complex
>    Add BCM2838 PCIE host
>    Enable BCM2838 PCIE
>    Add RNG200 skeleton
>    Add RNG200 RNG and RBG
>    Get rid of RNG200 timer
>    Implement BCM2838 thermal sensor
>    Add clock_isp stub
>    Add GENET stub
>    Add GENET register structs. Part 1
>    Add GENET register structs. Part 2
>    Add GENET register structs. Part 3
>    Add GENET register structs. Part 4
>    Add GENET register access macros
>    Implement GENET register ops
>    Implement GENET MDIO
>    Implement GENET TX path
>    Implement GENET RX path
>    Enable BCM2838 GENET controller
>    Connect RNG200, PCIE and GENET to GIC
>    Add Rpi4b boot tests
>    Add mailbox test stub
>    Add mailbox test constants
>    Add mailbox tests tags. Part 1
>    Add mailbox tests tags. Part 2
>    Add mailbox tests tags. Part 3
>    Add mailbox property tests. Part 1
>    Add mailbox property tests. Part 2
>    Add mailbox property tests. Part 3
>    Add missed BCM2835 properties
>    Append added properties to mailbox test
>    Add RPi4B to paspi4.rst


