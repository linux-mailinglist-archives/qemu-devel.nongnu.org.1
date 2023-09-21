Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F167A92B3
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFDA-0002Vo-2L; Thu, 21 Sep 2023 04:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qjFD4-0002R0-K7; Thu, 21 Sep 2023 04:38:55 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qjFD2-0001pc-DD; Thu, 21 Sep 2023 04:38:54 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-690bc3f8326so602930b3a.0; 
 Thu, 21 Sep 2023 01:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695285529; x=1695890329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VIKkwGUok/SeWJukNlJTlrusZJS75Jrvs11LYCpMKWg=;
 b=m6FURzhhBwxmJPX+GLxDNACYDnWiuAqxYv108P4FHZ82nvGIf3mux60CViDrCg9vLL
 S975YoUJF6GcY69wY7WojvDbRhOqGnmGXUzjcqLFXmfF7JJ2bSKmAz2Q84K3b/6PrF+n
 ko4Fnvc47DryjnCow7x04oPEvrLmfIvC0kCe4N6N5U8FKR5g4q7p+fkD1LuhLodEg0iB
 gpcl/xsXdgCb3X0UdVvrvJzDN1WNbNMcpvhPAH8blwXuJiDE6+ccBkoWorIZqX9rZk+M
 sdrFe1uPB233qBjmQlfL9PjIwl3O0AJT3rjVob2dM41put39Je89QrH6sKsYpAYdEZnH
 z99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695285529; x=1695890329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VIKkwGUok/SeWJukNlJTlrusZJS75Jrvs11LYCpMKWg=;
 b=IFbBqv6LGcLnFEeZ3yWtcysOIzYHhngPT1jnoBrUnlvxaaMVaqpRlCSUDrEtojcmoM
 S4+dKQJIHT7T+Mmtpjvi3nhJqGJ3Z6H8L5eShTYQczfpjxAjepfp38XKrewz62iv3IE5
 wg98QLZOOcmORu6I59paFTtYYtJCVQjiajfrRNX8OdNtVAhlCPI/U2GHgwzVf0GgKCNQ
 3907lyjY4VjSR7wQStN0fIbN/N8os7DbiEugIuRKYTyRAyD2wgCQ6Fqw0CGVejzYKAfG
 /Wxp9UVMKtXgVGJcWe5Qrejxl2gwHunPDFe66cuYvmaS+/NqrDYEgY5kQyHXGAM6uN95
 3SSA==
X-Gm-Message-State: AOJu0YyJEOBARNHdNUkFr1llRNAPMxIuX8WO+OWB5BEi7vXTFXEsTh+3
 UY0KSEoe+BpFYWQcPbMPnn0=
X-Google-Smtp-Source: AGHT+IE5StdHi+Szsxv6K0tLOpDIh1Sy0VISh9AoP7W9E5+csd6dmCYJg1bwjnxH3Lx6NLa8Zi5GVg==
X-Received: by 2002:a05:6a20:1602:b0:14c:5dc3:f1fe with SMTP id
 l2-20020a056a20160200b0014c5dc3f1femr5846192pzj.41.1695285528652; 
 Thu, 21 Sep 2023 01:38:48 -0700 (PDT)
Received: from [192.168.0.19] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a17090aec1300b0027475ac5bcasm2522073pjy.30.2023.09.21.01.38.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 01:38:48 -0700 (PDT)
Message-ID: <9a8f1e6e-edcf-416d-9508-8af666db4263@gmail.com>
Date: Thu, 21 Sep 2023 17:38:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 4/5] hw/ufs: Support for UFS logical unit
Content-Language: ko
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230907181628.1594401-1-stefanha@redhat.com>
 <20230907181628.1594401-5-stefanha@redhat.com>
 <c4dc2292-4690-f16f-4b70-d6f759c16633@redhat.com>
 <160581dc-bdbc-03e8-64a5-1adb818a15b2@gmail.com>
 <86ebcc33-491c-8820-2ca0-51d46b0b7375@redhat.com>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <86ebcc33-491c-8820-2ca0-51d46b0b7375@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42a.google.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 2023-09-15 4:59 PM, Paolo Bonzini wrote:
> On 9/15/23 00:19, Jeuk Kim wrote:
>> First, ufs-lu has a feature called "unit descriptor". This feature 
>> shows the status of the ufs-lu
>>
>> and only works with UFS-specific "query request" commands, not SCSI 
>> commands.
>
> This looks like something that can be implemented in the UFS subsystem.
>
>> UFS also has something called a well-known lu. Unlike typical SCSI 
>> devices, where each lu is independent,
>> UFS can control other lu's through the well-known lu.
>
> This can also be implemented in UfsBus.
>
>> Finally, UFS-LU will have features that SCSI-HD does not have, such 
>> as the zone block command.
>
> These should be implemented in scsi-hd as well.
>
>> In addition to this, I wanted some scsi commands to behave 
>> differently from scsi-hd, for example,
>> the Inquiry command should read "QEMU UFS" instead of "QEMU HARDDISK",
>> and the mode_sense_page command should have a different result.
>
> Some of these don't have much justification, and others (such as the 
> control page) could be done in scsi-hd as well.
>
> We should look into cleaning this up and making ufs-lu share a lot 
> more code with scsi-hd; possibly even supporting -device scsi-hd with 
> UFS devices.  I am not going to ask you for a revert, but if this is 
> not done before 8.2 is out, I will ask you to disable it by default in 
> hw/ufs/Kconfig.
>
> In the future, please Cc the SCSI maintainers for UFS patches.
>
> Paolo
>
Dear Paolo

Hi. I've been looking into how ufs-lu can share code with scsi-hd.

I have verified that ufs-lu can use scsi-hd's code, and I would like to modify it to do so.

I've validated two possible fixes.
I'd like to hear your thoughts.

Option1.
As you mentioned, using ufsbus, which inherits from scsibus, removes the ufs-lu device type and use scsi-hd. (like -device ufs,id=ufs0 -device scsi-hd,bus=ufs0)
I've verified that this method is implementable, except for one problem.
Because we are using the scsi-hd type instead of the ufs-lu type, the ufs has to manage all the ufs-lu specific data (such as the unit descriptor).
However, since there is no ufs_lu_realize() function, we need a way to notify the ufs when a new scsi-hd device is added.
Would there be a way to let the ufs know that a new scsi-hd has been added at scsi_hd_realize() time?

Option 2.
Use qdev_new() & qdev_realize() to make ufs-lu have a virtual scsi bus and scsi-hd.
The ufs-lu can pass through SCSI commands to the virtual scsi-hd.
This is similar to the method used by the device "usb-storage".

With this method, I can keep the ufs-lu device type (ufs_lu_realize() makes it convenient to manage ufs-lu related data) and avoid duplicating code with scsi-hd.
So I prefer this approach, but the annotation for "usb-storage" is marked with a "Hack alert", so I'm not sure if this is the right way.
The code can be found in usb_msd_storage_realize() (hw/usb/dev-storage-classic.c:51).

I am wondering if you could give me some advice on this and your preferred direction for fixing it.

Thank you so much.

Jeuk


