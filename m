Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C507CC9A4
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 19:16:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsnfF-0007v2-Hb; Tue, 17 Oct 2023 13:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsnfC-0007us-V3
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsnfB-0003U3-CB
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697562924;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FjODC1oe92c3FP0AUPkq7WMZRRc7VPEvFqje6RM3MAc=;
 b=P/H3xD0l1iNDLRfQrAjM5fbWkXbG1HYN2b9cUpVdveoCT0qRc3drP8nEtuTxiqHdZOlx6A
 /SVvRkUMTZ1d0IfTTHqETJ13O22YTOr1UnFdmJ4PU153oigN2KYdlv7e1ewU0V1jdjNl9s
 PyPv0AqcXega7MgtVvQax/cxPKPf/m8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-rTACFtp4NaiCLMJ4ubL_vg-1; Tue, 17 Oct 2023 13:15:19 -0400
X-MC-Unique: rTACFtp4NaiCLMJ4ubL_vg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507b92b4346so1578364e87.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 10:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697562917; x=1698167717;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FjODC1oe92c3FP0AUPkq7WMZRRc7VPEvFqje6RM3MAc=;
 b=F1ilpUDF6l5FTTYO7yCBOhU8s4ttGOtjHwV0l6J4pd3UiU3jg09ny2OX51I2DyO0Xq
 ov/ho49Si2Lk6bhSd+4BdK0Bj5tp3UBzPZbNDDaN/y9QqfzBho9TOcNPHFbU0Fl2B+iS
 0cmKs0Q2ZI5WYXnDqZfQWygKuEmP/eRTLuQQNtgPZhxOWBC/TlFH6sUuCfznLhvuQhOz
 CTSCr+y/XiRgXL/H11uMreZOb3u9FW6JaZZk4mAWyGVLfG/3Ev7aIzUeVO5d4zpjX1Rz
 Fnr/skdDpr1qWCYSxZuPH6vzkyJI4zLcKIBIT8tK9gyjPMnVaHr1vu7UP9ISMpttFJLJ
 4YFA==
X-Gm-Message-State: AOJu0Yy983fX9RjUKLnQp9DDyJu0vQBVmY3hscQHeFvsJ4MLQ0pLfgCt
 wOA/uy1UwzqzkY4Cp+769LCZOSEiOEfhp7vf2BGi+dzHq/wUw9DRpv90smMhLuOgQOz4D/6usiB
 Tw/w/dJOTLVO0M74=
X-Received: by 2002:a05:6512:411:b0:507:975f:1df6 with SMTP id
 u17-20020a056512041100b00507975f1df6mr2252950lfk.14.1697562916977; 
 Tue, 17 Oct 2023 10:15:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFokipB4yj0L3UbyAEwdBvKf4uOSgB6cjcCWzYqln58YVNVPhaq5lfS1Slg/E9EaJ2gvpmHjg==
X-Received: by 2002:a05:6512:411:b0:507:975f:1df6 with SMTP id
 u17-20020a056512041100b00507975f1df6mr2252936lfk.14.1697562916544; 
 Tue, 17 Oct 2023 10:15:16 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m10-20020a05600c3b0a00b0040839fcb217sm109142wms.8.2023.10.17.10.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 10:15:15 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  libvir-list@redhat.com,  Leonardo Bras
 <leobras@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-block@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH v5 5/7] migration: Deprecate old compression method
In-Reply-To: <878r815otk.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 17 Oct 2023 16:03:03 +0200")
References: <20231017115238.18309-1-quintela@redhat.com>
 <20231017115238.18309-6-quintela@redhat.com>
 <878r815otk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 19:15:14 +0200
Message-ID: <875y35yxul.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Acked-by: Peter Xu <peterx@redhat.com>


>>  # @deprecated: Member @disk is deprecated because block migration is.
>> +#     Member @compression is deprecated because it is unreliable and
>> +#     untested. It is recommended to use multifd migration, which
>> +#     offers an alternative compression implementation that is
>> +#     reliable and tested.
>
> Two spaces between sentences for consistency, please.

I have reviewed all the patches again.  Let's hope that I didn't miss
one.

>>  # @announce-step: Increase in delay (in milliseconds) between
>>  #     subsequent packets in the announcement (Since 4.0)
>>  #
>> -# @compress-level: compression level
>> +# @compress-level: compression level.
>>  #
>> -# @compress-threads: compression thread count
>> +# @compress-threads: compression thread count.
>>  #
>>  # @compress-wait-thread: Controls behavior when all compression
>>  #     threads are currently busy.  If true (default), wait for a free
>>  #     compression thread to become available; otherwise, send the page
>> -#     uncompressed.  (Since 3.1)
>> +#     uncompressed. (Since 3.1)
>>  #
>> -# @decompress-threads: decompression thread count
>> +# @decompress-threads: decompression thread count.
>>  #
>>  # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
>>  #     bytes_xfer_period to trigger throttling.  It is expressed as
>
> Unrelated.

Rebases are bad for you O:-)

>> @@ -1023,7 +1036,9 @@
>>  # Features:
>>  #
>>  # @deprecated: Member @block-incremental is deprecated. Use
>> -#     blockdev-mirror with NBD instead.
>> +#     blockdev-mirror with NBD instead. Members @compress-level,
>> +#     @compress-threads, @decompress-threads and @compress-wait-thread
>> +#     are deprecated because @compression is deprecated.
>
> Two spaces between sentences for consistency, please.

Done.
>> @@ -1078,7 +1097,7 @@
>>  # Example:
>>  #
>>  # -> { "execute": "migrate-set-parameters" ,
>> -#      "arguments": { "compress-level": 1 } }
>> +#      "arguments": { "multifd-channels": 5 } }
>>  # <- { "return": {} }
>>  ##
>
> Thanks for taking care of updating the example!

You are welcome.  grep for all occurences of compress-level and friends
has its advantages.

>>  # @compress-wait-thread: Controls behavior when all compression
>>  #     threads are currently busy.  If true (default), wait for a free
>>  #     compression thread to become available; otherwise, send the page
>> -#     uncompressed.  (Since 3.1)
>> +#     uncompressed. (Since 3.1)
>>  #
>> -# @decompress-threads: decompression thread count
>> +# @decompress-threads: decompression thread count.
>>  #
>>  # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
>>  #     bytes_xfer_period to trigger throttling.  It is expressed as
>
> Unrelated.

I have removed the periods.

But I have a question, why the descriptions that are less than one line
don't have period and the other have it.
>>      if (params->has_compress_level) {
>> +        warn_report("Old compression is deprecated. "
>> +                    "Use multifd compression methods instead.");
>>          s->parameters.compress_level = params->compress_level;
>>      }
>>  
>>      if (params->has_compress_threads) {
>> +        warn_report("Old compression is deprecated. "
>> +                    "Use multifd compression methods instead.");
>>          s->parameters.compress_threads = params->compress_threads;
>>      }
>>  
>>      if (params->has_compress_wait_thread) {
>> +        warn_report("Old compression is deprecated. "
>> +                    "Use multifd compression methods instead.");
>>          s->parameters.compress_wait_thread = params->compress_wait_thread;
>>      }
>>  
>>      if (params->has_decompress_threads) {
>> +        warn_report("Old compression is deprecated. "

Once here, I did s/Old/old/

as all your examples of description start with lowercase.

>> +                    "Use multifd compression methods instead.");
>>          s->parameters.decompress_threads = params->decompress_threads;
>>      }
>
> Other than that
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks for your patience.




