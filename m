Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1FD8B3976
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Apr 2024 16:07:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MCy-0008Qe-5V; Fri, 26 Apr 2024 10:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0MCs-0008PC-2B
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0MCq-00062Z-HX
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714140339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o/tHiW+blbX9XljI8vRhkcT9GGScH0ng7MDjmldS/mE=;
 b=Ang3QpTUT4rcMUZrINBGb+6IB93kD/xAURYvd1WRe7joD67cQc9HAEWbjnYiMu+Tx8LihG
 b10h0ArGFsEmToDcbWuEwExbRyh5l9pS5RIEDxKN2FAsolcEqHlTrIjv1BaJyM6ydPvGnX
 c34UK+yKixC0jtDNO6ALoY43ODLouew=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-ymtZ6QJKMvybMnUir0HRDg-1; Fri,
 26 Apr 2024 10:05:36 -0400
X-MC-Unique: ymtZ6QJKMvybMnUir0HRDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E59863C0009E;
 Fri, 26 Apr 2024 14:05:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C64F3200BCFA;
 Fri, 26 Apr 2024 14:05:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B858021E6811; Fri, 26 Apr 2024 16:05:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Xu
 <peterx@redhat.com>, devel@lists.libvirt.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Eric Blake <eblake@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 3/6] migration: Remove 'blk/-b' option from migrate
 commands
In-Reply-To: <87y190s1a1.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 26 Apr 2024 15:26:30 +0200")
References: <20240425150939.19268-1-farosas@suse.de>
 <20240425150939.19268-4-farosas@suse.de> <87y190s1a1.fsf@pond.sub.org>
Date: Fri, 26 Apr 2024 16:05:34 +0200
Message-ID: <87o79wrzgx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> The block migration is considered obsolete and has been deprecated in
>> 8.2. Remove the migrate command option that enables it. This only
>> affects the QMP and HMP commands, the feature can still be accessed by
>> setting the migration 'block' capability. The whole feature will be
>> removed in a future patch.
>>
>> Deprecation commit 8846b5bfca ("migration: migrate 'blk' command
>> option is deprecated.").
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

I think you missed the update to hmp-commands.hx.  I almost missed it,
too :)


