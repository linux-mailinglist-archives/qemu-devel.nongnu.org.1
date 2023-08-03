Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EF376F5CF
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:45:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRh3d-0005zi-Dm; Thu, 03 Aug 2023 18:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRh3b-0005yo-NF
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:44:35 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRh3Z-000196-Kt
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:44:35 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-686e0213c0bso1097674b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691102672; x=1691707472;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1HZTpZKB+njwBy9bHkA1xM0PwH+Ekju32ieMf9j6HL4=;
 b=NG8OTfXO0j9zjcT1qTYwMoKRUUXTrpHkEkyqfiTW3cL/GSYYWTmXHs15u9RXQ2xJXE
 wsPQb96vINkuDC3dI70tCXFvS6LuWU/JPcBLbUQTFxnToxTtDK61CeOgtLPkdhesxBDa
 ua1uagUtJRInkr+adMQpssIiE5H/UarlH7+w8itIztKp10kMg8AORHxSo/2otZXJVUo4
 4aKQN0R61nhN/KIKwKMLT8pXsOSX64azlMISgKWM6YTVkZAhbaoOxYiJUWIEc0DMFD2o
 V42SBzWUEoF1jDXDOJGTX79siwVR/M1pGCXtuk0hjCgb5t3JeLw0VAxhCn3VSp+8XrMy
 9PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691102672; x=1691707472;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1HZTpZKB+njwBy9bHkA1xM0PwH+Ekju32ieMf9j6HL4=;
 b=ETyGxxhomVEiQp5Woyfuf7E0M6rc2kLee57TTl6wJeANXCwDOQnjnVIfRW9RtHrviR
 4hW2rpP2tejqoqkaSPFJG25fqMry0a0vDfui2yeCvYY4Aszc6HSpeI44HTEG+RSwZl12
 zofLTlPjegseCaxKg83pbUA1XtSZiTnKnKhppf80HjISbtXbVXRTaCnbqGJvL6+w6U2P
 gwEwa7byxMa45dSCzg9hsxSOiQkO6Fm+NQaYSgyjEmBF+yQGNjsILm2Ou5wyS3vNTFos
 EiKdZqLogpnhVM+c2u0GWC/Z7tgHhI96SESjGeiUM3VtRH+ZuebKwNZ+mC5RugT2OghY
 hTgw==
X-Gm-Message-State: ABy/qLapk7n2GbQBsV+bIKFEN/xGiQk+BEtxsZAubZGDgz1IJ/7a7/6+
 mxyucnUE8y+kiLWpZ9PaaXz7Qw==
X-Google-Smtp-Source: APBJJlHLOiKGAKgrCPCqKAEStPCLCM0PufQjwTheEbY+OENjpVHV3uZBDTmshhJApU08TWCjwFXpng==
X-Received: by 2002:a05:6a21:4886:b0:13d:5b70:17da with SMTP id
 av6-20020a056a21488600b0013d5b7017damr15264223pzc.26.1691102671586; 
 Thu, 03 Aug 2023 15:44:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 q24-20020a62e118000000b00679a4b56e41sm333383pfh.43.2023.08.03.15.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 15:44:31 -0700 (PDT)
Message-ID: <c39a9d14-4dfa-4c54-09c7-094ace1056b6@linaro.org>
Date: Thu, 3 Aug 2023 15:44:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/3] linux-user: Emulate /proc/cpuinfo for Alpha
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Cree <mcree@orcon.net.nz>
References: <20230803214450.647040-1-deller@gmx.de>
 <20230803214450.647040-4-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230803214450.647040-4-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/3/23 14:44, Helge Deller wrote:
> Add emulation for /proc/cpuinfo for the alpha architecture.
> 
> alpha output example:
> 
> (alpha-chroot)root@p100:/# cat /proc/cpuinfo
> cpu                     : Alpha
> cpu model               : ev67
> cpu variation           : 7
> cpu revision            : 0
> cpu serial number       : JA00000000
> system type             : QEMU
> system variation        : QEMU_v8.0.92
> system revision         : 0
> system serial number    : AY00000000
> cycle frequency [Hz]    : 250000000
> timer frequency [Hz]    : 250.00
> page size [bytes]       : 8192
> phys. address bits      : 44
> max. addr. space #      : 255
> BogoMIPS                : 2500.00
> platform string         : AlphaServer QEMU user-mode VM
> cpus detected           : 8
> cpus active             : 4
> cpu active mask         : 0000000000000095
> L1 Icache               : n/a
> L1 Dcache               : n/a
> L2 cache                : n/a
> L3 cache                : n/a
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> Cc: Michael Cree<mcree@orcon.net.nz>
> 
> v3:
> - use PRIx64 instead of casting to long long
> v2:
> - revised platform string and system variation output
> - show cpus detected/active/active mask based on
>    current physical machine configuration
> ---
>   linux-user/syscall.c | 56 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 54 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

