Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F04D77E7A33
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 09:36:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Mzp-0003lF-BT; Fri, 10 Nov 2023 03:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1r1Mzo-0003l2-5b
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 03:36:08 -0500
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1r1Mzm-0002n8-1U
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 03:36:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E767C1F8B9;
 Fri, 10 Nov 2023 08:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699605362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uB81GHjdagNa6TKI985cH017NM7XspVKe8XdpkBSZ7w=;
 b=ZppVMnpQD+AuTqrVGOV2T2UUmyCS7fGTE4rNii3k63Lafu28Can8L9mgC50URTbmjwcZit
 dLHQpunLgNx8oPmV2CYen9hfYQ8CFSDQK3Ytb1wg+rCW5ejv3G/gzs8PxwtrjS7K0+rmRZ
 FSkOZ9cVvVFXPM1V8pnv1F4CNaXp2eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699605362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uB81GHjdagNa6TKI985cH017NM7XspVKe8XdpkBSZ7w=;
 b=THqBcnnlJvGNeSL64xvWjPxfGN4Pshr3PTQmIDj+j+3EbaVLab+PvhrmT8xIHj7GHMGS4p
 K6UcodH6zNHbaEAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2CF4138FC;
 Fri, 10 Nov 2023 08:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bzbwJXLrTWXhLQAAMHmgww
 (envelope-from <cfontana@suse.de>); Fri, 10 Nov 2023 08:36:02 +0000
Message-ID: <59437ef3-7b94-2aa4-31b4-012412ce160b@suse.de>
Date: Fri, 10 Nov 2023 09:36:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [SeaBIOS] [PATCH v5] limit physical address space size
Content-Language: en-US
To: Kevin O'Connor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: seabios@seabios.org, qemu-devel@nongnu.org
References: <20231107130309.3257776-1-kraxel@redhat.com>
 <ZUvVCHWbU29+eDm7@morn>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <ZUvVCHWbU29+eDm7@morn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -76
X-Spam_score: -7.7
X-Spam_bar: -------
X-Spam_report: (-7.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.265,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/8/23 19:35, Kevin O'Connor wrote:
> On Tue, Nov 07, 2023 at 02:03:09PM +0100, Gerd Hoffmann wrote:
>> For better compatibility with old linux kernels,
>> see source code comment.
>>
>> Related (same problem in ovmf):
>> https://github.com/tianocore/edk2/commit/c1e853769046
> 
> Thanks.  I'll defer to your judgement on this.  It does seem a little
> odd to alter the CPUPhysBits variable itself instead of adding
> additional checking to the pciinit.c code that uses CPUPhysBits.
> (That is, if there are old Linux kernels that can't handle a very high
> PCI space, then a workaround in the PCI code might make it more clear
> what is occurring.)
> 
> Cheers,
> -Kevin
> 
> 
>>
>> Cc: Claudio Fontana <cfontana@suse.de>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Hi,

I thought about this, and I am not sure it's the right call though.

The change breaking old guests (CentOS7, Ubuntu 18.04 are the known ones, but presumably others as well) in QEMU is:

commit 784155cdcb02ffaae44afecab93861070e7d652d
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Mon Sep 11 17:20:26 2023 +0200

    seabios: update submodule to git snapshot
    
    git shortlog
    ------------
    
    Gerd Hoffmann (7):
          disable array bounds warning
          better kvm detection
          detect physical address space size
          move 64bit pci window to end of address space
          be less conservative with the 64bit pci io window
          qemu: log reservations in fw_cfg e820 table
          check for e820 conflict

The reasoning for the change is according to:

https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/message/BHK67ULKJTLJT676J4D5C2ND53CFEL3Q/

"It makes seabios follow a common pattern.  real mode address space
has io resources mapped high (below 1M).  32-bit address space has
io resources mapped high too (below 4G).  This does the same for
64-bit resources."

So it seems to be an almost aesthetic choice, the way I read the "common pattern", one that ends up actually breaking existing workloads though.

Now the correction to that that you propose in SeaBIOS is:

>> ---
>>  src/fw/paravirt.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/src/fw/paravirt.c b/src/fw/paravirt.c
>> index e5d4eca0cb5a..a2c9c64d5e78 100644
>> --- a/src/fw/paravirt.c
>> +++ b/src/fw/paravirt.c
>> @@ -182,6 +182,14 @@ static void physbits(int qemu_quirk)
>>              __func__, signature, pae ? "yes" : "no", CPULongMode ? "yes" : "no",
>>              physbits, valid ? "yes" : "no");
>>  
>> +    if (valid && physbits > 46) {
>> +        // Old linux kernels have trouble dealing with more than 46
>> +        // phys-bits, so avoid that for now.  Seems to be a bug in the
>> +        // virtio-pci driver.  Reported: centos-7, ubuntu-18.04
>> +        dprintf(1, "%s: using phys-bits=46 (old linux kernel compatibility)\n", __func__);
>> +        physbits = 46;
>> +    }
>> +
>>      if (valid)
>>          CPUPhysBits = physbits;
>>  }
>> -- 
>> 2.41.0

but to me this is potentially breaking the situation for another set of users,
those that are passing through 48 physical bits from their host cpu to the guest,
and expect it to actually happen.

Would it not be a better solution to instead either revert the original change,
or to patch it to find a new range that better satisfies code consistency/aesthetic requirements,
but also does not break any running workload?

I could help with the testing for this.

Or we could add some extra workarounds in the stack elsewhere in the management tools to
try to detect older guests (not ideal either), but this seems like adding breakage on top of breakage to me.

Might be wrong though, looking forward for opinions across Seabios and QEMU.

Thanks,

Claudio

