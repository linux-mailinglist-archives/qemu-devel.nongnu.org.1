Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7B719700
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:32:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eeV-0005nA-Is; Thu, 01 Jun 2023 05:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4eeQ-0005mo-SA
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4eeN-0007JM-Uf
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685611879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bReh5GwH0bO4Bm8no77JZ2enz79D3nsQ705iF0DmeMs=;
 b=WUJmFeSS2+4ksJSchYo5feDcxTsa537+4B0da4aTpjyBhHncdITGqwbshIjyZF+R6IWFq8
 FV8fLXzKU4dlmR/3gKTcfIua9g09QpWjs4HkZfuhUU0Y1hzdvDomEdj5L8qw1GMnWpxDFp
 JDTcerskUxbiHrkQfog2SwyfZwdrlSg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-UQjdGrx8OOeM-H5I_hnDfw-1; Thu, 01 Jun 2023 05:31:17 -0400
X-MC-Unique: UQjdGrx8OOeM-H5I_hnDfw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30ae42628cfso324143f8f.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685611876; x=1688203876;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bReh5GwH0bO4Bm8no77JZ2enz79D3nsQ705iF0DmeMs=;
 b=LNkL9N9KVBs8Ez8i6X9rAgwuZgbFq/CbqTqjmkF13eo0k1xPS4kXt98pd3FBIoiTxP
 OrsqZlPb/qoMoSTja73lU2L6Yo+d5OKAJswRd3thv8iyVqgilW3j7FzoeiL/CWBaEfUC
 8Trs5+BNCHPykNXwcphUgHbagyMa3vfB2QIa0G5wnrBQHYqkOEgG++Cd73gmRL5A6bTX
 koixqmCOT5pyY+5ZSIRiCmMxeEkmeUpQXCYTegxdaqkbr/88mbqT8VP8MuUjBAdejRuo
 dNEIA2G0IrLwJFKh5uSSagVhkj9ApnAXrurEdq3UY+PfFPLWpfXRCmQntgS+LNjOJhjZ
 LyBQ==
X-Gm-Message-State: AC+VfDx2vftlb55ZarExwEUvxhpNP0tA+6MbalMZ1OJ2HvyMwaJv+/v2
 mDrS9vEpHqf3+PIEHtnkVQD67LmDqWZcoPRaoB8m1M2kYv2qaxnWE9Ycmy/XPWrQiJuWq8oD5G4
 M/NX3AmRkIoqL0rw=
X-Received: by 2002:adf:f78f:0:b0:306:2c16:8361 with SMTP id
 q15-20020adff78f000000b003062c168361mr1318212wrp.22.1685611876801; 
 Thu, 01 Jun 2023 02:31:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5D5Ltl92kbehB7kBgMeYcW//abriHPlBL8kVmJigcMOz95yyjqZx2D4/ZyAVfUKzYBjLft2w==
X-Received: by 2002:adf:f78f:0:b0:306:2c16:8361 with SMTP id
 q15-20020adff78f000000b003062c168361mr1318204wrp.22.1685611876563; 
 Thu, 01 Jun 2023 02:31:16 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-86.web.vodafone.de.
 [109.43.178.86]) by smtp.gmail.com with ESMTPSA id
 s5-20020adff805000000b00307d58b3da9sm9758708wrp.25.2023.06.01.02.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 02:31:16 -0700 (PDT)
Message-ID: <7c6ff7af-6a7b-b789-1655-dcdb2882e8bf@redhat.com>
Date: Thu, 1 Jun 2023 11:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 5/9] tests/qtest: switch to using event callbacks for
 STOP event
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-6-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230531132400.1129576-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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
> Change the migration test to use the new qtest event callback to watch
> for the stop event. This ensures that we only watch for the STOP event
> on the source QEMU. The previous code would set the single 'got_stop'
> flag when either source or dest QEMU got the STOP event.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/migration-helpers.c | 18 ++++++++----------
>   tests/qtest/migration-helpers.h |  3 ++-
>   tests/qtest/migration-test.c    |  4 ++++
>   3 files changed, 14 insertions(+), 11 deletions(-)


Acked-by: Thomas Huth <thuth@redhat.com>


