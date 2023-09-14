Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E317A10F8
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 00:29:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qguov-0005vo-Lb; Thu, 14 Sep 2023 18:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qguot-0005v5-0J; Thu, 14 Sep 2023 18:28:19 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qguor-0003hK-7B; Thu, 14 Sep 2023 18:28:18 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68fba57030fso1412118b3a.3; 
 Thu, 14 Sep 2023 15:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694730495; x=1695335295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S8iTArZtGeAdX5fKAFf03LEg/lDVKveA5Jc4LV6x8Uw=;
 b=LuSl1mNJShmTrBXn317cZyoVA1pM3/IPPO0mdAbK/Ba03GTpL4atg08L65VlEQ/eek
 WqXwH8cfOb9seBhH0TG3DNiAHF8IWRRd9yoVxP1wiOxCSA3cbYKYo74FDk4xRe/WUoJP
 s5PGIxGiJ7QBkLeK8b5hNlcUhATezFuQcgfFz69o0jGc1VgBC6RegOClxwqHxogtBIQp
 HQxFXGK7RJGewhTstsh2FYHUlYsDlfSkETZ33DJByFZtLz/cg7xq8aUoiCSSil4wjQ0X
 v6tETsL52fnY70j+pzoGN8mqTtfNkr+ZxuG1ILZnPQtY9KJ0ZsYmdCxfcOxIMOVhJdFO
 Kwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694730495; x=1695335295;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S8iTArZtGeAdX5fKAFf03LEg/lDVKveA5Jc4LV6x8Uw=;
 b=GdTBGhla0YhoMLbk5RA1D8emH/Wpt54crVLwFLxd08PpFAjF/aCUEw9WZ/RTrC9Vwo
 hS7awAlyP+hTXdtsZl57umyBewv/L8NugTt5LsAdiiiS9YGkfazEdYG7yndak+XGY3jL
 buO5o66/MZQ6gD7BSkNWYQNogB2ciK9ZXAmXrNUjtsVRR3+puiugJbanyfwGxSYDv7/h
 kC/mFCvBcsfH/N+eXciV+tjnsiBbLCHR6IZYq0Tw9GTq25CLZVJwc8vYoGJCR5yKXMwg
 i4S1ZGNUhLKGwDUBBPaVlTF51v3tXu/Xk2HJhfxUvocF9UfV3UjUVuZgs0qsU+Pc6vh9
 ZFMA==
X-Gm-Message-State: AOJu0YzEV1zx4runIhOVRcOiehWbVMUzeXXgZe+zICVG5Wgb3KTH3kYG
 0N2Gb3ybDvR4CnkIl++NcUbCoFqjq7YQjg==
X-Google-Smtp-Source: AGHT+IHozXEHR49L6EGOz7DAC7CjdcXSAG4Uwe9J6SA9fuK4m4wkeL+nFOk+agXgyQUAsAUV4KYX3w==
X-Received: by 2002:a05:6a00:2d8f:b0:68f:dd50:aef8 with SMTP id
 fb15-20020a056a002d8f00b0068fdd50aef8mr7884540pfb.4.1694730495331; 
 Thu, 14 Sep 2023 15:28:15 -0700 (PDT)
Received: from [192.168.0.62] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 18-20020a056a00073200b0067ab572c72fsm1789990pfm.84.2023.09.14.15.28.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 15:28:14 -0700 (PDT)
Message-ID: <da63cc27-2ac9-9d45-52c9-5ad1a0962f9c@gmail.com>
Date: Fri, 15 Sep 2023 07:28:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL 3/5] hw/ufs: Support for Query Transfer Requests
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230907181628.1594401-1-stefanha@redhat.com>
 <20230907181628.1594401-4-stefanha@redhat.com>
 <CAFEAcA8K=TxoqUV-XK+_5KvmKxc+ue7rZ28Sd_yY=V_TVxmMcw@mail.gmail.com>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <CAFEAcA8K=TxoqUV-XK+_5KvmKxc+ue7rZ28Sd_yY=V_TVxmMcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x435.google.com
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


On 23. 9. 14. 23:40, Peter Maydell wrote:
> On Thu, 7 Sept 2023 at 19:17, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> From: Jeuk Kim <jeuk20.kim@samsung.com>
>>
>> This commit makes the UFS device support query
>> and nop out transfer requests.
>>
>> The next patch would be support for UFS logical
>> unit and scsi command transfer request.
>>
>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Message-id: ff7a5f0fd26761936a553ffb89d3df0ba62844e9.1693980783.git.jeuk20.kim@gmail.com
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>   hw/ufs/ufs.h        |  46 +++
>>   hw/ufs/ufs.c        | 988 +++++++++++++++++++++++++++++++++++++++++++-
>>   hw/ufs/trace-events |   1 +
>>   3 files changed, 1033 insertions(+), 2 deletions(-)
> Hi; Coverity isn't happy about the code in this function
> (CID 1519050). The code isn't strictly wrong, but it's
> probably possible to make it a bit more clearly correct.
>
>> +static void ufs_process_db(UfsHc *u, uint32_t val)
>> +{
>> +    unsigned long doorbell;
>> +    uint32_t slot;
>> +    uint32_t nutrs = u->params.nutrs;
>> +    UfsRequest *req;
>> +
>> +    val &= ~u->reg.utrldbr;
>> +    if (!val) {
>> +        return;
>> +    }
>> +
>> +    doorbell = val;
>> +    slot = find_first_bit(&doorbell, nutrs);
> Here we pass the address of a single 'unsigned long' to
> find_first_bit(). That function operates on arrays, so
> unless nutrs is guaranteed to be less than 32 this might
> walk off the end of memory.
>
> There is a check on params.nutrs in ufs_check_constraints(),
> which checks for "> UFS_MAX_NUTRS" and that value is 32,
> so this won't actually overflow, but Coverity can't
> see that check and in any case what it really doesn't
> like here is the passing of the address of a 'long'
> variable to a function that is prototyped as taking
> an array of longs.
>
> You can probably make Coverity happy by defining
> doorbell here as a 1 element array, and asserting
> that nutrs is 32 or less. Alternatively, we have
> ctz32() for working through bits in a uint32_t, though
> that is a bit lower-level than find_first_bit/find_next_bit.
>
>> +
>> +    while (slot < nutrs) {
>> +        req = &u->req_list[slot];
>> +        if (req->state == UFS_REQUEST_ERROR) {
>> +            trace_ufs_err_utrl_slot_error(req->slot);
>> +            return;
>> +        }
>> +
>> +        if (req->state != UFS_REQUEST_IDLE) {
>> +            trace_ufs_err_utrl_slot_busy(req->slot);
>> +            return;
>> +        }
>> +
>> +        trace_ufs_process_db(slot);
>> +        req->state = UFS_REQUEST_READY;
>> +        slot = find_next_bit(&doorbell, nutrs, slot + 1);
>> +    }
>> +
>> +    qemu_bh_schedule(u->doorbell_bh);
>> +}
> thanks
> -- PMM
>

Thank you for letting me know about the coverity issue with a detailed 
description!

I have checked all the coverity issues related to ufs.
(cid 1519042, cid 1519043, cid 1519050, cid 1519051)

I will fix them with an additional patch as soon as possible.

Thank you!

Jeuk


