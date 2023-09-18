Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B40467A502B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:00:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiHas-00063b-SJ; Mon, 18 Sep 2023 12:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qiHak-000638-TW
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:59:22 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qiHai-00072R-SH
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:59:22 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 5426D5C0197;
 Mon, 18 Sep 2023 12:59:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 18 Sep 2023 12:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm1; t=1695056357; x=1695142757; bh=R5
 hb+Vt6oixYYpS1ChQ4DBLQa7gC/witzaYDtwB0GDs=; b=g76cIWvkTt7m80KjWT
 vorb+aXr2++6uudQV9dQmdln/LqhaQWbQmqU56Z1dH3vPzRleO4Gur/GnO4kSJ+7
 WGV35w3n+3YKM5S5HuXOM0R8c5KsZqCZEnmafLadBHJNVKoKne9pkxM98fXXn+We
 BcfvyzKtoFL0mLq9CkcZ8phhwHw2hnCWb6+28UiKGIheZiidB2Zvo7gWcMKgsXG4
 rvpdMaYRwAzqOKzHSLpx4qQI417uRIfq89xkZKmYqM97GwKLn11Dz1hJ0QzjahOM
 C7MQqDuNQQuMhegChQUAGOG+6oFSvAHd8HIlf2AYZTN+2Sct4ehm48SUJZW+L86f
 EJ7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1695056357; x=1695142757; bh=R5hb+Vt6oixYY
 pS1ChQ4DBLQa7gC/witzaYDtwB0GDs=; b=iADai591jEg1/bw007QiCGlm8CTzf
 x+Sr01o+raWk2KfaoYVAPQYNc8kJrhXXsPZROrGPGyf676bzczbs8JSQo78lr2xg
 aw/5nteZEpJQioXzXHyo9CXWS+DeeEZGCxc1Z6AU5Q6F2EHSwWs59NKeISl7FdNr
 z8KHzD4VA8e877xXodQBbun1FmFYSBClZABoIYM539AliTBVAv4YWBLYe1P/qMuC
 xM/I09ylBKtEIuG2VUIo0lZqnVa6rCk0a9pFyPFLfz2FkNe7/9/8ffM5r62vENbJ
 aB7LmdkYk5RHI6Zrq34/XTothS01kbmEFQKBAQh8dTW3E4t3f14dsy3Zw==
X-ME-Sender: <xms:5YEIZdNmQHH-udbiemtLaF0zRyEoULX8Maf-MuW2j-X-fIzWKVf3Jw>
 <xme:5YEIZf91RyFfj0RhTm5KZxYXbBEFmodLQpyVCdgJd79DkKyNB3fu8p7IxT4a5JnR5
 d_snhqugOSrKAe-yw>
X-ME-Received: <xmr:5YEIZcSv5D8_wdZsFj65biwehPUau9JOoDk_WDNn2-bB20X43duHFlSS3EuYhkyT2dWkMHp0N5-xzmQrDUBpqLJu6v8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejkedguddtjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdt
 tddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
 enucggtffrrghtthgvrhhnpedvgfevleejieeiffejhfekvddthfehvdffhefhvdfggeei
 udefteehffelfeeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhqvghmuhdrrh
 hsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugig
 uhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:5YEIZZta3O9kJ6lkT6xunhIpQ71BEnpBC-9-JTZ7kzSYCnjOgGov3w>
 <xmx:5YEIZVeaYUcgGN3zGqFt5vRIhyKcsKPcTnxpX2LY20wh9NJpvuooIg>
 <xmx:5YEIZV19U1CMlNOK0M_WfiPKnb_YZ8C0dicEr5SvbdKa1YPq1tVUAg>
 <xmx:5YEIZc5TdzQwkTZelfckMTMaIhk8qBuJkU7IqtQfBk5jFabJevv4QQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Sep 2023 12:59:15 -0400 (EDT)
Date: Mon, 18 Sep 2023 10:59:12 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Markus Armbruster <armbru@redhat.com>
Cc: kkostiuk@redhat.com, michael.roth@amd.com, berrange@redhat.com, 
 qemu-devel@nongnu.org, hmodi@aviatrix.com
Subject: Re: [PATCH 2/3] qga: Add optional stream-output argument to guest-exec
Message-ID: <pqeqnqiaxafdjif2kkdohyjsqoqrzo35cn75ygoquoucufq2op@yxyxbqr5xuqe>
References: <cover.1695034158.git.dxu@dxuuu.xyz>
 <604ef5fd5bda8acdb837b5d28ec405e9fb0332a3.1695034158.git.dxu@dxuuu.xyz>
 <87il87bjz4.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il87bjz4.fsf@pond.sub.org>
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

On Mon, Sep 18, 2023 at 05:05:03PM +0200, Markus Armbruster wrote:
> Daniel Xu <dxu@dxuuu.xyz> writes:
> 
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
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> 
> [...]
> 
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index b720dd4379..0a76e35082 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -1315,13 +1315,18 @@
> >  # @capture-output: bool flag to enable capture of stdout/stderr of
> >  #     running process.  defaults to false.
> >  #
> > +# @stream-output: causes future guest-exec-status calls to always
> > +#     return current captured output rather than waiting to return
> > +#     it all when the command exits. defaults to false. (since: 8.2)
> 
> So guest-exec-status normally returns no captured output until the
> process terminates, right?  Its documentation (shown below for
> convenience) did not make me expect this!

Right. You can see I made the same mistake [0] quite a few months ago
and realized it some time later.

[0]: https://github.com/danobi/vmtest/blob/73007280446cea3c823eb2dde78261501e6273ab/src/qemu.rs#L368-L406

> 
> > +#
> >  # Returns: PID on success.
> >  #
> >  # Since: 2.5
> >  ##
> >  { 'command': 'guest-exec',
> >    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
> > -               '*input-data': 'str', '*capture-output': 'GuestExecCaptureOutput' },
> > +               '*input-data': 'str', '*capture-output': 'GuestExecCaptureOutput',
> > +               '*stream-output': 'bool' },
> >    'returns': 'GuestExec' }
> 
>    ##
>    # @GuestExecStatus:
>    #
>    # @exited: true if process has already terminated.
>    #
>    # @exitcode: process exit code if it was normally terminated.
>    #
>    # @signal: signal number (linux) or unhandled exception code (windows)
>    #     if the process was abnormally terminated.
>    #
>    # @out-data: base64-encoded stdout of the process
>    #
>    # @err-data: base64-encoded stderr of the process Note: @out-data and
>    #     @err-data are present only if 'capture-output' was specified for
>    #     'guest-exec'
>    #
>    # @out-truncated: true if stdout was not fully captured due to size
>    #     limitation.
>    #
>    # @err-truncated: true if stderr was not fully captured due to size
>    #     limitation.
>    #
>    # Since: 2.5
>    ##
>    { 'struct': 'GuestExecStatus',
>      'data': { 'exited': 'bool', '*exitcode': 'int', '*signal': 'int',
>                '*out-data': 'str', '*err-data': 'str',
>                '*out-truncated': 'bool', '*err-truncated': 'bool' }}
>    ##
>    # @guest-exec-status:
>    #
>    # Check status of process associated with PID retrieved via
>    # guest-exec.  Reap the process and associated metadata if it has
>    # exited.
>    #
>    # @pid: pid returned from guest-exec
>    #
>    # Returns: GuestExecStatus on success.
>    #
>    # Since: 2.5
>    ##
>    { 'command': 'guest-exec-status',
>      'data':    { 'pid': 'int' },
>      'returns': 'GuestExecStatus' }
> 
> Could you throw in a patch to clarify what exactly is returned while the
> process is still running, and what only after it terminated?  It should
> go first.
> 

Yes, will do.

Thanks,
Daniel

