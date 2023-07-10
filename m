Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A26E974D8EC
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrmv-0005JK-RQ; Mon, 10 Jul 2023 10:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qIrms-0005Io-8k
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qIrmq-0003dx-1l
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688998964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jK7RCIh7s5fID6L7BtZPgTLvpx/InRXfIbND1hq6Gqw=;
 b=MohfLQRpUQO0KBd5iDs42nHkLKuT81qB64+MoR60oXEtzGfNEdwNxWRVYzoxXFUB4/8lGx
 D/FXTMHSG1UvqSoApgKfA20KsIvW40h3NhsS1S7stw/UqBNcIH3RSPn2qoj4nABFPHMCGJ
 on7FdYo0NN6kxsQ+a6KfNm4WjfahiYU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ZVqk0D0PN5u4BD5gcM9avQ-1; Mon, 10 Jul 2023 10:22:42 -0400
X-MC-Unique: ZVqk0D0PN5u4BD5gcM9avQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fbcdca8fb6so3488449e87.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 07:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688998961; x=1691590961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jK7RCIh7s5fID6L7BtZPgTLvpx/InRXfIbND1hq6Gqw=;
 b=ZMz9nl7pJX3kNTIUXJuTqaBUvG1yMO2DdyUcu+d9LPy0W8j3jr380N6P9iSvoif2Sz
 XLRFdAtRwBhRlwdVMWmO6JSfcmLPZQgrT6tpMXI15M760xctE97XTx3Ba71YYYspF4sB
 wP1i2f1ljuHR2WLp6tRy6uG115N+E4yVZNxZMNgGYOnHhZng2+lP2IdqFt/88526T6ez
 vz+OThzu8O83nEXSUP6adbaKoYSCaIWuYupbu64iY6clH/Zahlj+7KWmEyOOFcXweccY
 q2YvCqIu1nIDLaEPhapJod2JuDM3zmlH8ZobGjYNp84JwetSnYk0ZqT5IDQCRH7adk10
 nf2g==
X-Gm-Message-State: ABy/qLYY6wj47cShpbr4oUCW7B8L+AXid0BtwwICo7NLKD1Rj9eh2Tmm
 25eQ2EFj76oDLcLuYiS79X1xCJiNq7nr5mkgTgYAefgs6iloiu8sKSpF4P/bqF4YW36VR0WQbus
 KFlf8WJuZBU28eQY=
X-Received: by 2002:a05:6512:2315:b0:4f8:5cde:a44f with SMTP id
 o21-20020a056512231500b004f85cdea44fmr12559655lfu.10.1688998961190; 
 Mon, 10 Jul 2023 07:22:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGWSrl7r5GIzRf61tPv15RTJDm4Fu9OumLZt6f6UAIfek4z/0fml/O/WWsSUAszwoyGVVo2MQ==
X-Received: by 2002:a05:6512:2315:b0:4f8:5cde:a44f with SMTP id
 o21-20020a056512231500b004f85cdea44fmr12559627lfu.10.1688998960832; 
 Mon, 10 Jul 2023 07:22:40 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 r16-20020a170906c29000b00991d54db2acsm6203406ejz.44.2023.07.10.07.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 07:22:40 -0700 (PDT)
Date: Mon, 10 Jul 2023 16:22:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@linaro.org>, qemu-devel@nongnu.org, Zhenyu Wang
 <zhenyu.z.wang@intel.com>, Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 0/4] hw/smbios: Cleanup topology related variables
Message-ID: <20230710162239.7b0105f6@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230628135437.1145805-1-zhao1.liu@linux.intel.com>
References: <20230628135437.1145805-1-zhao1.liu@linux.intel.com>
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

On Wed, 28 Jun 2023 21:54:33 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi all,
> 
> This is my v4 patch series based on b111569da9f8 ("Merge tag 'ui-pull-
> request' of https://gitlab.com/marcandre.lureau/qemu into staging").
> 
> This v4 is a quick refresh to address Igor's comment in v3 [1] about the
> location of the new two helpers.
> 
> About the 2 newly added helpers, they can also be used in i386 code [2].
> I will follow up to do the cleanup after another i386 cluster support
> patch series.
> 
> 
> Introduction
> ============
> 
> This patchset is split from my previous hybrid topology RFC [3].
> 
> This patchset adds 2 new helpers to wrap the threads/cores per sockets
> calculation to avoid errors caused by other modules miss topology
> changes.
> 
> Additionally, there are three places for topology-related cleanup in
> smbios:
> 
> 1. Fix the calculation of the number of sockets.
> 
>    Due to the misuse of the smp.cpus variable and the change in the
>    meaning of smp.cores, the calculation of socket number in smbios is
>    incorrect. This can be fixed by using smp.sockets directly.
> 
> 2. Fix core count in type4.
> 
>    The meaning of smp.cores changed so that the calculation of cores
>    per socket became wrong.
> 
>    v3 introduces the helper "machine_topo_get_cores_per_socket()" to
>    wrap the calculation of cores per socket. This can help other modules
>    avoid calculation error caused by missing topology changes.
> 
> 3. Fix thread count in type4.
> 
>    I also found that the definition of thread count in type4 doesn't
>    match the spec (smbios 3.0.0) and cleaned it up as well.
> 
>    Similar to core count, also use a new helper to fix this.
> 
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05402.html
> [2]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06071.html
> [3]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03205.html
>

For series:

Acked-by: Igor Mammedov <imammedo@redhat.com>

> 
> Regards,
> Zhao
> ---
> Zhao Liu (4):
>   machine: Add helpers to get cores/threads per socket
>   hw/smbios: Fix smbios_smp_sockets caculation
>   hw/smbios: Fix thread count in type4
>   hw/smbios: Fix core count in type4
> 
>  hw/core/machine-smp.c | 10 ++++++++++
>  hw/smbios/smbios.c    | 16 ++++++++++------
>  include/hw/boards.h   |  2 ++
>  3 files changed, 22 insertions(+), 6 deletions(-)
> 


