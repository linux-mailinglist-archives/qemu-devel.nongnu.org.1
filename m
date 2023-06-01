Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7433719723
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:38:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4el6-0002ta-0b; Thu, 01 Jun 2023 05:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4el1-0002tB-Jz
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ekx-0001J5-TB
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685612285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcMLT3KO0r85zIN70w+raiOIU6tc0Vp7e+TRdEu1aNc=;
 b=V7Hfv6PFfIsupt9SL9dh6P8aS+jktdLXcWSFXQmCTIrMuf8XTsKc/UvhzvkTgVyPnBWGIQ
 8nV26wPEwR652b8aMV0joXWB0evnKqUQ9r05kA6TCOxl62W3axX/pg1xchyV8HuGZUqOye
 me/1osMrMoEwNx5+Diyzfc+/92XE4To=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-crEG_KPmNJCeGVsjH6weeA-1; Thu, 01 Jun 2023 05:38:04 -0400
X-MC-Unique: crEG_KPmNJCeGVsjH6weeA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f7005d4a85so3772365e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685612283; x=1688204283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hcMLT3KO0r85zIN70w+raiOIU6tc0Vp7e+TRdEu1aNc=;
 b=ZfvQQOuVq/uGaZRny2LBzvqD2LQARW1qlMZ7cb21V7ebXvetVtgOj4Be7IJL8Ht6Iz
 6r/8aOSJ73CrkLF8gllA8sWDFz5oMpbNWzV3BwB4sanrM+qLksUeLOrBqIan9zqIeTzh
 Qmw8YhE6JLw2dxJdmbbyFmKOghHR630WoWKw53lm1Gu5fMjwysTeh8JosVNi8n+ZNS4t
 s+adPuTzs4Hsj2eyT+zdQuj3Kx5fIovLEAsDYLxTrXg4Yei2wkXFjyGwWTWTmUNC/2I3
 DMWCtr7MI5TZBvjcsvWc1QN60Lhq79jWhpkl8WKTO8MxNWah3nz10NrWnVsphDSlD9Cv
 wtIg==
X-Gm-Message-State: AC+VfDwJ+tEWy8D/tUimM7HVWZRbfdLQ2oazf+bflCEnXXaOfUoV3j/R
 qQu3vI+978mSvPWyZdNBXCkk0nqqm4p5iBUbH5bgjgEdMKtBQjzJ4gi2TFAQTYEfh4Al5TcwAGr
 NpASqakJuZSkVjiI=
X-Received: by 2002:a5d:6045:0:b0:306:489b:3c6 with SMTP id
 j5-20020a5d6045000000b00306489b03c6mr1349012wrt.58.1685612282973; 
 Thu, 01 Jun 2023 02:38:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6etwJP/DZLKjjf9ybD8qaAWt0phEVnAjOticNi9OiOGExz/T5GSTlb4FYBSsAZIEFOIJPV3w==
X-Received: by 2002:a5d:6045:0:b0:306:489b:3c6 with SMTP id
 j5-20020a5d6045000000b00306489b03c6mr1348997wrt.58.1685612282686; 
 Thu, 01 Jun 2023 02:38:02 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-86.web.vodafone.de.
 [109.43.178.86]) by smtp.gmail.com with ESMTPSA id
 r13-20020adfce8d000000b0030630de6fbdsm9532139wrn.13.2023.06.01.02.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 02:38:02 -0700 (PDT)
Message-ID: <870e9e1f-1327-7d4a-1aa9-b5519227749d@redhat.com>
Date: Thu, 1 Jun 2023 11:38:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 7/9] tests/qtest: capture RESUME events during migration
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-8-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230531132400.1129576-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/05/2023 15.23, Daniel P. Berrangé wrote:
> When running migration tests we monitor for a STOP event so we can skip
> redundant waits. This will be needed for the RESUME event too shortly.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/migration-helpers.c | 12 ++++++++++++
>   tests/qtest/migration-helpers.h |  2 ++
>   tests/qtest/migration-test.c    |  5 +++++
>   3 files changed, 19 insertions(+)


Acked-by: Thomas Huth <thuth@redhat.com>


