Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 545E17A401C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 06:43:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi65L-0001ub-DG; Mon, 18 Sep 2023 00:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qi65I-0001uC-MD; Mon, 18 Sep 2023 00:42:08 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qi65G-0001iJ-AZ; Mon, 18 Sep 2023 00:42:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68fc292de9dso2868074b3a.0; 
 Sun, 17 Sep 2023 21:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695012123; x=1695616923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SfTbgSQq8ifC0cr96fWsNj/XyqQa4cwqYisfJpe0CPc=;
 b=J1gggAUPHNUDeaxtGBuuwC7TKAssn6N4+JWAzHjSw4W1xnr0z1+i6XgN7AInMlmE+x
 uVkXObtD6Y5icElj8AwCD1WAUQ4a/EnCHMdDQ4yyc9rU82WSS8S5z+CPCbM/+aRSqPbY
 E4TVCXCjPHdryYBFwZKuxB/HWllVe4i5LV5lz2ZGBTN+NdTEJzHo0HE3HiTlw689dKXE
 dpZSEZE3Maz1/XM9wvhO903LlYSM/N5dKuPbFRTevET7VhyCNG0ur8eCQ8djapTc9WQ0
 7OVIQCKUOfi7xz/dTZZHnZLs8XaycHRmtGmfU7Q9cQIhFKMFCeqXA/V36m/1CmeooKaK
 Dtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695012124; x=1695616924;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SfTbgSQq8ifC0cr96fWsNj/XyqQa4cwqYisfJpe0CPc=;
 b=NQMq+24/z+9z5CeIHgjDyXVjd5T2SQKQuBKxOT9tjK9BXcYzMyaakP7PQfPyMQCKcV
 GN8oiZibaQ5pAhgOQrO9zq8boKbcFbgB/Na0YpYaYR0J8HZQUBOztNDeE2RSaqEsrFzu
 B2ifgERJbRhnXZH++tDuhgCaMufTU0wUA9Z18aJ1S2leIsEXh3wjb5dsaxjAJqKCgKhI
 T6Hk1sLGWB5BHFZmMsIBVarjyjNlF/CcvK5j7wdy/OupageKeCG9p9kVFMMr1Bi3ycnm
 pRx+Mc1tdQXr06ACsCGvYQXhGz5cVyTMLnmMu9KXUMXEyudpnxoWSGkCeFuH4u9E+TlE
 4saw==
X-Gm-Message-State: AOJu0Yxnt1LnqgIL1Dkv9U3xVkizxevtXf1t/wy/JjOX9bJ/IiFspHNE
 m2pFYxdcDw/XtSY2c6J5bKA=
X-Google-Smtp-Source: AGHT+IFe9aaOi9FK6JTOq5RgqJVJSCNA+hftiYEHIoK99/kw9NT4mIfXEdsCGHbZlcySO/iPQrs63g==
X-Received: by 2002:a05:6a00:3688:b0:68c:59cb:2dd9 with SMTP id
 dw8-20020a056a00368800b0068c59cb2dd9mr15961037pfb.1.1695012123449; 
 Sun, 17 Sep 2023 21:42:03 -0700 (PDT)
Received: from [192.168.0.19] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a62ed04000000b0068fb9965036sm6284624pfh.109.2023.09.17.21.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Sep 2023 21:42:02 -0700 (PDT)
Message-ID: <3785ea83-35e4-4f6f-b8b2-72f6b8cd606b@gmail.com>
Date: Mon, 18 Sep 2023 13:41:57 +0900
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42f.google.com
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

On 2023-09-15 16:59, Paolo Bonzini wrote:
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

Thanks for the comment.

ufs-lu took most of its code from scsi-hd, so I completely agree that we 
should make scsi-hd code shareable to reduce code redundancy and make it 
better.


I will fix it and get back to you soon.

Thank you.


Sincerely,

Jeuk


