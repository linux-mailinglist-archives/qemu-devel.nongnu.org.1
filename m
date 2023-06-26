Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F139B73DD6F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:28:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkNk-0004rh-Q4; Mon, 26 Jun 2023 07:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDkNN-0004iV-3O
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:27:22 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qDkNJ-0004Ro-1a
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:27:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f9bece8e19so51440255e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687778830; x=1690370830;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLujOKsXlm9KHQ1LLzZ/KxxngZ83aAuPeNX0wQ4oF3o=;
 b=xoGviNjLlVK3LXS4ytwHkp7qAVR5rE+63jHhYNeqnBwpmwRlNj0CiZkUgC4ry3rdfi
 O0lZwnhJnjocjd3QhQmukDyZI4Vrf3qSKFrBN1tBkNkUtDhicmSBKHsb60M16llJIjZc
 zpgJojGMxRAe5Yma42ZlBJBfoNZL2HEEGL42USGjIsdq06WxkpO4wXznfneR0r6tu1Td
 /MPpOIut6hAZMxs6yBI4EIHeAiRbvUaRLjrsX/5sjW1HbTPdtCkuX70BggqrpsED6hiO
 ZPqehV0LY5MD0OBepZ2sNaUUtkWmfWewVs298akda/ZZyVvw9hvwuAKl0dbnjVu0BEfJ
 RxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778830; x=1690370830;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tLujOKsXlm9KHQ1LLzZ/KxxngZ83aAuPeNX0wQ4oF3o=;
 b=ZQkYeJmMsKm1NIgMHSV8eSchiX8An+eM2GLrBkb/qksN6xHhP95il9kE54j690oOfO
 KlO32nD22c97XemZ/4djE+4SMMbpAtMVUAT+J3NEoo6qCo/GSPhgqAOBzJZ8mm29gknc
 7dq1lkwkCDjMXWdBQmDVXlA1VViWGP1Wgr8o7exn9ziA+IQgfd4E8OpldLMvdr+nCUgz
 oOoFddTpQxRRvQBUoKdMUTkHKNfJxysR+rMKGpXyE0MsjIbYVgKetUdENToqtW/BLqSN
 /VC5knJ6JecNWuHSyupIwYMtwZDmcX85qktxlRgykPHlNpUqhDcU5F5UutQW7gt2g24W
 7qng==
X-Gm-Message-State: AC+VfDwwOKxZT5qffWP9deTAOYN8/Wvb8MD1ZfK6P8pQ8df6nA3muWsQ
 T8BbgSLyx/aAAk1nomdtSHx7dw==
X-Google-Smtp-Source: ACHHUZ6+h5mzA2e/z8p+aaOWs27g+a/oBwvzXEEnoK6TmXQInB4g41eLSfAeXh/8beQWvFbCxK+Bcg==
X-Received: by 2002:a05:600c:28e:b0:3fa:8aed:d57f with SMTP id
 14-20020a05600c028e00b003fa8aedd57fmr5063495wmk.24.1687778830614; 
 Mon, 26 Jun 2023 04:27:10 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.226])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a1c4c0c000000b003fa9554fb30sm3031859wmf.44.2023.06.26.04.27.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 04:27:10 -0700 (PDT)
Message-ID: <deda3e29-654a-5a60-98bf-b97b0ada570e@linaro.org>
Date: Mon, 26 Jun 2023 13:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Content-Language: en-US
To: Yifei Jiang <jiangyifei@huawei.com>, Mingwang Li <limingwang@huawei.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Anup Patel <anup@brainfault.org>
Cc: qemu-riscv <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Subject: Is it possible to boot a riscv32 guest on riscv64 host using KVM?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi,

I'm working on a tree-wide accelerator refactor and want
to run various configs to be sure I didn't broke anything.

QEMU theoretically supports running a riscv32 guest using
KVM on a riscv64 host, however the documentation I'm finding
only refers to riscv64 guests:
https://github.com/kvm-riscv/howto/wiki

So I wonder, is this a valid / supported config? If so,
do you mind helping me with pointing me to a guest image
and its command line?

Thanks,

Phil.

