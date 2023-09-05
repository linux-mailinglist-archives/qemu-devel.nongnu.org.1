Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6956792146
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:05:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdRzd-0006pK-Ss; Tue, 05 Sep 2023 05:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdRzb-0006oW-EP
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:05:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdRzY-0001cY-TF
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:05:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fef56f7248so22557845e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 02:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693904698; x=1694509498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I/rtkaclifMVwreTlgFTtSlHt/oHFewkv6B4xvpVoO8=;
 b=lNdmo0zVsvZVgjVqHSVb/erzxS2XGwc8A+Z/SCu7+xijdGDU8X4/2Ar3MWJUzfzuW0
 FBlqR+xzvwJEYJaVRSi7MN86HarKNLXMmb7S5gUO3xfD2VTEybmpbqld0MoGoeL87gLz
 06KP+4G+JFUsFNjYg/aat+/51K9ALnQLaNeg5oj/pz7WRb2MxGWuKn8rmLFvPOYKLyFZ
 QSYq3eHSCve6Qcl9O6ZaHKGGe46e3smZZMEWBFDRZKgwRDrhq4G52ab3WDn/zYOZFAlM
 y1gDLHw1UKuIne0xeWs0p0jj2HYJGkBpXtcAiB8W9KpWzOGuv2fQnchfDUOn3/EKl5+M
 GaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693904698; x=1694509498;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I/rtkaclifMVwreTlgFTtSlHt/oHFewkv6B4xvpVoO8=;
 b=hvIMLu5c1YB8biDZ199WKsyaMK61w5Hdx8ubeCVm6Us61ARyKOrL0zs603uqrcTdra
 LN7OXxYnVjYutYa16b146zp4Eb32InrFok7cD1UvpKc/VR4HglW9W53qSeZK0dVDaFzz
 HI1Qrq6m2TlgpjcX6Zt60CeUr5apkWp2PraR9yu2yrQWnAshk29ADGF/d0Z6ywofMo7A
 lhCur+sN+FtxH4/r1LVB5Ab4BhU8DGj7J+T12MV7KaEA7MI3EfYxrsVflHwMBvLSfAfF
 YTpy+zxROQu1FAL55ELq9ktfLPHAGv39ewEnSvdAF61UX2omfe5cwZtuF4bWZ3ml7Q1a
 Go+g==
X-Gm-Message-State: AOJu0YzEiu8mcbjWq6R3KpRqwvHK6xNb/wTPl5SjFCUsWkkQdDqN8dhP
 1sEGBcr+go61qF5ahDGv0wrRmQ==
X-Google-Smtp-Source: AGHT+IEt4fdGCm9gpoJs/bgzm6WL9WV5xkA/o6UgWAzxHdyvBXMGuXmE5ByfHHyS+bnDZETZxDYN6g==
X-Received: by 2002:a05:600c:19d2:b0:402:cc5c:c98 with SMTP id
 u18-20020a05600c19d200b00402cc5c0c98mr4321807wmq.13.1693904697924; 
 Tue, 05 Sep 2023 02:04:57 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 fa20-20020a05600c519400b00402d7105035sm946919wmb.26.2023.09.05.02.04.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 02:04:57 -0700 (PDT)
Message-ID: <6c7c4237-4052-cec7-d515-8ac6dc33ec1f@linaro.org>
Date: Tue, 5 Sep 2023 11:04:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 0/5 v2] CXL: SK hynix Niagara MHSLD Device
Content-Language: en-US
To: Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 junhee.ryu@sk.com, kwangjin.ko@sk.com,
 Gregory Price <gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230901012914.226527-1-gregory.price@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 1/9/23 03:29, Gregory Price wrote:
> v2:
> - 5 patch series, first 4 are pull-aheads that can be merged separately
> - cci: rebased on 8-30 branch from jic23, dropped cci patches
> - mailbox: dropped MHD commands, integrated into niagara (for now)
> - mailbox: refactor CCI defines to avoid redefinition in niagara
> - type3: cleanup duplicate typecasting
> - type3: expose ct3 functions so inheriting devices may access them
> - type3: add optional mhd validation function for memory access
> - niagara: refactor to make niagara inherit type3 and override behavior
> - niagara: refactor command definitions and types into header to make
>             understanding the device a bit easier for users
> - style and formatting
> 
> This patch set includes an emulation of the SK hynix Niagara MHSLD
> platform with custom CCI commands that allow for isolation of memory
> blocks between attached hosts.
> 
> This device allows hosts to request memory blocks directly from the device,
> rather than requiring full the DCD command set.  As a matter of simplicity,
> this is beneficial to for testing and applications of dynamic memory
> pooling on top of the 1.1 and 2.0 specification.
> 
> Note that these CCI commands are not servicable without a proper driver or
> the kernel allowing raw CXL commands to be passed through the mailbox
> driver, so users should enable `CONFIG_CXL_MEM_RAW_COMMANDS=y` on the
> kernel of their QEMU instance if they wish to test it
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> 
> Gregory Price (5):
>    cxl/mailbox: move mailbox effect definitions to a header
>    cxl/type3: Cleanup multiple CXL_TYPE3() calls in read/write functions
>    cxl/type3: Expose ct3 functions so that inheriters can call them
>    cxl/type3: add an optional mhd validation function for memory accesses
>    cxl/vendor: SK hynix Niagara Multi-Headed SLD Device

Being at commit 17780edd81 I can't apply this series:

Applying: cxl/mailbox: move mailbox effect definitions to a header
error: patch failed: hw/cxl/cxl-mailbox-utils.c:12
error: hw/cxl/cxl-mailbox-utils.c: patch does not apply
Patch failed at 0001 cxl/mailbox: move mailbox effect definitions to a 
header

On what is it based?

Thanks,

Phil.

