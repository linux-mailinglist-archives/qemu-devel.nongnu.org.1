Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D856715A81
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:45:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vuH-0007v6-V5; Tue, 30 May 2023 05:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3vuF-0007uo-NM
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:44:43 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3vuD-0002TU-WB
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:44:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 78C2274633D;
 Tue, 30 May 2023 11:44:38 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4859A746335; Tue, 30 May 2023 11:44:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 46D21745720;
 Tue, 30 May 2023 11:44:38 +0200 (CEST)
Date: Tue, 30 May 2023 11:44:38 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tcg: Add tlb_index_and_entry() function
In-Reply-To: <586a2a70-99bb-c0a9-14d1-a154cbecc13e@linaro.org>
Message-ID: <d319ef04-c509-0a8c-a52e-d15df1149365@eik.bme.hu>
References: <20230530000543.4F83174632B@zero.eik.bme.hu>
 <586a2a70-99bb-c0a9-14d1-a154cbecc13e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

On Mon, 29 May 2023, Richard Henderson wrote:
> On 5/29/23 17:05, BALATON Zoltan wrote:
>> The tlb index and entry are often retrieved together and tlb_entry()
>> already calls tlb_index() so it could easily return it. Add a
>> tlb_index_and_entry() function that does that to simplify callers and
>> maybe avoid some duplicate calculations.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> The compiler does a good job removing duplicate calculations already.
> What effect do you see with this?

Hard to tell because measurements always change slightly when I run some 
benchmark in guest so if it has an effect it's not big but I find it more 
readable with a single call than two calls so that's the main motivation 
here.

Regards,
BALATON Zoltan

