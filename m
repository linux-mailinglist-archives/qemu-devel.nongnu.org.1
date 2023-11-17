Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7927EF5C5
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 16:59:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r41EL-0006gI-TO; Fri, 17 Nov 2023 10:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1r41EG-0006fo-7w
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 10:58:00 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1r41ED-0000eX-VX
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 10:57:59 -0500
X-CSE-ConnectionGUID: c2QBbu4GRWiUpxzpPnWtjw==
X-CSE-MsgGUID: x3rEWi/1QuWObYMWT9O2Ng==
X-IronPort-AV: E=Sophos;i="6.04,206,1695715200"; d="scan'208";a="25805520"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 17 Nov 2023 07:57:51 -0800
IronPort-SDR: 4SAYYqACIISR2kzhiwkIbVdYa4lhmBOfZVUla94SUvcYgUUNN3Biyqp9Dw53yhSN46dJEoDPr6
 XJXMAFXZP+PAhMAoUOG5rkGWx0x9uP8GItt+tLs9Xsdfnee69Loiedw1V+mRyWaOJTT+4Ze9oO
 xHKFHtZ517C5QWGct4t6YN7u4X9tuwDmkgl8cAYPgKN9CVFIRx/GvsU1Sxev3zaf+jkEFzU7Yt
 W3hvK3z22SdZnt+eRe6jsjV3IvQEktA03hyCF1IQPA2nMWUewqLsPnud2onYVfQv9cyr/QTZL7
 KXQ=
Message-ID: <c8f41115-51a3-41b9-922f-228b1e82035d@codesourcery.com>
Date: Fri, 17 Nov 2023 08:57:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH-for-8.2] target/nios2: Deprecate the Nios II architecture
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, <qemu-devel@nongnu.org>
CC: Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 <devel@lists.libvirt.org>
References: <20231117070250.32932-1-philmd@linaro.org>
 <fa514dc7-ffbd-4760-9df7-4536929c8b48@redhat.com>
From: Sandra Loosemore <sandra@codesourcery.com>
In-Reply-To: <fa514dc7-ffbd-4760-9df7-4536929c8b48@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: svr-orw-mbx-11.mgc.mentorg.com (147.34.90.211) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
Received-SPF: pass client-ip=68.232.141.98;
 envelope-from=Sandra_Loosemore@mentor.com; helo=esa2.mentor.iphmx.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.265,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 11/17/23 01:46, Thomas Huth wrote:
> 
> Being orphan for so long in QEMU, I guess it makes sense to mark it as 
> deprecated here now. We can still reconsider if a new maintainer shows up...
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

I agree, but I'd be surprised if anybody steps forward, since Intel has pretty 
much dropped all support for the nios2 architecture now (their current FPGA 
products based on risc-v).  At this point it looks very much like the upcoming 
GCC 14 release will be the last that includes support for this target.

-Sandra



