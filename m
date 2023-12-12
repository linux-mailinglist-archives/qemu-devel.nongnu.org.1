Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 173BF80E37D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 05:57:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCunr-00078u-5t; Mon, 11 Dec 2023 23:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rCunm-00078O-SP
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 23:55:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rCunk-0006NW-Oe
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 23:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702356921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDEN6IBKCR9SZvy+vP5xMfqISLn2urgiBHY3S8b4Wt0=;
 b=i1rctoaqK2VXCKM67iVI/sUXTDmNEmL5pF45n4uZSFa49p8jabSjmFBoP2dlQ0hostKN0l
 1xr1tW43f8CIYhXWf7c19/vLHbYe08OVPccLcTa/sBMxaY7vHzajqk73nkGtpobUNsGPem
 GKgwpLnjld74PhiO+xMmzMIuTvkzDeQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-ibZOL-NRO_yh2oMyf8n9mw-1; Mon, 11 Dec 2023 23:55:19 -0500
X-MC-Unique: ibZOL-NRO_yh2oMyf8n9mw-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3b9eeff9f7bso6034741b6e.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 20:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702356919; x=1702961719;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gDEN6IBKCR9SZvy+vP5xMfqISLn2urgiBHY3S8b4Wt0=;
 b=SHL46GcRhfAYgM/4EOa/eSghSFhNVsUOwX1bGOgqrEsm0a7Ztb6MdF2kAMGD+DV1Ul
 XnbwdJkhsnjQFBMof+s30kbXIyMAJtOW14QFfJPBsff2O3TGq8UOVt+s+tN3IN6CxfUD
 eUrAeQwzN5fMY6rHYpMYotwvp7LxtEKpZu07YtAez7q9QcyhwAvM9d7NOTYSWH5QYLp+
 Jxw75Kqso/BfJYPqQSZHPmHZ439R/nmZ3m3z0jk1qRnut4sVEzVgSWI8Bd9ybO96FUm3
 IacwXcEb3lVRNADZsuDf6JVBWUY31CSSWZxPvznai+5A384MQCBpUnnOMx+etOykrh+S
 frJg==
X-Gm-Message-State: AOJu0YzX7+cdEcQNeNS4UpVbMlVFiOHSIjx2Ir4hUfXoFM7Vpezfsrrz
 M+AL3g+yOr4XJHkbDMZ/lxG/DpGZEYepdpRvgMR643lwlkkpO28wWgeXA3IU2Xarlh1hdbDd+PS
 ezUuVq7iaL/zOJBo=
X-Received: by 2002:a05:6808:1493:b0:3b9:d4c0:5fac with SMTP id
 e19-20020a056808149300b003b9d4c05facmr7478783oiw.22.1702356919107; 
 Mon, 11 Dec 2023 20:55:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF69UM/96uA9+yVDBg06a7ccGQ/ArtwPvz/UiRlwVZ4UPAq2rRgkmD9crHzR3Fux+aWTDQ9Zg==
X-Received: by 2002:a05:6808:1493:b0:3b9:d4c0:5fac with SMTP id
 e19-20020a056808149300b003b9d4c05facmr7478776oiw.22.1702356918859; 
 Mon, 11 Dec 2023 20:55:18 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 c23-20020aa78817000000b006ce358d5d9asm7417601pfo.141.2023.12.11.20.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 20:55:18 -0800 (PST)
Message-ID: <0b2aaedf-7a4c-49f4-b4af-71f9ab693207@redhat.com>
Date: Tue, 12 Dec 2023 14:55:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/9] Unified CPU type check
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, imammedo@redhat.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 armbru@redhat.com, wangyanan55@huawei.com, vijai@behindbytes.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231204004726.483558-1-gshan@redhat.com>
In-Reply-To: <20231204004726.483558-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Phil,

On 12/4/23 10:47, Gavin Shan wrote:
> This series bases on Phil's repository because the prepatory commits
> have been queued to the branch.
> 
>    https://gitlab.com/philmd/qemu.git (branch: cpus-next)
> 
> There are two places where the user specified CPU type is checked to see
> if it's supported or allowed by the board: machine_run_board_init() and
> mc->init(). We don't have to maintain two duplicate sets of logic. This
> series intends to move the check to machine_run_board_init() so that we
> have unified CPU type check.
> 
> This series can be checked out from:
> 
>    git@github.com:gwshan/qemu.git (branch: kvm/cpu-type)
> 
> PATCH[1-4] refactors and improves the logic to validate CPU type in
>             machine_run_board_init()
> PATCH[5-9] validates the CPU type in machine_run_board_init() for the
>             individual boards
> 
> v6: https://lists.nongnu.org/archive/html/qemu-arm/2023-11/msg00768.html
> v7: https://lists.nongnu.org/archive/html/qemu-arm/2023-11/msg01045.html
> v8: https://lists.nongnu.org/archive/html/qemu-arm/2023-11/msg01168.html
> 

Ping to see if there is a chance to queue it up before the Chrismas? :)

Thanks,
Gavin


