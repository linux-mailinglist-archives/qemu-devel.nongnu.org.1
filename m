Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2907673B1C2
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 09:35:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCbJX-00057g-U8; Fri, 23 Jun 2023 03:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCbJV-00056Y-1O
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 03:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCbJT-0002Gh-5r
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 03:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687505674;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lfP4iqB/+NrbnkkrQsrp4BDqcurQYEcu7cXpy3uONtI=;
 b=HWg8afQBLYwC4aPLNvk9nJkuILnsDuMp5uJewxyQusLQTqZo6GuYaiK5eneMIIXi/PMScF
 vRpdrCSo0e0WSSKIxzEjGabdKM+DXYkpLbeV7PNS4tXhga3taUyvRMMd5UkpjH4R2TREAB
 H+uXgcRrcvZiaSKxgPvgaiZGp7TZZNA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-NKCbdNumNRKyjdvRxrSYmg-1; Fri, 23 Jun 2023 03:34:32 -0400
X-MC-Unique: NKCbdNumNRKyjdvRxrSYmg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3127a76c56bso177268f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 00:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687505672; x=1690097672;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfP4iqB/+NrbnkkrQsrp4BDqcurQYEcu7cXpy3uONtI=;
 b=ZNktM6KJ008UN+OZhhzBpGQrWVfQvrVjKVg7Pt4IBH1De/HGboKbMU+LKrihAG2K7T
 xBFj4DPt5E+ZCQXP2WnOMValVcY9bxXMi6Yc2xdOTZTGtpTqQvaS9QSnQejYecPO+CHu
 q4gVqyA/y+votSHl0C48BHg9oEVtLebIYqFtbPGM/OekKit3BF+ja88mkBtCASKbcMOE
 42NKLzd8RYgQ7CmjbwA0AGwrbPR1b1hjglGdEg0MZrxskrTw4eXt2rmZzDdsp2ivVR4y
 +fj1TYDDEPAtumf5PFLvwoZHXppjDvTeQNU0A5MkHhJAfEJvrtwDO79kxFQ+UnawQfWw
 HPkg==
X-Gm-Message-State: AC+VfDyxmBAFG0fJijNGYcZTNB8LzIUSNM9O9Azcwu3J1IxJutdy4Xa6
 6CrtS5YCju5zLr2xyzXshWcP7bHO7qj5LnNVZ4UItG68T5/1hlLPzobG4e1nPs1PXLOYsTnxuOb
 PXZ6xJpsUjHtFkTU=
X-Received: by 2002:adf:f203:0:b0:311:19df:dac7 with SMTP id
 p3-20020adff203000000b0031119dfdac7mr14850585wro.28.1687505671850; 
 Fri, 23 Jun 2023 00:34:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6SlrLnaw6S09RNknRpWHEAfty/JCfLthbXSaFnziXBihOwvYoAgtVP/X7NjeuQ3NvN754s9A==
X-Received: by 2002:adf:f203:0:b0:311:19df:dac7 with SMTP id
 p3-20020adff203000000b0031119dfdac7mr14850571wro.28.1687505671483; 
 Fri, 23 Jun 2023 00:34:31 -0700 (PDT)
Received: from redhat.com (84.125.88.130.dyn.user.ono.com. [84.125.88.130])
 by smtp.gmail.com with ESMTPSA id
 q6-20020adff506000000b00307c8d6b4a0sm8814024wro.26.2023.06.23.00.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 00:34:30 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  Leonardo Bras
 <leobras@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PULL 00/30] Next patches
In-Reply-To: <1f5c4a38-6ae2-53dd-d739-65accb1d86a8@linaro.org> (Richard
 Henderson's message of "Fri, 23 Jun 2023 07:45:43 +0200")
References: <20230622165527.2417-1-quintela@redhat.com>
 <1f5c4a38-6ae2-53dd-d739-65accb1d86a8@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 23 Jun 2023 09:34:28 +0200
Message-ID: <87ttuy1vjv.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Richard Henderson <richard.henderson@linaro.org> wrote:
> On 6/22/23 18:54, Juan Quintela wrote:
>> The following changes since commit b455ce4c2f300c8ba47cba7232dd03261368a4cb:
>>    Merge tag 'q800-for-8.1-pull-request'
>> ofhttps://github.com/vivier/qemu-m68k  into staging (2023-06-22
>> 10:18:32 +0200)
>> are available in the Git repository at:
>>    https://gitlab.com/juan.quintela/qemu.git  tags/next-pull-request
>> for you to fetch changes up to
>> 23e4307eadc1497bd0a11ca91041768f15963b68:
>>    migration/rdma: Split qemu_fopen_rdma() into input/output
>> functions (2023-06-22 18:11:58 +0200)
>> ----------------------------------------------------------------
>> Migration Pull request (20230621) take 2
>> In this pull request the only change is fixing 32 bits complitaion
>> issue.
>> Please apply.
>> [take 1]
>> - fix for multifd thread creation (fabiano)
>> - dirtylimity (hyman)
>>    * migration-test will go on next PULL request, as it has failures.
>> - Improve error description (tejus)
>> - improve -incoming and set parameters before calling incoming (wei)
>> - migration atomic counters reviewed patches (quintela)
>> - migration-test refacttoring reviewed (quintela)

I had the feeling when I wake up that today was going to be a great day.
Confirmed.

> New failure with check-cfi-x86_64:

Aha. CFI.  Something that I don't know what it is failing on me.

/me googles.

/me enables cfi+lto and compiles with clang.

50/491] Compiling C object subprojects/berkeley-testfloat-3/libtestfloat.a.p/source_test_az_f128_rx.c.o
[51/491] Compiling C object subprojects/berkeley-testfloat-3/libtestfloat.a.p/source_test_az_f128.c.o
[52/491] Compiling C object subprojects/berkeley-testfloat-3/libtestfloat.a.p/source_test_abz_f128.c.o
[53/491] Compiling C object subprojects/berkeley-testfloat-3/libtestfloat.a.p/source_test_abcz_f128.c.o
[54/491] Compiling C object subprojects/berkeley-testfloat-3/libtestfloat.a.p/source_test_ab_f128_z_bool.c.o
[55/491] Linking target qemu-system-x86_64
FAILED: qemu-system-x86_64 
clang++ -m64 -mcx16 @qemu-system-x86_64.rsp
/usr/bin/ld: cannot find libchardev.fa: Too many open files
/usr/bin/ld: cannot find libqmp.fa: Too many open files
/usr/bin/ld: cannot find libpage-vary-common.a: Too many open files
/usr/bin/ld: cannot find libqemuutil.a: Too many open files
/usr/bin/ld: cannot find subprojects/libvhost-user/libvhost-user-glib.a: Too many open files
/usr/bin/ld: cannot find subprojects/libvhost-user/libvhost-user.a: Too many open files
/usr/bin/ld: cannot find tcg/libtcg_softmmu.fa: Too many open files
/usr/bin/ld: cannot find libmigration.fa: Too many open files
/usr/bin/ld: cannot find libhwcore.fa: Too many open files
/usr/bin/ld: cannot find libqom.fa: Too many open files
/usr/bin/ld: cannot find gdbstub/libgdb_softmmu.fa: Too many open files
/usr/bin/ld: cannot find libio.fa: Too many open files
/usr/bin/ld: cannot find libcrypto.fa: Too many open files
/usr/bin/ld: cannot find libauthz.fa: Too many open files
/usr/bin/ld: cannot find libblockdev.fa: Too many open files
/usr/bin/ld: cannot find libblock.fa: Too many open files
/usr/bin/ld: cannot find libchardev.fa: Too many open files
/usr/bin/ld: cannot find libqmp.fa: Too many open files
/usr/bin/ld: cannot find /usr/lib64/libpixman-1.so: Too many open files
/usr/bin/ld: cannot find /usr/lib64/libepoxy.so: Too many open files
/usr/bin/ld: cannot find /usr/lib64/libxenctrl.so: Too many open files
/usr/bin/ld: cannot find /usr/lib64/libxenstore.so: Too many open files
/usr/bin/ld: cannot find /usr/lib64/libxenforeignmemory.so: Too many open files
/usr/bin/ld: cannot find /usr/lib64/libxengnttab.so: Too many open files
/usr/bin/ld: cannot find /usr/lib64/libxenevtchn.so: Too many open files

Confirmed, today is going to be a great day.

No check-cfi<anything> target for me.

/me investigates what is going on.  Found this and retries.

AR=llvm-ar CC=clang CXX=clang++ /mnt/code/qemu/full/configure
--enable-cfi --target-list=x86_64-softmmu

Gives the same error.

After a while of desesperation trying to disable features, etc, etc
Just doing a plain ulimit -n 4096 fixed the problem.

Here we go.

Later, Juan.


