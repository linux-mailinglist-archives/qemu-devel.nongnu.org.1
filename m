Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B49E4AC6CA5
	for <lists+qemu-devel@lfdr.de>; Wed, 28 May 2025 17:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKIQf-0000lF-1N; Wed, 28 May 2025 11:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uKIQZ-0000kj-UC
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:10:48 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uKIQY-0005ds-07
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:10:47 -0400
Received: from example.com (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 30D99206788C;
 Wed, 28 May 2025 08:10:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 30D99206788C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1748445044;
 bh=K9wAbwFu2b9ZHiaJY2ZZUt3t+q42W4ptbO6lQF2+uWw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FEJUaQ9U8IQdWJieUoWu0uZdj72XIDBrKggvRyAdvFVuwnBOY5NYp8Hk3DAtgGz2S
 mDiJA6xFkQ//QgKun6sBMsHagahR4DT9RdQN80AFRMXG4iEorDmW72a7Cfw8fGNQvw
 5RWibuVsKcZTNDpZGfn6E/Qgf6jC9DkF9uLvMkvU=
Date: Wed, 28 May 2025 17:10:37 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 22/25] target/i386/mshv: Integrate x86 instruction
 decoder/emulator
Message-ID: <aDcnbavXF+OUH8Zp@example.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-23-magnuskulke@linux.microsoft.com>
 <aC0EZHBoP_ez_ShX@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC0EZHBoP_ez_ShX@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, May 20, 2025 at 10:38:28PM +0000, Wei Liu wrote:
> On Tue, May 20, 2025 at 01:30:15PM +0200, Magnus Kulke wrote:
> > +    init_emu(&mshv_x86_emul_ops);
> 
> If I'm not mistaken, the name mshv_init_cpu_logic suggests this function
> is called every time a CPU is initialized. There is no need to
> repeatedly initialize the emulator.
> 
> The code snippet should be moved to either the initialization function
> of the accelerator or the initialization function of the VM object.

It's called as part of the accelerator initialization, but it's a
misnomer, I agree. We'll see whether we require the guards, so this is
is really just an mmio emu init.

