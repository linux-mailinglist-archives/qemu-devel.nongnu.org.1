Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3477D7192
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 18:19:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvgaQ-0006a5-QC; Wed, 25 Oct 2023 12:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvgaJ-0006Z7-Rm
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:18:20 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvgaI-0007pH-AU
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:18:19 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53ebf429b4fso9270255a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698250696; x=1698855496; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9Q2jJf69+REApXG71JA3IUNDwDMkzrzokByVEMfEeQo=;
 b=mmD17EgQPp86MTOz7cVLryWPjB4fLhYistVlAPnMBLoAjOW+w0nChMTOJ/YkQh7P5l
 ObR8MvZV7j8xmkxuAO6OqdgVshG9Jr6xvcB4n7u8Jp9wLKswYfqbv3DJnmgVaf9gNftS
 +++qNKVNqyUflZBSEHebcNm1dn+OqQb+YhmYTbka0IAZaTNPDf9Of7cE0MbbQtJKHXft
 fbhN64H1JOhslXgIv+UHd4ym1Q0tn+GtStAb+VHHiV26MBmR7vz7Wok4HOFTLqzniuMq
 yfzSZ9KkNzzrTt2e0hFPH/LE3poUOVr2onJvxttkLhc8arfgWMdkrPTlEr/IurXVtbkx
 uvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698250696; x=1698855496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Q2jJf69+REApXG71JA3IUNDwDMkzrzokByVEMfEeQo=;
 b=xGuhmzjL+hAMItVTdYTyGjNyxko0cOpVSWJ9s02BaI446IefzlY8EAA328sTCfCUG+
 M5atOuPTWymiW4SwmA65E4tg35uscFOzwrc14Pohp/MRn2qh85+iKQwk78mwkNstjnbA
 JfxNkslNuxwUb0MpwcmgXHRVUzNiBEwgq0w3WLXTrTlSUIS2vHpgAFv5SAXAmmKug12j
 bEKSUbXBCzA4/TbXTsbZJ9d1xThkNiTNTJag0Lfo47ClrfL36w8zL350WrcNQsy93v1C
 upRxkqCEbS+GUwp5sjBLr6o0fvbOV+1Z7qIMg5jfvAiXjjC26cCDQC2Vd0/7Xd333l6K
 fWjg==
X-Gm-Message-State: AOJu0YyOZ1Xk/5redDgdOZsJhvPdYGfWoy2l+uzKXENTZeFqyNtiVLim
 A9msrPLVZxon4CxA/Yimh8d/oA==
X-Google-Smtp-Source: AGHT+IEtBth1LuaWcJqRAwjHuZps56ng8iCjeoSicHco7wedm6V+VK3KRTD6qOf3mGlTpLKKhzwiqg==
X-Received: by 2002:a17:907:31c1:b0:9be:21dc:8a9a with SMTP id
 xf1-20020a17090731c100b009be21dc8a9amr12118384ejb.39.1698250696680; 
 Wed, 25 Oct 2023 09:18:16 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 gu18-20020a170906f29200b00977cad140a8sm10179720ejb.218.2023.10.25.09.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 09:18:16 -0700 (PDT)
Date: Wed, 25 Oct 2023 18:18:15 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v4 7/9] target/riscv/tcg: add hash table insert helpers
Message-ID: <20231025-bc6cafdec7af73ef9b189adb@orel>
References: <20231025135001.531224-1-dbarboza@ventanamicro.com>
 <20231025135001.531224-8-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025135001.531224-8-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x534.google.com
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

On Wed, Oct 25, 2023 at 10:49:59AM -0300, Daniel Henrique Barboza wrote:
> Latest patches added several g_hash_table_insert() patterns. Add two
> helpers, one for each user hash, to make the code cleaner.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

