Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF327CDA32
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:23:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4d7-0007Ym-It; Wed, 18 Oct 2023 07:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt4d5-0007YF-VQ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt4d4-0004JB-9i
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697628141;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdD92zdUa7HtkSq851i5F3FijmAPCZeGmMpkFwt8FGE=;
 b=ITh4WRIlFjwCIsH8pP59WpbM1w3XaEYsQFvE+NO4BOmuvxl8zIyjWi0Vh8KfJwvKXS/YmU
 d9leWrNlK/MsiTgyPMoZVDw5zN5EC2qTEgwXqERojaRnY8gHAD+y2nIelleesNCaIAMxHs
 DNm56UiF7/4M6TboT7OfT0304t2EQtk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-uWmcBE6gOwa9djfFREg-Yg-1; Wed, 18 Oct 2023 07:22:20 -0400
X-MC-Unique: uWmcBE6gOwa9djfFREg-Yg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5043c463bf9so6380641e87.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 04:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697628134; x=1698232934;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fdD92zdUa7HtkSq851i5F3FijmAPCZeGmMpkFwt8FGE=;
 b=v8Wi7iHRThUBwiJbUun6SMD5zyX99X9KGES90jVOeRsAqjUu++piS5OuLD0ao0FAYM
 yZ37rALp40fapG5GYNckgiTMLttIulfYSaYsUvx/siC0fF+DCdVTRbOn9JycHzxHNiYQ
 QDL1WDCWs4K2wakdPluSG2ykDi4HC3Z5eRydmD039wrtNCkeUiLEFo2z35lkVToYzn2m
 cixPBo+ormwxEv00J2gQaFEojzfcDZYkCBJE4LXuYQdQMAyvnrNCczpfFCAfs4X0cSv/
 crsR6u45aoUmA9Vltd+zdaBzy2sFLlcJGnZ9X3w2dzIv8gwQgdYEqUQ/MzpWFiVxPiNI
 O7Hw==
X-Gm-Message-State: AOJu0YwwWGD5B8u1bXWwzoOVPPC+jAa+T/piKYIFiS2xw8v9BG4ntg+a
 X8Adzn4fy9P+Oyeeml3xy2dg9nFJurqNXZsMB756Z2kFlPh1PjEK42B1s0H9yjTJO4HNcC5Q0eG
 bPrOXqSkC6ysbN7A=
X-Received: by 2002:ac2:5398:0:b0:4f9:54f0:b6db with SMTP id
 g24-20020ac25398000000b004f954f0b6dbmr4198619lfh.13.1697628133732; 
 Wed, 18 Oct 2023 04:22:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPn50hjBeBBj00EtH2oKPqpq6abOtitxJptMUaQ5TsDN/oZwidKLA3b2pCt1MXSv+DvCLzQg==
X-Received: by 2002:ac2:5398:0:b0:4f9:54f0:b6db with SMTP id
 g24-20020ac25398000000b004f954f0b6dbmr4198595lfh.13.1697628133351; 
 Wed, 18 Oct 2023 04:22:13 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 q1-20020adffec1000000b00326b8a0e817sm1889129wrs.84.2023.10.18.04.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 04:22:12 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Fam Zheng
 <fam@euphon.net>,  Peter Xu <peterx@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,
 libvir-list@redhat.com,  Hanna Reitz <hreitz@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v7 0/4] Migration deprecated parts
In-Reply-To: <ZS+43SAy3xEMF4fh@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 18 Oct 2023 11:52:13 +0100")
References: <20231018103204.33444-1-quintela@redhat.com>
 <87bkcwxlkd.fsf@secure.mitica> <ZS+43SAy3xEMF4fh@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 13:22:12 +0200
Message-ID: <87mswgkwez.fsf@secure.mitica>
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Wed, Oct 18, 2023 at 12:38:10PM +0200, Juan Quintela wrote:
>> Juan Quintela <quintela@redhat.com> wrote:
>> > Based on: Message-ID: <20231018100651.32674-1-quintela@redhat.com>
>> >           [PULL 00/11] Migration 20231018 patches
>> >
>> > And here we are, at v7:
>> > - drop black line at the end of deprecated.rst
>> > - change qemu-iotest output due to warnings for deprecation.
>> >
>> > The only real change is the output of the qemu-iotest.  That is the
>> > reason why I maintained the reviewed-by.  But will be happy if anyone
>> > of the block people ack the changes.
>>=20
>> I forgot to include the link to the CI of the previous failure.
>>=20
>> https://gitlab.com/juan.quintela/qemu/-/jobs/5314070229
>>=20
>> tput mismatch (see /builds/juan.quintela/qemu/build/tests/qemu-iotests/s=
cratch/raw-file-183/183.out.bad)
>> --- /builds/juan.quintela/qemu/tests/qemu-iotests/183.out
>> +++ /builds/juan.quintela/qemu/build/tests/qemu-iotests/scratch/raw-file=
-183/183.out.bad
>> @@ -28,6 +28,8 @@
>>  { 'execute': 'migrate',
>>         'arguments': { 'uri': 'unix:SOCK_DIR/migrate', 'blk': true } }
>> +warning: parameter 'blk is deprecated; use blockdev-mirror with NBD ins=
tead
>> +warning: block migration is deprecated; use blockdev-mirror with NBD in=
stead
>>  {"return": {}}
>>  { 'execute': 'query-status' }
>>  {"return": {"status": "postmigrate", "singlestep": false, "running":
>>  false}}
>
> IIUC, the JSON bits are being written on stdout, and the warnings
> are being written on stderr. The interleaving of the data is
> potentially going to be non-deterministic in the .out file.
> Generally you'd want a filter in the iotests that culls the
> warning: lines to avoid this mixing of stdout/err streams.

Thanks.

So here I am, going to v8 to create filters.

Later, Juan.


