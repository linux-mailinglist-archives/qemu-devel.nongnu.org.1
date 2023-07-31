Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85995769C84
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:31:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVnK-0007kJ-J6; Mon, 31 Jul 2023 12:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQVmt-0007b0-03
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:30:27 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQVmk-0000Ta-RF
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:30:20 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-686bc261111so3344188b3a.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690821017; x=1691425817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B3UhabbQhX1k+qo55fEhKGmYzKBzaUjJnaU5yev56e0=;
 b=lZpfAda313yb6q79CU+6/6I6WuMWGFvfKRxJ33VF20S1mxjtR4JExyttMH9ZqM8yeO
 VfTWBHboifFzjjIXV9Wj0ya6p7P9ymhNm12aH/Zjfw9NWgyZjVeHYLTrlTFRr0L2uBgt
 0YVCWm/Joa0m3EWDr8ayaVRJOWVXDUKwxEFbrI+xoKPqYbaaDYwHjYAB61VJA1GWh69b
 u8umKucRfSXT/r85k3DB4Uouo9azwK/HD9BgIxDZabbWPkUyp+K3xvaD82Brzbcj4OvN
 /rUufuUeGaPbRCay2VqEDHvPhd9qIRx7lXyJuKuDQwN7o36zAXNW/nv5SWGKd5nTN0mW
 1a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690821017; x=1691425817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B3UhabbQhX1k+qo55fEhKGmYzKBzaUjJnaU5yev56e0=;
 b=FmREjFo4qM32o9egQuVF+9hfSLdsuwXwXlmM2mTD/fCbpynQz3GvvmuP5O8Y6zwOGt
 nuCRqI49Aqjt+DmUpyVrrFGkLmRPgfYCTl+sHQHnflmj3xnb43Z6S/CgNfcWBr7GIGn/
 HKkGtoDjGj3ztrw5upfyT3/mvSuJv50krQdd+Rx0//WaQ+nJ8DtXAeR9rXEHk0waIuKR
 0Gch9BVb42AbgQLQ2QTPAjwjCB4Gxul6Vl+OkNeDUndkMCd3Ib9wIeUNOECH9DVZ2avv
 uoLueLEgP9rNkDFQdHg9drkWaIS6QbYYJAA6a7L78dzn5wRFhmrnlwLFv3DcykmFWAzO
 MUSw==
X-Gm-Message-State: ABy/qLYs1KCgzDBXLxT9W9ZveJDO/52p3pSiJNTMoGA7BMsl659pcx3H
 4yasIbi2phhHWd+zOhrNkkCAQg==
X-Google-Smtp-Source: APBJJlH58WYU/dZGMz93zpXmjdZydH7uGEASq3ziAO3/nJBj3LaCv3md8GKGljZHSzB4ipT5X7VHFA==
X-Received: by 2002:a05:6a20:324e:b0:13d:bf07:7444 with SMTP id
 hm14-20020a056a20324e00b0013dbf077444mr3296237pzc.0.1690821017495; 
 Mon, 31 Jul 2023 09:30:17 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:4f6f:6b:2de4:e0cb?
 ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a62ab0c000000b00682bec0b680sm7747848pff.89.2023.07.31.09.30.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 09:30:16 -0700 (PDT)
Message-ID: <998a1cd0-036a-f6c3-5b21-3526da4c5709@linaro.org>
Date: Mon, 31 Jul 2023 09:26:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/1] hw/nvme fixes
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <k.jensen@samsung.com>
References: <20230730192941.44019-3-its@irrelevant.dk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230730192941.44019-3-its@irrelevant.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/30/23 12:29, Klaus Jensen wrote:
> From: Klaus Jensen<k.jensen@samsung.com>
> 
> Hi,
> 
> This should also fix coverity cid 1518067 and 1518066.
> 
> The following changes since commit ccb86f079a9e4d94918086a9df18c1844347aff8:
> 
>    Merge tag 'pull-nbd-2023-07-28' ofhttps://repo.or.cz/qemu/ericb  into staging (2023-07-28 09:56:57 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/birkelund/qemu.git  tags/nvme-next-pull-request
> 
> for you to fetch changes up to c1e244b6552efdff5612a33c6630aaf95964eaf5:
> 
>    hw/nvme: use stl/ldl pci dma api (2023-07-30 20:09:54 +0200)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


