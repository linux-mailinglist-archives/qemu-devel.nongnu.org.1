Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 568C07DCB71
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:08:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmc0-0002Pj-G3; Tue, 31 Oct 2023 07:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxmbu-0002PR-UW
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxmbp-0006WU-GL
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698750512;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qibhGXNW1VsSIK8Nh40bXDKI49OsHrya4M7cyJlCRiE=;
 b=JqQEQ13f3lpBuOSuBCdtwGCHsXrwGx7BlmLFlVala8fWAuN3+L4IpfKvt+BRVa6OkNcg/Y
 qkXypBdgn01sUXEq86KnwEFVZ1TsxwePTsW42ZqkSfwkc8oSG7bk3uRVUBjZWCp/LwaWSU
 xumpSXUWM8qIR6yOAaaokfACUL0dbjE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-B3D9b9W7Ow6uu4ze-xIEvg-1; Tue, 31 Oct 2023 07:08:20 -0400
X-MC-Unique: B3D9b9W7Ow6uu4ze-xIEvg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507b9078aaaso6430556e87.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 04:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698750499; x=1699355299;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qibhGXNW1VsSIK8Nh40bXDKI49OsHrya4M7cyJlCRiE=;
 b=OHSpuCrrpDtqEtOaPRJQ4x46OncA24hyevOhWnoipQmWiq3gcUOv/7vBvKWNL+v9Kj
 rL3hMkQzlH9i/ECMfF19YLhePTbzHUkGlk58vYwyhegJNg3Y9Tbmkswq0mjnB2C28TTJ
 QKwN/DNphAkNBaj8OEF17npZ+huybkQ8FHcwLpa9FB0jV8akvkd3AzdUK8NxZ1OqQA1m
 lsMLef/b92+RPcht+1MpkoV0gIMcy+v4yyPwCWTeMdmp2zGDHn+4FYZ/+zroj3ht4SRU
 WoUCIMYP5Nfw1VA4ybAvPsaHMDrukHO3nirRJKGg+EAlGZQBx8QkGRBwrvBmUej5JCDI
 xC8w==
X-Gm-Message-State: AOJu0YzpCwgfRjQ12jsbRYhR5+S7SLUmfwDxUllaKKM7010EBXlNGWHf
 IBSd44S6C3HmZt4YN3mKy+qnPkRFgvcuRN+QbeLCVvPuunGF6mE2UAGkgen6mWytYW1U5NafPmh
 Q9mRYfYJMj9liIGE=
X-Received: by 2002:ac2:53a8:0:b0:508:19d6:d520 with SMTP id
 j8-20020ac253a8000000b0050819d6d520mr9084707lfh.44.1698750498992; 
 Tue, 31 Oct 2023 04:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsebtRHGaqntznSi3FOE05nXLhjTANsjR33PW8zYPd4myb5h5wYisbQ/PiUWKts5a8FQdIEA==
X-Received: by 2002:ac2:53a8:0:b0:508:19d6:d520 with SMTP id
 j8-20020ac253a8000000b0050819d6d520mr9084693lfh.44.1698750498646; 
 Tue, 31 Oct 2023 04:08:18 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m16-20020a7bca50000000b004083996dad8sm1416733wml.18.2023.10.31.04.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 04:08:18 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3 3/4] migration/qapi: Replace @MigrateSetParameters
 with @MigrationParameters
In-Reply-To: <877cnrjd71.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 13 Oct 2023 07:36:50 +0200")
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-4-peterx@redhat.com>
 <87fs30is78.fsf@pond.sub.org> <ZRsff7Lmy7TnggK9@x1n>
 <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
 <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
 <875y3dixzp.fsf@pond.sub.org> <8734yhgrzl.fsf@pond.sub.org>
 <ZShI4AucDGvUvJiS@x1n> <877cnrjd71.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 12:08:17 +0100
Message-ID: <87zfzz82xq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> wrote:
> Peter Xu <peterx@redhat.com> writes:
>
>> On Wed, Oct 11, 2023 at 04:21:02PM +0200, Markus Armbruster wrote:

>> IIRC both of them used to be the goals: either allow compat properties for
>> old machine types, or specify migration parameters in cmdline for easier
>> debugging and tests.  I use "-global" in mostly every migration test script
>> after it's introduced.
>
> You use -global just because it's easier than using monitor commands,
> correct?

It is long history.  But to make things easier I will try to resume.
In the beggining there was no "defer" method, so it was imposible to
setup migration-channels and that kind of information.
So we created that -global migration properties.

Time pass, and we need to fix that for real, because more and more
migration parameters need to be set bofer we start incoming migration.
So we create migration "defer" method.  And now we can set things from
the command line/QMP.

But when one is testing (i.e. migration developers), using the global
property is much easier.

I am always tempted to modify the monitor command line to allow "read
the commands from this file at startup".

> Configuration is almost entirely special (own QMP commands for
> everything), with a little abuse of general infrastructure stirred in
> (-global, compat props).  Having capabilities in addition to parameters
> is a useless complication.  Too many features of questionable utility
> with way too many configuration knobs.

I also remember that one.
In the beggining all migration options were bools.  So we have named
capabilities.  At some point we needed parameters that were not bools,
so we had to get the parameters thing because all the migration code
supposed that the capabilities were bool.

No, I am not defending the choices we made at the time, but that is how
it happened.  To be fair, when I have a new "bool" to add to migration,
I am never sure if I have to add it as a capability or as a parameter
that returns bool.


Later, Juan.


