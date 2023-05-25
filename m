Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DA6710A60
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 12:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q28bC-0003i8-3E; Thu, 25 May 2023 06:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q28b7-0003fr-Ny
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:53:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q28b5-0007Ch-RD
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685012010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZnD8TLnfdVimAE24poFoFTZQzPKGMmP0oSTcue1NNUU=;
 b=WuRrg4MgUiEmhPB/SiBA5MaFNQb7TEF7wUE144jBoHDqkGX/2VlRSK68sV2Br3SlvEfqhV
 Zdv2Fm5IgcqgfZ4TRCDRMx2R4xEht3Wo/Y0M1Jg4+ekXXtECtPUcyKv5rJ/RfwYmHi2mxR
 0NODt5WYaHwM+StwbwciOYSn6PoSvVg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-ngVHBaf7OLCD-lNf6GR2Bw-1; Thu, 25 May 2023 06:53:27 -0400
X-MC-Unique: ngVHBaf7OLCD-lNf6GR2Bw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f4fb0193c6so1882155e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 03:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685012001; x=1687604001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnD8TLnfdVimAE24poFoFTZQzPKGMmP0oSTcue1NNUU=;
 b=dclYYyb+T1UzF7BCZbiyyuFCzFgjkUai+aFPLwz8WJ2UdKoEDZBRiUMmz5MmyhTioj
 i0Rx5CDcehO8PxxFA4mcaOcV2O1B42/NGgEFT3TnDhpL3ZL4SmRTSzeJPHiniAYyKtp8
 UP8V0pej/l62tciKnqvbQDOnuzV6fV+O3AC1PKYjcCzaHZc/jvHE50QRXc2+mD2se1jB
 pOoPPgjtBPcpYsLmXrmY0l+KSVOkEdNyBkKWbHI/Q9rb7eb+ZLtD2gRj6Zj5wesytnoN
 +cXpwkAOsd3D0+uH9G373PW5qDBv7r8VXq/Y/rCjfhGMrlVWySxOsZptQ92KUbTYvlzo
 xqsg==
X-Gm-Message-State: AC+VfDydG0zuN+bTfMggm6+7WF0/2rjz90komE2TC1ybWfVNIDY2vfhV
 fk7FhhndkSykQjeFbVz6t5HdneUMfaEKZ7xRKGQWeOo+HVWpq2yWp0ahHxsUifcDvQYi4Qk0tvQ
 Dgg/CgDhKlStQ37zi2e2QO78=
X-Received: by 2002:a05:600c:3641:b0:3f4:24c8:f7c6 with SMTP id
 y1-20020a05600c364100b003f424c8f7c6mr1980216wmq.16.1685012001831; 
 Thu, 25 May 2023 03:53:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+tQujYlCjvqsilXV2x1Ux8xmcaYi7VVaBU05QrQu4LeIn4kbUXnf7owS9RTtHvxs9X5A5lw==
X-Received: by 2002:a05:600c:3641:b0:3f4:24c8:f7c6 with SMTP id
 y1-20020a05600c364100b003f424c8f7c6mr1980206wmq.16.1685012001455; 
 Thu, 25 May 2023 03:53:21 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-30.web.vodafone.de.
 [109.43.177.30]) by smtp.gmail.com with ESMTPSA id
 p23-20020a05600c205700b003f42314832fsm1714288wmg.18.2023.05.25.03.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 03:53:20 -0700 (PDT)
Message-ID: <6d3d5c10-bd55-cd01-ad30-edaf54d39cc6@redhat.com>
Date: Thu, 25 May 2023 12:53:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] docs: sbsa: correct graphics card name
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>
References: <CAFEAcA9GamGybSzd8FKBtmZ2qMgjRFy6D=Vhu1y0dL8m9Sa80w@mail.gmail.com>
 <20230523155644.678524-1-marcin.juszkiewicz@linaro.org>
 <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
 <4101dedc-91d7-1735-4655-81082931b79d@linaro.org>
 <49fa8502-70f9-cdc4-1058-9d4202400db6@redhat.com>
 <CAFEAcA8OUP9vnJwRxcT7AUWPD5ANhc17ETgePYPe2=-N_ZvCsw@mail.gmail.com>
 <e6444d41-62ba-2381-3b26-78e75c2da56e@redhat.com>
 <CAFEAcA-BX6n3YWy+PtSED=Jex9waiez4vxqBK0+Ob3hT-SZmPg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CAFEAcA-BX6n3YWy+PtSED=Jex9waiez4vxqBK0+Ob3hT-SZmPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 25/05/2023 12.44, Peter Maydell wrote:
> On Thu, 25 May 2023 at 11:32, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 25/05/2023 12.05, Peter Maydell wrote:
>>> On Tue, 23 May 2023 at 19:41, Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> On 23/05/2023 19.30, Marcin Juszkiewicz wrote:
>>>> ...
>>>>>> (is there a reason why it can't be disabled with "-vga none" or
>>>>>> "-nodefaults"?)
>>>>>
>>>>> That's something I need to check how it should be done.
>>>>
>>>> Other boards set mc->default_display in their ...class_init
>>>> function and then use pci_vga_init() (or vga_interface_type)
>>>> to instantiate their default display adapter ... however, that
>>>> does not seem to support the bochs adapter yet (see
>>>> vga_interfaces[] in softmmu/vl.c).
>>>>
>>>> Not sure whether it's worth the effort to extend vga_interfaces[]
>>>> in vl.c
>>>
>>> Isn't that a legacy-command-line-option thing? I feel like
>>> the recommended way to select a different graphics card
>>> these days would be to use -device my-pci-vga-card ...
>>
>> "-vga" is kind of legacy, indeed, but currently the sbsa-ref hard-codes the
>> graphics card to be always available, so if you add a "-device
>> something-vga-card" on the command line, you'd get two graphic cards on your
>> machine, even if you use -nodefaults.
> 
> At least some boards do "only create the default graphics
> type if vga_interface_type != VGA_NONE".
> 
> Mostly what I would like here is consistency. But also, we
> haven't added a new item to the '-vga' option list since
> 2014, which makes me strongly suspect it's legacy and we
> should only be keeping it for backwards compatibility.
> 
>> So there needs to be at least some logic dealing with vga_interface_type if
>> we want to be able to select a different graphics card for this machine.
>> Then why not go the full way and use pci_vga_init() here, too? ... that's
>> certainly the least confusing way for the users.
> 
> Is it? From an Arm perspective, having "-vga" do anything
> at all is pretty confusing: it's a rather PC-centric option name.
> (Also pretty noticeable for the Sparc TCX/CG3 framebuffers,
> which are not VGA in any way.)

Ok, if this is rather an oddity on arm, then it's maybe better to do the 
"vga_interface_type != VGA_NONE" check instead.

  Thomas



