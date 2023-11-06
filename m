Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD337E27A9
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:51:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00wZ-0003pE-2a; Mon, 06 Nov 2023 09:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r00wW-0003oW-HM
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:51:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r00wU-00041l-7J
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699282265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8GOpWvH+JyebVK5M8WU7x+YaHwAL46964xncMbKRbq8=;
 b=G3zdlqsNSYak56Ut7E2vLSeKGlkd5feKvJSM1ZQD63ZKh80g2IQ7bG83vh19J+ZtqEgn7M
 qezE4QoBSssNWDFqzCl0volIVOV0RGh9nmILEv1tq8Z9WdWdCzbOwdH+pDRczWuId333Oj
 Wygmk7CqyclozdlE+XQ5l7flM7mdf2k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-pb0vJfVsOgScnW_V4mMnEQ-1; Mon, 06 Nov 2023 09:51:03 -0500
X-MC-Unique: pb0vJfVsOgScnW_V4mMnEQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c6f33ee403so41462951fa.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699282262; x=1699887062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8GOpWvH+JyebVK5M8WU7x+YaHwAL46964xncMbKRbq8=;
 b=b3vn/Ke+awsfRU/QVGjE3d6WhAFHcyHOjNwi6z7nNv1lSRv3WPFsmJkLKnJYEXgXp+
 FstxdokPHQ48g4YWoXmyQ9FQPYqWs+nCv9yHPjxsSpAmlJ3p/AWmFCWR2vazNlrkJwNu
 E0LJ+zpp4NnLyay5PLL4sADKd6PbGkikQJ0U1fq9peW6t/4HyE91Mc/6CcqINl7XuP7n
 Z2EtFuQ36dvsSsaLwf6jXXsGz8Mteoq0uNi2KqDfiiXEZUOWbpWCvtdlsY012CuItflu
 vBGiNqKHOvJlaorGa68CIDrU5tz2Gb4kqnsM+EksrtIVT8HCGrqXkvOHJjC70n7GhHkt
 lFAg==
X-Gm-Message-State: AOJu0YwIIZ/EeCfa7KHkLg7bAnNq6FJeQooEKkEnbDs3/yyeyyM4edy3
 oA/Flk4Wmv6sItxoyH9G3WvImv6WtpTgbO0+b9BH8SdCCtXS0iZ3ucJNvzlea4hjwgU8H+kHz35
 7r8/FzQ7dkAmVYzQ=
X-Received: by 2002:a2e:9d55:0:b0:2c5:1674:8d79 with SMTP id
 y21-20020a2e9d55000000b002c516748d79mr23250834ljj.21.1699282262282; 
 Mon, 06 Nov 2023 06:51:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRMq/92mBJKzAfIhsYOt/jPwAGQQzfQg9gqWI59oIYLVsmBtZfQ25nT4431gCh8JPigy4vsQ==
X-Received: by 2002:a2e:9d55:0:b0:2c5:1674:8d79 with SMTP id
 y21-20020a2e9d55000000b002c516748d79mr23250823ljj.21.1699282261991; 
 Mon, 06 Nov 2023 06:51:01 -0800 (PST)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 r7-20020adff107000000b0032db8f7f378sm9754540wro.71.2023.11.06.06.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:51:01 -0800 (PST)
Message-ID: <a9d0abf4-fc79-461f-bd43-1d79b177de02@redhat.com>
Date: Mon, 6 Nov 2023 15:51:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] block: Allow the wrapper script to see functions
 declared in qapi.h
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Jo=C3=A3o_Silva?=
 <jsilva@suse.de>, Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20230609201910.12100-1-farosas@suse.de>
 <20230609201910.12100-4-farosas@suse.de>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230609201910.12100-4-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 09.06.23 22:19, Fabiano Rosas wrote:
> The following patches will add co_wrapper annotations to functions
> declared in qapi.h. Add that header to the set of files used by
> block-coroutine-wrapper.py.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   block/meson.build                  | 1 +
>   scripts/block-coroutine-wrapper.py | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


