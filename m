Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 941A27B7F32
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:35:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo15S-0005ZY-HB; Wed, 04 Oct 2023 08:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qo15Q-0005Vx-5Y
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qo15O-0000M3-ND
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696422882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSDN2aAg6e2rHShoomM/ovnxcIiEXrzJwHt38sYor1g=;
 b=QR6o4MLciLfcRWR3x02ZipXjUo+ZUVxerbqJ1bSDpYcVhW7rswQvW9WHM+waO54CDHThzW
 LlNRgZAqtOS5LX76KzE/K3AZfXTB+kNqdACxRbq6ZhtxzHWETAiVhd1duHsT3XIn/fmqOX
 jeyxpZTEq7Ggj+SRGLxHpfIuLPmf6dM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-jSs1TnXeNeyzW_7eealIiQ-1; Wed, 04 Oct 2023 08:34:38 -0400
X-MC-Unique: jSs1TnXeNeyzW_7eealIiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B726C29AA3BF;
 Wed,  4 Oct 2023 12:34:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 957DE2156711;
 Wed,  4 Oct 2023 12:34:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 88F4021E6904; Wed,  4 Oct 2023 14:34:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 09/16] semihosting: Clean up global variable shadowing
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-10-philmd@linaro.org>
 <87lecih9a7.fsf@linaro.org>
Date: Wed, 04 Oct 2023 14:34:36 +0200
In-Reply-To: <87lecih9a7.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 04 Oct 2023 13:16:36 +0100")
Message-ID: <87fs2qefc3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
>> Fix:
>>
>>   semihosting/config.c:134:49: error: declaration shadows a variable in =
the global scope [-Werror,-Wshadow]
>>   int qemu_semihosting_config_options(const char *optarg)
>>                                                   ^
>>   /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt=
.h:77:14: note: previous declaration is here
>>   extern char *optarg;                    /* getopt(3) external
>>   variables */
>
> I'm going to assume the getopt.h is somehow swept up by osdep.h?

It comes from unitstd.h via osdep.h.  getopt.h provides getopt_long() &
friends.
>
> Anyway:
>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


