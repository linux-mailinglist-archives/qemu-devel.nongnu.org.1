Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 707FA7BE537
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 17:43:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpsP4-0002yH-SC; Mon, 09 Oct 2023 11:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpsOs-0002qf-VI
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 11:42:38 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpsOg-00060B-Gu
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 11:42:29 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9b98a699f45so791496166b.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696866131; x=1697470931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rWZCwOZYscrw8dxHQIhyBz0e+KNg7KBY8wsd9k22CKM=;
 b=MimuD69ywIHojewV9QpO5vrAqEMeUJOFIPoaHo4Q70lQWvJwi1yzXbhUndJK51FmBr
 H+qOQ4hWiGoR5eS35mfamj9qEYfBNAGQa+GcgTCeVq/ffth9IKLak+gOcYkthCMZcWMi
 zdqcU0n0x6TnAMIbyurPvBx6NtHw4aA7YeSsjr/4OhMgTZkf7MeIY31qzU20A7FvcFXi
 4EIN/XIu8cEXa7LRFsAEV1sT95ugrk8oRFa4FTvHTNc7WiWe0u4Tt2Fm+4Brebk/hW+K
 s0k19PI5AXlJP53/ESS3RRl1SZeoOTm6Q7fHIkf6tOsP7w0QcGI3i3OKhySpa2Q0nZp0
 KsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696866131; x=1697470931;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rWZCwOZYscrw8dxHQIhyBz0e+KNg7KBY8wsd9k22CKM=;
 b=UrZoYDzQcNnNWa8W6UDtGfHhGoxcps4KfFxQZ6qgJrojQ4S4t3AL2bjtFfBO5GZoZY
 JNbERTsWzJvsygxWHPhzSHSrBGawpBiwgNRddXcY9MAg91D1PSJXIM3Ef2NAmtukCBAD
 sVHKlBmZG8hdC8MwzH3gA/tMrGUdaZFZ08di23J/rTWg6tcMpeYzJcaIqUgRctOslEcq
 eJmeZi9jNS1h78TYJQXaHqfVlclpO9HHDpAVj5WE3iLnRDEO/ttSOiRSLGNAN1uCffNK
 pVC8ewquzSEAsZTZ/SCtYrGa5rUKlJDVPn8t3bjF8lLupfTrI3YsrvnUImy8G9qcExso
 su/A==
X-Gm-Message-State: AOJu0Yx4diviZDb2gCtkuUceRdAPHn48vjHMkuKazHqSUbzB9m0qDo5j
 8lGRalyZ/Pytqv0/yu/ThDfO1Q==
X-Google-Smtp-Source: AGHT+IGTrIDYr3elkjuRj3GQSKSxxqK3ZMj05TqPIdYsLEgNENwoCFjnoGtsWN3ycLTaHq4OfCoVcg==
X-Received: by 2002:a17:906:1dd:b0:9ae:540c:90ef with SMTP id
 29-20020a17090601dd00b009ae540c90efmr13905367ejj.18.1696866130659; 
 Mon, 09 Oct 2023 08:42:10 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 dx8-20020a170906a84800b0099cbfee34e3sm6844789ejb.196.2023.10.09.08.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 08:42:10 -0700 (PDT)
Message-ID: <bd91f495-296a-a791-63bd-7827228af4e9@linaro.org>
Date: Mon, 9 Oct 2023 17:42:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] migration: Use g_autofree to simplify
 ram_dirty_bitmap_reload()
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>
References: <20231008114001.95348-1-philmd@linaro.org> <871qe3g7gn.fsf@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <871qe3g7gn.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 9/10/23 17:07, Fabiano Rosas wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Based-on: <ZR7e3cmxCH9LAdnS@x1n>
>> ---
>>   migration/ram.c | 15 ++++++---------
>>   1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 982fbbeee1..4cb948cfd0 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -4164,11 +4164,11 @@ bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
>>   {
>>       /* from_dst_file is always valid because we're within rp_thread */
>>       QEMUFile *file = s->rp_state.from_dst_file;
>> -    unsigned long *le_bitmap, nbits = block->used_length >> TARGET_PAGE_BITS;
>> +    unsigned long *le_bitmap = NULL;
> 
> Aren't you missing the actual g_autofree here?

Argh 🤦🏻 sorry...


