Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E146881E737
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 13:04:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI69c-000627-2V; Tue, 26 Dec 2023 07:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI69Z-00061z-ST
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 07:03:21 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI69Y-0001nA-9H
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 07:03:21 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3368ac0f74dso3742641f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 04:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703592198; x=1704196998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kl3GByFFf29gYOlDXosMxxGu0pftHoCsExPtPugb0dk=;
 b=o4d3t1xQ+70NyDFJR+c4I+MroFGZ4A3DjFW9UnREp3qSu9wx7HoJmNnlaPIe/uXjYX
 SDiZEAlDk2GPRj1NCwcljqGgoxjf8ELDnKFC33aSAIoZLoqzqezpMejJU0Azmxoaeg9o
 4rdjwN2YKR6RMVcY8gS1BznTq0dMX3H7UhPiNqoEDuk8BrZ/PBWoF+X4SYSXe0DxSFDm
 LQ8Zdm2EB5nl2hWil0gexPUHPwGapHnYe9Zpz4pxd4rjlq+Q0vti76BQm312RpSy9j+C
 qxqYqKPIqXIeTUF5geylSOUZq4vzGBW4ABxG0zAeImTp5Vzi0ShSGztEpA/3iKoxvLnL
 1fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703592198; x=1704196998;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kl3GByFFf29gYOlDXosMxxGu0pftHoCsExPtPugb0dk=;
 b=fArq2ID+pVIwFjccD/RZ71y6vuc/a/8Dl8PtZFjgifkuEZ604seKuQB8AdigZQJEFG
 j4nr57qbn/vIqtf0Dx/17PQQrms0pO/c7jhLn2GF9u+ufga+SqBP60IynL4Nbz8tsnlC
 gAG0veENmqtiEq1Zr6UYuQcTjn7HlGuPyE3m4CkKPZMkNIc+R9deHmNJiz7uBApYi0wW
 QJO91NXRiy8Li1NK6BC44orFkeBbyhaohAwO4+bdqDtn3E+49E01ot74P1XTN1aeStw/
 GAO6+nZ5l20enUEhX6AnrODR2bzwz+IWdKRaKEAVP9ejW8ecfMAjrtbiFCdsKG7tAfsC
 Zd0A==
X-Gm-Message-State: AOJu0Yz0ZF9SlKKFWtgUqn3IZe6oGe16ouxnw5kRaTboqJ+r/xuSmV/1
 C4JNV6Mzlq9S7NwLU/+zuKkM+z1QuPTHa2iEJ0ahQxhiroI=
X-Google-Smtp-Source: AGHT+IHIGoaxaUnUAEETAorMHF1HUEhBpqxFflJfiSJMpAx0qd8kxIry74uETeXzf48o3dTGuOtiLA==
X-Received: by 2002:a5d:668b:0:b0:336:92c8:3dcc with SMTP id
 l11-20020a5d668b000000b0033692c83dccmr3027782wru.21.1703592198401; 
 Tue, 26 Dec 2023 04:03:18 -0800 (PST)
Received: from [192.168.96.175] (137.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.137]) by smtp.gmail.com with ESMTPSA id
 w18-20020adfee52000000b0033657376b62sm12443482wro.105.2023.12.26.04.03.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Dec 2023 04:03:18 -0800 (PST)
Message-ID: <0a9f5a65-5747-4575-a5a9-aa209799e096@linaro.org>
Date: Tue, 26 Dec 2023 13:03:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] load_elf: fix iterator type in glue
Content-Language: en-US
To: Anastasia Belova <abelova@astralinux.ru>, qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org
References: <20231221080858.12876-1-abelova@astralinux.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221080858.12876-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi,

On 21/12/23 09:08, Anastasia Belova wrote:
> file_size is uint32_t, so j < file_size should be
> uint32_t too.

file_size is of elf_word type, which is either uint32_t
or uint64_t.

Your explanation is not very clear... Maybe you want an unsigned type?
In that case, does the following makes your sanitizer happier?

-- >8 --
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 0a5c258fe6..03eba78c6e 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -502,4 +502,3 @@ static ssize_t glue(load_elf, SZ)(const char *name, 
int fd,
              if (data_swab) {
-                int j;
-                for (j = 0; j < file_size; j += (1 << data_swab)) {
+                for (unsigned j = 0; j < file_size; j += (1 << 
data_swab)) {
                      uint8_t *dp = data + j;
---

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 7ef295ea5b ("loader: Add data swap option to load-elf")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>   include/hw/elf_ops.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index 0a5c258fe6..1defccaa71 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -500,7 +500,7 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
>               }
>   
>               if (data_swab) {
> -                int j;
> +                uint32_t j;
>                   for (j = 0; j < file_size; j += (1 << data_swab)) {
>                       uint8_t *dp = data + j;
>                       switch (data_swab) {


