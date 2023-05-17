Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 270E37072B0
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 22:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzNLO-0002DB-HR; Wed, 17 May 2023 16:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzNLL-0002Cz-2B
 for qemu-devel@nongnu.org; Wed, 17 May 2023 16:01:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzNLJ-0001hB-FM
 for qemu-devel@nongnu.org; Wed, 17 May 2023 16:01:50 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ae3f6e5d70so12534715ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 13:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684353708; x=1686945708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jN5+Y5fxZNwxa6yUSpNerTayb6FUNpIPtV628duKnK4=;
 b=mq6xMkKqC5nKGjCDfvvQu63uKxklDgRQIw10H7KSqjM4VMleOJF3kPQdBLSWYq09Gv
 6TPtWaoiJQRH11csNc90MUIUTQqgc+7Jc+v6Prdx2NoqIyahBfHyIn82JTOxMCS5ktfe
 9JS2+2VEjVml/wr9mhbzlQsz5O+WmhzkEVPjC9C1JdWji7tBADx+/VeX4aGseXqYNYfg
 SbGQSFGlhrjHUJAYFCzDAiN5fuED4Wtv8+rNP15DYSyB4BlnIdH+NVLhKOWIxdT4LZYu
 cy8wanPdKzd8wjPwv0NpwD+QJit9QZL2Mj+zdSiiGF3Sv3/Wuk/SdQYvfoAJt8tV8OK1
 DjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684353708; x=1686945708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jN5+Y5fxZNwxa6yUSpNerTayb6FUNpIPtV628duKnK4=;
 b=Yuvm/axOcUUu2tC+Fo6DKtMqidMbeXwD7STwRAsc8WdG42TdsMqHndvhAhGoSgzS8L
 8/kN2iWN1SBJKjBlu+HOpew9fxubA587g7GST9NWdvlkg6Q7uy+6y4SgUfhh63eFAQdC
 5MGBlRsbbLLpcLCq6dHqprchLW1KnU6Qim39C7QynTfvex2/QBPvG592gDXeA8CYC6Ds
 zIJ939LFQ8yffYD3F3Zzn2f36QQFVojv4GiPcoEh0+c/bvqfQUTh0XPOhP6Cvvb9AQW9
 5fPq7WJpTQi6RMPt583JoOjNRSUXfo0DhD5qP0jV09BV1eYcwNRG/IGYhJCz0AAdAmUL
 WLxg==
X-Gm-Message-State: AC+VfDyjd18GA+l6/1rFdTa1AOShu5SIFn7VrlZwPHiaaiv4HGkOMlB6
 +9SPE63OHTWIhCN5K8bG1oc/RQ==
X-Google-Smtp-Source: ACHHUZ5dBAgayujVrhRc/RuIwcvEKhITQJCR8hmpNDPTZWK0YBC6IJo8n7RWGU5De1zAKktOAVzJ4w==
X-Received: by 2002:a17:902:d2c5:b0:1ae:2e0e:dfcf with SMTP id
 n5-20020a170902d2c500b001ae2e0edfcfmr59559plc.2.1684353707758; 
 Wed, 17 May 2023 13:01:47 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7?
 ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a17090341d000b001a98f064a2asm18054619ple.48.2023.05.17.13.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 13:01:47 -0700 (PDT)
Message-ID: <a51de44e-1261-fea1-b1fa-085db6b76b6b@linaro.org>
Date: Wed, 17 May 2023 13:01:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/5] gitlab: centralize the container tag name
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Beraldo Leal <bleal@redhat.com>
References: <20230517135448.262483-1-berrange@redhat.com>
 <20230517135448.262483-2-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230517135448.262483-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.412,
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

On 5/17/23 06:54, Daniel P. Berrangé wrote:
> We use a fixed container tag of 'latest' so that contributors' forks
> don't end up with an ever growing number of containers as they work
> on throwaway feature branches.
> 
> This fixed tag causes problems running CI upstream in stable staging
> branches, however, because the stable staging branch will publish old
> container content that clashes with that needed by primary staging
> branch. This makes it impossible to reliably run CI pipelines in
> parallel in upstream for different staging branches.
> 
> This introduces $QEMU_CI_CONTAINER_TAG global variable as a way to
> change which tag container publishing uses. Initially it can be set
> by contributors as a git push option if they want to override the
> default use of 'latest' eg
> 
>    git push gitlab <branch> -o ci.variable=QEMU_CONTAINER_TAG=fish
> 
> this is useful if contributors need to run pipelines for different
> branches concurrently in their forks.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   .gitlab-ci.d/base.yml                | 6 ++++++
>   .gitlab-ci.d/buildtest-template.yml  | 4 ++--
>   .gitlab-ci.d/buildtest.yml           | 4 ++--
>   .gitlab-ci.d/container-template.yml  | 3 ++-
>   .gitlab-ci.d/crossbuild-template.yml | 6 +++---
>   .gitlab-ci.d/static_checks.yml       | 4 ++--
>   docs/devel/ci-jobs.rst.inc           | 5 +++++
>   7 files changed, 22 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

