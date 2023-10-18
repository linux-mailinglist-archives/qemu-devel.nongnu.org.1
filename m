Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D34AF7CDA3A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:25:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4fB-0008R7-5j; Wed, 18 Oct 2023 07:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt4f7-0008Qk-Bn
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt4f5-0004na-Hf
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697628266;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Ug5cT3WMDuE8s0u+ZCMrurGgDF0l9gdle2RsmZHbRgQ=;
 b=fDR+Exs/pjRFRhjV9ATd4d2YAbfba3vPeKIvePCEEwXQ6S+HeSRakYyZ5cMt3cLYLYiEOK
 SNJ1ggHR5wxBiw4NTHr/AfUL3B1AeYE3QX250n5+4LiP0T9eIFvUNbe1hZHUKkvjPJJmuF
 o1rAwKHV9gwmHkMJnvzFrreeNUhM1Y0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-pdJKpM7FP0GcOnXo9hlZXg-1; Wed, 18 Oct 2023 07:24:10 -0400
X-MC-Unique: pdJKpM7FP0GcOnXo9hlZXg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-327ab41de6cso4385655f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 04:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697628249; x=1698233049;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ug5cT3WMDuE8s0u+ZCMrurGgDF0l9gdle2RsmZHbRgQ=;
 b=UPul/gMXheH9yGgXvijkyKBe/wZo/o3lV+b3pL4Lh2slIYpP/VtHyPmxxebSwnx75c
 9Xq5QuAENMJCd+2cVeCVW5pfrUH52b4aQMzCarSICCNBj9WqmnIRl6RZ/Kg8gbxDqj9J
 bAEKHX4g/Sv3XraW+NWA+MR6egnIH0R7tSVyLmgKEPtAR95UMQbQDeplcfs8/I6EMCRg
 askGvD5cvThneyyNZJbQ5L+GyGRKoXQ2SdQPlbXyyD8VcGA4D+1v957q7f89nokml3Mc
 joNKyFxf/dN9JFu9HwK7x3G9AdAZ6zRoGzauxcV3biRHXna/Af3qK4voeeOkzNVKWjBC
 yE5w==
X-Gm-Message-State: AOJu0Yy/OFmXj/7eirK2H8wqJwzwkv4CpIM7IbDoPTI5HwC19w42z0bX
 RXH4rZ56g0vkLaconzaseJi9FbFjHKigpS2DeB9pZ211swtz7TcM6YqcqhYKb2Z1HZgc/DfNw/p
 q/CoQ1EJy3GXmRrc=
X-Received: by 2002:a5d:4f91:0:b0:32d:ba78:2b33 with SMTP id
 d17-20020a5d4f91000000b0032dba782b33mr4132032wru.63.1697628249055; 
 Wed, 18 Oct 2023 04:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEof/gY7Nkoe9LTJIMRQYZtiwX3H6k1mjgvjfwPdqBoo0q7XBmMpQma5lMlQQog0KRno/ciTA==
X-Received: by 2002:a5d:4f91:0:b0:32d:ba78:2b33 with SMTP id
 d17-20020a5d4f91000000b0032dba782b33mr4132018wru.63.1697628248684; 
 Wed, 18 Oct 2023 04:24:08 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 r16-20020a056000015000b0031aef72a021sm1880617wrx.86.2023.10.18.04.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 04:24:06 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 1/3] migration/doc: Add documentation for backwards
 compatiblity
In-Reply-To: <CAFEAcA8brMkW8Y6=sOq1YpEwY+Wjvt+NxSqCBTQFw2tBeYRbEw@mail.gmail.com>
 (Peter Maydell's message of "Tue, 17 Oct 2023 17:20:01 +0100")
References: <20231017151857.21328-1-quintela@redhat.com>
 <20231017151857.21328-2-quintela@redhat.com>
 <CAFEAcA8brMkW8Y6=sOq1YpEwY+Wjvt+NxSqCBTQFw2tBeYRbEw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 13:24:06 +0200
Message-ID: <87il74kwbt.fsf@secure.mitica>
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

Peter Maydell <peter.maydell@linaro.org> wrote:
> On Tue, 17 Oct 2023 at 16:20, Juan Quintela <quintela@redhat.com> wrote:
>>
>> State what are the requeriments to get migration working between qemu
>> versions.  And once there explain how one is supposed to implement a
>> new feature/default value and not break migration.
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Acked-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  docs/devel/migration.rst | 217 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 217 insertions(+)
>>
>> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
>> index c3e1400c0c..5ef2b36e9e 100644
>> --- a/docs/devel/migration.rst
>> +++ b/docs/devel/migration.rst
>> @@ -142,6 +142,223 @@ General advice for device developers
>>    may be different on the destination.  This can result in the
>>    device state being loaded into the wrong device.
>>
>> +How backwards compatibility works
>> +---------------------------------
>
> Is there a better place in this document that we could add
> this information?

> At the moment these new sections have
> been placed in the middle of the "Saving the state of one device"
> section, which doesn't seem right; worse, it's between the
> "General advice for device developers" and the "VMState"
> subsections of that section, which means that we end up with
> a very long part of the document that is talking about edge
> cases, and which splits up the two parts of the document that
> are really all most device model authors need to think about.

You are right.  I didn't know for a good place either.
I created a new section:

Backwards compatibility

At the end of the archive.

> My guess is that the extra documentation on backwards
> compatibility that these patches are adding should get
> a new section of its own (at the same level as the current
> top-level sections "Transports", "Debugging", etc) which
> then has its own subsections; and that this should probably
> go either at the bottom of the document, after "Firmware",
> or else just before "Stream structure".

End it is.

> We should probably also add a
> .. contents::
> directive near the start of the page, since it's now big
> enough and has enough sections and subsections that a
> table of contents would be helpful.

Also done.

Thanks a lot.


