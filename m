Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 787197D92F5
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:02:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwIiX-0004Iz-CM; Fri, 27 Oct 2023 05:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwIiO-0004Ia-KM; Fri, 27 Oct 2023 05:01:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwIiM-0000Kq-JD; Fri, 27 Oct 2023 05:01:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-409299277bbso7178365e9.2; 
 Fri, 27 Oct 2023 02:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698397268; x=1699002068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kudjWF6BKXHcvZTM1tPFPJmSWancLrtDgA6AoiUkJqM=;
 b=d0+L2AmtvHqUS5mRQm0mZvsC8U8eOs5A78P/8ysBFFwJ1m5pqcExiOYh8cZPBV/cVk
 W5RgPmiiltMT4NHLdNP44qyVxTer1aIXJEoDJXhxAA0sYkhhvIHyYn5GmWH3/4a/MXVc
 pDCR1vspLujUoH8TzqlRVRvPzAbevlZ+gT6fdqD8V/0JirMmoVVnJFH1bG2XSwSs/pQW
 iRBN6xPU52RKb7X5LsS7mQS/gC8dFb4U4eZ6ayU79qj0i0wXMSShlu5kxMSlNVjjpqnk
 JcKTFBQpTE4ChPf7+HOMRmYTM48VRtpxrJEmfd2TL2Ijd2+dlnKfur5XjdaTWAyQAz9G
 WF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698397268; x=1699002068;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kudjWF6BKXHcvZTM1tPFPJmSWancLrtDgA6AoiUkJqM=;
 b=K+jYRID2waCkYwO/WlETqgtdFTVrigF/o6/g+HmxrD75I/JnLQvN9vdV/bHV8hkhMz
 tlSlju4srtLtVkeV5fc8M13Os8dSM/AQ4lfntZcgUFrXyyYEQo7R9Nmxr06iAA+4w4Xl
 KUWXEx0bcQnp2QXwCtWUdME5GA8PwJSWruSphFSn+JPI9NiSkGeKQ3m78DBdPgaJKjxm
 K2cQyTSkSj07ada9SvVTFo9JMMJlGoeSZ/PvtNOL+qfyXyeC7a+OIPAXwjkLT01Y7gB6
 vkrgR6EHAyc4ZiTYvO8EWLeMlxmg5khirwhX0Sq1GlMNBBuSl/Ed5Oj1CFxtymTiiKm6
 mW/w==
X-Gm-Message-State: AOJu0YzReSjka+75ki7ROJXAHcuVnnP7h+woGwR7i8T+WaUT8nztLmeJ
 24uQNqdszj7XD+Kog+awlMA=
X-Google-Smtp-Source: AGHT+IF2wenxeyE7XIJ4gn5j7HE7kYt/efuEUfra8aTWvRCTeZ6usZClJatbl/oALDDone8ynTaYHQ==
X-Received: by 2002:a05:600c:1f92:b0:405:959e:dc7c with SMTP id
 je18-20020a05600c1f9200b00405959edc7cmr1735809wmb.30.1698397268254; 
 Fri, 27 Oct 2023 02:01:08 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-227.amazon.com. [54.240.197.227])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a05600c510100b003fe1c332810sm4617535wms.33.2023.10.27.02.01.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:01:07 -0700 (PDT)
Message-ID: <9fb67e52-f262-4cf4-91c2-a42411ba21c4@gmail.com>
Date: Fri, 27 Oct 2023 10:01:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/28] hw/xen: automatically assign device index to
 block devices
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, paul@xen.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231025145042.627381-1-dwmw2@infradead.org>
 <20231025145042.627381-14-dwmw2@infradead.org>
 <74e54da5-9c35-485d-a13c-efac3f81dec2@gmail.com>
 <f72e2e7feed3ecf17af8ab8442c359eea329ef17.camel@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <f72e2e7feed3ecf17af8ab8442c359eea329ef17.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x329.google.com
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

On 27/10/2023 09:45, David Woodhouse wrote:
> On Fri, 2023-10-27 at 08:30 +0100, Durrant, Paul wrote:
>>
>>> +    if (blockdev->props.vdev.type == XEN_BLOCK_VDEV_TYPE_INVALID) {
>>> +        XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
>>> +        char fe_path[XENSTORE_ABS_PATH_MAX + 1];
>>> +        char *value;
>>> +        int disk = 0;
>>> +        unsigned long idx;
>>> +
>>> +        /* Find an unoccupied device name */
>>
>> Not sure this is going to work is it? What happens if 'hda' or 'sda', or
>> 'd0' exists? I think you need to use the core of the code in
>> xen_block_set_vdev() to generate names and search all possible encodings
>> for each disk.
> 
> Do we care? You're allowed to have *all* of "hda", "sda" and "xvda" at
> the same time. If a user explicitly provides "sda" and then provides
> another disk without giving it a name, we're allowed to use "xvda".
> 

Maybe sda and xvda can co-exist, but

https://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=docs/man/xen-vbd-interface.7.pandoc;h=ba0d159dfa7eaf359922583ccd6d2b413acddb13;hb=HEAD#l125

says that you'll likely run into trouble if hda exists and you happen to 
create xvda.

> Hell, you can also have *separate* backing stores provided as "hda1",
> "sda1" and "xvda1". I *might* have tolerated a heckle that this
> function should check for at least the latter of those, but when I was
> first coding it up I was more inclined to argue "Don't Do That Then".

This code is allocating a name automatically so I think the onus is on 
it not create a needless clash which is likely to have unpredictable 
results depending on what the guest is. Just avoid any aliasing in the 
first place and things will be fine.

   Paul


