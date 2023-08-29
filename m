Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 958B978CFFC
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:10:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mz-0000mf-By; Tue, 29 Aug 2023 19:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3if-0003OJ-M5
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:45:42 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3id-0002Dd-BR
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:45:41 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68a42d06d02so3307542b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693334738; x=1693939538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gtDgq+/WYJ+b/sZ1SxnPIpaHqwGp+FLWx/NLiXyH16Y=;
 b=UC8Mq/0qeQDmWBoKXcCN4LN7d1Wq7ZrEugIND538F1GjcWnIZlLTQqKCqhdnUjPSpN
 FR9aVj/ymiR8ZWXPyXDNcGgXdgilNo229hUyi+zBm4oZxESbQ8BuyixCk3bOwzOy+bzL
 ZH9ah/ay7gWf0sOTEly1M4GbE3AqAD+f7yx0BHTlHLV1MsqOMffUwlpZ5h/DemjBI7xY
 iffnK9sImtS3KwgPRA3vqr/Ptl3BaDcfhdkVx0Mc5Z3DAY+KNtdGEXkhKszfrULZc5aO
 aG86w+Z12h+Qzyp2LcbNA+B2roTozYqpMel/csXTHyZf3Hx0OTMEMUooinKm6JKO5eAZ
 ATWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693334738; x=1693939538;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gtDgq+/WYJ+b/sZ1SxnPIpaHqwGp+FLWx/NLiXyH16Y=;
 b=IIwTjZaVyb+KatkLpt0o6aVDxtEDQa+8xyKe7e9tdc7EHj11GSVrhH3AYiqbMWw7Hu
 hB52It1NWXYD5uwoCsV6hGZnNqLpFDUPlSCx8N2tf8aa+V2crouP/BcAPE3Tt/niMNil
 JIN8dgw3YZMKhaQyhZ65NhxjALs/LPVn7GMdsJXJ/F1LwEWL2L8suXuHznHlNvFik06d
 UYVbe/qScH3X4bQVUHRDqABDdsU8cuE9EYnt/BDPvgePTegh8/SGzlKUV9iYvFejyz/+
 c8kKwJkh3I+S79U0NeV2HOR/xGRrdG6GrrssELdgYF1/MoIFzeSWcwGYMYc6QG//7Nz8
 6j0w==
X-Gm-Message-State: AOJu0Yy8IRMVZD/nXDVHzCc4WbEccz6xekoB2ehdhk6PsHwXspQjJqKW
 bJFcZGBXbFuOTMm2t25xMKTEQQ==
X-Google-Smtp-Source: AGHT+IGqep4rrYsmNrGaqJCOg5US2cZcCGzsorDe0/GduTYb7/scc5vxXoGQWh7NC1QvYJeWrrDKYg==
X-Received: by 2002:a05:6a20:2d6:b0:13a:ccb9:d5b7 with SMTP id
 22-20020a056a2002d600b0013accb9d5b7mr115620pzb.41.1693334737746; 
 Tue, 29 Aug 2023 11:45:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a170902b78800b001b7ffca7dbcsm9640786pls.148.2023.08.29.11.45.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 11:45:37 -0700 (PDT)
Message-ID: <94ae5eef-b0b0-e6d8-e319-0f453ad58a15@linaro.org>
Date: Tue, 29 Aug 2023 11:45:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/10] configure: create native file with contents of
 $host_cc
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230829082931.67601-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/29/23 01:29, Paolo Bonzini wrote:
> The argument of --host-cc is not obeyed when cross compiling.  To avoid
> this issue, place it in a configuration file and pass it to meson
> with --native-file.
> 
> While at it, clarify that --host-cc is not obeyed anyway when_not_
> cross compiling.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   configure | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

