Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AB17E3567
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 07:57:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0G0q-0006LH-CF; Tue, 07 Nov 2023 01:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r0G0o-0006L3-NL
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 01:56:34 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r0G0k-0007Fs-LK
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 01:56:34 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso5467926b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 22:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1699340189; x=1699944989;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NvWvdrXp+37vUNEbfdJCW6fVZfFYnDKe/+UmXqAOKo4=;
 b=pJ6FCJORdt+kdzPYsaCThCI9JR4iR3IDAE7xhV5NPKiRjcqGLMu+7e35N6Re8WdRK9
 Nahqr7IETH4a/shePEsR/lTqhiAchXlrZ7czHK0vqNv9rzRVdacs0cVG5CaJ4Wb4/GcS
 9IIz6oHJFSU6bXRIeyWxROHfGY8/Ra7QenRA6oQtawxcw1g2K63QtRBTBbEaz5Q/IOym
 IPpu5QrT5nozNVfFilsgnz/IZ2pGAxoKIeW8lDYxrlhLmNm8WkkCFPhcxMcjsDwxszwj
 5zB2lhfvAo7iKobn+2RgKT83xpAUKJx4+pNO+7BVVnMaLVMJ3mdHENXmeWxDyw4Ak+eF
 I92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699340189; x=1699944989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NvWvdrXp+37vUNEbfdJCW6fVZfFYnDKe/+UmXqAOKo4=;
 b=ugRRN9U89rxvYddnRypXt6uF095lYMU01I3vNQE58KuWcgg3OJ9KMuImAJi0ujalBo
 nlT63emcHudQMwYC+ke6iwqOfy+l2crI3AwzggHj6riaawKEtMPAz+vunPqp9RVTTw6w
 +x5Zor5OIevRlIMPqZFPGrdv5GvkzNaS1qf8fOjzIn8CNDRTewX+Z/I0EGd+dcspzQDW
 znuiK193XFt1T+XvGMHSZABC1FAFoBSjNfIk+9WlLxm692ooYlq58xYLUDj06Vx8KDwZ
 I9ssCqgbEEfg6L0mDSS3J1QjLrePCZj7kN3U3uHQqEZYE+4D2KBGxSIChEbvvDEIwRFk
 0N2Q==
X-Gm-Message-State: AOJu0YzQmb3GJhftwf8NArlgtJwcplDA/shL4LeQRgfulDiG+9vus3r9
 7AXiTvLTx94iVVm+1tjZcUGqKg==
X-Google-Smtp-Source: AGHT+IEguCwLdGu8EnuNi8KiAXY4YQKzgy7qdVhOUOTjdFC5CNSUrFB0rWbcvCanh9gkYiUHnjSpZg==
X-Received: by 2002:a05:6a00:14d0:b0:693:4a5c:268f with SMTP id
 w16-20020a056a0014d000b006934a5c268fmr35406336pfu.6.1699340188657; 
 Mon, 06 Nov 2023 22:56:28 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 h24-20020a63e158000000b005af9dcb4756sm746648pgk.42.2023.11.06.22.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 22:56:28 -0800 (PST)
Message-ID: <633cc017-faa9-49a1-b15b-c31d57a6349c@daynix.com>
Date: Tue, 7 Nov 2023 15:56:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/29] plugins: add an API to read registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
 <20231103195956.1998255-25-alex.bennee@linaro.org>
 <e9c6bb21-678e-44d5-b34d-e7a840a1b7b0@daynix.com>
 <87il6fdyaq.fsf@draig.linaro.org>
 <94da2184-2586-458e-9362-fa913ca68fb5@daynix.com>
 <874jhzdur3.fsf@draig.linaro.org>
 <333fbdf6-9f5b-41c3-99ce-8808c542d485@daynix.com>
 <87msvrcdo5.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87msvrcdo5.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2023/11/06 20:40, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
> (re-adding qemu-devel which my mail client dropped a few messages ago, sorry)
> 
>> On 2023/11/06 19:46, Alex Bennée wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> On 2023/11/06 18:30, Alex Bennée wrote:
>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>
>>>>>> On 2023/11/04 4:59, Alex Bennée wrote:
>>>>>>> We can only request a list of registers once the vCPU has been
>>>>>>> initialised so the user needs to use either call the find function on
>>>>>>> vCPU initialisation or during the translation phase. We don't expose
>>>>>>> the reg number to the plugin instead hiding it behind an opaque
>>>>>>> handle. This allows for a bit of future proofing should the internals
>>>>>>> need to be changed while also being hashed against the CPUClass so we
>>>>>>> can handle different register sets per-vCPU in hetrogenous situations.
>>>>>>> Having an internal state within the plugins also allows us to expand
>>>>>>> the interface in future (for example providing callbacks on register
>>>>>>> change if the translator can track changes).
>>>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>>>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>>>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>>>> +struct qemu_plugin_register;
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * typedef qemu_plugin_reg_descriptor - register descriptions
>>>>>>> + *
>>>>>>> + * @name: register name
>>>>>>> + * @handle: opaque handle for retrieving value with qemu_plugin_read_register
>>>>>>> + * @feature: optional feature descriptor, can be NULL
>>>>>>> + */
>>>>>>> +typedef struct {
>>>>>>> +    char name[32];
>>>>>>> +    struct qemu_plugin_register *handle;
>>>>>>> +    const char *feature;
>>>>>>> +} qemu_plugin_reg_descriptor;
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * qemu_plugin_find_registers() - return register list
>>>>>>> + * @vcpu_index: vcpu to query
>>>>>>> + * @reg_pattern: register name pattern
>>>>>>> + *
>>>>>>> + * Returns a GArray of qemu_plugin_reg_descriptor or NULL. Caller
>>>>>>> + * frees. As the register set of a given vCPU is only available once
>>>>>>> + * the vCPU is initialised if you want to monitor registers from the
>>>>>>> + * start you should call this from a qemu_plugin_register_vcpu_init_cb()
>>>>>>> + * callback.
>>>>>>> + */
>>>>>>> +GArray * qemu_plugin_find_registers(unsigned int vcpu_index, const char *reg_pattern);
>>>>>>
>>>>>> A pattern may be convenient for humans but not for machine. My
>>>>>> motivation to introduce the feature is to generate traces consumable
>>>>>> by trace-based simulators. Such a plugin needs an exact match of
>>>>>> registers.
>>>>> That's true - but we don't have any such users in the code base.
>>>>> However
>>>>> for exact matches the details are in qemu_plugin_reg_descriptor so you
>>>>> can always filter there if you want.
>>>>
>>>> I designed the feature to read registers for users outside of the code
>>>> base so the code base has no practical user.
>>>> I added the feature to log register values to execlog but it's only
>>>> for demonstration and it is useless for practical use;
>>> I wouldn't say its useless - and it is important to have in-tree
>>> code to
>>> exercise the various parts of the API we expose.
>>
>> I mean it is useless except for demonstration. Having some code for
>> demonstration is good but we shouldn't overfit the API to it.
>>
>>> To be clear is your objection just to the way
>>> qemu_plugin_find_registers() works or the whole concept of using a
>>> handle instead of the register number? I'm certainly open to better ways
>>> of doing the former but as explained in the commit I think the handle
>>> based approach is a more hygienic interface that gives us scope to
>>> improve it going forward.
>>
>> Yes, my major concern is that the pattern matching.
> 
> OK. Another potential consumer I thought about during implementing the
> internal API was HMP which would also benefit from a more human wildcard
> type search. So I think the resolution of this is having two APIs, one
> returning a list of qemu_plugin_reg_descriptor and one returning a
> single descriptor only with an exact match.

I don't think qemu_plugin_find_registers() is so versetile that it 
should be a public API. What is appropriate as a user interface depends 
more on the context.

For HMP, it may be better to implement command completion instead of 
having a wildcard. Some may want regular expressions instead of GLib 
patterns. Some may want POSIX-compliant glob instead of GLib-specific 
pattern match (the quirks of GLib pattern is documented at 
https://gitlab.gnome.org/GNOME/glib/-/blob/2.78.1/glib/gpattern.c#L33).

I think it's better to expose an array of register names and let the 
plugin do the pattern match in a way appropriate for the specific use case.

> 
> I thought exposing features and registers in two calls was a bit clunky
> though so how about:
> 
>    struct qemu_plugin_reg_descriptor *
>      qemu_plugin_find_register(unsigned int vcpu_index,
>                                const char *name,
>                                const char *gdb_feature);
> 
> which will only reply on an exact match (although I still think
> register names are unique enough you can get away without gdb_feature).
> 
>> I'm fine with the use of a pointer instead of the register number. A
>> pointer is indeed more random for each run so it will prevent the user
>> from hardcoding it.
>>
>>> As we are so close to soft-freeze I suggest I re-spin the series to
>>> include 1-12/29 and the windows bits and we can work on a better API for
>>> the 9.0 release.
>>
>> I'm not in haste either and fine to delay it for the 9.0 release.
> 
> OK I'll get as much as I can merged now and leave the final API bits for
> when the tree opens up. I don't suppose you have any idea why:
> 
>    target/riscv: Use GDBFeature for dynamic XML
> 
> caused a regression? The XML generated looks identical but the
> communication diverges with the riscv-csr response:
> 
>    gdbstub_io_command Received: qXfer:features:read:riscv-csr.xm   gdbstub_io_command Received: qXfer:features:read:riscv-csr.xm
>    gdbstub_io_binaryreply 0x0000: 6c 3c 3f 78  6d 6c 20 76  65 7   gdbstub_io_binaryreply 0x0000: 6c 3c 3f 78  6d 6c 20 76  65 7
>    gdbstub_io_binaryreply 0x0010: 31 2e 30 22  3f 3e 3c 21  44 4   gdbstub_io_binaryreply 0x0010: 31 2e 30 22  3f 3e 3c 21  44 4
>    gdbstub_io_binaryreply 0x0020: 66 65 61 74  75 72 65 20  53 5   gdbstub_io_binaryreply 0x0020: 66 65 61 74  75 72 65 20  53 5
>    gdbstub_io_binaryreply 0x0030: 67 64 62 2d  74 61 72 67  65 7   gdbstub_io_binaryreply 0x0030: 67 64 62 2d  74 61 72 67  65 7
>    gdbstub_io_binaryreply 0x0040: 3c 66 65 61  74 75 72 65  20 6   gdbstub_io_binaryreply 0x0040: 3c 66 65 61  74 75 72 65  20 6
>    gdbstub_io_binaryreply 0x0050: 72 67 2e 67  6e 75 2e 67  64 6   gdbstub_io_binaryreply 0x0050: 72 67 2e 67  6e 75 2e 67  64 6
>    gdbstub_io_binaryreply 0x0060: 2e 63 73 72  22 3e 3c 72  65 6   gdbstub_io_binaryreply 0x0060: 2e 63 73 72  22 3e 3c 72  65 6
>    gdbstub_io_binaryreply 0x0070: 22 66 66 6c  61 67 73 22  20 6   gdbstub_io_binaryreply 0x0070: 22 66 66 6c  61 67 73 22  20 6
>    gdbstub_io_binaryreply 0x0080: 3d 22 36 34  22 20 72 65  67 6   gdbstub_io_binaryreply 0x0080: 3d 22 36 34  22 20 72 65  67 6
>    gdbstub_io_binaryreply 0x0090: 22 2f 3e 3c  72 65 67 20  6e 6 | gdbstub_io_binaryreply 0x0090: 22 20 74 79  70 65 3d 22  69 6
>    gdbstub_io_binaryreply 0x00a0: 6d 22 20 62  69 74 73 69  7a 6 | gdbstub_io_binaryreply 0x00a0: 65 67 20 6e  61 6d 65 3d  22 6
>    gdbstub_io_binaryreply 0x00b0: 72 65 67 6e  75 6d 3d 22  36 3 | gdbstub_io_binaryreply 0x00b0: 74 73 69 7a  65 3d 22 36  34 2
>    gdbstub_io_binaryreply 0x00c0: 67 20 6e 61  6d 65 3d 22  66 6 | gdbstub_io_binaryreply 0x00c0: 6d 3d 22 36  38 22 20 74  79 7
>    gdbstub_io_binaryreply 0x00d0: 74 73 69 7a  65 3d 22 36  34 2 | gdbstub_io_binaryreply 0x00d0: 22 2f 3e 3c  72 65 67 20  6e 6
>    gdbstub_io_binaryreply 0x00e0: 6d 3d 22 36  39 22 2f 3e  3c 7 | gdbstub_io_binaryreply 0x00e0: 73 72 22 20  62 69 74 73  69 7
>    gdbstub_io_binaryreply 0x00f0: 65 3d 22 63  79 63 6c 65  22 2 | gdbstub_io_binaryreply 0x00f0: 20 72 65 67  6e 75 6d 3d  22 3
>    gdbstub_io_binaryreply 0x0100: 65 3d 22 36  34 22 20 72  65 6 | gdbstub_io_binaryreply 0x0100: 65 3d 22 69  6e 74 22 2f  3e 3
>    gdbstub_io_binaryreply 0x0110: 31 33 38 22  2f 3e 3c 72  65 6 | gdbstub_io_binaryreply 0x0110: 6d 65 3d 22  63 79 63 6c  65 2
>    gdbstub_io_binaryreply 0x0120: 22 74 69 6d  65 22 20 62  69 7 | gdbstub_io_binaryreply 0x0120: 7a 65 3d 22  36 34 22 20  72 6
>    gdbstub_io_binaryreply 0x0130: 36 34 22 20  72 65 67 6e  75 6 | gdbstub_io_binaryreply 0x0130: 33 31 33 38  22 20 74 79  70 6
>    gdbstub_io_binaryreply 0x0140: 22 2f 3e 3c  72 65 67 20  6e 6 | gdbstub_io_binaryreply 0x0140: 2f 3e 3c 72  65 67 20 6e  61 6
>    gdbstub_io_binaryreply 0x0150: 73 74 72 65  74 22 20 62  69 7 | gdbstub_io_binaryreply 0x0150: 65 22 20 62  69 74 73 69  7a 6
>    gdbstub_io_binaryreply 0x0160: 36 34 22 20  72 65 67 6e  75 6 | gdbstub_io_binaryreply 0x0160: 72 65 67 6e  75 6d 3d 22  33 3
>    gdbstub_io_binaryreply 0x0170: 22 2f 3e 3c  2f 66 65 61  74 7 | gdbstub_io_binaryreply 0x0170: 70 65 3d 22  69 6e 74 22  2f 3
>                                                                  > gdbstub_io_binaryreply 0x0180: 61 6d 65 3d  22 69 6e 73  74 7
>                                                                  > gdbstub_io_binaryreply 0x0190: 74 73 69 7a  65 3d 22 36  34 2
>                                                                  > gdbstub_io_binaryreply 0x01a0: 6d 3d 22 33  31 34 30 22  20 7
>                                                                  > gdbstub_io_binaryreply 0x01b0: 6e 74 22 2f  3e 3c 2f 66  65 6
>    gdbstub_io_command Received: qTStatus                           gdbstub_io_command Received: qTStatus
>    gdbstub_io_reply Sent:                                          gdbstub_io_reply Sent:
>    gdbstub_io_command Received: ?                                  gdbstub_io_command Received: ?
>    gdbstub_io_reply Sent: T05thread:p2003b4.2003b4;              | gdbstub_io_reply Sent: T05thread:p2011b6.2011b6;
> 
> Was this the reason for the misa_max cleanups?

The misa_max cleanups are needed for "gdbstub: Simplify XML lookup", not 
for "target/riscv: Use GDBFeature for dynamic XML".

