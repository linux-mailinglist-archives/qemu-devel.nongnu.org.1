Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311B798404
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:27:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeWoi-0003sp-DM; Fri, 08 Sep 2023 04:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fJ+a=EY=kaod.org=clg@ozlabs.org>)
 id 1qeWof-0003s1-KQ; Fri, 08 Sep 2023 04:26:13 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fJ+a=EY=kaod.org=clg@ozlabs.org>)
 id 1qeWod-0000f0-2K; Fri, 08 Sep 2023 04:26:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rhq221Rwgz4xFR;
 Fri,  8 Sep 2023 18:26:02 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rhq204HVFz4xFQ;
 Fri,  8 Sep 2023 18:26:00 +1000 (AEST)
Message-ID: <0aaf7b07-faf3-39f7-c310-1eed51a628b2@kaod.org>
Date: Fri, 8 Sep 2023 10:25:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/26] aspeed queue
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
References: <20230901094214.296918-1-clg@kaod.org>
 <be868ef0-cbc3-a380-3307-512857e2a4a2@kaod.org>
 <70e53523-eb9c-669a-1ee6-cdfd08507f8c@tls.msk.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <70e53523-eb9c-669a-1ee6-cdfd08507f8c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=fJ+a=EY=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On 9/8/23 09:52, Michael Tokarev wrote:
> 08.09.2023 10:09, Cédric Le Goater wrote:
> ..
>>> Hang Yu (3):
>>>        hw/i2c/aspeed: Fix Tx count and Rx size error in buffer pool mode
>>>        hw/i2c/aspeed: Fix TXBUF transmission start position error
>>
>> Michael,
>>
>> I think the two above are candidates for stable.
> 
> Got it.  I've noticed these two in master yesterday, but thought
> i2c/aspeed priority is a bit lower than other stuff, - maybe
> wrongly.

It is not hot material indeed but it does fix support for the
latest Aspeed SDK and a lot people simply use the disto QEMU.

> Picked these two up now.

Thanks, !

C.

