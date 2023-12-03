Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BF58028F6
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 00:22:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9vlk-0001pv-Tz; Sun, 03 Dec 2023 18:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r9vli-0001pG-K7
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 18:20:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r9vlh-0000Uv-4M
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 18:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701645655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spwkLDHgoaxm9u/144CqpiGtbQ9F85ARNRSrmjoTQow=;
 b=gvVQkT/q10T7C79kFD17SrUJpuejMfjijjYRh4D4OprW2ctGgpHJpHSgXVweWFXhyOBCFs
 pcBF2EgERKbG2TZHIA1KDIQDwy1CB0+WA0S0pItO6UTDfFH9Bh5IQecAEnZuVtw3s53ORP
 g6+q+JSSEb+X44MX9Rk8EW89FkyuQks=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-rxhOhBY2P32PSfit_bXieQ-1; Sun, 03 Dec 2023 18:20:54 -0500
X-MC-Unique: rxhOhBY2P32PSfit_bXieQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6d87f0b71aeso1466625a34.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 15:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701645653; x=1702250453;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=spwkLDHgoaxm9u/144CqpiGtbQ9F85ARNRSrmjoTQow=;
 b=QIzddpExPJ8XM01ZUrCz82i5dNdjrpAuYCh7yYvACiAsQhNA40QON//k8BLyixt3I1
 +eLDU6tFS26FZ1OJM+YUMnxy3x39OEHy+9LLjfNt9y+y24VRoWWMtzunVMMzZp1fTUsY
 2HchWZun41C3ieDnARcfAYcS19hYZ0krxxxpg/+V4107R6uMdzMnJuiXvqx87bVjduKW
 ma4woXoL+84tIUmmhm/qIjIubi0kFGfLI32MZ/9p8O0c9J7cfvrLALfBorFo9di6p+4K
 Qe1ttUbMyWWiWcPhPNAIfq81e7f96JVvX0pF7pZyIIbELcWK1nh3XduBts1NIvQXe96O
 T/SQ==
X-Gm-Message-State: AOJu0YwtWEUIoU+VWPML4+3uiSjhwhbRc3YhH+/ytjEQWsHZpA+3v8HE
 v+YD3NGKerX3RRjtI4eE7XzZqAG6+YizqZr+tgPctBhrlCa+3SxfzoQvNSkXNiaR6d96IBXq/Fb
 9XEiD8MII7rPESPI=
X-Received: by 2002:a05:6870:d889:b0:1fb:75b:2fb3 with SMTP id
 oe9-20020a056870d88900b001fb075b2fb3mr3531167oac.74.1701645653619; 
 Sun, 03 Dec 2023 15:20:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+mtUOBvNeAZYsiln7QyrSwYC05F2KrlSocmiKdSvDR7WktaYEtI9UNJCAMAuSt2buO7tQyQ==
X-Received: by 2002:a05:6870:d889:b0:1fb:75b:2fb3 with SMTP id
 oe9-20020a056870d88900b001fb075b2fb3mr3531134oac.74.1701645653335; 
 Sun, 03 Dec 2023 15:20:53 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78805000000b006cb65cfde6dsm6358199pfo.200.2023.12.03.15.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 15:20:53 -0800 (PST)
Message-ID: <fa0e8be7-8f18-4d74-ad5d-6dc44d375d2d@redhat.com>
Date: Mon, 4 Dec 2023 09:20:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/9] machine: Improve is_cpu_type_supported()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, b.galvani@gmail.com, strahinja.p.jankovic@gmail.com,
 sundeep.lkml@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, vijai@behindbytes.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231129042012.277831-1-gshan@redhat.com>
 <20231129042012.277831-4-gshan@redhat.com>
 <83046c42-1df3-499e-b202-b123391d39cb@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <83046c42-1df3-499e-b202-b123391d39cb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Phil

On 12/1/23 20:57, Philippe Mathieu-Daudé wrote:
> On 29/11/23 05:20, Gavin Shan wrote:
>> It's no sense to check the CPU type when mc->valid_cpu_types[0] is
>> NULL.
> 
> This case is a programming error, right? We should simply:
> 
>   assert(!mc->valid_cpu_types || *mc->valid_cpu_types);
> 

Yes, assert() should be used instead. I will do this like below:

     if (mc->valid_cpu_types && machine->cpu_type) {
         assert(mc->valid_cpu_types[1] != NULL);


>> So the check is skipped for this particular case. The constraint
>> has been taken when the error messags are appended.
>>
>> A precise hint for the error message is given when mc->valid_cpu_types[0]
>> is the only valid entry. Besides, enumeration on mc->valid_cpu_types[0]
>> when we have mutiple valid entries there is avoided to increase the code
>> readability, as suggested by Philippe Mathieu-Daudé.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   hw/core/machine.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
> 

Thanks,
Gavin


