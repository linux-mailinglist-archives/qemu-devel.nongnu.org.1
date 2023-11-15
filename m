Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 847E47EBAC3
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:01:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34HN-0003Ie-RT; Tue, 14 Nov 2023 20:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34HK-0003GC-IJ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:01:14 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34HI-0005NO-Rw
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:01:14 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6c10f098a27so5024714b3a.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700010069; x=1700614869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jnbc3C/4milNJmZ9IrjzWMed2qYeAUSFQhPEWjwTNhQ=;
 b=WmKyToPP1Dc12EpMofD/hguaMJFJMNrmYwIfXV4ttv6ZVYkdUr7kugDw617n/yOpFN
 DZ4DLO9WN1WxdhIkPekMc8xTEiM5CKzORaaVjVVafq1dPNJ64ISO2jq4GuQ+W1EuOGHX
 qPWKd2Sk0B8TxFxP7ezc7g8Po/prKU1VGz76cBzG4UtSPn+uId71uFkjoJuUPLzsLwM6
 sxDz3FbHF4dIvZ1ZfrDRIm8AAT/XsC7yy7vSFCN5k9loZOKnZiccx/H/4Eap2wlXZLUK
 naO45EvCdfi2u2/pkR1RSslBnq+dmjmhAr25mi74ltfuVvV+OQDJMLOp7ZbWDZyN4S73
 2Fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700010069; x=1700614869;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jnbc3C/4milNJmZ9IrjzWMed2qYeAUSFQhPEWjwTNhQ=;
 b=HKX/wL3gWq407ue9Gp/Th1b+4iqCOt0dTKl9ChN0ASbl8W7FYYHL8jwpGUhpAvIp3F
 KehDDx4ia9CAvfoi5U2Y2cB5ixhtz2NXphoNaKxKRjK8KHmddTwF0zYb8eJ6OYZKt1nx
 2gGi20ffeaVmKjI8WWFS3DtIXf3e3C+owMcrvq/+Vk39NGEaa+vBWdTQ8kSQXAbCZZgT
 vPJSiMUThM6umRDs0JX3xKB2xm2f//FLwJPqf2EqrNPKtl+pXK/jm4cdAgI5d9wbPqXI
 6iB4ARp9L3QCf+UV47q2gV1d5rte0RhPCE0Jey4h+hjcuk19zemejPc/dRg/sfQmDPF8
 Fs3w==
X-Gm-Message-State: AOJu0Yw208yJrlHZknolqdmKMl6eyL1LU1WKmnMxvntfW1wgwdi082ZO
 tRmJc6nYHwJHC+hGK6sUXrTlYQ==
X-Google-Smtp-Source: AGHT+IHOKWdvCqIXu71hUvo4KKpn1MXhzcJCTFLhjEU7DX2zsfnAprwrXeqKh1AEEeNtotnvUcq4EQ==
X-Received: by 2002:a05:6a20:440d:b0:186:487b:5443 with SMTP id
 ce13-20020a056a20440d00b00186487b5443mr9433500pzb.1.1700010069319; 
 Tue, 14 Nov 2023 17:01:09 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a056a00198900b006be0b0fc83asm1748118pfl.125.2023.11.14.17.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:01:08 -0800 (PST)
Message-ID: <3d53d20e-64b0-477f-aa02-8880c3bfdffc@linaro.org>
Date: Tue, 14 Nov 2023 17:01:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/31] target/m68k: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-15-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-15-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/14/23 15:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-m68k -cpu ?
> cfv4e
> m5206
> m5208
> m68000
> m68010
> m68020
> m68030
> m68040
> m68060
> any
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-m68k -cpu ?
> Available CPUs:
>    any
>    cfv4e
>    m5206
>    m5208
>    m68000
>    m68010
>    m68020
>    m68030
>    m68040
>    m68060
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/m68k/cpu.h    |  4 ----
>   target/m68k/helper.c | 40 ----------------------------------------
>   2 files changed, 44 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

