Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0A7A06913
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Jan 2025 23:58:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVezs-0004rZ-9m; Wed, 08 Jan 2025 17:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tVezp-0004rP-UZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:57:53 -0500
Received: from dormouse.elm.relay.mailchannels.net ([23.83.212.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tVezn-0005E3-VA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:57:53 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id E8590163EE7;
 Wed,  8 Jan 2025 22:57:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a296.dreamhost.com
 (trex-2.trex.outbound.svc.cluster.local [100.111.51.238])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 7AD60164025;
 Wed,  8 Jan 2025 22:57:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736377069; a=rsa-sha256;
 cv=none;
 b=MNECF7wlzN3iMv8afHOdtIpwHkJ9gPvc7gcjQo1aQsEkC0twxZY585IlpiOIcxDaDY/tp8
 kNA7+9M4yv9Q8EUqADzxgOAaZDUSbj/0fEZrruI/PrM+ip3eiusVx1LoQp6BsQjOlM9/Qt
 /6A48Oc5HN9Qyz41uBcAklVrkhiFBYK227Mf6hsCIG0zrAq52L0URpcmx8oxHTK7S6l6Kj
 eYJed/MaeWqGRVWzKuJm/UC3ANTspM/Y5hYNzx3vA5erlddvebdeEBDWfMgNT7mmEmO1nt
 /KgBzdw8xHuqVZRXIfkRysHHuNvYvkXxOu8hgQH9NqrCi16hShg2fIYUkg9oKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1736377069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=85UeQmHRXWYgBxJkGx3G4QZkt8zTFOxNWlCoPlYO/Pg=;
 b=3koJHSDKL3cHEQSE+S2xAjbA4T6yI58tNBBTgzLt4uJBXGvr0hCh/CBWMLjdUHHXQ00QUP
 2hluwSx6iEpSFt+Gf5Cyky9vAk4BA4mDiU+4tKk1oXLhO7QzYacT5C2Jvs8jzO9Ujyi0hq
 8bDxS6bMefn66hzhLZPT/sP3gpChlW95uXtbQiDaTXldrEW9KKZ86h3UN/kwct7gRbKu5c
 eCZArDCAN5C9x942Cs45PeOrRtPfCLJxZRhfmN2nnKJA2LV4EapO1cL0MJhKi7hFghenAr
 K/s895JckwE8n19pSgvGS9H0wglF5NUslxdYPB1+lz5cTQRBJ0uQNRC1cSLYkA==
ARC-Authentication-Results: i=1; rspamd-b5645c5d4-2sk9h;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Stretch-Befitting: 7aac2cce210809f7_1736377069768_1020453084
X-MC-Loop-Signature: 1736377069768:233838770
X-MC-Ingress-Time: 1736377069767
Received: from pdx1-sub0-mail-a296.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.51.238 (trex/7.0.2); Wed, 08 Jan 2025 22:57:49 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a296.dreamhost.com (Postfix) with ESMTPSA id 4YT3Gh0sLNz1h; 
 Wed,  8 Jan 2025 14:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1736377068;
 bh=85UeQmHRXWYgBxJkGx3G4QZkt8zTFOxNWlCoPlYO/Pg=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=Ga8i61R+lZjK/PIKtIPx9VzvEQyiOJUIv6Xz2S6SpDImvA6S8eQ1WkV4MehIzE2ZR
 oTTKGICHCBuZh08K9D4T97kcYI2zyo6RNSilaw7+dTiP6iZR1bzlR3U96C8BZ71vQJ
 Tfe5XVMBpOVHDCS7ueq2gURzdfP911rJzbt8Xk2beyDJGYeXkFMOjOySpA7Rn1UKUx
 AZ7SumTzQUJ84Z/waCvprbnao0AXptFe870xsC3WMfqC4AiTy7hR0hy2gawq9OAuXz
 Y7mgq7MU6WC+VbGfvU5RE7G5EDzmu00DrEDnTzNucA/wKJ/OG1WDxvpARfisVT33MQ
 Ja0Ca9QUIcA1Q==
Message-ID: <c5efb6af-5fef-4938-aac9-c9c8b75a9a69@landley.net>
Date: Wed, 8 Jan 2025 16:57:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: or1k -M virt -hda and net.
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec> <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec>
 <87y0zmbita.fsf@draig.linaro.org>
 <e2f1c14c-f5d2-48f3-bb6e-d1db0ce6d1fa@landley.net>
 <6e5f24cf-02bf-1cf0-2d0d-e683866cc3d3@eik.bme.hu>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <6e5f24cf-02bf-1cf0-2d0d-e683866cc3d3@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=23.83.212.50; envelope-from=rob@landley.net;
 helo=dormouse.elm.relay.mailchannels.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 1/8/25 07:01, BALATON Zoltan wrote:
> On Tue, 7 Jan 2025, Rob Landley wrote:
>> What's the alternative to -hda you suggest for that?
>>
>> Can I do "./run-qemu.sh -drive file=blah.img" without the rest? 
>> Perhaps specify all the details in the script and then optionally add 
>> an extra argument at the end? I couldn't get that to work:
>>
>> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device virtio-net- 
>> device,netdev=net0 -drive format=raw,id=hd0 -device virtio-blk- 
>> device,drive=hd0 -drive file=README
> 
> You need '-drive if=none,id=hd0,format=raw,file=README' as a single 
> option not split into two.

I'm not always specifying an -hda. Sometimes it does, and sometimes it 
runs without it. I would like to have everything EXCEPT the media 
specified, so it can be inserted into a ready drive or run without it.

That's what -hda traditionally does.

> With if=none -drive won't auto-create a  device

$ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
virtio-net-device,netdev=net0 -drive if=none,id=hd0,format=raw
qemu-system-or1k: -drive if=none,id=hd0,format=raw: A block device must 
be specified for "file"

> so you then also need a corresponding -device option for the 
> drive that you seem to have already above.

$ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
virtio-net-device,netdev=net0 -device virtio-blk-device
qemu-system-or1k: -device virtio-blk-device: drive property not set
$ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
virtio-net-device,netdev=net0 -device virtio-blk-device,drive=hd0
qemu-system-or1k: -device virtio-blk-device,drive=hd0: Property 
'virtio-blk-device.drive' can't find value 'hd0'
$ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
virtio-net-device,netdev=net0 -device virtio-blk-device,drive=hd0 -drive 
id=hd0,if=none
qemu-system-or1k: -device virtio-blk-device,drive=hd0: Device needs 
media, but drive is empty

That's as close as I can get. As far as I can tell, it's complaining 
that I got it into the state I wanted, and it doesn't want to be in that 
state. The "if=none" does not appear to help.

I also don't know what drive=/id= pair "-hda" would be trying to 
populate, so dunno what name to use there.

Also, it requires -drive and its argument to be seperate:

   qemu-system-or1k: -device=virtio-blk-device,drive=hda: invalid option

Refusing to let them to be glued together with = (like most --longopt 
parsers do, including the 
https://github.com/landley/toybox/blob/master/lib/args.c I wrote) means 
I can't use bash's brace expansion to set up multiple at once (to 
preload support for -hda, -hdb, -hdc, and -hdd), ala:

   -drive=id=hd{0,1,2,3},if=none

Not that the current script has a bash dependency... :P

> If you want -hda to work you 
> may need something like commit d36b2f4e78 (hw/ppc/sam460ex: Support 
> short options for adding drives) for the machine you use. In particular 
> the MachineClass block_default_type field says what's the default 
> interface that -drive and other short options should use (at least I 
> think so, I'm no expert on this either but searching for it should at 
> least point to where it's handled).

Thanks for the pointer, I'll take a look.

Rob

