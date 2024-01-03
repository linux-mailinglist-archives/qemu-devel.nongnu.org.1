Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C566823096
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 16:31:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL3D9-0001pD-5Z; Wed, 03 Jan 2024 10:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL3D7-0001ov-52
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 10:31:13 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL3D5-0001rb-Gi
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 10:31:12 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a2768b78a9eso103659366b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 07:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704295870; x=1704900670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ziOlqsIoT4l/tS6IUNKKfoa9E5fTN49T5ltMcZCw0oQ=;
 b=q4hOpVAcXqM3TbCxTU+baoqvk6u/GvjPtGGvfc76nDl3midAEo4eNUlBoG33apj20A
 Ra4QHRDNFAFPhwFGEw3g5pyeeWfa8X8oeXmyCDJlMjgYrI1D7OrcuchChhHXTXUgSkeA
 T7FHuuM3CHY4cRKo1IYJxX3dpx/HWSgwaC6B1tnm3OVfN+9djtP/dvXHVs0ssCXhsLTf
 L/556w9iaWNxP03s0dJUTwY7N6KOS2KOxjM8b1PHNLU2hFXitHDCA8ou7LFU4sXHpNtd
 hjHMnzQEWPKB7qFnsU5t3EBfbQ7VVnUOcmsME4Rm7WQp5B0V0tDSI3SaaNeBRQ11aTU6
 4OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704295870; x=1704900670;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ziOlqsIoT4l/tS6IUNKKfoa9E5fTN49T5ltMcZCw0oQ=;
 b=XSNbFDSXB0hHwRl1q0SEezCqR/C089PPR8P67J2+AdSNqIasaZORPhYU49vbKdiwUR
 9+48wUCN0GExqOD0KqpRrRsdoXd+4uxSNg3Tg49hbdW7TXup8ch9FhJO0hpw5vQSZ8y/
 Gkz4JzRnFdKscvO5lGDiiTsZZ5rQg9jBL/Q5WlvztpreNM1r0Rf0HKa/9FvMVMCT2piM
 B6G09s8JnkNb7qmmdWfObD5u1ufMDRTA9t8uL58NOJ4fVRiH9N+3ETPdod/JgK9H78dI
 RTBRtvzjbSNgxTVfkE6/r2HfgmFK1kUyAira8f6MxSRyGG5ZR0yFCqcyLDgVGZ6ZITCe
 uAsg==
X-Gm-Message-State: AOJu0Yz5MmWp+NQMZzR4rAm3IcsQm9PflF7fXSl8Gj3Yj/8s7UbcwGid
 6qfI2QMBvVFJclNIblTA/a/JFgyBV3iAzg==
X-Google-Smtp-Source: AGHT+IGA70Ksmf5BPJ5anHmC0dhzIjhyHBqMBgkVquL6H9uLx4NhMQ0ygfODD7djbl6hXLuPwcNO2Q==
X-Received: by 2002:a17:906:af95:b0:a26:6d82:3261 with SMTP id
 mj21-20020a170906af9500b00a266d823261mr1018301ejb.38.1704295869985; 
 Wed, 03 Jan 2024 07:31:09 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 o20-20020aa7c7d4000000b0055537e76e94sm10524871eds.57.2024.01.03.07.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 07:31:09 -0800 (PST)
Message-ID: <994853ca-8d4c-4348-be14-cc29168f082e@linaro.org>
Date: Wed, 3 Jan 2024 16:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/33] linux-user: Remove qemu_host_page_size from main
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240102015808.132373-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 2/1/24 02:57, Richard Henderson wrote:
> Use qemu_real_host_page_size() instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/main.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


