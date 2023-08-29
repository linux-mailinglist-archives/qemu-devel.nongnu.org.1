Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7CB78D011
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:13:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7my-0000kz-5O; Tue, 29 Aug 2023 19:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3RP-0005ho-La
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:27:53 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3RL-0005oA-M8
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:27:51 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6beff322a97so2507151a34.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693333666; x=1693938466;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DOjnzNcWfYQY67RvXQBYVGXPPMVts8+e0vxXVWCbJRk=;
 b=py3vaPYhhPdyPX3Zj2CCdldX5w6TsOhIsYNEFd5AFNJmWs76sX+D89WBFXwYk6Vmx1
 FT1rWT5SdNdhRtl8ewZBp0jnmBzq146yYr+e9Hkxd3+OcrOjlIxJn0NvYfNC5U+nZhS6
 nuMdwWoadtAnm6/wCorIjLmPO+toYCHIXnfe5cao4p8Ajm1M7ynaofMm+N8lIo8sLhP/
 JefmVUBQPvmfeDh1AyC/feXlJByP6RZ4mjVsd+/NdVx39iqCi3v9E6U307OIv6sQvROJ
 F47oI+2Js0DqcNFGBEYUpTkVi46fCoY9CWi4cPfVaPn6X8cLcQIGgjRWKxqPoqV8ihbu
 7lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693333666; x=1693938466;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DOjnzNcWfYQY67RvXQBYVGXPPMVts8+e0vxXVWCbJRk=;
 b=cQH+gORw0jEb5tFdYY4ec6FNTCbhb137dy8zOZZ5v0C/5SE3xQpbswXQ9bzy1FMe8F
 K5smPNYrI5shXtXBErJiXjkR5hHoqTLyQSY3qwX6wLhKhncB0oxaJ49RSPF0cuO2oziw
 4jYiomP+Q+pKyyqgwZ40VENL6f47TCcmRW3keS8VglH8Ur7LcXoNJoxBjc1945GjyhHM
 MOIivWCC3cIkMHhUv3P6Hyoew06Y27dQnY4QWdt1pmA1x1ggClj/OhduiuifC68Rb3ze
 KgJwLDreX0lFi8/R9Y62jyJBdRfRXPCr+/vDDgc4b/R3zWK/7S4Nxtf0hluMKIHZe3YA
 IzCA==
X-Gm-Message-State: AOJu0YwgI7k1kKnrL+oJBmpTNaNifQInrVnWem5UgDQaIHYJxhy+gPGb
 QGQx6wz1ZVB8l/pfjPGHom2VQpEjm3CyoyNJNDk=
X-Google-Smtp-Source: AGHT+IGXgUXOVNZBtazCOhu3QUoRY1zqRo91VcyP2i4F3CL08mf069ToES9rKJhBXpA7cBci31yZ2g==
X-Received: by 2002:a05:6830:1d3:b0:6b7:30cc:6419 with SMTP id
 r19-20020a05683001d300b006b730cc6419mr17486430ota.1.1693333666317; 
 Tue, 29 Aug 2023 11:27:46 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a63b552000000b005501b24b1c9sm9269941pgo.62.2023.08.29.11.27.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 11:27:45 -0700 (PDT)
Message-ID: <6ab08395-e290-8d76-c653-2685611d7b25@linaro.org>
Date: Tue, 29 Aug 2023 11:27:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/4] tcg patch queue
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230829170240.765996-1-richard.henderson@linaro.org>
In-Reply-To: <20230829170240.765996-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/29/23 10:02, Richard Henderson wrote:
> The following changes since commit 813bac3d8d70d85cb7835f7945eb9eed84c2d8d0:
> 
>    Merge tag '2023q3-bsd-user-pull-request' of https://gitlab.com/bsdimp/qemu into staging (2023-08-29 08:58:00 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230829
> 
> for you to fetch changes up to dad2f2f5afbaf58d6056f31dfd4b9edd0854b8ab:
> 
>    tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32 (2023-08-29 09:57:39 -0700)
> 
> ----------------------------------------------------------------
> softmmu: Use async_run_on_cpu in tcg_commit
> tcg: Remove vecop_list check from tcg_gen_not_vec
> tcg/sparc64: Disable TCG_TARGET_HAS_extr_i64_i32
> 

Disregard this PR.  I will re-issue with the abi_ptr change reverted.


r~

