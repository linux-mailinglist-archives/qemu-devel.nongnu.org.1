Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C67923CC
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:10:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXgI-0001t4-6B; Tue, 05 Sep 2023 11:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdXgD-0001qe-Pg
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:09:25 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdXgB-00005G-Ht
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:09:25 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9a2a4a5472dso753602166b.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693926561; x=1694531361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vkAxuP5OyfvLfdtuBcobTOfxLs5IK+p1+Txl4Ty5Xqc=;
 b=vJOYf7mbw6sn4CHoBZc6PbJ9kga6iupKSe5WFSix892o7hlUp2kqhdvQeell7AiYV8
 MQoUa7SlLo8oYuHqPaG2Y2YYos1RcpHnUaRWsjq63y4k8YIuJYyaiJ7O8GkIRDFPNoGN
 URbKbJiBTkfbMSjzaemYEzBVbnZnSBCjgK/LZr347vlAptAdd1mJknWHnKlD9wdPOIzY
 23gQKIoOcJafBwnQzRPYzBbQx9oyf4n0S0ip3G+hvxWOce+CuHyvGohdnUQbReRNmPa7
 KfepX9DKeVh44t1hH3weqcqBX5XeDee1It0cCqZtU9XLW8uzbUcUk8I5RZD/4o1lNDRF
 sgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693926561; x=1694531361;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vkAxuP5OyfvLfdtuBcobTOfxLs5IK+p1+Txl4Ty5Xqc=;
 b=PcmDS4ofqZV8znAbApoLtSfyyutvvqmeSFiX1R6zrZtvzqUpY9O7y/O1XEAlMrYNZu
 syAuhbEydNqP8hECUBImtaEYSitjVL2YBG7Z9xHUjkDLv3TDIKw9eQSSdEuEAaqhppDI
 pD/0OC577OcioMgbAgNLzbK/xDuTO5CJirwG6CVa0a12OvzPW6FkCpSjOp7s2QLYiuxE
 lXf2GLDKN5LuKSaixUZw/Qosj3Oh2IWPzO/drtazwYF6b0L1CnFHiSUIJq48cGq+e7Lp
 WCt5Ysm6LUkrqEsknTcvZhxGQuQP2LKOsUvVFc+IYFWbZQH9i9crm08sZRq1tyDFhHAW
 4+bw==
X-Gm-Message-State: AOJu0Yy5HbDq58Jef5cIWFzrRo8LRp63Yr8dHBqaVa0jFk1iURD5khC5
 zD77urv13tq9W0cq23W9A4T5Uw==
X-Google-Smtp-Source: AGHT+IHm2e0TQ+z6IZuP5nqpTBNS5LQC410CoJBfaZbpDRAtaMdKGJPNt4OXntbTDVbbMBTCvHTJnA==
X-Received: by 2002:a17:907:72d5:b0:9a5:7d34:e68a with SMTP id
 du21-20020a17090772d500b009a57d34e68amr86240ejc.28.1693926560863; 
 Tue, 05 Sep 2023 08:09:20 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 v26-20020a170906489a00b0099cc36c4681sm7665759ejq.157.2023.09.05.08.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 08:09:20 -0700 (PDT)
Message-ID: <0d882c9c-a95c-3c0b-8e95-da729ad16b32@linaro.org>
Date: Tue, 5 Sep 2023 17:09:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: PCI Hotplug ACPI device names only 3 characters long
Content-Language: en-US
To: Marcello Sylverster Bauer <sylv@sylv.io>, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, ani@anisinha.ca,
 Patrick Rudolph <patrick.rudolph@9elements.com>
References: <66949448-1577-444a-b6d2-d907f9870765@sylv.io>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <66949448-1577-444a-b6d2-d907f9870765@sylv.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Hi Marcello,

On 5/9/23 17:05, Marcello Sylverster Bauer wrote:
> Greetings,
> 
> I'm currently working on a project to support Intel IPU6 in QEMU via 
> VFIO so that the guest system can access the camera. This requires 
> extending the ACPI device definition so that the guest knows how to 
> access the camera.
> 
> However, I cannot extend the PCI devices because their names are not 4 
> characters long and therefore do not follow the ACPI specification.
> 
> When I use '-acpitable' to include my own SSDT for the IPU6 PCI device, 
> it does not allow me to declare the device as an External Object because 
> it automatically adds padding underscores.
> 
> e.g.
> Before:
> ```
> External(_SB.PCI0.S18.SA0, DeviceObj)
> ```
> After:
> ```
> External(_SB.PCI0.S18_.SA0_, DeviceObj)
> ```

What do you mean by "before" / "after"?

> Adding the underscore padding is hard coded in iASL and also in QEMU 
> when parsing an ASL file. (see: build_append_nameseg())
> 
> So here are my questions:
> 1. Is there a solution to extend the ACPI PCI device using '-acpitable' 
> without having to patch iASL or QEMU?
> 2. Are there any plans to change the names to comply with the ACPI spec? 
> (e.g. use "S%.03X" format string instead)
> 
> Thanks
> Marcello
> 


