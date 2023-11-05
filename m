Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B77E16A8
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:56:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzk9g-0006re-VH; Sun, 05 Nov 2023 15:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzk9a-0006qT-HG
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:55:30 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzk9Z-00010A-3P
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:55:30 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b565e35fedso2325146b6e.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699217727; x=1699822527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jCkAF8nL+PLgvYmFX+Y1KTHa+SLgfr34ZXoRtlEJC3A=;
 b=ilpVVrnAYgYEmxQ+3uuVXSxUuk1nMa8UBnCNkCUzehq/sZn07N4LgSf+eG4YrcpLv8
 DvjJjDbhi/OVT0/oiAiH4gb0vO7u9HFAMMRVngUroD8ts00EpMTa+PPg3upwSpw1vyh6
 eb+5B9Gqm/0Na3f2sUL/6SzA9VI/YWJoaCQp1w9fNUi27zcvP8CV5djPqPFGRUVqS7y3
 Hr0pxME/QTjp3iRUV5ttTdevr71TSAdsDN71JScOuUQi88FyHP0YPOHXAYLGXCnQlLYV
 r8f/n9i5ECH/BVIUBp09eT0OASRYkc4ab2OxtWIatzANV9r3j9ryBwZSPor4ujEPD7kN
 1i3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699217727; x=1699822527;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jCkAF8nL+PLgvYmFX+Y1KTHa+SLgfr34ZXoRtlEJC3A=;
 b=YEq5EvNWg5jiyg3Ehun3pqDZEPj9mIHkuxXlKuuJWbpsgcJrA6F6kCmLo4jgNzBmlQ
 zIoCH9nEYyogWgF4yP0vuI0NzBDIlQ92YlSjRKiIHmBy7wNwVi8hdP0iIHp2pCPohHYc
 sikevQ9A8hhAn1VusbBODH+U4OwZ4jVrRg42Of6ANZpfBZbLWbo8XSyaY9m9JtTPYYAO
 lXVyNRzzBF7wVlHhE7h0lAl/IrV27McWCJPsgYezN3RmZ4+fOs/lRUJkutbYQVMOg4jU
 V5Bgtq/NG/oSI+layDwQnILxOoww6wewxwvWQ2jTqREJjH2LliEdk4WKzqmTkskmrHgO
 yvLg==
X-Gm-Message-State: AOJu0YzwI8pqFPeUQQEQTu6f8YIfqQgJqxJDC/HnLUgGw9jZvtMJLe0Z
 ZWSWzFMPrV0cweVe97eWhsXDOg==
X-Google-Smtp-Source: AGHT+IHz/VZU8dMNlDpRHmg2gnItqzZIEd7Iab0+gQfikdmwzx7EsHIAu0ketwMKo+6NFhYw/+KdKA==
X-Received: by 2002:a05:6808:f15:b0:3b2:e519:192c with SMTP id
 m21-20020a0568080f1500b003b2e519192cmr33933586oiw.9.1699217727566; 
 Sun, 05 Nov 2023 12:55:27 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a056a00139100b006933866f49dsm4553887pfg.19.2023.11.05.12.55.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 12:55:27 -0800 (PST)
Message-ID: <936a0e12-f022-4d16-a21c-89e4b77f547f@linaro.org>
Date: Sun, 5 Nov 2023 12:55:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/29] default-configs: Add TARGET_XML_FILES definition
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
 <20231103195956.1998255-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231103195956.1998255-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

On 11/3/23 12:59, Alex Bennée wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> loongarch64-linux-user has references to XML files so include them.
> 
> Fixes: d32688ecdb ("default-configs: Add loongarch linux-user support")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-Id: <20231030054834.39145-6-akihiko.odaki@daynix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configs/targets/loongarch64-linux-user.mak | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/targets/loongarch64-linux-user.mak b/configs/targets/loongarch64-linux-user.mak
> index 7d1b964020..43b8a2160f 100644
> --- a/configs/targets/loongarch64-linux-user.mak
> +++ b/configs/targets/loongarch64-linux-user.mak
> @@ -1,3 +1,4 @@
>   # Default configuration for loongarch64-linux-user
>   TARGET_ARCH=loongarch64
>   TARGET_BASE_ARCH=loongarch
> +TARGET_XML_FILES=gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml


The qemu-loongarch64 binary emulates loongarch64 only, not loongarch32.  The inclusion of 
loongarch-base32.xml here is not relevant.

That said, we don't exclude TYPE_LOONGARCH32_CPU or -cpu la132 from CONFIG_USER_ONLY, 
which is a separate mistake.


r~

