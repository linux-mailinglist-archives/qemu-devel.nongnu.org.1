Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BBE7BF2BF
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 08:06:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq5rd-0001ln-Mq; Tue, 10 Oct 2023 02:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qq5ra-0001lP-P4
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 02:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qq5rZ-0004yF-47
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 02:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696917899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UYqWw/RwqpLJwfmK5aZGjQp0N41vM1xGrh78MRhKzE4=;
 b=URhXj5B88hnwb0OvAkPnxc41oegaaLS09b+6AxB+lad8RZ4NSbsIKtUgIcCegFrvAqsmZ5
 8z5gmCsZHyea5RXeGdTC+OIaM/e0pgzh/B2Cr0R5SiGsK3lD/X6dYr62zqNxNjAhYKUG+L
 WUUwVMGUz5qF5HuUFf9RJvaNuD0Cg1s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-_xkuct4uPJm33VdED22dLg-1; Tue, 10 Oct 2023 02:04:42 -0400
X-MC-Unique: _xkuct4uPJm33VdED22dLg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81F411C0515C;
 Tue, 10 Oct 2023 06:04:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2607C47AD4A;
 Tue, 10 Oct 2023 06:04:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1937921E6904; Tue, 10 Oct 2023 08:04:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Brian Cain <bcain@quicinc.com>,  "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,  "anjo@rev.ng" <anjo@rev.ng>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,  "Matheus
 Bernardino (QUIC)" <quic_mathbern@quicinc.com>,  "stefanha@redhat.com"
 <stefanha@redhat.com>,  "ale@rev.ng" <ale@rev.ng>,  "Marco Liebel (QUIC)"
 <quic_mliebel@quicinc.com>,  "ltaylorsimpson@gmail.com"
 <ltaylorsimpson@gmail.com>,  Thomas Huth <thuth@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-4-bcain@quicinc.com>
 <48c5233c-c294-f50d-a438-f7f6a63c113b@linaro.org>
 <187100e7-a516-4024-1739-a08c630d76f3@linaro.org>
 <BN7PR02MB4194900078A1AA6E067FE20FB8CEA@BN7PR02MB4194.namprd02.prod.outlook.com>
 <0aa445c4-d39d-e28a-6bb0-00f7b9f12bb0@linaro.org>
Date: Tue, 10 Oct 2023 08:04:40 +0200
In-Reply-To: <0aa445c4-d39d-e28a-6bb0-00f7b9f12bb0@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 10 Oct 2023 07:22:31
 +0200")
Message-ID: <87jzrvvwqv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

[...]

> If we have to clean that for -Wshadow=3Dglobal, I'm tempted to rename
> the typedef as 'vaddr_t' and keep the 'vaddr' variable names.

POSIX reserves suffix _t, see
https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#t=
ag_15_02_02

Do we care?

> Richard, Anton, what do you think?

[...]


