Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4377EAB22
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 08:59:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2oJb-00020h-O6; Tue, 14 Nov 2023 02:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2oJZ-000207-Uv
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 02:58:29 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2oJX-0006LR-MM
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 02:58:29 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40839652b97so41754745e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 23:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699948705; x=1700553505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ocmXiH4qcLkoZdQoaluE8CpB0EXbFAC8scGwpgtKsc=;
 b=jVypKVvlOZKJtD4cen2XdVXnWZ+Lrb4tUONx6wvGC42rM/j/TrFPjeIUY20FVtcyVa
 oaCSak3iNoo2q8vvw7XO+FMnvNnRS5QtCxDGW62IhgKasWsnVDVbUgERzLbYSer5lW2M
 JFotL6AyZph/Uaz2gTSxuq4uJU3oofEYFLF9um7tOVZs8vlUouWa76/YPCtPenyk3MXp
 2h8UPGzeQTsj+cSJfy2fsnjwPZ254f2mzq9ZzjSAVl9yOKbayGV6WzMTy7DfBfMTCl1P
 HGnECcyTpvAxM5PGjhktzUcKWUQ9IMqQtz/rvKB4xNLiqUV1tkO7B/w5GkdDn4zTRxzG
 EYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699948705; x=1700553505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ocmXiH4qcLkoZdQoaluE8CpB0EXbFAC8scGwpgtKsc=;
 b=H5186JgBWmkHljzELNWFINpvda9WH9pQLnT7WAxOZvbZ8QpoxXAiVK8txXbKggVX8q
 eK2z6YF5E8TipuiaOue16lyddC6cxgA2VELU3VaszNWZSTZaFFIPyyXwMeumWeW9aFBQ
 RREkD9LKCFcLIVDN2AYM0W/WQ8n4QdcCeB0LtbVoL66X4b/D+sLqjErWFsxUw0EUAAFV
 t1YH+63SUNBPNl4RJ9xvJkLyL3vb+2qpJIc80SkrYWWMWIARkxSl2GUGIWS+LBe+U/sb
 r5ALRAxBqs5R1ZykBY2cbtZqLPLQay40p4mFbJtcfb2ANf+Lvyq/li4KUvWoTzHrNHPw
 8hAg==
X-Gm-Message-State: AOJu0Ywcz5LxqBeLaaupnmglnfJ28Db6VQMWuWmYjPKylpQpCYOT+SPv
 6waTvvhEEg2jHmIl5GDR8uQucw==
X-Google-Smtp-Source: AGHT+IGLnHPxByJUZlv0OHbrwkWB8vQY4zl1JbOsJeysfx3/2KJYr3iDxrCmrQRuOG07AKPgS0e+TQ==
X-Received: by 2002:a05:600c:1c21:b0:407:612b:91fb with SMTP id
 j33-20020a05600c1c2100b00407612b91fbmr6720884wms.30.1699948704783; 
 Mon, 13 Nov 2023 23:58:24 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 r18-20020a05600c35d200b0040a487758dcsm10551547wmq.6.2023.11.13.23.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 23:58:24 -0800 (PST)
Message-ID: <b7646614-8f5c-4ea6-9ea8-ff81f4a492c9@linaro.org>
Date: Tue, 14 Nov 2023 08:58:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 04/10] hw/xen: Factor xen_arch_align_ioreq_data()
 out of handle_ioreq()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Paul Durrant <paul@xen.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <f791a822-f6f5-44fa-904b-f67d3f193763@email.android.com>
 <7a66c289-19e1-4690-8c6e-31a9f6344b6f@linaro.org>
 <e892e4eee469b1d1406dcd0844af48d1aaff23ae.camel@infradead.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e892e4eee469b1d1406dcd0844af48d1aaff23ae.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/11/23 18:11, David Woodhouse wrote:
> On Mon, 2023-11-13 at 17:09 +0100, Philippe Mathieu-Daudé wrote:
>> On 13/11/23 16:58, Woodhouse, David wrote:
>>> On 13 Nov 2023 10:22, Philippe Mathieu-Daudé <philmd@linaro.org>
>>> wrote:
>>>
>>>      Per commit f17068c1c7 ("xen-hvm: reorganize xen-hvm and move
>>> common
>>>      function to xen-hvm-common"), handle_ioreq() is expected to be
>>>      target-agnostic. However it uses 'target_ulong', which is a
>>> target
>>>      specific definition.
>>>
>>>      In order to compile this file once for all targets, factor the
>>>      target-specific code out of handle_ioreq() as a per-target
>>> handler
>>>      called xen_arch_align_ioreq_data().
>>>
>>>      Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>      ---
>>>      Should we have a 'unsigned qemu_target_long_bits();' helper
>>>      such qemu_target_page_foo() API and target_words_bigendian()?
>>>
>>>
>>> It can be more fun than that though. What about
>>> qemu_target_alignof_uint64() for example, which differs between
>>> i386 and
>>> x86_64 and causes even structs with *explicitly* sized fields to
>>> differ
>>> because of padding.
>>>
>>> I'd *love* to see this series as a step towards my fantasy of being
>>> able
>>> to support Xen under TCG. After all, without that what's the point
>>> in
>>> being target-agnostic?
>>
>> Another win is we are building all these files once instead of one
>> for
>> each i386/x86_64/aarch64 targets, so we save CI time and Amazon
>> trees.
>>
>>> However, I am mildly concerned that some of these files are
>>> accidentally
>>> using the host ELF ABI, perhaps with explicit management of 32-bit
>>> compatibility, and the target-agnosticity is purely an illusion?
>>>
>>> See the "protocol" handling and the three ABIs for the ring in
>>> xen-block, for example.
>>
>> If so I'd expect build failures or violent runtime assertions.
> 
> Heh, mostly the guest just crashes in the cases I've seen so far.
> 
> See commit a1c1082908d ("hw/xen: use correct default protocol for xen-
> block on x86").
> 
>> Reviewing quickly hw/block/dataplane/xen-block.c, this code doesn't
>> seem target specific at all IMHO. Otherwise I'd really expect it to
>> fail compiling. But I don't know much about Xen, so I'll let block &
>> xen experts to have a look.
> 
> Where it checks dataplane->protocol and does different things for
> BLKIF_PROTOCOL_NATIVE/BLKIF_PROTOCOL_X86_32/BLKIF_PROTOCOL_X86_64, the
> *structures* it uses are intended to be using the correct ABI. I think
> the structs for BLKIF_PROTOCOL_NATIVE may actually be *different*
> according to the target, in theory?

OK I see what you mean, blkif_back_rings_t union in hw/block/xen_blkif.h

These structures shouldn't differ between targets, this is the point of
an ABI :) And if they were, they wouldn't compile as target agnostic.

> I don't know that they are *correct* right now, if the host is
> different from the target. But that's just a bug (that only matters if
> we ever want to support Xen-compatible guests using TCG).
> 
>>> Can we be explicit about what's expected to work here and what's
>>> not in scope?
>>
>> What do you mean? Everything is expected to work like without this
>> series applied :)
> 
> I think that if we ever do support Xen-compatible guests using TCG,
> we'll have to fix that bug and use the right target-specific
> structures... and then perhaps we'll want the affected files to
> actually become target-specfic again?
> 
> I think this series makes it look like target-agnostic support *should*
> work... but it doesn't really?

For testing we have:

aarch64: tests/avocado/boot_xen.py
x86_64: tests/avocado/kvm_xen_guest.py

No combination with i386 is tested,
Xen within aarch64 KVM is not tested (not sure it works).

