Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD787799EF
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 23:51:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUa1o-0005Xq-9m; Fri, 11 Aug 2023 17:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUa1l-0005XX-C2
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:50:37 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUa1j-000444-Gh
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:50:37 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2680182bc21so1426421a91.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691790634; x=1692395434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FEXZw0l5vQCgB0OV7BlglBafnxpaMwdlJfHKVlEvtrg=;
 b=nXLl5L0bs+z/pNcRZ18mhtN4LRGsvzxmWBVHg0/KyTbATG78yyIwkUPJcSVwVsAsfM
 yR+gdDBdXtns4FgOmmTEMQD4h5uKTFLbaijdz+m6pgbckhuljkQw+9ra3JnE22MYcrqW
 DAdQl1+dlHrHI7Voz7dVaVlvf2M90nHApjNU+LkcOPxW1F1lUFMSm8LZqcCJfyd9zu+o
 dnm+HoLJ+/I0KFlDcnGHYaroG8hPfruUIo/CPDCOl99IZ01YY5iq4zPoFtb8aIKcxPJt
 FDr2amqWPuynBeokjtBim0IVoyY++ARzEz+hWIiy+ubiBGIIom0wCaLe0KjOoV7JWyOt
 OINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691790634; x=1692395434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FEXZw0l5vQCgB0OV7BlglBafnxpaMwdlJfHKVlEvtrg=;
 b=jGXAEX2rQ7Yht1tUK2HxVT5JCFYPHR7CFtfKYsxUadwBmnDmtUK1hrU60FZYHSL/GV
 hpNMwHhP+KaAnJ6+g2IwiO7s00qa5tZZyPNCnbfbZbpbS0yVt8pzhf3ghCzwyzuG8aBG
 IS8sQPzmbTS9ctrixQ8WeteheEJup+aKaKsqZztgUyo5RAx++bosslCgmtVBNzbGwWi8
 k3NRoOVYghiPLxeFiL0JpTVmNgPxic5qWkCbXvDnIdKeUSeYaE3+ZNhyt9+8dk7Rm4LF
 Ignj/tBk6eL8RBKywKGqZ6HHadCJgYrNuo1Ag/gj0c6Ju+aih24LdiIUOabXJWXLdsYs
 aAPA==
X-Gm-Message-State: AOJu0Yzepyk+X9FSCm54ISus9ntcS+9mnkkB9Xda1MasMSdpCx+LhG1k
 cQU3g7m4MZmW+zhl+1N6HKc+mvZhVdaOW9/ydyc=
X-Google-Smtp-Source: AGHT+IFRA6dOKY6A/tT8T+bXhciYL9/IiY/Z0F2c3hqBwF4j6LZLppEedE5Sqo4YhP248Z0IQP52UQ==
X-Received: by 2002:a17:90b:4d8e:b0:263:fbe5:2125 with SMTP id
 oj14-20020a17090b4d8e00b00263fbe52125mr2231382pjb.15.1691790634108; 
 Fri, 11 Aug 2023 14:50:34 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:e773:351d:2db2:8a8a?
 ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm4054620pjj.8.2023.08.11.14.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 14:50:33 -0700 (PDT)
Message-ID: <f3cae6c8-f598-f926-8863-c421e8fffb01@linaro.org>
Date: Fri, 11 Aug 2023 14:50:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/2] pci: last minute bugfixes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
References: <cover.1691770630.git.mst@redhat.com>
 <CAFEAcA8sKYYfo_OazF_fftUwnU0viaTxk9tyn=TUrChMxaLgGg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8sKYYfo_OazF_fftUwnU0viaTxk9tyn=TUrChMxaLgGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 8/11/23 10:41, Peter Maydell wrote:
> On Fri, 11 Aug 2023 at 17:18, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> The following changes since commit 15b11a1da6a4b7c6b8bb37883f52b544dee2b8fd:
>>
>>    cryptodev: Handle unexpected request to avoid crash (2023-08-03 16:16:17 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>
>> for you to fetch changes up to 0f936247e8ed0ab5fb7e75827dd8c8f73d5ef4b5:
>>
>>    pci: Fix the update of interrupt disable bit in PCI_COMMAND register (2023-08-11 12:15:24 -0400)
>>
>> ----------------------------------------------------------------
>> pci: last minute bugfixes
>>
>> two fixes that seem very safe and important enough to sneak
>> in before the release.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> ----------------------------------------------------------------
>> Guoyi Tu (1):
>>        pci: Fix the update of interrupt disable bit in PCI_COMMAND register
>>
>> Jason Chien (1):
>>        hw/pci-host: Allow extended config space access for Designware PCIe host
> 
> Could you respin to get rid of the malformed Signed-off-by
> line in patch 1 which has an HTML mailto link in it, please?

Oops.  I lost my train of thought over the course of the day.
I mean to not push the pr to master and wait for v2, but then
I forgot and did it anyway hours later.

Sorry about that.

r~

