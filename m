Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AA59493F7
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Aug 2024 16:57:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbLcB-0000dB-6B; Tue, 06 Aug 2024 10:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbLc9-0000cL-4m
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbLc4-0001sZ-S2
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722956193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=in22lGiWvjvVa+QnCNaYBNzPdS4W23iInNoRspQ3yDo=;
 b=YQF6zexygM4NJYBAV8KOU4JC0V5MdNMmslTuv0w3aCBVo1Az5+Lrw87Wv/tuPkAnNqSsUg
 TYfat3T3HvGZie3KEPdhokvOiz6NgWJw0+hOEW0128yBUtOdSaLcfvRmyc9eVAAZUW2/yQ
 2NbU3A8ym09RQeVHC0F2QA7UGnbGho0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-C17W2V3_NG-UJelpA4rNug-1; Tue, 06 Aug 2024 10:56:31 -0400
X-MC-Unique: C17W2V3_NG-UJelpA4rNug-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4281d0d1c57so32900125e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 07:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722956191; x=1723560991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=in22lGiWvjvVa+QnCNaYBNzPdS4W23iInNoRspQ3yDo=;
 b=sKXWXG4DY9brBkdzxa/UHSkTb1IrxS6UpA0XTLofzFNJZE7t5fA4Kkcb0DI+4akg1x
 0P/IolWklIJoym/4cWlf/7MYD4JbKbsAipZ7yUBxrpMQjusuEIef1Z8SPOx7NtfIg/Lc
 fRqrZ1UJq26Um6EBduUcCTSpatsvhRPJhLyR9+XjXrsDZziFtwDBVlTFz/kfkAidO0NU
 eDrTwyS6vbZIjimDdDuLGHCcVwKjp9Cr0CZ5LlvUTH5hDhgg1WWc6p0v6OlHNPNCuEVd
 fGoa/HWyjUm2trac6fcuiu/acofcA5lJcBXvwuA7J1EXIhLFl1d9z9yCb9mzXU1rZQy/
 QylA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW8X2vZ+LEFE5PyLbOaPNwRidi6i9qQZXia499dbebtchCB/xiXJywTzXCjo9S0RoNMZTYUKZHaSWgx6FOrGb1aVMmhKU=
X-Gm-Message-State: AOJu0YwEXo/pqn3GW2gIn9hiWwYYFJkujCF6TO1zChZvUo9asZKmyRim
 SaNW1DYTVy7ZiaJQtbpoPAUFZAjUH3EBbxmv51ky4vTOoMAcCpomqbSQ9UP4TDcsBIePuc0i0z2
 U/biXHc272qLIWPPGOgQoM9lKjUuCP9GiLzqBI8u9uQj6jCjKSJYw
X-Received: by 2002:adf:e406:0:b0:367:89b0:f584 with SMTP id
 ffacd0b85a97d-36bbbe41a5amr10941567f8f.11.1722956190536; 
 Tue, 06 Aug 2024 07:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNDOkrESu3JIcTRCLpzIkfYFQ0PveSez4G5RsxMBCn5JrfRQ0E1ZJKxzo3960b/TvlD38l3A==
X-Received: by 2002:adf:e406:0:b0:367:89b0:f584 with SMTP id
 ffacd0b85a97d-36bbbe41a5amr10941544f8f.11.1722956189943; 
 Tue, 06 Aug 2024 07:56:29 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01ee25sm13114422f8f.53.2024.08.06.07.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 07:56:29 -0700 (PDT)
Date: Tue, 6 Aug 2024 16:56:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Cleber Rosa <crosa@redhat.com>, John Snow
 <jsnow@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 7/7] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20240806165628.7ceffbe8@imammedo.users.ipa.redhat.com>
In-Reply-To: <0654a89fe24f4343016b9cecc0752594ad1cd49f.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <0654a89fe24f4343016b9cecc0752594ad1cd49f.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri,  2 Aug 2024 23:44:02 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Using the QMP GHESv2 API requires preparing a raw data array
> containing a CPER record.
> 
> Add a helper script with subcommands to prepare such data.
> 
> Currently, only ARM Processor error CPER record is supported.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS                    |   3 +
>  scripts/arm_processor_error.py | 352 +++++++++++++++++++++++++++++++++
>  scripts/ghes_inject.py         |  59 ++++++
>  scripts/qmp_helper.py          | 249 +++++++++++++++++++++++
>  4 files changed, 663 insertions(+)
>  create mode 100644 scripts/arm_processor_error.py
>  create mode 100755 scripts/ghes_inject.py
>  create mode 100644 scripts/qmp_helper.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 655edcb6688c..e490f69da1de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2081,6 +2081,9 @@ S: Maintained
>  F: hw/arm/ghes_cper.c
>  F: hw/acpi/ghes_cper_stub.c
>  F: qapi/ghes-cper.json
> +F: scripts/ghes_inject.py
> +F: scripts/arm_processor_error.py
> +F: scripts/qmp_helper.py
>  
>  ppc4xx
>  L: qemu-ppc@nongnu.org
> diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
> new file mode 100644
> index 000000000000..df4efa508790
> --- /dev/null
> +++ b/scripts/arm_processor_error.py
> @@ -0,0 +1,352 @@
> +#!/usr/bin/env python3
> +#
> +# pylint: disable=C0301, C0114, R0912, R0913, R0914, R0915, W0511
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +# TODO: current implementation has dummy defaults.
> +#
> +# For a better implementation, a QMP addition/call is needed to
> +# retrieve some data for ARM Processor Error injection:
> +#
> +#   - machine emulation architecture, as ARM current default is
> +#     for AArch64;
> +#   - ARM registers: power_state, midr, mpidr.

I'm not really reviewing the script but here some pointers how to fetch properties

start qemu with QMP connection
  ./qemu-system-aarch64 -M virt -qmp unix:/tmp/s,server,nowait
use script
  ./scripts/qmp/qom-get --socket /tmp/s /machine/unattached/device[0].midr

you can use ./scripts/qmp/qom-tree to explore what's there

see commit e61cc6b5c69 how to add property (DEFINE_PROP_UINT32 part mainly),
as long as it's prefixed with "x-" (meaning internal/unstable) likelihood is
that no one would object adding extra ones

> +
> +import argparse
> +import json
> +
> +from qmp_helper import (qmp_command, get_choice, get_mult_array,
> +                        get_mult_choices, get_mult_int, bit,
> +                        data_add, to_guid)
> +
> +# Arm processor EINJ logic
> +#
> +ACPI_GHES_ARM_CPER_LENGTH = 40
> +ACPI_GHES_ARM_CPER_PEI_LENGTH = 32
> +
> +# TODO: query it from emulation. Current default valid only for Aarch64
> +CONTEXT_AARCH64_EL1 = 5
> +
> +class ArmProcessorEinj:
> +    """
> +    Implements ARM Processor Error injection via GHES
> +    """
> +
> +    def __init__(self):
> +        """Initialize the error injection class"""
> +
> +        # Valid choice values
> +        self.arm_valid_bits = {
> +            "mpidr":    bit(0),
> +            "affinity": bit(1),
> +            "running":  bit(2),
> +            "vendor":   bit(3),
> +        }
> +
> +        self.pei_flags = {
> +            "first":        bit(0),
> +            "last":         bit(1),
> +            "propagated":   bit(2),
> +            "overflow":     bit(3),
> +        }
> +
> +        self.pei_error_types = {
> +            "cache":        bit(1),
> +            "tlb":          bit(2),
> +            "bus":          bit(3),
> +            "micro-arch":   bit(4),
> +        }
> +
> +        self.pei_valid_bits = {
> +            "multiple-error":   bit(0),
> +            "flags":            bit(1),
> +            "error-info":       bit(2),
> +            "virt-addr":        bit(3),
> +            "phy-addr":         bit(4),
> +        }
> +
> +        self.data = bytearray()
> +
> +    def create_subparser(self, subparsers):
> +        """Add a subparser to handle for the error fields"""
> +
> +        parser = subparsers.add_parser("arm",
> +                                       help="Generate an ARM processor CPER")
> +
> +        arm_valid_bits = ",".join(self.arm_valid_bits.keys())
> +        flags = ",".join(self.pei_flags.keys())
> +        error_types = ",".join(self.pei_error_types.keys())
> +        pei_valid_bits = ",".join(self.arm_valid_bits.keys())
> +
> +        # UEFI N.16 ARM Validation bits
> +        g_arm = parser.add_argument_group("ARM processor")
> +        g_arm.add_argument("--arm", "--arm-valid",
> +                           help=f"ARM valid bits: {arm_valid_bits}")
> +        g_arm.add_argument("-a", "--affinity",  "--level", "--affinity-level",
> +                           type=lambda x: int(x, 0),
> +                           help="Affinity level (when multiple levels apply)")
> +        g_arm.add_argument("-l", "--mpidr", type=lambda x: int(x, 0),
> +                           help="Multiprocessor Affinity Register")
> +        g_arm.add_argument("-i", "--midr", type=lambda x: int(x, 0),
> +                           help="Main ID Register")
> +        g_arm.add_argument("-r", "--running",
> +                           action=argparse.BooleanOptionalAction,
> +                           default=None,
> +                           help="Indicates if the processor is running or not")
> +        g_arm.add_argument("--psci", "--psci-state",
> +                           type=lambda x: int(x, 0),
> +                           help="Power State Coordination Interface - PSCI state")
> +
> +        # TODO: Add vendor-specific support
> +
> +        # UEFI N.17 bitmaps (type and flags)
> +        g_pei = parser.add_argument_group("ARM Processor Error Info (PEI)")
> +        g_pei.add_argument("-t", "--type", nargs="+",
> +                        help=f"one or more error types: {error_types}")
> +        g_pei.add_argument("-f", "--flags", nargs="*",
> +                        help=f"zero or more error flags: {flags}")
> +        g_pei.add_argument("-V", "--pei-valid", "--error-valid", nargs="*",
> +                        help=f"zero or more PEI valid bits: {pei_valid_bits}")
> +
> +        # UEFI N.17 Integer values
> +        g_pei.add_argument("-m", "--multiple-error", nargs="+",
> +                        help="Number of errors: 0: Single error, 1: Multiple errors, 2-65535: Error count if known")
> +        g_pei.add_argument("-e", "--error-info", nargs="+",
> +                        help="Error information (UEFI 2.10 tables N.18 to N.20)")
> +        g_pei.add_argument("-p", "--physical-address",  nargs="+",
> +                        help="Physical address")
> +        g_pei.add_argument("-v", "--virtual-address",  nargs="+",
> +                        help="Virtual address")
> +
> +        # UEFI N.21 Context
> +        g_ctx = parser.add_argument_group("Processor Context")
> +        g_ctx.add_argument("--ctx-type", "--context-type", nargs="*",
> +                        help="Type of the context (0=ARM32 GPR, 5=ARM64 EL1, other values supported)")
> +        g_ctx.add_argument("--ctx-size", "--context-size", nargs="*",
> +                        help="Minimal size of the context")
> +        g_ctx.add_argument("--ctx-array", "--context-array", nargs="*",
> +                        help="Comma-separated arrays for each context")
> +
> +        # Vendor-specific data
> +        g_vendor = parser.add_argument_group("Vendor-specific data")
> +        g_vendor.add_argument("--vendor", "--vendor-specific", nargs="+",
> +                        help="Vendor-specific byte arrays of data")
> +
> +    def parse_args(self, args):
> +        """Parse subcommand arguments"""
> +
> +        cper = {}
> +        pei = {}
> +        ctx = {}
> +        vendor = {}
> +
> +        arg = vars(args)
> +
> +        # Handle global parameters
> +        if args.arm:
> +            arm_valid_init = False
> +            cper["valid"] = get_choice(name="valid",
> +                                       value=args.arm,
> +                                       choices=self.arm_valid_bits,
> +                                       suffixes=["-error", "-err"])
> +        else:
> +            cper["valid"] = 0
> +            arm_valid_init = True
> +
> +        if "running" in arg:
> +            if args.running:
> +                cper["running-state"] = bit(0)
> +            else:
> +                cper["running-state"] = 0
> +        else:
> +            cper["running-state"] = 0
> +
> +        if arm_valid_init:
> +            if args.affinity:
> +                cper["valid"] |= self.arm_valid_bits["affinity"]
> +
> +            if args.mpidr:
> +                cper["valid"] |= self.arm_valid_bits["mpidr"]
> +
> +            if "running-state" in cper:
> +                cper["valid"] |= self.arm_valid_bits["running"]
> +
> +            if args.psci:
> +                cper["valid"] |= self.arm_valid_bits["running"]
> +
> +        # Handle PEI
> +        if not args.type:
> +            args.type = ["cache-error"]
> +
> +        get_mult_choices(
> +            pei,
> +            name="valid",
> +            values=args.pei_valid,
> +            choices=self.pei_valid_bits,
> +            suffixes=["-valid", "-info", "--information", "--addr"],
> +        )
> +        get_mult_choices(
> +            pei,
> +            name="type",
> +            values=args.type,
> +            choices=self.pei_error_types,
> +            suffixes=["-error", "-err"],
> +        )
> +        get_mult_choices(
> +            pei,
> +            name="flags",
> +            values=args.flags,
> +            choices=self.pei_flags,
> +            suffixes=["-error", "-cap"],
> +        )
> +        get_mult_int(pei, "error-info", args.error_info)
> +        get_mult_int(pei, "multiple-error", args.multiple_error)
> +        get_mult_int(pei, "phy-addr", args.physical_address)
> +        get_mult_int(pei, "virt-addr", args.virtual_address)
> +
> +        # Handle context
> +        get_mult_int(ctx, "type", args.ctx_type, allow_zero=True)
> +        get_mult_int(ctx, "minimal-size", args.ctx_size, allow_zero=True)
> +        get_mult_array(ctx, "register", args.ctx_array, allow_zero=True)
> +
> +        get_mult_array(vendor, "bytes", args.vendor, max_val=255)
> +
> +        # Store PEI
> +        pei_data = bytearray()
> +        default_flags  = self.pei_flags["first"]
> +        default_flags |= self.pei_flags["last"]
> +
> +        error_info_num = 0
> +
> +        for i, p in pei.items():        # pylint: disable=W0612
> +            error_info_num += 1
> +
> +            # UEFI 2.10 doesn't define how to encode error information
> +            # when multiple types are raised. So, provide a default only
> +            # if a single type is there
> +            if "error-info" not in p:
> +                if p["type"] == bit(1):
> +                    p["error-info"] = 0x0091000F
> +                if p["type"] == bit(2):
> +                    p["error-info"] = 0x0054007F
> +                if p["type"] == bit(3):
> +                    p["error-info"] = 0x80D6460FFF
> +                if p["type"] == bit(4):
> +                    p["error-info"] = 0x78DA03FF
> +
> +            if "valid" not in p:
> +                p["valid"] = 0
> +                if "multiple-error" in p:
> +                    p["valid"] |= self.pei_valid_bits["multiple-error"]
> +
> +                if "flags" in p:
> +                    p["valid"] |= self.pei_valid_bits["flags"]
> +
> +                if "error-info" in p:
> +                    p["valid"] |= self.pei_valid_bits["error-info"]
> +
> +                if "phy-addr" in p:
> +                    p["valid"] |= self.pei_valid_bits["phy-addr"]
> +
> +                if "virt-addr" in p:
> +                    p["valid"] |= self.pei_valid_bits["virt-addr"]
> +
> +            # Version
> +            data_add(pei_data, 0, 1)
> +
> +            data_add(pei_data, ACPI_GHES_ARM_CPER_PEI_LENGTH, 1)
> +
> +            data_add(pei_data, p["valid"], 2)
> +            data_add(pei_data, p["type"], 1)
> +            data_add(pei_data, p.get("multiple-error", 1), 2)
> +            data_add(pei_data, p.get("flags", default_flags), 1)
> +            data_add(pei_data, p.get("error-info", 0), 8)
> +            data_add(pei_data, p.get("virt-addr", 0xDEADBEEF), 8)
> +            data_add(pei_data, p.get("phy-addr", 0xABBA0BAD), 8)
> +
> +        # Store Context
> +        ctx_data = bytearray()
> +        context_info_num = 0
> +
> +        if ctx:
> +            for k in sorted(ctx.keys()):
> +                context_info_num += 1
> +
> +                if "type" not in ctx:
> +                    ctx[k]["type"] = CONTEXT_AARCH64_EL1
> +
> +                if "register" not in ctx:
> +                    ctx[k]["register"] = []
> +
> +                reg_size = len(ctx[k]["register"])
> +                size = 0
> +
> +                if "minimal-size" in ctx:
> +                    size = ctx[k]["minimal-size"]
> +
> +                size = max(size, reg_size)
> +
> +                size = (size + 1) % 0xFFFE
> +
> +                # Version
> +                data_add(ctx_data, 0, 2)
> +
> +                data_add(ctx_data, ctx[k]["type"], 2)
> +
> +                data_add(ctx_data, 8 * size, 4)
> +
> +                for r in ctx[k]["register"]:
> +                    data_add(ctx_data, r, 8)
> +
> +                for i in range(reg_size, size):   # pylint: disable=W0612
> +                    data_add(ctx_data, 0, 8)
> +
> +        # Vendor-specific bytes are not grouped
> +        vendor_data = bytearray()
> +        if vendor:
> +            for k in sorted(vendor.keys()):
> +                for b in vendor[k]["bytes"]:
> +                    data_add(vendor_data, b, 1)
> +
> +        # Encode ARM Processor Error
> +        data = bytearray()
> +
> +        data_add(data, cper["valid"], 4)
> +
> +        data_add(data, error_info_num, 2)
> +        data_add(data, context_info_num, 2)
> +
> +        # Calculate the length of the CPER data
> +        cper_length = ACPI_GHES_ARM_CPER_LENGTH
> +        cper_length += len(pei_data)
> +        cper_length += len(vendor_data)
> +        cper_length += len(ctx_data)
> +        data_add(data, cper_length, 4)
> +
> +        data_add(data, arg.get("affinity-level", 0), 1)
> +
> +        # Reserved
> +        data_add(data, 0, 3)
> +
> +        data_add(data, arg.get("mpidr-el1", 0), 8)
> +        data_add(data, arg.get("midr-el1", 0), 8)
> +        data_add(data, cper["running-state"], 4)
> +        data_add(data, arg.get("psci-state", 0), 4)
> +
> +        # Add PEI
> +        data.extend(pei_data)
> +        data.extend(ctx_data)
> +        data.extend(vendor_data)
> +
> +        self.data = data
> +
> +    def run(self, host, port):
> +        """Execute QMP commands"""
> +
> +        guid = to_guid(0xE19E3D16, 0xBC11, 0x11E4,
> +                       [0x9C, 0xAA, 0xC2, 0x05,
> +                        0x1D, 0x5D, 0x46, 0xB0])
> +
> +        qmp_command(host, port, guid, self.data)
> diff --git a/scripts/ghes_inject.py b/scripts/ghes_inject.py
> new file mode 100755
> index 000000000000..8415ccbbc53d
> --- /dev/null
> +++ b/scripts/ghes_inject.py
> @@ -0,0 +1,59 @@
> +#!/usr/bin/env python3
> +#
> +# pylint: disable=C0301, C0114
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +import argparse
> +
> +from arm_processor_error import ArmProcessorEinj
> +
> +EINJ_DESCRIPTION = """
> +Handle ACPI GHESv2 error injection logic QEMU QMP interface.\n
> +
> +It allows using UEFI BIOS EINJ features to generate GHES records.
> +
> +It helps testing Linux CPER and GHES drivers and to test rasdaemon
> +error handling logic.
> +
> +Currently, it support ARM processor error injection for ARM processor
> +events, being compatible with UEFI 2.9A Errata.
> +
> +This small utility works together with those QEMU additions:
> +- https://gitlab.com/mchehab_kernel/qemu/-/tree/arm-error-inject-v2
> +"""
> +
> +def main():
> +    """Main program"""
> +
> +    # Main parser - handle generic args like QEMU QMP TCP socket options
> +    parser = argparse.ArgumentParser(prog="einj.py",
> +                                     formatter_class=argparse.RawDescriptionHelpFormatter,
> +                                     usage="%(prog)s [options]",
> +                                     description=EINJ_DESCRIPTION,
> +                                     epilog="If a field is not defined, a default value will be applied by QEMU.")
> +
> +    g_options = parser.add_argument_group("QEMU QMP socket options")
> +    g_options.add_argument("-H", "--host", default="localhost", type=str,
> +                           help="host name")
> +    g_options.add_argument("-P", "--port", default=4445, type=int,
> +                           help="TCP port number")
> +
> +    arm_einj = ArmProcessorEinj()
> +
> +    # Call subparsers
> +    subparsers = parser.add_subparsers(dest='command')
> +
> +    arm_einj.create_subparser(subparsers)
> +
> +    args = parser.parse_args()
> +
> +    # Handle subparser commands
> +    if args.command == "arm":
> +        arm_einj.parse_args(args)
> +        arm_einj.run(args.host, args.port)
> +
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
> new file mode 100644
> index 000000000000..13fae7a7af0e
> --- /dev/null
> +++ b/scripts/qmp_helper.py
> @@ -0,0 +1,249 @@
> +#!/usr/bin/env python3
> +#
> +# pylint: disable=C0301, C0114, R0912, R0913, R0915, W0511
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +import json
> +import socket
> +import sys
> +
> +from base64 import b64encode
> +
> +#
> +# Socket QMP send command
> +#
> +def qmp_command(host, port, guid, data):
> +    """Send commands to QEMU though QMP TCP socket"""
> +
> +    # Fill the commands to be sent
> +    commands = []
> +
> +    # Needed to negotiate QMP and for QEMU to accept the command
> +    commands.append('{ "execute": "qmp_capabilities" } ')
> +
> +    base64_data = b64encode(bytes(data)).decode('ascii')
> +
> +    cmd_arg = {
> +        'cper': {
> +            'notification-type': guid,
> +            "raw-data": base64_data
> +        }
> +    }
> +
> +    command = '{ "execute": "ghes-cper", '
> +    command += '"arguments": ' + json.dumps(cmd_arg) + " }"
> +
> +    commands.append(command)
> +
> +    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
> +    try:
> +        s.connect((host, port))
> +    except ConnectionRefusedError:
> +        sys.exit(f"Can't connect to QMP host {host}:{port}")
> +
> +    data = s.recv(1024)
> +    try:
> +        obj = json.loads(data.decode("utf-8"))
> +    except json.JSONDecodeError as e:
> +        print(f"Invalid QMP answer: {e}")
> +        s.close()
> +        return
> +
> +    if "QMP" not in obj:
> +        print(f"Invalid QMP answer: {data.decode("utf-8")}")
> +        s.close()
> +        return
> +
> +    for i, command in enumerate(commands):
> +        s.sendall(command.encode("utf-8"))
> +        data = s.recv(1024)
> +        try:
> +            obj = json.loads(data.decode("utf-8"))
> +        except json.JSONDecodeError as e:
> +            print(f"Invalid QMP answer: {e}")
> +            s.close()
> +            return
> +
> +        if isinstance(obj.get("return"), dict):
> +            if obj["return"]:
> +                print(json.dumps(obj["return"]))
> +            elif i > 0:
> +                print("Error injected.")
> +        elif isinstance(obj.get("error"), dict):
> +            error = obj["error"]
> +            print(f'{error["class"]}: {error["desc"]}')
> +        else:
> +            print(json.dumps(obj))
> +
> +    s.shutdown(socket.SHUT_WR)
> +    while 1:
> +        data = s.recv(1024)
> +        if data == b"":
> +            break
> +        try:
> +            obj = json.loads(data.decode("utf-8"))
> +        except json.JSONDecodeError as e:
> +            print(f"Invalid QMP answer: {e}")
> +            s.close()
> +            return
> +
> +        if isinstance(obj.get("return"), dict):
> +            print(json.dumps(obj["return"]))
> +        if isinstance(obj.get("error"), dict):
> +            error = obj["error"]
> +            print(f'{error["class"]}: {error["desc"]}')
> +        else:
> +            print(json.dumps(obj))
> +
> +    s.close()
> +
> +
> +#
> +# Helper routines to handle multiple choice arguments
> +#
> +def get_choice(name, value, choices, suffixes=None):
> +    """Produce a list from multiple choice argument"""
> +
> +    new_values = 0
> +
> +    if not value:
> +        return new_values
> +
> +    for val in value.split(","):
> +        val = val.lower()
> +
> +        if suffixes:
> +            for suffix in suffixes:
> +                val = val.removesuffix(suffix)
> +
> +        if val not in choices.keys():
> +            sys.exit(f"Error on '{name}': choice {val} is invalid.")
> +
> +        val = choices[val]
> +
> +        new_values |= val
> +
> +    return new_values
> +
> +
> +def get_mult_array(mult, name, values, allow_zero=False, max_val=None):
> +    """Add numbered hashes from integer lists"""
> +
> +    if not allow_zero:
> +        if not values:
> +            return
> +    else:
> +        if values is None:
> +            return
> +
> +        if not values:
> +            i = 0
> +            if i not in mult:
> +                mult[i] = {}
> +
> +            mult[i][name] = []
> +            return
> +
> +    i = 0
> +    for value in values:
> +        for val in value.split(","):
> +            try:
> +                val = int(val, 0)
> +            except ValueError:
> +                sys.exit(f"Error on '{name}': {val} is not an integer")
> +
> +            if val < 0:
> +                sys.exit(f"Error on '{name}': {val} is not unsigned")
> +
> +            if max_val and val > max_val:
> +                sys.exit(f"Error on '{name}': {val} is too little")
> +
> +            if i not in mult:
> +                mult[i] = {}
> +
> +            if name not in mult[i]:
> +                mult[i][name] = []
> +
> +            mult[i][name].append(val)
> +
> +        i += 1
> +
> +
> +def get_mult_choices(mult, name, values, choices,
> +                     suffixes=None, allow_zero=False):
> +    """Add numbered hashes from multiple choice arguments"""
> +
> +    if not allow_zero:
> +        if not values:
> +            return
> +    else:
> +        if values is None:
> +            return
> +
> +    i = 0
> +    for val in values:
> +        new_values = get_choice(name, val, choices, suffixes)
> +
> +        if i not in mult:
> +            mult[i] = {}
> +
> +        mult[i][name] = new_values
> +        i += 1
> +
> +
> +def get_mult_int(mult, name, values, allow_zero=False):
> +    """Add numbered hashes from integer arguments"""
> +    if not allow_zero:
> +        if not values:
> +            return
> +    else:
> +        if values is None:
> +            return
> +
> +    i = 0
> +    for val in values:
> +        try:
> +            val = int(val, 0)
> +        except ValueError:
> +            sys.exit(f"Error on '{name}': {val} is not an integer")
> +
> +        if val < 0:
> +            sys.exit(f"Error on '{name}': {val} is not unsigned")
> +
> +        if i not in mult:
> +            mult[i] = {}
> +
> +        mult[i][name] = val
> +        i += 1
> +
> +
> +#
> +# Data encode helper functions
> +#
> +def bit(b):
> +    """Simple macro to define a bit on a bitmask"""
> +    return 1 << b
> +
> +
> +def data_add(data, value, num_bytes):
> +    """Adds bytes from value inside a bitarray"""
> +
> +    data.extend(value.to_bytes(num_bytes, byteorder="little"))
> +
> +def to_guid(time_low, time_mid, time_high, nodes):
> +    """Create an GUID string"""
> +
> +    assert(len(nodes) == 8)
> +
> +    clock = nodes[0] << 8 | nodes[1]
> +
> +    node = 0
> +    for i in range(2, len(nodes)):
> +        node = node << 8 | nodes[i]
> +
> +    s = f"{time_low:08x}-{time_mid:04x}-"
> +    s += f"{time_high:04x}-{clock:04x}-{node:012x}"
> +
> +    return s


