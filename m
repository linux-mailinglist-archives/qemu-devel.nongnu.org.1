Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F27867A1EC7
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 14:33:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh7zC-0005t9-53; Fri, 15 Sep 2023 08:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh7z8-0005ry-PA
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh7z6-0003tX-RN
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694781103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yc8PAB3ZKpWa1ExYlvcWYD1/PhWhZ5t6A+MoKbko7Uc=;
 b=fazx8L9eyz/vAdU0Qp+EZhbgwebqvKx9p9h4hDbkAOW/JHYTl5NxSueu/J0n5DPXUKDhNp
 TTRChOpQwlM4vVXU8T/F0WnzMThYokVQBt5H6mxIpuqIePTDKG3YlFNMEJKy1segzR5dSj
 eOivUcNPgqAG7Z5S2JWZqoeRbMBNdoE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-MXh14t1WNx6WD2UZ3fUTpw-1; Fri, 15 Sep 2023 08:31:41 -0400
X-MC-Unique: MXh14t1WNx6WD2UZ3fUTpw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-53087cba7ecso518794a12.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 05:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694781100; x=1695385900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yc8PAB3ZKpWa1ExYlvcWYD1/PhWhZ5t6A+MoKbko7Uc=;
 b=Gc546QY5D8WIEFEpJIQSqgDLivfTOHfjYouuv0NF31SM52ZT5JkZiLSXJEH1iAIfpY
 Q+cEMAO6PTEAKm4qnWtb3gZkgCCtrHT5vT+xCgH2kCmK1nmsGZYot1eQCnZtp99Oj/U4
 zNzzzcAGACFjl3+lodlRLPDHj8giA/Yd81Zxsndsnp2mUYliyIta3elqYd92PlBcQoDR
 qUo8FhNDR6/g1fTnM8EjdXKkCVU2h/EjM2pT0vLq1VuTXWLf6gkM4QotTuoJnSre5gOA
 x3LLvWuwJ69yieECuCTC70UadVWmhZMkQeH2U9vFcJD5LweY6pVuRzM/DRzt5A2z/srx
 cRwg==
X-Gm-Message-State: AOJu0Yxs1Fpu0Gqj8gbYhoEVH2qnaR8rOJhAlt54ZZrRdtVZlLAVN2Vz
 UhAoC9gOUsrKUF1oqlimhBPjZ/M+S5BnDRXt5OQlXCYE+4+zWrr/6dFvOAedKEV8/SOCHiE50Qd
 8tAOjnIZwjnxINgI=
X-Received: by 2002:a50:fc0b:0:b0:530:74ed:fc8a with SMTP id
 i11-20020a50fc0b000000b0053074edfc8amr1162267edr.41.1694781100745; 
 Fri, 15 Sep 2023 05:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElCZ0qST5BTkdbhG05RMFfxxjTrEyy8jcD2SQrvhgfTyynYKKuZ2QHrMX4SB6l0Y7MRjkcmg==
X-Received: by 2002:a50:fc0b:0:b0:530:74ed:fc8a with SMTP id
 i11-20020a50fc0b000000b0053074edfc8amr1162245edr.41.1694781100440; 
 Fri, 15 Sep 2023 05:31:40 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 f5-20020a056402068500b005254b41f507sm2220333edy.32.2023.09.15.05.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 05:31:39 -0700 (PDT)
Date: Fri, 15 Sep 2023 14:31:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang
 <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 01/16] tests: test-smp-parse: Add the test for
 cores/threads per socket helpers
Message-ID: <20230915143138.7244c37a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230825033619.2075837-2-zhao1.liu@linux.intel.com>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <20230825033619.2075837-2-zhao1.liu@linux.intel.com>
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

On Fri, 25 Aug 2023 11:36:04 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Use the different ways to calculate cores/threads per socket, so that
> the new CPU topology levels won't be missed in these 2 helpes:
> 
> * machine_topo_get_cores_per_socket()
> * machine_topo_get_threads_per_socket()
> 
> Test the commit a1d027be95bc3 ("machine: Add helpers to get cores/
> threads per socket").
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/unit/test-smp-parse.c | 67 ++++++++++++++++++++++++++++++-------
>  1 file changed, 54 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
> index fdc39a846ca6..24972666a74d 100644
> --- a/tests/unit/test-smp-parse.c
> +++ b/tests/unit/test-smp-parse.c
> @@ -394,20 +394,47 @@ static char *smp_config_to_string(const SMPConfiguration *config)
>          config->has_maxcpus ? "true" : "false", config->maxcpus);
>  }
>  
> -static char *cpu_topology_to_string(const CpuTopology *topo)
> +/* Use the different calculation than machine_topo_get_threads_per_socket(). */
> +static unsigned int cpu_topology_get_threads_per_socket(const CpuTopology *topo)
> +{
> +    /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
> +    if (!topo->sockets) {
> +        return 0;
> +    } else {
> +        return topo->max_cpus / topo->sockets;
> +    }
> +}
> +
> +/* Use the different calculation than machine_topo_get_cores_per_socket(). */
> +static unsigned int cpu_topology_get_cores_per_socket(const CpuTopology *topo)
> +{
> +    /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
> +    if (!topo->threads) {
> +        return 0;
> +    } else {
> +        return cpu_topology_get_threads_per_socket(topo) / topo->threads;
> +    }
> +}
> +
> +static char *cpu_topology_to_string(const CpuTopology *topo,
> +                                    unsigned int threads_per_socket,
> +                                    unsigned int cores_per_socket)
>  {
>      return g_strdup_printf(
>          "(CpuTopology) {\n"
> -        "    .cpus     = %u,\n"
> -        "    .sockets  = %u,\n"
> -        "    .dies     = %u,\n"
> -        "    .clusters = %u,\n"
> -        "    .cores    = %u,\n"
> -        "    .threads  = %u,\n"
> -        "    .max_cpus = %u,\n"
> +        "    .cpus               = %u,\n"
> +        "    .sockets            = %u,\n"
> +        "    .dies               = %u,\n"
> +        "    .clusters           = %u,\n"
> +        "    .cores              = %u,\n"
> +        "    .threads            = %u,\n"
> +        "    .max_cpus           = %u,\n"
> +        "    .threads_per_socket = %u,\n"
> +        "    .cores_per_socket   = %u,\n"
>          "}",
>          topo->cpus, topo->sockets, topo->dies, topo->clusters,
> -        topo->cores, topo->threads, topo->max_cpus);
> +        topo->cores, topo->threads, topo->max_cpus,
> +        threads_per_socket, cores_per_socket);
>  }
>  
>  static void check_parse(MachineState *ms, const SMPConfiguration *config,
> @@ -415,14 +442,26 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
>                          bool is_valid)
>  {
>      g_autofree char *config_str = smp_config_to_string(config);
> -    g_autofree char *expect_topo_str = cpu_topology_to_string(expect_topo);
> -    g_autofree char *output_topo_str = NULL;
> +    g_autofree char *expect_topo_str = NULL, *output_topo_str = NULL;
> +    unsigned int expect_threads_per_socket, expect_cores_per_socket;
> +    unsigned int ms_threads_per_socket, ms_cores_per_socket;
>      Error *err = NULL;
>  
> +    expect_threads_per_socket =
> +                        cpu_topology_get_threads_per_socket(expect_topo);
> +    expect_cores_per_socket =
> +                        cpu_topology_get_cores_per_socket(expect_topo);
> +    expect_topo_str = cpu_topology_to_string(expect_topo,
> +                                             expect_threads_per_socket,
> +                                             expect_cores_per_socket);
> +
>      /* call the generic parser */
>      machine_parse_smp_config(ms, config, &err);
>  
> -    output_topo_str = cpu_topology_to_string(&ms->smp);
> +    ms_threads_per_socket = machine_topo_get_threads_per_socket(ms);
> +    ms_cores_per_socket = machine_topo_get_cores_per_socket(ms);
> +    output_topo_str = cpu_topology_to_string(&ms->smp, ms_threads_per_socket,
> +                                             ms_cores_per_socket);
>  
>      /* when the configuration is supposed to be valid */
>      if (is_valid) {
> @@ -433,7 +472,9 @@ static void check_parse(MachineState *ms, const SMPConfiguration *config,
>              (ms->smp.clusters == expect_topo->clusters) &&
>              (ms->smp.cores == expect_topo->cores) &&
>              (ms->smp.threads == expect_topo->threads) &&
> -            (ms->smp.max_cpus == expect_topo->max_cpus)) {
> +            (ms->smp.max_cpus == expect_topo->max_cpus) &&
> +            (ms_threads_per_socket == expect_threads_per_socket) &&
> +            (ms_cores_per_socket == expect_cores_per_socket)) {
>              return;
>          }
>  


