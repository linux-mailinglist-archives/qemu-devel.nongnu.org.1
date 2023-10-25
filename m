Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A253B7D6159
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 07:57:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvWsV-0000CJ-Vp; Wed, 25 Oct 2023 01:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvWsS-00006j-Pk
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:56:25 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvWsQ-0005qP-Kj
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:56:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32d9effe314so3579739f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 22:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698213380; x=1698818180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zs2gbkRDyur7pDchslP/aRzZiddSMfd3l/SL3nFyX28=;
 b=QJ5XiLzBDE/dzYlujhgMa45B5is7hiZbFXCfBbuyxmVPkbSvAqVzjSDwh5jdP7lvEO
 gVKrwoYKUE5WzzEBF+zxT4n1xDbkpXFSBW/e0HfdbWEHuNz0SR4v1PQy6VJIsS5tvZrn
 782VC/Vqb1UKPuiqVJIb53frQrtv16/I8KLopveorOlrxy/Aa057L78Po/aN+1NSM1NT
 R4VKShvQXI+Q/lRetIVhGpJDin0++kiBAiaaza7PUDdFMJMrDXaMQurItI8cEKmQJy5U
 ZkOLH1Z7HR8FGIJ5LT+IoJfaK0bB1OPeWNK1p9kpCTje6QneqQE9Ii5sqjeRTDZGymd/
 Xs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698213380; x=1698818180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zs2gbkRDyur7pDchslP/aRzZiddSMfd3l/SL3nFyX28=;
 b=ezA0cj1IanrS6eTwa52RDR9liMwAurA/ro6LykYSdVR7Sb4MqzJWZScvWHFa+NKJqP
 rbqvWokiPpkZsLTcRemUy4Wdov33/Lw40u1spw9VpPdaeQFljNqE7KIznDCZKDgxW3lq
 VbGHSc/Jupibxtp94hKaBIGY57pzJ42tjnt21hcN4jX5zFE7e3vCQp3BJgC1do0iXRGf
 9QKM1eb0fk5Wq4T24lMEfnCIo7VL1bIk5bhO8fdJXsNdBnsbtL4DyPsIRfeCYdBrqLa7
 VYU4q+iqOel3Vm/ggqGpSHXfeBfVOpjwwprGmst5MKsRUurIJgFOwaWUVBQ3rXHY9Hr2
 e9Gg==
X-Gm-Message-State: AOJu0YxzeNz55x4MWtEDuNTkuGMmmN/I3H5L+0GWopuFf0F2fiGneZ3g
 +/AHXP7naIil3GNdeAec8bbWYg==
X-Google-Smtp-Source: AGHT+IFwV3DobD21uGM0FXN6Tbc8qhFQQ3RNRMrGncB1heXMwwTT3NCxlhg2JTW5kfdAQ+x9nTvYyQ==
X-Received: by 2002:a5d:5744:0:b0:32d:82d8:3442 with SMTP id
 q4-20020a5d5744000000b0032d82d83442mr8044347wrw.53.1698213380397; 
 Tue, 24 Oct 2023 22:56:20 -0700 (PDT)
Received: from [192.168.69.115] (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 p7-20020a5d4587000000b0032db430fb9bsm11280228wrq.68.2023.10.24.22.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 22:56:20 -0700 (PDT)
Message-ID: <98eb2407-8612-c617-ec80-a6ac1ddda3fd@linaro.org>
Date: Wed, 25 Oct 2023 07:56:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/8] PMBus fixes and new functions
To: Titus Rwantare <titusr@google.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, minyard@acm.org, qemu-devel@nongnu.org
References: <20231023180837.91785-1-titusr@google.com>
 <874jih40a3.fsf@linaro.org>
 <CAMvPwGpXZxyoX1WNypgNCW+Uj+bcVPn99vF71Myx7jn_c2Fjdg@mail.gmail.com>
 <87zg082twp.fsf@linaro.org> <c87866ad-568b-1917-7617-c63b137a196a@linaro.org>
 <CAMvPwGpyE0BVKJVEo+bZsQz99W_O61fW4TzEwm7A6bCd0bsJ0g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAMvPwGpyE0BVKJVEo+bZsQz99W_O61fW4TzEwm7A6bCd0bsJ0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 24/10/23 18:07, Titus Rwantare wrote:
> On Tue, 24 Oct 2023 at 04:50, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 24/10/23 12:06, Alex Bennée wrote:
>>
>>> A pull request is really just a GPG signed tag that you push to a repo.
>>> You can use the existing git tooling to create the cover letter for it.
>>>
>>> I've included my exact steps at the end of the email but really it comes
>>> down to:
>>>
>>>     git tag --sign your-pr-tag
>>>     git push your-pr-tag
>>>     git format-patch <series details>
>>>     git request-pull origin/master your_repo_details your-pr-tag
>>>
>>> and finally
>>>
>>>     git send-email
>>>
>>> My personal exact steps are integrated with my editor but are:
>>
>>
>>> 8 Preparing a QEMU Pull Request
>>> ═══════════════════════════════
>>
>>> 9 And send the pull request
>>> ═══════════════════════════
>>
>> For these steps I just do:
>>
>> $ git publish -b origin/master \
>>       --pull-request --sign-pull --keyid=0xMYKEY
>>
>> which uses .gitpublish from commit 08bb160e02,
>> calling get_maintainer.pl for each patch.
>>
>> Using GSuite, I also have in ~/.gitconfig:
>>
>> [sendemail]
>>       smtpServer = smtp.gmail.com
>>       smtpBatchSize = 1
>>       smtpReloginDelay = 3
> 
> Thanks all, I'll do some dry runs to walk through these approaches.

Tell me if you want me to unqueue your v4, otherwise I'll send a PR
with it in a few days.

Regards,

Phil.


