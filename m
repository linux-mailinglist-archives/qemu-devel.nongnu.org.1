Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9677B4942
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 20:40:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qn1Mk-0004Zx-BM; Sun, 01 Oct 2023 14:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qn1Mf-0004NV-Q8
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 14:40:26 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qn1MS-0006qx-Fj
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 14:40:24 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id E38C03200EC7;
 Sun,  1 Oct 2023 14:40:03 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
 by compute1.internal (MEProxy); Sun, 01 Oct 2023 14:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1696185603; x=1696272003; bh=ykRWlExIGWCWCb9LHuRKNDqYKA/JL+N+Q4q
 c1q+rgVA=; b=XZ0a6kqz5wxaClaSGuPbHpocGdtwAJerPX552GkU+xxCW2/4eZs
 A/V97o1p6aFr7M83g1GckqrNWrc1+vLby7KZDRqlW2mhzmRW8wJgW10psveEa7AU
 1ZLOHM3tR6YHit6gslvkHkoSevE5+Vp+9kH8TsmmWshnvB1H3glexWBEIap35w4t
 1uMHkIP0INLkUTUMIT1oS3WFX6fW9RPYHPsimo+CLmiBmPFp7NNl4VpwGseuxVpE
 w3CM2F6/fQsTMHT/gza4yhficIf9ufDGfhpsc+KB+iJHd/vVjX3VSAei8V4GXXwn
 wPcSfjtQjtzuUfYyep7UsW1uXmNUMU1VU7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1696185603; x=1696272003; bh=ykRWlExIGWCWCb9LHuRKNDqYKA/JL+N+Q4q
 c1q+rgVA=; b=N+QHEAWpdQrzP7Thp6i8Z/d73Fw8yZc3FoK/ldLcnVqWq85SANy
 P9q4Vedccbe49JeasC6CmCArBG210iG+O9v+oRTPktCyQWsXtuSYbfqNuT5amHV2
 fQ4WirVVlxzBjv0In33KSX2Fn3LmBc3SHQgAiLIgYVIhNzZZXPw5tavZJSz7STb1
 0bsOVaFH8fYV460IrfvzFEcyckrJf2+qp6m3c4ANW8ehk5UfYsu1Bm5o6mknfGG+
 FTUgC1oW6fdApzPP8CAChP6exhnulw2UgNNVR1qTbz5K7ASwr8F4sb4Raicw4Pfn
 wR8XXO7Y6ZRkcf+vt/QLz7cN/YkC0sj1Osw==
X-ME-Sender: <xms:A70ZZdyhENqCnN7aEveycxTWG_kOn5U4oVZ9pVTP385K9GlU7s9fsA>
 <xme:A70ZZdSuRhFvdiSdISEANNQXFNVB3jFXBLpKmRZvFubSK3EYR300lsGW7HiTBFqNj
 osguvmiPzKCGxx9Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefgddtudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
 hrlhcuvffnffculddvfedmnecujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredt
 reerjeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
 iiqeenucggtffrrghtthgvrhhnpefffefgiedutdeffeelgefhkeelheetteelgeeffeeg
 leduueeitdejhfffueejheenucffohhmrghinhepshhtrggtkhhovhgvrhhflhhofidrtg
 homhdpfhgvughorhgrphhrohhjvggtthdrohhrghdpugiguhhuuhdrgiihiidpghhithhh
 uhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:A70ZZXVA-9aov7-v6WYz0SMhzLRudGacFJKxV-DojqG2XWYq1g72Og>
 <xmx:A70ZZfj7omus3f2lmSvOTzfdwViy-CcWSWfkmuGTUdhO26Rh1EGzHQ>
 <xmx:A70ZZfDcqdefxIBxP4Gujd2cL6JAkmv9VFi__x3bJ8mpJ0FXkN-5Xw>
 <xmx:A70ZZWNCWFGoQebUqTpZIbXmS23WcbZpPgYjjZ7Fejg5hOfh8GtZIQ>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 2BB1EBC007C; Sun,  1 Oct 2023 14:40:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <9e3054e9-74c1-42f2-abf1-fd2f4c91557b@app.fastmail.com>
In-Reply-To: <CAPMcbCojC=R0mr5dMqdoJUzw5-RoeydsK0io3vpzO_qo-A27Yw@mail.gmail.com>
References: <cover.1695034158.git.dxu@dxuuu.xyz>
 <604ef5fd5bda8acdb837b5d28ec405e9fb0332a3.1695034158.git.dxu@dxuuu.xyz>
 <ZQhpZ+2doxD7vaR8@redhat.com>
 <qelgz7ljf5ooc6mkdzeikodf35cc77anowtm34b6rhgr4qpdcz@zdvjnj67jyfo>
 <CAPMcbCojC=R0mr5dMqdoJUzw5-RoeydsK0io3vpzO_qo-A27Yw@mail.gmail.com>
Date: Sun, 01 Oct 2023 12:39:42 -0600
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Konstantin Kostiuk" <kkostiuk@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 michael.roth@amd.com, qemu-devel@nongnu.org, hmodi@aviatrix.com,
 "Yan Vugenfirer" <yvugenfi@redhat.com>
Subject: Re: [PATCH 2/3] qga: Add optional stream-output argument to guest-exec
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.20; envelope-from=dxu@dxuuu.xyz;
 helo=wout4-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi Konstantin,

On Wed, Sep 27, 2023, at 2:43 AM, Konstantin Kostiuk wrote:
> Hi Daniel,
>
> As for me, the idea of using QGA as an interactive shell is not good.
> I suggest using virtio-serial as a transport for stdin/stdout of your=20
> process.=20
> Examples:
>    =20
> https://stackoverflow.com/questions/68277557/qemu-virtio-virtconsole-d=
evices-explained
>     https://fedoraproject.org/wiki/Features/VirtioSerial
>
> Is this solution good for your project?=20
>
> Best Regards,
> Konstantin Kostiuk.

Thanks for the tip. It looks like that'll work -- I'll look into it.

Daniel

>
>
> On Mon, Sep 18, 2023 at 8:17=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrot=
e:
>> Hi Daniel,
>>=20
>> On Mon, Sep 18, 2023 at 04:14:47PM +0100, Daniel P. Berrang=C3=A9 wro=
te:
>> > On Mon, Sep 18, 2023 at 04:54:22AM -0600, Daniel Xu wrote:
>> > > Currently, commands run through guest-exec are "silent" until they
>> > > finish running. This is fine for short lived commands. But for co=
mmands
>> > > that take a while, this is a bad user experience.
>> > >=20
>> > > Usually long running programs know that they will run for a while=
. To
>> > > improve user experience, they will typically print some kind of s=
tatus
>> > > to output at a regular interval. So that the user knows that their
>> > > command isn't just hanging.
>> > >=20
>> > > This commit adds support for an optional stream-output parameter =
to
>> > > guest-exec. This causes subsequent calls to guest-exec-status to =
return
>> > > all buffered output. This allows downstream applications to be ab=
le to
>> > > relay "status" to the end user.
>> > >=20
>> > > If stream-output is requested, it is up to the guest-exec-status =
caller
>> > > to keep track of the last seen output position and slice the retu=
rned
>> > > output appropriately. This is fairly trivial for a client to do. =
And it
>> > > is a more reliable design than having QGA internally keep track of
>> > > position -- for the cases that the caller "loses" a response.
>> >=20
>> > I can understand why you want this incremental output facility,
>> > but at the same time I wonder where we draw the line for QGA
>> > with users needing a real shell session instead.
>>=20
>> You mean interactive shell, right? If so, I would agree an interactive
>> shell is not a good fit for QGA.
>>=20
>> But as it stands, a non-interactive shell works quite well (having
>> guest-exec run a bash script). I was the one who added the merged out=
put
>> stream support a few months back. With merged output streams and this
>> streaming support, you can do some really neat things with QGA (see
>> below).
>>=20
>> The primary reason I'm adding this support is for vmtest [0]. You can
>> find code for it here [1]. Basically what leveraging QGA does is allow
>> the vmtest implementation to reuse the same code for both kernel-only
>> (ie bzImage) and and image targets (eg qcow2).=20
>>=20
>> [0]: https://dxuuu.xyz/vmtest.html
>> [1]: https://github.com/danobi/vmtest
>>=20
>> >=20
>> > When there is a long lived command, then IMHO it is also likely
>> > that there will be a need to kill the background running command
>> > too.
>> >=20
>> > We quickly end up re-inventing a shell in QGA if we go down this
>> > route.
>>=20
>> I can understand if you don't want to bloat the QGA feature set, but
>> IMHO this change cleanly composes with the current implementation and
>> is easily unit testable (and comes with a test).
>>=20
>> Per the discussion in the other thread, it could be argued that this
>> streaming feature is actually a bug fix -- the documentation seems to
>> imply otherwise, which both Markus and I have independently arrived
>> at. But I don't think we need to go into semantics like that :) .
>>=20
>> But it does kinda imply from first principles that it is a reasonable
>> thing for guest-exec-status to provide. Perhaps it's too late to chan=
ge
>> the existing behavior, so a flag is needed.
>>=20
>> I hope my reasoning makes sense. And thanks for giving this a look.
>>=20
>> Thanks,
>> Daniel
>>=20
>> [...]
>>

