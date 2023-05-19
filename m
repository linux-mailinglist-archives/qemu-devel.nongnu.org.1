Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A9F709BB7
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:54:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q02Pz-0001je-FK; Fri, 19 May 2023 11:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q02Pw-0001iZ-NQ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:53:20 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q02Pu-0002PH-VT
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:53:20 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64354231003so760458b3a.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684511597; x=1687103597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OITtHFAz9Qp5eoexjjo5wGhf3/OmTAOXK+xiIg9FHxY=;
 b=hwyZR5z/7BjOhMfsKhe7r2Vnm4I+pIt8zmTgxCCnMwrFLIUNimSmgHFnWmFs3oS+PW
 0X8s1kvhrauBxzOfArLr0A8JxyvfgQgqDk+bdhWrH3XukWr+Zyn3tr46ypEtiPxk0nAR
 KMNbHtVlXemTkSyckNcsOiDInXkTZYcVVCzdYxspIAbjmuQnVVL6orIXuS33ugs//ofM
 t3OhGPloII2pb/xo3EVBVJq2tOTtip80jiscamnlhEDlomVLbYSB7FCoZ36Le54wCbIZ
 9ciD2emr6SEWOVPDdDS4bKiAYk2b4IT0l/D8RCpLiV+MeWdwN2hDOeGwYXNzYHyLLSU9
 LaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684511597; x=1687103597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OITtHFAz9Qp5eoexjjo5wGhf3/OmTAOXK+xiIg9FHxY=;
 b=TzgejmAdMibHzsaUDkcBMLJfUXYdzzJE7vYIgj7AvCBTf3x7Exmw9wzv/LE3DguJNu
 0DHuJOE38/2EyKl5N4EweesdZbEbAwglDvvx5ZG7igyKkbwvzRv0jhDR2srwaCsf9R5V
 UKF7bvbm50Atx6/iQU4nrsQWSJtGzx1RBqaGtVV9uhMZLL4z59BNRW/NQUpKHU2e0+nU
 dDX+wxDFKeLbzmOVW7MFgMTLP1g9/9mmJCraYABV4m9RQhH9mdzc/BfFrb4oRxvIYP0O
 zdLFLhAVtjqxtTo9EKqpeO/ktnXBsHFJP5mfBAk/CUEQFBw7s0aEYqRXtXfvDre/v43S
 lr1Q==
X-Gm-Message-State: AC+VfDwJhsKZHI85ReR/faBE8yhDXaJxUW0QaSpr8ozUFpDm7erYqr77
 euE41BVvwwI2FAG0m4uH5m2XKw==
X-Google-Smtp-Source: ACHHUZ69XY7k8LHpKVSlWEE35BbRIbWR99NmFRFDNGN828gk+Az0bWfvrbf6TZH23LQo/p84eYaNHw==
X-Received: by 2002:a05:6a00:290a:b0:643:4608:7c2d with SMTP id
 cg10-20020a056a00290a00b0064346087c2dmr6672367pfb.12.1684511597590; 
 Fri, 19 May 2023 08:53:17 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:686f:d1bb:8fc4:dc38?
 ([2602:ae:1598:4c01:686f:d1bb:8fc4:dc38])
 by smtp.gmail.com with ESMTPSA id
 j15-20020aa7800f000000b00646ebc77b1fsm3179434pfi.75.2023.05.19.08.53.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:53:17 -0700 (PDT)
Message-ID: <7230d02b-e9f9-aa1b-3aa8-67aec82494a7@linaro.org>
Date: Fri, 19 May 2023 08:53:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v2 00/21] Block layer patches
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20230519105013.217914-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230519105013.217914-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

On 5/19/23 03:50, Kevin Wolf wrote:
> The following changes since commit 6972ef1440a9d685482d78672620a7482f2bd09a:
> 
>    Merge tag 'pull-tcg-20230516-3' of https://gitlab.com/rth7680/qemu into staging (2023-05-16 21:30:27 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to c1bc2467c25ae2b846eeb5d338d1c697c6f83833:
> 
>    iotests: Test commit with iothreads and ongoing I/O (2023-05-19 11:32:19 +0200)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - qcow2 spec: Rename "zlib" compression to "deflate"
> - Honour graph read lock even in the main thread + prerequisite fixes
> - aio-posix: do not nest poll handlers (fixes infinite recursion)
> - Refactor QMP blockdev transactions
> - graph-lock: Disable locking for now
> - iotests/245: Check if 'compress' driver is available

Build failure:

https://gitlab.com/qemu-project/qemu/-/jobs/4316574356#L3199


../block/graph-lock.c: In function ‘assert_bdrv_graph_readable’:
../block/graph-lock.c:278:37: error: implicit declaration of function ‘reader_count’ 
[-Werror=implicit-function-declaration]
   278 |     assert(qemu_in_main_thread() || reader_count());
       |                                     ^~~~~~~~~~~~
../block/graph-lock.c:278:37: error: nested extern declaration of ‘reader_count’ 
[-Werror=nested-externs]


r~


