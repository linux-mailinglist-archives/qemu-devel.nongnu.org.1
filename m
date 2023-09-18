Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C47757A50D0
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:18:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiHse-0001hC-W5; Mon, 18 Sep 2023 13:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qiHsc-0001h3-BW
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:17:50 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qiHsZ-0002Un-2h
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:17:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 076595C0158;
 Mon, 18 Sep 2023 13:17:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Mon, 18 Sep 2023 13:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1695057464; x=1695143864; bh=PF65YShs93YbQybvU96p76HADggw+UO/SMe
 5bLKxSYI=; b=drAPAvhRYQAhMqbm6aenJed2sVdQUDuDr6asMN4/+xh3BkLlW0t
 170+IQsKQ05JepL5AMqWCXZMmJbb15O51zZuoJbLHU6hu+ejGxg4bl4GJcN2Hw6Z
 HQO3ekthQAMET4nVq7LM5BdgbhHA/xgdT9OT1hPBVVqUqibZN3GrPvPrdaakr4XZ
 /9DQpZRu6SIs+gSWeLVOpy+m2SmFESug5ecAxp14W8LCoHVF4NZxaO/v80Ojy1J0
 /+PfxFmGbab+pf0859pJR/Vy/qardUc+k4lJFQkcKctW2ud6HuYRnEeTCAMrt0AZ
 QqydX9fSHHAwnTpatWsE1W7P52chBD9osJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1695057464; x=1695143864; bh=PF65YShs93YbQybvU96p76HADggw+UO/SMe
 5bLKxSYI=; b=abthYUX23zW+0tUxy6o69yUTAR8dE4iaqEeJmBdQX0sSNqy0tD/
 3MCxyQAmGqyNoEspe91hKLtM8oTF9TzGp+erGfByP5SXGpyNIXVpKFk8lAGTpnpe
 zTDePOFHtxn5+nRfsCkh6v3KR7zwWKPhNoXPjBluNzDKQv9d/eC5HtGgzkj+GmSf
 tglxiFmFROd01zCQUBeGzLEsHgzuBYcfPQfCb9JCZzTBLA6Rrbx6kMHrQEA/CRaQ
 C2EBBAgfQlEyxy83TLq6ML/jMRuLdyEMqPc+cwa8ez4YrvY4f7lFyBpRi++PI8m3
 GDc83uRhcY7XCrr2qG2vZqznpOEo2i6WXYg==
X-ME-Sender: <xms:N4YIZeKPR1moXcVPtEdoqdaP4fhVqAIePF5mbfTdouuZmNtUQNOkMg>
 <xme:N4YIZWJrCzewrYUW-VNeyYuaeYMKwBnPekmaPXWBHP0hxBPokPPGaqv-cz6XyJPKG
 t9OlGdnE4TjTjC3fQ>
X-ME-Received: <xmr:N4YIZescD6TTlxft-62r7kYO0VMXlds9_995kvZcZo2vz0kT29bAtmisoq0GdrZXJw0K8eSSGR1jWyur6iwZc7ZMAko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejkedguddutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
 tddttddunecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
 eqnecuggftrfgrthhtvghrnhephefggfekkeelleduvdegtdegjeefjedtffehgeeguedt
 ueegudevgfelgeetheelnecuffhomhgrihhnpegugihuuhhurdighiiipdhgihhthhhusg
 drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:N4YIZTbe8SUd4jSeNq74erJaMYFN1fhSsR41_j5b1R1nSTkUwBcn5Q>
 <xmx:N4YIZVblq1_IdWOQ1z_yrI0i7Zu2Cq06oOGnjUpcSGqPrHhBzpZ9AQ>
 <xmx:N4YIZfCFaqwKK1Qg_IKFdNRxdxrvxqG6to2LLNw4Qv18X80MtUz57g>
 <xmx:OIYIZZG5Q7QHSCWPqR9P7IREDUX-ZFHbrD3s5TikRdPjUAATYRbXww>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Sep 2023 13:17:42 -0400 (EDT)
Date: Mon, 18 Sep 2023 11:17:39 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: kkostiuk@redhat.com, michael.roth@amd.com, qemu-devel@nongnu.org, 
 hmodi@aviatrix.com
Subject: Re: [PATCH 2/3] qga: Add optional stream-output argument to guest-exec
Message-ID: <qelgz7ljf5ooc6mkdzeikodf35cc77anowtm34b6rhgr4qpdcz@zdvjnj67jyfo>
References: <cover.1695034158.git.dxu@dxuuu.xyz>
 <604ef5fd5bda8acdb837b5d28ec405e9fb0332a3.1695034158.git.dxu@dxuuu.xyz>
 <ZQhpZ+2doxD7vaR8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQhpZ+2doxD7vaR8@redhat.com>
Received-SPF: pass client-ip=66.111.4.29; envelope-from=dxu@dxuuu.xyz;
 helo=out5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Daniel,

On Mon, Sep 18, 2023 at 04:14:47PM +0100, Daniel P. Berrangé wrote:
> On Mon, Sep 18, 2023 at 04:54:22AM -0600, Daniel Xu wrote:
> > Currently, commands run through guest-exec are "silent" until they
> > finish running. This is fine for short lived commands. But for commands
> > that take a while, this is a bad user experience.
> > 
> > Usually long running programs know that they will run for a while. To
> > improve user experience, they will typically print some kind of status
> > to output at a regular interval. So that the user knows that their
> > command isn't just hanging.
> > 
> > This commit adds support for an optional stream-output parameter to
> > guest-exec. This causes subsequent calls to guest-exec-status to return
> > all buffered output. This allows downstream applications to be able to
> > relay "status" to the end user.
> > 
> > If stream-output is requested, it is up to the guest-exec-status caller
> > to keep track of the last seen output position and slice the returned
> > output appropriately. This is fairly trivial for a client to do. And it
> > is a more reliable design than having QGA internally keep track of
> > position -- for the cases that the caller "loses" a response.
> 
> I can understand why you want this incremental output facility,
> but at the same time I wonder where we draw the line for QGA
> with users needing a real shell session instead.

You mean interactive shell, right? If so, I would agree an interactive
shell is not a good fit for QGA.

But as it stands, a non-interactive shell works quite well (having
guest-exec run a bash script). I was the one who added the merged output
stream support a few months back. With merged output streams and this
streaming support, you can do some really neat things with QGA (see
below).

The primary reason I'm adding this support is for vmtest [0]. You can
find code for it here [1]. Basically what leveraging QGA does is allow
the vmtest implementation to reuse the same code for both kernel-only
(ie bzImage) and and image targets (eg qcow2). 

[0]: https://dxuuu.xyz/vmtest.html
[1]: https://github.com/danobi/vmtest

> 
> When there is a long lived command, then IMHO it is also likely
> that there will be a need to kill the background running command
> too.
> 
> We quickly end up re-inventing a shell in QGA if we go down this
> route.

I can understand if you don't want to bloat the QGA feature set, but
IMHO this change cleanly composes with the current implementation and
is easily unit testable (and comes with a test).

Per the discussion in the other thread, it could be argued that this
streaming feature is actually a bug fix -- the documentation seems to
imply otherwise, which both Markus and I have independently arrived
at. But I don't think we need to go into semantics like that :) .

But it does kinda imply from first principles that it is a reasonable
thing for guest-exec-status to provide. Perhaps it's too late to change
the existing behavior, so a flag is needed.

I hope my reasoning makes sense. And thanks for giving this a look.

Thanks,
Daniel

[...]

