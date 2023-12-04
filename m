Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B3880335B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 13:49:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA8NV-0002rp-2y; Mon, 04 Dec 2023 07:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DQUR=HP=kaod.org=clg@ozlabs.org>)
 id 1rA8NR-0002qr-2g; Mon, 04 Dec 2023 07:48:45 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=DQUR=HP=kaod.org=clg@ozlabs.org>)
 id 1rA8NO-00033I-71; Mon, 04 Dec 2023 07:48:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SkNkk3tj7z4xkN;
 Mon,  4 Dec 2023 23:48:30 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SkNkX5rTSz4xkG;
 Mon,  4 Dec 2023 23:48:20 +1100 (AEDT)
Message-ID: <3ae174c2-bad6-4099-8e39-a2f02f58cdfd@kaod.org>
Date: Mon, 4 Dec 2023 13:48:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] gitlab: build the correct microblaze target
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Eric Auger <eric.auger@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
 <20231201093633.2551497-7-alex.bennee@linaro.org>
 <a9b7f414-5229-4dc6-9d32-b95d36cdbaf7@redhat.com>
 <871qc29m3z.fsf@draig.linaro.org>
 <181145d8-4d1e-4b19-a77b-1c583155a725@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <181145d8-4d1e-4b19-a77b-1c583155a725@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=DQUR=HP=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 12/4/23 13:43, Thomas Huth wrote:
> On 04/12/2023 13.40, Alex Bennée wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 01/12/2023 10.36, Alex Bennée wrote:
>>>> We inadvertently built the LE target for BE tests.
>>>> Fixes: 78ebc00b06 (gitlab: shuffle some targets and reduce avocado
>>>> noise)
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>> ---
>>>>    .gitlab-ci.d/buildtest.yml | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>>>> index 7f9af83b10..62b5379a5e 100644
>>>> --- a/.gitlab-ci.d/buildtest.yml
>>>> +++ b/.gitlab-ci.d/buildtest.yml
>>>> @@ -41,7 +41,7 @@ build-system-ubuntu:
>>>>      variables:
>>>>        IMAGE: ubuntu2204
>>>>        CONFIGURE_ARGS: --enable-docs
>>>> -    TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
>>>> +    TARGETS: alpha-softmmu microblaze-softmmu mips64el-softmmu
>>>>        MAKE_CHECK_ARGS: check-build
>>>>      check-system-ubuntu:
>>>
>>> We've got microblazeel-softmmu here and microblaze-softmmu in the
>>> build-system-fedora job. So please don't change the ubuntu job here,
>>> otherwise we're building the same target twice instead.
>>
>> Hmm - what would be really useful is an actual microblazeel test image
>> so we can test what we build.
> 
> We've got at least a small test in tests/qtest/boot-serial-test.c, so we know that at least some instructions can be executed via TCG.

There are 2 configs under buildroot, qemu_microblazebe_mmu_defconfig and
qemu_microblazeel_mmu_defconfig, we could possibly use.

C.


