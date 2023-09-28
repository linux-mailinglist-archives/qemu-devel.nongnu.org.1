Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B417B2642
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 22:06:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlxGC-0005x2-G8; Thu, 28 Sep 2023 16:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qlxG9-0005wf-Ti
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 16:05:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qlxG8-00061X-5J
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 16:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DkVlUBHR1aPNbTQaZRt798QCRa3KDj0KgZr49pOxJfs=; b=0Cy4lGQrhKRGBQrjEBypq2Fyos
 NjYgElX9fRwY5uX5w88VRxGPI1IH0batYu3dwumQ/QLNAV9d59feOgxdQB7TKYsnfy0Ti4dbonm4T
 J2JrpiB7yBvel4WnN10wes+qcCbrMnIodnL3eBfSW6hr2w/5xWGDwiUCgPu1/XHxCvcW32REWwluB
 Ywu0KP8Qv+7LQfuv5JPMGZBBcDrqpazBPogSodMjdhx61oJFak/Cj4/aqFx3Z13o7QKJdfX5lqux2
 5cRMKbU2C2o2d8+djOpu+kIwnbzsBH0dv3y+QbtLuM2B/mobnG03dTnutwkUbr+geoQcSfqb/P2QH
 IUnY2HhUViVtyJRzGjL9xc7b1fw+ihfVIM4SNeA7M8UmFBNiv1yplks4TQ1mpXnMExg4VDT9KU30D
 hRwe1/SLPiyCY8T7DnYkxifgU4O0ItCwO8MN8ixsFS3TA+HrQycVodtmuV4GaujBrwM0UJpcgvPJD
 vd/zTSuTZAuSB6yvpCTexb3vuT7dEG2Lcr2/Zd12+nYbYglOl4t3y7HZsltECik3gpyFAlTztSfvb
 7v94ekvtwTBXewVNkwVTDmhho3BJ4hhAnZMsDLgOz4lJEY/2YJ1Hrk7x7/vgm0FXEENyqiiW05fs6
 qpOukZpXhT8tTUp1nII7me4HAnbjVtoKDnav3qP5I=;
Received: from [2a00:23c4:8baf:5f00:89cc:78d2:7179:5c3b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qlxFr-0006vy-SV; Thu, 28 Sep 2023 21:05:04 +0100
Message-ID: <59cb2064-3a12-8c7e-71a2-a6ec570d2645@ilande.co.uk>
Date: Thu, 28 Sep 2023 21:05:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Nick Bowler <nbowler@draconx.ca>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230925050545.30912-1-nbowler@draconx.ca>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230925050545.30912-1-nbowler@draconx.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:89cc:78d2:7179:5c3b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/8] SPARC VIS fixes
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 25/09/2023 06:03, Nick Bowler wrote:

> I noticed that the fmul8x16 instruction did not appear to be emulated
> correctly[1].  It would seem that emulation was not using a single-
> precision input register like the real hardware does, but rather a
> double-precision register, causing it to operate on the wrong data.
> 
> Every other VIS instruction which contains one or more single-precision
> inputs and a double-precision output has the exact same problem.
> 
> A few computational problems are found and fixed by this series too.
> 
> All patches can be applied independently, except patch 2 adds some
> helpers which are subsequently needed by patches 3, 4 and 5.
> 
> Emulation results are tested by manually comparing the output of a small
> Linux test program on an UltraSparc II against the output of running the
> same binary under qemu-sparc32plus on a ppc64le host system.
> 
> [1] https://gitlab.com/qemu-project/qemu/-/issues/1901
> 
> Nick Bowler (8):
>    target/sparc: Fix VIS fmul8x16 input register.
>    target/sparc: Fix VIS fmul8x16au instruction.
>    target/sparc: Fix VIS fmul8x16al instruction.
>    target/sparc: Fix VIS fmuld8sux16 instruction.
>    target/sparc: Fix VIS fmuld8ulx16 instruction.
>    target/sparc: Fix VIS fpmerge input registers.
>    target/sparc: Fix VIS fexpand input register.
>    target/sparc: Fix VIS subtraction instructions.
> 
>   target/sparc/helper.h     |  14 ++---
>   target/sparc/translate.c  |  42 +++++++++++---
>   target/sparc/vis_helper.c | 119 +++++++++++++++++++-------------------
>   3 files changed, 101 insertions(+), 74 deletions(-)

Thanks for the patches, Nick. I've had a look at the series, and whilst I'm not 
overly familiar with the VIS instructions, your changes and detailed explanations 
look good against a cursory read of the SPARCv9 specification.

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

I'll wait a few days to see if either Artyom or Richard has any further comments, but 
if not then I'll queue them to my qemu-sparc branch.


ATB,

Mark.


