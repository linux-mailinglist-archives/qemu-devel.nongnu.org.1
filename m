Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B03987CC5C9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:19:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsktv-00065q-8b; Tue, 17 Oct 2023 10:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qskth-00065V-My
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsktf-0005DU-Oj
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697552289;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=V/sgVzx8TAjuq2sPTnNkawMed70PaiTSz6ptGNJ2ax0=;
 b=D9uRpYeDPntYYL0gzP5Mk5x7e37YVKp/jLyrG32GfNmlQUrUP8NnLR8c+L2yAYDy77O5jj
 YKHaHQsluPYUSekqQe0NtbJJsFL5KTwWkcgpxXwIAyispnj+R0AvvY6rAtvRPJJLWhndop
 jnL7lRzYEDd3+D8vjHqx5FnzBQ+q0UM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-Ap5A60UPNZOBCLLeduwJaw-1; Tue, 17 Oct 2023 10:18:07 -0400
X-MC-Unique: Ap5A60UPNZOBCLLeduwJaw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4077ee09a4eso19142785e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697552286; x=1698157086;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/sgVzx8TAjuq2sPTnNkawMed70PaiTSz6ptGNJ2ax0=;
 b=fQqQwiY7ctxA76+vYoM2hRK5HBhJeCHdCBjpiqu87agJdnW6d+2sRVf9TbXoBdjhjh
 n0oPMNAGEx8tVcjL3lh8IJnlH4RfIO++/lUbLDnGI16097U0tawwT+dytWd4inHkwOXJ
 eOlZHe9hBa4j02yPEfGeO0PsnMiM0zNexWIWYKFvfcNP1ksM9z1xOUcLTmnp0w1dXroK
 4QBtzchl/pZmmfY6uBo2qCDOSHOItSmcvjx5gnopzlxmfk9Ia0TqtCKSpPP0loNrGd9U
 gIwQKa7ceG007uFVTIsprzgXShe31u2oiISXCMXUz08YGvQ4rITf2hEk1STHt8oEyDOQ
 UWoA==
X-Gm-Message-State: AOJu0YwCKsxyYtjVUpU9lgoD+TbsNSGl3psVT084DED7ae0VDL6p+bB2
 Drqmva8cvEv1mj9LWq7KIel/+vHFGuEmujO3X+e+uEBPS9SLiI+RMCU9feaeFQb0KVv/8mcAtxJ
 flEUpvXZDYN19cxo=
X-Received: by 2002:a05:600c:46c3:b0:407:5adc:4497 with SMTP id
 q3-20020a05600c46c300b004075adc4497mr1839117wmo.9.1697552286409; 
 Tue, 17 Oct 2023 07:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFktS9TGJE9267X5R8wmpCJgf+icPB8fcVgw3zKy/z6pMq9QppTp+GPpckjfv9AjH5KeV/TDw==
X-Received: by 2002:a05:600c:46c3:b0:407:5adc:4497 with SMTP id
 q3-20020a05600c46c300b004075adc4497mr1839097wmo.9.1697552285976; 
 Tue, 17 Oct 2023 07:18:05 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 az15-20020a05600c600f00b004081a011c0esm1421279wmb.12.2023.10.17.07.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:18:05 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,  Jiri Denemark <jdenemar@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,  Fiona Ebner <f.ebner@proxmox.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 3/3] migration/doc: We broke backwards compatibility
In-Reply-To: <ZGQZ6A+hQx0+6vBo@x1n> (Peter Xu's message of "Tue, 16 May 2023
 20:03:52 -0400")
References: <20230515083201.55060-1-quintela@redhat.com>
 <20230515083201.55060-4-quintela@redhat.com> <ZGQZ6A+hQx0+6vBo@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 16:18:04 +0200
Message-ID: <87sf69z61v.fsf@secure.mitica>
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

Peter Xu <peterx@redhat.com> wrote:
> On Mon, May 15, 2023 at 10:32:01AM +0200, Juan Quintela wrote:
>> When we detect that we have broken backwards compantibility in a
>> released version, we can't do anything for that version.  But once we
>> fix that bug on the next released version, we can "mitigate" that
>> problem when migrating to new versions to give a way out of that
>> machine until it does a hard reboot.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  docs/devel/migration.rst | 194 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 194 insertions(+)
>> 
>> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
>> index 95e797ee60..97b6f48474 100644
>> --- a/docs/devel/migration.rst
>> +++ b/docs/devel/migration.rst
>> @@ -451,6 +451,200 @@ binary in both sides of the migration.  If we use different QEMU
>>  versions process, then we need to have into account all other
>>  differences and the examples become even more complicated.
>>  
>> +How to mitigate when we have a backward compatibility error
>> +-----------------------------------------------------------
>> +
>> +We broke migration for old machine types continously during
>
> continuously

done.

>> +development.  But as soon as we find that there is a problem, we fix
>> +it.  The problem is what happens when we detect after we have done a
>> +release that something has gone wrong.
>> +
>> +Let see how it worked with one example.
>> +
>> +After the release of qemu-8.0 we found a problem when doing migration
>> +of the machine type pc-7.2.
>> +
>> +- $ qemu-7.2 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
>> +
>> +  This migration works
>> +
>> +- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
>> +
>> +  This migration works
>> +
>> +- $ qemu-8.0 -M pc-7.2  ->  qemu-7.2 -M pc-7.2
>> +
>> +  This migration fails
>> +
>> +- $ qemu-7.2 -M pc-7.2  ->  qemu-8.0 -M pc-7.2
>> +
>> +  This migration fails
>> +
>> +So clearly something fails when migration between qemu-7.2 and
>> +qemu-8.0 with machine type pc-7.2.  The error messages, and git bisect
>> +pointed to this commit.
>> +
>> +In qemu-8.0 we got this commit: ::
>> +
>> +    commit 9a6ef182c03eaa138bae553f0fbb5a123bef9a53
>> +    Author: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> +    Date:   Thu Mar 2 13:37:03 2023 +0000
>> +
>> +        hw/pci/aer: Add missing routing for AER errors
>
> Worst timing ever for him.. :(

haha

> The lesson is never break migration when the maintainer has any intention
> to add some docs explaining backward compatibility.

Nah.  Just don't ever break migration and you are safe O:-)

>> +Notice that we enable te feature for new machine types.
>
> the

Done.

>> +                      PCI_ERR_UNC_SEVERITY_DEFAULT);
>> +
>> +I.e. If the property bit is enabled, we configure it as we did for
>> +qemu-8.0.  If the property bit is not set, we configure it as it was in 7.2.
>> +
>> +And now, everything that is missing is disable the feature for old
>
> disabling

Done.

>> +Can we do better?
>> +
>> +Yeap.  If we know that we are gonig to do this migration:
>
> IIUC the other thing one should do is always keep their QEMU binaries
> uptodate.  E.g., anyone seriously using 8.0 released QEMU should always
> consider to do timely upgrade to e.g. 8.0.1 so this issue can also be
> avoided (by dropping 8.0 directly).

I think that advice is valid, but independently of migration.

>> +
>> +- $ qemu-8.0 -M pc-7.2  ->  qemu-8.0.1 -M pc-7.2
>> +
>> +We can launche the appropiate devices with
>
> launch
>
>> +
>> +--device...,x-pci-e-err-unc-mask=on
>> +
>> +And now we can receive a migration from 8.0.  And from now on, we can
>> +do that migration to new machine types if we remember to enable that
>> +property for pc-7.2.  Notice that we need to remember, it is not
>> +enough to know that the source of the migration is qemu-8.0.  Think of this example:
>
> (wrap)
>
>> +
>> +$ qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 -> qemu-8.2 -M pc-7.2
>> +
>> +In the second migration, the source is not qemu-8.0, but we still have
>> +that "problem" and have that property enabled.  Notice that we need to
>> +continue having this mark/property until we have this machine
>> +rebooted.  But it is not a normal reboot (that don't reload qemu) we
>> +need the mapchine to poweroff/poweron on a fixed qemu.  And from now
>> +on we can use the proper real machine.
>> +
>
> The 8.0.1 breaking migration to 8.0 is a very important point to mention
> indeed.

I hope it was clear on the example.

> Acked-by: Peter Xu <peterx@redhat.com>

Thanks, Juan.


