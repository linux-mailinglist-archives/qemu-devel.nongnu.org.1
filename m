Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C53397CD7CE
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:23:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt2l5-0004XT-Fj; Wed, 18 Oct 2023 05:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt2kk-0004Uy-D9
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:22:11 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt2ki-00076D-QU
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:22:10 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53e84912038so6177377a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697620926; x=1698225726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NXpq5twkhkVtITAA0lmpSh3SnangYX1AgL0ZDdqXMw4=;
 b=eHf+0EnTSXpPpyjbSdCygXuVWzOmNep/pd+nFB8+ct1YndRwUtprgABBLWHcV5EuDW
 C7fQxUT+66SVJaK2+1z1zroCEJ5LsAVEqtqoFrS8C3Ik9/gtShMQs5TO18WJOjYDrWV6
 J6kps9dLniZ6xgW1LNzgYZQ1AhIvEOnGdWD5HvzcroiZMAnE3ptAN1fvZu0rzFOjEToT
 XSMj7hj57FvVEsfmcMWpC/wESu1GFMqeQaDFjMDue4Nv5SnSFLS1Kgk8L0mdBO/Orgzf
 pGL9YZz60t3TQlyWzp36G7lf+/SgVIUCQ2gqcf/aycBGq6D9ot+zSGEP72XezucAUgyD
 nURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697620926; x=1698225726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NXpq5twkhkVtITAA0lmpSh3SnangYX1AgL0ZDdqXMw4=;
 b=jSfd3OCBjNE+DnoigX3JTxCFgskPWSf0DgmrGmcq3qlVAaMYf0Wo7c9I8Sj3Fo+IXB
 uEvlbfgYuvySHByrs1HeHv41Oqgo9/qPVzqYxZdEI550HeeGr5Y5B05zQTMhad/ZwMMv
 38VZzO+dZvB1EciXbSPpkgilOjg8XeOSEkGZL66LSndhMbKVwASqXp95gYB+gPkLIajt
 eTcpthSGLcNmLdKl856aFKrCDGLPoKEtKTpgzFfoUbno+eJN3l+4ygrLB6JqfCEMiQ5s
 sjUyv97pMkfWnv/LvDmou1Q1qDe9GgmUHiIJf+VePvHeEnbptORLAMsMaToq+TlEkl6u
 bKMQ==
X-Gm-Message-State: AOJu0YwW6be77WGkaQeffFJgZ+/wj69XrQaNUVEht6sZISoFRxO4RGJE
 MGGinp3yS+6A7taaDXCVavv6bQ==
X-Google-Smtp-Source: AGHT+IEexXIW8fwb9DRJKcuQOXDqNogjyJ6S8+7yVHRrXNlU+f2VM4ueyxbks2zFDw3ePepQrhg7Ug==
X-Received: by 2002:a17:907:80b:b0:9af:9c4f:b579 with SMTP id
 wv11-20020a170907080b00b009af9c4fb579mr3302761ejb.18.1697620926260; 
 Wed, 18 Oct 2023 02:22:06 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 mc8-20020a170906eb4800b009737b8d47b6sm1228593ejb.203.2023.10.18.02.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 02:22:05 -0700 (PDT)
Message-ID: <dd146c6b-7c4b-fb43-5e28-b53b00adc102@linaro.org>
Date: Wed, 18 Oct 2023 11:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 08/11] hw/net/cadence_gem: use FIELD to describe DESCONF6
 register fields
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
 <20231017194422.4124691-9-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017194422.4124691-9-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 17/10/23 21:44, Luc Michel wrote:
> Use the FIELD macro to describe the DESCONF6 register fields.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   hw/net/cadence_gem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


