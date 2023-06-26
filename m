Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DE773D784
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:05:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfFc-0006Vx-2t; Mon, 26 Jun 2023 01:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flwu@google.com>) id 1qDfFV-0006An-6Z
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 01:58:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flwu@google.com>) id 1qDfFT-0007r1-12
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 01:58:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-311394406d0so2391931f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 22:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1687759128; x=1690351128;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gNyRnvGL8Sl91bWJVZRjV4lwFGyjAAmu8ggpp8qFns0=;
 b=tDf7nbrKrrrBPX5n9gQkhXELueB0R7yWxNiT5z++7L7MCqeM5TGAA2RR65PehH/9KK
 nLPGD/bUh4QXZnM4U8NODcIROnsiVZKeHk8W+/YRPGeGK8y1cPR6yubRGVAwmU2PPwGB
 j+DFPNF41V+koqUPpQPj38eSci2g1f07aJ2wGYtauP6gKca7FNzD7n5yuuj4P90HPMkK
 IMm0J8eKmwAXdVMzkVD0aUiz6Obs6FKdvaemCkPfiVo6/stuHeYmMVB4H56drK/9fovV
 lUPdup5WuLYSz1xmYMH56z0G6qLgBIp8V8mDaRUNpPWWG2byBKSzzBmqP7cqMazTqFMn
 1Zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687759128; x=1690351128;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gNyRnvGL8Sl91bWJVZRjV4lwFGyjAAmu8ggpp8qFns0=;
 b=b5IdwnUi6P13E8YUYTnr7oY8AZBIReQr4p1u4eWq7B8yHzl8XCDRgVx7G+WbUQ+K/X
 NzdD1VhKWrWiGXYYYMuZZZjdpq5IKrcs62xiLFv4ox2NSpMaG2NsnX2kbs6ssk/bYJDt
 UuDfjRkYwjWOzNDLWcpVpCmkNrVwdtcb5rRJSgsyZhQCMGQej2ZPUpnKuKfpx/NjwYsz
 JuGb6epYSpLGwDD8kFVqOlmIdusxstTv9tgc0Oh3sCDjYeWVw5IuHHJccKor8wjAac0B
 pLeg+MpzYLB5fq2C18icC2U1BmzDUOUGicohZebrJNcp3II7Qk4jTDtAurglYFMzfVjT
 Algw==
X-Gm-Message-State: AC+VfDz4e4csPOUB3vH1GVhv44j1dorWNZ1gz4OxHS4ZAJOYLLMUCugQ
 VwU67D/pNMhIQwf3PVNOzWVXHHiIF+xiYyOEGg0iTmQUHRIBjyJxZNFhJg==
X-Google-Smtp-Source: ACHHUZ7GMh8xwk1gqJOULUj9Oskt5pCam72NSIOrydZAL4veJABnrk0oW3VvvEBqYQmHjOw3XkznPcFbD4CX0vXNmRg=
X-Received: by 2002:a5d:618b:0:b0:313:f366:2c69 with SMTP id
 j11-20020a5d618b000000b00313f3662c69mr498985wru.46.1687759127713; Sun, 25 Jun
 2023 22:58:47 -0700 (PDT)
MIME-Version: 1.0
From: Felix Wu <flwu@google.com>
Date: Sun, 25 Jun 2023 22:58:36 -0700
Message-ID: <CAJt6XFoT2irgOwtMB2qpgr3Yj6Q-zij_fpD9BL24QvFG7w3zOg@mail.gmail.com>
Subject: Tips for local testing guestfwd
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000046a4c005ff020b50"
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=flwu@google.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--00000000000046a4c005ff020b50
Content-Type: text/plain; charset="UTF-8"

Hi all,

TL,DR: I am working on QEMU ipv6 guestfwd feature and finished coding, and
would like to learn the best practice to test it.
Context: in slirp side this task is tracking by [1].
Currently, I have done following:
i. made char parse + guestfwd functions happy with ipv6 address.
ii. enabled debug print and made sure the ip and port are inserted into the
forward list in libslirp.
To sufficiently verify it's working, I do have three questions:
1. I want to forward a port in the guest (OS in QEMU) to a port 22 on the
host OS, and ssh from guest back to host,
does this sound reasonable? If this is not a good idea, what method is
recommended?
2. I want to understand what ip I should use. Currently I have following
formats for the QEMU invocation in ipv6:
```
guestfwd=tcp:[::1]:1234-tcp:[my:host:ip:from:ifconfig]:22
```
I know the general form is `guestfwd=tcp:server:port-dev`, where
server:port is for guest, dev is for host.
Adding [] in my implementation will let QEMU know it's ipv6.
Is the aforementioned invocation correct? Or in this case [::1] is the
local host address and I should put qemu address
for it instead?
3. Is there a default ipv6 address for QEMU instance? I think I need it in
the invocation.

Thanks in advance! Felix

[1]. https://gitlab.freedesktop.org/slirp/libslirp/-/issues/67

--00000000000046a4c005ff020b50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>TL,DR: I am working on QEMU ipv=
6 guestfwd feature and finished coding, and would like to learn the best pr=
actice to test it.</div><div>Context: in slirp side this task is tracking b=
y [1].</div><div>Currently, I have done following:</div><div>i. made char p=
arse + guestfwd functions happy with ipv6 address.</div><div>ii. enabled de=
bug print and made sure the ip and port are inserted into the forward list =
in libslirp.</div><div>To sufficiently verify it&#39;s working, I do have t=
hree questions:</div><div>1. I want to forward a port in the guest (OS in Q=
EMU) to a port 22 on the host OS, and ssh from guest back to host,</div><di=
v>does this sound reasonable? If this is not a good idea, what method is re=
commended?</div><div><font face=3D"arial, sans-serif">2. I want to understa=
nd what ip I should=C2=A0use. Currently I have following formats for the QE=
MU invocation in ipv6:</font></div><div><font face=3D"arial, sans-serif">``=
`</font></div><div>guestfwd=3Dtcp:[::1]:1234-tcp:[my:host:ip:from:ifconfig]=
:22</div><div><span style=3D"font-family:arial,sans-serif">```</span><br></=
div><div>I know the general form is `guestfwd=3Dtcp:server:port-dev`, where=
 server:port is for guest, dev is for host.</div><div>Adding [] in my imple=
mentation will let QEMU know it&#39;s ipv6.=C2=A0=C2=A0</div><div>Is the af=
orementioned invocation correct? Or in this case [::1] is the local host ad=
dress and I should put qemu address</div><div>for it instead?</div><div>3. =
Is there a default ipv6 address for QEMU instance? I think I need it in the=
 invocation.</div><div><br></div><div>Thanks in advance! Felix</div><div><b=
r></div><div>[1].=C2=A0<a href=3D"https://gitlab.freedesktop.org/slirp/libs=
lirp/-/issues/67">https://gitlab.freedesktop.org/slirp/libslirp/-/issues/67=
</a></div></div>

--00000000000046a4c005ff020b50--

