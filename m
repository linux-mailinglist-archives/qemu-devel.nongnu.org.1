Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D089EDF01
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 06:41:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLbvX-0002n6-V3; Thu, 12 Dec 2024 00:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tLbvV-0002my-CJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 00:39:53 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1tLbvS-0002Ke-6o
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 00:39:53 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21654fdd5daso1677075ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 21:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1733981988; x=1734586788;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b6ZQN2KH2+jPXIJfa7DJN/RCGg91mVK0ADoMRcl6L4Y=;
 b=AklXN94wyhPTOO7Gq5FssfnkMWoXwQkX1XGWfo+FgJrFGg+5z3O7+LMZlESOMvO0r9
 jGg9J7h+Ax6emZSVD50rp2/45W7KDUveLQJd7pnQMCmtJdzzAtJ/P/CjyWmVVE2JWh1V
 BpvVzpVDuCaAv+M9vDObqT7WqXRjg7mMB/302V4NEfLgmI1yq4Q73gO04sihHc3jWQja
 wPZWkt3ICIPPDy283QhimqAyJ/ULYiHOx4xuW6mOYb4bcLj/4RZJlznac7gLtMm0ofC/
 ChvQ5oL/jgml75eXDIKKlmvlLHLodT6mVHMxReDJSrYnuf2RVk6EtIfqE2xkdwwp9eI7
 5H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733981988; x=1734586788;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b6ZQN2KH2+jPXIJfa7DJN/RCGg91mVK0ADoMRcl6L4Y=;
 b=H6zA920MlZssZE1txZCnByrXgX4Uz4FMGWj9/5IfDTcYTXMjdfqrwphvXAyCRV9Dkt
 n5i/6gXxWinraP0D8LKxCIRhnTU6X3/txqQzxsdnxn50IVMhQYzYc+ijVi8K7Tr6JyQt
 Bp7Tl8pQqrw2L9Ny2cKHtLrKzwq4THTKn/aK4qa+EAHIVBJ0TPqrkS4lZiBjF5weD0Ts
 m2qYtSu/7nonk5o3cRnYl41TCvu+HPDS8ZB8/LqbAf0YX4drxY0ckbA494uRP8ySb7aK
 OGvx/jMWGqYMzTKwMGiBWpZpKndI3t7ghMXsR3QDb4RhOElnv7Fg585t1lutkAgKvpV2
 zxXw==
X-Gm-Message-State: AOJu0YxILN/fxrihHwxyEYXNdoubQ90cJWfMO3Km/+wMP2D9IzUWx5Eb
 e9SrVg3avi2cRXttgJRbaPyGZmH0A+qtY9+JHAsXRQfh8T8Gw9i2Q+Zeol0erao=
X-Gm-Gg: ASbGncsFT/tswW9cqXkHK3aj5NPWNUlH98AuE3+Q8gFawAMDsI/mFjVmIoDVSbqoF9Y
 6hpknL/hLwL2MxflovOEqgy2APP0/QjmYPL9RZZW5gOQXnyPYkFwZv8WtOiShTgk1p0gjQAJInH
 J7n2mwxlx3hkpztcKSI54Nv53e/7y5vxplK4JKuOI+itAu1/+QZeK7Zk2VIFn+8e34IF/pWYlxK
 mpY09wsAK/FehfP96QDUL3ku5jQWZYMMUWJN0DEUXe0iS06yuxXWL4I9d7C3rmtZDWd/ICyy+ue
 MmmDTFvW
X-Google-Smtp-Source: AGHT+IEh11Qm/vaML1Lqs4I9o3RLZ1tgQ6zMaup5qEuoEmEz44p3G3NxnU2OXGFmHuAwwMEOSfJzPg==
X-Received: by 2002:a17:902:f68f:b0:216:7926:8d69 with SMTP id
 d9443c01a7336-2178aee5dafmr39591895ad.47.1733981987996; 
 Wed, 11 Dec 2024 21:39:47 -0800 (PST)
Received: from [10.16.129.170] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21625a0b842sm88716025ad.34.2024.12.11.21.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 21:39:47 -0800 (PST)
Message-ID: <1ab0a747-e2c4-4545-bae9-31e19c77bd75@igel.co.jp>
Date: Thu, 12 Dec 2024 14:39:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] system/memory: support unaligned access
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <20241108032952.56692-3-tomoyuki.hirose@igel.co.jp> <Z04lW_CdYBPJRah3@x1n>
 <2de74447-00f7-4bcf-81f3-c8461ec19a67@igel.co.jp> <Z1MpY7ZIAAoBDbZU@x1n>
 <9d1f07e5-2c08-455c-a653-e57e219666ab@igel.co.jp> <Z1oYIn5cMZeA4tes@x1n>
Content-Language: en-US
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
In-Reply-To: <Z1oYIn5cMZeA4tes@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/12/12 7:54, Peter Xu wrote:
> On Wed, Dec 11, 2024 at 06:35:57PM +0900, Tomoyuki HIROSE wrote:
>> Sorry for late reply.
>>
>> On 2024/12/07 1:42, Peter Xu wrote:
>>> On Fri, Dec 06, 2024 at 05:31:33PM +0900, Tomoyuki HIROSE wrote:
>>>> In this email, I explain what this patch set will resolve and an
>>>> overview of this patch set. I will respond to your specific code
>>>> review comments in a separate email.
>>> Yes, that's OK.
>>>
>>>> On 2024/12/03 6:23, Peter Xu wrote:
>>>>> On Fri, Nov 08, 2024 at 12:29:46PM +0900, Tomoyuki HIROSE wrote:
>>>>>> The previous code ignored 'impl.unaligned' and handled unaligned
>>>>>> accesses as is. But this implementation could not emulate specific
>>>>>> registers of some devices that allow unaligned access such as xHCI
>>>>>> Host Controller Capability Registers.
>>>>> I have some comment that can be naive, please bare with me..
>>>>>
>>>>> Firstly, could you provide an example in the commit message, of what would
>>>>> start working after this patch?
>>>> Sorry, I'll describe what will start working in the next version of
>>>> this patch set. I'll also provide an example here.  After applying
>>>> this patch set, a read(addr=0x2, size=2) in the xHCI Host Controller
>>>> Capability Registers region will work correctly. For example, the read
>>>> result will return 0x0110 (version 1.1.0). Previously, a
>>>> read(addr=0x2, size=2) in the Capability Register region would return
>>>> 0, which is incorrect. According to the xHCI specification, the
>>>> Capability Register region does not prohibit accesses of any size or
>>>> unaligned accesses.
>>> Thanks for the context, Tomoyuki.
>>>
>>> I assume it's about xhci_cap_ops then.  If you agree we can also mention
>>> xhci_cap_ops when dscribing it, so readers can easily reference the MR
>>> attributes from the code alongside with understanding the use case.
>>>
>>> Does it mean that it could also work if xhci_cap_ops.impl.min_access_size
>>> can be changed to 2 (together with additional xhci_cap_read/write support)?
>>>
>>> Note that I'm not saying it must do so even if it would work for xHCI, but
>>> if the memory API change is only for one device, then it can still be
>>> discussed about which option would be better on changing the device or the
>>> core.
>>>
>>> Meanwhile, if there's more use cases on the impl.unaligned, it'll be nice
>>> to share together when describing the issue.  That will be very persuasive
>>> input that a generic solution is needed.
>> OK, I understand. I will try to describe 'xhci_cap_ops' and related topics.
> Thanks.
>
>> Currently, the actual 'xhci_cap_ops' code is as follows:
>>
>> ```
>> static const MemoryRegionOps xhci_cap_ops = {
>>      .read = xhci_cap_read,
>>      .write = xhci_cap_write,
>>      .valid.min_access_size = 1,
>>      .valid.max_access_size = 4,
>>      .impl.min_access_size = 4,
>>      .impl.max_access_size = 4,
>>      .endianness = DEVICE_LITTLE_ENDIAN,
>> };
>> ```
>>
>> According to the above code, the guest can access this MemoryRegion
>> with 1-4 bytes.  'valid.unaligned' is also not explicitly defined, so
>> it is treated as 'false'. This means the guest can access this MR with
>> 1-4 bytes, as long as the access is aligned. However, the xHCI
>> specification does not prohibit unaligned accesses.
>>
>> Simply adding '.valid.unaligned = true' will not resolve this problem
>> because 'impl.unaligned' is also 'false'. In this situation, where
>> 'valid.unaligned' is 'true' but 'impl.unaligned' is 'false', we need
>> to emulate unaligned accesses by splitting them into multiple aligned
>> accesses.
> Correct.
>
>> An alternative solution would be to fix 'xhci_cap_{read,write}',
>> update '.impl.min_access_size = 1', and set '.impl.unaligned = true'
>> to allow the guest to perform unaligned accesses with 1-4 bytes. With
>> this solution, we wouldn't need to modify core memory code.
>>
>> However, applying this approach throughout the QEMU codebase would
>> increase the complexity of device implementations. If a device allows
>> unaligned guest access to its register region, the device implementer
>> would needs to handle unaligned accesses explicitly. Additionally,
>> the distinction between 'valid' and 'impl' would become almost
>> meaningless, making it unclear why they are separated.
> I get it now, let's stick with the core memory change.
>
>> "Ideally", we could consider one of the following changes:
>>
>> 1. Introduce an emulation mechanism for unaligned accesses using
>>     multiple aligned accesses.
>> 2. Remove either 'valid' or 'impl' and unify these functionality.
>>
>> Solution 2 would require extensive changes to the codebase and memory
>> API, making it impractical.
> Why it is impractical?  Let me explain my question..
>
> Firstly, valid.unaligned makes perfect sense to me.  That describes whether
> the device emulation allows unaligned access at all.  So I do think we need
> this, and yes when xHCI controller supports unaligned access, this is the
> flag to be set TRUE instead of FALSE.
>
> However, impl.unaligned is confusing to me.
>
>  From literal POV, it says, "the MR ops implemented unaligned access".
>
> If you check my initial reply to this patch, I had a similar question: from
> such definition, whenever a device emulation sets impl.unaligned=true, I
> think it means we should simply pass over the MR request to the ops, no
> matter if it's aligned or not, especially when it's not aligned memory core
> shouldn't need to do any trick on amplifying the MR access, simply because
> the device said it supports unaligned access in its implementation.  That's
> the only meaningful definition of impl.unaligned that I can think of so far.

I have the same understanding.  I found a relevant section in the
documentation at 'docs/devel/memory.rst':

```
In addition various constraints can be supplied to control how these
callbacks are called:

- .valid.min_access_size, .valid.max_access_size define the access sizes
   (in bytes) which the device accepts; accesses outside this range will
   have device and bus specific behaviour (ignored, or machine check)
- .valid.unaligned specifies that the *device being modelled* supports
   unaligned accesses; if false, unaligned accesses will invoke the
   appropriate bus or CPU specific behaviour.
- .impl.min_access_size, .impl.max_access_size define the access sizes
   (in bytes) supported by the *implementation*; other access sizes will be
   emulated using the ones available.  For example a 4-byte write will be
   emulated using four 1-byte writes, if .impl.max_access_size = 1.
- .impl.unaligned specifies that the *implementation* supports unaligned
   accesses; if false, unaligned accesses will be emulated by two aligned
   accesses.
```

> However, after I try to read more of the problem, I don't think any MR ops
> would like to implement such complicated logic, the norm should be like
> xHCI MR ops where it supports only aligned access in MR ops, then the
> memory core is hopefully always be able to convert an unaligned access into
> one or multiple aligned access internally.
>
> IOW, it makes more sense to me that we keep valid.unaligned, but drop
> impl.unaligned.  Would that make sense to you (and Peter)?  That kind of
> matches with the comment you quoted below on saying that unaligned access
> is broken - I'm not 100% sure whether it's talking about impl.unaligned,
> but it would make sense if so.

I agree with you.

> Meanwhile, I do see that we already have two impl.unaligned=true users:
>
> hw/pci-host/raven.c:    .impl.unaligned = true,
> system/ioport.c:    .impl.unaligned = true,
>
> I actually have no idea whether they're working at all if accesses can be
> unaligned internally, and how they work, if at least impl.unaligned seems
> to be totally broken.

I initially assumed there would be more users, so I expected that a
lot of changes would be needed.  MR can be categorized into the
following patterns:

1. `impl.unaligned == true`
2. `impl.unaligned == false` and `valid.unaligned == false`
3. `impl.unaligned == false` and `valid.unaligned == true`

- Pattern 1: No special handling is required since the implementation
   supports unaligned accesses. The MR can handle both aligned and
   unaligned accesses seamlessly.
- Pattern 2: No additional handling is needed because unaligned
   accesses are invalid in this MR. Any unaligned access is treated as
   an illegal operation.
- Pattern 3: This is the only pattern that requires consideration. We
   must emulate unaligned accesses using aligned accesses.

I searched by keyword "unaligned = true" and got the following result:

```
$ rg "unaligned = true"
system/memory.c
1398:        .unaligned = true,
1403:        .unaligned = true,

system/ioport.c
223:    .valid.unaligned = true,
224:    .impl.unaligned = true,

hw/xtensa/mx_pic.c
271:        .unaligned = true,

hw/pci-host/raven.c
203:    .impl.unaligned = true,
204:    .valid.unaligned = true,

hw/riscv/riscv-iommu.c
2108:        .unaligned = true,

hw/ssi/npcm7xx_fiu.c
256:        .unaligned = true,

hw/cxl/cxl-host.c
285:        .unaligned = true,
290:        .unaligned = true,

hw/i386/xen/xen_platform.c
412:        .unaligned = true,
417:        .unaligned = true,

hw/display/vmware_vga.c
1306:        .unaligned = true,
1309:        .unaligned = true,
```

In this result, I found two pattern 3 in the codebase:

- hw/xtensa/mx_pic.c
- hw/ssi/npcm7xx_fiu.c

```
static const MemoryRegionOps xtensa_mx_pic_ops = {
     .read = xtensa_mx_pic_ext_reg_read,
     .write = xtensa_mx_pic_ext_reg_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .unaligned = true,
     },
};
```

```
static const MemoryRegionOps npcm7xx_fiu_flash_ops = {
     .read = npcm7xx_fiu_flash_read,
     .write = npcm7xx_fiu_flash_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
         .unaligned = true,
     },
};
```

Note that these implementations are implicitly 'impl.unaligned ==
false'; the 'impl.unaligned' field simply does not exist in these
cases. However, it is possible that these implementations inherently
support unaligned accesses.

To summarize, if we decide to remove the 'impl' field, we might need
to revisit and make changes to the MR implementation in these codes.

>> Solution 1 seems to align with QEMU's
>> original intentions. Actually, there is a comment in 'memory.c' that
>> states:
>>
>> `/* FIXME: support unaligned access? */`
>>
>> This patch set implements solution 1. If there is a better way to
>> resolve these issues, I would greatly appreciate your suggestions.
> I think if my above understanding is correct, I can kind of understand your
> solution now.  But then I wonder whether we should already drop
> impl.unaligned with your solution.
>
> Also, I don't think I am 100% sure yet on how the amplification of the
> accessed (as proposed in your patch) would have side effects to the device
> emulation.  For example, read(0x2, 0x4) with impl.access_size_min=4 now
> will be amplified to two continuous:
>
>    read(0x0, 0x4)
>    read(0x4, 0x4)
>
> Then there will be side effects of reading (addr=0x0, size=0x2) portion,
> and (addr=0x6, size=0x2) portion, that is not part of the request.  Maybe
> it's as simple as: when device emulation has such side effect, it should
> always set valid.unaligned=false already.

There is also a potential issue regarding side effects. Consider a
device where a register value changes upon a read access. Assume the
device has the following register map:

```
31                       8        0 (bit)
+---------------------------------+
|         Reg1(lo)       |  Reg0  | 0 byte
+---------------------------------+
|                        |Reg1(hi)| 4 byte
```

In this case, let’s assume that Reg0 is a register whose value
changes whenever it is read.
Now, if the guest issues a read(addr=0x1, size=4) on this device's
MR(impl.unaligned=false, valid.unaligned=true), the unaligned access
must be split into two aligned accesses:

1. read(addr=0x0, size=4)
2. read(addr=0x4, size=4)

However, this results in Reg0 being read as part of the first aligned
access, potentially triggering its side effect. This unintended side
effect violates the semantics of the original unaligned read. If we
don't want to allow this, we should set 'valid.unaligned = false'.

Thanks,
Tomoyuki HIROSE

> Thanks,
>

