Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5D1752C40
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:37:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3z7-0007dR-L9; Thu, 13 Jul 2023 17:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qK3z5-0007d7-RP
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:36:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qK3yz-0001Nu-Lu
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:36:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so10021705e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689284176; x=1691876176;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8xMv+ia7NSDF7Ahfzb6VfdV2Jbopnergz0f/S4Nj7RY=;
 b=jdzN1smzBv53g3r9qZMd0ruuaHNw3zQqRQuGNy87vZ49fxzhDnRMX6iGO7n7xEaocJ
 5dd1gQA+VO/GwQTTrkct+F/E93fr0n73GO58KE/WkkPKmQFZxnsmkBNTtU4MOQhcwT82
 Lbm9xTQAP6hR6Hdq8OyU9yl5Hw7aQkwSdtkRsZbVcThM05rZwspoNiZ6cP0eFngnADD9
 YbmOF+Hk0dYqbd7Q1R03IbcAQYlLWUf2u4ubroz1VpYedYGpwKxx1UNXJRRIpYVqhwIj
 QfNz4x5fUsUb2k8B1Fll7qRjXHox3gdUxrUIc/rwSMiD4aELPVAPRmKdkiM91jHQsECL
 SOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689284176; x=1691876176;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8xMv+ia7NSDF7Ahfzb6VfdV2Jbopnergz0f/S4Nj7RY=;
 b=ILZ01iM2UA5LDa28heZ8S30e9o9zsckiF3bxeG907blb1Aw/LYomIu3T1R7jH7Ax0C
 57Vt56XI5dwHRczRN4A7qjI2v4WaKXvc/Ze8KzPkpXRzgPljithmwXH/da7LhkCtml5i
 ihYscXgqAxUwIWO4+yXbGWDcOrTtvvoz2aJU6D42erWTDzRrN619GGLkuY9T3x05HVKa
 /MzInuiU0Igz/5zlMyYteHoBy7g1H3pfiIHqMJbpHE1ngm50xAzAYAIAoSJLveBh8GEp
 oA+SakiqvvY3ngniLICUs+bvASt2W5bvAQbxMZWVNiGduoyVeoL+Fl4JgEyknnpBRmw8
 Fcyw==
X-Gm-Message-State: ABy/qLbXoJgNXQ1rqtLfCfQWqBdEdbnURYsVsZqhzRE4DFn6aVnCs/0C
 08lk9qAm/ecXQ8dNKt+hh7q0og==
X-Google-Smtp-Source: APBJJlFzJ1PSIYavYjmBnsI9TANWIDBZILuu7w/NGGY6E1rjNxUUwrL9g0T/NFt24XEFJYBQVId7mQ==
X-Received: by 2002:a7b:c412:0:b0:3fa:71db:56ff with SMTP id
 k18-20020a7bc412000000b003fa71db56ffmr2701834wmi.40.1689284175711; 
 Thu, 13 Jul 2023 14:36:15 -0700 (PDT)
Received: from [192.168.7.115] (m-109-111-99-24.andorpac.ad. [109.111.99.24])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a5d4641000000b0031434936f0dsm8967234wrs.68.2023.07.13.14.36.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 14:36:15 -0700 (PDT)
Message-ID: <c99ad0cb-a5b6-3a6b-a256-32aa9028eb2a@linaro.org>
Date: Thu, 13 Jul 2023 23:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] tcg: Use HAVE_CMPXCHG128 instead of
 CONFIG_CMPXCHG128
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20230713202327.12662-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230713202327.12662-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

Hi Richard,

On 13/7/23 22:23, Richard Henderson wrote:
> We adjust CONFIG_ATOMIC128 and CONFIG_CMPXCHG128 with
> CONFIG_ATOMIC128_OPT in atomic128.h.  It is difficult
> to tell when those changes have been applied with the
> ifdef we must use with CONFIG_CMPXCHG128.  So instead
> use HAVE_CMPXCHG128, which triggers -Werror-undef when
> the proper header has not been included.
> 
> Improves tcg_gen_atomic_cmpxchg_i128 for s390x host, which
> requires CONFIG_ATOMIC128_OPT.  Without this we fall back
> to EXCP_ATOMIC to single-step 128-bit atomics, which is
> slow enough to cause some tests to time out.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Thomas, this issue does not quite match the one you bisected, but
> other than the cmpxchg, I don't see any see any qemu_{ld,st}_i128
> being used in BootLinuxS390X.test_s390_ccw_virtio_tcg.
> 
> As far as I can see, this wasn't broken by the addition of
> CONFIG_ATOMIC128_OPT, rather that fix didn't go far enough.
> 
> Anyway, test_s390_ccw_virtio_tcg now passes in 159s on our host.

IIUC:

If we have CONFIG_ATOMIC128, we use qatomic_cmpxchg__nocheck;
else if we have CONFIG_CMPXCHG128 we use __sync_val_compare_and_swap_16;
in both cases we set HAVE_CMPXCHG128;
otherwise we can not use atomic128 cmpxchg().

(I'm trying to figure why we need both CONFIGs).

