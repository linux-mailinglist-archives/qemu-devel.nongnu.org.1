Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 741F0713332
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 10:00:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2opk-0003x8-Hk; Sat, 27 May 2023 03:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2opg-0003ww-1e
 for qemu-devel@nongnu.org; Sat, 27 May 2023 03:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2ope-0008Sx-Ll
 for qemu-devel@nongnu.org; Sat, 27 May 2023 03:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685174361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x+Rg6A2+nJDybtjWE2MSsd2ER3R7+nYv52T9iq8EyHg=;
 b=hOkt9T8GJhShw4qFE/BwBJal/z2Q9kmowQu4NZhWFLrf8xjH/L5riyjMcRYM5cybWpc1+a
 6JtxSt5BPwHgqtj0tM5sXeiIeLJr5bNp8aDT5I2Mfa4gWvcEDtqUDdg7EJOaYcBcWg5Taz
 FIh8agNkS/BQTcNyQx4ivqCx/MIPs0I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-ONIb0s0aPaO2XU52Y32FlQ-1; Sat, 27 May 2023 03:59:18 -0400
X-MC-Unique: ONIb0s0aPaO2XU52Y32FlQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D21AD2999B24;
 Sat, 27 May 2023 07:59:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0B4BC154D1;
 Sat, 27 May 2023 07:59:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E74221E692E; Sat, 27 May 2023 09:59:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org,  philmd@linaro.org,  wangyanan55@huawei.com,
 pbonzini@redhat.com,  Peter Maydell <peter.maydell@linaro.org>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: The madness of ad hoc special IDs
References: <20230522131717.3780533-1-imammedo@redhat.com>
 <877csz6xgd.fsf@pond.sub.org>
 <0d4d72b3-4b21-d371-7d15-bb36b33bbbc4@redhat.com>
 <87353i1bnt.fsf@pond.sub.org>
Date: Sat, 27 May 2023 09:59:16 +0200
In-Reply-To: <87353i1bnt.fsf@pond.sub.org> (Markus Armbruster's message of
 "Sat, 27 May 2023 09:22:30 +0200")
Message-ID: <87a5xqyzl7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Thomas Huth <thuth@redhat.com> writes:
>
>> On 23/05/2023 14.31, Markus Armbruster wrote:
>> ...
>>> To stop creating more moles, we need to reserve IDs for the system's
>>> use, and let the system pick only reserved IDs going forward.
>>
>> Just something to add here: We already have a function for generating
>> internal IDs, the id_generate() function in util/id.c ... our

id_generate() generates IDs of the form #<subsystem><number>, where
<number> counts up.  Suitable for IDs that are not part of the stable
interface.

When a system-picked ID needs to be part of the stable interface, we
pick it in some other way.

>> convention is that we use "#" as prefix for those, so for new code
>> (which is not affected by migration backward compatibility problems),
>> we should maybe take care of always using that prefix for internal
>> IDs, too.
>
> Valid point.

I propose to move towards the QAPI naming rules for user-picked IDs:
must begin with a letter, and contain only ASCII letters, digits,
hyphen, and underscore.


