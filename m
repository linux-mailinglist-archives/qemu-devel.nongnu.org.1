Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D952D7B2906
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 01:51:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm0lz-0005Cv-DV; Thu, 28 Sep 2023 19:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm0lx-0005CO-CC
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 19:50:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm0lv-0007XB-LP
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 19:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695945018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p0XZt9kRyelPfoqH8bCJT3LAf3sfTTCBFuXgcpHVVwQ=;
 b=Jz6rtIz+aql4870XOdil18MguHbN4wqADlmtlN6KcfM5HFvuOSvh25ymEHQ06LFTIns+Vo
 gBzVZke7H49Eyqvcts7BCqZzf3mYiDyyJpgv3aoW+Jx0294CSRlMVsaWP1zG24Q3/cqn6N
 rIQcbCuiN2aHFJtgsl2oqoFXdJ9/v74=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-BcqLLHiGPcGUDjPD_ChUVg-1; Thu, 28 Sep 2023 19:50:17 -0400
X-MC-Unique: BcqLLHiGPcGUDjPD_ChUVg-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3ae2a37595dso28533710b6e.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 16:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695945016; x=1696549816;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p0XZt9kRyelPfoqH8bCJT3LAf3sfTTCBFuXgcpHVVwQ=;
 b=sTPiDVeISCIeGQobW9yCiGNpvTGixuuiIE7g7ifdxAlxU1q9aqiSmw72HeZ8Zh8pEa
 +bEtkVXeHdzFMgL3RGzdtsuLlubKc78qOao2sR5/eaWYRMMF91e2DwfKBiWXjnqIuJxD
 VYiSiiqLtHmQl+BAnsOgHPeoHIl9qdwI4Qp9UzBT48L8eCiwHp0TaZb5RPNYQcCR+YUT
 17PPqeVAdfbIgt4fSp3uEBkB4uVNzmIoitKgbLEXvrifxm1XVXlDNK7FhG6oYk4j5Aah
 n8mtF2z6VoioKtbZNJWd0v16Z+Wn2C+4EdH7p6SxQiJTDgnBzJ0cL6Y8Fq/3EXMTs90t
 G6rA==
X-Gm-Message-State: AOJu0YwtL5G5lj7GskPtyWs1wgoPJ9LAc/7UmfLlgpw2aISNt7B0d0Th
 0VteJJ5j9Q4oZM0AviIXYzCtbRwFSqhJxUCWR9XUsfyZoheuQUDiRbiB0nABqXm+L7xexs2eiEj
 wPXqwIq5CEx0nmAY=
X-Received: by 2002:a05:6808:f04:b0:3af:6cf3:d62f with SMTP id
 m4-20020a0568080f0400b003af6cf3d62fmr1563709oiw.29.1695945016374; 
 Thu, 28 Sep 2023 16:50:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG49JH3BMY6IZoWbfrUszHt3uYOrx4q5Mmwlfh3G76UtcNOkVU7LpINQrZ6TbwLSquK/A6Pw==
X-Received: by 2002:a05:6808:f04:b0:3af:6cf3:d62f with SMTP id
 m4-20020a0568080f0400b003af6cf3d62fmr1563687oiw.29.1695945016063; 
 Thu, 28 Sep 2023 16:50:16 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a62bd0a000000b00682a908949bsm6718016pff.92.2023.09.28.16.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 16:50:15 -0700 (PDT)
Message-ID: <ae6cdf01-2ede-69d8-cc6d-60ea1c80cefd@redhat.com>
Date: Fri, 29 Sep 2023 09:50:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 22/37] hw/acpi: Make _MAT method optional
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-23-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-23-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/26/23 20:04, Salil Mehta wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> The GICC interface on arm64 vCPUs is statically defined in the MADT, and
> doesn't require a _MAT entry. Although the GICC is indicated as present
> by the MADT entry, it can only be used from vCPU sysregs, which aren't
> accessible until hot-add.
> 
> Co-developed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/acpi/cpu.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 

With following nits addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index e1299696d3..217db99538 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -715,11 +715,13 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>               aml_append(dev, method);
>   
>               /* build _MAT object */
> -            assert(adevc && adevc->madt_cpu);
> -            adevc->madt_cpu(i, arch_ids, madt_buf,
> -                            true); /* set enabled flag */
> -            aml_append(dev, aml_name_decl("_MAT",
> -                aml_buffer(madt_buf->len, (uint8_t *)madt_buf->data)));
> +            if (adevc && adevc->madt_cpu) {
> +                assert(adevc && adevc->madt_cpu);
> +                adevc->madt_cpu(i, arch_ids, madt_buf,
> +                                true); /* set enabled flag */
> +                aml_append(dev, aml_name_decl("_MAT",
> +                    aml_buffer(madt_buf->len, (uint8_t *)madt_buf->data)));
> +            }
>               g_array_free(madt_buf, true);
>   
>               if (CPU(arch_ids->cpus[i].cpu) != first_cpu) {

May be worthy to have comment to mention _MAT isn't needed on aarch64.

                /* Build _MAT object, which isn't needed by aarch64 */

Thanks,
Gavin


