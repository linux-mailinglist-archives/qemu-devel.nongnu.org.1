Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54A7BB4A6
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 12:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qohcs-0003Jz-R9; Fri, 06 Oct 2023 06:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qohcn-0003JO-V1
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 06:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qohcm-0006N8-De
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 06:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696586399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jw+G6G+ZklHgReqY2B5sSGjpHZnm6ZxAZY14zqxdA/0=;
 b=d06BLDM/vDlc2WiLj0o2TjLNgsOSzNqxDH1L49dR45p05SeK3ywU7UC1VdKxMF3FqWt/Lb
 OvQ7cPiMdZ+XQ++bMZb3gbmrP2FK+4/iJfdhHrmeHX5ZCSOTOIVSe5Q55SujM+gQgiG0v0
 4eQThLYuHACVE4lDCi+ryz1UxjRe+pQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-qO9ticuyPEaARBdstjio9g-1; Fri, 06 Oct 2023 05:59:43 -0400
X-MC-Unique: qO9ticuyPEaARBdstjio9g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6557c921df1so18308416d6.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 02:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696586382; x=1697191182;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jw+G6G+ZklHgReqY2B5sSGjpHZnm6ZxAZY14zqxdA/0=;
 b=bOWFSl7bxoLIFoyz15TuY3p91tx8b97fgb+QnoVO52g1nzOcBznsMF/sQvny+1EB8v
 0ganODzJ7OqxroJ86bLz833OdDiunrOYRw86vSCErmv2Z9WlqpUSQ1eZK2tZYYtGG87c
 YefTh6MDEJFo0cYFSNRP+aIuICEFeYXhXihnV2baBLcQGkWgaSkvEZ3yes6iAPGoCG14
 /HBEwv1wLsr31YnvfGlLXd/AoNIy9DnbG3Rm5Z2cxuf7LSIwyH6rTUrCaFLGPKk1bwIo
 PFAPZWr2oVyBpokKutjU5UqNluiD7Qwzrl0/Zn3q+9Gdl91C5NT3shnuc7VXCVs1Cef7
 IKYw==
X-Gm-Message-State: AOJu0Yz4DECJ4GDF5YAKzSbs2bx6OVaqEM0r9aLGL3Ym2U2GGRcWMzjr
 AZlqPT/Hc3oNPXaeE2KnqZPOS2ZfKUh+o1IjkqXVZLwYacW4rQFuJU3oqzbAdR5oPO/9FT+lS7C
 i0gngZC5QfkHdRLc=
X-Received: by 2002:a0c:8e8c:0:b0:64f:8213:197d with SMTP id
 x12-20020a0c8e8c000000b0064f8213197dmr7787575qvb.33.1696586382666; 
 Fri, 06 Oct 2023 02:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIp4VhkuTfAF6zHprRFZs0T9db1URQSAE+fvv2PO6PKFeglMojKqF/TgBgrLHHkMiHDtY26w==
X-Received: by 2002:a0c:8e8c:0:b0:64f:8213:197d with SMTP id
 x12-20020a0c8e8c000000b0064f8213197dmr7787571qvb.33.1696586382420; 
 Fri, 06 Oct 2023 02:59:42 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a0ca987000000b0065b1bcd0d33sm1262761qvb.93.2023.10.06.02.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 02:59:41 -0700 (PDT)
Message-ID: <d2d1fecf-683f-7d1e-20d0-725958bd179f@redhat.com>
Date: Fri, 6 Oct 2023 11:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/5] linux-user/flatload: clean up local variable shadowing
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
References: <20230925151029.461358-1-laurent@vivier.eu>
 <20230925151029.461358-2-laurent@vivier.eu>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230925151029.461358-2-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/09/2023 17.10, Laurent Vivier wrote:
> Fix following warnings:
> 
> .../linux-user/flatload.c: In function 'load_flt_binary':
> .../linux-user/flatload.c:758:23: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
>    758 |             abi_ulong p;
>        |                       ^
> ../../../Projects/qemu/linux-user/flatload.c:722:15: note: shadowed declaration is here
>    722 |     abi_ulong p;
>        |               ^
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/flatload.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


