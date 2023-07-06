Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 426037492EC
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 03:11:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHDVP-00006j-9x; Wed, 05 Jul 2023 21:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHDVM-00006A-Td; Wed, 05 Jul 2023 21:09:56 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHDVL-0000NB-1T; Wed, 05 Jul 2023 21:09:56 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2E038746369;
 Thu,  6 Jul 2023 03:09:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 01F98746335; Thu,  6 Jul 2023 03:09:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0103574635C;
 Thu,  6 Jul 2023 03:09:34 +0200 (CEST)
Date: Thu, 6 Jul 2023 03:09:34 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 00/14] PPC440 devices misc clean up
In-Reply-To: <d192a786-6019-f1d3-6491-c245527da417@gmail.com>
Message-ID: <ec526143-9f3f-3d8d-9977-2ee76a31ef23@eik.bme.hu>
References: <cover.1688586835.git.balaton@eik.bme.hu>
 <d192a786-6019-f1d3-6491-c245527da417@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 5 Jul 2023, Daniel Henrique Barboza wrote:
> Zoltan,
>
> Patches 1-9 are queued. Don't need to re-send those.

Thanks, the last two patches are also reviewed and they don't depend on 
the ones before so you could queue those too.

The only outstanding patches are those 3 that rename the type defines to 
match their string values. We could come up with better names but those 
suggested by Philippe are too long IMO so at least the patches in this 
series clean up the current mess and we could rename these later. I'd 
rather not change the string values too much as those are what QOM 
actually uses to ideintify the types but we're free to change the defines. 
Currently we have:
#define TYPE_PPC4xx_PCI_HOST_BRIDGE "ppc4xx-pcihost"
and then a "ppc4xx-host-bridge" type without a define which is another 
type which is quite confusing. I may have partly created this mess back 
when I first tried to add sam460ex and did not know much about this but at 
least I'd like to improve it a little and resolve some of it now.

Regards,
BALATON Zoltan

