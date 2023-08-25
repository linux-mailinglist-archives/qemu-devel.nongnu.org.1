Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF53D7880AF
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:12:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZQz8-0005Dd-W6; Fri, 25 Aug 2023 03:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qZQz6-0005DR-CU
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:11:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qZQz2-0001r9-HB
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:11:56 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id EF8265C025C;
 Fri, 25 Aug 2023 03:11:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Fri, 25 Aug 2023 03:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1692947508; x=1693033908; bh=6o
 n9q3lVlCyOn5S4oc/hAZl3BLN2bEfmSyuuXySfHEk=; b=O1TOu+QDsURyXr96va
 OUgcFdbj/uab6bZe/PH+wRkgb3nRUp2WZi6Lw10VJ2ClvlWas4MqzI3TRAgH1iTq
 z/8aUDDDHlc0LAMaIBebhOfS0TXSf42J+O6tg6Tx4uwKwNwPNA5MIv23O9JLHhsU
 N0wuYD68LZEoWONGDqQxTmbeVbO3/9HKCiP3R6ShQcxSj6tZ5kBoWHVD0i23xT+s
 RfGZWxHumrNJEa4yaEn8rTjvlWIi9y4+H4RtNQTxbH5iiDhrSoAWVO2XuTvSNRfl
 5/upIiQtr0e1f/H1CYRvn7GmJTGmFQbNcfxmm1zMaG1SbEKuE6305vOzwzjU+mnd
 hZ4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1692947508; x=1693033908; bh=6on9q3lVlCyOn
 5S4oc/hAZl3BLN2bEfmSyuuXySfHEk=; b=ArXpw8QxN3YfYQGRXHMs5h+1OVoTl
 W+DPyqhFHWFS1s/NbwpjbLZDqtgKKbzVYSqjNlblbTtOihJxgHsdRgOdt0zQHtdv
 K8YulKHN2cO5KbwpN2z5fnG4vF5bp48UJz7cRqOyfT4kwU3c6FC7AYGPbGmxqg2P
 RlbSgGpDkRP86vKCisLrYSQLYqqR8pJAe3MZIht6Ut1pefwY3emyuVG2fK9eJ4g9
 vPL4+zu+ZkwaPrVYruGNA1nCHt+ehVomDoLzc72+wrAMADQs3qiBpw0uUdsZRfFn
 FPSWSxW2mgxbeNSCi0Vi8nnjAJSqRq2uYhEnWWzp1hu4PBswYBGdwwg0A==
X-ME-Sender: <xms:NFToZEwQi4kkiRd8Sllue21cHJOrtz4jhaIaNTcuM8j4dIZSkBAOHw>
 <xme:NFToZIRU4LZtjDNltq5KA9Fl8D1LYkkPiYS7CO3im2PvauxoNFgLn3B0xr0HdLOqi
 6o-yBa8vhBYNL4hdQ>
X-ME-Received: <xmr:NFToZGXsgsKLhTLMHLhjfWlwbYjMrum-vpED_DERRlLJKTpLrhMzmOVKaxesAEHfjaqTEfNV-kNFR8bGdVk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvjedgudduiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufgjfhffkfggtgesghdtreertddtjeenucfhrhhomheptehlhihs
 shgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepie
 elvefggefhieejfffhueelkeefleffgefgvdegfefhudejffdtfefhheejtdejnecuffho
 mhgrihhnpegtrhhrvghvrdgtohhmpdgtrhhoshhvmhdruggvvhenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:NFToZCjRIDpXyb4ngpwQwK-Ap9uVKZnII9ohQtHr8WnFGfhNCdyuYw>
 <xmx:NFToZGDCBvk1MhNdOiumOTYwgQRaDcNSpln9IJTLxeD8q4adGOTFaw>
 <xmx:NFToZDKf6QtZIDsG20aV-O889sYT-W9VJZ8oSyyGN8P8oFQgtDcnFg>
 <xmx:NFToZC24iZ4Vw7TZU80JLix06Iq08czadJsRrxK0UTpbkyuvjXhLQg>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Aug 2023 03:11:48 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id B5294809C; Fri, 25 Aug 2023 07:11:45 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 philmd@linaro.org
Subject: Re: [PATCH v11 0/9] rutabaga_gfx + gfxstream
In-Reply-To: <CAAfnVB=qW99pYK04g6ZdM+c8HLLmE5kwc_UWyJgRVSPnGB84=g@mail.gmail.com>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
 <87a5uiyq35.fsf@alyssa.is>
 <CAAfnVB=qW99pYK04g6ZdM+c8HLLmE5kwc_UWyJgRVSPnGB84=g@mail.gmail.com>
Date: Fri, 25 Aug 2023 07:11:43 +0000
Message-ID: <871qfriok0.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=66.111.4.25; envelope-from=hi@alyssa.is;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gurchetan Singh <gurchetansingh@chromium.org> writes:

> On Wed, Aug 23, 2023 at 4:07=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
>> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>>
>> > - Official "release commits" issued for rutabaga_gfx_ffi,
>> >   gfxstream, aemu-base.  For example, see crrev.com/c/4778941
>> >
>> > - The release commits can make packaging easier, though once
>> >   again all known users will likely just build from sources
>> >   anyways
>>
>> It's a small thing, but could there be actual tags, rather than just
>> blessed commits?  It'd just make them easier to find, and save a bit of
>> time in review for packages.
>>
>
> I added:
>
> https://crosvm.dev/book/appendix/rutabaga_gfx.html#latest-releases-for-po=
tential-packaging
>
> Tags are possible, but I want to clarify the use case before packaging.
> Where are you thinking of packaging it for (Debian??)? Are you mostly
> interested in Wayland passthrough (my guess) or gfxstream too?  Depending
> your use case, we may be able to minimize the work involved.

Packaging for Nixpkgs (where I already maintain what to my knowledge is
the only crosvm distro package).  I'm personally mostly interested in
Wayland passthroug, but I wouldn't be surprised if others are interested
in gfxstream.  The packaging work is already done, I've just been
holding off actually pushing the packages waiting for the stable
releases.

The reason that tags would be useful is that it allows a reviewer of the
package to see at a glance that the package is built from a stable
release.  If it's just built from a commit hash, they have to go and
verify that it's a stable release, which is mildly annoying and
unconventional.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmToVC8ACgkQ+dvtSFmy
ccDmpA/9EWqM31u5GydYNUnvw0/0LPGNTsAWFqfVMizxEq2ntlrYg9HpN92qbvcF
ayZn/jxRrQ3fbxdCZ2jjTTdZ4lU6268iVSjr6R7ln1Q4iFENGmXj5bpXbG6lb88Q
D8BK6XM2Bg1ogXLb7CVawoF4GnYKIQiPEk5xIIJd/VUnQoY3G/FOzBjZsTuFJC/n
3CJoT+dUj3gWoH0PLlGaCOHivXkinYwDXYaAcanTxgDhR1QbvWqy+2BCuQzdd2C+
U0lL7PxMHPgxgBl4W8wsl7xMftKbRhC+NTVGEegTNSxI3fi1NO6ucoiEGXQTuQQV
zcgWqYqH2VJu+lMt7uHHqeHwOkuIVN6rxhFwSO/wwd9ARiE9Ol5RT4yJSAf6DSHA
9dWvhJLQ5VgdykphCrEhsNGVqv8GvdFOZYJsZEa0oYjFRBbOhMJFFG5zS/u7787S
tu47nj91fSPVbJx8LH7jLyd5YCtuHN9a7F6z+IXckeFUPVZZhDCqp0fXjPyfij71
mkkTWWEA/0MClC22fHFGmEl7Uk2HlXXaBntj1VbmQHbWVfIoRJRdYer3uQtEaTAI
AYZ11A/9hu0HvSUyAG5p2/dnmDOlJr9VTYbvkEpB9CPjvKeWYbAp7YrCwLvTv8ov
KcfKyEKFL5q6OjCZBoP9mDCGPzmFmh7HfKh717Ns6nk7JO6y1bY=
=2bpb
-----END PGP SIGNATURE-----
--=-=-=--

