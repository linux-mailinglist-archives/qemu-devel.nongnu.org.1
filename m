Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8DB7B79F3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:23:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxAO-0005J7-Lj; Wed, 04 Oct 2023 04:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnxAN-0005Ij-ER
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnxAL-0001bA-O2
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696407812;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3uZRkTZXmt7clrPD7NheAmHGZKX9GwvFqMlLUoKAhLM=;
 b=GRx75U338JhbyvctXz88vIzyhg70VD80lG1f9TfHFdiEbuj6oARlWqQHgTRi0ci/J8ucaj
 S1YKiqlLjDsFH9KY5m7gGcr2RdG8XBLqU9AJdqCgr047Lk5J7NoMt4BGSzty3quyiOKPO6
 0YhmVDzArHj9wU4tPZ21+FS97wZL350=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-5-18D5P4No2eUqQAlHPfpA-1; Wed, 04 Oct 2023 04:23:29 -0400
X-MC-Unique: 5-18D5P4No2eUqQAlHPfpA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso1364052f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696407808; x=1697012608;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uZRkTZXmt7clrPD7NheAmHGZKX9GwvFqMlLUoKAhLM=;
 b=Tbuv66tfqTX/K/HT/2yxQfNmlTyp5c+RSrVJ6uxDYnuqn1V10MpOSKDAVQdaWwH1Gt
 JDHzgLgt+wb7jVjnLaaPuiJSWmmz91lyvDcN5YSh+Ws+cgl03zHBoEd03NCdXWYDsj4Z
 dJROKuGYYQ+YAJUeCqfSco3SfUqEc8zsY5gi3TGIKzYWwc/4ylLXj51Dfzl2kqz2rP6f
 dv3T51EZkyQB5wGnZPs4lO2yF+kPEwtNUnvLIae0QEHw/zPs52UP2F+22+GqaHRRf9UP
 hKhguMTQBk17k10JcPUwZpCgcob9Wi/fUUeotMGJsmifJj525PurRlwRwSNcHwrewgPB
 HlwQ==
X-Gm-Message-State: AOJu0YxkuguLIEngzaO5jaiLeiQ6+peQhPkXsRxh1WHKL27kE6QI/JnD
 gKTlmUObDUHjc15Byah/3v3/IwV302tCg2lrByTYnEtiFjQBN2HOJ8yCExfztemR3E0cTIyA2rW
 vDPlzofJ3v6Ju+fvLXTVNa/U+LQ==
X-Received: by 2002:a05:6000:4e1:b0:31f:fdd8:7d56 with SMTP id
 cr1-20020a05600004e100b0031ffdd87d56mr1613501wrb.12.1696407808108; 
 Wed, 04 Oct 2023 01:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3TNRLKr7ipYO6w6UkJ2yuSuCdWiNabgY1OIM2d9YbT87N3b6mxg+sIOgciEQONd8mw1PjwA==
X-Received: by 2002:a05:6000:4e1:b0:31f:fdd8:7d56 with SMTP id
 cr1-20020a05600004e100b0031ffdd87d56mr1613486wrb.12.1696407807748; 
 Wed, 04 Oct 2023 01:23:27 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 w10-20020adfd4ca000000b0031ad5470f89sm3448096wrk.18.2023.10.04.01.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:23:27 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com
Subject: Re: [PATCH v5 2/2] migration: Update error description outside
 migration.c
In-Reply-To: <c281b1e9-a027-4871-a1d5-7fc10f4ba1ed@nutanix.com> (Tejus GK's
 message of "Wed, 4 Oct 2023 09:58:59 +0530")
References: <20231003065538.244752-1-tejus.gk@nutanix.com>
 <20231003065538.244752-3-tejus.gk@nutanix.com>
 <874jj77u4a.fsf@secure.mitica>
 <c281b1e9-a027-4871-a1d5-7fc10f4ba1ed@nutanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 10:23:26 +0200
Message-ID: <871qea6bk1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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

Tejus GK <tejus.gk@nutanix.com> wrote:
> On 03/10/23 6:14 pm, Juan Quintela wrote:
>> Tejus GK <tejus.gk@nutanix.com> wrote:
>>> A few code paths exist in the source code,where a migration is
>>> marked as failed via MIGRATION_STATUS_FAILED, but the failure happens
>>> outside	of migration.c
>>>
>>> In such	cases, an error_report() call is made, however the current
>>> MigrationState is never	updated	with the error description, and	hence
>>> clients	like libvirt never know	the actual reason for the failure.
>>>
>>> This patch covers such cases outside of	migration.c and	updates	the
>>> error description at the appropriate places.
>>>
>>> Acked-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Queued.
> Thanks, will be sending out a patch with the "Reviewed by" trailer added.

Send the other one.  This one is already queued.

I think that the error_report() thing, you need to review more things
than the one in this patch.

>> 
>>>               return ret;
>>>           }
>>>       }
>>> @@ -389,8 +390,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>>>                                        vmdesc_loop);
>>>                   }
>>>                   if (ret) {
>>> -                    error_report("Save of field %s/%s failed",
>>> -                                 vmsd->name, field->name);
>>> +                    error_setg(errp, "Save of field %s/%s failed",
>>> +                                vmsd->name, field->name);
>> Same here.
> You're right, I'm only setting it here and reporting it eventually in
> savevm.c. The trivial solution for this would have been directly doing
> a migrate_set_error() here, but that ended up breaking the build for
> the unit test test-vmstate.c

What was the error?  Because the problem could be on the test.

>> 
>>>                       if (vmsd->post_save) {
>>>                           vmsd->post_save(opaque);
>>>                       }
>> So, I am wondering if it could be better to just report the error in
>> a
>> single place for migration, and set it whenever we need it?
> Yes, that would be very convenient, for all the errors to be reported
> in lets say migration.c. Though that'd also require all the subsystems
> under migration.c to properly propagate the errors.

Yeap, it requires auditing all the entry points, but will make easier to
know when we just need to set the error, the system will do the rest.

Thanks, Juan.


