Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF582781E74
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 17:13:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXk74-0004oq-PU; Sun, 20 Aug 2023 11:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXk72-0004oN-RK
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:13:08 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXk70-0007EJ-Me
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:13:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68a3daf4cf7so171411b3a.3
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 08:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692544385; x=1693149185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jwEuHstn8M6f1VgKMoCT41DGzR6f00wIT5IoKRTCyE8=;
 b=Y2ZrCSzmECepl6lmTGxE+lYV8HjoRg3DnxWHPa0PhTpHw3FT58a9B3WXruxJXKyynZ
 6r6xqHjHH8OFuT7UVDmoMgSgNX60MKQ9ixVzhsIXcXZ8h91SgSaJXXWRwABDmVMw+7HF
 Xn6aS/LvLQ8Sk65m2BxvmGSO0HPShr4eI9e7q4ceBJUHML3ixLvAo2xxZPPNkZs7ijrx
 ME455w4OZ6nYf32TNfqSzP6ceIRsTCmHgNYbHscmmy2Tc0OYJCxJsTZ34ezY3cI2OteK
 A3powTOSvgKkUq9/59F1dGrBiTYAXtnu2mw5OupgvcKPBFJ/hLKa4WCPADr/6sSfv3AS
 Rghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692544385; x=1693149185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jwEuHstn8M6f1VgKMoCT41DGzR6f00wIT5IoKRTCyE8=;
 b=iizfnG9NcKcQcUCEZosCcOyaNEDcfGH9AiayxBMxgJ1yixk6zBjukm9ZPe+gUeDtD3
 Stf3YR4zWrYbdd/jWIRmf85PLtSdQ+BYV8fpbXVWp2zipqACIcqkZ3dENDWqBLqdBjBV
 klnddSp9Hp7G+gkmiDtIyFlNvxFqDDRPumWysFKSITC7dw7e0kiytvNpjYRzLjrvr4P8
 62DSNhl3VwAwGoq8GQpEwY2XgYwafHoqAtbWaZqHrSqYxjm5TjGBkS1pXO+p8TgKy0X9
 QPYduCO6zlSi7FkJvXAXMMODibXOkI29xvDf04t6EQH7BsVY20hlZikYDPY+nUmTcVGR
 4A/w==
X-Gm-Message-State: AOJu0Yx4idiNjd2zjS2wZJoVYtBlU/11eJpuU/1hwO1kRM+WYizvH1SP
 WT2/9vh4MGhZiovpr4nbeuopdA==
X-Google-Smtp-Source: AGHT+IEgpVMlx+954i+W3rvlR4iJGWgB59Dscpo+pLaUC1Ugg+HijqWsxPVEz4uSF9nqRvlrnQbLFw==
X-Received: by 2002:a05:6a20:12d2:b0:12e:92c1:b1c8 with SMTP id
 v18-20020a056a2012d200b0012e92c1b1c8mr3447095pzg.47.1692544385008; 
 Sun, 20 Aug 2023 08:13:05 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 iy20-20020a170903131400b001b89b7e208fsm5226954plb.88.2023.08.20.08.13.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 08:13:04 -0700 (PDT)
Message-ID: <ec99a998-7793-1c01-e9e5-d84c3ada68ee@linaro.org>
Date: Sun, 20 Aug 2023 08:13:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 20/22] Implement shmctl(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-21-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-21-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/19/23 02:48, Karim Taha wrote:
> +    switch (cmd) {
> +    case IPC_STAT:
> +    case IPC_SET:
> +        if (target_to_host_shmid_ds(&dsarg, buff)) {
> +            return -TARGET_EFAULT;
> +        }
> +        ret = get_errno(shmctl(shmid, cmd, &dsarg));
> +        if (host_to_target_shmid_ds(buff, &dsarg)) {
> +            return -TARGET_EFAULT;
> +        }
> +        break;

IPC_STAT treats buff as output, IPC_SET treats buff as input,
so these cases can't be combined.


r~

