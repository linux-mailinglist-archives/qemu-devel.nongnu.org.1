Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 932CE739815
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:32:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCEms-00046N-Vc; Thu, 22 Jun 2023 03:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCEme-00045X-GT
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCEmb-0006lX-W0
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687419068;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NrXJc973Aw+qwUB2NskQRr3m482eTOjm/t2oFDdYi4w=;
 b=QrGbfyjyauSwru0CW7SSG5y8kBFlcA75yRdn9GqMqL8e7D+ghkIZglicYEHKBAomfw0+Q+
 ivVaokyWs3qYAnAJwo2dB7yLSOShiX1TWuQVL1ZeCiclif1yGPlF8KHd55/1rSE/IcSHu0
 WDihEwpTT9YU+A1lMYxPVwkHHY82VrE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-Gi4zLuNeMbqH3AWowC_BuQ-1; Thu, 22 Jun 2023 03:31:07 -0400
X-MC-Unique: Gi4zLuNeMbqH3AWowC_BuQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e4d85e1ffso10245464f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 00:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687419066; x=1690011066;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NrXJc973Aw+qwUB2NskQRr3m482eTOjm/t2oFDdYi4w=;
 b=aqJj1J38AUgqcail8O1ZFl0N2g+KkDKJZgC84cQKm0dmgqcbH2hn02XnRycJMw1wee
 PqTptpbUxrOILvJq7v2F8srh77ZGj1wg0TPblNxWDbK9KIhrpfWHtv9cVcE39l8BR4ek
 NDowg2y2shHBCW3kopm3hRzjEb+6xBg9LKfDz5lW5PSQD4FzWiwar/5xnTU6Cde4Q3Yz
 CYyCKA4jAy0Qfu3wnCjEQRr5XCu8RVSsHEzhrY/31NyLN6o99dl+IKfbQZbsQTvNtCVK
 WWXB5S9nebxtgcsI2gKQkHa0xJd2QUvZQN3wR1yxyZAmR1dK5TcsefYZnXA5W8Q7qjD7
 rk+g==
X-Gm-Message-State: AC+VfDw+hebD4srbJcXqHQin7kHfZLQ+Q4TrMuPEk+b0QRK+UUCbqv/a
 LLbrIWZ3BI873+r0k3WhgfK8N8uDt1vHLcyXhxWP8gWtyOWuv74DNQ6YWoUxhLagu9Sy4WEegs7
 IczDU0BR0MM3rHbg=
X-Received: by 2002:adf:f811:0:b0:311:17af:df96 with SMTP id
 s17-20020adff811000000b0031117afdf96mr18008575wrp.44.1687419066060; 
 Thu, 22 Jun 2023 00:31:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4K0nWLKNY0dckfn2mQ/NuSOdPggS1PxmpZdeFcrW2dneSQaWPQPB+hT+NTdV8bRMKp1MqNOQ==
X-Received: by 2002:adf:f811:0:b0:311:17af:df96 with SMTP id
 s17-20020adff811000000b0031117afdf96mr18008553wrp.44.1687419065707; 
 Thu, 22 Jun 2023 00:31:05 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 z11-20020a5d4c8b000000b0030c4d8930b1sm6286808wrs.91.2023.06.22.00.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 00:31:05 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org,  Eric Blake <eblake@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Fam Zheng <fam@euphon.net>,  Laurent Vivier
 <lvivier@redhat.com>
Subject: Re: [PULL 00/30] Next patches
In-Reply-To: <609d91c6-1690-5f2e-57a7-da6e4b1597e4@linaro.org> (Richard
 Henderson's message of "Thu, 22 Jun 2023 07:38:17 +0200")
References: <20230622021320.66124-1-quintela@redhat.com>
 <609d91c6-1690-5f2e-57a7-da6e4b1597e4@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 09:31:04 +0200
Message-ID: <871qi47y2v.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Richard Henderson <richard.henderson@linaro.org> wrote:
> On 6/22/23 04:12, Juan Quintela wrote:
>> The following changes since commit 67fe6ae41da64368bc4936b196fee2bf61f8c720:
>>    Merge tag 'pull-tricore-20230621-1'
>> ofhttps://github.com/bkoppelmann/qemu  into staging (2023-06-21
>> 20:08:48 +0200)
>> are available in the Git repository at:
>>    https://gitlab.com/juan.quintela/qemu.git  tags/next-pull-request
>> for you to fetch changes up to
>> c53dc569d0a0fb76eaa83f353253a897914948f9:
>>    migration/rdma: Split qemu_fopen_rdma() into input/output
>> functions (2023-06-22 02:45:30 +0200)
>> ----------------------------------------------------------------
>> Migration Pull request (20230621)
>> In this pull request:
>> - fix for multifd thread creation (fabiano)
>> - dirtylimity (hyman)
>>    * migration-test will go on next PULL request, as it has failures.
>> - Improve error description (tejus)
>> - improve -incoming and set parameters before calling incoming (wei)
>> - migration atomic counters reviewed patches (quintela)
>> - migration-test refacttoring reviewed (quintela)
>> Please apply.
>
> You really need to test at least one 32-bit host regularly.
> It should be trivial for you to do an i686 build somewhere.
>
> https://gitlab.com/qemu-project/qemu/-/jobs/4518975360#L4817
> https://gitlab.com/qemu-project/qemu/-/jobs/4518975263#L3486
> https://gitlab.com/qemu-project/qemu/-/jobs/4518975261#L3145
> https://gitlab.com/qemu-project/qemu/-/jobs/4518975298#L3372
> https://gitlab.com/qemu-project/qemu/-/jobs/4518975301#L3221
>
> ../softmmu/dirtylimit.c:558:58: error: format specifies type 'long'
> but the argument has type 'int64_t' (aka 'long long')
> [-Werror,-Wformat]
>         error_setg(&err, "invalid dirty page limit %ld", dirty_rate);
>                                                    ~~~   ^~~~~~~~~~
>                                                    %lld

Grrr, sorry.

Will not happen again.

Later, Juan.

>
>
> r~


