Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D23A23AA5
	for <lists+qemu-devel@lfdr.de>; Fri, 31 Jan 2025 09:32:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdmQL-000380-Ed; Fri, 31 Jan 2025 03:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tdmQ1-00036s-Sl
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 03:30:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tdmPq-0004t3-59
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 03:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738312216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CAYldfUaj/mx9BjKE+e/VwgqDMGx7ZSH4EzyQW2XMX0=;
 b=crK/2oIohKj5oImjjLJIcQlV3YhEsv0eOsH+PKXWJjpn8eIoyjjgsB/McdXYZc+seOHVoJ
 VmuPpgMkPBnFuAjCe73H+8/oe6zJmRqiSNzH7d3VDY+wQnzpvz4ZO1zhUw5JJCy9//O/oF
 zTYFvS9EjFMwyiSF/OR+4Ku145rF5/c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-LTtF1q0qN5mlRINE7A7_8g-1; Fri,
 31 Jan 2025 03:30:11 -0500
X-MC-Unique: LTtF1q0qN5mlRINE7A7_8g-1
X-Mimecast-MFC-AGG-ID: LTtF1q0qN5mlRINE7A7_8g
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A7161955F2D
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 08:30:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.71])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFF541800980
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 08:30:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9131521E6A28; Fri, 31 Jan 2025 09:30:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/9] util/error: Introduce warn_report_once_err()
In-Reply-To: <06a2532d-bbfa-4a7d-aade-7813173d8ca2@redhat.com>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Thu, 30 Jan 2025 22:26:42 +0100")
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-2-clg@redhat.com>
 <20250130105529.205cbdb2.alex.williamson@redhat.com>
 <06a2532d-bbfa-4a7d-aade-7813173d8ca2@redhat.com>
Date: Fri, 31 Jan 2025 09:30:05 +0100
Message-ID: <87jzabo06q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> On 1/30/25 18:55, Alex Williamson wrote:
>> On Thu, 30 Jan 2025 14:43:38 +0100
>> C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>>=20
>>> Depending on the configuration, a passthrough device may produce
>>> recurring DMA mapping errors at runtime and produce a lot of
>>> output. It is useful to report only once.
>>>
>>> Cc: Markus Armbruster <armbru@redhat.com>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>>> ---
>>>   include/qapi/error.h | 5 +++++
>>>   util/error.c         | 9 +++++++++
>>>   2 files changed, 14 insertions(+)
>>>
>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>> index 71f8fb2c50eee9a544992d0c05263c9793956fe1..b6ea274882b9788b64d4bb2=
13c3458d7c674a881 100644
>>> --- a/include/qapi/error.h
>>> +++ b/include/qapi/error.h
>>> @@ -448,6 +448,11 @@ void error_free_or_abort(Error **errp);
>>>    */
>>>   void warn_report_err(Error *err);
>>>   +/*
>>> + * Convenience function to call warn_report_err() once.
>>> + */
>>> +void warn_report_once_err(Error *err);
>>> +
>> Turning it into a macro would do what you want:
>> #define warn_report_once_err(err) ({ \
>>      static bool print_once_;         \
>>      if (!print_once_) {              \
>>          warn_report_err(err);        \
>>          print_once_ =3D true;          \
>>      }                                \
>> })
>> So long as we only want once per call site and not once per object,
>> which would pull in something like warn_report_once_cond().  Thanks,
>
> yeah. I came up with this :
>
> /*
>  * TODO: move to util/
>  */
> static bool warn_report_once_err_cond(bool *printed, Error *err)
> {
>     if (*printed) {
>         error_free(err);
>         return false;
>     }
>     *printed =3D true;
>     warn_report_err(err);
>     return true;
> }
>
> #define warn_report_once_err(err)                           \
>     ({                                                      \
>         static bool print_once_;                            \
>         warn_report_once_err_cond(&print_once_, err);       \
>     })
>
>
> I don't know where to put it though. It sits in between qapi/error.h
> and qemu/error-report.h.

Stuff involving the Error type should not go into qemu/error-report.h.
Precedence: warn_report_err() & friends are in qapi/error.h even though
they're straightforward wrappers around warn_report() & friends for easy
use with Error.


