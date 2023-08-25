Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EB3788B5F
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 16:15:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZXa4-0006SO-AL; Fri, 25 Aug 2023 10:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZXa1-0006Qv-Hd
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 10:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZXZz-0003IB-JL
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 10:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692972867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mCEhS5u+8iXOX24h0kqOWUfzTSZw592MWvxAwpNV6AY=;
 b=ClM830kiRPtM0nUi5HECswZ2UlLi8nWm6tz24RqXl5SMbfFAPwWd/wbQrMLCYnkahp1hN2
 DWsYvT8truVoOp6ekP+ElLokEqgw0oSQqjTkkNEvOE+zL6rmHwMltG5q1+wYNN57Sc8CET
 S0W9a3Nuhv3+p4+bVPKMfULwg0MFErQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-SWCv12i5OmypFBgHLhWMmw-1; Fri, 25 Aug 2023 10:14:25 -0400
X-MC-Unique: SWCv12i5OmypFBgHLhWMmw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso74030166b.3
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 07:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692972864; x=1693577664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mCEhS5u+8iXOX24h0kqOWUfzTSZw592MWvxAwpNV6AY=;
 b=dJX9/afXfXJt3J8LFU1Wak69KS9TBajrD48zxeggGlAtyWMBbD9W5WkMB6cUWEX681
 X4m2cqTEa8Er9/0W2LX+NoY/EaCOG1HNp+RpsI6fGWteXdtEuO2w7vYQfIeTFa5drvqT
 4/j+68QjTzKYhz+fqPe7YK48Pn8ybiRVIdYol6z+CupKO4zF0LzPOoBKaJi3j7O+77z/
 7bDtuIyHmkTwyJ/i4WET9ZQwmod5dGsAwlpaAzLiNhXmX8ncrCS0/XOv7AxRsoSkZh3J
 nydJtqmZX3PHTl4TAe832XmaJqfL/eEaDn4rxtao/CnY87g7Tonb4N+2SxLkIG+HGTum
 mzsA==
X-Gm-Message-State: AOJu0YzypxbM+f/cYQYs6emqnn6BiDIgwy/9iFjPrHFSeoe04JQxbA4E
 TURVDehWHrCQN4b5ZwC8Zm0ut3LTiQYXnbpQeMdhAIq4fn918HP8o81NGbfN/48fbfYimeuH7YZ
 jTgGVXtBtf6hK87Q=
X-Received: by 2002:a17:906:15b:b0:9a2:1b05:24c6 with SMTP id
 27-20020a170906015b00b009a21b0524c6mr3366210ejh.22.1692972864527; 
 Fri, 25 Aug 2023 07:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK5nB7FrO1UfS+IRTV5rtZvtZV1p6abhOelNuLJwWyUpNJUwPzI6H5mxAl+Y/05QWB4SGsEw==
X-Received: by 2002:a17:906:15b:b0:9a2:1b05:24c6 with SMTP id
 27-20020a170906015b00b009a21b0524c6mr3366194ejh.22.1692972864160; 
 Fri, 25 Aug 2023 07:14:24 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37?
 (p200300cfd70f5ee06d7a84866b838d37.dip0.t-ipconnect.de.
 [2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a1709062c0100b0099df2ddfc37sm1002548ejh.165.2023.08.25.07.14.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 07:14:23 -0700 (PDT)
Message-ID: <f9f267d1-3b75-10df-c379-e04056a3e6ee@redhat.com>
Date: Fri, 25 Aug 2023 16:14:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] block: add BDRV_BLOCK_COMPRESSED flag for
 bdrv_block_status()
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 eblake@redhat.com, vsementsov@yandex-team.ru, den@virtuozzo.com
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
 <20230706163047.128999-2-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230706163047.128999-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.57, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 06.07.23 18:30, Andrey Drobyshev wrote:
> Functions qcow2_get_host_offset(), get_cluster_offset(),
> vmdk_co_block_status() explicitly report compressed cluster types when data
> is compressed.  However, this information is never passed further.  Let's
> make use of it by adding new BDRV_BLOCK_COMPRESSED flag for
> bdrv_block_status(), so that caller may know that the data range is
> compressed.  In particular, we're going to use this flag to tweak
> "qemu-img map" output.
>
> This new flag is only being utilized by qcow, qcow2 and vmdk formats, as only
> those support compression.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow.c                 | 5 ++++-
>   block/qcow2.c                | 3 +++
>   block/vmdk.c                 | 2 ++
>   include/block/block-common.h | 3 +++
>   4 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


