Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3547204C9
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q561i-0000H0-Vo; Fri, 02 Jun 2023 10:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q561U-0000Fm-G6
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q561S-0006LO-Lq
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685717096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txu6fbxAS6bdIDDK2G4PaodJ7P1+Uj0agMpzdDIwkiE=;
 b=Sf3JyrGSWJTm0oUYDIzkw5qHNC6pY1jysSTbi0KPvwhkTgBvwXL1+K/D+RNJf1yDc+MPoQ
 nFUZypozqUNv/VWftw02lay3ov+vWsOMXwEC8fDznqKL/Bc3jMfzbpp9HdhETdaPPF9rEe
 YyRMub+X9WDLYZW8rY/PDq0kdyH8j+Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-mZ9P2DEdNaahGlD_pAUMKw-1; Fri, 02 Jun 2023 10:44:55 -0400
X-MC-Unique: mZ9P2DEdNaahGlD_pAUMKw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-975508d8187so26341266b.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 07:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685717094; x=1688309094;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=txu6fbxAS6bdIDDK2G4PaodJ7P1+Uj0agMpzdDIwkiE=;
 b=YEY+eIoUMN3Rls0+xm3PWgAmuaY7+EnIngs7stJ47ESoAMt7XToiRmlAzdWp2CznlN
 IMEWDaqlPjZLWsOdXQ9dG0eg8XzaHQ1k0Fwmubb9rXCJZo2yrJtZEvOPFy7veQaeGkIy
 +YaAxr0O14jCHv9QAGbA96cOXnPAXLQ17u6nOpzqlAJWYu9x+vQssqmSHhsb4PFuvIcr
 dQZz/sFaO73DiEz6ppg3gz9W8qJcjnHib5osnx+48z0POh0Jf4LY+YHEVm938Jxb8GT9
 V/IibXZqfKCHK6amQ8+siq9aopjULuRbw6Mr1neNld8Wwu4dUNuZp1vWpKvZrnyrC4Sj
 wCQw==
X-Gm-Message-State: AC+VfDzpc97dtVNnQyly23VwPMF8ToT/biRfNWReYbxvdMp4uRDCRO2K
 pFlAj3FFPhIiNcI4a7M5jxMz1K0Xi5PwiU34sMtUKg2flptsNITLRE3499jkoNAMpkcQHXVv8I/
 alHooDGWtEJS72IA=
X-Received: by 2002:a17:907:318b:b0:96a:bf50:3ad9 with SMTP id
 xe11-20020a170907318b00b0096abf503ad9mr11213258ejb.43.1685717094263; 
 Fri, 02 Jun 2023 07:44:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50howus3wkZx9f0vHcBgEPwMJbTXXEUPpkcuCetlTGbaxewQ8arbwR3w2oI1jREhcjnex19Q==
X-Received: by 2002:a17:907:318b:b0:96a:bf50:3ad9 with SMTP id
 xe11-20020a170907318b00b0096abf503ad9mr11213242ejb.43.1685717093993; 
 Fri, 02 Jun 2023 07:44:53 -0700 (PDT)
Received: from ?IPV6:2003:cf:d72e:f7e0:e1ec:6307:c799:c188?
 (p200300cfd72ef7e0e1ec6307c799c188.dip0.t-ipconnect.de.
 [2003:cf:d72e:f7e0:e1ec:6307:c799:c188])
 by smtp.gmail.com with ESMTPSA id
 bq4-20020a170906d0c400b0096f7105b3a6sm824859ejb.189.2023.06.02.07.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 07:44:53 -0700 (PDT)
Message-ID: <58f622ae-e120-90df-481c-b1cdaaa9ed19@redhat.com>
Date: Fri, 2 Jun 2023 16:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 1/5] parallels: Incorrect data end calculation in
 parallels_open()
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
 <20230529151503.34006-2-alexander.ivanov@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230529151503.34006-2-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 29.05.23 17:14, Alexander Ivanov wrote:
> The BDRVParallelsState structure contains data_end field that is measured
> in sectors. In parallels_open() initially this field is set by data_off
> field from parallels image header.
>
> According to the parallels format documentation, data_off field contains
> an offset, in sectors, from the start of the file to the start of the
> data area. For "WithoutFreeSpace" images: if data_off is zero, the offset
> is calculated as the end of the BAT table plus some padding to ensure
> sector size alignment.
>
> The parallels_open() function has code for handling zero value in
> data_off, but in the result data_end contains the offset in bytes.
>
> Replace the alignment to sector size by division by sector size and fix
> the comparision with s->header_size.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> Reviewed-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


