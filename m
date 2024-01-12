Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FA582C1C9
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 15:27:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOIUQ-0002hw-Lv; Fri, 12 Jan 2024 09:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rOIUO-0002gx-KI
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 09:26:28 -0500
Received: from mout.kundenserver.de ([212.227.126.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rOIUM-0000vd-1J
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 09:26:27 -0500
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N8EdM-1r2Q5s0i12-0149ok; Fri, 12 Jan 2024 15:26:12 +0100
Message-ID: <50e2ebf1-da14-4724-96e3-2c01c12a73a3@vivier.eu>
Date: Fri, 12 Jan 2024 15:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Goldfish TTY enhancement
Content-Language: fr
To: Jason Thorpe <thorpej@me.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, David 'Digit' Turner <digit@android.com>
References: <8FAAD163-46DD-426F-AF69-1DDAB45B2A9B@me.com>
 <20f3d501-7ff4-4094-8f34-9393c4c7c1e0@linaro.org>
 <286AB63F-6453-42FF-9CF4-5C75C22C6559@me.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+wsF4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +c7BTQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAcLBXwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
In-Reply-To: <286AB63F-6453-42FF-9CF4-5C75C22C6559@me.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BhGeluhiHIgXIgWhBXdKvWASjWkYWyH3dDcWDhL4vuVuL48lSsi
 PQm6uqvNoU0Nxku4OaUv96l3DKYGOwrrlhZB5T4cCGB8vMnod7jVSqFjnTt5H4aHTQ5qdz3
 KOIPLQWFG4dueKKF8GOqgaVHOrdGvtL6eQW75eN6QVwDpGzX1/911Gxw0m+m24BZNxi/Zti
 4LhnDbyH71jRRPq5J7lnw==
UI-OutboundReport: notjunk:1;M01:P0:YblDj/gU28k=;RYhWgUJwMuGu96KZgMjEPHg+BEj
 wKsNJ1e/ziHOBIjPc3ghF77sBH+Ve+EKBybJy9sNmnX9oZP7pxtq053nYQSJLkrvmIrPkynP5
 LJFicYJO975VXnnes9D5o6ldKdb8KZ844N1YYCVtqrl+t1+6L8X/4NIGRqzxjw74yvc1K4BZu
 Q3bBu2uHAXFteX6np6Tm/QP69ODckljMI/SK85Hyg4asyRkhbovwbRmZZXpe56Jhb5NuGV0V4
 jNZ9QMyo28uj+LdkDqAIasYhJO857j8UVPXbCmiFcr6XfyzoVdb5k97oKigx0rjJjeqn1sUwV
 gbMKDBKQw7XJ5huO4e4Z3GBA4EhE0ySNGD6Sv9ODR0NVpf2sAC2Ecx7lcKR9snOq/xQQalyjL
 uiapYuf0+Gs4qBKrYAtUkNgJR+rycO9q9GXHLbC7czoP7kciXA2ipoB8SXJj1PBvXH3bZeE82
 tTdpnnIqHhm092Uw2Kr/6c3jtJaOJb/bH6ZQl1DOVgTxlK77WuL74nlORpwmkLvP5SL7D3Mk5
 lxoKP3mkTt1ZJawr//kRNqPOw3aCCxvu0BiyXg1aYm6CzejL8G961jLiaVAoslN4FDp0Ivksq
 p0d4DjBFkgkkxbLMolQVomtk27EV+Oes1wLrfoOxPwGi84SsEcbwY9iFRiDZutj1KR0xU05fA
 bamEPXWK0ToF6YuIbGq73D+8gBj16h4G0Kl046oghCxMXVBfIyDDBwn2j8VplnE7y7kJdrs82
 w0JE+qxdza2VRO49P8ZsvaK1ZSdbD0M3YUAVwVftA7dEHhNadbCUxpMtuW0IBl4K9EQcZhbib
 1mLj+wY8lXVRAXx3EGvLAYx/H+znB6FgW9r05rhJHRurKph/A7IVMEnsg5tkgNtRKb5QoqWo8
 ylnCQJHOrdaeTFg==
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Jason,

Le 11/01/2024 à 19:58, Jason Thorpe a écrit :
> 
>> On Jan 10, 2024, at 8:01 AM, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> IIUC Goldfish virtual HW is maintained externally by Google
>> https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
>>
>> I suppose the spec needs to be updated before the change can be
>> accepted in mainstream QEMU, but since I'm not sure I Cc'ed Alex,
>> David and Laurent.
> 
> Hey Philippe,
> 
> I have seen that document didn’t realize that it was the source of truth for the Goldfish devices in Qemu, as Qemu already has Goldfish devices that deviate in behavior from that document.  In particular:
> 
> 1. There is no distinction between “rtc” and “timer” in Qemu.
> 
> 2. The Goldfish “pic” device does not behave as that document describes.  In particular, the “NUMBER” register is described in that document as returning the lowest pending interrupt index or 0 for none (i.e. a number in the range 0..32).  But Qemu returns a bitmask of pending interrupts when that register is read.  And despite the name “DISABLE_ALL” that document claims that writing to it merely clears the pending interrupts without disabling them (which would be quite the trick with level-triggered interrupt sources) whereas in Qemu, it does both clear and disable.
> 
> (I am not, in any way, advocating for a behavior change in Qemu, BTW… I just thought that referenced docuemnt was no longer relevant.)

In fact the source of truth is the kernel. The idea of using Goldfish in the virt m68k machine is to 
only have to code the QEMU part and to use the kernel part as-is. And the kernel part has diverged 
from the documentation...

Thanks,
Laurent

