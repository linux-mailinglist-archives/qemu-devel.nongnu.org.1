Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA36D86C040
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Feb 2024 06:35:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZ4F-0004Vi-Su; Thu, 29 Feb 2024 00:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfZ4D-0004VR-VW
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:34:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfZ4C-0000cN-Fc
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709184887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ud1XLA+MLSNkvL/2/mRAkKjQWIRdtBkKse3LVFM07Y=;
 b=AcHFv5r9dbobD5UlAVyeN/bX7gbBdP3DdI7VXlz/gtmcXxs0RXzxifV0zOqNqXbbQnz1RJ
 +Pq5ETUMvB/bgeqJ8I/nhmyACVDDBI5kDgnAAYkvDaahRVNn+Qpepo7t86wZ9I2TjSJbpT
 wJ7DZKAfYNhswaM+M5OKod8ROjSLy1A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-swQykrfCNQGd-3qi4IXIng-1; Thu, 29 Feb 2024 00:34:44 -0500
X-MC-Unique: swQykrfCNQGd-3qi4IXIng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F16D3185A780;
 Thu, 29 Feb 2024 05:34:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F27B1121312;
 Thu, 29 Feb 2024 05:34:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1EEE521E66D0; Thu, 29 Feb 2024 06:34:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com,  berrange@redhat.com,  eduardo@habkost.net,
 peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 thuth@redhat.com,  lvivier@redhat.com,  jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Subject: Re: [External] Re: [PATCH v3 1/7] migration/multifd: Add new
 migration option zero-page-detection.
In-Reply-To: <CAAYibXjwBTcBFmUUs=L2BfTKgxi3Pym5S-5w-JOsZDmGdb9sgg@mail.gmail.com>
 (Hao Xiang's message of "Wed, 28 Feb 2024 10:30:24 -0800")
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
 <20240226195654.934709-2-hao.xiang@bytedance.com>
 <87msrk2abr.fsf@pond.sub.org>
 <CAAYibXjwBTcBFmUUs=L2BfTKgxi3Pym5S-5w-JOsZDmGdb9sgg@mail.gmail.com>
Date: Thu, 29 Feb 2024 06:34:42 +0100
Message-ID: <87edcvu93h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hao Xiang <hao.xiang@bytedance.com> writes:

> On Wed, Feb 28, 2024 at 1:43=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Hao Xiang <hao.xiang@bytedance.com> writes:
>>
>> > This new parameter controls where the zero page checking is running.
>> > 1. If this parameter is set to 'legacy', zero page checking is
>> > done in the migration main thread.
>> > 2. If this parameter is set to 'none', zero page checking is disabled.
>> >
>> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>>
>> [...]
>>
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index 5a565d9b8d..1e66272f8f 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -653,6 +653,18 @@
>> >  { 'enum': 'MigMode',
>> >    'data': [ 'normal', 'cpr-reboot' ] }
>> >
>> > +##
>> > +# @ZeroPageDetection:
>> > +#
>> > +# @none: Do not perform zero page checking.
>> > +#
>> > +# @legacy: Perform zero page checking from main migration thread.
>> > +#
>> > +# Since: 9.0
>> > +##
>> > +{ 'enum': 'ZeroPageDetection',
>> > +  'data': [ 'none', 'legacy' ] }
>> > +
>> >  ##
>> >  # @BitmapMigrationBitmapAliasTransform:
>> >  #
>> > @@ -874,6 +886,9 @@
>> >  # @mode: Migration mode. See description in @MigMode. Default is 'nor=
mal'.
>> >  #        (Since 8.2)
>> >  #
>> > +# @zero-page-detection: Whether and how to detect zero pages. More de=
tails
>> > +#     see description in @ZeroPageDetection. Default is 'legacy'.  (s=
ince 9.0)
>> > +#
>>
>> I'm not sure we need to point to the member's type.  If we want to, we
>> better fix the prose: "For additional information, see
>> @ZeroPageDetection" or similar.
>
> This is mimicking what was done for the "mode" migration option. There
> aren't many enumeration types on the interface I can learn from.
>
> Existing code
>
> #
> # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
> # (Since 8.2)

"More details see description in @TYPE" feels off, "See description in
@TYPE" is better.  Feel free to use it instead of my suggested phrasing.

[...]


