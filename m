Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B8A835817
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 23:21:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRgAh-0004G0-4B; Sun, 21 Jan 2024 17:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1rRgAf-0004Fr-FB
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 17:20:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1rRgAd-0007JF-L8
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 17:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705875602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4XxYJVJsXkHY4YpwbpGnmcFEOSJRQ1nOrWwARXXAQY=;
 b=ON2rf2/AX0jUJlGpihmuMjiliRqCKDQc7tLZRpELcbNWOgLiDSEl0b9fxHHYcQt4yymwGa
 n8Fc3syNwQ6kuNcbbs3TqtF8imPhqW7aYcK83lJ+1aOqSs4rusie+RxiU6GV1Pi7km7lWr
 qrKqfxvZcDVyjWL8tcbRPgvJvmPmgVc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-1Q2FASTdOL6hKiOa_NShjQ-1; Sun,
 21 Jan 2024 17:18:31 -0500
X-MC-Unique: 1Q2FASTdOL6hKiOa_NShjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A23052999B28
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 22:18:31 +0000 (UTC)
Received: from [10.22.32.65] (unknown [10.22.32.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66DA8C0FDCA;
 Sun, 21 Jan 2024 22:18:31 +0000 (UTC)
Message-ID: <b974967f-8bca-41b9-3ec5-05cf2f776765@redhat.com>
Date: Sun, 21 Jan 2024 17:18:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] pc-bios/optionrom: Fix pvh.img ld build failure on fedora
 rawhide
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
References: <20231128143647.847668-1-crobinso@redhat.com>
 <ZZVWtxyGkVzBjf0O@redhat.com>
 <pxcc3rmq7g7zriwgyv2uiovwicnzfvtvdsngmt47r746sukwxb@shbiglopqrrw>
From: Cole Robinson <crobinso@redhat.com>
In-Reply-To: <pxcc3rmq7g7zriwgyv2uiovwicnzfvtvdsngmt47r746sukwxb@shbiglopqrrw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crobinso@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.72, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/3/24 10:44 AM, Gerd Hoffmann wrote:
> On Wed, Jan 03, 2024 at 12:44:39PM +0000, Daniel P. Berrangé wrote:
>> On Tue, Nov 28, 2023 at 09:36:47AM -0500, Cole Robinson wrote:
>>> binutils 2.39 shows some warnings when building pvh.img
>>>
>>> /usr/bin/ld: warning: pvh.o: missing .note.GNU-stack section implies executable stack
>>> /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>>> /usr/bin/ld: warning: pvh.img has a LOAD segment with RWX permissions
>>>
>>> The latter of which is fatal on Fedora rawhide for some reason.
>>>
>>> Add linker options to suppress the errors
>>
>> This makes it silent, but I guess someone needs to confirm that this
>> option ROM code genuinely does NOT need to have executable stack,
>> otherwise the future change that is being warned about could impact
>> it ?
> 
> Skimming the code it does not look like it depends on a execute-able
> stack.  Beside that the option rom will be loaded as raw binary by
> seabios and run without paging.  There is nothing which could actually
> setup and enforce an NX stack ...
> 
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> 

I just realized this breaks the build on centos 9 with binutils
2.35.2-42.el9

make[1]: Leaving directory
'/builddir/build/BUILD/qemu-8.2.0/qemu_kvm_build/pc-bios/optionrom'
make[1]: Entering directory
'/builddir/build/BUILD/qemu-8.2.0/qemu_kvm_build/pc-bios/optionrom'
gcc -O2 -g -march=i486 -Wall -m32 -m16 -ffreestanding
-I/builddir/build/BUILD/qemu-8.2.0/include -fcf-protection=none -fno-pie
-no-pie -fno-stack-protector -Wno-array-bounds -nostdlib
-Wl,--build-id=none,-T,/builddir/build/BUILD/qemu-8.2.0/pc-bios/optionrom/flat.lds
-Wl,--no-warn-rwx-segments -Wl,--no-warn-execstack -s -o multiboot.img
multiboot.o
/usr/bin/ld: unrecognized option '--no-warn-rwx-segments'
/usr/bin/ld: use the --help option for usage information

This article has tips about how to fix these issues in the linker
scripts, so maybe that's the better approach:

https://www.redhat.com/en/blog/linkers-warnings-about-executable-stacks-and-segments

Thanks,
Cole


