Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5542278C381
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 13:41:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qax4i-0008Gr-Ol; Tue, 29 Aug 2023 07:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qax4f-0008Fu-TF
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 07:39:57 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qax4W-0000N9-W9
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 07:39:53 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-500a8b2b73eso6212336e87.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693309181; x=1693913981;
 h=content-transfer-encoding:cc:organization:subject:from:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=idpYPs2gFiTnX8PBeKAykYbJTGbWSWsOs8ccLbmc+hw=;
 b=scy5DQKsGxkileBbi/SSboPmS0xShD/rkNsd+cuuFWSM8oHKPLmJBcnm5XU9DxDwCU
 aFDo9M8R1AECRGDlFSHjXfFoM0HFC7IhRFyBdGdS8KULVmOFGKHbqDZ6tCdh3l/Ky03/
 hU/FN5ve+phkuIuMFjbukr5Bd8qzCrckTt8J606+AlmCu073YUMEpanuOMwQ4rjF223u
 Tv1zke/2dyrewO+ubrjlETuxjGr0lUk+7jthPPigdUGPNGRmv9wgzOQIGjNQWPkF2bE2
 W7ZRzgB3F9eNq7Gzi7utaAc2D5YTRbxgfTDjrN/icMFc3LKnfZ0QZYnsySac5RlZzXNe
 zdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693309181; x=1693913981;
 h=content-transfer-encoding:cc:organization:subject:from:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=idpYPs2gFiTnX8PBeKAykYbJTGbWSWsOs8ccLbmc+hw=;
 b=ewoNyO3R8HMISBsyilDLR+gJf/3pi+b5xduKnVgNhOJRWu7442FKCCg/sK7eVO7+eZ
 WBLXSwbxbrNbRFlVlVkAQX4UMvOJYr+ctagTwq2/FlV1rtxiDV4I9ag60ryiy1z53KCS
 BCJjglvJbnSsAVUbcxuyYL/d8z9qXcfqBpY3GOKtJoSPUX6itWDB0PZ6DsDziER/xgTI
 ikZTwYoaHjKtUFFLusHfxrYa4NzA8bvPaMcBy2Q4iQpF7wK4M7+gtx1qtY+8RbC/fnl8
 wbPElPuPl8BZs8yjo3XBoswbl/6EohpMasa4JwE8uAJ6y37P87FZwzDFCHHy9bgf5Poa
 2XGw==
X-Gm-Message-State: AOJu0YyVIS45cYN8mGPBnn8de1LpDhF75zBiufEWd6QjX17hFYJ6n7sa
 b7OxvZCejQcgbJ1YRLctgK0URaggSxylMkCkzTAp/Q==
X-Google-Smtp-Source: AGHT+IEziar3Kq56l0f7p1fR8/0qPqfhTZbUWqdEwSO4fO0vaaxISnnpX+x+CE5SHJ8cJnD6O+rhJg==
X-Received: by 2002:a05:6512:33c5:b0:4f9:cd02:4af1 with SMTP id
 d5-20020a05651233c500b004f9cd024af1mr22674118lfg.34.1693309179990; 
 Tue, 29 Aug 2023 04:39:39 -0700 (PDT)
Received: from [192.168.200.206] (83.11.188.80.ipv4.supernova.orange.pl.
 [83.11.188.80]) by smtp.gmail.com with ESMTPSA id
 u5-20020ac248a5000000b004fbd39b69adsm1926529lfg.199.2023.08.29.04.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 04:39:39 -0700 (PDT)
Message-ID: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
Date: Tue, 29 Aug 2023 13:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl-PL, en-GB, en-HK
To: qemu-devel@nongnu.org
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Organization: Linaro
Cc: Gowtham Siddarth <gowtham.siddarth@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I am working on aarch64/sbsa-ref machine so people can have virtual
machine to test their OS against something reminding standards compliant
system.

One of tools I use is BSA ACS (Base System Architecture - Architecture
Compliance Suite) [1] written by Arm. It runs set of tests to check does
system conforms to BSA specification.

1. https://github.com/ARM-software/bsa-acs


SBSA-ref goes better and better, yet still we have some issues. One of
them is test 822 ("Check Type 1 config header rules") which fails on
each PCIe root port device:

BDF 0x400 : SLT attribute mismatch: 0xFF020100 instead of 0x20100
BDF 0x500 : SLT attribute mismatch: 0xFF030300 instead of 0x30300
BDF 0x600 : SLT attribute mismatch: 0xFF040400 instead of 0x40400

I reported it as an issue [2] and got response that it may be QEMU
fault. My pcie knowledge is not good enough to know where the problem is.

2. https://github.com/ARM-software/bsa-acs/issues/193


In the comment Gowtham Siddarth wrote:

> Regarding the SLT (Secondary Latency Timer) register, the expected 
> values align with the ACS specifications, registering as 0. However, 
> a discrepancy arises in the register's attribute, intended to be set 
> as Read-Only. Contrary to this intent, the bit field seems to 
> function as> Read-Write. Ordinarily, when attempting to write to the 
> register by configuring all bits to 1, the anticipated behaviour 
> should involve rejecting the write operation, maintaining the value 
> at 0 to uphold the register's designated Read-Only nature. However, 
> in this scenario, the write action takes effect, leading to a 
> transformation of the register's value to FFs. This anomaly could 
> potentially stem from an issue within the emulator.

Does someone know where the problem may be? And how to fix it?

