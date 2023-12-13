Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820C810F00
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 11:55:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDMtN-0008WN-HW; Wed, 13 Dec 2023 05:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rDMtJ-0008Vx-LD
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 05:55:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rDMtI-0006dJ-2L
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 05:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702464899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HU8SWwamGacwL6Ipt63TqUDV0WFAIHBdSLcEitBLHvM=;
 b=dZqvYpSq2kC/KWu94TxzcoAYCgotMVTFk35n4//fz66ULeIgRCuiXyIUBbpt9xHaBbEMeA
 ecwuSORhxmfa6sJrkO3uuAeTmOaoVunOBOfVeLsGbnUvJT9byOiPpYiZ5lVPrB5dai9X50
 IRiqCa4o+b6UBtT6IJ4GTatOJ+62zhA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-QDuZenQAMjmPgk78-8lcMQ-1; Wed, 13 Dec 2023 05:54:55 -0500
X-MC-Unique: QDuZenQAMjmPgk78-8lcMQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5c65e666609so5840472a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 02:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702464895; x=1703069695;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HU8SWwamGacwL6Ipt63TqUDV0WFAIHBdSLcEitBLHvM=;
 b=AN9kvZs6ajPwSxLGzdVdc0h/Jz8ge8MPEgrb2HrCwFtfqyaa1z1lhP08JLqgQnDdp7
 07y2oycHpHJaVm+bk2hQSw64carWjt80lBxv8btmp5zgrlUFM51IMVkjoNXlezM7EkI+
 tc8rVKw86aCj46/Lw1ruZXG2EhFXnWCPBYohJVM1OjX/DEVYn7GW/7Vk7GTnrkxoXOUY
 u3WJgtb2rFwXz/UJrkaNGwAsijXMEpwpUeBs29u8uS3lX297ewZYnf6kfWiz58BCOkGi
 UF99ajlUj5yufWNTrnZjtVX99yxEpGKr0mExIxCNoEOLvdmB0gZi0FPf1yB3Z+4DoMyU
 K4aQ==
X-Gm-Message-State: AOJu0YyYcqNAIp4K019MuIleA9fKzxdroQ/bTXLQk7Ci6Bpsn0fBx4mj
 axhjpe/pAhNmyNSyZ7qe28wtmgJMXMvrvkQCgDgBJOwU3sbHiiiGsyt7B1rl5xCk0Ka4vDSF3rK
 RsVARBuTlkssDV78=
X-Received: by 2002:a05:6a20:1388:b0:187:5db4:1688 with SMTP id
 hn8-20020a056a20138800b001875db41688mr7896295pzc.18.1702464894978; 
 Wed, 13 Dec 2023 02:54:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg6umOAb9b/pM1wLYg5nnAL0BtmZIjDnLqgbtZOvIGm+xy3vWclv/21zWnt6UwJDrMKFFl+Q==
X-Received: by 2002:a05:6a20:1388:b0:187:5db4:1688 with SMTP id
 hn8-20020a056a20138800b001875db41688mr7896283pzc.18.1702464894684; 
 Wed, 13 Dec 2023 02:54:54 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a17090a9c0500b0028ad273525dsm1977655pjp.25.2023.12.13.02.54.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 02:54:54 -0800 (PST)
Message-ID: <23213dcb-16ca-4be4-9ff2-32e4fc491495@redhat.com>
Date: Wed, 13 Dec 2023 20:54:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/9] Unified CPU type check
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, imammedo@redhat.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 wangyanan55@huawei.com, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231204004726.483558-1-gshan@redhat.com>
 <0b2aaedf-7a4c-49f4-b4af-71f9ab693207@redhat.com>
 <ff0237a8-9e1c-46bf-ae69-99c3f33112f6@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ff0237a8-9e1c-46bf-ae69-99c3f33112f6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


On 12/13/23 20:08, Philippe Mathieu-Daudé wrote:
> On 12/12/23 05:55, Gavin Shan wrote:
>> On 12/4/23 10:47, Gavin Shan wrote:
>>> This series bases on Phil's repository because the prepatory commits
>>> have been queued to the branch.
>>>
>>>    https://gitlab.com/philmd/qemu.git (branch: cpus-next)
>>>
>>> There are two places where the user specified CPU type is checked to see
>>> if it's supported or allowed by the board: machine_run_board_init() and
>>> mc->init(). We don't have to maintain two duplicate sets of logic. This
>>> series intends to move the check to machine_run_board_init() so that we
>>> have unified CPU type check.
>>>
>>> This series can be checked out from:
>>>
>>>    git@github.com:gwshan/qemu.git (branch: kvm/cpu-type)
>>>
>>> PATCH[1-4] refactors and improves the logic to validate CPU type in
>>>             machine_run_board_init()
>>> PATCH[5-9] validates the CPU type in machine_run_board_init() for the
>>>             individual boards
>>>
>>> v6: https://lists.nongnu.org/archive/html/qemu-arm/2023-11/msg00768.html
>>> v7: https://lists.nongnu.org/archive/html/qemu-arm/2023-11/msg01045.html
>>> v8: https://lists.nongnu.org/archive/html/qemu-arm/2023-11/msg01168.html
>>>
>>
>> Ping to see if there is a chance to queue it up before the Chrismas? :)
> 
> Series queued. "Before" Christmas will depend on the final release tag.
> 
> Thanks for the various iterations,
> 

Phil, thank you for you continuous reviews and valuable comments.

Yes, the final merge to master branch depends on the release plan.
'queue' meant to merge the series to your 'cpus-next' branch ;-)

Thanks,
Gavin


