Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96954ABE6C3
	for <lists+qemu-devel@lfdr.de>; Wed, 21 May 2025 00:09:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHV98-0002kx-3r; Tue, 20 May 2025 18:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHV96-0002kk-5Q
 for qemu-devel@nongnu.org; Tue, 20 May 2025 18:09:12 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHV94-0001WK-KB
 for qemu-devel@nongnu.org; Tue, 20 May 2025 18:09:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F38F05C5666;
 Tue, 20 May 2025 22:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F24DC4CEE9;
 Tue, 20 May 2025 22:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747778948;
 bh=eho6lbl51/S9l73vqJHxLlu0GHXw8O/FfYyR1Z/fKAQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OTk4B35J0VBiGQDYKMbFKOQc2IzMl7Bx1rNqtCm9p+rw2xtabIKGh0iPCGhroEqvJ
 Ax49lTrM7nJGTUy5BhQXgcWAJ7Ng7jzYgLPZMrrhipoD3OXlhHbyUem3xASiDLI1d4
 jsUT2/w8tc8etrVgLSZtO8/VTnbsoJKl2tdP9sOmKwDWOSEnh84iuQ91vRjXBK1xDW
 0BuK7DQ5juOp+VHSo1HbseQvsY3kG1yfsPUaFsl6tCBIDDL9wrQOLovqt/6sq6Yjhl
 CyEhnVJE7vCxJZyD+Mdm7vCIuoSBORXLV4o+4CS0ttDCElI0CPYCICgFtT9H2GH8kk
 AqbUOWrTQJR3A==
Date: Tue, 20 May 2025 22:09:07 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 16/25] target/i386/mshv: Implement
 mshv_get_standard_regs()
Message-ID: <aCz9gwYwUWx_BdrH@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-17-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-17-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=wei.liu@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 20, 2025 at 01:30:09PM +0200, Magnus Kulke wrote:
> Fetch standard register state from MSHV vCPUs to support debugging,
> migration, and other introspection features in QEMU.
> 
> Fetch standard register state from a MHSV vCPU's. A generic get_regs()
> function and a mapper to map the different register representations are
> introduced.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
[...]
>  int mshv_load_regs(CPUState *cpu)
>  {
> +    int ret;
> +
> +    ret = mshv_get_standard_regs(cpu);
> +    if (ret < 0) {
> +        error_report("Failed to load standard registers");
> +        return -1;
> +    }
> +
>  	error_report("unimplemented");
>  	abort();

This part looks wrong. It should be "return 0;" instead.

Thanks,
Wei.

>  }

> -- 
> 2.34.1
> 

