Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3A373B043
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 07:46:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCZcI-0007J4-1n; Fri, 23 Jun 2023 01:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCZcF-0007Ih-QG
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:45:51 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCZcE-0007pD-1D
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:45:51 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3129c55e1d1so322402f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 22:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687499148; x=1690091148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lOHIrqwf/uq+ncpJU5UNM1w5gySLrcSK5TWh+825C0o=;
 b=kKNM/9IuYF3SR+A+6JJj+ybtL7wKhlkasr+KngyniHOE+VWucdy3i2z6GXf5aV65Kt
 9Vc7msVy0flqV24j375hfmDUt3FXUqkz8hpf0W9hqkYj3QhB1ujpwcupip6p6SwPuDpL
 mpw28GfFaj5Or4GX/atiEXcVdTdOosqhOPtnqw1+LeNVGwNpnVyM9TCGcuGPmEFwjN/z
 Jfv9kzIkr/lTymoZvaV/SzkM1RG1EJQpKgECitEvNRe31qkGzyRFJPW+EOy7vaFJckux
 s0eqo3yivgtFexS0GBBMN7k33tTrGqNZl3VCGmaw09Fcf6L3wNbPwCawF45COIXnQ/Rd
 I0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687499148; x=1690091148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lOHIrqwf/uq+ncpJU5UNM1w5gySLrcSK5TWh+825C0o=;
 b=CQbeFU7NOh0Xwq7ZD850Y3SAEp42N/iNjViBkTm4mmtSXi8pd/hD73CGMJ2UtwiRBg
 HRkP+E4uJX8DNUfbNqxN7C4DPlbV3BsDzR3ELIIx7S1D9MyNO1akJqL6DKjRZ2HMfIOW
 6/P1FjFgDr4ek53xUb0JcqDaVZp4aU8YTKhTDPIY6PJ31CyA2i9Dqt5iPYed+8YAAP0e
 8mIs+NGgcnqFY4d6hYDjVqa3woqhZBIIyC2Uhwu9UKqJPuNJ1fpw1m7tx0QUxESW9ZM+
 it1jvkdx0tMU/MmSDsbNcG5L0r0fnLmZ98NkwtiImqL38G/4LL08AY1jqSdOxf0/3Uhf
 qa1w==
X-Gm-Message-State: AC+VfDwxovsstltCUJE8Q6lHzPqgI14aAuEM/Chh0VNsIAMHAe4RLdhy
 CKqcIULWTkesogbHIfn0jZJbQw==
X-Google-Smtp-Source: ACHHUZ4/ftCSnrkSDX3QRtj+UDEmK3AC5GOFYwCv+ekFY405P4AuSwPgU138R+1hqhWV67Oypbj/Zw==
X-Received: by 2002:adf:d08f:0:b0:30f:bbec:216b with SMTP id
 y15-20020adfd08f000000b0030fbbec216bmr16133460wrh.65.1687499148417; 
 Thu, 22 Jun 2023 22:45:48 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.168.147])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a5d56c9000000b0030fb4b55c13sm8555413wrw.96.2023.06.22.22.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 22:45:48 -0700 (PDT)
Message-ID: <1f5c4a38-6ae2-53dd-d739-65accb1d86a8@linaro.org>
Date: Fri, 23 Jun 2023 07:45:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/30] Next patches
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
References: <20230622165527.2417-1-quintela@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230622165527.2417-1-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/22/23 18:54, Juan Quintela wrote:
> The following changes since commit b455ce4c2f300c8ba47cba7232dd03261368a4cb:
> 
>    Merge tag 'q800-for-8.1-pull-request' ofhttps://github.com/vivier/qemu-m68k  into staging (2023-06-22 10:18:32 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/juan.quintela/qemu.git  tags/next-pull-request
> 
> for you to fetch changes up to 23e4307eadc1497bd0a11ca91041768f15963b68:
> 
>    migration/rdma: Split qemu_fopen_rdma() into input/output functions (2023-06-22 18:11:58 +0200)
> 
> ----------------------------------------------------------------
> Migration Pull request (20230621) take 2
> 
> In this pull request the only change is fixing 32 bits complitaion issue.
> 
> Please apply.
> 
> [take 1]
> - fix for multifd thread creation (fabiano)
> - dirtylimity (hyman)
>    * migration-test will go on next PULL request, as it has failures.
> - Improve error description (tejus)
> - improve -incoming and set parameters before calling incoming (wei)
> - migration atomic counters reviewed patches (quintela)
> - migration-test refacttoring reviewed (quintela)

New failure with check-cfi-x86_64:

https://gitlab.com/qemu-project/qemu/-/jobs/4527202764#L188

/builds/qemu-project/qemu/build/pyvenv/bin/meson test  --no-rebuild -t 0  --num-processes 
1 --print-errorlogs
   1/350 qemu:qtest+qtest-x86_64 / qtest-x86_64/qom-test               OK 
6.55s   8 subtests passed
▶   2/350 ERROR:../tests/qtest/migration-test.c:320:check_guests_ram: assertion failed: 
(bad == 0) ERROR
   2/350 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test         ERROR 
151.99s   killed by signal 6 SIGABRT
 >>> G_TEST_DBUS_DAEMON=/builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh 
MALLOC_PERTURB_=3 QTEST_QEMU_IMG=./qemu-img 
QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon 
QTEST_QEMU_BINARY=./qemu-system-x86_64 
/builds/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
stderr:
qemu-system-x86_64: Unable to read from socket: Connection reset by peer
Memory content inconsistency at 4f65000 first_byte = 30 last_byte = 2f current = 88 
hit_edge = 1
**
ERROR:../tests/qtest/migration-test.c:320:check_guests_ram: assertion failed: (bad == 0)

(test program exited with status code -6)
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――


r~

