Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A9F7E41A5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:14:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Moy-0004yF-L6; Tue, 07 Nov 2023 09:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1r0Mow-0004y7-Og
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:12:46 -0500
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1r0Mov-0005CH-2w
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:12:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 79AE82190B;
 Tue,  7 Nov 2023 14:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699366363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FlaRN7Ss8e2WXdetV/SiVCbEPl0W9EfYOO8+a4MF1gs=;
 b=VZ5mNo0pnNObuvqBD8RSUVbucyMLShB0P1ZzLPKUk1JOR8Xf1ymTtmaS4f3h3tUJvZw0uI
 zn7rBq32IwWjQtzwFv0Uh6+mPKp36ONPRAEOCzbmXwaIMqaZFaSN4fZNzbk+eUABmZplUv
 OL7ZIR2OZ7DLOcleE37wc+c+lD1tLDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699366363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FlaRN7Ss8e2WXdetV/SiVCbEPl0W9EfYOO8+a4MF1gs=;
 b=f5wlxmCizM5kaO4StFzz8Fyl1Mkiy57dCA+4snVOyrPqa4IezzCSjk4KoKW+yqja7Cepgn
 jtQmLwNrmMH9RMCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36267132FD;
 Tue,  7 Nov 2023 14:12:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XqTkC9tFSmVceAAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 07 Nov 2023 14:12:43 +0000
Message-ID: <96325128-c7f2-d6c0-8ace-3c4e26bd4b91@suse.de>
Date: Tue, 7 Nov 2023 15:12:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PULL 4/6] seabios: update binaries to git snapshot
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Dario Faggioli <dfaggioli@suse.com>,
 Jim Fehlig <jfehlig@suse.com>, Charles Arnold <carnold@suse.com>
References: <20231010112610.2618091-1-kraxel@redhat.com>
 <20231010112610.2618091-5-kraxel@redhat.com>
 <30a82b23-ded6-f03a-727c-ed6f86657a34@suse.de>
 <terqy6i5rs6ui4wwbzmwlqi2v72c6qfl62nnu2ifgbkbrrz3z4@mneyylwzf6fo>
 <8aa3d259-6dd5-ebf7-8989-66b967434773@suse.de>
 <rdyjajgmgmk3kfbmnufqkws662xhsitcg6yx74qlczclx3i3pz@ftfqmcm7jtp4>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <rdyjajgmgmk3kfbmnufqkws662xhsitcg6yx74qlczclx3i3pz@ftfqmcm7jtp4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.344,
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

On 11/7/23 12:49, Gerd Hoffmann wrote:
>> Hi, thanks for the response,
>>
>> just to be sure, this is a regression (it worked fine prior to the seabios update).
> 
> Yes.
> 
>> Address sizes:                      43 bits physical, 48 bits virtual
> 
> OK.
> 
>> [    0.881472] pci 0000:00:01.0: PCI bridge to [bus 01]
>> [    0.882262] pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
>> [    0.886991] pci 0000:00:01.0:   bridge window [mem 0xfe800000-0xfe9fffff]
>> [    0.890308] pci 0000:00:01.0:   bridge window [mem 0xe1a000000000-0xe1bfffffffff 64bit pref]
> 
> This is the change btw, the 64-bit mmio window is moved.
> Apparently we got 48 bits guest physical address space.
> 
>> [    8.331290] vmap allocation for size 211106232541184 failed: use vmalloc=<size> to increase size.
>> [    8.332666] virtio-pci 0000:01:00.0: virtio_pci: unable to map virtio 56@0 on bar 4
>> [    8.334166] virtio-pci: probe of 0000:01:00.0 failed with error -22
> 
> And here things go wrong.  The size is /way/ off (bar 4 is 16k).
> 
> Can you try to reduce the guest physical address space?
> Try 46 instead of 48 first, if that doesn't help try
> smaller values.
> 
> qemu command line:
>   -cpu host,host-phys-bits-limit=46
> 
> libvirt xml:
>   <cpu ...>
>     <maxphysaddr mode='emulate' bits='46'/>
>   </cpu>
> 
> take care,
>   Gerd
> 


Thanks, this works, I tested with the 46 bit limit.

In terms of virt-install, I used the extra option:

--qemu-commandline='-cpu host,host-phys-bits-limit=46'

Charles maybe something to update the older os info definitions (for QEMU 8.2 and newer..?)

The idea is just that the toolstack could automatically correct for this for older Linux guests, requiring a limit on the host-phys-bits.
Exactly how, I don't know what's best.

Thanks,

Claudio



