Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C5D78D37C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 09:15:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbFP3-0002qT-E4; Wed, 30 Aug 2023 03:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CWUu=EP=kaod.org=clg@ozlabs.org>)
 id 1qbFOk-0002hD-Tv; Wed, 30 Aug 2023 03:13:56 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CWUu=EP=kaod.org=clg@ozlabs.org>)
 id 1qbFOi-0005hZ-6j; Wed, 30 Aug 2023 03:13:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RbFrn62Brz4wy7;
 Wed, 30 Aug 2023 17:13:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RbFrk1Rn4z4wxn;
 Wed, 30 Aug 2023 17:13:41 +1000 (AEST)
Message-ID: <c722f63e-697b-eeab-82f0-7155b2a4632b@kaod.org>
Date: Wed, 30 Aug 2023 09:13:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 8/8] hw/fsi: Documentation and testing
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Ninad Palsule <ninad@linux.ibm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, andrew@aj.id.au,
 joel@jms.id.au, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20230830022638.4183766-1-ninad@linux.ibm.com>
 <20230830022638.4183766-9-ninad@linux.ibm.com>
 <0cdc9d0c-b146-e55f-cd2d-81e6827e64e4@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <0cdc9d0c-b146-e55f-cd2d-81e6827e64e4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=CWUu=EP=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.242, SPF_HELO_PASS=-0.001,
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

On 8/30/23 09:05, Thomas Huth wrote:
> On 30/08/2023 04.26, Ninad Palsule wrote:
>> Added FSI document
>> Added basic qtests for FSI model.
>> Added MAINITAINER for FSI
>> Replaced some qemu logs to traces.
> 
> Sorry, that's not how we rework patch series in the QEMU development process. Please squash the log traces changes into the patches that introduced the original code, and please put the MAINTAINERS update, documentation and qtests into separate patches.

yes. This is true for some Kconfig changes also. On that topic, please
make sure FSI is compiled only when ASPEED_SOC is selected. It could be
useful for the PPC PowerNV machines one day but the models are not
available yet.

I will try to go through the series this week. Wait a bit for the v4.

Thanks,

C.



