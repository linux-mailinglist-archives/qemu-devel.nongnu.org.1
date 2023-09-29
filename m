Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD0F7B35DC
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:39:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEdF-00053l-S6; Fri, 29 Sep 2023 10:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qmEd8-0004zs-4w
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qmEd4-0001td-U9
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695998286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlZ92PaieIcAo0LulD7/aTcMzuq6A1g2LDknhLTBBBU=;
 b=dcd7NTZKyI7pHr+PyIAzJX6RDaDQR1IzkYIkFrKF8wLtKQZlcx6y05iAQRXT/fexupB59j
 jZJnz5TEONF0hBi8/1PQ2+JOczdmDFGz1MK4DXQEAdpRJEdALCqY/19wxhqmUyALPyWlf5
 amm9JS+z+WNMmcZCZnG8wkJa0hl131Y=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-bcuUAw80P2WxsllGT4dzTw-1; Fri, 29 Sep 2023 10:38:04 -0400
X-MC-Unique: bcuUAw80P2WxsllGT4dzTw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-65b14f88921so134819356d6.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695998284; x=1696603084;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dlZ92PaieIcAo0LulD7/aTcMzuq6A1g2LDknhLTBBBU=;
 b=RYVlILXTplzbHmbT+HNE0Ib3Kb3Tmuj4WDyWH2isFlSUD2zEYLHaBmibzKndVhZXNw
 eDW0ZEmroS8jHN0G9WWewfEQtEEzxn2sDRGttGlng+LhfuBXRaEpM3GYuUOUAmZ+44xd
 prapslVT+Q0ovUDkm3c/fVcCoARPOLcXC1PhqVGoQcDKW857trkTuHmA2bdwbsgralH0
 rjpUENrw/wvDUzBokTDJZvhBU5AWBYlQtEF5MY+XOz9w8q8l1oDMixTFt63ker7AmgF2
 fGO5HD99uPp/J7gaNRqq5lxpV/WJURgOdSK+ppMjtzH8aRq9iT+r1/cxAplzeyX+6cOg
 kOBg==
X-Gm-Message-State: AOJu0YzP9NdRM17vK4vYm+jZMA6CdFk7L0LRjKpGXOtsOzSQQ00iDKng
 BL3LnGcvQaSh6IwblXqlx07r+hLm6AjETQy8L85HZmZq0Ty91xUiBPgeMRuRpiiIpnLubrlkYMw
 9JqRzqlLDVnR1K4M=
X-Received: by 2002:a0c:b45e:0:b0:656:55f8:e82 with SMTP id
 e30-20020a0cb45e000000b0065655f80e82mr3897178qvf.32.1695998284363; 
 Fri, 29 Sep 2023 07:38:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQdkHwyU2OMqeE9C/GSYdBGiZEm7bmnQx1JZUtprBmEEPv7Al5XOEuVljABL2WMTC9EDTIDA==
X-Received: by 2002:a0c:b45e:0:b0:656:55f8:e82 with SMTP id
 e30-20020a0cb45e000000b0065655f80e82mr3897161qvf.32.1695998284104; 
 Fri, 29 Sep 2023 07:38:04 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 f23-20020ae9ea17000000b00767da9b6ae9sm6976845qkg.11.2023.09.29.07.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 07:38:03 -0700 (PDT)
Message-ID: <c7dbf14f-66bf-4180-a4fb-1e064b1581e2@redhat.com>
Date: Fri, 29 Sep 2023 16:38:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: add standard-headers to Hosts/LINUX
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230929143012.77128-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230929143012.77128-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.295, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 29/09/2023 16.30, Cornelia Huck wrote:
> The files in there are updated via update-linux-headers.sh.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 355b1960ce46..95df1f3d8884 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -556,6 +556,7 @@ M: Cornelia Huck <cohuck@redhat.com>
>   M: Paolo Bonzini <pbonzini@redhat.com>
>   S: Maintained
>   F: linux-headers/
> +F: include/standard-headers/
>   F: scripts/update-linux-headers.sh
>   
>   POSIX

Reviewed-by: Thomas Huth <thuth@redhat.com>


