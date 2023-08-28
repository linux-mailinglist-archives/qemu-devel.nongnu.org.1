Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 299A978B267
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 15:59:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaclS-0006iP-DO; Mon, 28 Aug 2023 09:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qaclP-0006i9-Rx
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 09:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qaclN-00050c-AZ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 09:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693231115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJdC36BRaylLOW71RKXrMymYWvs/dDFUOUvEIPTeyjE=;
 b=TKmv86XNByZHvHut+9Qo7Mg2gUxrhHdlmGPybNqoCKr1U4X8Pdmdp2Pnid3OOwA/npihGp
 SkSvvQlnY//Iv5uha/eiDdLh5UVQXUy/srKAJqNyNlJl0cXL4lr8H9upJ6hKWQb06Nn8WT
 gmZZuczTTU/FFApv92AR3laPhR21SQ8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-bc9lyfjYOPqkyNNTw_KC0g-1; Mon, 28 Aug 2023 09:58:33 -0400
X-MC-Unique: bc9lyfjYOPqkyNNTw_KC0g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso270942166b.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 06:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693231110; x=1693835910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJdC36BRaylLOW71RKXrMymYWvs/dDFUOUvEIPTeyjE=;
 b=EUzBKMYWTALFV+kdN4JEogkwkH7zSOb0bHmlZ1alGJJaxSDqkR3D9qn515uP3tpV/g
 HNXbMkfmK0xUbt2A7pfagISdwSbhGUN6dQMv+gXs8Ev+41rEl9eP21mtZuiYZH9Ufy8C
 ht/Kx+Yq06gE8geirrYn+u9iQhcDDU9u+EEKL++nhLYOmIuT34Vgqrx5uuthX3gEUZe4
 540NEg9/aIapr6QjvTfVy+lVb/4bEVKvW4oIi/6MyHqj/O7qPvdMbTwUWVLAuzJXC3Y+
 Q2CgJaQ3k8nhTMtSw1IZ4a0v9Jc2qHnP2cOR3Absi3R/JOy/mDRGKOfv6VC+qnIcIlag
 8kRw==
X-Gm-Message-State: AOJu0YyzbT8HSW5dKzcCO2XTADSrh+309rikgL0xEIEfNlhdPIZhev/E
 XaLEJOO7M1tv1DC0JRuU6YDYaTYsaQeZvIgiKN00v3YxLaVjMF7LAD+2Dk0dR75EMbT/L/p6ir/
 rdQ+kr206PqgZpUc=
X-Received: by 2002:a17:906:8a5a:b0:9a1:f415:7c24 with SMTP id
 gx26-20020a1709068a5a00b009a1f4157c24mr9935973ejc.46.1693231110034; 
 Mon, 28 Aug 2023 06:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaGAwj7bDejyTCtQnRZyyi0WnohApTphmKTbG+wHRE8WwGwKIty3QKI9tDH4/G6wxTsOEFbg==
X-Received: by 2002:a17:906:8a5a:b0:9a1:f415:7c24 with SMTP id
 gx26-20020a1709068a5a00b009a1f4157c24mr9935952ejc.46.1693231109760; 
 Mon, 28 Aug 2023 06:58:29 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ck17-20020a170906c45100b009a1a5a7ebacsm4651872ejb.201.2023.08.28.06.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 06:58:29 -0700 (PDT)
Date: Mon, 28 Aug 2023 15:58:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, pbonzini@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org, laurent@vivier.eu,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, qemu-riscv@nongnu.org,
 Jiri Denemark <jdenemar@redhat.com>, Tim Wiederhake <twiederh@redhat.com>
Subject: Re: [RFC PATCH v2 0/6] Add API for list cpu extensions
Message-ID: <20230828155828.561dc83e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230828084536.231-1-zhiwei_liu@linux.alibaba.com>
References: <20230828084536.231-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 28 Aug 2023 16:45:30 +0800
LIU Zhiwei <zhiwei_liu@linux.alibaba.com> wrote:

> Some times we want to know what is the really mean of one cpu option.
> For example, in RISC-V, we usually specify a cpu in this way:
> -cpu rv64,v=on
> 
> If we don't look into the source code, we can't get the ISA extensions
> of this -cpu command line.
> 
> In this patch set, we add one list_cpu_props API for common cores. It
> will output the enabled ISA extensions.
> 
> In the near future, I will also list all possible user configurable
> options and all possible extensions for this cpu.
> 
> In order to reuse the options parse code, I also add a QemuOptsList
> for cpu.
> 
> After this patch, we can output the extensions for cpu,
> """
> ./qemu-system-riscv64 -cpu rv64,help
> Enabled extensions:
>     rv64imafdch_zicbom_zicboz_zicsr_zifencei_zihintpause_zawrs_zfa_zba_zbb_zbc_zbs_sstc_svadu

It's not that easy to get features with values in general.
(many factors influence defaults, which may include:
 * properties set and/or added at realize time
 * defaults amended by machine type version
 * defaults amended by -global CLI options
)

To do that consensus was to query features after CPU object is realized.
Typically that implies starting dummy QEMU with needed CPU model and
then using query-cpu-model-expansion command to get actual property values.
 
The task is solved by implementing query-cpu-model-expansion
command so that user (mainly management layer) could get defaults via QMP.
So if your goal is to get the given cpu defaults to mgmt layer
it is sufficient to implement query-cpu-model-expansion command for riscv.
(CC-ing libvirt folks to see if it picks up the command
automatically for every target or some more work would be needed
on their side as well)

PS:
no one cared about making -cpu name,help working till this moment
and certainly not for linux-user part.

To make this option work reliably it's would be necessary to make sure
that query-cpu-model-expansion work in user mode as well.

Also the timing when 'help' is processed should ensure that
machine is available/initialized (i.e. compat properties are in effect) 

Once you have working query-cpu-model-expansion, your new -cpu foo,help handler
can translate json to human readable format that everyone would agree upon.

> To get all configuable options for this cpu, use -device rv64-riscv-cpu,help
> """
> 
> 
> v1->v2:
> 
> 1) Give a hint to use -device cpu,help for configualbe options on cpu
> 2) Support list_cpu_props for linux user mode
> 3) Add default to some properties to make -device cpu,help output better
> 
> 
> Todo:
> 1) Fix Daniel comments on KVM and cpu option check
> 2) Add support for other archs
> 3) Move qdev help function from qdev-monitor to qdev-property
> 
> LIU Zhiwei (6):
>   cpu: Add new API cpu_type_by_name
>   target/riscv: Add API list_cpu_props
>   softmmu/vl: Add qemu_cpu_opts QemuOptsList
>   target/riscv: Add default value for misa property
>   target/riscv: Add defalut value for string property
>   linux-user: Move qemu_cpu_opts to cpu.c
> 
>  cpu.c                        | 63 +++++++++++++++++++++++++++++-------
>  hw/core/qdev-prop-internal.h |  2 ++
>  hw/core/qdev-properties.c    |  7 ++++
>  include/exec/cpu-common.h    |  3 ++
>  include/hw/core/cpu.h        | 11 +++++++
>  include/hw/qdev-properties.h |  8 +++++
>  linux-user/main.c            | 10 ++++++
>  softmmu/vl.c                 | 11 +++++++
>  target/riscv/cpu.c           | 30 +++++++++++++----
>  target/riscv/cpu.h           |  2 ++
>  10 files changed, 128 insertions(+), 19 deletions(-)
> 


