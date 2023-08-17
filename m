Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4C77FE90
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 21:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWikO-0003sY-1Q; Thu, 17 Aug 2023 15:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qWikI-0003sG-7O
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 15:33:26 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@gmail.com>)
 id 1qWikG-0005T5-1o
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 15:33:25 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-689f9576babso130413b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692300802; x=1692905602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XDpmkbtmo41tCFp1o3Ev1dKke69X6hggRRQ2zyUrv1o=;
 b=Cb7fG3v05Qst3vvoIabgWZ+7wni+4JaW0WNooBK2CsXRcO3ICLJckZPaxFHz/DmzZm
 zazx4xDPiJ8Zk++UmkQm96NrFvcvoPVwHR9MqdkF6cbsTbY6qMMKVuP75+1WTq5b+8zW
 hrEyJr3VKnz73iJIgphKKEdP3ThKv6QoLlc8n443Fh54agM3EsJGw1Ez2QlYdBc4WgcW
 RN8A0z+vpL137FPwOpDFOilK/Z+Ift9L/8NF+Yl/abWqat+6c/WuGcxADkFcv733JdId
 M0B6eFD4uauGLEF77dCtMuQ0bTh06/5FM5nozSaHfc3fauL79WUsYuW7mBN3fNQdI6Y0
 vncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692300802; x=1692905602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDpmkbtmo41tCFp1o3Ev1dKke69X6hggRRQ2zyUrv1o=;
 b=Ia/XkGsSVFK+mmaayTqvzZwrXF7XzBVZWrHxY2C+O/u67wv/BGPeSTMfrwpfe2uzz9
 srj62yhWzzJm87jeH4gQiGO1UqVUjSi0ivd9c8pi6pgDPwCnH7JmMFEvobFd23H5K/f2
 rzulU3jWQ2tt+0qR1/b/MvrCR2z0Z34K5AGtXtu+T7Q7h2nIefBgOQpLvISE29jvTp87
 Uqn2WJBi58N2MEFNiK0jWGyB2ZkJsyU8VIm0qvCB9fhOhfFU3Cnv8COHCJCwf2mlCWrQ
 ZAKLfbIeejGG/q0Kz/LQIuRRi903FSjOyobd1IgbNE+22gYGrWhSETi2QW5IYumkCoPH
 aELw==
X-Gm-Message-State: AOJu0Yx6oEYWgX9qCz4E/reimZX2xdM9GhT4PNE0r/BBqaIhXHED79oG
 Y/LIKQMsNcpgBbReQEvVN3c=
X-Google-Smtp-Source: AGHT+IH+qg+9EO8udl7L5GcEEB+uswLtljq7D7yAA09CFtaLK7DCc9dI8QmDR8B18flOfMvrL+kqWw==
X-Received: by 2002:a05:6a00:812:b0:687:5415:7282 with SMTP id
 m18-20020a056a00081200b0068754157282mr470760pfk.23.1692300801853; 
 Thu, 17 Aug 2023 12:33:21 -0700 (PDT)
Received: from localhost ([192.55.55.51]) by smtp.gmail.com with ESMTPSA id
 fe17-20020a056a002f1100b006889348ba6asm126798pfb.81.2023.08.17.12.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:33:21 -0700 (PDT)
Date: Thu, 17 Aug 2023 12:33:19 -0700
From: Isaku Yamahata <isaku.yamahata@gmail.com>
To: Qian Wen <qian.wen@intel.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 babu.moger@amd.com, isaku.yamahata@gmail.com
Subject: Re: [PATCH v3 0/2] Fix overflow of the max number of IDs for logic
 processor and core
Message-ID: <20230817193319.GA3637892@ls.amr.corp.intel.com>
References: <20230816080658.3562730-1-qian.wen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816080658.3562730-1-qian.wen@intel.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=isaku.yamahata@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Aug 16, 2023 at 04:06:56PM +0800,
Qian Wen <qian.wen@intel.com> wrote:

> CPUID.1.EBX[23:16]: Maximum number of addressable IDs for logical
> processors in this physical package.
> CPUID.4:EAX[31:26]: Maximum number of addressable IDs for processor cores
> in the physical package.
> 
> The current qemu code doesn't limit the value written to these two fields.
> If the guest has a huge number of cores, APs (application processor) will
> fail to bring up and the wrong info will be reported.
> According to HW behavior, setting max value written to CPUID.1.EBX[23:16]
> to 255, and CPUID.4:EAX[31:26] to 63.
> 
> ---
> Changes v2 -> v3:
>   - Add patch 2.
>   - Revise the commit message and comment to be clearer.
>   - Using MIN() for limitation.
> Changes v1 -> v2:
>   - Revise the commit message and comment to more clearer.
>   - Rebased to v8.1.0-rc2.
> 
> Qian Wen (2):
>   target/i386: Avoid cpu number overflow in legacy topology
>   target/i386: Avoid overflow of the cache parameter enumerated by leaf 4
> 
>  target/i386/cpu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> base-commit: 0d52116fd82cdd1f4a88837336af5b6290c364a4
> -- 
> 2.25.1
> 

The patch itself looks good. Can we add test cases?
We have some in qemu/tests/unit/test-x86-cpuid.c.
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>

