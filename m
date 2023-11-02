Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 072BA7DEDBD
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:58:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySZH-0007xk-Bg; Thu, 02 Nov 2023 03:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qySZF-0007xD-5F
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:56:41 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qySZD-0002rL-A1
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:56:40 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507975d34e8so793927e87.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698911797; x=1699516597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sF7Hj2hEa72zZ/WI2WhM366HtOJev2AIO3JWURIw6sU=;
 b=QMpwh9rIcW7tzjUdMD3hdLgZn+MZlGGafFD6XB0mMiqa5srE3CIxqUV6muVR3g89mI
 Zr4a00BsDy1aT3Ema2pm8h9CnSK5cQQmhaxEdMmA8h4sFhRyi1if4qR/KQYU2Pzr0C5h
 7ntapHqkx9WmEoSQrL/Eu1HaUAIzL4BW4CTQNTBpjhE60G8svzRYZKVXy0ZW4mOq+gSE
 3emWF1i9MBCPKsrClt6p+rCYY+PDezhMs0fL7xqI/1viAwTlbcX+vekoRgWNhqlgTMHm
 BwwWS+n1IANi1lXxDzhNO14o04km1V6iwaWseRm7yutTps06ovrPUKjI9Nqaxw3AoM1A
 5MEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698911797; x=1699516597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sF7Hj2hEa72zZ/WI2WhM366HtOJev2AIO3JWURIw6sU=;
 b=M7Yhk20Qi5AoxC6cndJKpAAst+yQBwuDfgosLxYbe4mbEtN1vv8/5C2BJ8b7CUxyEi
 /585qtwukRJqTDs54GxNyzKh0o0WzKDwhhkDhgg6vvBw6OGQN5oXYNbOLo+T68ykXJWT
 AFVFSMzKpS/dbrOHq4gDQpsE+wN4MSqOuMKd0FV5qI8n3juqboUowiBr6q6qz8KnbuPU
 L4pWijqNx/+tFZBuzdKQQo99VK5Dr2H4wQeXLtxGqMt+Q+UNLeSzCzXuBQItO4LJdWwZ
 eG7K8NH6DKgZbd49pGjUoBRc0l4dZiexQnYfbMsCBB+cysltI6ZNEm2H7vhQtquJUq/B
 U5BA==
X-Gm-Message-State: AOJu0YxHsYxJBcs/konjicx+45YRTeN/OQ2xS8EqK04NDVxLKqXqqCeV
 NYWauIXXxRkcbvrPn9igwhGUbA==
X-Google-Smtp-Source: AGHT+IEDdwE3MvYCzg2/HET8YVtdW4G6eMBMnVW6CLB9bmlSRPop4aAJnhIFzv6GCRwUrt05Io2EVA==
X-Received: by 2002:ac2:4c25:0:b0:503:17fd:76bb with SMTP id
 u5-20020ac24c25000000b0050317fd76bbmr13953640lfq.39.1698911797037; 
 Thu, 02 Nov 2023 00:56:37 -0700 (PDT)
Received: from [192.168.69.115] (176-131-219-113.abo.bbox.fr.
 [176.131.219.113]) by smtp.gmail.com with ESMTPSA id
 a60-20020a509ec2000000b0053e3d8f1d9fsm1990812edf.67.2023.11.02.00.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 00:56:36 -0700 (PDT)
Message-ID: <281434a9-f63a-3cda-fd25-5b243cf86a76@linaro.org>
Date: Thu, 2 Nov 2023 08:56:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 0/5] hw/ppc/e500: Pass array of CPUs as array of
 canonical QOM paths
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231030143957.82988-1-philmd@linaro.org>
 <81265616-df2d-460c-aea5-0af04b15cd8b@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <81265616-df2d-460c-aea5-0af04b15cd8b@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.777,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31/10/23 22:49, Daniel Henrique Barboza wrote:
> 
> 
> On 10/30/23 11:39, Philippe Mathieu-Daudé wrote:
>> Following the discussion with Peter on my "cpus: Step toward
>> removing global 'first_cpu'" series [*], we now pass the array
>> of CPUs via property. Since we can not pass array of "link"
>> properties, we pass the QOM path of each CPU as a QList(String).
>>
>> Tagged as RFC to discuss the idea of using qdev_prop_set_array
>> with qlist_append_str(object_get_canonical_path). Personally I
>> find it super simple.
> 
> I probably misunderstood the concept/problem but "super simple" is not 
> the first
> thing that came to my mind in patch 5 hehe

Right, I probably forgot some paragraph here. I meant, passing QOM
canonical path as a string between (qdev) objects seems much simpler
than declaring a PropertyInfo for each type we want to pass, because
this is within the same QEMU process and we don't need to serialize
anything.

See for example:
$ git grep -h PropertyInfo hw/core/qdev-properties-system.c
219:const PropertyInfo qdev_prop_drive = {
228:const PropertyInfo qdev_prop_drive_iothread = {
295:const PropertyInfo qdev_prop_chr = {
369:const PropertyInfo qdev_prop_macaddr = {
457:const PropertyInfo qdev_prop_netdev = {
495:const PropertyInfo qdev_prop_audiodev = {
585:const PropertyInfo qdev_prop_losttickpolicy = {
615:const PropertyInfo qdev_prop_blocksize = {
628:const PropertyInfo qdev_prop_blockdev_on_error = {
642:const PropertyInfo qdev_prop_bios_chs_trans = {
654:const PropertyInfo qdev_prop_fdc_drive_type = {
666:const PropertyInfo qdev_prop_multifd_compression = {
747:const PropertyInfo qdev_prop_reserved_region = {
810:const PropertyInfo qdev_prop_pci_devfn = {
916:const PropertyInfo qdev_prop_pci_host_devaddr = {
926:const PropertyInfo qdev_prop_off_auto_pcibar = {
996:const PropertyInfo qdev_prop_pcie_link_speed = {
1084:const PropertyInfo qdev_prop_pcie_link_width = {
1134:const PropertyInfo qdev_prop_uuid = {
1147:const PropertyInfo qdev_prop_cpus390entitlement = {

