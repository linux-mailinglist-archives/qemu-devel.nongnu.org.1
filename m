Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6E7759490
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 13:45:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM5bC-0007Sz-P7; Wed, 19 Jul 2023 07:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM5b7-0007Rb-8J
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 07:44:03 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM5b3-00079z-DV
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 07:44:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31297125334so468569f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689767035; x=1692359035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RVB0pvAN5vdtoP2giPv9r7me79eOAmONKWvmiY0mMJM=;
 b=H8eYlrDM8qoEBT2oHuezZuNY96pOENyaCZbt2EFL8Ge77BAO30UKKs3fC4SXPn6HLe
 xZOqh7wgz1dq0NDW3spF5Hdq7+Gq4q26fPyPzYQ+poTRUv9U2QmpiUZTjlpc6z07Lpxl
 SAktsU1Mu0BMmJ9USr8zImvoIJmNvyUytnUyDQQvpB78p0wgGazRVve/CwehXB9sjSUl
 pIe81SyJblrKFLxSzS/Auel5p1m+jb/YjzV8wpTEACWbYKsoRu+1IN2zoiFL9n57UT9t
 hvecqfOyXeHjYHUIVbi+AndPvRbX2LkP77dSomKkC7SEQmBM/aPrMIFxrsC1T/j5dUi/
 kkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689767035; x=1692359035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RVB0pvAN5vdtoP2giPv9r7me79eOAmONKWvmiY0mMJM=;
 b=hnZj4HEhLZnmjzNaT71CxXVxV2WUcZCnZLg3zlLK4Dm3yci6DZtOuTokeQLGHSEaN2
 5x/1hn6W/guWXjKU833PRNUDoGcTJXmohEXkhhza1QLG26vDgTfidDcz4+/VngAOPjrd
 Ob1lmPZJ7qatVp9hs54rgUbUrBUIEz55pxRcva2EB4CislGInKhdCNkwq0kiwA7AY/1v
 iQupKXMK4/FKaFnd4AMObnOsC7T4Gy4skFqIBtSEzsSorOh8jUksxfTCIGjDeF+rJXTD
 GZ5YhnFjwmlCAxpmS49ChZ1A6xMY0DvoA8G1+aMrM2egAl8f8FfrI2KFeVXn+56YFsR2
 fVWA==
X-Gm-Message-State: ABy/qLZzRIsIDRRdm4/H7cM8xZfx3kyideywa5e/gvV6R4Yh54IcDQDB
 CEZdo7s+w5V7SA/HJOVgoEUo+w==
X-Google-Smtp-Source: APBJJlHh7/UNryd8AXcREbSgGdhwbqFXLOjZhkR8Q5/vx/564id7S+AqHZ37dSHbXLdDMA+6i9bHAg==
X-Received: by 2002:adf:dd0e:0:b0:313:ee8b:8489 with SMTP id
 a14-20020adfdd0e000000b00313ee8b8489mr1701993wrm.10.1689767035427; 
 Wed, 19 Jul 2023 04:43:55 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.201.220])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a056000120d00b00316eb7770b8sm5170348wrx.5.2023.07.19.04.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 04:43:55 -0700 (PDT)
Message-ID: <7823960a-b1bf-071d-1452-586f6f0e9c84@linaro.org>
Date: Wed, 19 Jul 2023 13:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/8] hw/ide/core: set ERR_STAT in unsupported command
 completion
Content-Language: en-US
To: Niklas Cassel <nks@flawful.org>, John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
References: <20230609140844.202795-1-nks@flawful.org>
 <20230609140844.202795-3-nks@flawful.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609140844.202795-3-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 9/6/23 16:08, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Currently, the first time sending an unsupported command
> (e.g. READ LOG DMA EXT) will not have ERR_STAT set in the completion.
> Sending the unsupported command again, will correctly have ERR_STAT set.
> 
> When ide_cmd_permitted() returns false, it calls ide_abort_command().
> ide_abort_command() first calls ide_transfer_stop(), which will call
> ide_transfer_halt() and ide_cmd_done(), after that ide_abort_command()
> sets ERR_STAT in status.
> 
> ide_cmd_done() for AHCI will call ahci_write_fis_d2h() which writes the
> current status in the FIS, and raises an IRQ. (The status here will not
> have ERR_STAT set!).
> 
> Thus, we cannot call ide_transfer_stop() before setting ERR_STAT, as
> ide_transfer_stop() will result in the FIS being written and an IRQ
> being raised.
> 
> The reason why it works the second time, is that ERR_STAT will still
> be set from the previous command, so when writing the FIS, the
> completion will correctly have ERR_STAT set.
> 
> Set ERR_STAT before writing the FIS (calling cmd_done), so that we will
> raise an error IRQ correctly when receiving an unsupported command.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>   hw/ide/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


