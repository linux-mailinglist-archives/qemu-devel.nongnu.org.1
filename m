Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D707A4037
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 06:52:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi6F5-0005pM-Ti; Mon, 18 Sep 2023 00:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qi6F3-0005or-OI; Mon, 18 Sep 2023 00:52:13 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qi6F2-00042A-4w; Mon, 18 Sep 2023 00:52:13 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5774b3de210so2950791a12.0; 
 Sun, 17 Sep 2023 21:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695012730; x=1695617530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2VBcZvFPFUuDp4m95guaYObwAsWYnqqHpQRw99mgtuU=;
 b=WUUC1noViXsywKn7VvSND2MNCR8Ye+rl/c5gm1oQuI+42DNvNk7HGCpjRXyoiu5SbH
 W0VIbivqIvAa7bxH51yct4v0UUPn2ll1QjTLZ905QfSiLsmspKAjRakzXIf4XR8J6SVB
 Wojq5y7fN/ySvt+OZHhsqkCNmecCJ2gOrChKohvYYbTONC69GCodCdxhjemnsa8l5IK2
 H0o3OTmFa5juYHf161iKEyWfoH3U08LTMWs6V2uRcPQUorIsPCF/l2hfwY4ElkLVUbSs
 Q5uTMyFVxnSgdpvXaJUm3Ek/dKTeQ8Z94mxGJdyqLB3ZDa39Id0tXgL3Hr70FXeayo+n
 g+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695012730; x=1695617530;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2VBcZvFPFUuDp4m95guaYObwAsWYnqqHpQRw99mgtuU=;
 b=A5Pgmc1FyXPnqv2MFsdJeWiC0QO/We00a5vCLw6dC32G8qfDLpIHFYvmItpX4b0fJq
 jUv9iNJVTinH0mNRebu0tUEitYZl3Fdt21hH71jb/ebMNSRyTkAZfwthfPTGdAbE4UOk
 RQ8cS3AAjf2CZlT2hpENCfBh4z5EKHQeeMkSQ31HSvMAwRxtZvWfHiOXToDjx/1uW2CR
 gzs4JelurcrtUIi8GcjMd37wqEvVjEHcY8l9QxfM+Vus7e/WkhmYZPVT7ReNgfqdZhij
 1prWuvss0+kwy2Lw7h43ukC/AcMY4dGWXjZYeokWLxiJvPPnPHHbdZjQaPXBxjtnrzK4
 p/Tg==
X-Gm-Message-State: AOJu0Yw+0w8bJR1GCpcDtknDLZCAJiP3I99JZz+wEQME0Fw8EGUzGRs6
 TjKL6XJvXXtC2Vq4pgFV1uY=
X-Google-Smtp-Source: AGHT+IEfr10UJFEthM78RAo1Jc+VEEghgxLAC3hwRoa8ZtopQ14f/3k/A7SJUeeZAziHUnmYMMPEbQ==
X-Received: by 2002:a05:6a20:12ce:b0:137:2f8c:fab0 with SMTP id
 v14-20020a056a2012ce00b001372f8cfab0mr8892111pzg.49.1695012730079; 
 Sun, 17 Sep 2023 21:52:10 -0700 (PDT)
Received: from [192.168.0.19] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 a26-20020aa780da000000b0068ff267f094sm6369978pfn.158.2023.09.17.21.52.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Sep 2023 21:52:09 -0700 (PDT)
Message-ID: <a8cef5cb-41f4-4652-a22d-bc2b2a17877e@gmail.com>
Date: Mon, 18 Sep 2023 13:52:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 4/5] hw/ufs: Support for UFS logical unit
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
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
 <3785ea83-35e4-4f6f-b8b2-72f6b8cd606b@gmail.com>
In-Reply-To: <3785ea83-35e4-4f6f-b8b2-72f6b8cd606b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x52a.google.com
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


On 2023-09-18 오후 1:41, Jeuk Kim wrote:
> On 2023-09-15 16:59, Paolo Bonzini wrote:
>> On 9/15/23 00:19, Jeuk Kim wrote:
>>> First, ufs-lu has a feature called "unit descriptor". This feature 
>>> shows the status of the ufs-lu
>>>
>>> and only works with UFS-specific "query request" commands, not SCSI 
>>> commands.
>>
>> This looks like something that can be implemented in the UFS subsystem.
>>
>>> UFS also has something called a well-known lu. Unlike typical SCSI 
>>> devices, where each lu is independent,
>>> UFS can control other lu's through the well-known lu.
>>
>> This can also be implemented in UfsBus.
>>
>>> Finally, UFS-LU will have features that SCSI-HD does not have, such 
>>> as the zone block command.
>>
>> These should be implemented in scsi-hd as well.
>>
>>> In addition to this, I wanted some scsi commands to behave 
>>> differently from scsi-hd, for example,
>>> the Inquiry command should read "QEMU UFS" instead of "QEMU HARDDISK",
>>> and the mode_sense_page command should have a different result.
>>
>> Some of these don't have much justification, and others (such as the 
>> control page) could be done in scsi-hd as well.
>>
>> We should look into cleaning this up and making ufs-lu share a lot 
>> more code with scsi-hd; possibly even supporting -device scsi-hd with 
>> UFS devices.  I am not going to ask you for a revert, but if this is 
>> not done before 8.2 is out, I will ask you to disable it by default 
>> in hw/ufs/Kconfig.
>>
>> In the future, please Cc the SCSI maintainers for UFS patches.
>>
>> Paolo
>>
>
> Thanks for the comment.
>
> ufs-lu took most of its code from scsi-hd, so I completely agree that 
> we should make scsi-hd code shareable to reduce code redundancy and 
> make it better.

Sorry about it. This sentence is misleading.

I meant to say "I completely agree that ufs-lu should be made to reuse 
scsi-hd code to reduce code redundancy and improve code quality."


>
> I will fix it and get back to you soon.
>
> Thank you.
>
>
> Sincerely,
>
> Jeuk
>

Thanks


