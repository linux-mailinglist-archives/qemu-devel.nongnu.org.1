Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A473A0AE
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 14:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJDa-0002QR-1I; Thu, 22 Jun 2023 08:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCJDU-0002O9-Db
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCJDS-0004OY-Ni
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 08:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687436109;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=oVRZoWmWXdvRy4SxXAKvCwy86tNDGhys7Dd5svwpeHk=;
 b=C1+2xrtdstNRaCDTIUqBQ6x2ewUD5FWAl6XJn1mBZURJ6ykUzh4shz+APFFahj7udYzkzq
 TO5hf1M8Y1n4xIl5zxgUE4jGKAQgkdZgCwBGe+WBPPOrASfc65TIwgsd2Ir4JuOidYQPOm
 S2ne7mBKgM6YXuL5ZJFV+SJRwmhJxQI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-eP6oWIWTPxaOMacA1tFu1w-1; Thu, 22 Jun 2023 08:15:07 -0400
X-MC-Unique: eP6oWIWTPxaOMacA1tFu1w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f9bd5c7fdfso9941865e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 05:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687436106; x=1690028106;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVRZoWmWXdvRy4SxXAKvCwy86tNDGhys7Dd5svwpeHk=;
 b=ASHCx5X/E7hqKfpzZRx4bme29TTTu//xcks2QeiTUlwDEgzWMsT3uZLbDgDIbuhFxj
 P3AfjQrcPk/5Ocxsm0SfkHJbQyJ3ZqK0Gb1ndD6ugGOr77jQLeIQHvX8EvwInpzk+yjC
 bMHZXbS+oJZevbTd2CiBj0qgvItptIGBm1t9hD0AqTMCNi7lOZjJdmScmVR8Fy2jL+OF
 RHs99zh5kvDSWu+rZvut0TUSYsV8+8OvwrkZpyzVzYvVAwCC6aISvScnTb1p3e4Sv/X9
 MrtnTwbVJyOzXKPm8Y+TDw/PoNTCZSj2M2j2cJPLwg/gVgRv2mg5vbPihqoykSjf5dbB
 rlfg==
X-Gm-Message-State: AC+VfDyaok7NOLoBNXa57bicw38ZnbimnxDmgy0d48CFFj2ypHV0AErp
 eANCRfwPAlNKIWyaNGFjykgiqnca647HbnWO96Nvz6NtO6hrgACAA7pRrbDh3ZtybiAL6QbQE60
 bNBP5Rq3qaxC2W+Y=
X-Received: by 2002:a1c:4b0c:0:b0:3f9:b083:109 with SMTP id
 y12-20020a1c4b0c000000b003f9b0830109mr8911311wma.33.1687436106659; 
 Thu, 22 Jun 2023 05:15:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6opVcerVlMFjFBPO4/mKuW54+sfdxaCZ0HyMMY4foIfNauhIn2y07NP5NvNUQcaBeMV0+v4Q==
X-Received: by 2002:a1c:4b0c:0:b0:3f9:b083:109 with SMTP id
 y12-20020a1c4b0c000000b003f9b0830109mr8911288wma.33.1687436106298; 
 Thu, 22 Jun 2023 05:15:06 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 f10-20020a7bcd0a000000b003f9b0830107sm1889193wmj.41.2023.06.22.05.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 05:15:05 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 01/18] migration: Give one error if trying to set
 MULTIFD and XBZRLE
In-Reply-To: <20230622133623.5189e059@mobian> (Lukas Straub's message of "Thu, 
 22 Jun 2023 13:36:23 +0200")
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-2-quintela@redhat.com>
 <20230622133623.5189e059@mobian>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 14:15:04 +0200
Message-ID: <87o7l77kxj.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Lukas Straub <lukasstraub2@web.de> wrote:
> On Tue, 13 Jun 2023 16:57:40 +0200
> Juan Quintela <quintela@redhat.com> wrote:
>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/options.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/migration/options.c b/migration/options.c
>> index b62ab30cd5..c6674a4753 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -547,6 +547,13 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>>          }
>>      }
>>  
>> +    if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
>> +        if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
>> +            error_setg(errp, "Multifd is not compatible with xbzrle");
>> +            return false;
>> +        }
>> +    }
>> +
>>      return true;
>>  }
>>  
>
> Hmm, I think supporting xbzrle + multifd might be worthwhile as an
> alternative to xbzrle + compress.

Nack.

> I don't use it, but it should be easy to do by just letting xbzlre try
> to handle the page before multifd.

My idea here is to implement xbzrle as we implement zlib/zstd on
multifd.  Just go from there.

> There shouldn't be any incompatibilities other than that, as long as
> xbzlre sees the pages before multifd and the zero-page case is still
> handled the old way.

The way that I say is going to be easier and probably also faster.

Later, Juan.


