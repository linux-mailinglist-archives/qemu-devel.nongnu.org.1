Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E257739CCF
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:24:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGXE-0006XF-FZ; Thu, 22 Jun 2023 05:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qCGX9-0006VJ-JR
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qCGX1-0004NJ-MJ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687425783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UEsFW6dzgW2GRq0CvXUAaYpERVA9Nk2cDYdeV87zEk8=;
 b=RC69RY5mYHG1MxHtMQc6LYnl7rJG7GcuQ+HgoHlZuOSkb8RhgsrNmnZOQy1KfBiUhwcMwv
 Fl9sHrmozs86SqrzIN1TqOwiyeIWCIx4Z7kbYdbrxjCaRoIUo4K25YkIaZlKGaeCGzCuQA
 3r3+NsZF2cQiSEDHERbT/4tFXI10+OE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-4kIcNCreNWmO5gGcVakL2w-1; Thu, 22 Jun 2023 05:23:01 -0400
X-MC-Unique: 4kIcNCreNWmO5gGcVakL2w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f81f4a7596so39589335e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 02:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687425780; x=1690017780;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UEsFW6dzgW2GRq0CvXUAaYpERVA9Nk2cDYdeV87zEk8=;
 b=aDjxVXoFRRTyA091ndjExz62ZF1mQ4WVrzS7M3ApOIJAgDSZTn+mfhrLOSRMFtBtxh
 8TrIiM6wBFpPmXixU0786kj6Tdtu+0YXBWjK+amrgg8QfZkvjyxVoog4hbuyidQsBzUa
 oS8nEx+tIWk1zt7rbRBEM4j3f9u3BExVI7QAjqRCK3w05xniXRwFtjoWKgugriiEo9J2
 JJPQoPsyWyMMX1x7r5ErmE/otrYTTYyC7snHca1cOSM0wQHryZ4mNieZKqK0oO+sThKQ
 n6W0ax/ozD2NndUJ+FQZFAzBMyKR40v3khHDL9uLM2cfdoGmJb+nss8SGeZ+BymcrxCf
 jF0A==
X-Gm-Message-State: AC+VfDwnQGReEyWqYr2yx77Vt1/6PKghq7mj4lLSlqZ1KNRgY7WARYFq
 kVNUM2nGGkdg/NYPaMIocyPVJ7IkMJiCBqp0OU96Q3Ye1lfeYBBdQHbz9AaaS84+Mgh+BpHJVA+
 31Ieo9TAT4Z1ND6yMfFx0CcM=
X-Received: by 2002:a7b:cbd8:0:b0:3fa:781a:3d07 with SMTP id
 n24-20020a7bcbd8000000b003fa781a3d07mr110583wmi.35.1687425780749; 
 Thu, 22 Jun 2023 02:23:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4KVR8B5yypa1+y+CMi1LWz2pr2kstpY/WYDl8+DpHQ5eLoBDOP+4LbX4bHuaLD0CkIX+VZPQ==
X-Received: by 2002:a7b:cbd8:0:b0:3fa:781a:3d07 with SMTP id
 n24-20020a7bcbd8000000b003fa781a3d07mr110485wmi.35.1687425778120; 
 Thu, 22 Jun 2023 02:22:58 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a05600c294800b003f90a604885sm7158769wmd.34.2023.06.22.02.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 02:22:57 -0700 (PDT)
Message-ID: <a81d48ac-4aee-1c5a-e530-20c634e42d5b@redhat.com>
Date: Thu, 22 Jun 2023 11:22:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Content-Language: en-US
To: quintela@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?Q?Daniel_P=2eBerrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 libvir-list@redhat.com
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <87wmzv7ubn.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22/06/2023 10.52, Juan Quintela wrote:
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 6/12/23 22:51, Juan Quintela wrote:
>>>> Shall we just leave it there?  Or is deprecating it helps us in any form?
>>> See the patches two weeks ago when people complained that lisen(.., num)
>>> was too low.  And there are other parameters that work the same way
>>> (that I convenientely had forgotten).  So the easiest way to get things
>>> right is to use "defer" always.  Using -incoming "uri" should only be
>>> for people that "know what they are doing", so we had to ways to do it:
>>> - review all migration options and see which ones work without defer
>>>     and document it
>>> - deprecate everything that is not defer.
>>
>> "-incoming <uri>" is literally the same as running "migrate-incoming"
>> as the first thing on the monitor:
>>
>>      if (incoming) {
>>          Error *local_err = NULL;
>>          if (strcmp(incoming, "defer") != 0) {
>>              qmp_migrate_incoming(incoming, &local_err);
>>              if (local_err) {
>>                  error_reportf_err(local_err, "-incoming %s: ", incoming);
>>                  exit(1);
>>              }
>>          }
>>      } else if (autostart) {
>>          qmp_cont(NULL);
>>      }
>>
>> It's the only piece of code which distinguishes "-incoming defer" from
>> "-incoming <uri>".
>>
>> So I'm not sure what the problem would be with keeping it?
> 
> User friendliness.
> 
> First of all, I use it all the time.  And I know that it is useful for
> developers.  I was the one asking peter to implement -global
> migration.foo to be able to test multifd with it.
> 
> The problem is that if you use more than two channels with multifd, on
> the incoming side, you need to do:
> 
> - migrate_set_parameter multifd-channels 16
> - migrate_incoming <uri>
> 
> And people continue to do:
> 
> - qemu -incoming <uri>
> - migrate_set_parameter multifd-channels 16 (on the command line)
> 
> And they complain that it fails, because we are calling listen with the
> wrong value.

Then simply forbid "migrate_set_parameter multifd-channels ..." if the uri 
has been specified on the command line?

  Thomas


