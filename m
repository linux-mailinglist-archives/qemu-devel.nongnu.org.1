Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D57B7F86
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1EL-0000Sa-4T; Wed, 04 Oct 2023 08:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1EG-0000S5-1T
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1ED-0005Bs-Hq
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423428;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BaBEyBmM0uWZEAL0p19/ex6GxvAUrLuvyogDbuL1IV8=;
 b=huawbqq8v+jEsm+AzZPau4JC4bx70qAIe/6L5wQVxttvZ6zLWymMFzCRoUN9Q0Zdv0oqJv
 WKKZUv2Pk4jrMnKUed8txKj6tTAWBXE7jZVLrdLknQOl0CFzrsbisS2exOFKhz1WhqwLW7
 4Om2A2EE8pTNwXyN4BJ9Md5syhq4W2E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-HR_TDXIQMQGjEdY1kWzbJQ-1; Wed, 04 Oct 2023 08:43:47 -0400
X-MC-Unique: HR_TDXIQMQGjEdY1kWzbJQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-313c930ee0eso1431014f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696423426; x=1697028226;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaBEyBmM0uWZEAL0p19/ex6GxvAUrLuvyogDbuL1IV8=;
 b=psMJAQ/waGrqkPqjmsmIrNeBEzo2wv+sKQ+7hyTC7oF+kSBr6i/IYFW3EWPqR0n8vT
 8LFKJZLOZ9mjkEscgj05hQ2gPohWzX1+TCgV6DYKpkCKfP3Ovw6wStorN7MSVMQHulGq
 yRtf09XKRn2JzsVc3GmGnkfFuOOIQhA19XISI58aFzRhx4e+G93Gx0lfqLyU3aq83/zZ
 8OvTvxs9L6N2hoVK58NPbuGBf56aJ8jzP4xhyUfBTRjmMP7YyapBRp2P9PZpaz17wWnd
 DI34HvqFcjhQmA8YR8+i69yYSxp+vS8WpbRxumU+1G6LHtnX2YaPIzGNou4wnwRzyFr8
 ZDHw==
X-Gm-Message-State: AOJu0Yz2CKpECpBJ7HW0GQOew2V8gqf4e6xTZAEUeBapfySuUHivhSPm
 eRGXlGvsHyd0/fo3kOT5P0fhEiu+W7c5/8/EA/Rukm9ZitnRFGCZO0JOZW/7yCY5rr0BHWAKMlE
 gbnbb9uO7BacWSMM=
X-Received: by 2002:a5d:410d:0:b0:31f:e428:8a4d with SMTP id
 l13-20020a5d410d000000b0031fe4288a4dmr1883318wrp.33.1696423426462; 
 Wed, 04 Oct 2023 05:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt9b31RpnT+LHuAVeiHdm1QLJcbpOq3aYwnmxztbq4jG+pOxyIeX7vXzmylP9QOJ4O79YztQ==
X-Received: by 2002:a5d:410d:0:b0:31f:e428:8a4d with SMTP id
 l13-20020a5d410d000000b0031fe4288a4dmr1883305wrp.33.1696423426088; 
 Wed, 04 Oct 2023 05:43:46 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 v17-20020a5d4a51000000b00323287186b2sm3952014wrs.29.2023.10.04.05.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 05:43:45 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de
Subject: Re: [PATCH v5 2/2] migration: Update error description outside
 migration.c
In-Reply-To: <68db0be7-694a-44da-8513-e761109d5902@nutanix.com> (Tejus GK's
 message of "Wed, 4 Oct 2023 17:45:06 +0530")
References: <20231003065538.244752-1-tejus.gk@nutanix.com>
 <20231003065538.244752-3-tejus.gk@nutanix.com>
 <874jj77u4a.fsf@secure.mitica>
 <c281b1e9-a027-4871-a1d5-7fc10f4ba1ed@nutanix.com>
 <871qea6bk1.fsf@secure.mitica>
 <68db0be7-694a-44da-8513-e761109d5902@nutanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 14:43:44 +0200
Message-ID: <87leci36db.fsf@secure.mitica>
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
> On 04/10/23 1:53 pm, Juan Quintela wrote:
>> Tejus GK <tejus.gk@nutanix.com> wrote:
>>> On 03/10/23 6:14 pm, Juan Quintela wrote:
>>>> Tejus GK <tejus.gk@nutanix.com> wrote:
>>>>> A few code paths exist in the source code,where a migration is
>>>>> marked as failed via MIGRATION_STATUS_FAILED, but the failure happens
>>>>> outside	of migration.c
>>>>>
>>>>> In such	cases, an error_report() call is made, however the current
>>>>> MigrationState is never	updated	with the error description, and	hence
>>>>> clients	like libvirt never know	the actual reason for the failure.
>>>>>
>>>>> This patch covers such cases outside of	migration.c and	updates	the
>>>>> error description at the appropriate places.
>>>>>
>>>>> Acked-by: Peter Xu <peterx@redhat.com>
>>>>> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
>>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>> Queued.
>>> Thanks, will be sending out a patch with the "Reviewed by" trailer added.
>> Send the other one.  This one is already queued.
>> I think that the error_report() thing, you need to review more
>> things
>> than the one in this patch.
>
> Not sure what you mean here? The only other patch I have on the list
> apart from this one is
> https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg00280.html ,
> which you marked as reviewed as well.
>> 
>>>>
>>>>>                return ret;
>>>>>            }
>>>>>        }
>>>>> @@ -389,8 +390,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>>>>>                                         vmdesc_loop);
>>>>>                    }
>>>>>                    if (ret) {
>>>>> -                    error_report("Save of field %s/%s failed",
>>>>> -                                 vmsd->name, field->name);
>>>>> +                    error_setg(errp, "Save of field %s/%s failed",
>>>>> +                                vmsd->name, field->name);
>>>> Same here.
>>> You're right, I'm only setting it here and reporting it eventually in
>>> savevm.c. The trivial solution for this would have been directly doing
>>> a migrate_set_error() here, but that ended up breaking the build for
>>> the unit test test-vmstate.c
>> What was the error?  Because the problem could be on the test.
> This is what I keep getting.
>
> FAILED: tests/unit/test-vmstate
> cc -m64 -mcx16  -o tests/unit/test-vmstate
> tests/unit/test-vmstate.p/test-vmstate.c.o -Wl,--as-needed
> -Wl,--no-undefined -pie -Wl,--whole-archive -Wl,--start-group
> libevent-loop-base.a libqom.fa libio.fa libcrypto.fa libauthz.fa
> -Wl,--no-whole-archive -fstack-protector-strong -Wl,-z,relro
> -Wl,-z,now -Wl,--warn-common libqemuutil.a
> subprojects/libvhost-user/libvhost-user-glib.a
> subprojects/libvhost-user/libvhost-user.a libmigration.fa libqom.fa
> libio.fa libcrypto.fa libauthz.fa /usr/lib64/libz.so
> /usr/lib64/libgio-2.0.so /usr/lib64/libgobject-2.0.so
> /usr/lib64/libglib-2.0.so /usr/lib64/libgmodule-2.0.so -pthread -lm
> /usr/lib64/libpixman-1.so -Wl,--end-group
> libmigration.fa.p/migration_vmstate.c.o: In function `vmstate_save_state_v':
> /rpmbuild/SOURCES/qemu/build/../migration/vmstate.c:333: undefined
> reference to `migrate_get_current'
> /rpmbuild/SOURCES/qemu/build/../migration/vmstate.c:344: undefined
> reference to `migrate_set_error'
> collect2: error: ld returned 1 exit status
>
> I tried to figure out how the dependencies work out for unit test, but
> found no luck with that.

Ouch, that again.

I think that I know how to fix that.

Will take a look.

Later, Juan.


