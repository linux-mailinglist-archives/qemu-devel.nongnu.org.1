Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E54AC102A
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 17:43:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI84U-0006vY-6T; Thu, 22 May 2025 11:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uI84Q-0006vH-Hr
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:42:58 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uI84O-0003QX-9C
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:42:57 -0400
Received: from example.com (unknown [167.220.208.38])
 by linux.microsoft.com (Postfix) with ESMTPSA id 40AFC211CF8A;
 Thu, 22 May 2025 08:42:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 40AFC211CF8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747928574;
 bh=A7F58Ka0vPrlLYeVqYrehTUbxQU5+8gUsh1NyLa0opQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M0qhX6H2/L9HKlcXf8sYFYVQLijy6YuuhWtJvwAN4gt309FycxLAXotlwKPAOMpSQ
 XX1nPhhpGnJ3QQDHDTSXy49Nd84JcRO4iBfb1EX8v9/iG3roOmNl0dbaizbE9xanHd
 tlcgSzezpuFCfFLgjSNfbyiWK2RhVVvRUlZM1NRo=
Date: Thu, 22 May 2025 17:42:48 +0200
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
Subject: Re: [RFC PATCH 08/25] accel/mshv: Initialize VM partition
Message-ID: <aC9F+LITGPcwQoLl@example.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-9-magnuskulke@linux.microsoft.com>
 <aCzS2h9UfGe-FZDW@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCzS2h9UfGe-FZDW@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
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

On Tue, May 20, 2025 at 07:07:06PM +0000, Wei Liu wrote:
> On Tue, May 20, 2025 at 01:30:01PM +0200, Magnus Kulke wrote:
> > +static void mshv_reset(void *param)
> > +{
> > +    warn_report("mshv reset");
> 
> What's missing for this hook?
> 

Ah, I suppose this was inspired by the KVM accel. The hook is called for
cleanups that should occur on a reset. At the moment we don't have state
that we want cleanup during reset afaik. So we can remove it here.

