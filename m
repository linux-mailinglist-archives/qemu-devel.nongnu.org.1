Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F3872D127
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 22:53:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8oVm-000072-Ui; Mon, 12 Jun 2023 16:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q8oVj-00006R-No
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 16:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q8oVZ-0004xs-9x
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 16:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686603074;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hX7F7gu38H8klwQFsZ9zd0ApRkm0o7XefyZcItIVmqI=;
 b=btpvzE7GBTSbxOvx7Fk4um7K8BONLYjHuS5jp4BnK42U18Mq5IbkbORrXE3q1KbaO1ZJdI
 8bOiF39aGMcKfi1E/PD0dPjZXznxcZkOKC55Vrmb1ZjTMJIv5BsaasJwID7uZdNjAoa0lq
 coGk4X/xczN46sj5Nd8WnlYvRz4pnYc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-AkOsuZ82OxCemRAMN7-6bA-1; Mon, 12 Jun 2023 16:51:12 -0400
X-MC-Unique: AkOsuZ82OxCemRAMN7-6bA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso1514039f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 13:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686603071; x=1689195071;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hX7F7gu38H8klwQFsZ9zd0ApRkm0o7XefyZcItIVmqI=;
 b=NxSSbeRfzF+p3fSBJRglxZw3Gr1IMFZ72Cl+j2HldbcAi4QGewUCD+zLkuHxYaXmc4
 DxLvRvML2XGEWAyi+2g0B2uaboQFFZ5WI99KwWv29d0Wr7SefgyoU61uaBf1QDz49Pp2
 rxRvjuGsz7p/viKpFk9I4IZCitrhTJu8VDcm+zlpHRvFAA/2g+PHTuc6D+WB2Qnw4ORc
 oaHFdg/6gW+QrptqdAEZxPfmQ30Lgl2nik+mc5Oz3IEFhAqjrLjEXnGRXKZAOX0dJmIN
 no19+xq1BpKHWPS1nFa5BOv1mho3CJqXg4T6CedcBtRGZz/N/lUZX4Dh3m0KhTqgekvU
 gwng==
X-Gm-Message-State: AC+VfDz2LxliJqubBneNU/voTB298OUB4u+cIwGsv2MxGBUsWs0n2QMa
 qdrE4ljAIvBGFIMQXGzZZ1X6+Ck3G7mBie8Ntx1R98SRTCCGGXneUO7H882iDKh3rE1cjn/87X1
 u5iFWmpg3c6QVMYo=
X-Received: by 2002:adf:f087:0:b0:306:2d15:fc35 with SMTP id
 n7-20020adff087000000b003062d15fc35mr4394925wro.37.1686603071734; 
 Mon, 12 Jun 2023 13:51:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4vwRw6SsWF5wxxfZQSRv4bOm0gDCNQnefJaSRQXjr0bMWQGdkwaALkrGr62Ohx/S+Pu9KM9w==
X-Received: by 2002:adf:f087:0:b0:306:2d15:fc35 with SMTP id
 n7-20020adff087000000b003062d15fc35mr4394910wro.37.1686603071374; 
 Mon, 12 Jun 2023 13:51:11 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 m11-20020a5d6a0b000000b0030b5d203e7esm13415406wru.97.2023.06.12.13.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 13:51:10 -0700 (PDT)
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
In-Reply-To: <ZId0+HYF/ETLVri3@x1n> (Peter Xu's message of "Mon, 12 Jun 2023
 15:41:44 -0400")
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 12 Jun 2023 22:51:08 +0200
Message-ID: <875y7sflqb.fsf@secure.mitica>
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Mon, Jun 12, 2023 at 09:33:42PM +0200, Juan Quintela wrote:
>> Only "defer" is recommended.  After setting all migation parameters,
>> start incoming migration with "migrate-incoming uri" command.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  docs/about/deprecated.rst | 7 +++++++
>>  softmmu/vl.c              | 2 ++
>>  2 files changed, 9 insertions(+)
>> 
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 47e98dc95e..518672722d 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -447,3 +447,10 @@ The new way to modify migration is using migration parameters.
>>  ``blk`` functionality can be acchieved using
>>  ``migrate_set_parameter block-incremental true``.
>>  
>> +``-incoming uri`` (since 8.1)
>> +'''''''''''''''''''''''''''''
>> +
>> +Everything except ``-incoming defer`` are deprecated.  This allows to
>> +setup parameters before launching the proper migration with
>> +``migrate-incoming uri``.
>> +
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index b0b96f67fa..7fe865ab59 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -2651,6 +2651,8 @@ void qmp_x_exit_preconfig(Error **errp)
>>      if (incoming) {
>>          Error *local_err = NULL;
>>          if (strcmp(incoming, "defer") != 0) {
>> +            warn_report("-incoming %s is deprecated, use -incoming defer and "
>> +                        " set the uri with migrate-incoming.", incoming);
>
> I still use uri for all my scripts, alongside with "-global migration.xxx"
> and it works.

You know what you are doing (TM).
And remember that we don't support -gobal migration.x-foo.
Yes, I know, we should drop the "x-" prefixes.

> Shall we just leave it there?  Or is deprecating it helps us in any form?

See the patches two weeks ago when people complained that lisen(.., num)
was too low.  And there are other parameters that work the same way
(that I convenientely had forgotten).  So the easiest way to get things
right is to use "defer" always.  Using -incoming "uri" should only be
for people that "know what they are doing", so we had to ways to do it:
- review all migration options and see which ones work without defer
  and document it
- deprecate everything that is not defer.

Anything else is not going to be very user unfriendly.
What do you think.

Later, Juan.

PD.  This series are RFC for multiple reasons O:-)


