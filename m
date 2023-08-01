Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BD876B7DF
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 16:42:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQqYn-00051v-6j; Tue, 01 Aug 2023 10:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQqYj-00051T-IK; Tue, 01 Aug 2023 10:41:14 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qQqYg-0003o2-Mm; Tue, 01 Aug 2023 10:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690900867; x=1691505667; i=deller@gmx.de;
 bh=z2nxXPSLyhF4zcevuUppFURzElWB2ixxrm2TB+KSoGE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=OECZV9Tlhw/kz44JQeTDrdviVrurD0wK0GLZIaVVZivetjrZy2DaQZkBRlj0OLFsd1TAT2g
 32csWRc4DRj0NxB52612V3w0tGeKA3zjgAAXsyMGiHLye61ArGFnw+RMgLHl2dok5G+tSQ5kN
 RgA9y01iXmHElP74EfJLWnJGdlgbmklNI1hYn/aQn8Ob/BISuJyV0p0zdjjVl5AJDLxxQi0zr
 6XSnV6r25FfjEAagR7gAic7cEeaGSNDCsXEFUOUX4HcoHiQ6gGlviArp7WpWpy19LuBJCDtpp
 gJ3WxS3vkES3EtGDzDUpFEUBVw6JdsYpI6QQAiWLXFaapg1jzVkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.150.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9kC-1qcxWZ1m6G-00GZg4; Tue, 01
 Aug 2023 16:41:07 +0200
Message-ID: <02f59869-fca4-4c8b-fc52-0073fb0ef8f9@gmx.de>
Date: Tue, 1 Aug 2023 16:41:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] linux-user: Emulate /proc/cpuinfo on aarch64 and arm
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <ZMkPRJ3subSuW+Rg@p100>
 <CAFEAcA8cEp2_vc0i9QMNeb7KkxsJecXjuYhYUR6nkL6-LLyFqw@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <CAFEAcA8cEp2_vc0i9QMNeb7KkxsJecXjuYhYUR6nkL6-LLyFqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7w6yMoln+Cx2wDqbXhwy2+Fa3iVkNS6SHNRPpEy/FMoIY1rT1VB
 bYsguzZN+h/CU9WROo5reQmh+FbAYG6VPipPVsoOL6dWT9o5JRV97VQJVylzHdeTceEH2qh
 kA81DJo3WbXzMByW8+/uhLwjVuvy6lhBGQ2huTDsX2hxkOnPmL241NgCo1Y6T/d4rjH8uX1
 4tqIcT84xuWBX7KAJ8hOg==
UI-OutboundReport: notjunk:1;M01:P0:18uB2raXr1M=;fjU7TYbauRvNBr4nj9SGkIdNQgU
 agHAoMH/na0LO7Kntu2uAMgL3tIGMRMCWVJ1rLIYmGaOdlvi6spvBTl04H8/Nk/KIYzzR28U7
 MUyumW+W81jWbvDU1L/hjPilGAgLQdJ7j9KU2zbqxMxoCIEhCRMHBDJ3oJFSRg6wg8ksjyDfl
 3rjHI9KJQw41rn1tsRMBhr40GtgqeBZFKUbMtle0NuUQQcLSCYUgSHJJDM2btNdXsqTcAl4Ve
 6E9zRTUL/0mouQ2vrmwFiBf9YsJh+qkUM6iIPsQ4Ri89X17FmZzqIQtNtXXByZtLZxHGL41We
 qbRjwPZiOIneH3p88uIyYFcJMJ3LL67zsq9jbVDGBRmZcSGOzIlErOGzC4z0w6oieNcKFkPEY
 Xrk/zAdwFuu3I+YTzLtyt2op+DhWhKcvgNcT718qY0jnwxUn6Z1Nl79e9w1RlZ4O81IpU0scb
 0WFRlf6EL694JWolQ4p3W6O8xeRksqv+ezT8D1k6tw8VrDwstxWZJ66U7sBXMXH1J7CqwOnR7
 kDl5XP3IQm7N9aUStXDnAOpNuEiYJzsmsVEGkbN6w3HJJRUBN8Da1vRKnj9ZBc6Zf561q3uGT
 4dD3xxwd64NhtLTnJY3QBKdvc7o8veXI9Z2Daj7F1H8fF7LbR55K/RBzYKIbQKeAkH6y7OsOw
 QnYW3qXNB0Gyw+oYM+cIFhu0QKKCccK6KE/lPvto71dIgb0OMVCaD964nAgWAYcoUEj9HfjZ8
 hUM+DL0gkfW26twXVleSWPFqwrPsu894l2nwsZt7oOUxl9byRZ9hTDNc5rMYK9g6dp10mvIV1
 PKxsQTq0fPMrvH87iivrfFHQbXNnh7BZTEsgr4mcWEiHfmvn5Jx9bmr5kZso+KNelvYN+Zz43
 ZqJbe7Bxh+GOE8FidjTMbTz8PN93OC9CsgiJBABLLc/UlwPAOqiOFqAuXFMkNHfwqkT2ZW++S
 d4zn/1pXVx71W5a66a5SEviDW0Y=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/1/23 16:22, Peter Maydell wrote:
> On Tue, 1 Aug 2023 at 14:57, Helge Deller <deller@gmx.de> wrote:
>>
>> Add emulation for /proc/cpuinfo for arm architecture.
>> The output below mimics output as seen on debian porterboxes.
>
>
>> +#if defined(TARGET_AARCH64) || defined(TARGET_ARM)
>> +static int open_cpuinfo(CPUArchState *cpu_env, int fd)
>> +{
>> +    int i, num_cpus;
>> +    const int is64 =3D TARGET_ABI_BITS =3D=3D 64;
>> +
>> +    num_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
>> +    for (i =3D 0; i < num_cpus; i++) {
>> +        dprintf(fd, "processor\t: %d\n", i);
>> +        if (!is64) {
>> +            dprintf(fd, "model name\t: ARMv7 Processor rev 2 (v7l)\n")=
;
>> +        }
>> +        dprintf(fd, "BogoMIPS\t: %d.00\n", is64 ? 100 : 50);
>> +        dprintf(fd, "Features\t: %s\n",
>> +                is64 ? "fp asimd evtstrm cpuid"
>> +                     : "half thumb fastmult vfp edsp thumbee vfpv3 " \
>> +                       "tls idiva idivt vfpd32 lpae");
>> +        dprintf(fd, "CPU implementer\t: 0x%d\n", is64 ? 50 : 56);
>> +        dprintf(fd, "CPU architecture: %d\n",    is64 ? 8 : 7);
>> +        dprintf(fd, "CPU variant\t: 0x%d\n",     is64 ? 0 : 2);
>> +        dprintf(fd, "CPU part\t: 0x%d\n",        is64 ? 0 : 584);
>> +        dprintf(fd, "CPU revision\t: %d\n\n",    is64 ? 1 : 2);
>
> If you want to do this you should hook it up to what the
> CPU being emulated actually is and what features it has.
> (Compare how we set the hwcaps.)

Nice!
I didn't know about those elf hwcaps...
I'll respin.

Thanks,
Helge


