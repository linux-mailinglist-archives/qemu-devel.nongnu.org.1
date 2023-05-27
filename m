Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFAD7132F6
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 09:24:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2oG8-00079j-HW; Sat, 27 May 2023 03:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2oG6-00079E-Ht
 for qemu-devel@nongnu.org; Sat, 27 May 2023 03:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2oG4-0001pi-9e
 for qemu-devel@nongnu.org; Sat, 27 May 2023 03:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685172154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OvnOz0OB+ZdbMk3qkycr+oGenXytAsdOZKGJtwfWv04=;
 b=SLTY0AmeZ9rvMMzB5ocPuegy0TDSOSTbHvdi9eLMOblscJ/incwgSxoHL3ZDsQsHrncSO4
 iZFYfuqa6sXh/tGUkaMYZukblIRoPXA4s+z2IazFG4Z7f6wKFyedSeZqgWoISozjIHJPPp
 /Ru15UkuNDeSo+EL62/36Yk9rdHoE1w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-qvn0lRejMfWi_HXN24FkxA-1; Sat, 27 May 2023 03:22:32 -0400
X-MC-Unique: qvn0lRejMfWi_HXN24FkxA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EB9D80013A;
 Sat, 27 May 2023 07:22:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 195DF492B00;
 Sat, 27 May 2023 07:22:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B3B9B21E692E; Sat, 27 May 2023 09:22:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,  qemu-devel@nongnu.org,
 philmd@linaro.org,  wangyanan55@huawei.com,  pbonzini@redhat.com,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: The madness of ad hoc special IDs
References: <20230522131717.3780533-1-imammedo@redhat.com>
 <877csz6xgd.fsf@pond.sub.org>
 <0d4d72b3-4b21-d371-7d15-bb36b33bbbc4@redhat.com>
Date: Sat, 27 May 2023 09:22:30 +0200
In-Reply-To: <0d4d72b3-4b21-d371-7d15-bb36b33bbbc4@redhat.com> (Thomas Huth's
 message of "Tue, 23 May 2023 15:06:40 +0200")
Message-ID: <87353i1bnt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

Thomas Huth <thuth@redhat.com> writes:

> On 23/05/2023 14.31, Markus Armbruster wrote:
> ...
>> To stop creating more moles, we need to reserve IDs for the system's
>> use, and let the system pick only reserved IDs going forward.
>
> Just something to add here: We already have a function for generating
> internal IDs, the id_generate() function in util/id.c ... our
> convention is that we use "#" as prefix for those, so for new code
> (which is not affected by migration backward compatibility problems),
> we should maybe take care of always using that prefix for internal
> IDs, too.

Valid point.


