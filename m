Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0267A4A7E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:07:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiDwx-0002xm-2u; Mon, 18 Sep 2023 09:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiDwp-0002xM-Hd
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiDwj-00073q-8V
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695042346;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ON7aS2D98kih6V+28uAsx+Vc2Q5NeUk3YyujT58xDE4=;
 b=X8xgyu+5Ee41zYFoksgYputo8d+wVd4rK6ca5bPqedm05Fvnme55LPeqkoPWwBcqmMrleC
 eDTvMjepsFtYEDcM4tNhLIvfZug8ykt9chdR8W7JfBHuOnP3yys3zVBkYNFkUZHHZGptVb
 b3h2z8msLxdvpObMbJvPEMUACl6gHC4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-yK-arTFqML-s-EwTBurLAA-1; Mon, 18 Sep 2023 09:05:43 -0400
X-MC-Unique: yK-arTFqML-s-EwTBurLAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B528A185A790;
 Mon, 18 Sep 2023 13:05:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4ECDC15BB8;
 Mon, 18 Sep 2023 13:05:41 +0000 (UTC)
Date: Mon, 18 Sep 2023 14:05:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 0/3] Firmware/seabios 20230912 patches
Message-ID: <ZQhLI0EzYFbXv9sW@redhat.com>
References: <20230912105359.563101-1-kraxel@redhat.com>
 <CAJSP0QX23UNOTCRsiHZWSa1j9KGA229S84+k7nNiDyp-AkNCFg@mail.gmail.com>
 <d7zwpgvdosd7ron3odscmwfqq5cwibyqi2drkjv22z5m5nzn3r@ltokhlip4ztv>
 <CAJSP0QU4EocB1FaAwwcUS9aZShXb5nr+ME1LEqe=Gujn39h-Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QU4EocB1FaAwwcUS9aZShXb5nr+ME1LEqe=Gujn39h-Lw@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Sep 18, 2023 at 08:52:57AM -0400, Stefan Hajnoczi wrote:
> On Mon, 18 Sept 2023 at 06:00, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > > Hi Gerd,
> > > I think either this pull request or your edk2 pull request causes the
> > > following CI failure:
> > >
> > > >>> G_TEST_DBUS_DAEMON=/builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-aarch64 MALLOC_PERTURB_=199 /builds/qemu-project/qemu/build/tests/qtest/bios-tables-test --tap -k
> > > ――――――――――――――――――――――――――――――――――――― ✀ ―――――――――――――――――――――――――――――――――――――
> >
> > Address change in ACPI tables (edk2 PR):
> >
> >      DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
> >      {
> >          Scope (\_SB)
> >          {
> >              Device (NVDR)
> >              {
> >                  Name (_HID, "ACPI0012" /* NVDIMM Root Device */)  // _HID: Hardware ID
> >                  [ ... ]
> >              }
> >          }
> >
> >     -    Name (MEMA, 0x43D10000)
> >     +    Name (MEMA, 0x43C90000)
> >      }
> >
> > seabios PR is fine and passes "make check".
> 
> I'm still seeing a CI failure:
> 
> 3/61 qemu:qtest+qtest-x86_64 / qtest-x86_64/bios-tables-test ERROR
> 19.18s killed by signal 6 SIGABRT
> ――――――――――――――――――――――――――――――――――――― ✀ ―――――――――――――――――――――――――――――――――――――
> stderr:
> acpi-test: Warning! DSDT binary file mismatch. Actual
> [aml:/var/folders/76/zy5ktkns50v6gt5g8r0sf6sc0000gn/T/aml-SW7IB2],
> Expected [aml:tests/data/acpi/q35/DSDT.mmio64].
> See source file tests/qtest/bios-tables-test.c for instructions on how
> to update expected files.
> to see ASL diff between mismatched files install IASL, rebuild QEMU
> from scratch and re-run tests with V=1 environment variable set**
> ERROR:../tests/qtest/bios-tables-test.c:535:test_acpi_asl: assertion
> failed: (all_tables_match)

Hmm, that's rather unhelpful - we need to get iasl added to the build
env by default.

> (test program exited with status code -6)
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/5110608123

Note this is a aarch64 macOS environment

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


