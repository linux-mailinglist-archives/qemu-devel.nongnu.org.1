Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4A7706DA5
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:08:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJhA-0007zL-1u; Wed, 17 May 2023 12:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzJh7-0007z0-Ue
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzJh6-00016D-5a
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684339683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CF5HnGBuKmKf4+ZT5nX31qPWafC16/r8+1bTNGX5eNc=;
 b=RFJu0yaVs3on1zm4S94Y6QTOfM7AEiF1WL5cHKYadvonOvbAMJ77ETQPHERIVfhV3OKr3C
 0UuusJN6DGMtkpkced/NonBH8M9wz1hYEkEn7RwT5L/gFsmBmPoC1ijldi2rKBjNTYBWUX
 sNH7xXvfqFq/UBhiex9qUiRQKnOXMTA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-FWhboEMmMiW3t08i1iBgMg-1; Wed, 17 May 2023 12:08:02 -0400
X-MC-Unique: FWhboEMmMiW3t08i1iBgMg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30940b01998so388948f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684339681; x=1686931681;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CF5HnGBuKmKf4+ZT5nX31qPWafC16/r8+1bTNGX5eNc=;
 b=ihABlBUwcdV1/CXLqXLluRsHT7p+JOPk8DheEQMj4d/2f0pSmNChFEia6nQb9YLh2h
 NzGmOiVkltHMx1g+49Lc/Yc7Ocl4NydGG/KSBartljb1oDH59bw4hdQ0CJ8rAjuwBSxh
 ueYy27uQPvXgKgs+RSFlvUrO5b2zJxPVJN73VC3wkK70uvkCQX0eTIlSYGYTaNN/Ji3j
 u2PZ3pB2ZoK5n7FtMneFavopdxWPr4sUsBzeU8S5MGSk2MKfdQJdZTBJKUof1q9/npvM
 Oxo5/oZG0w/e96FXhO6wEh2jGqoTV6q3yOb0toDS71xdfXCOCkF/2Z0hqbQCZy9PaFc9
 CT0w==
X-Gm-Message-State: AC+VfDz7Ze7U5ppMmrnKN0LnjoxJekG9hEk/EeXUfdyyCJXAQw/YxSy6
 s610O77dgdflC4+515sw/umIX0tIA7H3xr+fXvzSa44fhIdCfSL7+GPu3El+aXuu0ipg95j+zjY
 IGWJqvLeCuGGT3dg=
X-Received: by 2002:adf:f6c4:0:b0:2fe:c0ea:18b5 with SMTP id
 y4-20020adff6c4000000b002fec0ea18b5mr1124153wrp.35.1684339681165; 
 Wed, 17 May 2023 09:08:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5I39JS/K+wititmQzGu1w0TynL6FKZ/YqCkTIj01TH5f+CAQB6y9eh5M+4hKDk6Xw3g6+rcQ==
X-Received: by 2002:adf:f6c4:0:b0:2fe:c0ea:18b5 with SMTP id
 y4-20020adff6c4000000b002fec0ea18b5mr1124134wrp.35.1684339680783; 
 Wed, 17 May 2023 09:08:00 -0700 (PDT)
Received: from redhat.com ([109.253.194.87]) by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0030631dcbea6sm3160439wrp.77.2023.05.17.09.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 09:08:00 -0700 (PDT)
Date: Wed, 17 May 2023 12:07:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
Message-ID: <20230517120710-mutt-send-email-mst@kernel.org>
References: <20230517120751.14679-1-anisinha@redhat.com>
 <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com>
 <87zg63m18g.fsf@linaro.org>
 <20230517112347-mutt-send-email-mst@kernel.org>
 <87r0rflzd4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0rflzd4.fsf@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 17, 2023 at 04:58:06PM +0100, Alex Bennée wrote:
> 
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Wed, May 17, 2023 at 04:16:47PM +0100, Alex Bennée wrote:
> >> 
> >> Ani Sinha <anisinha@redhat.com> writes:
> >> 
> >> >> On 17-May-2023, at 8:06 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> >> 
> >> >> On Wed, May 17, 2023 at 07:57:53PM +0530, Ani Sinha wrote:
> >> >>> 
> >> >>> 
> >> >>>> On 17-May-2023, at 7:47 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> >>>> 
> >> >>>> On Wed, May 17, 2023 at 05:37:51PM +0530, Ani Sinha wrote:
> >> >>>>> Currently the meson based QEMU build process locates the iasl binary from the
> >> >>>>> current PATH and other locations [1] and uses that to set CONFIG_IASL which is
> >> >>>>> then used by the test.
> >> >>>>> 
> >> >>>>> This has two disadvantages:
> >> >>>>> - If iasl was not previously installed in the PATH, one has to install iasl
> >> >>>>>  and rebuild QEMU in order to pick up the iasl location. One cannot simply
> >> >>>>>  use the existing bios-tables-test binary because CONFIG_IASL is only set
> >> >>>>>  during the QEMU build time by meson and then bios-tables-test has to be
> >> >>>>>  rebuilt with CONFIG_IASL set in order to use iasl.
> >> 
> >> Usually we work the other way by checking at configure time and skipping
> >> the feature if the prerequisites are not in place. We do this with gdb:
> >> 
> >>   ../../configure --gdb=/home/alex/src/tools/binutils-gdb.git/builds/all/install/bin/gdb
> >> 
> >> which checks gdb is at least new enough to support the features we need:
> >> 
> >>   if test -n "$gdb_bin"; then
> >>       gdb_version=$($gdb_bin --version | head -n 1)
> >>       if version_ge ${gdb_version##* } 9.1; then
> >>           echo "HAVE_GDB_BIN=$gdb_bin" >> $config_host_mak
> >>           gdb_arches=$("$source_path/scripts/probe-gdb-support.py" $gdb_bin)
> >>       else
> >>           gdb_bin=""
> >>       fi
> >>   fi
> >> 
> >> >>>>> - Sometimes, the stock iasl that comes with distributions is simply not good
> >> >>>>>  enough because it does not support the latest ACPI changes - newly
> >> >>>>>  introduced tables or new table attributes etc. In order to test ACPI code
> >> >>>>>  in QEMU, one has to clone the latest acpica upstream repository and
> >> >>>>>  rebuild iasl in order to get support for it. In those cases, one may want
> >> >>>>>  the test to use the iasl binary from a non-standard location.
> >> 
> >> I think configure should be checking if iasl is new enough and reporting
> >> to the user at configure time they need to do something different. We
> >> don't want to attempt to run tests that will fail unless the user has
> >> added the right magic to their environment.
> >
> > iasl is a disassembler we trigger for user convenience in case tests
> > fail. It will never cause tests to fail.
> 
> Fair enough. But I still think the place to report it is in configure.
> Maybe something like:
> 
>     iasl                         : /usr/bin/iasl (version 20200925, might not handle all ACPI)           
> 
> in the Host Binaries section. Re-configuring shouldn't cause too much of
> the build to be regenerated although we could certainly do better in
> this regard.

won't all of it be regenerated? a header everyone includes changes.

-- 
MST


