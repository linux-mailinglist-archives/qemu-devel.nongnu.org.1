Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 847F77E7442
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 23:13:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1DH6-0006Zd-QY; Thu, 09 Nov 2023 17:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1DGv-0006NG-Im
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 17:13:10 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1DGn-0002bh-0p
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 17:13:09 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso2225512a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 14:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699567978; x=1700172778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7uGJpMvHLJeHMpAL9GVSyHWno/A/OzNvYmT52+RwsXQ=;
 b=jH3g4jSdBzzusyif1KA7AIQztFmaT3zgdJx2M5kDJuF8zeHcqzx+0Lkpu3uX6GQx6D
 FxfQgWarLe1LLtrEgeRAVl3IKdd4+w30KXASIPCGLev3V2RFA78Tu7MNchHisXMpnQZL
 K7uXzsCmt5GQkUUHJp3XvivVnaslg7bE0oHgICf44dn8g03PVhUVuSefHcp8jRKO0sM0
 qY6Vhz9RCkOlzCq8qW2Rz/nTzWIJOEapehqJ4vRal5CtncrYgpwxOOn9XqtWmQwVpHSw
 RTMqcRDsJtajYLCLhMDwNisSBTclRZ0ZPKtSl1W9ymIpzSo0qZUVd9HpcJ/mQFcqOqNy
 PP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699567978; x=1700172778;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7uGJpMvHLJeHMpAL9GVSyHWno/A/OzNvYmT52+RwsXQ=;
 b=V/60vVSrLhbmrwasFAKdQ6d/ugZjzyKVGV5JVRosUdKdxICC9c8oYXSP/PklzdJMcg
 47YnNl43+VvU3Dg8MlzoMCZaCVs9gqB8bPmlVQAobx8mNgBXJwBJDosD66ChQvXo8Qg7
 UM0deYEB8igzSzKLywMStY/Iq6ycgBNhOmSi7Cef69ObPBP4xItbMsVgJHYBQVMGQIuW
 +Ehf+5kAHPboch9Cm0VFvI/hNuY9Gn8ICuPYrVAncBfHp9Pag/2bmXtTxc5iPzfpFezi
 VhiDgULVgw/oC3hLLjBfs1DZTIN0TXDEXaU7UxGVldwCf17sdNCqBKgr5M2u66b90Mm0
 BS6A==
X-Gm-Message-State: AOJu0YyclxqfGK2tzfR75JwInTbd4UQNZumu0/KXQIo0187G6r572adg
 uYtI0NGheiQ+qQUyA95ZTLgPgA==
X-Google-Smtp-Source: AGHT+IEHWUBPhPWEwc9e8EMyCOfM2WpoMhHIF4qXSZSNzZ2DwGR+aX53lwWSj1N0+F9AT4IC/eAKpw==
X-Received: by 2002:a17:906:6a07:b0:9ae:50e3:7e40 with SMTP id
 qw7-20020a1709066a0700b009ae50e37e40mr6078360ejc.52.1699567978215; 
 Thu, 09 Nov 2023 14:12:58 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 fp2-20020a1709069e0200b009e5ded7d090sm289594ejc.97.2023.11.09.14.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 14:12:57 -0800 (PST)
Message-ID: <824cf3f4-4948-4a97-84ed-08d247cfef9d@linaro.org>
Date: Thu, 9 Nov 2023 23:12:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hv-balloon: avoid alloca() usage
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
References: <3b2253d199165648b958570d6c4db86d6ced139d.1699545634.git.maciej.szmigiero@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3b2253d199165648b958570d6c4db86d6ced139d.1699545634.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 9/11/23 17:02, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> alloca() is frowned upon, replace it with g_malloc0() + g_autofree.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/hyperv/hv-balloon.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


