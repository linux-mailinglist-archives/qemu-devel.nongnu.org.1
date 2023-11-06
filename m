Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6747E2038
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:42:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxyg-0006pm-Am; Mon, 06 Nov 2023 06:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qzxyZ-0006pL-DB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:41:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qzxyX-0004WV-6y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:41:03 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so32760795e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699270859; x=1699875659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yh45PbVxzxA+q4SI23iPclVM0xFG9E5Q42am3KRe+Sc=;
 b=c7wdVvX8mGKifsm3l2w1fJODJhGyZx78Ry9pPIHgtR9kD1svHvLJlr7A9Fnu8+QveA
 zEKrxXuecrD6e1OPeOAav95Z4ix8lxFP62SdaC7OBJHm3iogcFIQO87E3pF6yS2O3GsN
 sTDklz7z1GJjh9vkfFTFjzrEm7QZ8KY2oCx/jWZUKvmmrIPn11/Vpmv3NQUd/bqOhlKt
 1iJtLxexybMFquDTVXizmNB8UJunkvXps1hNAZDnZVh5hOOt0aR0XIJ/FBh3PTkm6PaA
 jyA0ob+s7orWOziNNiMLG8eKXIz2zHZvnijnon4LRb1yrC7HEEfQ88Lnhb99pBo7X80l
 UyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699270859; x=1699875659;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yh45PbVxzxA+q4SI23iPclVM0xFG9E5Q42am3KRe+Sc=;
 b=rS88yY4iOp1HV5YnyUXYBr/Q/RluunKIDdZ1K7llLwPZe4ik/x291bwQhS0DK212cK
 IbZJYIq3Kcex3ZNuovSmb/4r1oDOWmqO7tYAYwwBtEHEI5t+xar32yjGHWbEEH/B9S4K
 uRb+33MpAe7leUYMczNpEEaDwtoPNO8JtX4uF+5fLZ5mBNHFqM4DRmam+wqmL+BVJx42
 itU+RGakec+Vg/J6uOKRtQOTThte7ItHFRUPZMzHM3zwv5YBehaDQZitAtEJJY/OH8jB
 HYvkhlsAOISaoT5diyPaDaKpFNyik99hMWlgrammDcY4lkyTcNJNb7dEFBTkk72TlPQ/
 LnRQ==
X-Gm-Message-State: AOJu0YwRESUp5AOvtUKPCeT2R680MOuRyBE7ozSS8JAjpJghtI9egjkx
 4G75jS5wxkXSXo43mK0G99cPkigC3U1KJzyHzotewA==
X-Google-Smtp-Source: AGHT+IHUvCYnN2J92oFId3RitRWdUly9SvR5wObkmpvpCv3sv5HhJa8bNayc6cdBEr/zW3Sd8mZyMQ==
X-Received: by 2002:a05:600c:524f:b0:406:5463:3f51 with SMTP id
 fc15-20020a05600c524f00b0040654633f51mr24136506wmb.25.1699270859409; 
 Mon, 06 Nov 2023 03:40:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m36-20020a05600c3b2400b004075d5664basm12064321wms.8.2023.11.06.03.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:40:59 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A8D075F79F;
 Mon,  6 Nov 2023 11:40:58 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH 24/29] plugins: add an API to read registers
In-Reply-To: <333fbdf6-9f5b-41c3-99ce-8808c542d485@daynix.com> (Akihiko
 Odaki's message of "Mon, 6 Nov 2023 19:56:57 +0900 (24 minutes, 55
 seconds ago)")
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
 <20231103195956.1998255-25-alex.bennee@linaro.org>
 <e9c6bb21-678e-44d5-b34d-e7a840a1b7b0@daynix.com>
 <87il6fdyaq.fsf@draig.linaro.org>
 <94da2184-2586-458e-9362-fa913ca68fb5@daynix.com>
 <874jhzdur3.fsf@draig.linaro.org>
 <333fbdf6-9f5b-41c3-99ce-8808c542d485@daynix.com>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Mon, 06 Nov 2023 11:40:58 +0000
Message-ID: <87msvrcdo5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

(re-adding qemu-devel which my mail client dropped a few messages ago, sorr=
y)

> On 2023/11/06 19:46, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>=20
>>> On 2023/11/06 18:30, Alex Benn=C3=A9e wrote:
>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>
>>>>> On 2023/11/04 4:59, Alex Benn=C3=A9e wrote:
>>>>>> We can only request a list of registers once the vCPU has been
>>>>>> initialised so the user needs to use either call the find function on
>>>>>> vCPU initialisation or during the translation phase. We don't expose
>>>>>> the reg number to the plugin instead hiding it behind an opaque
>>>>>> handle. This allows for a bit of future proofing should the internals
>>>>>> need to be changed while also being hashed against the CPUClass so we
>>>>>> can handle different register sets per-vCPU in hetrogenous situation=
s.
>>>>>> Having an internal state within the plugins also allows us to expand
>>>>>> the interface in future (for example providing callbacks on register
>>>>>> change if the translator can track changes).
>>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>>>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>>> +struct qemu_plugin_register;
>>>>>> +
>>>>>> +/**
>>>>>> + * typedef qemu_plugin_reg_descriptor - register descriptions
>>>>>> + *
>>>>>> + * @name: register name
>>>>>> + * @handle: opaque handle for retrieving value with qemu_plugin_rea=
d_register
>>>>>> + * @feature: optional feature descriptor, can be NULL
>>>>>> + */
>>>>>> +typedef struct {
>>>>>> +    char name[32];
>>>>>> +    struct qemu_plugin_register *handle;
>>>>>> +    const char *feature;
>>>>>> +} qemu_plugin_reg_descriptor;
>>>>>> +
>>>>>> +/**
>>>>>> + * qemu_plugin_find_registers() - return register list
>>>>>> + * @vcpu_index: vcpu to query
>>>>>> + * @reg_pattern: register name pattern
>>>>>> + *
>>>>>> + * Returns a GArray of qemu_plugin_reg_descriptor or NULL. Caller
>>>>>> + * frees. As the register set of a given vCPU is only available once
>>>>>> + * the vCPU is initialised if you want to monitor registers from the
>>>>>> + * start you should call this from a qemu_plugin_register_vcpu_init=
_cb()
>>>>>> + * callback.
>>>>>> + */
>>>>>> +GArray * qemu_plugin_find_registers(unsigned int vcpu_index, const =
char *reg_pattern);
>>>>>
>>>>> A pattern may be convenient for humans but not for machine. My
>>>>> motivation to introduce the feature is to generate traces consumable
>>>>> by trace-based simulators. Such a plugin needs an exact match of
>>>>> registers.
>>>> That's true - but we don't have any such users in the code base.
>>>> However
>>>> for exact matches the details are in qemu_plugin_reg_descriptor so you
>>>> can always filter there if you want.
>>>
>>> I designed the feature to read registers for users outside of the code
>>> base so the code base has no practical user.
>>> I added the feature to log register values to execlog but it's only
>>> for demonstration and it is useless for practical use;
>> I wouldn't say its useless - and it is important to have in-tree
>> code to
>> exercise the various parts of the API we expose.
>
> I mean it is useless except for demonstration. Having some code for
> demonstration is good but we shouldn't overfit the API to it.
>
>> To be clear is your objection just to the way
>> qemu_plugin_find_registers() works or the whole concept of using a
>> handle instead of the register number? I'm certainly open to better ways
>> of doing the former but as explained in the commit I think the handle
>> based approach is a more hygienic interface that gives us scope to
>> improve it going forward.
>
> Yes, my major concern is that the pattern matching.

OK. Another potential consumer I thought about during implementing the
internal API was HMP which would also benefit from a more human wildcard
type search. So I think the resolution of this is having two APIs, one
returning a list of qemu_plugin_reg_descriptor and one returning a
single descriptor only with an exact match.

I thought exposing features and registers in two calls was a bit clunky
though so how about:

  struct qemu_plugin_reg_descriptor *
    qemu_plugin_find_register(unsigned int vcpu_index,
                              const char *name,
                              const char *gdb_feature);

which will only reply on an exact match (although I still think
register names are unique enough you can get away without gdb_feature).

> I'm fine with the use of a pointer instead of the register number. A
> pointer is indeed more random for each run so it will prevent the user
> from hardcoding it.
>
>> As we are so close to soft-freeze I suggest I re-spin the series to
>> include 1-12/29 and the windows bits and we can work on a better API for
>> the 9.0 release.
>
> I'm not in haste either and fine to delay it for the 9.0 release.

OK I'll get as much as I can merged now and leave the final API bits for
when the tree opens up. I don't suppose you have any idea why:

  target/riscv: Use GDBFeature for dynamic XML

caused a regression? The XML generated looks identical but the
communication diverges with the riscv-csr response:

  gdbstub_io_command Received: qXfer:features:read:riscv-csr.xm   gdbstub_i=
o_command Received: qXfer:features:read:riscv-csr.xm
  gdbstub_io_binaryreply 0x0000: 6c 3c 3f 78  6d 6c 20 76  65 7   gdbstub_i=
o_binaryreply 0x0000: 6c 3c 3f 78  6d 6c 20 76  65 7
  gdbstub_io_binaryreply 0x0010: 31 2e 30 22  3f 3e 3c 21  44 4   gdbstub_i=
o_binaryreply 0x0010: 31 2e 30 22  3f 3e 3c 21  44 4
  gdbstub_io_binaryreply 0x0020: 66 65 61 74  75 72 65 20  53 5   gdbstub_i=
o_binaryreply 0x0020: 66 65 61 74  75 72 65 20  53 5
  gdbstub_io_binaryreply 0x0030: 67 64 62 2d  74 61 72 67  65 7   gdbstub_i=
o_binaryreply 0x0030: 67 64 62 2d  74 61 72 67  65 7
  gdbstub_io_binaryreply 0x0040: 3c 66 65 61  74 75 72 65  20 6   gdbstub_i=
o_binaryreply 0x0040: 3c 66 65 61  74 75 72 65  20 6
  gdbstub_io_binaryreply 0x0050: 72 67 2e 67  6e 75 2e 67  64 6   gdbstub_i=
o_binaryreply 0x0050: 72 67 2e 67  6e 75 2e 67  64 6
  gdbstub_io_binaryreply 0x0060: 2e 63 73 72  22 3e 3c 72  65 6   gdbstub_i=
o_binaryreply 0x0060: 2e 63 73 72  22 3e 3c 72  65 6
  gdbstub_io_binaryreply 0x0070: 22 66 66 6c  61 67 73 22  20 6   gdbstub_i=
o_binaryreply 0x0070: 22 66 66 6c  61 67 73 22  20 6
  gdbstub_io_binaryreply 0x0080: 3d 22 36 34  22 20 72 65  67 6   gdbstub_i=
o_binaryreply 0x0080: 3d 22 36 34  22 20 72 65  67 6
  gdbstub_io_binaryreply 0x0090: 22 2f 3e 3c  72 65 67 20  6e 6 | gdbstub_i=
o_binaryreply 0x0090: 22 20 74 79  70 65 3d 22  69 6
  gdbstub_io_binaryreply 0x00a0: 6d 22 20 62  69 74 73 69  7a 6 | gdbstub_i=
o_binaryreply 0x00a0: 65 67 20 6e  61 6d 65 3d  22 6
  gdbstub_io_binaryreply 0x00b0: 72 65 67 6e  75 6d 3d 22  36 3 | gdbstub_i=
o_binaryreply 0x00b0: 74 73 69 7a  65 3d 22 36  34 2
  gdbstub_io_binaryreply 0x00c0: 67 20 6e 61  6d 65 3d 22  66 6 | gdbstub_i=
o_binaryreply 0x00c0: 6d 3d 22 36  38 22 20 74  79 7
  gdbstub_io_binaryreply 0x00d0: 74 73 69 7a  65 3d 22 36  34 2 | gdbstub_i=
o_binaryreply 0x00d0: 22 2f 3e 3c  72 65 67 20  6e 6
  gdbstub_io_binaryreply 0x00e0: 6d 3d 22 36  39 22 2f 3e  3c 7 | gdbstub_i=
o_binaryreply 0x00e0: 73 72 22 20  62 69 74 73  69 7
  gdbstub_io_binaryreply 0x00f0: 65 3d 22 63  79 63 6c 65  22 2 | gdbstub_i=
o_binaryreply 0x00f0: 20 72 65 67  6e 75 6d 3d  22 3
  gdbstub_io_binaryreply 0x0100: 65 3d 22 36  34 22 20 72  65 6 | gdbstub_i=
o_binaryreply 0x0100: 65 3d 22 69  6e 74 22 2f  3e 3
  gdbstub_io_binaryreply 0x0110: 31 33 38 22  2f 3e 3c 72  65 6 | gdbstub_i=
o_binaryreply 0x0110: 6d 65 3d 22  63 79 63 6c  65 2
  gdbstub_io_binaryreply 0x0120: 22 74 69 6d  65 22 20 62  69 7 | gdbstub_i=
o_binaryreply 0x0120: 7a 65 3d 22  36 34 22 20  72 6
  gdbstub_io_binaryreply 0x0130: 36 34 22 20  72 65 67 6e  75 6 | gdbstub_i=
o_binaryreply 0x0130: 33 31 33 38  22 20 74 79  70 6
  gdbstub_io_binaryreply 0x0140: 22 2f 3e 3c  72 65 67 20  6e 6 | gdbstub_i=
o_binaryreply 0x0140: 2f 3e 3c 72  65 67 20 6e  61 6
  gdbstub_io_binaryreply 0x0150: 73 74 72 65  74 22 20 62  69 7 | gdbstub_i=
o_binaryreply 0x0150: 65 22 20 62  69 74 73 69  7a 6
  gdbstub_io_binaryreply 0x0160: 36 34 22 20  72 65 67 6e  75 6 | gdbstub_i=
o_binaryreply 0x0160: 72 65 67 6e  75 6d 3d 22  33 3
  gdbstub_io_binaryreply 0x0170: 22 2f 3e 3c  2f 66 65 61  74 7 | gdbstub_i=
o_binaryreply 0x0170: 70 65 3d 22  69 6e 74 22  2f 3
                                                                > gdbstub_i=
o_binaryreply 0x0180: 61 6d 65 3d  22 69 6e 73  74 7
                                                                > gdbstub_i=
o_binaryreply 0x0190: 74 73 69 7a  65 3d 22 36  34 2
                                                                > gdbstub_i=
o_binaryreply 0x01a0: 6d 3d 22 33  31 34 30 22  20 7
                                                                > gdbstub_i=
o_binaryreply 0x01b0: 6e 74 22 2f  3e 3c 2f 66  65 6
  gdbstub_io_command Received: qTStatus                           gdbstub_i=
o_command Received: qTStatus
  gdbstub_io_reply Sent:                                          gdbstub_i=
o_reply Sent:=20
  gdbstub_io_command Received: ?                                  gdbstub_i=
o_command Received: ?
  gdbstub_io_reply Sent: T05thread:p2003b4.2003b4;              | gdbstub_i=
o_reply Sent: T05thread:p2011b6.2011b6;

Was this the reason for the misa_max cleanups?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

