Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFD873A8E6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 21:21:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCPru-0001Z1-P8; Thu, 22 Jun 2023 15:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCPrp-0001Ya-Nd
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCPro-0004tX-9l
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687461675;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=psFhvWlNn6ILJpHHBe3bDnf6GwQyu8l04Ps3PPB3AAg=;
 b=E+keUy1l+0lnXIY/AV3wEeI/1wxKvR7FCNUimwbwcjXuInHem/k3n0FguXEobFH8wPbXsn
 2u+jCRlsCePrcO19oMEKlyC5GSJ89YaUzwBv9wUGOQzqa3kjG/NdS3xKVnCEpqwgEDoui2
 y5GZ881fMDF5PamrroD0UFRRclox6qc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-R7OcxTmUODO24r74-Mv0rQ-1; Thu, 22 Jun 2023 15:21:11 -0400
X-MC-Unique: R7OcxTmUODO24r74-Mv0rQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so4083315f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 12:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687461669; x=1690053669;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psFhvWlNn6ILJpHHBe3bDnf6GwQyu8l04Ps3PPB3AAg=;
 b=DOrmhktV1ubfNWBfeZRZqB+JOa9sy8UToyLCb453PK06g8Cf8qgj6WEf0BLo/aPJi6
 AuwC8yS3QnzAHtMm90xIGyFluJpu0dKI4Axgu+ln9beZSgMoakOuX6zRTUBxP7jhm+xq
 q4visWrv9Wbwq4eFWwFEhexYvX9UitStsbYB7oWmFju88Qt1miDWv/hP0vnSrC5Dg54t
 wEBPgdhBgjHK4GM1qJi9y3pCDHd8HF9gxf2QC04zUgWKHnWWpJ/0Y0MbMJXhaVLSqwYg
 mrJsLvovNPP4p17/QMEd1vedaGNFi0MZbQGXy8f2dsLITEw2WrrIAHobA6dbbxp6lf6S
 Auag==
X-Gm-Message-State: AC+VfDyyAXaXNUypTBTkx3NEFIxhpFhdrksOG/qo8Yxfwy67rgAZCvRn
 BRMjzPkzC0K9/TjF5mmbVRdb/b0IFwW7It5Fvl+LFPsNrkI7CB6QGOB22nA4jhecdiXqDD7yqrt
 jEhuDbLuEa6OzLEY=
X-Received: by 2002:adf:f2c7:0:b0:306:3b78:fe33 with SMTP id
 d7-20020adff2c7000000b003063b78fe33mr17028524wrp.32.1687461669708; 
 Thu, 22 Jun 2023 12:21:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7OwRz4xO+zL8yxOr0VQMFlmYOjxssRh6IW/IsnWcY+8RI3Y0LfFyyIBQs/vJHtC4UdKn2qJg==
X-Received: by 2002:adf:f2c7:0:b0:306:3b78:fe33 with SMTP id
 d7-20020adff2c7000000b003063b78fe33mr17028511wrp.32.1687461669416; 
 Thu, 22 Jun 2023 12:21:09 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 m9-20020a5d56c9000000b0030fb4b55c13sm7655575wrw.96.2023.06.22.12.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 12:21:08 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Eric Blake <eblake@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  libvir-list@redhat.com,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [RFC 6/6] migration: Deprecated old compression method
In-Reply-To: <ae0ed423-ef17-9f6f-e7eb-537e2d53df8c@redhat.com> (Thomas Huth's
 message of "Wed, 21 Jun 2023 09:14:27 +0200")
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-7-quintela@redhat.com>
 <ae0ed423-ef17-9f6f-e7eb-537e2d53df8c@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 21:21:08 +0200
Message-ID: <87o7l7e21n.fsf@secure.mitica>
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

Thomas Huth <thuth@redhat.com> wrote:
> On 12/06/2023 21.33, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   docs/about/deprecated.rst |  8 ++++
>>   qapi/migration.json       | 92 ++++++++++++++++++++++++---------------
>>   migration/options.c       | 13 ++++++
>>   3 files changed, 79 insertions(+), 34 deletions(-)
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 173c5ba5cb..fe7f2bbde8 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -460,3 +460,11 @@ block migration (since 8.1)
>>   Block migration is too inflexible.  It needs to migrate all block
>>   devices or none.  Use driver_mirror+NBD instead.
>>   +old compression method (since 8.1)
>> +''''''''''''''''''''''''''''''''''
>> +
>> +Compression method fails too much.  Too many races.  We are going to
>> +remove it if nobody fixes it.  For starters, migration-test
>> +compression tests are disabled becase they hand randomly.  If you need
>
> "because they fail randomly" ?

yeap.

>>   # @deprecated: @disk migration is deprecated.  Use driver_mirror+NBD
>> -#     instead.
>> +#     instead. @compression is obsolete use multifd compression
>
> Use a dot or comma after "obsolete".

fixed.

>> @@ -503,6 +506,7 @@
>>   # Features:
>>   #
>>   # @deprecated: @block migration is deprecated.  Use driver_mirror+NBD
>> +#     instead. @compress is obsolete use multifd compression methods
>
> dito

fixed.

>> -# @compress-threads: compression thread count
>> +# @compress-threads: compression thread count. Obsolote and
>
> Obsolete

Fixed.

>> @@ -1182,7 +1209,6 @@
>>                                        'features': [ 'unstable' ] },
>>               '*block-incremental': { 'type': 'bool',
>>                                       'features': [ 'deprecated' ] },
>> -            '*block-incremental': 'bool',
>
> That hunk should go into a previous patch, I think.

Have found it already (it didn't compile).

Thanks, Juan.


