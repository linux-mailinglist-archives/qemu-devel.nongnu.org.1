Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BB87410CE
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:13:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEU1r-0008Ta-E5; Wed, 28 Jun 2023 08:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEU1o-0008TH-9y
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:12:09 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEU1m-00063s-Ar
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:12:07 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fb7589b187so5260617e87.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 05:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687954324; x=1690546324;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Cg8Z7JiWAy91wlju/RRik0/wVH5G4uO0xd2PVLz5cQ=;
 b=XVAilKtUV0w2/Qu3IESi+45ZGVQY7Cjknj0oSKHZrK2AI9zLxOCj7fgbvPBUlEeLOK
 N3o80Zf9a888tXDtMQhr5WDXZ09hRQEYutVFo9eJoBhDDKDnmdhdeKxx48B85C/lFd9I
 4n5uI7NsUpGz8L9If8OKWU5D/u9ivsmxvhAdZ2nz7MsaA35+ikiHJYWrRP+/8UtQFUNX
 FyfaJSgf3cws+Eov/Oy1lMKqtDG/eIOpsbQDVJGsq2miTS9KpkpkvxKJ2hsexUjWDFI2
 Gjpiuxzs0gQbSwtdA42EP+bS0nJiVK2J60W11mFlin4g7UCNUJkQc7rUR3yiQ7xP2zpk
 +gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687954324; x=1690546324;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Cg8Z7JiWAy91wlju/RRik0/wVH5G4uO0xd2PVLz5cQ=;
 b=TLhqOYcxcDBsQy0+4fHyZ3nhQ5yM+TzPfv5PkFNQZw/Uh4kJwbrJR4+jOPNSocNyiE
 kLxxvmR9QEfqylLYbKzeTbOsePhpSeBULzVmpu1xycS5uuyqyX0IoL9Ag+FFvK43eJ9q
 ew0PGq9TeWvjLA2N0dgOe/ZSkApv/9yZvDLCxbxnjJodGCUWgXUplAiTS59rRpYkViV5
 HH2EF+ury+gQesntyCh01Z1xz29hzSGwAWqS6AfUdwMrukdNLB95RQON7haCy8Y9BOKu
 6DrJ0thvZs5tLFQ8rcnuxSPd7iRrS/2v4+tJDSxsw52Vv0GpKB3ICglCzrZaYhv3jJmH
 LLpg==
X-Gm-Message-State: AC+VfDxDBAxtKWefbZw/c36/fOTeg7sFNg59AUDKATRZbdw2xXXDUglp
 7Y7X+JQ7trZ6BcykXMT4+FmNJA==
X-Google-Smtp-Source: ACHHUZ5BJqX4kFglCsDoxxYoKT0ZUy4xHkeYIcHX50ezjsTwTvdaihF+oBjqnJ/x/1V+bxbRaVJhCQ==
X-Received: by 2002:a05:6512:ba2:b0:4fb:73ba:5d9c with SMTP id
 b34-20020a0565120ba200b004fb73ba5d9cmr7244331lfv.17.1687954324045; 
 Wed, 28 Jun 2023 05:12:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a7bce86000000b003fbaa2903f4sm3394770wmj.19.2023.06.28.05.12.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 05:12:03 -0700 (PDT)
Message-ID: <4c1044c1-eec7-9396-b33e-14b450e2837e@linaro.org>
Date: Wed, 28 Jun 2023 14:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] Add symbols for memory listener priority
Content-Language: en-US
To: Isaku Yamahata <isaku.yamahata@intel.com>, qemu-devel@nongnu.org
References: <cover.1687279702.git.isaku.yamahata@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <cover.1687279702.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 20/6/23 18:50, Isaku Yamahata wrote:
> The hard-coded value, 10, is used for memory_listener_register().  Add symbolic
> values for priority of struct MemoryLister.  Replace those hard-coded values
> with symbols.
> 
> The background is KVM guest memory[1] or TDX support.  I'd like to add one more
> memory listener whose priority is higher than the KVM memory listener.  And I
> don't want to hard-code 10 + 1.
> 
> [1] KVM gmem patches
> https://github.com/sean-jc/linux/tree/x86/kvm_gmem_solo
> 
> Isaku Yamahata (3):
>    exec/memory: Add symbolic value for memory listener priority for accel
>    exec/memory: Add symbol for memory listener priority for dev backend
>    exec/memory: Add symbol for the min value of memory listener priority

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued fixing the typos, thanks.

