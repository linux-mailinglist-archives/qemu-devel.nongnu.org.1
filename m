Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E9873A904
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 21:35:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQ56-000790-JR; Thu, 22 Jun 2023 15:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQ54-00078V-Sa
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQ53-00032F-85
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687462496;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6LqbnDGa4rm1KzgYmUgQQMS19KTLoRd2OqA82f8PZq0=;
 b=P3hJ9AMgXctlxExCDSVFQ2FhStAMesKHiZAZpyM0SnwaIb+eS/I1NUdvD3JGJgLuA0BNgY
 +hOEBJzNMfoPGJgMs2C/gc89L7siqlvm5R4PH2BU91YxQeEXBu5dwSpHpddGQEKbbYJ9lc
 Dyx8E1s5g+uptfZkxI/6yr1WCD3iBII=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-Rb1FHRJpNQa3ab-T47_0jg-1; Thu, 22 Jun 2023 15:34:55 -0400
X-MC-Unique: Rb1FHRJpNQa3ab-T47_0jg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4ec790b902bso6121250e87.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 12:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687462493; x=1690054493;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LqbnDGa4rm1KzgYmUgQQMS19KTLoRd2OqA82f8PZq0=;
 b=e2rGsQ49u9mGhQ8YvP4BaOU3tdHu/cAjxCLwvtGEQ+p8FXBvYfwK6O/pfYoOOKcqEd
 rQcxXY7a1mCDIGI/pRGtzQhSt4KsPTyKe/dW7T6K46FhR0UYpdDT8F3DictCDWxwA+4w
 yZgukM1DUkhmWwzYjUTDw/5dy1X6/yXB63Qtrj5Xju0/a1KsNazz6jaG/Oz1z/3a2+rT
 Cfz1kpjvaQNapTVFmdCXjJIaAm60onqq7tsaUSOhCtSlIfuh/wHCX3xOwpMy8Q0bR/hq
 LptTVTWcP+vY3LL6eMr+FiDJPnt1daPGMB9BtsuPYwF8hH3MIyuMjh3pWst9tPjCEXQG
 PSeQ==
X-Gm-Message-State: AC+VfDx3G3wfxTZEMqeK8zca08lbgG41FsAq3+XE2BT6HBySB5QndIt4
 YUlLXWCRaX8fCEtHyRKtX3s7oiAcAong5xFwGBlm5683ZE7Z7AGo7OrMMSQVWZA8NbYYcVf7eb5
 pQovpk/f47tKGwxc=
X-Received: by 2002:a05:6512:607:b0:4f8:6f40:477b with SMTP id
 b7-20020a056512060700b004f86f40477bmr9426375lfe.25.1687462492843; 
 Thu, 22 Jun 2023 12:34:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6rVeh4zAxpm3dvo3GFlBdcenWAe0Kl3QjxUDxi+3bgwYMPsM9yHiBbCaemT3ELgB+DkzAxhw==
X-Received: by 2002:a05:6512:607:b0:4f8:6f40:477b with SMTP id
 b7-20020a056512060700b004f86f40477bmr9426364lfe.25.1687462492488; 
 Thu, 22 Jun 2023 12:34:52 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 9-20020a05600c228900b003f9b3588192sm342185wmf.8.2023.06.22.12.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 12:34:51 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 qemu-block@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  Thomas Huth
 <thuth@redhat.com>,  libvir-list@redhat.com,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
In-Reply-To: <ZIeL7MGzKBv7CgZ2@x1n> (Peter Xu's message of "Mon, 12 Jun 2023
 17:19:40 -0400")
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica> <ZIeL7MGzKBv7CgZ2@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 21:34:51 +0200
Message-ID: <87cz1ne1es.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

Peter Xu <peterx@redhat.com> wrote:
> On Mon, Jun 12, 2023 at 10:51:08PM +0200, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > On Mon, Jun 12, 2023 at 09:33:42PM +0200, Juan Quintela wrote:
>> >> Only "defer" is recommended.  After setting all migation parameters,
>> >> start incoming migration with "migrate-incoming uri" command.
>> >> 
>> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> >> ---
>> >>  docs/about/deprecated.rst | 7 +++++++
>> >>  softmmu/vl.c              | 2 ++
>> >>  2 files changed, 9 insertions(+)
>> >> 
>> >> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> >> index 47e98dc95e..518672722d 100644
>> >> --- a/docs/about/deprecated.rst
>> >> +++ b/docs/about/deprecated.rst
>> >> @@ -447,3 +447,10 @@ The new way to modify migration is using migration parameters.
>> >>  ``blk`` functionality can be acchieved using
>> >>  ``migrate_set_parameter block-incremental true``.
>> >>  
>> >> +``-incoming uri`` (since 8.1)
>> >> +'''''''''''''''''''''''''''''
>> >> +
>> >> +Everything except ``-incoming defer`` are deprecated.  This allows to
>> >> +setup parameters before launching the proper migration with
>> >> +``migrate-incoming uri``.
>> >> +
>> >> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> >> index b0b96f67fa..7fe865ab59 100644
>> >> --- a/softmmu/vl.c
>> >> +++ b/softmmu/vl.c
>> >> @@ -2651,6 +2651,8 @@ void qmp_x_exit_preconfig(Error **errp)
>> >>      if (incoming) {
>> >>          Error *local_err = NULL;
>> >>          if (strcmp(incoming, "defer") != 0) {
>> >> +            warn_report("-incoming %s is deprecated, use -incoming defer and "
>> >> +                        " set the uri with migrate-incoming.", incoming);
>> >
>> > I still use uri for all my scripts, alongside with "-global migration.xxx"
>> > and it works.
>> 
>> You know what you are doing (TM).
>> And remember that we don't support -gobal migration.x-foo.
>> Yes, I know, we should drop the "x-" prefixes.
>
> I hope they'll always be there. :) They're pretty handy for tests, when we
> want to boot a VM without the need to script the sequences of qmp cmds.
>
> Yes, we probably should just always drop the x-.  We can always declare
> debugging purpose for all -global migration.* fields.
>
>> 
>> > Shall we just leave it there?  Or is deprecating it helps us in any form?
>> 
>> See the patches two weeks ago when people complained that lisen(.., num)
>> was too low.  And there are other parameters that work the same way
>> (that I convenientely had forgotten).  So the easiest way to get things
>> right is to use "defer" always.  Using -incoming "uri" should only be
>> for people that "know what they are doing", so we had to ways to do it:
>> - review all migration options and see which ones work without defer
>>   and document it
>> - deprecate everything that is not defer.
>> 
>> Anything else is not going to be very user unfriendly.
>> What do you think.
>
> IIRC Wei Wang had a series just for that, so after that patchset applied we
> should have fixed all issues cleanly?

No, what he does is using always a very big value for listen.  But that
is it.  Anyways, I don't know how to change the backlog listen value
without restarting the listen call.

> Is there one more thing that's not
> working right there?

Compression has other problems.  But independentely of that, they have
the problem that we need to set the parameters before we call incoming.

>> PD.  This series are RFC for multiple reasons O:-)
>
> Happy to know the rest (besides which I know will break my script :).

Thanks, Juan.


