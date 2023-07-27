Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B3765C9D
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 21:55:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP6fo-000202-Ml; Thu, 27 Jul 2023 15:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP6fn-0001zt-Km
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:29:19 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP6fm-0000Th-8z
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:29:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686be28e1a8so974715b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690486157; x=1691090957;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hx4Uf5v4r7a2giQirBVTkiucYLJrPvOuy6I0Usxx6pw=;
 b=j3nRxhfo3gR9flMuxRq8x5UlcqS2BjO0a+R3pCp+AQi31iaCamKH81gAu3wfKmvTak
 PLHznLApNtj5JhlMxe8VWCbnZTflqWCD4hV5TXTR6kGdEMDGuWxcsMgrxL0iFOsGVYUa
 hfD1jTb+P1I33Krrid4TRjGAhUCx2LrwgIXSTOOyioZlLIgHEcWqz1u6ZUPj6zW43e33
 gOKOUSfk4XVp9pvlxkLTMi0Su6NJ/F2x90eRIz0S6enqQx7RFQCVEGefQbrKWHERecad
 ifglwYYZ6LWYPeKEPvKv/lzKhhkV1i5QOe8s/Rl0rFNVRDk2nklH+PJbXpqLE88dXSoa
 OHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690486157; x=1691090957;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hx4Uf5v4r7a2giQirBVTkiucYLJrPvOuy6I0Usxx6pw=;
 b=NZIWXb7xeno2ZH19z4+jDluzyqNnjW43Y6LaLaJg5Tze5VPYYQygb9WEHyTciZ3qhc
 3YAUvLWoXkldxIx79FFjaZmi+YcXnU0UVlFZjlJbylr5rNpoohhH26WxFESf08Q+pxWM
 fCsTS4StznuzKXzmRs8gZNe7G2xmfUoSOLbSttZnKjgytXw5w8jaA/gaKmEsf1JQT12b
 xlHnNnpVrJ3WEk4zNgUf8CVDxkE8qSGhwVqL8sT7yiF7eiMCiY0fXjFF8zbV9ubIoLzy
 +chLNElj8WP7Fuin4vJxePaojkCy+9FghxhVtUCQ/MVRoN/2BHSqlrtCla4mJ/3ViHDY
 mvgQ==
X-Gm-Message-State: ABy/qLaTJMd7PtgIxq78Yto5fzxn4m5jUxowVF3Hes5k8AdvgT90yAJG
 sP4Y//nidwwiX8UYQZIqYsXtuA==
X-Google-Smtp-Source: APBJJlHzg+JoRFP5ZHhUPSM5goJm54c70TJJca+GruTLuArYIlmWCd+5Z10eVyBdhTvtVqm9PSfXoA==
X-Received: by 2002:a05:6a00:218a:b0:687:570:5021 with SMTP id
 h10-20020a056a00218a00b0068705705021mr75970pfi.15.1690486156896; 
 Thu, 27 Jul 2023 12:29:16 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:caf5:5ae2:432a:1bdf?
 ([2602:ae:154e:c001:caf5:5ae2:432a:1bdf])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a63ab05000000b0054fa8539681sm1913742pgf.34.2023.07.27.12.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 12:29:16 -0700 (PDT)
Message-ID: <8c0d31d0-61c7-3a2e-47de-0ae4de87e424@linaro.org>
Date: Thu, 27 Jul 2023 12:29:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/9] target: Use vaddr for
 hvf_arch_[insert|remove]_hw_breakpoint
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org, agraf@csgraf.de,
 dirty@apple.com, rbolshakov@ddn.com, anielhb413@gmail.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
References: <20230721205827.7502-1-anjo@rev.ng>
 <20230721205827.7502-5-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230721205827.7502-5-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/21/23 13:58, Anton Johansson wrote:
> -int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len, int type)
> +int hvf_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
>   {
>       switch (type) {
>       case GDB_BREAKPOINT_HW:
> -        return insert_hw_breakpoint(addr);
> +        return insert_hw_breakpoint((target_ulong) addr);

No need for the casts.


r~

