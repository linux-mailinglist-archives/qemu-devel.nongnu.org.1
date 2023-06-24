Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E094573C772
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 09:43:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCxuI-0000vG-R5; Sat, 24 Jun 2023 03:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qCxuF-0000uN-9q
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 03:42:03 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qCxu9-0006Im-27
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 03:42:02 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51bea30ccbcso1356656a12.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 00:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687592515; x=1690184515;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qhmVfOjUMWSqtK39WahiVC3cYUdp7FqW+gT317BI4zw=;
 b=DNLJDS76Is6fnQwJlIX+nBS3zIFLjoRRa3wCXzskrUi3InDQOsCa5q6iae8nnCRo5e
 E2NfGczMGQVq3A3OSOmOswzs1rd+7Pp/aPUrSuFYLn3A5SSV5cDIQdPJ/4kacs71b79Q
 SJzebHtvxRMpYniG1AJAwJ7oRq/99iGn9vLm6NjvnPOTNYX5M6P8k15rlRgmMiHegt0F
 OPfAeTw73FWfb95efwOzt2gDu+0NlSFkFIB+YfKyxKjOTNH0iLoY9bvj3wlUsbGWKVMu
 wj80eUfWywq4sZcSAAFYZJSZvT00RmiVxg7M3oyloaKDDf8ogbYxQn1cso7KEpXIdiEI
 /SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687592515; x=1690184515;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhmVfOjUMWSqtK39WahiVC3cYUdp7FqW+gT317BI4zw=;
 b=PlohACMlE5EJXywd5rUlfVejviB7e3Cbsl7kWzRcO1kjEnAv8RJtjoPaEqHNA42veI
 Z57ed0ogdVfo3GH2YnSrevm8YEnif7cjOr66Hk35aitDL5GY3k+qTQlf4z6ZAkY/hq7i
 kJ4DCZ6ib9V6BQJAT6TEwPn1YC+HSIfJbx1aHueT7r+Wl5SdK5xTQtYfwH+IqsxKeIa7
 O5bp3GkoliwEZTen8SFAyCnqYUzpYAWMuGN4SEq/mA/5xzEZxI+Gx9uElg+tZGA0rZ4Q
 2onlP/sb2iQz+HnXF2sbHTIqPz4T6CwaMjCbC9k7QYtlh1UWxT9i+Xs3VGZIXg+MQ3MB
 8jNg==
X-Gm-Message-State: AC+VfDx4dCsusjN6/gKgFTqvpRbpGcmtAFdwlE+M0m1D3z5r+g4IbdE9
 S0bqWpji9vIaMNVFGvyJmiSntw==
X-Google-Smtp-Source: ACHHUZ5JxvqeBOuq6r7SC5nlsK9jzcV5U5tos97i34Y7S4oAdX6nxFtsJRwsYnoF5HqjPJ6J8MNeHA==
X-Received: by 2002:a17:907:c13:b0:988:aa45:806 with SMTP id
 ga19-20020a1709070c1300b00988aa450806mr15828464ejc.15.1687592515048; 
 Sat, 24 Jun 2023 00:41:55 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 qh15-20020a170906ecaf00b009885462a644sm569716ejb.215.2023.06.24.00.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jun 2023 00:41:54 -0700 (PDT)
Date: Sat, 24 Jun 2023 09:41:53 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v3 16/19] target/riscv/cpu.c: create KVM mock properties
Message-ID: <20230624-fad369c515a7f4edd9d21c2a@orel>
References: <20230622135700.105383-1-dbarboza@ventanamicro.com>
 <20230622135700.105383-17-dbarboza@ventanamicro.com>
 <20230623-421ca497f9f83486881b9d9c@orel>
 <c1056ba9-4418-d6ce-536b-93155fff84a2@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1056ba9-4418-d6ce-536b-93155fff84a2@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Jun 23, 2023 at 11:28:03AM -0300, Daniel Henrique Barboza wrote:
...
> > I think we should actually fail with an error when the user tries to
> > enable an extension KVM doesn't support. Otherwise a user may be
> > confused as to why their Zawrs=on didn't provide them a machine with
> > Zawrs. And, when KVM learns how to provide that support to guests
> > (Zawrs is actually on my TODO...), then migrating the same VM to
> > later KVM/QEMU will actually enable the feature, possibly confusing
> > the guest.
> > 
> > So, we should probably just not add any extension properties to KVM
> > guests which can't be enabled. Then, as we add support to KVM, we'll
> > add the properties too.
> 
> By 'extension properties' do you mean just the flags that enable/disable them,
> like '-cpu, rawrs=<bool>', or also the other properties related to extensions
> that KVM might not support, like 'vlen' and 'elen' from RVV? I'd say that it's
> ok to leave things such as 'vlen' because the user won't be able to enable RVV
> in KVM anyways.

Properties like 'vlen', which have a dependency on an extension, should
probably have their own error checking at cpu finalize features time.
I.e. if 'vlen' is present, but not V, then QEMU should complain. I see
we don't currently do that, though.

> 
> And what error do we want to throw? With this patch it's easy to just add an
> Extension zawrs is not available using KVM" error message. Otherwise we can
> not add the property at all and then QEMU will fail with a "property cpu.X not
> found" type of error. Both will error out, question is whether we want to be
> more informative about it.

It's probably best to do the "not available with KVM" error by changing
this patch from adding a no-op setter to an error-out setter. That way,
our story that a riscv machine is the same for both KVM and TCG still
remains, i.e. all properties are still present, but we add the honesty
to the story that not everything works with KVM.

Thanks,
drew

