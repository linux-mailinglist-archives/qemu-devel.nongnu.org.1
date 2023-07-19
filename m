Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D16A27594AA
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 13:53:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM5k6-0002sy-PP; Wed, 19 Jul 2023 07:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM5k2-0002l4-VR
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 07:53:14 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM5k1-0003AH-GW
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 07:53:14 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3142a9ff6d8so6771719f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 04:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689767592; x=1692359592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cTu3uGpdzxMYi2RkDkymm3NtpBgrMEUY7IY+H20CgEk=;
 b=bIpW4mtWKx7Hziya6JLMbMV9cKnkszK5SDAFTnQkKjr4K4NBFPdca49RdHznIuFtRl
 kcV7E/qOMKEmz0Rv9pdQsS5CN1OcOC1X9V7PInJFtbrS0R1cBJih0XeC9Xxppd3H/9+v
 vIE1xbkOSoIVWWMBpDbNScam19eraBD3W0YId32y6OSlmISK315YMy9UW43zdEmpaP85
 DPCokf/GtjlzepLAcg0Tg5L0D8gdzy628XPzykz8zgU2RgLO2pQLhJN7xpfp8JHpqEgt
 x+v72Qloa1YdxKMZuFdPgCXbDUk0PEwgUybMg1tQL61rfsUEKIMgHihDxXxJxyUi/D0H
 pdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689767592; x=1692359592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cTu3uGpdzxMYi2RkDkymm3NtpBgrMEUY7IY+H20CgEk=;
 b=QKc4BC+7uApNyZaN6sMOXAXYqih2ZR5Mpd9ECbvMjm72O6bALrr2KgUn3znO3DRWub
 9MmOCTfmn8epInjddZkzHtBV6oZh8l5H69Mz9pYluZSxSnmuSQw6trEkUsi8swNnXpf2
 v95HLljPpNvLzJkhx7hOxsiMwo+S/+92pkDvUr3qOg3Nwc3QiEClDGRGyrXUV87OHRzj
 KY4YKSSI35R2jAzOXzckih/RQ032xnNQC4lq2h8HnxWY8S6oudrCWDs6Qn5pB1AwBpAN
 /BQI8UuKSeFXv7sAUdvuwSsk8olI52THlsqVXvyeoJiaW4qVfTHh90Csp33cjVO5eZXo
 Q5ew==
X-Gm-Message-State: ABy/qLapZv7GcR5Z2rrlej+/Z2tPMgWB7Y9MpM7V0z3MI2r5lmM22vqn
 05avv6lyghrJeDWp+dqsnyAIHg==
X-Google-Smtp-Source: APBJJlGzdU6u1A/FtDDqTW3aU0q+hvvQOiAD1X7GEF2MVKNFLHRKpduiZoC3AR6NxVKUZFM7WHdCQw==
X-Received: by 2002:a5d:4449:0:b0:314:13e2:2f6c with SMTP id
 x9-20020a5d4449000000b0031413e22f6cmr1994058wrr.58.1689767592001; 
 Wed, 19 Jul 2023 04:53:12 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.201.220])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a5d51ca000000b00314398e4dd4sm5124898wrv.54.2023.07.19.04.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 04:53:11 -0700 (PDT)
Message-ID: <d43157b4-7f09-8071-d38c-b4c5dc611859@linaro.org>
Date: Wed, 19 Jul 2023 13:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 7/8] hw/ide/ahci: fix ahci_write_fis_sdb()
Content-Language: en-US
To: Niklas Cassel <nks@flawful.org>, John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
References: <20230609140844.202795-1-nks@flawful.org>
 <20230609140844.202795-8-nks@flawful.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609140844.202795-8-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> When there is an error, we need to raise a TFES error irq, see AHCI 1.3.1,
> 5.3.13.1 SDB:Entry.
> 
> If ERR_STAT is set, we jump to state ERR:FatalTaskfile, which will raise
> a TFES IRQ unconditionally, regardless if the I bit is set in the FIS or
> not.
> 
> Thus, we should never raise a normal IRQ after having sent an error IRQ.
> 
> It is valid to signal successfully completed commands as finished in the
> same SDB FIS that generates the error IRQ. The important thing is that
> commands that did not complete successfully (e.g. commands that were
> aborted, do not get the finished bit set).
> 
> Before this commit, there was never a TFES IRQ raised on NCQ error.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>   hw/ide/ahci.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


