Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C6C73DF76
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:41:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlVJ-0007RL-7e; Mon, 26 Jun 2023 08:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDlV5-0006zi-91
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDlV3-0005a2-2z
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687783160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=66ZvsbjhIGdyEqesqMDwK14bO1SKcg2qvY/UqeKbq0o=;
 b=fy1XYmmzf5HWc+irXR+W59Qt9Gz0aVV7N5F7ruTOZAqZJmcWWAoQXYNo6puyWK684CJ8CX
 FgKXDFF1+SOnWrkZQ7fpOMSD+D5I8fAyLsFmfhfMy4Ism1OPrdYnnAgyLrJSb1V+CFnUoB
 yDA5WGfgPwkGgZ8E/940IEAlt12x7lI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-NE_y9yakPOq-tHzwaPtrCw-1; Mon, 26 Jun 2023 08:39:18 -0400
X-MC-Unique: NE_y9yakPOq-tHzwaPtrCw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a355c9028so201740766b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687783157; x=1690375157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66ZvsbjhIGdyEqesqMDwK14bO1SKcg2qvY/UqeKbq0o=;
 b=DW3wiIh8AUxbcJKlQ+dWp27TC6S33WFScrx5eUmsy6NQi4FeBjQBg6IdVFGsUjUoJL
 NTFtJP0327vu7aySzzKEpFc4V30VN0+tV7VLKg/aUSLFzTk4l/CJUPG8A+cx+QIOy1GQ
 478KPGsbMCTbmcmdwZnRLPii05zl9bPbQXyZ2ZPiaFb2JBjyfF1QpYL+rFCzTJIaaM0m
 Wy7kEXsdpDtaeLuEop4mKilkrggIz2Hn2xHOSjBN9W7FIGtUgk3yl/tzi4Sbcx/61Zmk
 jOVBvLzLCAiHZpvOaWkdHWhG9crrLBVu2RDZNr/AREyuztZ+f8z2atc4qfqr4/L+tPFQ
 i8tg==
X-Gm-Message-State: AC+VfDyt1lVLnLPpNGgckipaNkE685h+bDdK4rIOrgQJNvPVFTqbn8+m
 kl7ThtIXFSsAIl+yc9Khoqm7ayQDxTgMSrFGvSgOHlx0c3FCzExKShfagLVnCW7dFOb6G98y5vQ
 RgUFzSfYBHij9qKk=
X-Received: by 2002:a17:907:6292:b0:983:ba44:48af with SMTP id
 nd18-20020a170907629200b00983ba4448afmr26591815ejc.53.1687783157276; 
 Mon, 26 Jun 2023 05:39:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4f3HzwrI97dQ9VskpQDESgRD5/FDGWvyKz5BtQnTWovZhTogKsu5TypQtCmKWcnBNYThpYXw==
X-Received: by 2002:a17:907:6292:b0:983:ba44:48af with SMTP id
 nd18-20020a170907629200b00983ba4448afmr26591808ejc.53.1687783157047; 
 Mon, 26 Jun 2023 05:39:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 c6-20020a170906340600b0098dd26c6e95sm3189089ejb.42.2023.06.26.05.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:39:16 -0700 (PDT)
Date: Mon, 26 Jun 2023 14:39:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 lei4.wang@intel.com, qian.wen@intel.com
Subject: Re: [PATCH 1/7] target/i386: Add FEAT_7_1_EDX to adjust feature level
Message-ID: <20230626143915.34d5712b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230616032311.19137-2-tao1.su@linux.intel.com>
References: <20230616032311.19137-1-tao1.su@linux.intel.com>
 <20230616032311.19137-2-tao1.su@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 16 Jun 2023 11:23:05 +0800
Tao Su <tao1.su@linux.intel.com> wrote:

> Considering the case of FEAT_7_1_EAX being 0 and FEAT_7_1_EDX being
> non-zero,
Can you clarify when/why that happens?

> guest may report wrong maximum number sub-leaves in leaf
> 07H. So add FEAT_7_1_EDX to adjust feature level.
> 
> Fixes: eaaa197d5b11 ("target/i386: Add support for AVX-VNNI-INT8 in CPUID
> enumeration")
> 
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1242bd541a..e8a70c35d2 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6778,6 +6778,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>          x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
>          x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
>          x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
> +        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
>          x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
>          x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
>          x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);


