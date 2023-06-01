Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A2271979D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:49:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4euE-00061W-CQ; Thu, 01 Jun 2023 05:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4euC-00060S-6K
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4euA-0004UV-BT
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685612857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUfpQGGQHBRxaPS3zUMosZgBun6AcqccGHN2Nr/2M2c=;
 b=SHRRX7K6g8ljsyuFOLgWO/JA5QQWOklaBxZnfOweUP+z/110FTSrVy1lATL3IhSe3rvC6l
 E3jPWKkMoxGaBxEReRL9CECpK+0nBKZAY8fWejP5hdI6rdgqPgzMDknb3yfTSHSL8grLjD
 aSq6IrCXXOef2A4fU/hcliR7VpCkdbU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-d1qf91pjM3iyI8yAH7gnKA-1; Thu, 01 Jun 2023 05:47:35 -0400
X-MC-Unique: d1qf91pjM3iyI8yAH7gnKA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30ae18b11bfso372773f8f.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685612854; x=1688204854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qUfpQGGQHBRxaPS3zUMosZgBun6AcqccGHN2Nr/2M2c=;
 b=S0PLkl/Y35y9Q5XPuyXDxLi5MnbKF21p9DfnCJaDRHjcvapohGvd3SqRUFVpDYOsHF
 /tSiNpnER0lYRRGvcpR8xZeCIL2XlMJXXSaA81lg1iHQKIyH9JXs2RIPbHEG22qqY+uu
 deJM7n8DKG3VAs8agqc5lD/I5OjHp7w/jsCj1zblvk2fr/JshQDyDyZ85IrFDpgBorXR
 3QQGDG1neJ2P0Zc52YhviR7xdli3xDKt77B//HPY2Ysb7sQqLQlqerLxvjqwfXLBoTTk
 lnvkglXp7ebmfPhJjS8gBcYhE/4cLVfS22YkqEanA3g+7QTcbNEDaH2jvO4BV72PZNk2
 g+bg==
X-Gm-Message-State: AC+VfDwgSNZRW10hHQBhXI2x3HLiZSXuMQGf9EZvE7rs3vRpzn5xa9QY
 bvm0RarLY1+9q7Bc3Bb0rMMrkG3sdwVTNY4F4fAwHJlMBAJTdmjfZYYaNNmGCT3aMGTd8emb13R
 7JNYczbP/iWjuAr5skxPjt/A=
X-Received: by 2002:a05:6000:180c:b0:30a:f60a:dc3c with SMTP id
 m12-20020a056000180c00b0030af60adc3cmr1048717wrh.24.1685612854660; 
 Thu, 01 Jun 2023 02:47:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6QLGBxrTBaV+WSGro2wVj+9JNKcFoRy6M4I9wFLGPR+cnwAXbW2YUuJtkp01Jg4YXZPNnjFA==
X-Received: by 2002:a05:6000:180c:b0:30a:f60a:dc3c with SMTP id
 m12-20020a056000180c00b0030af60adc3cmr1048689wrh.24.1685612854399; 
 Thu, 01 Jun 2023 02:47:34 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-86.web.vodafone.de.
 [109.43.178.86]) by smtp.gmail.com with ESMTPSA id
 cs1-20020a056000088100b002e5f6f8fc4fsm9817809wrb.100.2023.06.01.02.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 02:47:33 -0700 (PDT)
Message-ID: <4d3b985b-fdbe-aadb-a0a9-dc682bca87fe@redhat.com>
Date: Thu, 1 Jun 2023 11:47:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 8/9] tests/qtest: make more migration pre-copy
 scenarios run non-live
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-9-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230531132400.1129576-9-berrange@redhat.com>
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
> There are 27 pre-copy live migration scenarios being tested. In all of
> these we force non-convergance and run for one iteration, then let it
> converge and wait for completion during the second (or following)
> iterations. At 3 mbps bandwidth limit the first iteration takes a very
> long time (~30 seconds).
> 
> While it is important to test the migration passes and convergance

s/convergance/convergence/ (also in the first paragraph)

> logic, it is overkill to do this for all 27 pre-copy scenarios. The
> TLS migration scenarios in particular are merely exercising different
> code paths during connection establishment.
> 
> To optimize time taken, switch most of the test scenarios to run
> non-live (ie guest CPUs paused) with no bandwidth limits. This gives
> a massive speed up for most of the test scenarios.
> 
> For test coverage the following scenarios are unchanged
> 
>   * Precopy with UNIX sockets
>   * Precopy with UNIX sockets and dirty ring tracking
>   * Precopy with XBZRLE
>   * Precopy with UNIX compress
>   * Precopy with UNIX compress (nowait)
>   * Precopy with multifd
> 
> On a test machine this reduces execution time from 13 minutes to
> 8 minutes.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/migration-test.c | 81 +++++++++++++++++++++++++++++-------
>   1 file changed, 66 insertions(+), 15 deletions(-)

Tested-by: Thomas Huth <thuth@redhat.com>


