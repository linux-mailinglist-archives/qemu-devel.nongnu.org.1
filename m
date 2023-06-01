Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F81D71F464
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 23:08:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4pVa-0006fg-96; Thu, 01 Jun 2023 17:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4pVW-0006fG-Q8
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 17:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4pVT-0004tp-PV
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 17:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685653609;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=VCn3S2bO7vVd+tqaJY9r0VUIq35cYk4x6kXRS+a8ero=;
 b=g8s/IS+cfP5lxTnSq/pMEARghRLZY79EJUlfcUr3qV1vxmQwMRpHgZ8r9Ptughz091To/v
 dCtxe8VmJ+42jPGN1YZsOwrbIx5C0WoCIgkbGEVmnpuh2dQJeAyfdFlHUbY47RfOMDZeE0
 Ezxd3ZsQ9YPGdHt5SCjZLMqLAm9niq8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-8M4no7l7Ou-rlCEU5uZI4A-1; Thu, 01 Jun 2023 17:06:48 -0400
X-MC-Unique: 8M4no7l7Ou-rlCEU5uZI4A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30af779d6e6so763050f8f.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 14:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685653606; x=1688245606;
 h=mime-version:message-id:date:reply-to:user-agent:subject:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VCn3S2bO7vVd+tqaJY9r0VUIq35cYk4x6kXRS+a8ero=;
 b=cudkPeVSK0xXlXJ5EdTCZACeWc6g7TefH3xWje3Gj2mt93iCPgvuIh2tIh89yBI/jc
 wZTNeKX1jK6Foo3nONUXJ2tHAWqzxIoSb35ifI1tp5gCjvEYTG7EnEfgpDMZ/LZtuPpo
 iMYOWGkboQ/jLo/IuCZ6zohcLeIETpE/UUCBmIojpK0A5YypqMeBgxl6/qRASnNMnIAp
 k+79I6+ctnBz4wiun7V9hSq7VCNa2Ge092e5Hx91ig3hchsoFjSlb+hFHpoBZCIo/arv
 oOWzd/c8QOZ6CN3Rcacj+xF6ui0hBiTiX3P2WfoDX0fG4Rqb1prbtQlMg8ihNXgdsrS5
 Iw3g==
X-Gm-Message-State: AC+VfDymxKQigvCkJthno/YQYLX8WNAdD1s6xNZ96oEvd2xTh+u6h/5B
 yd/TRs4X2vPtU7LUeKSyR3hNzZPGyNUta/Tglz/4oLqe2LLvGc5+lSMLNvU/L/8fiUdnk4PU/D6
 okA8ieuCd82a46X8dS96QPUA2RBbLyn2erueRf95uD/z9q1+Hn+qGNiAJ+F8mEhuJNO0vERn4/h
 p+FQ==
X-Received: by 2002:adf:e8c1:0:b0:306:3021:2304 with SMTP id
 k1-20020adfe8c1000000b0030630212304mr2755469wrn.60.1685653605704; 
 Thu, 01 Jun 2023 14:06:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7I6nSvmxzV04Yn3IFyymNUDGW1l/P8kr9YfYBJHbHkDWLmBPFGvHA+LlkZrxLFgYCO/ueTfQ==
X-Received: by 2002:adf:e8c1:0:b0:306:3021:2304 with SMTP id
 k1-20020adfe8c1000000b0030630212304mr2755452wrn.60.1685653605223; 
 Thu, 01 Jun 2023 14:06:45 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 u3-20020a5d6ac3000000b003062ad45243sm11435660wrw.14.2023.06.01.14.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 14:06:43 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, Richard Henderson
 <rth@twiddle.net>, Daniel Berrange <berrange@redhat.com>
Subject: Big TCG slowdown when using zstd with aarch64
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 01 Jun 2023 23:06:42 +0200
Message-ID: <87y1l2rixp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


Hi

Before I continue investigating this further, do you have any clue what
is going on here.  I am running qemu-system-aarch64 on x86_64.

$ time ./tests/qtest/migration-test -p /aarch64/migration/multifd/tcp/plain/none
TAP version 13
# random seed: R02S3d50a0e874b28727af4b862a3cc4214e
# Start of aarch64 tests
# Start of migration tests
# Start of multifd tests
# Start of tcp tests
# Start of plain tests
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2888203.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2888203.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -machine virt,gic-version=max -name source,debug-threads=on -m 150M -serial file:/tmp/migration-test-WT9151/src_serial -cpu max -kernel /tmp/migration-test-WT9151/bootsect     -accel qtest
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2888203.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2888203.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -machine virt,gic-version=max -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-WT9151/dest_serial -incoming defer -cpu max -kernel /tmp/migration-test-WT9151/bootsect    -accel qtest
ok 1 /aarch64/migration/multifd/tcp/plain/none
# End of plain tests
# End of tcp tests
# End of multifd tests
# End of migration tests
# End of aarch64 tests
1..1

real	0m4.559s
user	0m4.898s
sys	0m1.156s
$ time ./tests/qtest/migration-test -p /aarch64/migration/multifd/tcp/plain/zlib
TAP version 13
# random seed: R02S014dd197350726bdd95aea37b81d3898
# Start of aarch64 tests
# Start of migration tests
# Start of multifd tests
# Start of tcp tests
# Start of plain tests
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2888278.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2888278.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -machine virt,gic-version=max -name source,debug-threads=on -m 150M -serial file:/tmp/migration-test-25U151/src_serial -cpu max -kernel /tmp/migration-test-25U151/bootsect     -accel qtest
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2888278.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2888278.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -machine virt,gic-version=max -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-25U151/dest_serial -incoming defer -cpu max -kernel /tmp/migration-test-25U151/bootsect    -accel qtest
ok 1 /aarch64/migration/multifd/tcp/plain/zlib
# End of plain tests
# End of tcp tests
# End of multifd tests
# End of migration tests
# End of aarch64 tests
1..1

real	0m1.645s
user	0m3.484s
sys	0m0.512s
$ time ./tests/qtest/migration-test -p /aarch64/migration/multifd/tcp/plain/zstd
TAP version 13
# random seed: R02Se49afe2ea9d2b76a1eda1fa2bc8d812c
# Start of aarch64 tests
# Start of migration tests
# Start of multifd tests
# Start of tcp tests
# Start of plain tests
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2888353.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2888353.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -machine virt,gic-version=max -name source,debug-threads=on -m 150M -serial file:/tmp/migration-test-UILY51/src_serial -cpu max -kernel /tmp/migration-test-UILY51/bootsect     -accel qtest
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2888353.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2888353.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -machine virt,gic-version=max -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-UILY51/dest_serial -incoming defer -cpu max -kernel /tmp/migration-test-UILY51/bootsect    -accel qtest



ok 1 /aarch64/migration/multifd/tcp/plain/zstd
# End of plain tests
# End of tcp tests
# End of multifd tests
# End of migration tests
# End of aarch64 tests
1..1

real	0m48.022s
user	8m17.306s
sys	0m35.217s


This test is very amenable to compression, basically we only modify one
byte for each page, and basically all the pages are the same.

no compression: 4.5 seconds
zlib compression: 1.6 seconds (inside what I would expect)
zstd compression: 48 seconds, what is going on here?

As a comparison, this are the times for x86_64 running natively, values
much more reasonable.

$ time ./tests/qtest/migration-test -p /x86_64/migration/multifd/tcp/plain/none
TAP version 13
# random seed: R02S579fbe8739386c3a3336486f2adbfecd
# Start of x86_64 tests
# Start of migration tests
# Start of multifd tests
# Start of tcp tests
# Start of plain tests
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-3002254.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3002254.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -name source,debug-threads=on -m 150M -serial file:/tmp/migration-test-KA6Z51/src_serial -drive file=/tmp/migration-test-KA6Z51/bootsect,format=raw     -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-3002254.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3002254.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-KA6Z51/dest_serial -incoming defer -drive file=/tmp/migration-test-KA6Z51/bootsect,format=raw    -accel qtest
ok 1 /x86_64/migration/multifd/tcp/plain/none
# End of plain tests
# End of tcp tests
# End of multifd tests
# End of migration tests
# End of x86_64 tests
1..1

real	0m3.889s
user	0m4.264s
sys	0m1.295s
$ time ./tests/qtest/migration-test -p /x86_64/migration/multifd/tcp/plain/zlib
TAP version 13
# random seed: R02S968738d716d2c0dc8c8279716ff3dd9a
# Start of x86_64 tests
# Start of migration tests
# Start of multifd tests
# Start of tcp tests
# Start of plain tests
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-3002385.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3002385.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -name source,debug-threads=on -m 150M -serial file:/tmp/migration-test-9JTZ51/src_serial -drive file=/tmp/migration-test-9JTZ51/bootsect,format=raw     -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-3002385.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3002385.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-9JTZ51/dest_serial -incoming defer -drive file=/tmp/migration-test-9JTZ51/bootsect,format=raw    -accel qtest
ok 1 /x86_64/migration/multifd/tcp/plain/zlib
# End of plain tests
# End of tcp tests
# End of multifd tests
# End of migration tests
# End of x86_64 tests
1..1

real	0m1.464s
user	0m2.868s
sys	0m0.534s
$ time ./tests/qtest/migration-test -p /x86_64/migration/multifd/tcp/plain/zstd
TAP version 13
# random seed: R02Sba4a923c284ad824bc82fd488044a5df
# Start of x86_64 tests
# Start of migration tests
# Start of multifd tests
# Start of tcp tests
# Start of plain tests
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-3006857.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3006857.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -name source,debug-threads=on -m 150M -serial file:/tmp/migration-test-ALK251/src_serial -drive file=/tmp/migration-test-ALK251/bootsect,format=raw     -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-3006857.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3006857.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-ALK251/dest_serial -incoming defer -drive file=/tmp/migration-test-ALK251/bootsect,format=raw    -accel qtest
ok 1 /x86_64/migration/multifd/tcp/plain/zstd
# End of plain tests
# End of tcp tests
# End of multifd tests
# End of migration tests
# End of x86_64 tests
1..1

real	0m1.298s
user	0m2.540s
sys	0m0.662s

3.88, 1.46 and 1.29 seconds, what I would have expected.

And if you ask why is this so important: with 48 seconds, we are very
near the limit.  If I am running 2 or more migration tests at the same
time:

# random seed: R02Sfb0b65ab5484a997057ef94daed7072f
# Start of aarch64 tests
# Start of migration tests
# Start of multifd tests
# Start of tcp tests
# Start of plain tests
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2754383.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2754383.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -machine virt,gic-version=max -name source,debug-threads=on -m 150M -serial file:/tmp/migration-test-L93051/src_serial -cpu max -kernel /tmp/migration-test-L93051/bootsect     -accel qtest
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2754383.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2754383.qmp,id=char0 -mon chardev=char0,mode=control -display none -net none -accel kvm -accel tcg -machine virt,gic-version=max -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-L93051/dest_serial -incoming defer -cpu max -kernel /tmp/migration-test-L93051/bootsect    -accel qtest
**
ERROR:../../../../mnt/code/qemu/multifd/tests/qtest/migration-helpers.c:143:wait_for_migration_status: assertion failed: (g_test_timer_elapsed() < MIGRATION_STATUS_WAIT_TIMEOUT)
not ok /aarch64/migration/multifd/tcp/plain/zstd - ERROR:../../../../mnt/code/qemu/multifd/tests/qtest/migration-helpers.c:143:wait_for_migration_status: assertion failed: (g_test_timer_elapsed() < MIGRATION_STATUS_WAIT_TIMEOUT)
Bail out!
qemu-system-aarch64: multifd_send_pages: channel 0 has already quit!
qemu-system-aarch64: Unable to write to socket: Connection reset by peer
Aborted (core dumped)

real	2m0.928s
user	16m15.671s
sys	1m11.431s


Later, Juan.


