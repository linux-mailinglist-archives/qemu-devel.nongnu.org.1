Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2082734466
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 00:52:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAekx-000831-Ve; Sat, 17 Jun 2023 18:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAekv-00082b-Bf
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 18:50:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAekt-00057m-Nf
 for qemu-devel@nongnu.org; Sat, 17 Jun 2023 18:50:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f8fa2cf847so15204855e9.1
 for <qemu-devel@nongnu.org>; Sat, 17 Jun 2023 15:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687042249; x=1689634249;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mpjI/kSgw65NyYmx+3KyUtMLklPwu7wxuqa7mRRP4iU=;
 b=y54eFsY7TV+AskaDiq5BRbGtdD2tTwXhC60AFM9yz5ewhZhyJ9mHZuyUZa0qt63cHG
 259gMNTFrpKHIzfynFu54eKURKgjo4HWgkXemtAvtubZSiHN/lNZV0RN59c/zUG8lLhV
 4J6EflA+MkHkLDE1Rlfbg6NhG63NGdcatTY9KSMx5nHYuDmMwwV0pFLg+MsG20nUBjba
 RyngdZBe5Ye41X8ip5R0wIJ+1i4Yj2h6yYAscXl54Z2vBMMVNQa/Pi7NpJ6PITVPXVt8
 uGJoXvNUoJFkuIHPRiZ8md1iKvectFbzo2dWNVfXMUGnZj2NRwufNt4r68ddpif79p/n
 1K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687042249; x=1689634249;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mpjI/kSgw65NyYmx+3KyUtMLklPwu7wxuqa7mRRP4iU=;
 b=Kif6EL62GAQNx783NvEsSyLKJRkbMivcc6qun15gKzMIu60ncJwCNzcIekLQFNYEWb
 pyoFPkkhG1tAe7a4iPQzAQ2dn8VHoL3eqb+C/5bqezcZ0LjQZ5MZEYBahWyY6MZpbVrb
 3venl7TD31eJUNCXLyd+fk+8BIjchs87AZB8e2ousETmAU8VVTqvdXiJxaG/L6eZuPKW
 DPN+CnlbxPC4sImKM07exseE86nR696kNi2gA+H/vnynlBb4Vd8HfcOjeRkVZxprn8ss
 XXNkVYnpPON7T6hu3C3skA8MvaFUSVTOjKAJwRwg5ottMXz+wucISbUE7EFhkc/wCmox
 DTZw==
X-Gm-Message-State: AC+VfDwclBRISclNqQFIaQo+bLszkkZgOA+g2owfTCO6vFvsiDzxQe0O
 TLWcG568DLIcspvA1fx0jCrnNyMSRH5gxLucmU4=
X-Google-Smtp-Source: ACHHUZ5jy+Gvxk7of3gLUwv9h9jIWlhBXOH0gWYuh3SALzLimb57jr/wv1s6MT8LXwOalBu7UQsxtg==
X-Received: by 2002:a7b:c045:0:b0:3f7:948f:5f17 with SMTP id
 u5-20020a7bc045000000b003f7948f5f17mr4882042wmc.7.1687042249002; 
 Sat, 17 Jun 2023 15:50:49 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.220])
 by smtp.gmail.com with ESMTPSA id
 18-20020a05600c231200b003f9063fc3cbsm2672309wmo.44.2023.06.17.15.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Jun 2023 15:50:48 -0700 (PDT)
Message-ID: <e36a681f-53e2-8379-078e-25e43fc3966e@linaro.org>
Date: Sun, 18 Jun 2023 00:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2] hw/arm/xlnx: Connect secondary CGEM IRQs
Content-Language: en-US
To: Kinsey Moore <kinsey.moore@oarcorp.com>, qemu-devel@nongnu.org
References: <20230616143803.73926-1-kinsey.moore@oarcorp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230616143803.73926-1-kinsey.moore@oarcorp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 16/6/23 16:38, Kinsey Moore wrote:
> The Cadence GEM peripherals as configured for Zynq MPSoC and Versal
> platforms have two priority queues with separate interrupt sources for
> each. If the interrupt source for the second priority queue is not
> connected, they work in polling mode only. This change connects the
> second interrupt source for platforms where it is available. This patch
> has been tested using the lwIP stack with a Xilinx-supplied driver from
> their embeddedsw repository.
> 
> Signed-off-by: Kinsey Moore <kinsey.moore@oarcorp.com>
> ---
>   hw/arm/xlnx-versal.c         | 12 +++++++++++-
>   hw/arm/xlnx-zynqmp.c         | 11 ++++++++++-
>   include/hw/arm/xlnx-versal.h |  1 +
>   include/hw/arm/xlnx-zynqmp.h |  1 +
>   4 files changed, 23 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


