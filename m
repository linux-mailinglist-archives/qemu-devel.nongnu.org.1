Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C98177D1671
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 21:40:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtvKt-0004o1-26; Fri, 20 Oct 2023 15:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtvKq-0004cv-TR
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 15:39:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtvKp-0007i2-3Z
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 15:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697830740;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TzwbtFMNzCTkuHNXLzp4S9UP1Bm3j9gX4dESjTJvyD8=;
 b=RzSIYbOy3eBwbafLYFMJdVtmL+USN1nJQDmqSYGbnSkWjrDoFjXX1U8aM5ZMfIjjBVGC92
 gPfF/cgN4iTqK9LvEG08R9csOysPKsdt1jjJuBieOEjOyNk1vdKspHA8/leR6ip/ETIkjU
 Sm/lYRBwcl8ehqT3i/fde8W7V7wqxPQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-MLFMp03MOrKb41i7QDV50g-1; Fri, 20 Oct 2023 15:38:49 -0400
X-MC-Unique: MLFMp03MOrKb41i7QDV50g-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c503804667so10781811fa.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 12:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697830727; x=1698435527;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzwbtFMNzCTkuHNXLzp4S9UP1Bm3j9gX4dESjTJvyD8=;
 b=mPCLocPViVsv3uij0yOaUArmFeiQcxUsk91VJ0j4PHD+mloRTaMjLbq4KSxJj9HuBI
 THwff9RVr0Puo6J9x05UnicA+eak72bd89h4n1q3nfcMsQCfumZh2449OvLc3PYBYPdi
 N0176e2BqgijhZl+EtSQr4pVdy/IFWRhpRr6SNhg/rFIbEopdJD6RkTDyoCQTG0tbBLW
 bj7A7a6j2tu/8+zu8K8DpYnxJAFMemYDJg12IPm3ANzMMMJVoLzRGhodeMnvn9eDRlBe
 NmOnbDrgmB4ep7EFZx339EQfFMT0e3TQoExte5G9AihECZ6J2knsKOMtPRfdqkWWXnQJ
 FXfA==
X-Gm-Message-State: AOJu0YwFetz76hxUSV99NFq8pqFPWdLjRwBQRbeupaQ8a/ci5SrlxVha
 98gFR9evwRhnYdDUKR1irw0/OUqCRzeIF7kmKlsBvHHAofRlccZjxXE6fr/Xx7TFgLOt7fysUWE
 kETLti5if7zZwhEs=
X-Received: by 2002:a05:651c:711:b0:2c5:1ea4:4e99 with SMTP id
 z17-20020a05651c071100b002c51ea44e99mr1746830ljb.48.1697830727740; 
 Fri, 20 Oct 2023 12:38:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDS7wen0Bigkeiy5Ke6uTo5hJIhriYm83DaYUjMgrpczUufO0H6nwYxgm+uK/5yjX8bCEBoA==
X-Received: by 2002:a05:651c:711:b0:2c5:1ea4:4e99 with SMTP id
 z17-20020a05651c071100b002c51ea44e99mr1746816ljb.48.1697830727343; 
 Fri, 20 Oct 2023 12:38:47 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c1d1600b004042dbb8925sm7802037wms.38.2023.10.20.12.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 12:38:46 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1 1/4] migration: mode parameter
In-Reply-To: <6ef2d943-0822-47fb-84d7-bb9c39260670@oracle.com> (Steven
 Sistare's message of "Fri, 20 Oct 2023 10:08:57 -0400")
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-2-git-send-email-steven.sistare@oracle.com>
 <8734y51w1h.fsf@secure.mitica>
 <6ef2d943-0822-47fb-84d7-bb9c39260670@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 21:38:46 +0200
Message-ID: <87a5sdyth5.fsf@secure.mitica>
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

Steven Sistare <steven.sistare@oracle.com> wrote:
> On 10/20/2023 5:29 AM, Juan Quintela wrote:
>> Steve Sistare <steven.sistare@oracle.com> wrote:
>>> Create a mode migration parameter that can be used to select alternate
>>> migration algorithms.  The default mode is normal, representing the
>>> current migration algorithm, and does not need to be explicitly set.
>>>
>>> No functional change until a new mode is added, except that the mode is
>>> shown by the 'info migrate' command.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> 
>> [... qdev definition ...]
>> 
>> Looks legit, but I am not an expert here.
>
> Nor I, but I copied a similar definition line for line, see
>   qdev_prop_blockdev_on_error
>   DEFINE_PROP_BLOCKDEV_ON_ERROR
>
> However, I now see I am missing:
>   QEMU_BUILD_BUG_ON(sizeof(MigMode) != sizeof(int));
>
> I can ask Daniel Berrange to review this part if you prefer.

I reviewed it, but I agree that looks legit to me O:-)

>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index db3df12..184fb78 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -616,6 +616,15 @@
>>>              { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
>>>  
>>>  ##
>>> +# @MigMode:
>>> +#
>>> +# @normal: the original form of migration. (since 8.2)
>>> +#
>>> +##
>>> +{ 'enum': 'MigMode',
>>> +  'data': [ 'normal' ] }
>>> +
>>> +##
>> 
>> Here you only have normal, but in qdev you also have exec.
>
> Good eye.  I will remove exec from .description in this patch, and add
> cpr-reboot to it in patch 4.

Thanks.

>>>  # @BitmapMigrationBitmapAliasTransform:
>>>  #
>>>  # @persistent: If present, the bitmap will be made persistent or
>>> @@ -675,6 +684,9 @@
>>>  #
>>>  # Migration parameters enumeration
>>>  #
>>> +# @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>>> +#        (Since 8.2)
>>> +#
>> 
>> You normally put comments and values at the end of the comments and
>> sections. Your sshould be last.
>
> Do you mean, add the mode parameter at the end of the existing parameters, 
> after vcpu-dirty-limit?
>
>> Feel free to use a single line in the json.  More than one value for
>> line make it a bit more compress, but makes changes more complicated.
>
> Like this?
>
> { 'enum': 'MigrationParameter',
>   'data': ['announce-initial', 'announce-max',
>           ...
>           'vcpu-dirty-limit',
>           'mode'] }

Exactwly.  Same for the comments at the end of the list.

> - Steve


