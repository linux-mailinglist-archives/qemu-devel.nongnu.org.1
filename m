Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FD17C873C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIbK-0000I8-8d; Fri, 13 Oct 2023 09:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrIb2-0000BL-NC
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:53:03 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrIas-0007h0-5f
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:52:47 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c737d61a00so18026255ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 06:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697205164; x=1697809964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RVAPBrtqnHNfBh8ZDVxlLhAVG7ZyA4mRHaMgvi6tUwI=;
 b=jBv/WpdRo34v/SbHhc8bPkow80hAxbHY8K72XzO3D2mtob1/7ceNRtFyUQ71A7xiTr
 jwTkW0yeyoQhXO0WUj7osKObCbEbQ99et5ggr/t/mWa+Od2LqW8AkPIllnJadRbi74Qr
 NnaENqRrmHFpV6fk5Xr/+QJypffaw7lBbK5uUK5vHM4C0t0vB8/7GKuxnKxafJA3RMNE
 L2OebHVDn3yaaBkI4+qQtO7TWoWmw6CEqY/EV467lLA/Cfb8Sebd6a4+tGBJGCWfxtbF
 pLbFMUcdrbYp5s2GyE98/OyufMlVrq70FyLYJ6lT9kHTzOP5aiK+AizSpiXRfx8V0H4w
 Gjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697205164; x=1697809964;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RVAPBrtqnHNfBh8ZDVxlLhAVG7ZyA4mRHaMgvi6tUwI=;
 b=BjpkmYFwTX/ANA8SRAF+Z4BapTtlFSJDFA90NN30+ACnrMRP4uOJJi9fL01QI1ZVBt
 VDF1pZoF2avuFroWsR7qDtXUVsc70xDtF+J9Jf3Km+XB3whbcxI60k8etdyYyIyu6zwd
 VBn+A4LlW3ohIOnkg6COITLgzkzmJ1SBOEDix7S7uFMn/nBoACjH9GiN9Rc7eLtQh5BG
 RXMkJcnDn5QGHR0caksCA7hIJb3/LZr5jN+AixvkfkQ/JsJQeSq57W7GxyNDGKvOe+vG
 ykNenE7PtLqNUqTfzjEJzJK6XgKjpOZjGXt3ZvCUdlT6e3wgYkZmTyTratqnW96XlStH
 3g4A==
X-Gm-Message-State: AOJu0YyzKPjw2+NP7ZWEHOvm3tFU3LA3/nyYWCwfwRbPzg3rbOMU0NQQ
 5gbLXKp8SwhGw6orJh4fXozgO2oV2rOqaKqf3Lc=
X-Google-Smtp-Source: AGHT+IHKNIxmeSAb4+unO8Wr7K8CEAazGOu+Up8/wkZstmSdCE2ilRl65M7qgtg2z0BBnT1VFMCVJw==
X-Received: by 2002:a17:903:28c5:b0:1ca:abe:a08b with SMTP id
 kv5-20020a17090328c500b001ca0abea08bmr876567plb.68.1697205164153; 
 Fri, 13 Oct 2023 06:52:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jh10-20020a170903328a00b001bdb85291casm3918320plb.208.2023.10.13.06.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 06:52:43 -0700 (PDT)
Message-ID: <a4f64040-9812-40b2-9287-0c971b4bec4d@linaro.org>
Date: Fri, 13 Oct 2023 06:52:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/78] Strict disable implicit fallthrough
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/13/23 01:45, Emmanouil Pitsidianakis wrote:
> --
> Resending because --function-context was accidentally used in the
> previous version. Sincere apologies for the noise.
> --
> 
> Hello,
> 
> This RFC is inspired by the kernel's move to -Wimplicit-fallthrough=3
> back in 2019.[0]
> We take one step (or two) further by increasing it to 5 which rejects
> fall through comments and requires an attribute statement.
> 
> [0]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a035d552a93b
> 
> The line differences are not many, but they spread all over different
> subsystems, architectures and devices. An attempt has been made to split
> them in cohesive patches to aid post-RFC review. Part of the RFC is to
> determine whether these patch divisions needs improvement.
> 
> Main questions this RFC poses
> =============================
> 
> - Is this change desirable and net-positive.

Did this catch any new problems?  If not, I really don't see the benefit.
The compiler comment matching appears to be sufficient.


r~

