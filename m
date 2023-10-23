Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E420E7D3073
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 12:58:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quscR-0008K8-Tf; Mon, 23 Oct 2023 06:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1quscM-0008Jj-CP
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:57:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1quscK-0004uz-7L
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:57:05 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ca3a54d2c4so25918835ad.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 03:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698058622; x=1698663422;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L38ZJosxE30IxaVKmCkiLa1+77ylU9E2RvDG4VY9pEU=;
 b=Y6cPs+a4TUMf+Q29jr7bCYGInivKKUoLDMWG4OtJAhABsTXIz54KZH92o9AE5y7lCL
 arb0LF4qw+whYWcx7j8EEcNBwfUXvFjjq7TzoK34V14fKbRoZS2WRTNePTxgMisC7a/8
 RCrhDWpKD+2zN5ScLN9HfabFctLUDuLpIogDVDk62JhTqnAfBd8M3gVYeCrQn9A869LH
 TqQ1Zt/4h7v9yP+DSmRKnxgPMmlAxk2iW+uMJrqF1DeVwX4tCpwbWTBeNwxn3Ic8gpmq
 wNom6YvGG2Y6vLatAu8BQEkbsfJneUqAUGW0q1m+nrjhC+apNCrD+Buvb859218tZi4Q
 Fxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698058622; x=1698663422;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L38ZJosxE30IxaVKmCkiLa1+77ylU9E2RvDG4VY9pEU=;
 b=aXNPM2H+Y1So6omTync0yzaSv35xAX7fnMI/46t/o7x5t5n/aU4qc7ZMurBqe842D4
 pda/+Jt7nmtKsJ+04zpCRFPdF8iSTedDWUL1O1JNG2PdRfjbZZpzjKn3s/xB/UkG6xK8
 oxFRygrwLOUEPTyPM/RzITlGfg/ow0ICkgjYZvUXRqPhBexHSB/bT55DpfolYuivBaNp
 cmhAbJsyf4UfWj+nyvJ/iHWXstG2tCN2hoYNj8Srpwoi0veeT9AA15OBx1208eYzBlsb
 YoO5fFJs98vAsfdug4M91CEVQOmAyJVR5OhoX9jUd+dr9XUqFVCKsfm+WbJc2KKx8iNP
 Wvfw==
X-Gm-Message-State: AOJu0YxV01S4CfKdSQh5Xq5cUzl8tSRr+Qhn+NiMZQJrYjhXnQtB7Azx
 7Q+X7pJKngwR+rWGJJkwWThtpQ==
X-Google-Smtp-Source: AGHT+IEi/CVh8kYXmp+I9VcctxVQo30OAiQ0JmcngBnJvRt4z5B2vQN7GDXIpuz18wIfkxcQPFOdRg==
X-Received: by 2002:a17:902:f543:b0:1ca:77e9:3863 with SMTP id
 h3-20020a170902f54300b001ca77e93863mr10344849plf.31.1698058622456; 
 Mon, 23 Oct 2023 03:57:02 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a170902c38c00b001bf044dc1a6sm5700756plg.39.2023.10.23.03.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 03:57:02 -0700 (PDT)
Message-ID: <0ba67ce3-ce96-4ac0-9941-9f3cb6321145@daynix.com>
Date: Mon, 23 Oct 2023 19:57:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] igb: Add Function Level Reset to PF and VF
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>
References: <20230829090529.184438-1-clg@kaod.org>
 <20230829090529.184438-3-clg@kaod.org>
 <CACGkMEu6nznVGTyk8gjrZ3jE=bEAd2bDDi9PPwjDKNFkXnVhSQ@mail.gmail.com>
 <d9df1c95-f681-4962-be74-671cef90e908@redhat.com>
 <b744bd42-0b46-44ce-8d60-28d4d31427e0@redhat.com>
 <CACGkMEtbsVCAUFe6AomYe3EO=iBOXze6vJ20c8p0AbsXogocCw@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEtbsVCAUFe6AomYe3EO=iBOXze6vJ20c8p0AbsXogocCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/23 12:11, Jason Wang wrote:
> On Fri, Oct 20, 2023 at 5:41 PM Cédric Le Goater <clg@redhat.com> wrote:
>>
>> On 10/20/23 09:40, Cédric Le Goater wrote:
>>> On 10/20/23 06:24, Jason Wang wrote:
>>>> On Tue, Aug 29, 2023 at 5:06 PM Cédric Le Goater <clg@kaod.org> wrote:
>>>>>
>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>>
>>>>> The Intel 82576EB GbE Controller say that the Physical and Virtual
>>>>> Functions support Function Level Reset. Add the capability to each
>>>>> device model.
>>>>>
>>>>
>>>> Do we need to do migration compatibility for this?
>>>
>>> Yes. it does. the config space is now different.
>>
>> Jason,
>>
>> To avoid an extra compat property, would it be ok to let the VF peek into
>> the PF capabilities to set FLR or not ? Something like below.
> 
> I might be wrong, but it looks to me it's still a behaviour change?

I think it's fine as long as the FLR capability of the PF is initialized 
with a compat property; there is no need of another property for the VFs.

Regards,
Akihiko Odaki

