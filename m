Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1294740F61
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 12:55:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qESop-0007Pj-9a; Wed, 28 Jun 2023 06:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qESoo-0007PX-20
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qESom-0000wC-9p
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687949675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=63T0JyU0ZtMZjXS5h8jX5BOC4I+j1HdnoJsL9RQneqQ=;
 b=dFnTwSpDgywjAj6aSGNl3GKlf0mzgltC0+5S8XWo3H4KZPIXXLCi6B5/D+7oyF/DcFhSC3
 iEmT/Li2LiA2ylZBV2iq3xeCaaZld9XueQqkv5Tqf4RttxiHEhTLcBYGF9IWvtYOH9ECH2
 fc3jImjxvWWigScVmPF24QY7J0xVpbY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-V6UOk3F6Mz2nhwxRX-QPlQ-1; Wed, 28 Jun 2023 06:54:34 -0400
X-MC-Unique: V6UOk3F6Mz2nhwxRX-QPlQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-313f5021d9bso1405748f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 03:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687949673; x=1690541673;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63T0JyU0ZtMZjXS5h8jX5BOC4I+j1HdnoJsL9RQneqQ=;
 b=bpcXkE6zIRlPZeuvG1BoGi94C1CZ9sgxdEdGdolWx/bNKoDa02po65s66MCuNoG0hR
 2T6ArsMUfzMboOx00gB0deNaRDvla8oKDYWFTUO7GIqpyVeXfdwLWxAsHNchcqG1Ki7h
 d794rjPIr5/03P5htOhw55LHfFMvayV+C1jIaRR/zO5qgjM0Wr3LdDLFpWWqR/Bv4bE0
 B5hIxP1iyBcxXu5uEYTsTY+SXSfzqpjIr1uC3z9IRzBDh8YSvTPcMu87fZiayu91im+b
 aQSwMf1ctB6Ey8AgNX7CVQMzQGbeh8A+tetf+I69RxSOvr4gPEGjhG1OwFXZO4QRT7QT
 xKiA==
X-Gm-Message-State: AC+VfDwr9eyA9xCChWhac3nc8d16qZX07DhBnR43ECy943X7YzroVtwg
 2Ovr+Re/QKm+8CJI2+XdPeWUJV8wsmA96NV54CIKUWs0GuBHVSya0PL5R8GqxgWKc4ii1fLjcB9
 lgGy40IRGCCXXli4=
X-Received: by 2002:a5d:4083:0:b0:313:f2b3:af73 with SMTP id
 o3-20020a5d4083000000b00313f2b3af73mr5538246wrp.25.1687949672868; 
 Wed, 28 Jun 2023 03:54:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ62XeXgCG/0DTkj1iRYIPcZA7I+FmqRFkrs/9GkTl76pha9hCbFRQ71lBxmWhX5pt1BZHoTjw==
X-Received: by 2002:a5d:4083:0:b0:313:f2b3:af73 with SMTP id
 o3-20020a5d4083000000b00313f2b3af73mr5538239wrp.25.1687949672552; 
 Wed, 28 Jun 2023 03:54:32 -0700 (PDT)
Received: from redhat.com ([176.12.183.225]) by smtp.gmail.com with ESMTPSA id
 l6-20020a5d4106000000b0030c2e3c7fb3sm13037746wrp.101.2023.06.28.03.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 03:54:32 -0700 (PDT)
Date: Wed, 28 Jun 2023 06:54:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3] acpi/tests/bios-tables-test: make iasl tool handling
 simpler
Message-ID: <20230628065132-mutt-send-email-mst@kernel.org>
References: <20230522103039.19111-1-anisinha@redhat.com>
 <20230626084401-mutt-send-email-mst@kernel.org>
 <9B31F63A-164A-42EF-9387-1F6A56BC9BEA@redhat.com>
 <20230626091206-mutt-send-email-mst@kernel.org>
 <585996FE-8415-4ECC-BBB2-1BDA0C3D8E25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <585996FE-8415-4ECC-BBB2-1BDA0C3D8E25@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jun 28, 2023 at 12:05:46PM +0530, Ani Sinha wrote:
> 
> 
> > On 26-Jun-2023, at 6:49 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Mon, Jun 26, 2023 at 06:33:14PM +0530, Ani Sinha wrote:
> >> 
> >> 
> >>> On 26-Jun-2023, at 6:28 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>> 
> >>> On Mon, May 22, 2023 at 04:00:39PM +0530, Ani Sinha wrote:
> >>>> Currently the meson based QEMU build process locates the iasl binary from the
> >>>> current PATH and other locations [1] and uses that to set CONFIG_IASL in
> >>>> config-host.h header.This is then used at compile time by bios-tables-test to
> >>>> set iasl path.
> >>>> 
> >>>> This has two disadvantages:
> >>>> - If iasl was not previously installed in the PATH, one has to install iasl
> >>>>  and rebuild QEMU in order to regenerate the header and pick up the found
> >>>>  iasl location. One cannot simply use the existing bios-tables-test binary
> >>>>  because CONFIG_IASL is only set during the QEMU build time by meson and
> >>>>  then bios-tables-test has to be rebuilt with CONFIG_IASL set in order to
> >>>>  use iasl.
> >>>> - Sometimes, the stock iasl that comes with distributions is simply not good
> >>>>  enough because it does not support the latest ACPI changes - newly
> >>>>  introduced tables or new table attributes etc. In order to test ACPI code
> >>>>  in QEMU, one has to clone the latest acpica upstream repository and
> >>>>  rebuild iasl in order to get support for it. In those cases, one may want
> >>>>  the test to use the iasl binary from a non-standard location.
> >>>> 
> >>>> In order to overcome the above two disadvantages, we set a default iasl path
> >>>> as "/usr/bin/iasl". bios-tables-test also checks for the environment variable
> >>>> IASL_PATH that can be set by the developer. IASL_PATH passed from the
> >>>> environment overrides the default path. This way developers can point
> >>>> IASL_PATH environment variable to a possibly a non-standard custom build
> >>>> binary and quickly run bios-tables-test without rebuilding. If the default
> >>>> path of iasl changes, one simply needs to update the default path and rebuild
> >>>> just the test, not whole QEMU.
> >>>> 
> >>>> [1] https://mesonbuild.com/Reference-manual_functions.html#find_program
> >>>> 
> >>>> CC: alex.bennee@linaro.org
> >>>> CC: pbonzini@redhat.com
> >>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >>> 
> >>> I don't much like environment variables since they are
> >>> not discoverable.
> >> 
> >> I do have this:
> >> 
> >> +                " Set IASL_PATH environment variable to the path of iasl binary\n"
> >> +                " if iasl is installed somewhere other than %s.\n",
> > 
> > You only see this if there's a diff.
> > 
> > And then people stick this in their scripts and are scratching their
> > heads trying to figure out why is a wrong iasl running.  Or someone
> > comes up with a different use for IASL_PATH and they conflict.
> 
> OK in that case I think its ok to simply remove the environment
> variable part. If people are going to be changing a header file,

Not people. configure script

> they
> might as well change the DEFAULT_IASL_PATH in the test itself where
> its easier to find. What additional complication meson provides is
> that it uses find_program() to find the IASL binary in a list of
> predefined locations. I do not think this additional tie up with meson
> is worth it for the niche iasl use case.  Simple is beautiful.

The just the below then? And we can let it be?

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index ed1c69cf01..d0e1655d2e 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -102,6 +102,7 @@ typedef struct {
 
 static char disk[] = "tests/acpi-test-disk-XXXXXX";
 static const char *data_dir = "tests/data/acpi";
+/* If you want your own path, change the below to iasl = "/home/usr/bin/iasl" */
 #ifdef CONFIG_IASL
 static const char *iasl = CONFIG_IASL;
 #else


