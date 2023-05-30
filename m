Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B7271642E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:30:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40Ln-0000us-B0; Tue, 30 May 2023 10:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q40Le-0000nn-7U
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:29:19 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q40Lc-0002WF-QG
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:29:17 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64d24136663so3053422b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685456953; x=1688048953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DdtmqeRraGPK3DxuXErqTENFASQDjvBjGRM7w5znKUU=;
 b=tV/xTYw08ws1oRArenJtof2MjsP66/YhbWPB3jfjPCP+Fa9tYUV2GxDR1KvFq2jyJi
 XgBruDx/wIDt8CmBeodDGfT+ChkhlvTd/2A9q/1YhKRdvKWbcTCiskPHqcqUtBjNBghj
 RSib0N2VGQ8SQ9Nx3KSPwdoAHNk8r2EgMMRbOOpkOR7pWjsoY+BEJJ03vaewl9vLVbam
 8IgfXMkVVETW4ffpIR6KZiVMhRW11NfL2+JR2HO7/8JlCTevGPweC66Z130cb+Fi/oGz
 ZyqIVnGy/rI/CoaaIK98r/R0QqLH8SCmpQd5NdC+iIoJyFjjngCGvIQh4RlzGJ0MveVM
 cZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685456953; x=1688048953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DdtmqeRraGPK3DxuXErqTENFASQDjvBjGRM7w5znKUU=;
 b=DWAFxXI+fjraVjrl8vIrhmuDiHa1A2XfDWxk726XfxEr3xcfY/F/5eDV2YkL59s3la
 GEIdC/C/gOLzRZKKWxiYmV8dq56zs8vTpWEjwCfJl4Ai+3tgaCO073SfA1mUZmgHNpHh
 U5ckPdi0OXFpd18gPS3l1HrNba9yhWBkdUoXGY2pfwxlBXiQebViHWLXuxDpr+xPlcfb
 ndLOGJRWISF5dG/ZTOAgNI88PQktw9WLfxblXW9FZl0kPrieNnNV6kfnDG9yST24iIJX
 GAD9xIkmdQKPUWLoFCy8g9Lg7HhsGSMAryO8bdsSn365xaLncY0FHgP0jRrp6VTQSGnv
 xfPQ==
X-Gm-Message-State: AC+VfDzLeoTMYDcDv4kPp0qDnGNwbb9iB2+242pMDz7jLpODNf/3ne+e
 5v8rH2qQYgA/Y76V9ZFP16IkNxHu7ZWCWqj4V9M=
X-Google-Smtp-Source: ACHHUZ5CpRW6tD1pGVTsfjfvOWl9T2/gyLJ1TgvnGLWF7QzL9Zd1FbBtR14Wccb1kesFbUiODQHPKA==
X-Received: by 2002:a05:6a20:1610:b0:10b:8698:2097 with SMTP id
 l16-20020a056a20161000b0010b86982097mr3246771pzj.0.1685456953038; 
 Tue, 30 May 2023 07:29:13 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a63f711000000b0050f93a3586fsm8854683pgh.37.2023.05.30.07.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 07:29:12 -0700 (PDT)
Message-ID: <a7ba5e1c-ca59-b114-229a-07930f6ba683@linaro.org>
Date: Tue, 30 May 2023 07:29:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 02/16] accel/tcg: Fix check for page writeability in
 load_atomic16_or_exit
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-3-richard.henderson@linaro.org>
 <CAFEAcA8E_wbiL=xxc=qzfbhBjTsGVxpMGYex_Ezsn_=47DJP3w@mail.gmail.com>
 <5192c74b-38fb-7f2e-7b27-58d210c1b087@linaro.org>
 <CAFEAcA8tPuFMz8BZ5P-SJS42q8E_TZ1_5DJL-0kOvzeT-Fymmw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8tPuFMz8BZ5P-SJS42q8E_TZ1_5DJL-0kOvzeT-Fymmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/30/23 07:06, Peter Maydell wrote:
>> This is about falling through to the cmpxchg below: if !PAGE_WRITE_ORG, then the page is
>> really not writable, we will SIGSEGV, and handle_sigsegv_accerr_write will kill the process.
> 
> Right, but if !PAGE_WRITE_ORG then that implies also !PAGE_WRITE,
> so we do that even without this change ?

But !PAGE_WRITE does not imply !PAGE_WRITE_ORG.
This fails tests/tcg/multiarch/munmap-pthread.c.


r~

