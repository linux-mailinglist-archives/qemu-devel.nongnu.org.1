Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E618833178
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:27:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQyGl-0004eV-NI; Fri, 19 Jan 2024 18:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyGj-0004eH-Oz
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:27:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyGi-0002DD-3a
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:27:25 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e8801221cso11682645e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 15:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705706842; x=1706311642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TADdEPYzJyA7RSXJ4MYwgfhq0+VV7lM9qaUA69UZ6VE=;
 b=Ea214u3U4I7MqfWeLdmdN7fM2v4T2LCB8tN1G3wqgctzKCvcyh7JvC1Ue3tmY4SJGd
 PMbQExt8Myu46W7T4iBkX3mOXdn8F3R4nQZjBeihSmCRkjB5LwlN3DofVHnpIXD/mRb1
 FTczRrL04p7lsaxE/RbEITXQcxT4XPrg4SI8qEnv75xWFM/XIcJhZ2mX5ckp6S8p7NGN
 Ec14Uyy+o108wOdtiIbF6+adsZlhm/TBRTOSzw+f5HYX6m42v82PJaJ4el6Oam4YcQwU
 kf4HCBRAZuWT7xuZQFaNrDJawnX2QgsNIFzJlNaixNdMq06hd4b0CM1HK6WwPzUsw3Aa
 Ih0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705706842; x=1706311642;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TADdEPYzJyA7RSXJ4MYwgfhq0+VV7lM9qaUA69UZ6VE=;
 b=HZ+kG3blSh65L+znYzUjy8h+x8THOYDBFiU7XOqGxgO0J6hnZXS9eYUtLRUmZKI49P
 GtmbBxFo/IoZcNIjlbgcgDD77lgBS5J8Pgw7if/xZzbxuNFCuNXMu6SflX96cnKePN6O
 gJEzxnUkEZkMLx/mPwp9jKPZro65qbjN1CKE6vgMm4g5fkxEKmejCeBdHiLXOK2o7sM9
 U5trTWGzbmVLDVm6sMk+lZXkW9s7wBFbIwxDf1F1nSxV7y1LJy5mwf0/Zlg/kuleUp+e
 jIwesrw6kEwd5a2hYu8Wo4EDAQwCXBe9XU3jPNPPlfEJZJz8yFUTQXOrGeH+hHy4CVyx
 r6WA==
X-Gm-Message-State: AOJu0YwvLzfsYNxDE1zK5NxeopZ1HSh2IcdivOJJv0z0RmDADUZ3EvDL
 7Iq9I+KmN8WzeDCeniso/VrwGdyk/dbo+U2kKWQMRbGyWOIqnNujq8QVjsVABeieEN5qJeuZqyj
 s
X-Google-Smtp-Source: AGHT+IGlyfkreLlyyXwTG25gch6187cfbXQ6F2U1/Omvc5KkbTSGEVApjpIdOF7T6SIH3dWV6I4XRw==
X-Received: by 2002:a05:600c:310f:b0:40e:4cc6:b4b4 with SMTP id
 g15-20020a05600c310f00b0040e4cc6b4b4mr253188wmo.36.1705706842312; 
 Fri, 19 Jan 2024 15:27:22 -0800 (PST)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 j21-20020a05600c1c1500b0040e9f7308f4sm2912581wms.10.2024.01.19.15.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 15:27:22 -0800 (PST)
Message-ID: <4573f3e6-14f4-408b-922e-b4ecbe5a7ce8@linaro.org>
Date: Sat, 20 Jan 2024 00:27:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/38] target/s390x: Improve general case of disas_jcc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-16-richard.henderson@linaro.org>
 <b6a05a23-9f83-4a62-9f60-1ac5234cde31@linaro.org>
 <38b4bb14-3846-458e-871f-6a60cc69719b@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <38b4bb14-3846-458e-871f-6a60cc69719b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 17/1/24 04:19, Richard Henderson wrote:
> On 1/17/24 09:19, Philippe Mathieu-Daudé wrote:
>>> +        case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
>>> +            cond = TCG_COND_TSTNE;
>>> +            c->u.s32.b = tcg_constant_i32(1);
>>
>> Don't we need to AND?
>>
>>                c->u.s32.a = tcg_temp_new_i32();
>>                tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
> 
> No, that's the TSTNE cond there.

This patch as is was too complex for me so I split it in very
dumb steps to get a trivial patch:
https://lore.kernel.org/qemu-devel/20240119232302.50393-6-philmd@linaro.org/.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


