Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 975B382E075
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 20:10:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPSKY-0000oL-IQ; Mon, 15 Jan 2024 14:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rPSKW-0000oC-5t
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 14:09:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rPSKU-0005bT-Fg
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 14:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705345741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+gzVl6GKKBag+n9vDJ3Ju2VlWaCs+TVcc8LGmuCkMY=;
 b=N1VVNMl+UTFRvwh4QGr5fPdVAiIvMbu+x1fMvIpavJj+NGAFN/7zRVFbZrM5QtTBObqO3q
 VmPsOZGcLctlY7ZEYV2KjcKX9E3c6S3HgPXGgPEnCaG8mVFMEUivI1E9ducKE+aHTeNF2W
 tZPm0KPTlE6WgOPlnOwA0Xp6eNMHKpg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-wQgSzJ8MM0G3sUQQF0iHog-1; Mon, 15 Jan 2024 14:07:43 -0500
X-MC-Unique: wQgSzJ8MM0G3sUQQF0iHog-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7173811E9C;
 Mon, 15 Jan 2024 19:07:42 +0000 (UTC)
Received: from [10.39.193.170] (unknown [10.39.193.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26EE8492BC6;
 Mon, 15 Jan 2024 19:07:42 +0000 (UTC)
Message-ID: <385fc0d8-2c07-0645-09d5-4f790d5b7dfd@redhat.com>
Date: Mon, 15 Jan 2024 20:07:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] tests/acpi: Update virt/SSDT.memhp
Content-Language: en-US
To: Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: Bin Meng <bin.meng@windriver.com>, qemu-devel@nongnu.org
References: <20240115043431.3900922-1-bin.meng@windriver.com>
 <20240115043431.3900922-4-bin.meng@windriver.com>
 <87le8qkepv.fsf@draig.linaro.org>
 <CAEUhbmUoyNi=3uSwiFPGdb25_a-0zwQavbni4T+8jMJJFJH01g@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <CAEUhbmUoyNi=3uSwiFPGdb25_a-0zwQavbni4T+8jMJJFJH01g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/15/24 15:46, Bin Meng wrote:
> On Mon, Jan 15, 2024 at 7:40 PM Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Bin Meng <bin.meng@windriver.com> writes:
>>
>>> The Arm dtb changes caused an address change:
>>>
>>>  DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
>>>  {
>>>      [ ... ]
>>> -    Name (MEMA, 0x43C80000)
>>> +    Name (MEMA, 0x43D80000)
>>>  }
>>
>> I'm confused by why this changes. Isn't this declaring the size of a
>> NVDIMM region of the memory map? Why does a DTB change affect an ACPI
>> based boot?
>>
> 
> I have no idea too. I suspect that's because the AllocateAlignedPages
> call to allocate a 1 MiB aligned address in the BiosTableTest.c is
> affected by the shrinked DTB now.
> 
> + Laszlo who might know the root cause.

Just speculating:

from "docs/specs/acpi_nvdimm.rst":

Memory:
   QEMU uses BIOS Linker/loader feature to ask BIOS to allocate a memory
   page and dynamically patch its address into an int32 object named "MEMA"
   in ACPI.

Therefore any QEMU-side change that affects memory allocations in the guest may affect the ACPI contents (captured later).

I don't know what the DTB change at hand was, but if (for example) the DTB has grown significantly, that could lead to this. The guest firmware stashes a dynamically allocated copy of the DTB, early on in the PEI phase. Some growth there may change the initial memory map of the DXE phase, which could affect the ACPI linker/loader's allocation operations.

If you can attach the DTB before-after, and the *verbose* firmware log before-after, we might find out finer details.

Laszlo


