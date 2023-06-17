Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D48734468
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 00:53:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAenC-0000eZ-0A; Sat, 17 Jun 2023 18:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAenA-0000bH-2w
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 18:53:12 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAen1-0005LZ-Lv
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 18:53:11 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-311099fac92so1982180f8f.0
 for <qemu-devel@nongnu.org>; Sat, 17 Jun 2023 15:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687042380; x=1689634380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=38KvE02SwxgYpioAFiWQ4GXP6pc0vQrcdcFV73Mtn/4=;
 b=ybOIV4YSeh5KHoCebbHBvrkbjcbHYimedfpnEwhE3Nn2MoZZRBIUCKuG74C/JJ5dwC
 BkvKupRtLZqV6sc6pUeUMzDlDVOW8Li2IH05b/lCY4+GVUz/+6qe+nob2FAh3Z/cdw/C
 DnKxjLHuHJcyepuhVRornI7hgYOaoSm7O+i1ISEYdV4w66S19I2ZXdlCkA7mLp7ysQQE
 eI7L4Sg1y1eypYBzbKF02+j2ykd7GGq6p0gBwJpMoBxdEb2tMGRspGePsD0g5CQvSEPN
 BngblMbuEK8kodHvQiqVvcRa8zy4/Tn+rbJkYo+SKbN54iZwWitV0he73ZijD0KPzs1H
 AeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687042380; x=1689634380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=38KvE02SwxgYpioAFiWQ4GXP6pc0vQrcdcFV73Mtn/4=;
 b=BwWMfgJkfCBBVstlhlezlAqfQGWCpiWw3IwCJPc+p6Y5N0fXkTGN2F66qFeD2DFgVu
 L28yBRXin3fCUKVZRFseY/F+zua/a+ZqqkybLh0zCgEoUDlFEktcjt0KbG5p2hEctoDZ
 gHwQDiY6hprifmURkWyc1qhvjh0BL674tKoHK1H5NWsO7BdSMCZ3+IDdpn62XEPiSGXv
 RRPqtLdiiznZAwoyRG6sHVHlVasz+tA8WHGtm/u48JPJYsXe8cXoM8cGZGkfAOJtRIIq
 87iHCh4h+gNpCngMH4deybrpk5NrpW1IqFTLP6toEDtF/wrkIrkPuoTMlFKYnxTs9E7I
 AhGg==
X-Gm-Message-State: AC+VfDw/xElE7aVqqgPvjtKjOlRtuGENuZEVHGMW7seYDRP133MsbuSd
 x+voK6QdJmIc0ae2GakT3dLKLg==
X-Google-Smtp-Source: ACHHUZ43qwVDyX1hcl3FAuZtWpHOAd7mMv6UOK1KPuJrSUM8irB+X5xQVOF68HsnuqucdONibOzuBA==
X-Received: by 2002:adf:ef50:0:b0:30f:cc45:5af1 with SMTP id
 c16-20020adfef50000000b0030fcc455af1mr4323473wrp.45.1687042379914; 
 Sat, 17 Jun 2023 15:52:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.220])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a056000054e00b0030c2e3c7fb3sm27061023wrf.101.2023.06.17.15.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Jun 2023 15:52:59 -0700 (PDT)
Message-ID: <6346223b-a67d-9332-bbbb-ef60066ed9f1@linaro.org>
Date: Sun, 18 Jun 2023 00:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/6] tests/tcg/cris: Correct the off-by-one error
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20230617053621.50359-1-bmeng@tinylab.org>
 <20230617053621.50359-3-bmeng@tinylab.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230617053621.50359-3-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 17/6/23 07:36, Bin Meng wrote:
> sysconf(_SC_OPEN_MAX) returns the maximum number of files that
> a process can have open at any time, which means the fd should
> not be larger than or equal to the return value.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - new patch: "tests/tcg/cris: Correct the off-by-one error"
> 
>   tests/tcg/cris/libc/check_openpf5.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


