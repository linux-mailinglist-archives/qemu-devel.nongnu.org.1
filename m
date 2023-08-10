Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E06CB7782E0
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 23:53:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUDZ2-0007ru-CF; Thu, 10 Aug 2023 17:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qUDYx-0007rT-Sv
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 17:51:23 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qUDYw-00040Q-2z
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 17:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691704254; x=1692309054; i=deller@gmx.de;
 bh=DtxgqEu+XMTyi62hedGS9ZKkuig3fioOcbtbJrtfA7A=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=N4o1KhctVwaHCMfrcupYXnU8Mv9CtGN8XBqHLiCyDPOZ/mv6TiyMPk/htFnjyNoAa2bkpEu
 Y8UaeiKP/spMzyTP8mOcOBEDaW/2Umuqete9Se6vOHDtvuAqAzZk9NUqhaJfJX/rRKLW7JY7p
 m7ZmoKqFeIsYUPcqFwy3JC9u9w9IuZdtuhP92UJi3oPCMYnyTgJohPKae3uDh9Bz9FMoz2ZSg
 WJJL/Eah9wBR8dte5hge5ryX4jZKcc5nZ0KIhwwFgzKOt9pVOupx3n+G1FIWVAQ4EXSyncNUe
 eRovs9/y+mjRmqXxPA6Mb9lUukID4PxFK6anayGY18CrC4Rumd1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.133]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRVh-1qJQij3Ft5-00Xvvc; Thu, 10
 Aug 2023 23:50:54 +0200
Message-ID: <9a5f4a80-0700-4261-f26d-ad86ad4209cd@gmx.de>
Date: Thu, 10 Aug 2023 23:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] thunk: Delete checks for old host definitions
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, laurent@vivier.eu, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20230808152314.102036-1-akihiko.odaki@daynix.com>
 <f61ff7ff-44a2-14c3-da08-755c290c75b7@linaro.org>
 <00d65683-47ea-44dc-889b-130cd6d1483e@daynix.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <00d65683-47ea-44dc-889b-130cd6d1483e@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E+CyOtzLi4AKZDJSaXEsZQ3XqaZBEyOlr51QfuaNKiZx/qW7fl7
 bpkRcjRr9++L0Xyl0+x3wt+vpu4Kx0NnTrRO9GusUxg3OJ+Ss0RwUmTYlltQokZiNBv23XV
 lb7zIYvdkHQBC2jN75j7OAMQx/gVCXb5oO39QrDt4ERl15K0CfpAfsnv/0dLPFAKCuCzm/q
 hBwQNPXbh4exaSKZvEbOA==
UI-OutboundReport: notjunk:1;M01:P0:TSwZrh/cU1c=;0vfE7/lvZpHSkpoWUi3DuqMeL3y
 5sGUtcd6dlWubmn81keg2ZMr1t7FiYPN9S47C1o8SH8MJ4OrgNT5NnKiZOcvTzc2OUt2xM5ey
 pSjIpLZ0OISgzr6sHUrIbhkDuDSKzy+QOJrOtvOYzWKu+pKzGoqemdmgQw7ASTJYQyLvVc4V+
 WTEplcGPKXPRIGu7/JYeDnS3j9aRKvxUCbOczZ+aGRcumiiUsCp0z/U8Y0O3v+kDHXv52vPDW
 IGhgoOxdnpRutBQmxU+O/wNX+SNXHnlmQKrwH4myNP5p0cq4xdAMEHAlkwMcTHopiOJi8fAik
 4eAWRfkwVergnh0KgyCQfzjt9fZYkkN1yPfnSEvqnHpCjvWTVjxOhLOev1Bll4MDq/sVIbomA
 qR5POzwYBXwpZuT/1uuWVocM0qevLsww32x/amd4O0tGazJmX25WV/blzBNrCDiK57ngVFolT
 oOcMPS/IpWqjEfU2uUYofhy2l5VEQ68XaWcUTXofqwhEgsF1cVS79k4M54OcBgOvcAxs53uDt
 s7UpWQ4tfdvhcf5gwOSCI0K2ngv9yLpIAtSxY2xkORUs+Y41Myddnp/yRflcJRe8qeZ9ttp5+
 1d5odkj2HLpzscMfTv5w8j+h7EgOi7FmfOTKVCrt1xXfgMHdvQSiBhDjWExefx9hJh13qqTFo
 xmhW7F3abXhSC6K0xcZo0Bxy1YYV9ucBZkztw38AMNwg4QZxKp3Iwk4yFRG50kEZQIEPyqdJF
 u5PxC/btQbg8x4xU8Bw4UJZTMMMm2T6+IT2/u6bP2rUSPcGQtg/qKY76TnVrYRBqCMo+bt/zr
 Z4Abr8AvauYEh1qNy7gKd2ku5ufreojniMfT2vJZ8RKpEa+LHJnSteF9XzPLMoOEy+TDt6ffE
 ms9Cy/k5XPcNTGBkFdNRG+uDF70TnhWCxweRKaKTsfI1Pvrf3xJu5ZWNOMxUaqcBbdVFNnSUJ
 yH04zyAGHix7N15XmM3706bYiFM=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-2.156, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 8/10/23 23:29, Akihiko Odaki wrote:
> On 2023/08/10 19:56, Philippe Mathieu-Daud=C3=A9 wrote:
>> Helge and myself sometime run the tests on a HPPA host

I think we mix up HOST and TARGET here....
I run HPPA target (=3Dguest) on x86-64 host.
That means, both qemu-hppa-user and qemu-hppa-system does
run fine for me (on x86-64 "HOST_X86_64" emulating HPPA).

>> (testing the QEMU tools). I guess remember John Paul
>> also runs some on Alpha (so Cc'ing him).

Yes, I think so.
If I find more time I'd like too.

>> Helge, what is your take on this?
>
> This file is only used in userspace emulation so it's not a problem
> for Alpha, which does no longer have userspace emulation.

Akihiko, your statement is correct, but somewhat misleading.
A native alpha machine (as host) isn't any longer able to run a linux-user
emulation to emulate Linux for some other architecture.
That's true.

> The story is different for HPPA. HPPA has userspace emulation code
> and there are also references for HOST_HPPA in coroutine code
> (util/async-teardown.c and util/os-posix.c). Probably HPPA support is
> broken both for userspace and system emulation. I think it's time to
> think of dropping HPPA support for both of userspace and system
> emulation.
HPPA as host... Yes, I think it doesn't make sense to try to emulate
something else on HPPA.

So, I think the patch below is OK.

Helge

>> On 8/8/23 17:23, Akihiko Odaki wrote:
>>> Alpha, IA-64, and PA-RISC hosts are no longer supported.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>> =C2=A0 include/exec/user/thunk.h | 3 +--
>>> =C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
>>> index 300a840d58..d9c131ec80 100644
>>> --- a/include/exec/user/thunk.h
>>> +++ b/include/exec/user/thunk.h
>>> @@ -111,8 +111,7 @@ static inline int thunk_type_size(const argtype *t=
ype_ptr, int is_host)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (is_host) {
>>> =C2=A0 #if defined(HOST_X86_64)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return 8;
>>> -#elif defined(HOST_ALPHA) || defined(HOST_IA64) || defined(HOST_MIPS)=
 || \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defined(HOST_PARISC) || defined(HOST_S=
PARC64)
>>> +#elif defined(HOST_MIPS) || defined(HOST_SPARC64)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return 4;
>>> =C2=A0 #elif defined(HOST_PPC)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return sizeof(void *);
>>
>


