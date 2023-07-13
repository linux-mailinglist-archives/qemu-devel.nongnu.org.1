Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75775206B
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 13:52:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJurp-0006AP-Cp; Thu, 13 Jul 2023 07:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qJurn-00069s-Kz
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:52:15 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qJurm-0002hC-1U
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:52:15 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51e99584a82so771780a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 04:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689249131; x=1691841131;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XFjNfn7R1H5fhzbWuvnUMECb004rySEmdgokQIdNG2I=;
 b=d3sMBqKSkPAkcXxeoNeOS+2SRLayWFJx+KBP4IpXEqBgP39JllcLr0mQDGIBmiZFEc
 06DgsryXUMbkcIRwDUU5HRRRt97enz+MWjUM/GZIjtS7rnlsIZtc7R5E5NN7DbEmLVYw
 0skSZ+2kiDyuUH96XR5KVMWTj/jgrGCBxJgapexboi9vyyHhaXTw9y1CDifAsN63K2eS
 q7+VJSYEmS9idyOcyySxmBMrcCSKvHR/2+AJFoAdSZYGEi0vHj9q4ypA27pN7gQitOh4
 oUh7bU69awt7cgoUUH1Hjxfak70x2OHJZ+aM39KMQAAow5eF1CPQ2fkPl7IhXA9nDSZM
 FllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689249131; x=1691841131;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XFjNfn7R1H5fhzbWuvnUMECb004rySEmdgokQIdNG2I=;
 b=bmaBX1Uu7DgeXsK11SFlYxpLfxM5TiXc07j14qjuvb+ANpW/CizP4B5wV9umjY7Xg5
 xzJpvMvyUuOlRNQtMhV/UG7Mu+XJEd2NzdJkusn/TPtKFI7RbpKU0UMCNg8k9t+LE+Ih
 zmwc+ZNtfS9il1ZIpHMOdA7NcSqlWjpsUnhyO9fHBEZwDXwFxApf6vXqGlo9EpMyRqM8
 HwC1GMsvvIQ0YQV4BIWM+TxjXPEbokEffkQcL8Fz4oltgE42jCWmxrEo+1+X2tKSeWU9
 M4mMSRNg26xO4PsJhzSljvGKTanDq///1kDQNoo/4xCwh6CmIYtCc1YlD4uZgc4lOltv
 A0eQ==
X-Gm-Message-State: ABy/qLaXi5yRiyfmmrep85a/aO+rTkqICp5tVKjPQUx6/IFZBzyRid/z
 WB/RMTOHcAtPF+CNiEuj50di+Q==
X-Google-Smtp-Source: APBJJlGSznKYsseOC3RvQoPWu+rvEYT5QYC2Mx6bM/7DitBKZfDRTggdML/3vQBkpW3H1EPtnE65Jg==
X-Received: by 2002:a50:fb17:0:b0:51e:26c8:25f7 with SMTP id
 d23-20020a50fb17000000b0051e26c825f7mr1434379edq.42.1689249131414; 
 Thu, 13 Jul 2023 04:52:11 -0700 (PDT)
Received: from [192.168.200.206] (83.21.150.147.ipv4.supernova.orange.pl.
 [83.21.150.147]) by smtp.gmail.com with ESMTPSA id
 w13-20020a50fa8d000000b0051dfa2e30b2sm4147837edr.9.2023.07.13.04.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 04:52:11 -0700 (PDT)
Message-ID: <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
Date: Thu, 13 Jul 2023 13:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
Content-Language: pl-PL, en-GB, en-HK
To: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, shan.gavin@gmail.com
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

W dniu 13.07.2023 o 13:44, Peter Maydell pisze:

> I see this isn't a change in this patch, but given that
> what the user specifies is not "cortex-a8-arm-cpu" but
> "cortex-a8", why do we include the "-arm-cpu" suffix in
> the error messages? It's not valid syntax to say
> "-cpu cortex-a8-arm-cpu", so it's a bit misleading...

Internally those cpu names are "max-{TYPE_ARM_CPU}" and similar for 
other architectures.

I like the change but it (IMHO) needs to cut "-{TYPE_*_CPU}" string from 
names:

13:37 marcin@applejack:qemu$ ./build/aarch64-softmmu/qemu-system-aarch64 
-M virt -cpu cortex-r5
qemu-system-aarch64: Invalid CPU type: cortex-r5-arm-cpu
The valid types are: cortex-a7-arm-cpu, cortex-a15-arm-cpu, 
cortex-a35-arm-cpu, cortex-a55-arm-cpu, cortex-a72-arm-cpu, 
cortex-a76-arm-cpu, a64fx-arm-cpu, neoverse-n1-arm-cpu, 
neoverse-v1-arm-cpu, cortex-a53-arm-cpu, cortex-a57-arm-cpu, 
host-arm-cpu, max-arm-cpu

13:37 marcin@applejack:qemu$ ./build/aarch64-softmmu/qemu-system-aarch64 
-M virt -cpu cortex-a57-arm-cpu
qemu-system-aarch64: unable to find CPU model 'cortex-a57-arm-cpu'


I can change sbsa-ref to follow that change but let it be userfriendly.

