Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3112D7E5339
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:22:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fhY-0003Yz-PM; Wed, 08 Nov 2023 05:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fhW-0003YW-9I
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:22:22 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fhU-0006wV-BT
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:22:22 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40850b244beso50339915e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699438939; x=1700043739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bqWnjIdbDU8HRmJm4DZp+Rs6jortlThe+Czrm21OCWs=;
 b=SLyy9iCq9A+w9eql3PQ9Xb0LwqoEAPRFDRpdHZNXCnT8mHd7WfSE+UMtBHFVQUO7XA
 bK3hHFWwZWx3uRPZuL/2R5eBKR4S55zFZvzxQgxnP+D6/+kXci5pMuisP6oMPc+YCCgd
 mzV5XJqZ6DK/g2Gb3g4ejT561qakaQJSW8AykzFIiFSvoxv2nMVMUfYWlDSiq5eNl40z
 SWxQR9cp0kfJzijULUdRg8v6yEkcXTcK3F4y5BXc1Csk+fpRYKP6YAOzlqRghBCfRW3/
 AdEb2/Uql4jfnoLigYFp2v7BRpzNmc4UzC+rWeo85T52JAF3vJGTrIsunPDnE9rOJg9r
 vDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699438939; x=1700043739;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bqWnjIdbDU8HRmJm4DZp+Rs6jortlThe+Czrm21OCWs=;
 b=lXSVAH5o1jWVGLrrNoW+XfmFPwEf8PvKUDSctEbKdVkRY+HDSQbaWbvXfuFz4Hy0qe
 VKXGRCj+a14+uDApDpmXVErRvlaE4rdh5cZX9CyXiILgplx4COAJpNA5R2As4iyNkwYQ
 wajU88VWe4v5kBw09qctX3i3rKQG7ICMUIYkVXDJMAeoFFKzKspHjY8+qVP9i+n+aByh
 eK5CGu6svwW1HR7Vsa9/yN7p47t8pgeByRwUtunhNnEkro3gFbMarV0e98hnt37rOEkt
 MgLGBhTUhCcBf3DBTou1tijZiU60ZLmR8uYo3X90sX32Ye5usoJJXWEsBAnLKUn/948X
 DkQw==
X-Gm-Message-State: AOJu0YzBoVSXTzUR+bNKLHL6wpzn713v4lyKA1rAqrj08R+HxOAuf8G5
 +Fz8mAIgALBwY+YNzBwCeQOTAA==
X-Google-Smtp-Source: AGHT+IHLBhDnf8qVaZztZq1d94GoMfnUvrPfFuYqsLIxP3Bfb4B6qfSVS43tG2WseuPKX9r3MGZQUA==
X-Received: by 2002:a05:600c:3b14:b0:406:53ab:a9af with SMTP id
 m20-20020a05600c3b1400b0040653aba9afmr1429320wms.10.1699438938799; 
 Wed, 08 Nov 2023 02:22:18 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 l2-20020a5d4bc2000000b0032da319a27asm4567897wrt.9.2023.11.08.02.22.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:22:18 -0800 (PST)
Message-ID: <5dacc2a2-d087-4f9a-a3b8-400f0539ae62@linaro.org>
Date: Wed, 8 Nov 2023 11:22:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] hmp: synchronize cpu state for lapic info
Content-Language: en-US
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, thuth@redhat.com, quintela@redhat.com,
 kkostiuk@redhat.com, berrange@redhat.com, dwmw@amazon.co.uk,
 pbonzini@redhat.com, joe.jin@oracle.com
References: <20231026211938.162815-1-dongli.zhang@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231026211938.162815-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 26/10/23 23:19, Dongli Zhang wrote:
> While the default "info lapic" always synchronizes cpu state ...
> 
> mon_get_cpu()
> -> mon_get_cpu_sync(mon, true)
>     -> cpu_synchronize_state(cpu)
>        -> ioctl KVM_GET_LAPIC (taking KVM as example)
> 
> ... the cpu state is not synchronized when the apic-id is available as
> argument.
> 
> The cpu state should be synchronized when apic-id is available. Otherwise
> the "info lapic <apic-id>" always returns stale data.
> 
> Reference:
> https://lore.kernel.org/all/20211028155457.967291-19-berrange@redhat.com/
> 
> Cc: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> Changed since v1:
>    - I sent out wrong patch version in v1
> Changed since v2:
>    - Add the Reviewed-by from Daniel and David
> 
>   target/i386/monitor.c | 5 +++++
>   1 file changed, 5 insertions(+)

Patch queued via my cpu/misc tree, thanks!

