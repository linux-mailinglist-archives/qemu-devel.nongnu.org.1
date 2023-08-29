Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8EC78D01E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:15:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mu-0000iq-Nl; Tue, 29 Aug 2023 19:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3kt-00055M-NS
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:47:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb3kr-0002lO-Cl
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:47:59 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c0d5b16aacso27960515ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 11:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693334876; x=1693939676;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1NeH6SMdPMzrgM9IKa1DVjOKT9S6QnX0o/KZBRo67xQ=;
 b=TQTQP1+s6WTODQLnNxxLxwn7NnMDGAR9tW1p1CGY2wFFjYyzx9rLPQwU/hbMn2FsU3
 CHX9gh+qmAvgfTjx7zzv0tPkcpSAixkQHlCS2BXtyucbFMv5Map9pXb3UzsntTLXlKZo
 7WuDK+6/svwGU74Xj842gB4QHWMoJkO4/mAaJe5R5fUG/4StfHnfaka4E9j0eFT8FMYm
 mMvbAKk7hmmjSDVqjrrilytRGrYYScuAy67dxV7t03u+dXzvj9lVQDvuawMK06MGHn1c
 9580Nz7HvbAtPj9r08twRS/ElFicSUnWpsdA+9OCHFGYIOYce+8+tog4JoKlCvoMM9nB
 QAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693334876; x=1693939676;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1NeH6SMdPMzrgM9IKa1DVjOKT9S6QnX0o/KZBRo67xQ=;
 b=iKtDqkd2u7ZpCWmrrQHbVEvg7FkM1Re2jt9ItP19dNDQlrpynbP5w533HbaMsfSL1T
 HfFBtu9WrPsH4MUoLKU/8orDVoQRhAxhfhHW1Ow+lOMwa9Qc7lJy1q47WQ/n0M2fEFId
 XNzJyXe1JnVZfUTuH337Cv+ubAeS4LNgm24xVYqQ5HJdwk8GZZvDTK+1ECZtnRZTpnQy
 vZoL230sxsnIaz9jr5gYsQFNdKiF9RuFX6fCEWipRiQzBJ7ty/eAlXo0+OW9OiYDZQWG
 xCnLhMNbIHeI8Dn0H79sAprV68WMD22OXyN9wO3VTjMLWvuZzYu2pbpA2eOaM0rNJWfD
 i2bw==
X-Gm-Message-State: AOJu0YzNedodQn/epLcqirBcY0MBQj4ikkCKVZTWYp67YUZ6XX0qSqSd
 kLQQp5wUSHfE5Z93WNCumYwpK9FrXH7njy52/Kk=
X-Google-Smtp-Source: AGHT+IGOFX8FZAocQNub9M0sVO1hnpaS3m9gpUBqEDaauflS7HTggn4IEOjUsgD0nSHT6ntVSZZ/4w==
X-Received: by 2002:a17:902:ec83:b0:1c0:d17a:bfe9 with SMTP id
 x3-20020a170902ec8300b001c0d17abfe9mr15451114plg.46.1693334875872; 
 Tue, 29 Aug 2023 11:47:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a170902ee8a00b001bb9883714dsm9661821pld.143.2023.08.29.11.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 11:47:55 -0700 (PDT)
Message-ID: <94395691-6fff-e973-d48b-f276fe758c7f@linaro.org>
Date: Tue, 29 Aug 2023 11:47:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/10] meson: compile bundled device trees
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-6-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230829082931.67601-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 8/29/23 01:29, Paolo Bonzini wrote:
> If dtc is available, compile the .dts files in the pc-bios directory
> instead of using the precompiled binaries.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   pc-bios/Makefile    | 19 -------------------
>   pc-bios/meson.build | 25 +++++++++++++++++++++----
>   2 files changed, 21 insertions(+), 23 deletions(-)
>   delete mode 100644 pc-bios/Makefile

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

