Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 194407C9A1F
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 18:54:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs4Mm-00067V-C0; Sun, 15 Oct 2023 12:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qs4Mk-000670-9v
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 12:53:22 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qs4Mi-00019T-Re
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 12:53:22 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57b8cebf57dso2020701eaf.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697388799; x=1697993599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DRkK6e4PKz44n7opJbllKh/+R0L3QRakDN2/ffomjek=;
 b=XQnZ4t0pU/a96naVQUR5pjD8ipfV2ZhoR/aeU9DjPTc5FAQDQ25NDSYloQRBr9Ufy2
 XeLP1p2EAZ3GSOd5scldNIFkSBkV03QmmFgNqGxeOJe1arMtiIVJSDhbzxxvHc92/Hyy
 G7G8cQtJREJDZsM7HmsM8dM4LfuF1fWG9o9a40DgYcKzxyoTAUDn/iNNOwbpz78mMuZR
 A5izPDtueqXTOHAwQjIR1G7okSv7WFZZkceiMZGqHaMDEgGUGvDc6UtWJ0nKFx8e1Xgg
 6R5G9Xvr18KV7ypEel85NPCcjvhXUnx3FXxzvW4hUAN9yclM0humATJnqCCUB25sHyg1
 v84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697388799; x=1697993599;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DRkK6e4PKz44n7opJbllKh/+R0L3QRakDN2/ffomjek=;
 b=bNmimdhGMN+wI17ejCkzD4Tdb/2AMwPgh1nZs5DCQvU2iKjy3GLnSVVIXBKXOsY1w2
 wXvQv1HpS/JUmO2myniBusTPPUhPK2jdmwRNTaLMlrLn2IRBQgeoaQLzGWLVGCmE8Fnf
 npyabdID19qaoEMwzRn+YSvvb3GRuZWNV36gc1W9/oy3Pqiv5QHXPHboj+ba7Ulr3chr
 y54ZiYrm2yKr2cdrR/ytQcKeT2kObJ45AtdfHguxhAPPZXKRZyaepXaKz0kOeXyeenEB
 4VunDnpByw+JU0BSuCFgXr+owIpXocxISvNqkLCq/g8Hbk/y7CpbAysjhmkyufAqxhXx
 +BVg==
X-Gm-Message-State: AOJu0YwZau47eMdrhcgMHYPciVEHT60hoMYLnMsdI3xf4M1LTCq4j3UK
 N8CgAPsNjLMq43FVRKkVx9qBMYf5d5Vbl+gUHSE=
X-Google-Smtp-Source: AGHT+IFaR0qkb1QhzIwrOX1OfbJPIt9Z+OTFFGUsytgULqyJnhy4IBk/djSpzjTRzfcp/ORj0mIfaA==
X-Received: by 2002:a05:6358:63a7:b0:14b:d9de:3008 with SMTP id
 k39-20020a05635863a700b0014bd9de3008mr40320535rwh.5.1697388798770; 
 Sun, 15 Oct 2023 09:53:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006b1c14a493fsm4449876pfb.71.2023.10.15.09.53.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 09:53:18 -0700 (PDT)
Message-ID: <f50eb588-99c7-4b58-942f-05cfb35f799f@linaro.org>
Date: Sun, 15 Oct 2023 09:53:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/85] target/sparc: Remove always-set cpu features
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20231013212846.165724-1-richard.henderson@linaro.org>
 <20231013212846.165724-4-richard.henderson@linaro.org>
In-Reply-To: <20231013212846.165724-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/13/23 14:27, Richard Henderson wrote:
> The oldest supported cpu is the microsparc 1;
> all other cpus use CPU_DEFAULT_FEATURES.
> 
> Remove all bits that are always set: FLOAT, SWAP, MUL, DIV,
> FLUSH, FSQRT, FMUL.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I've just found the command-line properties that could affect these, which unfortunately 
don't use the CPU_FEATURE_* symbols and hard-code bit numbers.

I'd be tempted to remove the properties as well, with the possible exception of 
CPU_FEATURE_FLOAT, but maybe not even that.

Thoughts?


r~

