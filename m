Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0579737BE9
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 09:13:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBs0c-0003AN-M7; Wed, 21 Jun 2023 03:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qBs0M-000397-FS
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:11:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qBs0J-0008PD-KG
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:11:49 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31114b46d62so5773858f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 00:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687331505; x=1689923505;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=J66YUyuz5YVnIrEEDl63DOF5S4RDKmE4Em6U8xJEI60=;
 b=BfRSqrztGxyQmBMQccRcZSwgqDIxDX9Y/M7X8N7kIjEV81XO0wBSLEtUq0kdCum8vw
 H2SuFiPRjOdG22CLInFTqYQA5becmyNfy4sC5x9w0XNrnxV2wmTqzaaJMAlu+CTYWidZ
 M9ZyM60NPaYXCq8qayyw3yNotNDUjf7zl0eRW/kGX+4XULnUM2Z3SXccVoPJ9g0m7QB2
 DJQi12gY6rf2gOU6g7ByhctDpGJDCaaPyNeZqHh/s7T2/I35mrkFulpvgN3899DoqUbK
 AwuHz/0YhNDjQFSe1UxfGj0uesKwu1ADws/FZnA7fdsN0fTZ9d3rPxWnCrsPcvGnCeMn
 U0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687331505; x=1689923505;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J66YUyuz5YVnIrEEDl63DOF5S4RDKmE4Em6U8xJEI60=;
 b=NgxhAJ/GjSsM6aqM9RFID9Hl+rGYivBHKrjU/A4w5oNNu3cMc/gkZsnlw8u5KFYnaz
 gmX7tyyvY0URMA4B6m8VGyUFCr88WOUpwktPTdnHGGUuus8rQVgwWRemqVuJq1KM7sU6
 7QhzM7otwiQrTQ5qiIy+7+99YY6dK8snS4dLAdt6hGKgPY+7WIBAhKypI9PjOLube8ej
 RyqHwzRAxb2jUDfDnN0sUdS5k1Ph0ahsNSc6ksGu7lT6ab2ZEiawYJNvEORHgeuXYNqj
 IiQ6Ty0jEFXhYXU6clqa5rImEy/eE0Qrr0defZA2JB9xiUSq4D0NygoE8SbAL/6ruU/h
 d2VQ==
X-Gm-Message-State: AC+VfDzFtA55LbDYuz21hrFXmk9Jt62/xtcNu61fzmh2SEtRnZqIdKwx
 izXgrQqDvaqpmoB7jQ9AZFEwhA==
X-Google-Smtp-Source: ACHHUZ4xOrwI0ZaFEf8pdSEKYw2ZjztWfoesIJ/Mnqv8mT2K/Q7Zc5nrsVaZgq5cOf8HhtI2BJSveQ==
X-Received: by 2002:a5d:6810:0:b0:30f:d1e3:22b7 with SMTP id
 w16-20020a5d6810000000b0030fd1e322b7mr14493459wru.6.1687331505461; 
 Wed, 21 Jun 2023 00:11:45 -0700 (PDT)
Received: from [192.168.200.206] (83.21.150.32.ipv4.supernova.orange.pl.
 [83.21.150.32]) by smtp.gmail.com with ESMTPSA id
 o10-20020a5d58ca000000b003111fd2e33dsm3653113wrf.30.2023.06.21.00.11.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 00:11:45 -0700 (PDT)
Message-ID: <9c29ce0f-1799-7ad5-18ca-457824e9178f@linaro.org>
Date: Wed, 21 Jun 2023 09:11:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Content-Language: pl-PL, en-GB, en-HK
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 quic_llindhol <quic_llindhol@quicinc.com>,
 "peter.maydell" <peter.maydell@linaro.org>
Cc: rad <rad@semihalf.com>, pbonzini <pbonzini@redhat.com>,
 chenbaozi <chenbaozi@phytium.com.cn>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20230607023314.192439-1-wangyuquan1236@phytium.com.cn>
 <20230607023314.192439-2-wangyuquan1236@phytium.com.cn>
 <CAFEAcA-B6Pbc2KyTVP9hheGfEecfTbwu-zi7_9EmjJH5opbiYg@mail.gmail.com>
 <f1e8edcc-14ed-0e97-0172-292032e61f1d@quicinc.com>
 <2023062111461132026159@phytium.com.cn>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <2023062111461132026159@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-wr1-x42d.google.com
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

W dniu 21.06.2023 o 05:46, Yuquan Wang pisze:
> On 2023-06-21 01:24, Leif wrote:

> > > Leif, do you think we should bump the minor version here?
> > I think that makes sense, yes.

> There is a new confusion: Which minor version should I bump to (2 or 3) ?
> As I found that Marcin’s latest patch (add ITS support in SBSA GIC
> <https://lists.nongnu.org/archive/html/qemu-arm/2023-06/msg00709.html> )
> increased the minor version to 2.

Please bump platform version to 0.3 one. ITS being 0.2 is already in our 
plans. Not that numbers matter for those components which are provided 
via DeviceTree.


