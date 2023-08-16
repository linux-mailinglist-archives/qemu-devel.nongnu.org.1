Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A22AE77E64D
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 18:25:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWJK8-00035q-17; Wed, 16 Aug 2023 12:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWJK7-00035Z-3k
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:24:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWJK4-0005N1-VF
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:24:42 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6889078ee66so618778b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692203079; x=1692807879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s0z9lc49cWiRjqOYj3ezdgKSt2EcK8Hg5wx8IQ4VSvM=;
 b=gQrfr42/PgF8MNP6h0Yznyn94Ueoi0iYHHCb42IgYW6jBc3T4RpCB/H0C/6kHjjtCk
 XgmGFCZ4UhnT2UpcW8Aq1XLsolFqcRmf1+1BwPIwPTOC9MhP4wLU/S2u5mPZD6PipOPb
 muKk4IEtNt4BmRiG4ZMJz11jC0bKA9nrpkA3G6+I6xDkgjpbH9Y8uclqiF51uloMgKAE
 aNrdquJ2jZGTrQtP/PIOK06fUpu/Z+0XJEeQoo5nskiF23SSA4eO/p/tVh+B+8Zv8jVR
 N3f+00pozLuh4QoX41CTf+n0trXS2pcrf+OF74MI7BGqw2bA0GDXJ+DXCSDWVtVg+bpo
 sMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692203079; x=1692807879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s0z9lc49cWiRjqOYj3ezdgKSt2EcK8Hg5wx8IQ4VSvM=;
 b=QlKT3fQ/xiSjQcW5BHZuZEW73DSmuxCX6TMuoJCnnj5XnZxpJfo7g80KO4oUpNVs/I
 spqQc0/jq8Fav3bjB3yLHEWrUCj6RDFqtsonIzk7UxMmuI/H6kI1vsoEId2jzqzbyGwq
 00L2cICTEwIdWKiD9JPQ1T03KVzfem3rM5yv85vGw/SnEpN6UqoNLZ0gT3NBiix49G5c
 /fkyHhxEVomcI+2Lm7pa4Igb7vIH1tM9DReGAAi8S9QsiWic5NLAooaAW425pCtKYAR4
 XLKVm8OGbTlFQ54kPqtrhGCUyejTGB6yTKllFbIP08DjcRskxjwVvBPy65RTbQVmoX29
 be+g==
X-Gm-Message-State: AOJu0Yyh7d9v+gT2Yzta76uu0OC2yd6eZpMX/Mye5fhMPVg9EOuKu+bQ
 LcGOMOZzDq4PR7tl4A9eeybmDg==
X-Google-Smtp-Source: AGHT+IFNb/EB6hauaj8j9wrG0NXILQJH9Rh6QHtp8meosLFSq0RUTGUXak+nSzPrgU4B1+C2I5FAcw==
X-Received: by 2002:a05:6a21:789b:b0:141:d594:c85d with SMTP id
 bf27-20020a056a21789b00b00141d594c85dmr3080414pzc.0.1692203079318; 
 Wed, 16 Aug 2023 09:24:39 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:a064:e3f9:a812:973b?
 ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a656a83000000b0054fa8539681sm11201398pgu.34.2023.08.16.09.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 09:24:38 -0700 (PDT)
Message-ID: <c7cf144b-b9cc-8d70-e8c5-a96c6533b4e7@linaro.org>
Date: Wed, 16 Aug 2023 09:24:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 09/25] target/ppc: Use GDBFeature for dynamic XML
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20230816145155.21049-1-akihiko.odaki@daynix.com>
 <20230816145155.21049-10-akihiko.odaki@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230816145155.21049-10-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 8/16/23 07:51, Akihiko Odaki wrote:
> In preparation for a change to use GDBFeature as a parameter of
> gdb_register_coprocessor(), convert the internal representation of
> dynamic feature from plain XML to GDBFeature.
> 
> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
> ---
>   target/ppc/cpu-qom.h  |  3 +--
>   target/ppc/cpu.h      |  2 +-
>   target/ppc/cpu_init.c |  2 +-
>   target/ppc/gdbstub.c  | 45 ++++++++++++++-----------------------------
>   4 files changed, 17 insertions(+), 35 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

