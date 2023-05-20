Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFF670A4F5
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 05:36:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0DMV-0005Xr-Rx; Fri, 19 May 2023 23:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0DMT-0005Xe-Im
 for qemu-devel@nongnu.org; Fri, 19 May 2023 23:34:29 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0DMR-0004S2-AL
 for qemu-devel@nongnu.org; Fri, 19 May 2023 23:34:28 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d426e63baso681288b3a.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 20:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684553665; x=1687145665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Od08UhMq25QIsi7/cQ4Wcalbl37ZYXdHQAb1S1hTA0=;
 b=V72BfvwwHWpZ3Z00LlTcLXV2RzUwHr4BEE35XwQFrh8Pa1EI3B22jxMIlG7u8hoFPR
 KZvYd/alyo9y5T8+FB68yFg1YMdmQ22+mEeP1RnUDjVajO+y4j3/55Zo77XYH3HfCq2e
 dqOLwnrlt0s4sYiouV/h5IqrsF6RzFMRg4Lj/YwWX77O3IhdbMED4SldbDJ5weezIOyE
 3Vyzp52iMP0i4EPrq2yLxlF3kRef+T7cV+i0QdrguZzh4y2Y+FDBpQdD88eOeNoCH7E2
 E+xjJu44TC71rp0hIS7o/evWqPEB9z2brEck66TUaVz1aoYm2+t8VbOL/wAb2uia9jTT
 Z13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684553665; x=1687145665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Od08UhMq25QIsi7/cQ4Wcalbl37ZYXdHQAb1S1hTA0=;
 b=Gx4SsXaPQLdUo8KxphenKO+yWsTq4tHtQ18bzNs6asxBe0r6hQ45q1GHZaKMwa3j6i
 u+zBpwm4PKU/oOTbDXxbLcsprMWmx3eahOGDphFGiDBzqaICWE11FECRoPbWL6RlmWeD
 FpQPtTlUCyZrmb1qFlSfOjmM3am8+plTIPhznrA3GYcY4aJn6B60J1GS24t8a0Z+arQt
 WO8X7AuXmbitnyvxuhdteY/jcX0d+rhfVkHuXiU0q7aOi3yRaQpoJutIuBPdHvLeD3SO
 0B3EnZyOsu0+yNOyLgGVWykMKOr55AJFzk19Jm6HSc6GoraCT6m/EUCvjefKv314XmCO
 Ch5g==
X-Gm-Message-State: AC+VfDxBWDbmjm1D+4DyeuBa7JUyXKOmMfKwtviVsd8TsrWB2umOGpG8
 525HK24bNDHR5UHFqouvnWaITg==
X-Google-Smtp-Source: ACHHUZ6KKJWTDPZt1zG9aP3rHvopUsckG8pgdKrHPSyce2XlwA0gFp3F+7XBWF4JGGMCmhxWnHBbXg==
X-Received: by 2002:a05:6a00:2d90:b0:643:5d7a:a898 with SMTP id
 fb16-20020a056a002d9000b006435d7aa898mr6118766pfb.0.1684553665356; 
 Fri, 19 May 2023 20:34:25 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:686f:d1bb:8fc4:dc38?
 ([2602:ae:1598:4c01:686f:d1bb:8fc4:dc38])
 by smtp.gmail.com with ESMTPSA id
 a23-20020a62bd17000000b00649281e2f03sm364542pff.141.2023.05.19.20.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 20:34:24 -0700 (PDT)
Message-ID: <04aa362a-041a-fb18-7ffa-c75555c11ca9@linaro.org>
Date: Fri, 19 May 2023 20:34:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/40] virtio,pc,pci: fixes, features, cleanups
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1684507742.git.mst@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

On 5/19/23 07:49, Michael S. Tsirkin wrote:
> The following changes since commit 297e8182194e634baa0cbbfd96d2e09e2a0bcd40:
> 
>    accel/tcg: Fix append_mem_cb (2023-05-18 09:28:44 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
> 
> for you to fetch changes up to 87af48a49c0a5663b3fff58c3407393772d3c448:
> 
>    hw/i386/pc: No need for rtc_state to be an out-parameter (2023-05-19 10:30:46 -0400)
> 
> ----------------------------------------------------------------
> virtio,pc,pci: fixes, features, cleanups
> 
> CXL volatile memory support
> More memslots for vhost-user on x86 and ARM.
> vIOMMU support for vhost-vdpa
> pcie-to-pci bridge can now be compiled out
> MADT revision bumped to 3
> Fixes, cleanups all over the place.
> 
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


