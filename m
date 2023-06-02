Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B29F71FB61
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 09:52:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4zaF-00024M-J5; Fri, 02 Jun 2023 03:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4za0-0001oz-3K
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 03:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4zZy-0003h7-LQ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 03:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685692330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vd+sU2J4fZvWweIVk5f6JlMjcWzOoTVfIIklTqVlWjc=;
 b=ZnSXnCU6mCEoNezusqOJqDLPNorbUMjlu5mWanQKqVutq1rvMEcwGb/AIlV9rrApXapHeK
 eEXVVgSIjAKreE/mDDGgkC+BArv88R7c0xvnjhuGZpa0Moat6Vt/FsgmZGoSMKOpu0gBmq
 oWzsjhgKKNU2wFeRMBCNYeVyEaR990U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-PACpRGIBOZWU9gXR5KLnJg-1; Fri, 02 Jun 2023 03:52:08 -0400
X-MC-Unique: PACpRGIBOZWU9gXR5KLnJg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30af81cf4dbso894636f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 00:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685692327; x=1688284327;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vd+sU2J4fZvWweIVk5f6JlMjcWzOoTVfIIklTqVlWjc=;
 b=XL9woK4727/4FT6ULDKQZJJJcAbzizbERuwNIZ7rrLrZ0cNaFQUqiZSqXxGKxsdXft
 4dzrw3GCsxNFsPIv4eb2Dgiyihcona8HbzUkTlPmK0p7oF+4YmzSDxjWzxU0YGDz6EkK
 8maHKy+ouZ1UqVaUuDMYJoqMos3aGflSGi6uKDopyo+I7hH3na1KOHIqmZsguH6v9SOz
 B8JBNPjIhUtemiYc9JwjWE2ODL8FG+k4PfeoftEBetCy0WiwpznDmWUyosk657XRPHVo
 kIj0/8YaeLBro45zjamw28U+28ogpDVHof7mkNrsQ1cCdwttfVJtoFTI7zo2t9NB8xGe
 tMww==
X-Gm-Message-State: AC+VfDyLeuTjX2qLr1DgV9QZMVinGrkcffaE76SQvfnWoIcPztOQWek8
 ioX1eotJdUhYragzpJMf23YbmXt+eWwdd3TwBhBgzru3g2XZ6zuUxcrsNq0Z1SDhZokanR/uTtt
 Sn7SPfRYRPYhC8ps=
X-Received: by 2002:a05:6000:136d:b0:2ff:6906:7169 with SMTP id
 q13-20020a056000136d00b002ff69067169mr3825127wrz.68.1685692327599; 
 Fri, 02 Jun 2023 00:52:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zJZQAghpv0B51aqS6w06eQVmnZyvP5DN1FHaw2sTjDwfOn/KazHGnzwPtz7DaOUj+QD8fCg==
X-Received: by 2002:a05:6000:136d:b0:2ff:6906:7169 with SMTP id
 q13-20020a056000136d00b002ff69067169mr3825118wrz.68.1685692327366; 
 Fri, 02 Jun 2023 00:52:07 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-14.web.vodafone.de.
 [109.43.176.14]) by smtp.gmail.com with ESMTPSA id
 s15-20020a5d69cf000000b0030af31c8c63sm877514wrw.47.2023.06.02.00.52.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 00:52:06 -0700 (PDT)
Message-ID: <38d8b6a0-abb4-3e00-8f6f-d8caaaca26fc@redhat.com>
Date: Fri, 2 Jun 2023 09:52:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 03/10] tests/qtest: get rid of 'qmp_command' helper in
 migration test
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <20230601161347.1803440-1-berrange@redhat.com>
 <20230601161347.1803440-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230601161347.1803440-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 01/06/2023 18.13, Daniel P. Berrangé wrote:
> This function duplicates logic of qtest_qmp_assert_success_ref.
> The qtest_qmp_assert_success_ref method has better diagnostics
> on failure because it prints the entire QMP response, instead
> of just asserting on existance of the 'error' key.
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/migration-helpers.c | 22 ----------------------
>   tests/qtest/migration-helpers.h |  3 ---
>   tests/qtest/migration-test.c    | 29 +++++++++++++++--------------
>   3 files changed, 15 insertions(+), 39 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


