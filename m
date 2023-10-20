Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 257627D0C65
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:57:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtmEw-0005Ov-Pz; Fri, 20 Oct 2023 05:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtmEZ-00052Q-Ak
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtmEU-0003S4-Mw
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697795743;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KLMU+I9osao7AtazXCWDbLO2o5vrv5iN8qcDoN2HNVU=;
 b=MCzIrvUzYsqHmUtcpyjkC2CtnU3BndoQBxnCnu0t1+RVC21jQaZkP/LXgx5gEWAld5g1NM
 8WD7Vpg5baVo4kv7T6IHbUItow+EfIa5kLQuPp0BEfB6fhw0O0laI4jwAqi/eHW7yxlcT/
 spaXFF1xcso1+lYLmoHgLFRlqus4MaY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-CcVcRKnSO9O9pkLLZmnDgA-1; Fri, 20 Oct 2023 05:55:40 -0400
X-MC-Unique: CcVcRKnSO9O9pkLLZmnDgA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-408212415abso3919875e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 02:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697795739; x=1698400539;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KLMU+I9osao7AtazXCWDbLO2o5vrv5iN8qcDoN2HNVU=;
 b=chr/DXpWaeoBNyCq3Ig+TiWCEQQs9mKdUEcEEhEUmvX0rnJwey2nk5zERgfqTwxvBt
 fB2Rp9w7qlBZ2BDsP0TVCNcfjazuPWOLssErhQE9Bn9Sqg2j2IZqC/kRoF/a770IIsYK
 boe3+qKZ//pY7Setiwh4vxuTolA0KM2EMeCLxzRfHV3OO5btq/dewvp9sGlr4TV+2AVR
 iyQmPQqLZxWVS4jJXQgnV2dmGGzlRB/g8jRFawdGtl5hdFzqXqGl19f9/T9KAoo3tG77
 /0IVtlojbDvueM21oNTZgtol5bdkrE9lHGLYc9ouBr/mdjcrno3ptriPmLyHJaW3ifVA
 5rDQ==
X-Gm-Message-State: AOJu0YxSSfGSxdPm23jfGbWukaRRM+D26Xh1VzBHJN1rBh93wTgSZulg
 Dj8/c1v5qhfgOuxY/4n8KTJlqmin400BhIaTOTILlSNwzJK4I/kwEbsgWnJPG26O22u65RyIKUG
 TTb8K0oDUH0vTyAk=
X-Received: by 2002:a05:600c:4593:b0:401:b504:b6a0 with SMTP id
 r19-20020a05600c459300b00401b504b6a0mr1097889wmo.3.1697795739080; 
 Fri, 20 Oct 2023 02:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBKB2FOolaXg8d3rhvQTrVfHCS/njN0B508BkFRPh6HaH9UwJ+wp+V+Gf+IPUQ1dHgKN7gFg==
X-Received: by 2002:a05:600c:4593:b0:401:b504:b6a0 with SMTP id
 r19-20020a05600c459300b00401b504b6a0mr1097874wmo.3.1697795738802; 
 Fri, 20 Oct 2023 02:55:38 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c314e00b003fbe4cecc3bsm6612838wmo.16.2023.10.20.02.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 02:55:38 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,  qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH v2 10/22] qapi: Correct error message for
 'vcpu_dirty_limit' parameter
In-Reply-To: <875y318zgy.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 20 Oct 2023 10:33:49 +0200")
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-11-philmd@linaro.org>
 <875y318zgy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 11:55:37 +0200
Message-ID: <87edhpzkh2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
>> QERR_INVALID_PARAMETER_VALUE is defined as:
>>
>>   #define QERR_INVALID_PARAMETER_VALUE \
>>       "Parameter '%s' expects %s"
>>
>> The current error is formatted as:
>>
>>   "Parameter 'vcpu_dirty_limit' expects is invalid, it must greater then=
 1 MB/s"
>>
>> Replace by:
>>
>>   "Parameter 'vcpu_dirty_limit' is invalid, it must greater then 1 MB/s"
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>  migration/options.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/migration/options.c b/migration/options.c
>> index 1d1e1321b0..79fce0c3a9 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -1163,9 +1163,8 @@ bool migrate_params_check(MigrationParameters *par=
ams, Error **errp)
>>=20=20
>>      if (params->has_vcpu_dirty_limit &&
>>          (params->vcpu_dirty_limit < 1)) {
>> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>> -                   "vcpu_dirty_limit",
>> -                   "is invalid, it must greater then 1 MB/s");
>> +        error_setg(errp, "Parameter 'vcpu_dirty_limit' is invalid,"
>> +                         " it must greater then 1 MB/s");
>>          return false;
>>      }
>
> Make that "greater than", please.
>
> Arrgh, the unit is MB/s even in QMP:
>
>     # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
>     #     Defaults to 1.  (Since 8.1)
>
> Should be Bytes.  Escaped review, and now it's too late to fix.

I want a Time Machine.
I want a Time Machine.

Wait, if I had a Time Machine I would not be fixing old bugs O:-)

Later, Juan.


