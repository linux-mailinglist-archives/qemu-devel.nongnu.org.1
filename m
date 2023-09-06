Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 279937939D1
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 12:27:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdpjz-0004u5-1R; Wed, 06 Sep 2023 06:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdpjD-0004p2-WE
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 06:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdpj7-0002MK-GO
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 06:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693995935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfqXLFeeHbKsXtQLbx2Y3MGTf3QM4W7LBg1oYwErs+Y=;
 b=F0P3ryvH09aZcCYGzlhGSZL7k8OCq7sxvn1ior1IGxebqJaJJoNw9GICsKOsVj4OIX3XE4
 9xaWofOi7125CquDmLp00g7Y83m6wcucerdzacM8rryil6HJafL44O/D5ZEn39Fj8t2V6P
 7FyfrKPPow0dj2Ycsj7Nr7PYmmRl62Y=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-crQvRCmSNMWgnr2oalIg_Q-1; Wed, 06 Sep 2023 06:25:34 -0400
X-MC-Unique: crQvRCmSNMWgnr2oalIg_Q-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2bbbaa6001dso45498031fa.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 03:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693995932; x=1694600732;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qfqXLFeeHbKsXtQLbx2Y3MGTf3QM4W7LBg1oYwErs+Y=;
 b=LN+QfuCSBFnDt3U8AhXYEHNQoJIZxYGZ4BXOqd0TKrwjd3nX1eYsDHfE4ZSpVkT6BW
 sfC1RdF2yNngiZVrYyQY1Im0daWQWxl6dXBj+WRNaXhr19lXsdMdh8zdapUxz3GUiVqU
 Hmxw8q0x6Un+iC2eQ/6H0IQEtC2AJmn3ghz0o30YhHMInPO5O/PMyGyzGYCBr3W/A2eM
 pAAo76BSvrereTHHbpvDPgdGPLyTCiuvsl195ji3GiwnV/KgSBk4T3WtkXgSx16LJYM2
 jDpUMrpISBOQa1VfWfhtP7gLNYZKc48Urnrbrra8z0nGUPf9tt0EJ4W2FJfyVaVZUxaS
 jSYg==
X-Gm-Message-State: AOJu0YzTOirqoXtz2a4dmytQwKyTAKkzuC85on9EfOycevCCajdOnbBj
 zbHMsyoGWv8qyztGKS9vFwYWA9zlA5No+KacahP4ypwtO9Ia36JrqndXCpOf329jHOwWv5A9vaH
 ZKVFf2KSaRbLw4dY=
X-Received: by 2002:a05:651c:11:b0:2b8:4100:b565 with SMTP id
 n17-20020a05651c001100b002b84100b565mr2043412lja.15.1693995932594; 
 Wed, 06 Sep 2023 03:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJeEivVATvJFIbUR19ir1qC37aHYlhGAz47W5YVqKQJqNB3/VXNFaD8YUy9xAt+w3VFtJAAA==
X-Received: by 2002:a05:651c:11:b0:2b8:4100:b565 with SMTP id
 n17-20020a05651c001100b002b84100b565mr2043376lja.15.1693995932197; 
 Wed, 06 Sep 2023 03:25:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:6c00:92a4:6f8:ff7e:6853?
 (p200300cbc70c6c0092a406f8ff7e6853.dip0.t-ipconnect.de.
 [2003:cb:c70c:6c00:92a4:6f8:ff7e:6853])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a1c6a07000000b003fe407ca05bsm22562795wmc.37.2023.09.06.03.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 03:25:31 -0700 (PDT)
Message-ID: <c9ab7061-22da-fed5-97bf-4924fe07cbf8@redhat.com>
Date: Wed, 6 Sep 2023 12:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 William Tsai <williamtsai1111@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, Fam Zheng <fam@euphon.net>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20230902094041.8626-1-williamtsai1111@gmail.com>
 <ZPYIBVtUgDGhj3TQ@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] qdict: Preserve order for iterating qdict elements
In-Reply-To: <ZPYIBVtUgDGhj3TQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 04.09.23 18:38, Daniel P. Berrangé wrote:
> On Sat, Sep 02, 2023 at 05:40:40PM +0800, William Tsai wrote:
>> Changing the structure of qdict so that it can preserve order when
>> iterating qdict. This will fix array_properties as it relies on `len-`
>> prefixed argument to be set first.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1090
>> Signed-off-by: William Tsai <williamtsai1111@gmail.com>
> 
> This is a variation of what Markus illustrated a year ago
> 
>    https://lists.gnu.org/archive/html/qemu-devel/2022-07/msg00758.html
> 
> I wasn't a particular fan of that approach at the time.
> 
> I've made an alternative proposal here which avoids the broader
> impact of this QDict change:
> 
>    https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg00652.html

Just a note regarding s390x CPU models (and how they are also affected, but
it probably doesn't matter because it never 100% worked that way on all interfaces).


I recall that I thought the order of parameters worked for s390x CPU models,
where we support feature groups (due to the huge number of CPU features). But this
might only have worked for the "-cpu" parameter, which parses them in-order and
sets properties in-order.

So when mixing a feature group with contained features, the end result might not
be deterministic in other cases thatn "-pu" (CPU hotplug via "-device", but
also qapi CPU model operations).

For example, one might want to enable all but some features of a group, or
disable all but some features of a group. Note that I doubt that there are really
users of that, but it's possible on the QEMU cmdline.

I guess it never really worked with qapi CPU model operations in general
(baseline, comparison, expansion, ...) because these
operations all rely on qdict as well (see cpu_model_from_info()). So they should
never return something non-deterministic.


To highlight one case that could now fail:

$ ./qemu-system-s390x -smp 1,maxcpus=2 -cpu qemu,msa2=off,kimd-sha-512=on -nographic -nodefaults -monitor stdio -S -device qemu-s390x-cpu,core-id=1,msa2=off,kimd-sha-512=on
QEMU 8.1.50 monitor - type 'help' for more information
qemu-system-s390x: warning: 'msa5-base' requires 'klmd-sha-512'.
qemu-system-s390x: -device qemu-s390x-cpu,core-id=1,msa2=off,kimd-sha-512=on: warning: 'msa5-base' requires 'kimd-sha-512'.
qemu-system-s390x: -device qemu-s390x-cpu,core-id=1,msa2=off,kimd-sha-512=on: warning: 'msa5-base' requires 'klmd-sha-512'.
qemu-system-s390x: -device qemu-s390x-cpu,core-id=1,msa2=off,kimd-sha-512=on: Mixed CPU models are not supported on s390x.

Note that using "-device qemu-s390x-cpu,core-id=1" instead works as expected, as
cpu_common_parse_features() registers all settings as global properties for
that CPU type.


Further, feature groups might not be used by actual users that way. CPU model expansion (s390_feat_bitmap_to_ascii()) only reports a feature group when all
features are contained, so most of libvirt should be fine, unless someone decides to
manually specify a non-deterministic CPU model as above.

So maybe one can conclude that specifying "msa2=off,kimd-sha-512=on" is similar to
"kimd-sha-512=off,kimd-sha-512=on", and which setting "wins" is not deterministic.

-- 
Cheers,

David / dhildenb


