Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BC379FD54
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:39:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qggwB-0004vI-Kq; Thu, 14 Sep 2023 03:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qggw9-0004tJ-Gg
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:38:53 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qggw7-0006Eu-Kg
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:38:53 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-502e385e33bso1037689e87.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 00:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694677130; x=1695281930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6a07noXEEeKYvWLKsxvl2WHpK5F69z9OVfpm+Ch6jm4=;
 b=ivysUO5CWK/Ap3DuXnvbTSB2aXPo5rU6x0Nu+Mfzwq2KJAaidk9ukQtilXCGv9O2FM
 B+QQMH9TB72nEB0bOGpG2sw2S3pDdzWJKWazbNAy69afK2wh90+z2aARpYqA5uUj/NqR
 gRiHqOXgYxzGdoEhUK8zbq40iCd9qHIo4VDaD7lhEpZzgOl4P0xJdkuAEX/w3PePwupT
 ujNdKbXB38AQ1ISRGPPKTEn25/Lorob0YApAfBDAjvyH63ptl5o/asbYJZ0eXJjpCDce
 ZCWn8q+75T9dZZPkFn9FBg+62plg9U7H00SdyCOFvLeBPpzFNb1sIBCH+910v2v37Dhf
 mvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694677130; x=1695281930;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6a07noXEEeKYvWLKsxvl2WHpK5F69z9OVfpm+Ch6jm4=;
 b=WMU8gNlg1YI2Ve4GOSFUS1+6XiD0Qyk3JmxJv+iF+Awtfm5jeTQHXkTC1GBAciaiBH
 bGjLNDJphqTFDjNchNAXeHWWVXbwbVEhP/Rg01nicK02UqzDFwdACldqgc/32GGbNTRt
 fgvxA6eesIH75xfCagnYGV5hdEnqJNGi5VLx6Xt7i8ZxluVEedhjDTuVt2M5iWBxahQ1
 2bngClAb/wQE4i25T7paWU/pr7xwFono2uMWXNo98c6n4JPfc1jNA0xPGBiWOfoa1EjK
 +xmnyrLOXuS/SP4uv86x2yAAnVUfdOOZ8Lb8duQ+ukbUAYx5sLn+WtT1ha5bQOfAPe+a
 8+PQ==
X-Gm-Message-State: AOJu0YwCT0H+amydmB1INkxx5JKhGk1Y0ZJj5UK7HBKYQOiLVEQnSrvj
 PlPQlqjL4GV4vgREbRtacN86QQ==
X-Google-Smtp-Source: AGHT+IFvOeScxfD7nNArBjxb2/X37ctH0HekJVyd4OoEGRMHHoGJiVsOHKisFnZfoY6lhnmvKpBVdQ==
X-Received: by 2002:a05:6512:3b95:b0:500:8ecb:509 with SMTP id
 g21-20020a0565123b9500b005008ecb0509mr4434920lfv.15.1694677129826; 
 Thu, 14 Sep 2023 00:38:49 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 k17-20020aa7c391000000b00521f4ee396fsm556332edq.12.2023.09.14.00.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 00:38:49 -0700 (PDT)
Message-ID: <b98d2eb3-7228-5a78-3c91-d347f160bc8a@linaro.org>
Date: Thu, 14 Sep 2023 09:38:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 10/21] i386: Introduce module-level cpu topology to
 CPUX86State
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
 <20230914072159.1177582-11-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914072159.1177582-11-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/9/23 09:21, Zhao Liu wrote:
> From: Zhuocheng Ding <zhuocheng.ding@intel.com>
> 
> smp command has the "clusters" parameter but x86 hasn't supported that
> level. "cluster" is a CPU topology level concept above cores, in which
> the cores may share some resources (L2 cache or some others like L3
> cache tags, depending on the Archs) [1][2]. For x86, the resource shared
> by cores at the cluster level is mainly the L2 cache.
> 
> However, using cluster to define x86's L2 cache topology will cause the
> compatibility problem:
> 
> Currently, x86 defaults that the L2 cache is shared in one core, which
> actually implies a default setting "cores per L2 cache is 1" and
> therefore implicitly defaults to having as many L2 caches as cores.
> 
> For example (i386 PC machine):
> -smp 16,sockets=2,dies=2,cores=2,threads=2,maxcpus=16 (*)
> 
> Considering the topology of the L2 cache, this (*) implicitly means "1
> core per L2 cache" and "2 L2 caches per die".
> 
> If we use cluster to configure L2 cache topology with the new default
> setting "clusters per L2 cache is 1", the above semantics will change
> to "2 cores per cluster" and "1 cluster per L2 cache", that is, "2
> cores per L2 cache".
> 
> So the same command (*) will cause changes in the L2 cache topology,
> further affecting the performance of the virtual machine.
> 
> Therefore, x86 should only treat cluster as a cpu topology level and
> avoid using it to change L2 cache by default for compatibility.
> 
> "cluster" in smp is the CPU topology level which is between "core" and
> die.
> 
> For x86, the "cluster" in smp is corresponding to the module level [2],
> which is above the core level. So use the "module" other than "cluster"
> in i386 code.
> 
> And please note that x86 already has a cpu topology level also named
> "cluster" [3], this level is at the upper level of the package. Here,
> the cluster in x86 cpu topology is completely different from the
> "clusters" as the smp parameter. After the module level is introduced,
> the cluster as the smp parameter will actually refer to the module level
> of x86.
> 
> [1]: 864c3b5c32f0 ("hw/core/machine: Introduce CPU cluster topology support")
> [2]: Yanan's comment about "cluster",
>       https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg04051.html
> [3]: SDM, vol.3, ch.9, 9.9.1 Hierarchical Mapping of Shared Resources.
> 
> Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> Changes since v1:
>   * The background of the introduction of the "cluster" parameter and its
>     exact meaning were revised according to Yanan's explanation. (Yanan)
> ---
>   hw/i386/x86.c     | 1 +
>   target/i386/cpu.c | 1 +
>   target/i386/cpu.h | 5 +++++
>   3 files changed, 7 insertions(+)


> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 470257b92240..556e80f29764 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1903,6 +1903,11 @@ typedef struct CPUArchState {
>   
>       /* Number of dies within this CPU package. */
>       unsigned nr_dies;
> +    /*
> +     * Number of modules within this CPU package.
> +     * Module level in x86 cpu topology is corresponding to smp.clusters.
> +     */
> +    unsigned nr_modules;
>   } CPUX86State;

It would be really useful to have an ASCII art comment showing
the architecture topology. Also for clarity the topo fields from
CPU[Arch]State could be moved into a 'topo' sub structure, or even
clearer would be to re-use the X86CPUTopoIDs structure?

