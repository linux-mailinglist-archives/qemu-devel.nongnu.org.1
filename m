Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF287103E7
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 06:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q22L4-0005eQ-AW; Thu, 25 May 2023 00:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eldon-qemu@eldondev.com>)
 id 1q22L2-0005e2-92
 for qemu-devel@nongnu.org; Thu, 25 May 2023 00:12:32 -0400
Received: from [209.195.0.149] (helo=npcomp.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eldon-qemu@eldondev.com>)
 id 1q22L0-0001IN-4D
 for qemu-devel@nongnu.org; Thu, 25 May 2023 00:12:32 -0400
Received: by npcomp.net (Postfix, from userid 1000)
 id 3D531131EA5; Thu, 25 May 2023 04:12:27 +0000 ()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eldondev.com;
 s=eldondev; t=1684987947;
 bh=ocox5Fe519yiqsgr/X5QdeJSJjNeVbJyFLIZytGGxbM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=INGTJkQe21ctChT9vePyIF+6/AVoc+MXsTxbqkLnzCoPQpuNWmRhjv2ILPsd3bcoV
 Bae7OKlD1GahoxqV2+a7P8nP8MSw7v6R6RdKYq5UgV+jwYaNEJa0SkFulKQ5ZWXDLI
 zqqPflC8golLEr/VIYG1Dfsnpj/CXJ3NHKWdqPKc=
Date: Thu, 25 May 2023 04:12:27 +0000
From: Eldon Stegall <eldon-qemu@eldondev.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: New container build error: mountpoint does not exit
Message-ID: <ZG7gK6ZFgSSvBGBV@invalid>
References: <b7ef4d65-1b2c-c435-b448-9b6bec39cd96@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7ef4d65-1b2c-c435-b448-9b6bec39cd96@linaro.org>
X-Host-Lookup-Failed: Reverse DNS lookup failed for 209.195.0.149 (failed)
Received-SPF: pass client-ip=209.195.0.149;
 envelope-from=eldon-qemu@eldondev.com; helo=npcomp.net
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, May 24, 2023 at 01:09:30PM -0700, Richard Henderson wrote:
> Hi Eldon,
> 
> New this morning are some odd failures in the container build stage, e.g
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4345796216#L235
> 
> cgroups: cgroup mountpoint does not exist: unknown
> 
> There are several such failures in that pipeline. I've not seen this before, nor was it 
> happening yesterday.
> 
> Any ideas?

Hi Richard,
If I had to guess, it's probably related to some changes in
Camille's patchset. My first guess is that it is related to 
https://gitlab.com/qemu-project/qemu/-/commit/5f63a67adb58478974b91f5e5c2b1222b5c7f2cc

which downgrades docker-in-docker from latest to stable-dind.

I'm not sure how the stable tags are treated with docker, but it
does seem that those tags haven't been updated in a couple of years.

This person on SO seems to have fixed a similar issue in gitlab ci
by upgrading: https://stackoverflow.com/q/70707572

The cgroups error leads me to believe that the older dind service is 
expecting cgroups v1, while the hardware runner is running FCOS with
cgroups v2.
 
I ran a test with just that patch omitted on my repo, with better
results:

https://gitlab.com/eldondev/qemu/-/pipelines/878387857

I will see if the opensbi build which also uses stable-dind and failed
in that pipeline is successful when attempting to use latest dind
instead.

If using stable is compelling, I can work on making the hardware runner
support it.

Thanks,
Eldon



