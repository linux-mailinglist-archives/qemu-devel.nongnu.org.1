Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 381167A70AC
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 04:44:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qinB8-00049r-4m; Tue, 19 Sep 2023 22:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qinB6-00049b-Nh
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 22:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qinB4-0003Qp-Oz
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 22:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695177777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CG+oi1mMU5fVHdBvEQ5EIOypdiKpnVC4+FICTtij+0Y=;
 b=apGQOSffBReeAOo60xqKFA2F8QDxPPgTpX9y6sK3jWOg3RqixbkLq2WkArXE7Ytol3J7vB
 boH6H5xewpB00oXjJt235m2lNqgOTFz9iIy4rnJWmBchRm50GnVbh+pSvifwOebDxafKD5
 rZWLyf4MZpX7+wQi3wvPDDDZnGTUTh0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-MBo2wnSCPrSiK-i63o_VtA-1; Tue, 19 Sep 2023 22:42:54 -0400
X-MC-Unique: MBo2wnSCPrSiK-i63o_VtA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-503c774fd61so337735e87.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 19:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695177773; x=1695782573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CG+oi1mMU5fVHdBvEQ5EIOypdiKpnVC4+FICTtij+0Y=;
 b=ZVLK6+7l18y+5OdjD//WtaSxyPs9IMCC5DkfaZNI5LJjgZ45IWFinj/ppkbTtpg+MO
 V4jkBsqGPCqVUTbsz+iL8epM0cMy7mBSub1vi1mjCpPpmFo8XRTDeHcvYPx6ubQ41lIq
 2HN8L+3zBS3kx2zLIAzvFSMaJTI5FjuWmNlp4tDlobEn4uvRdRafi7h4/LolQA0EH+gt
 dANf0uKxQwwaym49XgVLKYnY8zwIJ5yakRwNF5zwCC00nVYEbvqmOPunbUqyyKCuufeA
 hFguis5zUMceEvdD4vkblMa0VMwI4E6n2MPPTrGXNvCZZXfwWb12WS9qolxe3CA4yLLN
 GZSw==
X-Gm-Message-State: AOJu0YxP4fKvPAH1bqBpykcMIIsFHofr1iijlk93kDPsZjRiBcvbhcXB
 MhFplReWA/s662romtUd9HQc5cox95Q6Vh+zVW2HpHHjTzD6ksVphrAyio+oG79il2Uk1n4FR+3
 qXLDDXTVFAOT92kg=
X-Received: by 2002:ac2:4990:0:b0:4f9:5519:78b8 with SMTP id
 f16-20020ac24990000000b004f9551978b8mr1087372lfl.63.1695177772749; 
 Tue, 19 Sep 2023 19:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa6mT+IM1Ip+Bvd5uA4yq2LzONzbFBh1w2DqkCRpkK249ClfbMNWL11VmTJOUxohsDMaoVxA==
X-Received: by 2002:ac2:4990:0:b0:4f9:5519:78b8 with SMTP id
 f16-20020ac24990000000b004f9551978b8mr1087361lfl.63.1695177772436; 
 Tue, 19 Sep 2023 19:42:52 -0700 (PDT)
Received: from redhat.com ([2.52.26.122]) by smtp.gmail.com with ESMTPSA id
 w21-20020a056402129500b0052c9f1d3cfasm8207343edv.84.2023.09.19.19.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 19:42:51 -0700 (PDT)
Date: Tue, 19 Sep 2023 22:42:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 0/8] ACPI: X86 AML generation and GPE tracing cleanup
Message-ID: <20230919224233-mutt-send-email-mst@kernel.org>
References: <20230908084234.17642-1-shentey@gmail.com>
 <9F292779-FCA7-43B3-BC37-CCE2E7958B57@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9F292779-FCA7-43B3-BC37-CCE2E7958B57@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 19, 2023 at 07:47:09PM +0000, Bernhard Beschow wrote:
> 
> 
> Am 8. September 2023 08:42:26 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
> >This series contains changes from my effort to bring the VIA south bridges to
> >
> >the PC machine [1]. The first part of the series resolves the
> >
> >AcpiCpuAmlIfClass::madt_cpu virtual method which frees ACPI controllers from
> >
> >worrying about CPU AML generation. The second part minimizes an Intel-specific
> >
> >assumption in AML generation to just one place. The third part contains two
> >
> >ACPI tracing patches which have been reviewed a long time ago but weren't merged
> >
> >yet.
> >
> >
> >
> >The removal of AcpiCpuAmlIfClass::madt_cpu is essentially a respin of [2] with
> >
> >a different approach. Igor wasn't generally against it but wasn't convinced
> >
> >either [3]. The new approach causes much less churn and instead allows to
> >
> >remove code. So I think it's worth to be reconsidered.
> >
> >
> >
> >The motivation for removing this virtual method didn't change: It frees the ACPI
> >
> >controllers in general and PIIX4 PM in particular from generating X86 CPU AML.
> >
> >The latter is also used in MPIS context where X86 CPU AML generation is
> >
> >stubbed out. This indicates a design issue where a problem was solved at the
> >
> >wrong place. Moreover, it turned out that TYPE_ACPI_GED_X86 could be removed as
> >
> >well, further supporting this claim.
> >
> >
> >
> >The second part of this series limits SMI command port determination during AML
> >
> >generation to just one place. Currently the ACPI_PORT_SMI_CMD constant is used
> >
> >multiple times which has an Intel-specific value. In order to make the code a
> >
> >microscopic bit more compatible with our VIA south bridge models its usage gets
> >
> >limited to one place, allowing the constant to be turned into a device model
> >
> >property in the future.
> >
> >
> >
> >The third part improves the tracing experience for ACPI general purpose events.
> >
> >It originates from an old series: [4].
> >
> >
> >
> >Testing done:
> >
> >* `make check`
> >
> >* `make check-avocado`
> >
> >
> >
> >v2:
> >
> >* Trace ACPI GPE values with "0x%02" (Phil)
> >
> 
> Ping
> 
> All patches reviewed. Michael, are you the one going to queue it?
> 
> Thanks,
> Bernhard

yes, thanks!

> >
> >
> >[1] https://github.com/shentok/qemu/tree/pc-via
> >
> >[2] https://lore.kernel.org/qemu-devel/20230121151941.24120-1-shentey@gmail.com/
> >
> >[3] https://lore.kernel.org/qemu-devel/20230125174842.395fda5d@imammedo.users.ipa.redhat.com/
> >
> >[4] https://patchew.org/QEMU/20230122170724.21868-1-shentey@gmail.com/
> >
> >
> >
> >Bernhard Beschow (8):
> >
> >  hw/i386/acpi-build: Use pc_madt_cpu_entry() directly
> >
> >  hw/acpi/cpu: Have build_cpus_aml() take a build_madt_cpu_fn callback
> >
> >  hw/acpi/acpi_dev_interface: Remove now unused madt_cpu virtual method
> >
> >  hw/acpi/acpi_dev_interface: Remove now unused #include "hw/boards.h"
> >
> >  hw/i386: Remove now redundant TYPE_ACPI_GED_X86
> >
> >  hw/i386/acpi-build: Determine SMI command port just once
> >
> >  hw/acpi: Trace GPE access in all device models, not just PIIX4
> >
> >  hw/acpi/core: Trace enable and status registers of GPE separately
> >
> >
> >
> > hw/acpi/hmat.h                         |  3 ++-
> >
> > hw/i386/acpi-common.h                  |  3 +--
> >
> > include/hw/acpi/acpi_dev_interface.h   |  3 ---
> >
> > include/hw/acpi/cpu.h                  |  6 ++++-
> >
> > include/hw/acpi/generic_event_device.h |  2 --
> >
> > hw/acpi/acpi-x86-stub.c                |  6 -----
> >
> > hw/acpi/core.c                         |  9 +++++++
> >
> > hw/acpi/cpu.c                          |  9 +++----
> >
> > hw/acpi/hmat.c                         |  1 +
> >
> > hw/acpi/memory_hotplug.c               |  1 +
> >
> > hw/acpi/piix4.c                        |  5 ----
> >
> > hw/i386/acpi-build.c                   | 13 +++++-----
> >
> > hw/i386/acpi-common.c                  |  5 ++--
> >
> > hw/i386/acpi-microvm.c                 |  3 +--
> >
> > hw/i386/generic_event_device_x86.c     | 36 --------------------------
> >
> > hw/i386/microvm.c                      |  2 +-
> >
> > hw/isa/lpc_ich9.c                      |  1 -
> >
> > hw/acpi/trace-events                   | 10 ++++---
> >
> > hw/i386/meson.build                    |  1 -
> >
> > 19 files changed, 38 insertions(+), 81 deletions(-)
> >
> > delete mode 100644 hw/i386/generic_event_device_x86.c
> >
> >
> >
> >-- >
> >2.42.0
> >
> >
> >


