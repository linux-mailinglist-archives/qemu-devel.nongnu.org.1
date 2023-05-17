Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 478D9706CA6
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:26:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJ2F-0004UH-8N; Wed, 17 May 2023 11:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzJ1z-0004N3-Nt
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzJ1x-0000F5-IJ
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684337132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/9proWdpCnevndVAMu1VzDZYV9NT9OPQSvCINh+P0Y=;
 b=Og4YhHsIaMQsre9DE2Szvu/0ExAvVERolJdKadUsKgztNZHmDml1MaZUsgoxc9Lqnv48DX
 xRS51IWxVat5rGuMiYSmkN/SaOEB04MRz7x9+Uv9FOqqsVo8/WIgFf/ueb6K1Wu5u4Tx1C
 FlYxst0vCipqqHQrKKscWD3mQkL7z4I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-7mFFP3abMtujoK74Xpu7gA-1; Wed, 17 May 2023 11:25:31 -0400
X-MC-Unique: 7mFFP3abMtujoK74Xpu7gA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f518f2900eso6475045e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 08:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684337130; x=1686929130;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V/9proWdpCnevndVAMu1VzDZYV9NT9OPQSvCINh+P0Y=;
 b=eHqImiMCXTKYGSMiUh+IX9323uxlxt484EOPnDY/Sk0I7T469SctnCuj00SgkwoTJ+
 LWEFbBxjXN3rvATBoh3JAIyxhMQT+a7WsGr1EF9MePd7FnqElI7JWnddDBbfiHlVzq9x
 +MC0H8r6z+HhAgMu47MkX3vXV819dOG5qFmg/VjexYNXyEHgq3jeH374UuV0FEAz/NSr
 fgCq+ZZaXkWw2rckvZgdRACJVKf4UGtUT6fWOwFBVJBIO9qnUm/3vTPqwPmRH6McVOQ5
 i87zeItb/waw94w9hu8ZahSBLZXyCQ7FOtn06eKoG28/j/UUxpR5AgKeSxnuWYnVQ29T
 yQLQ==
X-Gm-Message-State: AC+VfDyRkAiRc7M/JW4PMf5NS9WcIx2JHB20QfywWmlUEYfyO1QgrK/I
 duF37dQQTkjP2Q3K3JqeGuINBvzY9D8gjH0JCrSbFeo57vFAbe/t4YbkukrIemAyNEiBYinmN9r
 AV2D4Nc6etTxE1qY=
X-Received: by 2002:a05:600c:22cf:b0:3f4:ef3c:a89f with SMTP id
 15-20020a05600c22cf00b003f4ef3ca89fmr14795077wmg.1.1684337130163; 
 Wed, 17 May 2023 08:25:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7VWU6AXwzvrwI3hGq3Tvz6BI0IxHS56WUTB53P6HBSTimWf+19DTkkiT+GA9DIBJZVKMSSPQ==
X-Received: by 2002:a05:600c:22cf:b0:3f4:ef3c:a89f with SMTP id
 15-20020a05600c22cf00b003f4ef3ca89fmr14795063wmg.1.1684337129797; 
 Wed, 17 May 2023 08:25:29 -0700 (PDT)
Received: from redhat.com ([109.253.194.87]) by smtp.gmail.com with ESMTPSA id
 f6-20020a1cc906000000b003f435652aaesm2581929wmb.11.2023.05.17.08.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 08:25:29 -0700 (PDT)
Date: Wed, 17 May 2023 11:25:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
Message-ID: <20230517112347-mutt-send-email-mst@kernel.org>
References: <20230517120751.14679-1-anisinha@redhat.com>
 <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com>
 <87zg63m18g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zg63m18g.fsf@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, May 17, 2023 at 04:16:47PM +0100, Alex Bennée wrote:
> 
> Ani Sinha <anisinha@redhat.com> writes:
> 
> >> On 17-May-2023, at 8:06 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> 
> >> On Wed, May 17, 2023 at 07:57:53PM +0530, Ani Sinha wrote:
> >>> 
> >>> 
> >>>> On 17-May-2023, at 7:47 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>> 
> >>>> On Wed, May 17, 2023 at 05:37:51PM +0530, Ani Sinha wrote:
> >>>>> Currently the meson based QEMU build process locates the iasl binary from the
> >>>>> current PATH and other locations [1] and uses that to set CONFIG_IASL which is
> >>>>> then used by the test.
> >>>>> 
> >>>>> This has two disadvantages:
> >>>>> - If iasl was not previously installed in the PATH, one has to install iasl
> >>>>>  and rebuild QEMU in order to pick up the iasl location. One cannot simply
> >>>>>  use the existing bios-tables-test binary because CONFIG_IASL is only set
> >>>>>  during the QEMU build time by meson and then bios-tables-test has to be
> >>>>>  rebuilt with CONFIG_IASL set in order to use iasl.
> 
> Usually we work the other way by checking at configure time and skipping
> the feature if the prerequisites are not in place. We do this with gdb:
> 
>   ../../configure --gdb=/home/alex/src/tools/binutils-gdb.git/builds/all/install/bin/gdb
> 
> which checks gdb is at least new enough to support the features we need:
> 
>   if test -n "$gdb_bin"; then
>       gdb_version=$($gdb_bin --version | head -n 1)
>       if version_ge ${gdb_version##* } 9.1; then
>           echo "HAVE_GDB_BIN=$gdb_bin" >> $config_host_mak
>           gdb_arches=$("$source_path/scripts/probe-gdb-support.py" $gdb_bin)
>       else
>           gdb_bin=""
>       fi
>   fi
> 
> >>>>> - Sometimes, the stock iasl that comes with distributions is simply not good
> >>>>>  enough because it does not support the latest ACPI changes - newly
> >>>>>  introduced tables or new table attributes etc. In order to test ACPI code
> >>>>>  in QEMU, one has to clone the latest acpica upstream repository and
> >>>>>  rebuild iasl in order to get support for it. In those cases, one may want
> >>>>>  the test to use the iasl binary from a non-standard location.
> 
> I think configure should be checking if iasl is new enough and reporting
> to the user at configure time they need to do something different. We
> don't want to attempt to run tests that will fail unless the user has
> added the right magic to their environment.

iasl is a disassembler we trigger for user convenience in case tests
fail. It will never cause tests to fail.

> >>>>> 
> >>>>> In order to overcome the above two disadvantages, we introduce a new
> >>>>> environment variable IASL_PATH that can be set by the tester pointing to an
> >>>>> possibly non-standard iasl binary location. Bios-tables-test then uses this
> >>>>> environment variable to set its iasl location, possibly also overriding the
> >>>>> location that was pointed to by CONFIG_IASL that was set by meson. This way
> >>>>> developers can not only use this new environment variable to set iasl
> >>>>> location to quickly run bios-tables-test but also can point the test to a
> >>>>> custom iasl if required.
> >>>>> 
> >>>>> [1] https://mesonbuild.com/Reference-manual_functions.html#find_program
> >>>>> 
> >>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >>>> 
> >>>> Well I think the point was originally that meson can
> >>>> also test the binary in a variety of ways.
> >>>> Never surfaced so maybe never mind.
> >>>> 
> >>>> Would it be easier to just look iasl up on path
> >>> 
> >>> But that’s what meson is also doing, only QEMU build time.
> >> 
> >> 
> >> So you were unhappy it's build time because it is not really
> >> part of build and you want flexibility, right?
> >
> > Hmm, maybe in that case, we might want to resurrect iasl_installed(),
> > basically reverting part of cc8fa0e80836c51ba644d910c.
> >
> > To me its ok if I had to set IASL_PATH=`which iasl` before running the
> > test. I do not have strong opinions.
> 
> I don't think so - we should be using the tools configure found, after
> all that is its job.
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


Let's say the whole problem does not seem that important to me either.

-- 
MST


