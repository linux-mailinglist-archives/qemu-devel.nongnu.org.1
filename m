Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784CC832E07
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 18:20:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQsX5-0007xW-Ve; Fri, 19 Jan 2024 12:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rQsX3-0007uv-Og
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:19:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rQsX2-0005uY-3B
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705684791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5riWEk6l5qNETbjEOoIRn0QYh0ZgT93HT2E1AODe1Wc=;
 b=Th3cC9aSYU1b18D8P9kkGxK33CPdj8Vx2T3ZNrpCUNT2VRcXcjBtomtNSzJijYJC0jA6ri
 BfGAL2UpfyHdGXIrPJnp0/NF4B/WnQb1oSzHjERskmt3UgF1epLipjRZjc/UVVQqVQ5AsD
 mNb3tTSsV6S4rTmy8ZeR5mltkS+2Ntw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-eJEqbSKRP82wAxEBFIRovA-1; Fri, 19 Jan 2024 12:19:47 -0500
X-MC-Unique: eJEqbSKRP82wAxEBFIRovA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23BBE85A588;
 Fri, 19 Jan 2024 17:19:47 +0000 (UTC)
Received: from [10.39.192.76] (unknown [10.39.192.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08675492BE2;
 Fri, 19 Jan 2024 17:19:45 +0000 (UTC)
Message-ID: <ba16062e-e2c9-95b8-8b35-c388f348e126@redhat.com>
Date: Fri, 19 Jan 2024 18:19:44 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] tests/acpi: Update virt/SSDT.memhp
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Bin Meng <bin.meng@windriver.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20240115043431.3900922-1-bin.meng@windriver.com>
 <20240115043431.3900922-4-bin.meng@windriver.com>
 <CAFEAcA9Z_9Mg_R2ToEo=++UAdq789-q2S8CjHLT6fyp_zXrh-A@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <CAFEAcA9Z_9Mg_R2ToEo=++UAdq789-q2S8CjHLT6fyp_zXrh-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/19/24 15:29, Peter Maydell wrote:
> On Mon, 15 Jan 2024 at 04:35, Bin Meng <bin.meng@windriver.com> wrote:
>>
>> The Arm dtb changes caused an address change:
>>
>>  DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
>>  {
>>      [ ... ]
>> -    Name (MEMA, 0x43C80000)
>> +    Name (MEMA, 0x43D80000)
>>  }
>>
>> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>>
>> ---
> 
> You should follow up (with Laszlo?) to make sure we understand
> why reducing the size of the generated dtb has caused this
> change in the ACPI tables. In particular, if we made the
> dtb *smaller* why has the allocated address here got *larger*?

As a very roughly stated trait (i.e., I'm not claiming this is an exact,
hard rule), the UEFI memory allocator hands out chunks top-down. An
earlier allocation (such as the DTB's) shrinking is consistent with
further allocations being serviced at higher addresses.

> 
> This particular bit of the ACPI tables does seem to be
> annoyingly unstable, though -- for instance commit 55abfc1ffbe54c0
> we had to change this figure when we updated to a newer EDK2
> version, and similarly commit 5f88dd43d0 for the same reason.
> I wonder if we can or should make our data-check be more
> loose about the address reported here, given what Laszlo
> says about how we're basically looking at the address of some
> memory the guest allocated. (cc'd the bios-tables-test
> maintainers for their opinion.)

Right, the allocation address is generally unpredictable. (That's why
the ACPI linker/loader "language" had to be extended with an extra
command, for the sake of the vmgenid device -- so that the firmware
could send the allocation GPA back to QEMU in an "architected" way.)

> 
> I'm also a little concerned that if the ACPI generated
> tables care about the dtb size then we're now going to
> have a situation where any patch we make to the virt board
> that changes the generated dtb at all will result in the
> ACPI tables changing. That would be annoying.

This is generally inevitable, it's just how the ACPI linker/loader
works. The guest allocator can only work with the memory map it gets
from QEMU. The same effect is triggered BTW if you don't change the DTB
but change (on the QEMU command line) the guest RAM size. The ACPI
tables will be allocated at different addresses than before, and so the
pointer fields in other tables, to those tables, will also change.

> 
> Finally, if we do need to update the reference data in
> tests/data/acpi, there is a multi-stage procedure for
> this, documented in the comment at the top of
> tests/qtest/bios-tables-test.c -- basically you need
> first to have a patch that says "ignore discrepancies in
> these files", then the patch that makes the actual change to
> QEMU (in this case your patch 2 in this series), then the
> patch which updates the reference data and removes the files
> from the ignore-this list. (It is because this is a bit of a
> pain that I definitely don't want "any small change to the dtb"
> to turn into "ACPI tables change"...)

Laszlo


