Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BE47386D3
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:24:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByl1-0003jb-WB; Wed, 21 Jun 2023 10:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByky-0003bg-Df
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:24:24 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBykw-0001Av-Ro
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HCWu6wXiv5neqENNZpwVOgdXE9uv+R/3DP0gH1kinbE=; b=1EV36pszL9VAe2GP+JdF8pEpgY
 KLQsSKZq6Glu0LzkhNg67bYhRoabCA9vqLX11Jg/CnY9idy9QC3CA6woPS1FxFvlAdbymgtyCodcV
 BK31yiaWmfnwShQgyRwWlTP7xVK2ky/6747e5d/kDYdtai56RdDfZGvUnJABA981XAs2sCDoID+++
 7iBHhtv3B3IjGbKYvEfAafj689bfzJ0pJUtbWmPCFsGYGY4vmyFa/6IHxGeVjVXUqANZiuL5rQyaH
 NtA8EekX2q/AL3EvtOmgTHY5GR4rB4Xvb4YxWhdBFkGIbwYRAp1m13YO19d3kevk0xxifYL06OKV3
 igXvhTRhhNb73dk1k+IgB3Yuhj2pu6MpVPtMEN5C47DP/TfJHACdW96hspSHwcLzoqux6TJPyDTal
 gRC+1+Xgzel6BIpjlLYe+rRx8tlLTOfWZBdn9DLmtMNw8WGPMC/SaSepCNTjkjD4DKRf+ZirzgfEd
 GSMk59jtKHu3rlFw+aEvCNWkVFgY1NcBKLKT6+GcbRKL+ZGTOJgqQaFZL0jMHHjJf8oThACS4q4EO
 u6crM46PT0vXGiKOyOxbvv73BQsZ5wi2EZet7UDT1B1bMvTh42KYfO62zJHolSN8EVuHFkFY6BZkV
 AA4MJ3/154+ImbInI+FroUb8ITxLdIrrRBHN+Jx+Y=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qByki-0003LZ-Tt; Wed, 21 Jun 2023 15:24:13 +0100
Message-ID: <4e72ee4d-a5ed-7c43-df8b-3d3d8c159675@ilande.co.uk>
Date: Wed, 21 Jun 2023 15:24:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <20230621085353.113233-3-mark.cave-ayland@ilande.co.uk>
 <2f1b2a44-0d0a-751d-4f3f-2de1f4ce4729@eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <2f1b2a44-0d0a-751d-4f3f-2de1f4ce4729@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 02/24] q800: add missing space after parent object in
 GLUEState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 21/06/2023 12:41, BALATON Zoltan wrote:

> On Wed, 21 Jun 2023, Mark Cave-Ayland wrote:
>> This brings GLUEState in line with our current QOM guidelines.
> 
> Are these guidelines documented somewhere? I like this better than the public/private 
> comments (although I prefer no space at all with just documenting that QOM object 
> parents should not be accessed directly) but I haven't seen it discussed and agreed 
> upon so it looks like a convention you defined but not documented anywhere. But it 
> could be I missed the patch to coding style or QOM docs to establish this convention.

Alex documented this earlier in the year: you can find this online at 
https://qemu.readthedocs.io/en/master/devel/style.html#qemu-specific-idioms.

> If we really want to make these QOM object states stand out we might even consider 
> formatting these as
> 
> struct GLUEState { SysBusDevice parent_obj;
>      M68kCPU *cpu;
>      ...
> }
> 
> unless checkpatch would not like that or something.

I'm not overly convinced by this, and yes I suspect it would also require some 
hacking on checkpatch.pl for it to work.


ATB,

Mark.


