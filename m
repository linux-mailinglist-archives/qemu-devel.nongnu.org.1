Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C58F7D8DF2
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 07:03:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwEyV-0002cT-JU; Fri, 27 Oct 2023 01:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwEyQ-0002bH-6m
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 01:01:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwEyO-00066T-HQ
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 01:01:29 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso9402765e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 22:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698382886; x=1698987686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WPGwRBlQCh/G+BwS0q6D9PppWERqITp/FFC1pgEn2/8=;
 b=apSgPhGdHGK5Q8LHJk22oFmq3UGDTH4sCgZCst4G/cQ4/EW0jQkMi6MsTK4/khboyC
 XLkgzr4wgrXdsTp12y8xphP51SJ9jADeoo9AK1NnGhlp4osCuqO54pqF91VB1Wkle776
 Au+iF5jYu1JOKaFn1aOH23N7iAdRJnO8W9KLh7JLZRCgRGKwdRUeb2wkbh6+J5X/KqKE
 c4DVfej3pByrmPXcb775+TUUuCFRFAUPfP0XG3H67gF5JPv0Uokh6V6yH0QoGjmWkRdo
 wO8LEp49DSyKgwWm49KYi/W3+qpzrDYm3Sjsg0TjfEXbjCnwQsw6fUsrsdzMreNvtCbL
 2zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698382886; x=1698987686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WPGwRBlQCh/G+BwS0q6D9PppWERqITp/FFC1pgEn2/8=;
 b=jcBHFCiN22EKVZEfgj6xEQNAK/V+Mnj59JVXXvrdbcurMXEXhSAgR0xJ2s43LiMlFU
 Qe40EM/VfYM83I11Aj/nuCrVcW405qP+WYfcBTavR4fFBBNmfvuq3WWOuCy4wK4dD89b
 AAJlxHBEIE7rqiD515+kyGmz74rx0ubYb1om6zED2oTOB4dQojdjoWMv7/frE1tLcAWX
 sijk11viaSR+GoCsbDDPwJZ6RYz2bm7xYjOADD3LFf7xWznCc7pvVIHQpVTDk4Uk7iOI
 Iadm0n6iy2U3YVk/QUrICeHTGjqFxAXkB+K5hXVDUQhLMlyADcVmxlBsqb4JzxnXfCyl
 YomQ==
X-Gm-Message-State: AOJu0YxwuzVyA+kV0yNYfE2PjofXdn4sTXpJmPpYfzf4y3Wq51aB20+6
 8oxdxDJ0OH0PXJ1gJgyr+CS75g==
X-Google-Smtp-Source: AGHT+IE2vWa8CgYbmrmal8BdAhSDOCQck6LPLKAUxSloFaBUO/ZkGcHsiLoKMJlmzLEpVrZMH8nG9Q==
X-Received: by 2002:a05:600c:46cc:b0:402:ea8c:ea57 with SMTP id
 q12-20020a05600c46cc00b00402ea8cea57mr1860927wmo.7.1698382886551; 
 Thu, 26 Oct 2023 22:01:26 -0700 (PDT)
Received: from [192.168.69.115] ([176.171.220.131])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a05600c358800b0040472ad9a3dsm662916wmq.14.2023.10.26.22.01.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 22:01:26 -0700 (PDT)
Message-ID: <a66db343-9938-fee7-465b-59f7cad5e542@linaro.org>
Date: Fri, 27 Oct 2023 07:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/3] vfio/pci: Fix buffer overrun when writing the VF
 token
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev"
 <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20231026070636.1165037-1-clg@redhat.com>
 <8a9d26d0-ccb4-448b-9fc2-d7ce521646ae@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <8a9d26d0-ccb4-448b-9fc2-d7ce521646ae@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 26/10/23 16:00, Cédric Le Goater wrote:
> On 10/26/23 09:06, Cédric Le Goater wrote:
>> Hello,
>>
>> This series fixes a buffer overrun in VFIO. The buffer used in
>> vfio_realize() by qemu_uuid_unparse() is too small, UUID_FMT_LEN lacks
>> one byte for the trailing NUL.
>>
>> Instead of adding + 1, as done elsewhere, the changes introduce a
>> UUID_STR_LEN define for the correct size and use it where required.
> 
> Cc: qemu-stable@nongnu.org # 8.1+

Hopefully 8.2 shouldn't be affected ;)

> 
> I propose to take this series in vfio-next if no one objects.
> 
> Thanks,
> 
> C.


