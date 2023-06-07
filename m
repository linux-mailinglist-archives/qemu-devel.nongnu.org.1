Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F5C726915
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 20:43:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6y7N-0005O7-Pe; Wed, 07 Jun 2023 14:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6y7M-0005Nc-17
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:42:48 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6y7K-0000Fz-Fe
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:42:47 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-542c54455e7so2567300a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686163365; x=1688755365;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DDzN6l/JaHqFy8u87d7UlnU2HVLpNTzgbII7x9Kg+lk=;
 b=j+TeNdqZVeMtZILsUbIDjmk9jnT3ZkzX+sg7JG+Xj6wdKcd7zCfzlWHQh0lW1/gJwk
 +sxtUgohKXmPmBRIN+hFt2RRW3Y/5BMLJRWQiOK/rywdjnvPusIb/kwkJTnQTGjdQeSZ
 sfaIp7qogyZh1b270VHJmnGHkkcO/NtcQXM02/1OnApJwb/5RBOnslmarVW5SsdcTkhn
 MbGzk47REooXRIdxM/yBnmHXQ+1eWFFxtOcAzJ4kjviEXn1fnZ70Xtn5KC0X5h46T+JM
 Dccmow1n17MqhldTRsIYT6uJ9rHcOM/tfGLvFIwQDtn630vFlnlaAWxh3i27Cz6hg/cN
 tScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686163365; x=1688755365;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DDzN6l/JaHqFy8u87d7UlnU2HVLpNTzgbII7x9Kg+lk=;
 b=IjEEK+1/2J1Z/oUFLVTeBjD7lqlqZQLndfOjkesqUTxRvo0qd6Lgf4uZ1SqthUjKzu
 jFe7Tz9wQoWqm/XB8BDAycY+sgB7E2q5KqiOlI3JfNC5B1bjcYth2cvdQxVsspJvLOkF
 On5G1pU6tCJ/7TARcNzThvakJFOzAznhxn+S2+8LKAk58137bHT0CXoufJD54OYe7Z9y
 Bmla96YMvVZ03Zo5rjWIDSsd0qVkhmu+caogaDHQ4t67fWp8F4lPZqIIM450Ft+3VmXr
 hKg9RZWVDxWy85aBNqDWsq6si5nQuRYsyEMPc6eO2sTs2ph+ZKbMboxBSbWuuoV3fWld
 MFOA==
X-Gm-Message-State: AC+VfDylX1iUWw2/pibGm9PBqH5o2rgQn+I8K0nDVqBRNYi3vAdWbj8X
 443ktHL8a+xU+PdVIrG0w1tWmA==
X-Google-Smtp-Source: ACHHUZ6mndlwQZhXGmHENtN7OBIOwcnc6eY9va6W1UOmHWTlL9JhEK10AuaGLq6nJBVJY2yTuLXGJw==
X-Received: by 2002:a05:6a20:8e03:b0:117:d4d:15fb with SMTP id
 y3-20020a056a208e0300b001170d4d15fbmr1982331pzj.10.1686163364908; 
 Wed, 07 Jun 2023 11:42:44 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:1f09:2b0b:a56e:7a17?
 ([2602:ae:1598:4c01:1f09:2b0b:a56e:7a17])
 by smtp.gmail.com with ESMTPSA id
 e24-20020aa78c58000000b0065ceef92047sm4728160pfd.31.2023.06.07.11.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 11:42:44 -0700 (PDT)
Message-ID: <76e6ea8d-e651-98f6-0b64-81820fbd6baf@linaro.org>
Date: Wed, 7 Jun 2023 11:42:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/12] xen queue
Content-Language: en-US
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
References: <20230607141839.48422-1-anthony.perard@citrix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 6/7/23 07:18, Anthony PERARD via wrote:
> From: Anthony PERARD<anthony.perard@citrix.com>
> 
> The following changes since commit f5e6786de4815751b0a3d2235c760361f228ea48:
> 
>    Merge tag 'pull-target-arm-20230606' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2023-06-06 12:11:34 -0700)
> 
> are available in the Git repository at:
> 
>    https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git  tags/pull-xen-20230607
> 
> for you to fetch changes up to 9000666052f99ed4217e75b73636acae61e6fc2c:
> 
>    xen-block: fix segv on unrealize (2023-06-07 15:07:10 +0100)
> 
> ----------------------------------------------------------------
> Xen queue
> 
> - fix for xen-block segv
> - Resolve TYPE_PIIX3_XEN_DEVICE
> - Xen emulation build/Coverity fixes

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


