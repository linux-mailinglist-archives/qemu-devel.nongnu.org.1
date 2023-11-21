Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 933587F222A
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 01:35:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5EjB-0004I7-9J; Mon, 20 Nov 2023 19:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r5Ej6-0004Fl-TF
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 19:34:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r5Ej5-0003PZ-5l
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 19:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700526889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zwQV9ruwyGeb4CQaS8eyhz532/e3aSmzenzWeviWFHU=;
 b=MFMMDIstwtmjYFQmc6VTSNag8fNh3eiGuEGZZA8Frb0iiGH+B8hFHhbhE+B2Uw/7c6ZkQr
 D6EIuUyCsK2fcMfWVkuhxuiQcoNugn3p4lV2aYzjDeD47PvJEcO3jzW2JJH3BLWVR+B0EG
 rgWETgKxj9ColyvdBt4q+bdEPsBcjpw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-HJqgkCLIP8uOf69TesobbA-1; Mon, 20 Nov 2023 19:34:46 -0500
X-MC-Unique: HJqgkCLIP8uOf69TesobbA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1cc23f2226fso58691395ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 16:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700526885; x=1701131685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zwQV9ruwyGeb4CQaS8eyhz532/e3aSmzenzWeviWFHU=;
 b=PEiZntGlhRfHp0yYNo9yjf/wvMN77DJmiYu4gwt/4E4ProGYmsD7Y7wSSBa2XP9DN2
 RwqTKk1vfZ6YViEH72FOj4cOVh/HEKX+HKUxiqmmeFVKH5bJQYPgEREEWIlrJd6I6Co8
 rpZ0T/lyIrGppDoIjQmxhkLYNNGzBTrkuclVRtdEvt00yfoyDUfdgYmc8UCJLJ8/PAhS
 Z/NrQiA+zPNPMejQyKMHtKOym/XGJW4enfUF23g2nZkyaSiHkZrcmipNQ+tuRBOpyqgc
 KDCNpM3yF8J0ltps2B1wk794WhmrmjAAeTdV1LI2S2JekObVGra7rh56sxoH6fmDIywJ
 BooA==
X-Gm-Message-State: AOJu0YydGdvOJNG27ZE3da5OuUn9D2a92cM0o1i65bkllXk9Wr+AvEtV
 4TcMJVeC0IeqLpVOP3uwipXRLTRMHXVQesg0G+RpsZxGbsfsYb608B/Gu/LEW0HA7ai9nmrlzKk
 PKuOwa1yLhXBFPBA=
X-Received: by 2002:a17:902:e748:b0:1ca:8541:e1ea with SMTP id
 p8-20020a170902e74800b001ca8541e1eamr10829614plf.0.1700526885115; 
 Mon, 20 Nov 2023 16:34:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxYyEpr7i+kut7a98LmWqK7w00neo1ezzJFYv+fmFSVtLkTrmq/mNh8/wzvr7WOyLJUN06AA==
X-Received: by 2002:a17:902:e748:b0:1ca:8541:e1ea with SMTP id
 p8-20020a170902e74800b001ca8541e1eamr10829587plf.0.1700526884726; 
 Mon, 20 Nov 2023 16:34:44 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15?
 ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a17090282c400b001cc615e6850sm6647120plz.90.2023.11.20.16.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 16:34:44 -0800 (PST)
Message-ID: <5ce6f318-3fbb-41fe-9761-fb460c607de1@redhat.com>
Date: Tue, 21 Nov 2023 10:34:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] Unified CPU type check
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231120002724.986326-1-gshan@redhat.com>
 <8a386258-1a5b-4c69-972e-49f9d1e59f51@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <8a386258-1a5b-4c69-972e-49f9d1e59f51@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/21/23 05:42, Marcin Juszkiewicz wrote:
> W dniu 20.11.2023 o 01:27, Gavin Shan pisze:
>> Testing
>> =======
>>
>> With the following command lines, the output messages are varied before
>> and after the series is applied.
>>
>>    ./build/qemu-system-aarch64            \
>>    -accel tcg -machine virt,gic-version=3 \
>>    -cpu cortex-a8 -smp maxcpus=2,cpus=1
>>
>> Before the series is applied:
>>
>>    qemu-system-aarch64: mach-virt: CPU type cortex-a8-arm-cpu not supported
>>
>> After the series is applied:
>>
>>    qemu-system-aarch64: Invalid CPU type: cortex-a8-arm-cpu
>>    The valid models are: cortex-a7, cortex-a15, cortex-a35, cortex-a55,
>>                          cortex-a72, cortex-a76, a64fx, neoverse-n1,
>>                          neoverse-v1, cortex-a53, cortex-a57, max
> 
> 
> $ ./build/qemu-system-aarch64 -M sbsa-ref -cpu cortex-a53
> qemu-system-aarch64: Invalid CPU type: cortex-a53
> The valid types are: cortex-a57, cortex-a72, neoverse-n1, neoverse-v1, neoverse-n2, max
> 
> $ ./build/qemu-system-aarch64 -M sbsa-ref -cpu sa1100
> Unexpected error in object_property_find_err() at ../qom/object.c:1329:
> qemu-system-aarch64: Property 'sa1100-arm-cpu.secure-memory' not found
> Aborted (core dumped)
> 
> 
> Similar with 'host' or 'pxa250' while QEMU/master does:
> 
> $ qemu-system-aarch64 -M sbsa-ref -cpu sa1100
> qemu-system-aarch64: sbsa-ref: CPU type sa1100-arm-cpu not supported
> 

Good catch! I didn't realize that the syntax of error_propagate() has been changed
due to ERRP_GUARD() since ae7c80a7bd7 ("error: New macro ERRP_GUARD()"). Prior to
the commit, QEMU process is terminated immediately by error_propagate(). After the
commit, the termination is delayed until machine_run_board_init() returns. For the
later case, mc->init() is called and causing coredump on 'sbsa-ref' board.

A 'return' is needed after error_propagate() in machine_run_board_init() so that
mc->init() won't be called.

void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp)
{
     ERRP_GUARD();
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
     Error *local_err = NULL;
     :
     /* Check if the CPU type is supported */
     is_cpu_type_supported(machine, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;                               <<<<< A 'return' is needed here >>>>>
     }
     :
     accel_init_interfaces(ACCEL_GET_CLASS(machine->accelerator));
     machine_class->init(machine);
     phase_advance(PHASE_MACHINE_INITIALIZED);
}

With the 'return' added, everything looks good. I would let v6 floating for another 2-3
days before posting v7 to fix the issue.

[gshan@gshan q]$ ./build/qemu-system-aarch64 -M virt -cpu cortex-a8
qemu-system-aarch64: Invalid CPU type: cortex-a8
The valid types are: cortex-a7, cortex-a15, cortex-a35, cortex-a55, cortex-a72, cortex-a76, cortex-a710, a64fx, neoverse-n1, neoverse-v1, neoverse-n2, cortex-a53, cortex-a57, max

[gshan@gshan q]$ ./build/qemu-system-aarch64 -M sbsa-ref -cpu sa1100
qemu-system-aarch64: Invalid CPU type: sa1100
The valid types are: cortex-a57, cortex-a72, neoverse-n1, neoverse-v1, neoverse-n2, max

[gshan@gshan q]$ ./build/qemu-system-aarch64 -M sbsa-ref -cpu cortex-m0
qemu-system-aarch64: Invalid CPU type: cortex-m0
The valid types are: cortex-a57, cortex-a72, neoverse-n1, neoverse-v1, neoverse-n2, max

[gshan@gshan q]$ ./build/qemu-system-aarch64 -M sbsa-ref -cpu pxa250
qemu-system-aarch64: Invalid CPU type: pxa250
The valid types are: cortex-a57, cortex-a72, neoverse-n1, neoverse-v1, neoverse-n2, max

[gshan@gshan q]$ ./build/qemu-system-aarch64 -M sbsa-ref -cpu host
qemu-system-aarch64: unable to find CPU model 'host'

Thanks,
Gavin




