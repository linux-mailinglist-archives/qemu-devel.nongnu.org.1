Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BB27939A3
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 12:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdpYv-0007JG-B4; Wed, 06 Sep 2023 06:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdpYt-0007Ix-T5
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 06:15:03 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdpYq-00005g-1U
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 06:15:03 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9a65f9147ccso375543666b.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 03:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693995296; x=1694600096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LHH3txj+LcTxQpIbFUguC22IeIYbRGyEtFv5HHdt6hg=;
 b=T3gbC3Fj434zYkPaLhh+H5cksv8Zlkw77FHNbcPrNdRbYAfky8OUcqZJbAh76uDN2z
 s19z/WrCcOF2xHOy5Ebxzpgl0OVXFa67J+0x3EgOMH3nulQI+kMcLyIVb8XFv1fql8zd
 W1m98URMJ4w90fPxICFEI+mGaln2lVwnaoORtoBI4TrbWq5C0V7ZHRXIz1UKjaSjAV/P
 qwc0lAROh+abyA8Y4GzINF0Oi2b3NDi0BpEXDS7CIZn39dfIMBc9vQfT938Tkr6OtYId
 DHqE9SPRy8JvXQbRdZ2KfgyplGRjgc+T26AD4F9VvMGQqAWv0ZPj6Uyp9klxBUCy91Aw
 3zrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693995296; x=1694600096;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LHH3txj+LcTxQpIbFUguC22IeIYbRGyEtFv5HHdt6hg=;
 b=Va043VvBrqgFGz1iKetCkAp6EN3UZBLGKJsl4WNJpul8PLHr0kO4ZSulwpqagjFxwM
 aHNQFx5Vr5lKSwDav96eYtczLBy3vkJEtTQ7PSt4ClgUgvXDG6LjPeLxqzhPz3ODPmzb
 D/fT9RhBdGrrQLUityBL5IMFvgRFbnm062/td3xAfGXnjY45nfg5QX5S34HwSGFTKvp8
 w6TVlVP+o35nTmu9sTLXsDTdiLVlDx2T3ZIXu3RY0DPNH3MYYuulRi6/6FpDIJvMTDlf
 SFDMfJiJmSXdkgJrBkvwQ/ap6O0GbmSObBR7SxMn2wvWulWH71ImHtcVsATlFdQQl/mP
 Oj1g==
X-Gm-Message-State: AOJu0Yz6mFBUpj2RE8c4Nz2/BjBIagcxqJkdzLIuxBk5BBXumJQ5ZBI2
 j4tfAnNYymFL2Fdro8sAbVVx1w==
X-Google-Smtp-Source: AGHT+IERC4nli+mDJaAWRySum5zJzgqipp5W+Pn09pNapAM2DVOnIYTD3zF0lhPH0X5cHZh4kqWy+w==
X-Received: by 2002:a17:906:3155:b0:99b:c038:fdac with SMTP id
 e21-20020a170906315500b0099bc038fdacmr1851946eje.20.1693995296626; 
 Wed, 06 Sep 2023 03:14:56 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 lt20-20020a170906fa9400b009a193a5acffsm8690033ejb.121.2023.09.06.03.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 03:14:56 -0700 (PDT)
Message-ID: <2edd3a6f-f23d-9a77-db47-4288fe3dbb44@linaro.org>
Date: Wed, 6 Sep 2023 12:14:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 4/4] migration/qapi: Drop @MigrationParameter enum
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-5-peterx@redhat.com>
 <c5937e59-e267-519a-cf57-bf051b07304f@linaro.org>
 <ZPg/xagpvBW62h4w@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZPg/xagpvBW62h4w@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 6/9/23 11:00, Daniel P. Berrangé wrote:
> On Wed, Sep 06, 2023 at 06:42:16AM +0200, Philippe Mathieu-Daudé wrote:
>> On 5/9/23 18:23, Peter Xu wrote:
>>> Drop the enum in qapi because it is never used in QMP APIs.  Instead making
>>> it an internal definition for QEMU so that we can decouple it from QAPI,
>>> and also we can deduplicate the QAPI documentations.
>>>
>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    qapi/migration.json            | 179 ---------------------------------
>>>    migration/options.h            |  47 +++++++++
>>>    migration/migration-hmp-cmds.c |   3 +-
>>>    migration/options.c            |  51 ++++++++++
>>>    4 files changed, 100 insertions(+), 180 deletions(-)
>>
>>
>>> diff --git a/migration/options.h b/migration/options.h
>>> index 124a5d450f..4591545c62 100644
>>> --- a/migration/options.h
>>> +++ b/migration/options.h
>>> @@ -66,6 +66,53 @@ bool migrate_cap_set(int cap, bool value, Error **errp);
>>>    /* parameters */
>>> +typedef enum {
>>> +    MIGRATION_PARAMETER_ANNOUNCE_INITIAL,
>>> +    MIGRATION_PARAMETER_ANNOUNCE_MAX,
>>> +    MIGRATION_PARAMETER_ANNOUNCE_ROUNDS,
>>> +    MIGRATION_PARAMETER_ANNOUNCE_STEP,
>>> +    MIGRATION_PARAMETER_COMPRESS_LEVEL,
>>> +    MIGRATION_PARAMETER_COMPRESS_THREADS,
>>> +    MIGRATION_PARAMETER_DECOMPRESS_THREADS,
>>> +    MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD,
>>> +    MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD,
>>> +    MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL,
>>> +    MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT,
>>> +    MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW,
>>> +    MIGRATION_PARAMETER_TLS_CREDS,
>>> +    MIGRATION_PARAMETER_TLS_HOSTNAME,
>>> +    MIGRATION_PARAMETER_TLS_AUTHZ,
>>> +    MIGRATION_PARAMETER_MAX_BANDWIDTH,
>>> +    MIGRATION_PARAMETER_DOWNTIME_LIMIT,
>>> +    MIGRATION_PARAMETER_X_CHECKPOINT_DELAY,
>>> +    MIGRATION_PARAMETER_BLOCK_INCREMENTAL,
>>> +    MIGRATION_PARAMETER_MULTIFD_CHANNELS,
>>> +    MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE,
>>> +    MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH,
>>> +    MIGRATION_PARAMETER_MAX_CPU_THROTTLE,
>>> +    MIGRATION_PARAMETER_MULTIFD_COMPRESSION,
>>> +    MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL,
>>> +    MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL,
>>> +    MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING,
>>> +    MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD,
>>> +    MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT,
>>> +    MIGRATION_PARAMETER__MAX,
>>
>> MIGRATION_PARAMETER__MAX is not part of the enum, so:
>>
>>     #define MIGRATION_PARAMETER__MAX \
>>         (MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT + 1)
> 
> IMHO the way it currently is written is better, because the
> __MAX value is guaranteed to always have the right max value
> without needing to be manually changed when new params are
> added. Note this matches the code style used by the QAPI
> enum generator too.

This concern comes from a previous discussion with Richard (which I
can't find now in the archives) where he explained to me __MAX is not
part of the enum set, thus reduces the coverage of compiler sanitizers
/ optimizers, and could introduce subtle bugs.

This motivated this series:
https://lore.kernel.org/qemu-devel/20230315112811.22355-4-philmd@linaro.org/
which should have changed that generated QAPI enum.

(I didn't respin that series because I couldn't find an easy way to
  handle conditionals, see
  https://lore.kernel.org/qemu-devel/87sfdyaq0m.fsf@pond.sub.org/)

Back to this patch, I don't object to having MIGRATION_PARAMETER__MAX
in the enum, but I'd rather have the suggestion below considered.

Thanks,

Phil.

> 
>>
>>> +} MigrationParameter;
>>> +
>>> +extern const char *MigrationParameter_string[MIGRATION_PARAMETER__MAX];
>>> +#define  MigrationParameter_str(p)  MigrationParameter_string[p]
>>
>> Hmm this is only used once by HMP. Following our style I suggest here:
>>
>>   const char *const MigrationParameter_string(enum MigrationParameter param);
>>
>> And in options.c:
>>
>>   static const char *const MigrationParameter_str[MIGRATION_PARAMETER__MAX] =
>> {
>>      ...
>>   };
>>
>>   const char *const MigrationParameter_string(enum MigrationParameter param)
>>   {
>>       return MigrationParameter_str[param];
>>   }
>>
>>> +
>>> +/**
>>> + * @MigrationParameter_from_str(): Parse string into a MigrationParameter
>>> + *
>>> + * @param: input string
>>> + * @errp: error message if failed to parse the string
>>> + *
>>> + * Returns MigrationParameter enum (>=0) if succeed, or negative otherwise
>>> + * which will always setup @errp.
>>> + */
>>> +int MigrationParameter_from_str(const char *param, Error **errp);
>>> +
>>>    const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
>>>    bool migrate_has_block_bitmap_mapping(void);
>>
>> With the changes:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> 
> With regards,
> Daniel


