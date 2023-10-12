Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CD57C6DBF
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:15:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qquaC-0000pn-Eu; Thu, 12 Oct 2023 08:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qquaA-0000pX-O1
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqua8-0000gZ-QZ
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697112864;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8FqkK5+9kqpXLVol0G6SOnUBl/72ugUj+3SMsmODt30=;
 b=gq5fa82ITrlkq1+2fVsimOzX27n9uzM3t6vLA/zAP4Vw0VQgFcUl0SqrAaPOrVEqmcPiS1
 /rohkXzipdP1067+G5tXzsGS0PvCGS6r3uK8ZecOCfytPI5j0hOk4B70K7HhAnjesJHEoW
 OIV5RdZRG/MkU8ZB3e5l1I/Y+NEKPm4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-xGdR0BU5O9iqeCFcqrMMYg-1; Thu, 12 Oct 2023 08:14:22 -0400
X-MC-Unique: xGdR0BU5O9iqeCFcqrMMYg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so7345525e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 05:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697112861; x=1697717661;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FqkK5+9kqpXLVol0G6SOnUBl/72ugUj+3SMsmODt30=;
 b=GUxmug9qJKiwxK+HjpHTP98KASNSGhJgTFXnut74zN26t7SnZ14VsinkdmnLzh7qYf
 7Diy/SsRIq8YrGz8T1QeLsUtFoWHuIz0a1m5wIsGS6OhrvWk1QAtm8nrsOe6YNDc07qS
 Zw+gJfZVBnD5KD5P1ot4O29p18dpsdXmM8j4WoL8txKUZJpVv67Re+QB92qYUSHSqXV/
 qf8+LHonZcEwyN33Lx+bEkFjkwA6kQTHAumPihVjutUaLGai3iXT8vTfT6DA2ZHMvqSa
 FRmFRCm/tfnf9+25GCvND0uMF1b2v4j4jYfsPfF373FrllSw70q2wBsro2ts+mttcYAW
 +www==
X-Gm-Message-State: AOJu0YwJMyqvq8vIuTlyC2hM8WrZFaIsf0I3FzxCyDaWpYL/p4QX4X18
 6hu4HHgdBKpwDZKMWUYQelQNm7VyZl6Soey0YMDjaJ/BCIQtXGxx2jIHPG65I48kcmAG1CwXSCy
 h4+1IWC98XN7L8jE=
X-Received: by 2002:a05:600c:3787:b0:402:95a0:b2ae with SMTP id
 o7-20020a05600c378700b0040295a0b2aemr19982270wmr.32.1697112861119; 
 Thu, 12 Oct 2023 05:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5xe1VgEPvRRZzJv8bf/2UvWKW3xxHZ6ADCit8b3pGpg4TI0rx8xL/+MJCiRwc5A8M04olwQ==
X-Received: by 2002:a05:600c:3787:b0:402:95a0:b2ae with SMTP id
 o7-20020a05600c378700b0040295a0b2aemr19982231wmr.32.1697112860774; 
 Thu, 12 Oct 2023 05:14:20 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 k1-20020a05600c0b4100b00405442edc69sm21529503wmr.14.2023.10.12.05.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 05:14:20 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  Fam Zheng <fam@euphon.net>,  Eric Blake
 <eblake@redhat.com>,  libvir-list@redhat.com,  Leonardo Bras
 <leobras@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 4/4] migration: Deprecate old compression method
In-Reply-To: <87jzrsyx29.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 12 Oct 2023 12:06:22 +0200")
References: <20231011204711.9744-1-quintela@redhat.com>
 <20231011204711.9744-5-quintela@redhat.com>
 <87jzrsyx29.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 12 Oct 2023 14:14:19 +0200
Message-ID: <877cns6ns4.fsf@secure.mitica>
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

Markus Armbruster <armbru@redhat.com> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> -# @deprecated: @disk migration is deprecated.  Use driver-mirror
>> -#     with NBD instead.
>> +# @deprecated: @disk migration is deprecated.  Use driver-mirror with
>> +#     NBD instead.  @compression is unreliable and untested. It is
>> +#     recommended to use multifd migration, which offers an
>> +#     alternative compression implementation that is reliable and
>> +#     tested.
>
> Again, single deprecation note under "Features:", please.

Done in all places.

>
>>  #
>>  # Since: 0.14
>>  ##
>> @@ -290,7 +295,7 @@
>>             '*blocked-reasons': ['str'],
>>             '*postcopy-blocktime': 'uint32',
>>             '*postcopy-vcpu-blocktime': ['uint32'],
>> -           '*compression': 'CompressionStats',
>> +           '*compression': { 'type': 'CompressionStats', 'features': ['deprecated'] },
>>             '*socket-address': ['SocketAddress'],
>>             '*dirty-limit-throttle-time-per-round': 'uint64',
>>             '*dirty-limit-ring-full-time': 'uint64'} }
>> @@ -445,7 +450,8 @@
>>  #     compress and xbzrle are both on, compress only takes effect in
>>  #     the ram bulk stage, after that, it will be disabled and only
>>  #     xbzrle takes effect, this can help to minimize migration
>> -#     traffic.  The feature is disabled by default.  (since 2.4 )
>> +#     traffic.  The feature is disabled by default.  Obsolete.  Use
>
> Some places call it "deprecated", others "obsolete".  Best to always use
> "deprecated".

"obsolete" word removed from this series O:-)

> More of the same below.
>
>> +#     multifd compression methods if needed. (since 2.4 )
>>  #
>>  # @events: generate events for each migration state change (since 2.4
>>  #     )
>
> [...]
>
> Migration has grown way too many options.  Thanks for pruning them back
> some.

I am going to redo the 1st patches to just print an error if you use
-i/-b on HMP.  So that will clean up your last comment for that patch.

Thanks.


