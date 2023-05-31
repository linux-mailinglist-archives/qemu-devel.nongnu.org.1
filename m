Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D7671883F
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 19:14:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4POB-0004Nc-C4; Wed, 31 May 2023 13:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@xora.org.uk>)
 id 1q4PO9-0004NS-Gl
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:13:33 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@xora.org.uk>)
 id 1q4PNz-0005qf-4E
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:13:33 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 5D41C32004E7
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:13:21 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
 by compute2.internal (MEProxy); Wed, 31 May 2023 13:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xora.org.uk; h=
 cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1685553200; x=1685639600; bh=nX
 ktaqT76b7N844NIvw2Pq4AjUek9vKhA0l7/u2Tu+I=; b=qJoCtlaelBgu4ZRzio
 gTZc337aQeKXKP9TkzjfEVn2PpOmbNf9xydZo0E1CI10JE91tScj4ygaX721Ct5y
 h5RG3tHcsdwdE0K96RrvKqXvLFaAgeUt5lgG+DsxpPG15tk8J5JUx0aw7EvHAAex
 s0+EbjPbWioQH+kWm4qQvGK7qFW1PSYQBfTQLVaQkABR5JuzhLC+vm4s8yrvXK5k
 HpnJNynKF+WzYOl1xX/CwD5fLkdWPPgPKT/S28aiO8/PUopvyVNXCkro8L6Lmp9C
 1Ik3b7SBcVf9dDDEBgvT1Y45nSJvt0oS/NBe9AtH3fi1Rej3kvv4AefPkiB69VDH
 4oHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1685553200; x=1685639600; bh=nXktaqT76b7N8
 44NIvw2Pq4AjUek9vKhA0l7/u2Tu+I=; b=XZjjz9lc4cU3ZPE28smh7WpplPHc0
 vSdj3ukmRLmqwtNoqd7xfmz634FVCA1TrsPmDeiYrvzCTRDYXaSZYnA/mzZuVkl3
 c5qxzcNCJ6uMoXHwxadKHUKf0XcFTcqqIA1btaVvxXGqhQ6CB0PWWhCw1t98DAg0
 AGHHH7w2wY6IauO0yvUAC+WifYv6+ornQXBt2ZzYhaXa6PqkWTzyhNic2SwYcV57
 M8sovGV9GjuohdpB+F0WOZiytMaEUOF5NgYbNuLDX2VO/AYR3//4sfZ2HB+4lHBn
 fXifWNnS/pZdvUOBZ5Ck3CRqXkF/z0CTYc6hwaNTzLRnrgXhyurwJuenw==
X-ME-Sender: <xms:MIB3ZC2V066LhldCgekjjemgb520KY1wqgNwE2COAhFLt283JmfNeA>
 <xme:MIB3ZFEOj1vsudcIBeTTz62S16RBueR2hGw1R7xDQzH2wcm-HGjMHsg0UiPX8IEKo
 4_7SlhdbXiBF8A_Ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledguddtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesth
 dtredtreertdenucfhrhhomhepfdfirhgrvghmvgcuifhrvghgohhrhidfuceoghhrrggv
 mhgvseigohhrrgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeejueejtdfgveehfe
 evkeegveeifedvvdehgffgtddvieehffeggeefueeludfhgeenucffohhmrghinhepghhn
 uhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehgrhgrvghmvgesgihorhgrrdhorhhgrdhukh
X-ME-Proxy: <xmx:MIB3ZK420urK6csBQFMEAwZg7jOtU40EqMx_IslEAY2vKxGJ5DEdDA>
 <xmx:MIB3ZD0I7Wmz9XQeEG99RHyzd-reqTllHxj_Mex2RZ3Wq_WIi2ZlCQ>
 <xmx:MIB3ZFEU08mpVG1tQJKxO3AKlnZMx0Hi4b2hOnH_Sz47dh9ixPAdZQ>
 <xmx:MIB3ZJSYvgHJ_4cs6xaOdD5iNHl-QMp0RO-Ril2TcYke6vbbRFkWrQ>
Feedback-ID: i62f7400e:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id B862E234007B; Wed, 31 May 2023 13:13:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <7cadffff-939a-4ee9-9e46-16c5be011a15@app.fastmail.com>
In-Reply-To: <b663fb55-dc8e-9fd8-9d82-7e693c3c4ad3@quicinc.com>
References: <20230531070229.334124-1-wangyuquan1236@phytium.com.cn>
 <20230531070229.334124-2-wangyuquan1236@phytium.com.cn>
 <lfcmvvqjp64wngrdk33bvkb3k7op53l24lcoslah2evsyh3esc@at7jnsnrto7h>
 <CAFEAcA8h9-YWUYsvuERttmsEK3xi+K+xasFdoWmnFm26S6npNw@mail.gmail.com>
 <b663fb55-dc8e-9fd8-9d82-7e693c3c4ad3@quicinc.com>
Date: Wed, 31 May 2023 18:12:59 +0100
From: "Graeme Gregory" <graeme@xora.org.uk>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Content-Type: text/plain
Received-SPF: pass client-ip=64.147.123.20; envelope-from=graeme@xora.org.uk;
 helo=wout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On Wed, 31 May 2023, at 5:36 PM, Leif Lindholm wrote:
> On 2023-05-31 16:27, Peter Maydell wrote:
>> On Wed, 31 May 2023 at 15:58, Graeme Gregory <graeme@xora.org.uk> wrote:
>>>> The current sbsa-ref cannot use EHCI controller which is only
>>>> able to do 32-bit DMA, since sbsa-ref doesn't have RAM above 4GB.
>>>> Hence, this uses XHCI to provide a usb controller with 64-bit
>>>> DMA capablity instead of EHCI.
>>>
>>> Should this be below 4G?
>> 
>> It would be pretty disruptive to try to rearrange the memory
>> map to put RAM below 4GB at this point, though in theory it's
>> possible I guess. (I have a vague recollection that there was
>> some reason the RAM was all put above 4GB, but can't find
>> anything about that in my email archives. Perhaps Leif remembers?)
>
> I think Graeme was just pointing out a typo in Marcin's email.
>

Yes the typo!

Graeme

> Yeah, we're not changing the DRAM base at this stage.
> I think the reason we put no RAM below 4GB was simply that we had 
> several real-world platforms where that was true, and given the intended 
> use-case for the platform, we explicitly wanted to trigger issues those 
> platforms might encounter.
>
>>> Also has EHCI never worked, or has it worked in some modes and so this
>>> change should be versioned?
>> 
>> AIUI, EHCI has never worked and can never have worked, because
>> this board's RAM is all above 4G and the QEMU EHCI controller
>> implementation only allows DMA descriptors with 32-bit addresses.
>> 
>> Looking back at the archives, it seems we discussed XHCI vs
>> EHCI when the sbsa-ref board went in, and the conclusion was
>> that XHCI would be better. But there wasn't a sysbus XHCI device
>> at that point, so we ended up committing the sbsa-ref board
>> with EHCI and a plan to switch to XHCI when the sysbus-xhci
>> device was done, which we then forgot about:
>> https://mail.gnu.org/archive/html/qemu-arm/2018-11/msg00638.html
>
> Ah, thanks! That explains why we did the thing that made no sense :)
>
> To skip the migration hazard, my prefernece is we just leave the EHCI 
> device in for now, and add a separate XHCI on PCIe. We can drop the
> EHCI device at some point in the future.
>
> /
>      Leif

