Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B68822119
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 19:37:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKjd0-0008IK-FC; Tue, 02 Jan 2024 13:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1rKjcz-0008IA-C9
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 13:36:37 -0500
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1rKjcx-00057J-1x
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 13:36:37 -0500
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6B3DAFF80E;
 Tue,  2 Jan 2024 18:36:27 +0000 (UTC)
Message-ID: <ecdc0f06-a7b2-49ac-a3f4-536f91b80b92@ovn.org>
Date: Tue, 2 Jan 2024 19:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Erik Skultety <eskultet@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Ed Maste <emaste@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 2/4] tests/lcitool: Refresh generated files
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20230711144922.67491-1-philmd@linaro.org>
 <20230711144922.67491-3-philmd@linaro.org> <ZK2YS0v5G3iKyXwJ@redhat.com>
 <41ae7db7-8d80-1749-c89d-025ee30bd73d@linaro.org>
 <ZK6Kn8hB8soQBRsA@redhat.com>
 <30d49562-451e-b4c6-679e-0f8d1e0abe72@linaro.org>
 <ZK6lhY5H/XRqukgU@redhat.com>
 <eb9bb489-d79a-4aa1-951e-b0c7e97313dc@linaro.org>
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <eb9bb489-d79a-4aa1-951e-b0c7e97313dc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: neutral client-ip=2001:4b98:dc4:8::229;
 envelope-from=i.maximets@ovn.org; helo=relay9-d.mail.gandi.net
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_NEUTRAL=0.779,
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

On 1/2/24 19:19, Philippe Mathieu-Daudé wrote:
> On 12/7/23 15:07, Daniel P. Berrangé wrote:
>> On Wed, Jul 12, 2023 at 02:55:10PM +0200, Philippe Mathieu-Daudé wrote:
>>> On 12/7/23 13:12, Daniel P. Berrangé wrote:
>>>> On Wed, Jul 12, 2023 at 01:00:38PM +0200, Philippe Mathieu-Daudé wrote:
>>>>> On 11/7/23 19:58, Daniel P. Berrangé wrote:
>>>>>> On Tue, Jul 11, 2023 at 04:49:20PM +0200, Philippe Mathieu-Daudé wrote:
>>>>>>> Refresh the generated files by running:
>>>>>>>
>>>>>>>      $ make lcitool-refresh
>>>>>>>
>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>> ---
>>>>>>>     tests/docker/dockerfiles/debian-amd64.docker |  2 -
>>>>>>>     tests/docker/dockerfiles/ubuntu2004.docker   |  2 -
>>>>>>>     tests/docker/dockerfiles/ubuntu2204.docker   |  2 -
>>>>>>
>>>>>> I don't know why this would be removing xen/pmem from these files. If
>>>>>> I run 'lcitool-refresh' on current git master that doesn't happen
> 
> FTR since commit cb039ef3d9 libxdp-devel is also being changed on my
> host, similarly to libpmem-devel, so I suppose it also has some host
> specific restriction.

Yeah, many distributions are not building libxdp for non-x86
architectures today.  There are no real reasons not to, but
they just do not, because the package is relatively new.  It
will likely become available in the future.

I see this thread is a bit old.  Was a solution found for the
pmem/xen?  i.e. do I need to do something specific for libxdp
at this point?

Best regards, Ilya Maximets.

> 
>>>>>> Do you have any other local changes on top ?
>>>
>>> (I just noticed manually updating the libvirt-ci submodule is
>>>   pointless because the 'lcitool-refresh' rule does that)
>>>
>>>>> diff --git a/tests/docker/dockerfiles/ubuntu2204.docker
>>>>> b/tests/docker/dockerfiles/ubuntu2204.docker
>>>>> index 1d442cdfe6..5162927016 100644
>>>>> --- a/tests/docker/dockerfiles/ubuntu2204.docker
>>>>> +++ b/tests/docker/dockerfiles/ubuntu2204.docker
>>>>> @@ -73 +72,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>>> -                      libpmem-dev \
>>>>> @@ -99 +97,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>>> -                      libxen-dev \
>>>>
>>>> What architecture are you running from ? I'm suspecting it is a non
>>>> x86_64 architecture as these pacakges are both arch conditionalized.
>>>
>>> My host is Darwin aarch64, but how is this relevant to what we
>>> generate for guests? Are we missing specifying the target arch
>>> somewhere? (This is not the '--cross-arch' argument, because we
>>> don't want to cross-build). These dockerfiles always targeted x86_64,
>>> in particular the debian-amd64.docker one...
>>
>> This is an unfortunate design choice of lcitool.
>>
>> If you give '--cross-arch' it will always spit out the dockerfile
>> suitable for cross-compiling to that arch.
>>
>> If you omit '--cross-arch' it will always spit out the dockerfile
>> suitable for compiling on the *current* host arch.
>>
>> When we're committing the dockerfiles to qemu (or any libvirt project
>> using lcitool), we've got an implicit assumption that the non-cross
>> dockerfiles were for x86_64, and hence an implicit assumption that
>> the person who ran 'lcitool' was also on x86_64.
>>
>> This is clearly a bad design choice mistake in retrospect as people
>> are increasingly likely to be using aarch64 for day-to-day dev work.
>>
>> So I guess we need to come up with a more explicit way to say give
>> me a native container for x86_64.
>>
>> With regards,
>> Daniel
> 


