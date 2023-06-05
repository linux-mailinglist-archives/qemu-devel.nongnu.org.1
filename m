Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C2372266B
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:54:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69ii-0006Dv-0i; Mon, 05 Jun 2023 08:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69iW-0006CR-KZ
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:53:49 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69iQ-0006jM-TX
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:53:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f60e536250so42219445e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969621; x=1688561621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Iljg6MtwO4tWaBYYrFcFDtYtjMh0o9de02ESdYW8RJw=;
 b=IE6xwGa8qodqCKte+2vKfdU9N4XzDIuFF1/ZL8cFdEMrWwTZmi10mMcBA2NgoAgn69
 GjA3Rg+JYvLuNU5AqvGZmhNEHn0IdSHbEpIdgqanM87Ph9h74bvwE3DRj/o90XZBzZHR
 CiGuss39lBKzmawpfFvEm2rswXAnAB8Zg6C+3lcNDK2SdjQ6iQG6yA2yegdbQMT5oVDU
 1cFS4pbo20o492IyPY4BSo4hgSyUB4ojTrnvbkRoXXWMXcYJitgQYb/c4IF7RQQWbv4R
 ovBta0z4UXnm1kgauAAOmoGg39jgoUxlmknwaq4VL8BCEy4IaAqM7Psq0FueqsGlvtO6
 DdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969621; x=1688561621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iljg6MtwO4tWaBYYrFcFDtYtjMh0o9de02ESdYW8RJw=;
 b=j57eayRsVIclc4A3M8gNHjwTKPN3GSYS6dF0dUrib2K71LMUrTGLZ2TdV5o61Hewck
 +wrkyJWAagDkFf755LuzAsvvqll39vxH83VJhGAWBTEa2tFIIOA3BTydi0qh0injFpt7
 72v4KG8WYuC36ltQhG1rBJFQR9J4yld9wEjZFDpAwdiG53yJXsPGnNqTXyKApXkxFydR
 Ipfji1IaheK3uAhgJinvl/axclpAFK7JPOkkvc+0zc64L+OsHYM7OxWQsFXMFTiAEP/o
 j0htP+JceEz0JiN0+6mJ0CaJj9Uz1xOhTtcZW8MIsg8ldbk6xqqNskKs33K0BDfJZdA4
 exKg==
X-Gm-Message-State: AC+VfDx4Vl8Oii5WE7XqywG1UmPjvZ1ArQG0vrck4huKKTF+6FC6OsR1
 qET0aqUNC6bk2vqlUG/KdqVNepWqI8mzwnE1RNo=
X-Google-Smtp-Source: ACHHUZ664IspSxe+TsIWxny7m/iyq2ZhgX2b0PXrGQZc2CNvDxHZN8WxIEWSFtUd5U3tTvpawAAMSg==
X-Received: by 2002:a7b:ca55:0:b0:3f7:408c:ad39 with SMTP id
 m21-20020a7bca55000000b003f7408cad39mr2956221wml.14.1685969621401; 
 Mon, 05 Jun 2023 05:53:41 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c220a00b003f42a75ac2asm10754851wml.23.2023.06.05.05.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:53:41 -0700 (PDT)
Message-ID: <ad00155f-4ed2-6d3c-5e6e-708daeac5ec7@linaro.org>
Date: Mon, 5 Jun 2023 14:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 05/15] linux-user: Use abi_ullong not uint64_t in
 syscall_defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
 <20230603222355.1379711-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603222355.1379711-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 4/6/23 00:23, Richard Henderson wrote:
> Be careful not to change linux_dirent64, which is a host structure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall_defs.h | 72 +++++++++++++++++++--------------------
>   1 file changed, 36 insertions(+), 36 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


