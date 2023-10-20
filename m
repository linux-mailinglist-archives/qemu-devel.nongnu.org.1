Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 067307D208F
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 03:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quMs9-0000ZE-Dn; Sat, 21 Oct 2023 21:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quMs6-0000PS-O0
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 21:03:14 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quMs5-0006ky-2K
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 21:03:14 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9e072472bso13176765ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 18:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697936591; x=1698541391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ohZho2OXubKsrxSmJRncIJsie51PfO2xP60hSp8Ncbw=;
 b=gtV7eS+9Ps5OKQ3lBAO1yH0idQqkxaTnntII3gQqHKZpQeOchIwFvme6drpemYB7Xy
 lrjupAMnQIaCg/qOPvTd9TA5op3l863gEM8R3toqIjwPbmyPMTiow3qpVCpv6v5niGCy
 SmuiZ0L+ns2gNofTVekrsWBv3SiM0pX7qBckXyfwgjh54FRpRsVCXw6w01+NS8iCQGjV
 JPmk+yslk8LDLCDIvMmmVKHItFcZv3zyWJntAnjjHmspqBSgkJWhBUgLbOg57xd1hdns
 YBxPJ/XiwgjpyU7OldXqNKpLfzZQ6sAXZ64o7CstYtg06QXCTmdBfhY4gHh+HoDJvmNL
 BPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697936591; x=1698541391;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ohZho2OXubKsrxSmJRncIJsie51PfO2xP60hSp8Ncbw=;
 b=ZH6n6/lXcUsCFXdUWKbWPOSJTA+nBH8oTLpbhlZdDyRlztcZE65E98v1SwfHh95Jbg
 kll1OcqBKI20PgZvYQw+VH8/et9eY0OvGH1wW+1qitC/h3RmE1GJVgpXUcGU5fElEmYT
 v3O11wlRmaFM8Ywdm+ziL1P5Qt8vtaqRBJtXifT/hypAF3rr9gx9b2Ck47kUkRRsKnQD
 yCpTESgknezX0MNQ7Ks1YeNljsDbFIV1Bmx1PldWpxlZ/XsXCRumMagv8XZJLj/z+DR5
 vZbj5XUKgoduYf4qnm2ppD+BZSgq0mtHuf8cGBF0Y+z6KpvXj377kVbZVMVlJTcHmFvz
 Vl0w==
X-Gm-Message-State: AOJu0Yww9E9tG5VZ5jGmDLCEnOaAhQla5ArnCarGe2uFRpvk7HYa2hM0
 lu1ylXaFmyZtiXThZ2BXhUBNDQ==
X-Google-Smtp-Source: AGHT+IFvqrIPnJncCNBPD6boB31h/hE1STu1WvXgf7hBs+3jJxFmJDnwZmaOafMdWa7TYf8F2EEPQA==
X-Received: by 2002:a17:902:e402:b0:1c9:ca02:645c with SMTP id
 m2-20020a170902e40200b001c9ca02645cmr3444877ple.36.1697936591303; 
 Sat, 21 Oct 2023 18:03:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jb14-20020a170903258e00b001bc21222e34sm3704336plb.285.2023.10.21.18.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Oct 2023 18:03:10 -0700 (PDT)
Message-ID: <63a90f1f-5db4-44df-abce-8ebe6a404076@linaro.org>
Date: Fri, 20 Oct 2023 12:06:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Allow user enable/disable LSX/LASX
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, peter.maydell@linaro.org, eblake@redhat.com,
 armbru@redhat.com, maobibo@loongson.cn
References: <20231020084925.3457084-1-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231020084925.3457084-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/20/23 01:49, Song Gao wrote:
> Hi,
> 
> This series adds the cpu model 'max' support. and allow users
> enable/disable LSX/LASX features.
> 
> V3:
> - Remove patch 2, add cpu feature flags;
> - Remove unused code has_lsx, has_lasx.
> 
> V2:
> - Use qapi type OnOffAuto;
> - Add patch2, add cpu feature flags;
> - patch4: show more query results.
> 
> 
> Song Gao (3):
>    target/loongarch: Add cpu model 'max'
>    target/loongarch: Allow user enable/disable LSX/LASX features
>    target/loongarch: Implement query-cpu-model-expansion
> 
>   qapi/machine-target.json              |  6 ++-
>   target/loongarch/cpu.c                | 74 +++++++++++++++++++++++++++
>   target/loongarch/cpu.h                |  2 +
>   target/loongarch/loongarch-qmp-cmds.c | 64 +++++++++++++++++++++++
>   4 files changed, 144 insertions(+), 2 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

