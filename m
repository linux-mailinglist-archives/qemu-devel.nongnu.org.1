Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9C7DFE56
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 04:22:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qykkx-0001kd-F5; Thu, 02 Nov 2023 23:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qykkv-0001iC-4a
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:21:57 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qykkt-0005tE-BV
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:21:56 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-694ed847889so1657910b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 20:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698981714; x=1699586514; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MRWkzNV15sMQ1OThxzZvfTQZK66YIKvjAWMAHks9Xmg=;
 b=FPe9qHj8wJhQBaTElihGdU1ZzDPYc92vg5vdr8Vv6FbDBaYztfj7jWvM7Gyn6Cp0wc
 18v4ciMV1p/Y1IAsMBSu6uIljriw5/VUiYCvpDkFbfnPvHb4OyqcaSgIVVt80tk2/vHN
 JXi6XdZVG3CT2s+bpkS6Rl1H1D8O+yh9JkWEr5UIIe/oMiaHP7zeqAi8ztCac6hyEErr
 lD4qn+3b4INvzd8l57/r8Y9FK2Idc16BWqWve7XgI+9Z5qH6snNKapOO6IEdhHlsNNPl
 4Sc2Lykr5ErPIZcIQmAmMmBS1yJL3XZAadUbtSMTvrnbG+mx3Y1VCXjFxV4MQOfJ+2wR
 5TwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698981714; x=1699586514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRWkzNV15sMQ1OThxzZvfTQZK66YIKvjAWMAHks9Xmg=;
 b=ZOuCbxQAYlf+NOK2Vd4rTlmOnTNiukeXeTUj4sT4zCU2Yezcw1D8g2Jz2p/73ZEHm4
 1TKn70z7wpT6sA7sY7CpxQ4ewtS2t9kT676sW065fiMsEWj9GVat4rAD/0pd0qcEcYtM
 FEGukKrSX6iEqRN2ro4OGEvlM9pJBQ5rpkyY9Bdh5HEzhWVnXElBdkaINSdXOhlMm635
 cfZsh9tJ6OqLDDHvoUxpKGU5p9VwF/YkKbEaztf5EdWMOGuWmdFU/ye547uDqjfNECB+
 jTJyUEIaSQ0yQp2JjdsCiSgYv8R8A9kAC663ZbzS9rw8P5Q3HQ3GizSEgux2K+XP0ywD
 XUvA==
X-Gm-Message-State: AOJu0YyJiQAh6ujrM3Pp195tIstQ6EJnRe4bD1l/5TjjjhYfnZxxCRuZ
 Gxvkpotc4tZndq1zEk4NN+/NYA==
X-Google-Smtp-Source: AGHT+IF3IA226jM3vDkUWkqqi0G2hQvEOOBNSV4qGYVtwZS3eKCSL/om09dUeXQwULdnGdHK5IscYQ==
X-Received: by 2002:a05:6a20:3c88:b0:181:7e88:56f7 with SMTP id
 b8-20020a056a203c8800b001817e8856f7mr4765956pzj.18.1698981714002; 
 Thu, 02 Nov 2023 20:21:54 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78]) by smtp.gmail.com with ESMTPSA id
 l8-20020a170902f68800b001b890009634sm380108plg.139.2023.11.02.20.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 20:21:53 -0700 (PDT)
Date: Fri, 3 Nov 2023 08:51:42 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [PATCH v6 00/13] RISC-V: ACPI: Enable AIA, PLIC and update RHCT
Message-ID: <ZURnRrsG13pMJYLi@sunil-laptop>
References: <20231102170223.2619260-1-sunilvl@ventanamicro.com>
 <64055d84-7a8f-4fc5-85db-dcaa7a36e120@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64055d84-7a8f-4fc5-85db-dcaa7a36e120@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Nov 02, 2023 at 06:00:22PM -0300, Daniel Henrique Barboza wrote:
> Sunil,
> 
> 
> While doing unrelated work (running Gitlab on my series built on top of
> current riscv-to-apply.next), I hit the following error:
> 
> https://gitlab.com/danielhb/qemu/-/jobs/5448178994
> 
> ==========
> 
> 4/257 ERROR:../tests/qtest/bios-tables-test.c:535:test_acpi_asl: assertion failed: (all_tables_match) ERROR
>   4/257 qemu:qtest+qtest-i386 / qtest-i386/bios-tables-test                ERROR           7.77s   killed by signal 6 SIGABRT
> > > > G_TEST_DBUS_DAEMON=/builds/danielhb/qemu/tests/dbus-vmstate-daemon.sh PYTHON=/builds/danielhb/qemu/build/pyvenv/bin/python3 MALLOC_PERTURB_=159 QTEST_QEMU_BINARY=./qemu-system-i386 /builds/danielhb/qemu/build/tests/qtest/bios-tables-test --tap -k
> 
> acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-IOYVD2], Expected [aml:tests/data/acpi/microvm/DSDT].
> See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
> to see ASL diff between mismatched files install IASL, rebuild QEMU from scratch and re-run tests with V=1 environment variable set**
> ERROR:../tests/qtest/bios-tables-test.c:535:test_acpi_asl: assertion failed: (all_tables_match)
> (test program exited with status code -6)
> 
> (...)
> 
> Summary of Failures:
> 4571  4/257 qemu:qtest+qtest-i386 / qtest-i386/bios-tables-test                ERROR           7.77s   killed by signal 6 SIGABRT
> 4572  7/257 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test          ERROR          66.00s   killed by signal 6 SIGABRT
> 4573  Ok:                 247
> 4574  Expected Fail:      0
> 4575  Fail:               2
> 4576  Unexpected Pass:    0
> 4577  Skipped:            8
> 4578  Timeout:            0
> 
> ==========
> 
Thanks! Daniel. I sent v7 with this issue fixed. With v7, here is the
qtest report I got.

$ make check-qtest-i386 V=1
...
Ok:                 60  
Expected Fail:      0   
Fail:               0   
Unexpected Pass:    0   
Skipped:            3   
Timeout:            0

$ make check-qtest-aarch64 V=1
...
Ok:                 20  
Expected Fail:      0   
Fail:               0   
Unexpected Pass:    0   
Skipped:            2   
Timeout:            0

$ make check
...
Ok:                 765
Expected Fail:      0   
Fail:               0   
Unexpected Pass:    0   
Skipped:            71  
Timeout:            0

While I don't see any failures now, there are some tests skipped which
look expected. Let me know if I need to run any other tests.

Thanks!
Sunil

