Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A855B7D5084
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 14:59:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvH09-00055J-0x; Tue, 24 Oct 2023 08:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvH05-00054P-Q8; Tue, 24 Oct 2023 08:59:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvH04-00064A-5h; Tue, 24 Oct 2023 08:59:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso35549345e9.1; 
 Tue, 24 Oct 2023 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698152350; x=1698757150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Fv2AY0PfohaOR9XcU+8ZQ81rKPOWLOMFyddNbcLYLA=;
 b=kgTAmPyal5o6zuAwb9jZBdnHZAlh3GPBJWjDRlSo4Ti6SAKlQ7DH4tVYdjs+Xof+TH
 acTC2Tn1F61MIIUxR8yn2v/1cz+Tq1OZZ1uQYi7h9TTNisI1yDQCz7tFgS+wEWj6HvMO
 T6OUjJL05v2nQW+n9BoDPM//2TxHufwHPyY/Wcwe121GtThFmxVmeeaFi0qTJdAsDvGF
 xuPjPhVVjVI/XXD4d8QNny3ql1GuGQP2/jSFHTUngxdVgYSbGskiW6VdLQI/9gUm4Ayi
 K8hqLgG+wDO4BNh0Rj3nAHmnNS1S/iP6bEWhTf5d8DPqKXgs+eH+mFRgoMUbC2JscZwB
 pFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698152350; x=1698757150;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Fv2AY0PfohaOR9XcU+8ZQ81rKPOWLOMFyddNbcLYLA=;
 b=DzzBJzp89HzPVpza7W6ntEQgeoGeYiAH0C8yr/rdWaKDtVvy5m+z/1ldj+z4dc1jIN
 X1sQ0Mwz0hbrbZa3Mn0XxNn8tT++kvrdXJIWPsgGFIpdok21Vobjg2AVlk3jhF1krWst
 AswGoeCIU5WPRXISXBCh4W32ZIx1vQNU1qqgHFZZLUJ6HiyuOescnNM+LBzgou1eGrmy
 zj2O+VRhQzXkdeRkeIdYvfHxVMMt6lRQfpNdavC8OEuUBHyD2jKVczipUO1x8YEWXqxY
 /zZsgvkxFCdz7GGWAYEXS1JbfijBl0KEB5o24hbE49ImQBzGxOgo1Xp3WQA4m9EiBKsl
 HFZQ==
X-Gm-Message-State: AOJu0YxSWweG5SIiWWumWrWcC7MIvheOGXQbMh57dJ3Cy2YtLgVC2ICg
 BVK55EUEOB2n2oWUYEgPAk8=
X-Google-Smtp-Source: AGHT+IHO2khmsIcOqOzMGxdA5Ej9PMASd96m2EkszFQX+E0xL93HsityPlswigSIsmJsJG7LwrKmlw==
X-Received: by 2002:a05:600c:5252:b0:408:389d:c22e with SMTP id
 fc18-20020a05600c525200b00408389dc22emr9189363wmb.25.1698152350138; 
 Tue, 24 Oct 2023 05:59:10 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-230.amazon.com. [54.240.197.230])
 by smtp.gmail.com with ESMTPSA id
 az20-20020a05600c601400b004054dcbf92asm11888555wmb.20.2023.10.24.05.59.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 05:59:08 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <55bb6967-9499-45ef-b4c8-00fbfaccef0d@xen.org>
Date: Tue, 24 Oct 2023 13:59:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] hw/xen: add get_frontend_path() method to
 XenDeviceClass
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-7-dwmw2@infradead.org>
 <5ef43a7c-e535-496d-8a14-bccbadab3bc0@xen.org>
 <d43b900a6c7987c6832ceeede9b4c5ab65d5bacd.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <d43b900a6c7987c6832ceeede9b4c5ab65d5bacd.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 24/10/2023 13:56, David Woodhouse wrote:
> On Tue, 2023-10-24 at 13:42 +0100, Paul Durrant wrote:
>>
>>> --- a/hw/xen/xen-bus.c
>>> +++ b/hw/xen/xen-bus.c
>>> @@ -711,8 +711,16 @@ static void xen_device_frontend_create(XenDevice *xendev, Error **errp)
>>>     {
>>>         ERRP_GUARD();
>>>         XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
>>> +    XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
>>>     
>>> -    xendev->frontend_path = xen_device_get_frontend_path(xendev);
>>> +    if (xendev_class->get_frontend_path) {
>>> +        xendev->frontend_path = xendev_class->get_frontend_path(xendev, errp);
>>> +        if (!xendev->frontend_path) {
>>> +            return;
>>
>> I think you need to update errp here to note that you are failing to
>> create the frontend.
> 
> If xendev_class->get_frontend_path returned NULL it will have filled in errp.
> 

Ok, but a prepend to say that a lack of path there means we skip 
frontend creation seems reasonable?

> As a general rule (I'll be doing a bombing run on xen-bus once I get my
> patch queue down into single digits) we should never check 'if (*errp)'
> to check if a function had an error. It should *also* return a success
> or failure indication, and we should cope with errp being NULL.
> 

I'm pretty sure someone told me the exact opposite a few years back.

   Paul

