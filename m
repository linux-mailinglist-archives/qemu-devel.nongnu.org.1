Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B982678EDA8
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 14:52:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbh8x-0003k7-Bw; Thu, 31 Aug 2023 08:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbh8q-0003ev-Qm
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:51:22 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qbh8l-0003Ab-9l
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:51:18 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5298e43bb67so1540040a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693486273; x=1694091073; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cu7jLGG9iAfK0JBfix+6KtNfxSZg40SgX6mhS3ZdJSM=;
 b=JV14mLZ97qHZV4B9twS2eh7DdlGXvPkVoXv8s3Fog9jKv8YvakYTsqANQWjlbzT/3n
 ZIihBZLR+LibLhA2bjdFa3rar1H1N4DKDZBt7dk5GW75GiRdUE9nnVYvLOBrthn9XBnc
 UqcnUlWXyv5HGxsWlgG6f0jos0Ls3sr28fv/ZToCodGxKgK87xtt6hqpptyDMYd8ID5J
 GYK+SRC8W9/I+y0s2YPgv9Fn+xsdq4cIKYa9houckSYcoPPnwCoqAUaeuE3TEq9fNKAe
 xAukJ2XQuy92eaH+MTsEU52c3m/ISHSUvYz1YD2W1Zgue0ncvH6aVS3/fHkqDZZ40Kdh
 FLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486273; x=1694091073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cu7jLGG9iAfK0JBfix+6KtNfxSZg40SgX6mhS3ZdJSM=;
 b=mHPPRj+oV6cf/JIEdcpLDo6VEaaEcng2LnwJvjwwODEvpEr/jcSFyxrDsqNwPtynnw
 Y8NTUJgXwvUp+vr7Q5bupXBTlH7GnAWQZlaRbhr+oNn4FH1GZ2X+OeMTYuawEFPM8G3H
 2fIBRhltWsdQIyKv2JRlzu8G2/c4WeWhTUgqtX23H1usMQ5eMr0+e1FCSC0NCaORPFha
 9k8f81EdQDaJBOPrsWmYMxCnm/hYQJaqehdj90vbb9m42IIBJF8/zqDl5Df5gMlsqK9M
 uGrr4DUh+bve3V8CtzNDaNhER2jIpVUZyBWjITFlcvFE4hbvxnp//AW+YDRU5kPafEBD
 1+oQ==
X-Gm-Message-State: AOJu0YzWa3rGddNasowXAT1ZSSwmIF/MCSQ5y0JFN7oDjdn+B3OWrgqh
 UMJA7GmcsHkQydQdKUsj5DIRVw==
X-Google-Smtp-Source: AGHT+IFvzvh+ZcQORdPVNz9P5c4v9EWZnmUQzcL8JIRsYb9YAO66wf7rGaheUzp0ANdECY4mRrPwUw==
X-Received: by 2002:aa7:d743:0:b0:51d:95ac:22ed with SMTP id
 a3-20020aa7d743000000b0051d95ac22edmr3118038eds.1.1693486273687; 
 Thu, 31 Aug 2023 05:51:13 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a05640203cb00b0052a1d98618bsm764404edw.54.2023.08.31.05.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 05:51:13 -0700 (PDT)
Date: Thu, 31 Aug 2023 14:51:12 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH RESEND v8 03/20] target/riscv/cpu.c: split kvm prop
 handling to its own helper
Message-ID: <20230831-bf339311f4294d34e24ec37c@orel>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
 <20230824221440.484675-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824221440.484675-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Aug 24, 2023 at 07:14:23PM -0300, Daniel Henrique Barboza wrote:
> Future patches will split the existing Property arrays even further, and
> the existing code in riscv_cpu_add_user_properties() will start to scale
> bad with it because it's dealing with KVM constraints mixed in with TCG
> constraints. We're going to pay a high price to share a couple of common
> lines of code between the two.
> 
> Create a new riscv_cpu_add_kvm_properties() that will be forked from
> riscv_cpu_add_user_properties() if we're running KVM. The helper
> includes all properties that a KVM CPU will add. The rest of
> riscv_cpu_add_user_properties() body will then be relieved from having
> to deal with KVM constraints.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 65 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 23 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

