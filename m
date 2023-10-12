Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2195F7C6D93
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:05:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qquQM-0005Tt-Js; Thu, 12 Oct 2023 08:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qquQK-0005TZ-NC
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qquQJ-0006je-2C
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697112253;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WXyE9bMQ/AKWUOsRj9T/tHeDp2tIciJKfUcLaz14W5s=;
 b=YLZ3bNEJ58mgH0Ldbp247Wk98mwRwKCkxyv0WtSqQmZ1e9Si27Y55EA443LHqUAAbCBwfc
 W8+KyGoAZoeLgSH72MvJpHzQTIJs8dA8owrNKppnTFqFQi/OTeS9e2MyromSQ5X1DWflOY
 ra5qwefAa0NZ2m8Fa+YWqxw3dE1R+1Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-DifeQNH8NNaC-0kFoaPN9A-1; Thu, 12 Oct 2023 08:04:11 -0400
X-MC-Unique: DifeQNH8NNaC-0kFoaPN9A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-406de77fb85so6482345e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 05:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697112250; x=1697717050;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXyE9bMQ/AKWUOsRj9T/tHeDp2tIciJKfUcLaz14W5s=;
 b=JyLYSYP8c+n6PW7mr8uGGc0ZuoL0rKYDgQkm7zE9uZZDPEMRnN9opVf+ROR5zWCARR
 aeYs3ZqbGaXtA9lxwZWBApZbJepKEkm9/2wJowYY+8MVQa8jx/mjLj8Vnfn2DEiJ+wh8
 rkVUjxz0EDKjMizTODfxrRjuRrS9ZtL1MJFQmCnHD/R8ocdwyNfhlLMA3sW0hrZCdesN
 /ux3HLrEly2fEBPm8bRHK1kIzuom8iv/+V2e8ge397hgOo9DAaeFz17wgdZiz3U0wiJU
 uIc/SL4c/Tr+hDSd0nYf19Zc3eenHeiXKSy++F9vXT6hkU8zIMtSID30isffIiYpKxUd
 hl7Q==
X-Gm-Message-State: AOJu0YzpFDtuj+UHpkQqw1X1bNruhuwciuW8o056eCAnwbHAr63dnPl3
 FjKhkB9MpKcnN9T7RaCkCNaOaRDKaWqCaKA8VfLmpytvR63Uiapeu4YmIjH7/r9ixXt1xLaMWcK
 7UAPluARhkG2oPPo=
X-Received: by 2002:a05:600c:2a4e:b0:405:49aa:d578 with SMTP id
 x14-20020a05600c2a4e00b0040549aad578mr21315556wme.37.1697112250799; 
 Thu, 12 Oct 2023 05:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmneIq8iffgBoWoc+/ZUG0TG3y+ZCXsZ7fOzdepK520Rzp4hRbP0nsfeVk16qFBryPTe7hWg==
X-Received: by 2002:a05:600c:2a4e:b0:405:49aa:d578 with SMTP id
 x14-20020a05600c2a4e00b0040549aad578mr21315525wme.37.1697112250457; 
 Thu, 12 Oct 2023 05:04:10 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m19-20020a7bcb93000000b003fe61c33df5sm21777880wmi.3.2023.10.12.05.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 05:04:09 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  Fam Zheng <fam@euphon.net>,  Eric Blake
 <eblake@redhat.com>,  libvir-list@redhat.com,  Leonardo Bras
 <leobras@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH v3 3/4] migration: Deprecate block migration
In-Reply-To: <87r0m0yxb2.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 12 Oct 2023 12:01:05 +0200")
References: <20231011204711.9744-1-quintela@redhat.com>
 <20231011204711.9744-4-quintela@redhat.com>
 <87r0m0yxb2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 12 Oct 2023 14:04:08 +0200
Message-ID: <87cyxk6o93.fsf@secure.mitica>
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

Markus Armbruster <armbru@redhat.com> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> It is obsolete.  It is better to use driver-mirror with NBD instead.
>
> drive-mirror
>
> Several more below.

Done.

>> +# Features:
>> +#
>> +# @deprecated: @disk migration is deprecated.  Use driver-mirror
>> +#     with NBD instead.
>> +#
>
> Suggest:
>
>    # @deprecated: Member @disk is deprecated because block migration is.

Done.

>>  # Since: 0.14
>>  ##
>>  { 'struct': 'MigrationInfo',
>>    'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
>> -           '*disk': 'MigrationStats',
>> +           '*disk': { 'type': 'MigrationStats', 'features': ['deprecated'] },
>>             '*vfio': 'VfioStats',
>>             '*xbzrle-cache': 'XBZRLECacheStats',
>>             '*total-time': 'int',
>> @@ -526,6 +531,9 @@
>>  #
>>  # Features:
>>  #
>> +# @deprecated: @block migration is deprecated.  Use driver-mirror
>> +#     with NBD instead.
>> +#
>
> Suggest:
>
>    # @deprecated: Member @block is deprecated.  Use drrive-mirror with
>    # NBD instead.

Done.

>>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>>  #
>>  # Since: 1.2
>> @@ -535,7 +543,8 @@
>>             'compress', 'events', 'postcopy-ram',
>>             { 'name': 'x-colo', 'features': [ 'unstable' ] },
>>             'release-ram',
>> -           'block', 'return-path', 'pause-before-switchover', 'multifd',
>> +           { 'name': 'block', 'features': [ 'deprecated' ] },
>> +           'return-path', 'pause-before-switchover', 'multifd',
>>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
>>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>             'validate-uuid', 'background-snapshot',
>> @@ -826,6 +835,9 @@
>>  #
>>  # Features:
>>  #
>> +# @deprecated: Member @block-incremental is obsolete. Use
>> +#     driver-mirror with NBD instead.
>> +#
>
> Wait!  This is what PATCH 1 tells users to use instead of deprecated
> @inc.  You need to update that deprecation note to point to a
> non-deprecated replacement.

I don't have.
I want to deprecate the whole thing.
But the options are more urgent to deprecate/remove.  They are
implemented in a very hacky way.  Even for migration/qemu standards.

Later, Juan.


