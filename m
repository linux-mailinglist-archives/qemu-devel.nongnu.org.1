Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF98E73A902
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 21:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQ2Y-0005aw-1c; Thu, 22 Jun 2023 15:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQ2W-0005Zi-3T
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQ2U-0002iY-Er
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687462335;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+8aCizdY8GKSrLR9cehw3CsMh0xGFQBV+fRh2a6f7Y=;
 b=RAoW2ZPDu7H63167oIVybGZtOFRAwe2xU+0XxNoJfgKoWwe6q1VqFkiUNhx6ixdtlcsl62
 hQQrwhVkC0C6/TEgf3fABwcQm/NW4R/89HKYvCZIxDSVWSAPb2Bdsz3ES1C3d2HirKsCY0
 /oR8j2dgoHLvXNWeBefDcAZ3t+RXURI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-DI1-UWkDMwe8C-6aWomqZw-1; Thu, 22 Jun 2023 15:32:12 -0400
X-MC-Unique: DI1-UWkDMwe8C-6aWomqZw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3129750e403so619281f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 12:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687462323; x=1690054323;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z+8aCizdY8GKSrLR9cehw3CsMh0xGFQBV+fRh2a6f7Y=;
 b=AMZNqBSFUOcPWoMI6Tp6m3KL0TYJGEheEgiq9RLcNw17+hz+F2gXlbWzX61t7npoI6
 dcGVeV/fSogLAPCPfTP0ugPQCXuxgw2ZwCmUV5mWLIKEuuE7jglsWu+XRnD5aSAlfhIr
 f3VFbzZd3/vMcFOvpOTFmj/MbJrFXWDCeWs2d8oYd+PRIW/VBNMpSKc9gOgOldWtA4Re
 2ikve0Zbz4WCfF0ZpipjOcPLgdRyX4EqmX5N8Wgbz5E4r7B2WOP3cLZBEMTN74RqkAK0
 YRElhRIu5hGW7brmjwdl2Q0TgUh3Xbu2sIsJ6BA10FuV23h6lDEH1q+kdpusTAAYXNDL
 KaQQ==
X-Gm-Message-State: AC+VfDwrRQeTzuwU+c4hPtki+/4m62lhOO1zJUvDDqC/xXUTvDCu3BTn
 8Nqr/tm5UrOO73Jal3vypnh2DlZzcCgjAUHfu4YTvdDBhkB+kCyCPc0UexOPZoXabdlU5ktnmTE
 QILu5gdnmzuat3uY=
X-Received: by 2002:adf:fa83:0:b0:30d:44a1:99a with SMTP id
 h3-20020adffa83000000b0030d44a1099amr14565175wrr.54.1687462323541; 
 Thu, 22 Jun 2023 12:32:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bWvCPoPCIr1sOfytAWNoj2FqMDoWEwf6izBBuTHrs1i2j3iYhJjJpPqz5JGZg7H6nJ/heEQ==
X-Received: by 2002:adf:fa83:0:b0:30d:44a1:99a with SMTP id
 h3-20020adffa83000000b0030d44a1099amr14565157wrr.54.1687462323250; 
 Thu, 22 Jun 2023 12:32:03 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 l8-20020a05600012c800b0030ae4350212sm7715685wrx.66.2023.06.22.12.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 12:32:02 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  qemu-block@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  Thomas Huth
 <thuth@redhat.com>,  libvir-list@redhat.com,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [RFC 6/6] migration: Deprecated old compression method
In-Reply-To: <ZJLRj02koQn4jXHi@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 21 Jun 2023 11:31:43 +0100")
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-7-quintela@redhat.com>
 <ZJLRj02koQn4jXHi@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 21:32:01 +0200
Message-ID: <87jzvve1ji.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Mon, Jun 12, 2023 at 09:33:44PM +0200, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  docs/about/deprecated.rst |  8 ++++
>>  qapi/migration.json       | 92 ++++++++++++++++++++++++---------------
>>  migration/options.c       | 13 ++++++
>>  3 files changed, 79 insertions(+), 34 deletions(-)
>>=20
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 173c5ba5cb..fe7f2bbde8 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -460,3 +460,11 @@ block migration (since 8.1)
>>  Block migration is too inflexible.  It needs to migrate all block
>>  devices or none.  Use driver_mirror+NBD instead.
>>=20=20
>> +old compression method (since 8.1)
>> +''''''''''''''''''''''''''''''''''
>> +
>> +Compression method fails too much.  Too many races.  We are going to
>> +remove it if nobody fixes it.  For starters, migration-test
>> +compression tests are disabled becase they hand randomly.  If you need
>> +compression, use multifd compression methods.
>> +
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index a8497de48d..40a8b5d124 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -244,6 +244,7 @@
>>  #
>>  # @compression: migration compression statistics, only returned if
>>  #     compression feature is on and status is 'active' or 'completed'
>> +#     It is obsolete and deprecated.  Use multifd compression methods.
>>  #     (Since 3.1)
>
> This doesn't give users an indication /why/ we're saying this. Instead
> I'd suggest
>
>   This feature is unreliable and not tested. It is recommended to
>   use multifd migration instead, which offers an alternative reliable
>   and tested compression implementation.

Much better.  Done, thanks.


>>  # @deprecated: @disk migration is deprecated.  Use driver_mirror+NBD
>> -#     instead.
>> +#     instead. @compression is obsolete use multifd compression
>> +#     methods instead.
>
> For @deprecated, are we supposed to list multiple things at once, or
> use a separate @deprecated tag for each one ?

# @unstable: Members @x-colo and @x-ignore-shared are experimental.

This is the only example that I found that is similar.
Only one example.  Markus?

>
> Again I'd suggest rewording
>
>     @compression is unreliable and untested. It is recommended to
>     use multifd migration, which offers an alternative compression
>     implementation that is reliable and tested.

Done.



>> @@ -443,6 +443,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_c=
aps, Error **errp)
>>                      "Use driver_mirror+NBD instead.");
>>      }
>>=20=20
>> +    if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
>
> Surely MIGRATION_CAPABILITY_COMPRESS not BLOCK ?

Good catch.  Copy & paste to its best.

Thanks very much.


