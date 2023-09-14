Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 108E77A10DB
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 00:20:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgugO-0006Ac-3y; Thu, 14 Sep 2023 18:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qgugK-000694-Kb; Thu, 14 Sep 2023 18:19:28 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qgugI-0001vi-Bo; Thu, 14 Sep 2023 18:19:28 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68fbb10dec7so1362428b3a.3; 
 Thu, 14 Sep 2023 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694729964; x=1695334764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LzhWTu4lS5kGUJhMfDONX7tYBkJw0NgyLAdBVf5/Y04=;
 b=RCRMHrgBoi6cFdrrvRn61zmWMN9e4ssQYt3GZ7Y2zENVgWVSBh8Tp86//0WvQMK0DO
 rNl9wm+n/onaX1r2h75mS7SybXMDk4TPAlfDRtefvGi5XR/cw7JYEvDhXQurjy4bj1cU
 QQ5KhUC4PMWZG4azy5gST/ZO6myU9Xz33xdCvbGHqvOeXw7SuQVH07dCwxeVgpSUaIae
 RbXi/WOlIk6T4pXCgWIYeXpl52E+mNXsYZVHHEdXQJyTcSL+Y+tjauZr5Jn2NNjISX91
 7VZsrR+abefBNQ4h+so8MYtA4Ff6AJ2NhYM7vL02i/5I0jR1qFM2qXwOMCqUWGpYobvm
 ak0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694729964; x=1695334764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LzhWTu4lS5kGUJhMfDONX7tYBkJw0NgyLAdBVf5/Y04=;
 b=TWY8wLiHAkG2zykJVn5x2bDHKZM2QqvcWKyjzKxnhULTtdkb3gGen07uhNSiuZMrVK
 aaXeMAShTMWPwZKQRjS5IrKpgilEcDJEMtQNQS6A5wOtpK437Yl5Vc4YG9Lz6/nkse8Z
 wSWpRLUgdon2wOtRut9VPQ3OJ7b2eKZf5an1lKwB6TyiZAd0c7ChN2gR31DkP0KXZZFT
 a7/WEgbCdmBY+/SjTFFFKoT4R6WF/5D40kBX/bPZcozg/lknD3jvih0M4djtpUvqluoB
 4jfgsgnzv+V1FzLhdCGtH7ShSwGa2FWQW7Ok9ZPW8NR72y35Bv57KKxcm4ujgzRN+wUS
 rxuQ==
X-Gm-Message-State: AOJu0YxZhAPu040ykAkGGSjuLGQ1FuxHQbcZyBPA+ye/Axq/jfauKBgo
 m/U03lnlhzivziGgIei4oc0=
X-Google-Smtp-Source: AGHT+IFQb0X3v5CkEzhbLediqd1V7oGJR6cZ4K8BzCgsdftiMFmLZ+GnuPOXiEXT8+ztwKOGKMin2A==
X-Received: by 2002:a05:6a20:394f:b0:14c:d105:2a59 with SMTP id
 r15-20020a056a20394f00b0014cd1052a59mr121029pzg.55.1694729963966; 
 Thu, 14 Sep 2023 15:19:23 -0700 (PDT)
Received: from [192.168.0.62] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a170902b48a00b001bdc8a5e96csm2075236plr.169.2023.09.14.15.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 15:19:23 -0700 (PDT)
Message-ID: <160581dc-bdbc-03e8-64a5-1adb818a15b2@gmail.com>
Date: Fri, 15 Sep 2023 07:19:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL 4/5] hw/ufs: Support for UFS logical unit
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230907181628.1594401-1-stefanha@redhat.com>
 <20230907181628.1594401-5-stefanha@redhat.com>
 <c4dc2292-4690-f16f-4b70-d6f759c16633@redhat.com>
Content-Language: en-US
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <c4dc2292-4690-f16f-4b70-d6f759c16633@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 23. 9. 15. 02:31, Paolo Bonzini wrote:
> On 9/7/23 20:16, Stefan Hajnoczi wrote:
>> From: Jeuk Kim<jeuk20.kim@samsung.com>
>>
>> This commit adds support for ufs logical unit.
>> The LU handles processing for the SCSI command,
>> unit descriptor query request.
>>
>> This commit enables the UFS device to process
>> IO requests.
>>
>> Signed-off-by: Jeuk Kim<jeuk20.kim@samsung.com>
>> Reviewed-by: Stefan Hajnoczi<stefanha@redhat.com>
>> Message-id:beacc504376ab6a14b1a3830bb3c69382cf6aebc.1693980783.git.jeuk20.kim@gmail.com 
>>
>> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
>> ---
>
> Jeuk,
>
> can you explain the differences between scsi-hd and ufs-lu, apart from 
> the different bus type?  Ideally, the UFS controller would be in 
> hw/scsi/ufs.c and there would be no need for ufs-lu at all.
>
> Would it make sense to allow any SCSI device into a UFS bus without 
> the need to have duplicate code?
>
> Thanks!
>
> Paolo
>
>

Hi Paolo,


While ufs does use the SCSI specification to communicate with the driver,

it doesn't behave exactly like a typical scsi device.


First, ufs-lu has a feature called "unit descriptor". This feature shows 
the status of the ufs-lu

and only works with UFS-specific "query request" commands, not SCSI 
commands.


UFS also has something called a well-known lu. Unlike typical SCSI 
devices, where each lu is independent,

UFS can control other lu's through the well-known lu.


Finally, UFS-LU will have features that SCSI-HD does not have, such as 
the zone block command.


In addition to this, I wanted some scsi commands to behave differently 
from scsi-hd, for example,

the Inquiry command should read "QEMU UFS" instead of "QEMU HARDDISK",

and the mode_sense_page command should have a different result.


For these reasons, I chose to generate the ufs-lu code separately.


Please let me know if you have any comments on this.


Thanks!

Jeuk


