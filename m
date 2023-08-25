Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7C27880FB
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:37:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRNW-00048G-1z; Fri, 25 Aug 2023 03:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qZRNT-00047n-Dz
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qZRNR-0006dN-6j
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692949023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5u+5UB1yPzhwqHapJuzH2bAwocD05RZ8UuVQaOaePNk=;
 b=XtHW0Wz1ZRS8Y2YwRvBi+uKRM9eOEOPOX/KBpp7mUeAeZRYQdN0keRIE9VYKy4OmwEhSZD
 Dyo8jiyOHXg+kvdZV2i8Lck+7qYZm94pvyvyw9bT3nF/SD9OmsfJTVHyShar8jIMWuGuql
 fSOcEkreaCBLxVkb7UaPSru/oWNTtlM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-vwpgwRqLPtKbJtBKvtLXxQ-1; Fri, 25 Aug 2023 03:37:01 -0400
X-MC-Unique: vwpgwRqLPtKbJtBKvtLXxQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fee703462dso5503325e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 00:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692949020; x=1693553820;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5u+5UB1yPzhwqHapJuzH2bAwocD05RZ8UuVQaOaePNk=;
 b=daMJEZQp5zYCd/kDlxhX3WD0TVmjya8g+NO84IZyqaN0yLiXiPGOZ3lXuQZ4JY4deo
 eIjm60PEaNtD7EtzOI0mI/prCga7QuJ0pSCp5wheVoOZkWFFBflE/zZC1ZMIEHDLTMln
 /W+paUx5/+JLRgyncTnNTVQerkT8duz1U7rShk9zhSGGFFhkrmo+RSTnXWWVNPf5Zp0e
 cEXeSMvi0KDp5GVnUgLexZUUeIbyKfZBRgI6Nt3c33WfbohWLZzpCcU/DgkFHo7N475k
 CnnGlRGmBakNYlsZ/PG6XhGH18GQIrn0WFEFqycvSiieJiEAzFSnrvmOuUhQlBXxPkY2
 EzKg==
X-Gm-Message-State: AOJu0YyhYIbYBaoSLevdzl5ur1PvqOail7j31ly11E+NZVnwwVS0IlOj
 /BV/RhxpCDMWGulLIZ4T6snce43Z6shCs/91r3EUAVzHFwJExOK5edJ0TrqBm/RyYEgdyvfSYSa
 m47gJAD32XDxsEog=
X-Received: by 2002:adf:cf02:0:b0:317:6b0d:1b1 with SMTP id
 o2-20020adfcf02000000b003176b0d01b1mr13725154wrj.4.1692949020558; 
 Fri, 25 Aug 2023 00:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfk6XNN+JUzGmN+1JQsQI19VltMiZJW88NsXjFY/ULK4tKdfNl9AhU3U1vuJMZ5JpPNRNi9A==
X-Received: by 2002:adf:cf02:0:b0:317:6b0d:1b1 with SMTP id
 o2-20020adfcf02000000b003176b0d01b1mr13725133wrj.4.1692949020175; 
 Fri, 25 Aug 2023 00:37:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4?
 (p200300cbc70e9200ce93b5e68aa965d4.dip0.t-ipconnect.de.
 [2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4])
 by smtp.gmail.com with ESMTPSA id
 q9-20020adfea09000000b0031c5ee51638sm1391689wrm.109.2023.08.25.00.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:36:59 -0700 (PDT)
Message-ID: <e81b5069-e49a-cfb4-bea9-3c7ab6a358ca@redhat.com>
Date: Fri, 25 Aug 2023 09:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: ThinerLogoer <logoerthiner1@163.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-12-david@redhat.com>
 <209b4b8c.54bc.18a2b7b6f53.Coremail.logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 11/11] machine: Improve error message when using
 default RAM backend id
In-Reply-To: <209b4b8c.54bc.18a2b7b6f53.Coremail.logoerthiner1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.919, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 25.08.23 08:57, ThinerLogoer wrote:
> Hello,
> 
> At 2023-08-23 23:34:11, "David Hildenbrand" <david@redhat.com> wrote:
>> For migration purposes, users might want to reuse the default RAM
>> backend id, but specify a different memory backend.
>>
>> For example, to reuse "pc.ram" on q35, one has to set
>>     -machine q35,memory-backend=pc.ram
>> Only then, can a memory backend with the id "pc.ram" be created
>> manually.
>>
>> Let's improve the error message.
>>
>> Unfortuantely, we cannot use error_append_hint(), because the caller
>> passes &error_fatal.
>>
>> Suggested-by: ThinerLogoer <logoerthiner1@163.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> hw/core/machine.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index f0d35c6401..dbcd124d45 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -1382,7 +1382,9 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>>                                   machine_class->default_ram_id)) {
>>              error_setg(errp, "object name '%s' is reserved for the default"
>>                  " RAM backend, it can't be used for any other purposes."
>> -                " Change the object's 'id' to something else",
>> +                " Change the object's 'id' to something else or disable"
>> +                " automatic creation of the default RAM backend by setting"
>> +                " the 'memory-backend' machine property",
>>                  machine_class->default_ram_id);
>>              return;
>>          }
> 
> I'd suggest a more explicit version:
> 
>                  " Change the object's 'id' to something else or disable"
>                  " automatic creation of the default RAM backend by appending"
>                  "  'memory-backend={machine_class->default_ram_id}' in '-machine' arguments",


Thanks, I'll do:

diff --git a/hw/core/machine.c b/hw/core/machine.c
index f0d35c6401..cd0fd6cdd1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1382,8 +1382,10 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
                                   machine_class->default_ram_id)) {
              error_setg(errp, "object name '%s' is reserved for the default"
                  " RAM backend, it can't be used for any other purposes."
-                " Change the object's 'id' to something else",
-                machine_class->default_ram_id);
+                " Change the object's 'id' to something else or disable"
+                " automatic creation of the default RAM backend by appending"
+                " 'memory-backend=%s' in '-machine' arguments",
+                machine_class->default_ram_id, machine_class->default_ram_id);
              return;
          }
          if (!create_default_memdev(current_machine, mem_path, errp)) {


-- 
Cheers,

David / dhildenb


