Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F96BF275B
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Oct 2025 18:35:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAsqc-0003Q8-0v; Mon, 20 Oct 2025 12:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAsqZ-0003Pr-Ph
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAsqY-0002n9-0k
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760978095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TOkfXY0iVLyZAZOgIpW6Ph47AU7MNKM1w3CLMIffSbc=;
 b=KycYVoeC9pkAl3LqKkBI7UOb0g8XLKb4qNBszyhVFOshP1Hm1O9Wto9kXmY94wTnSFqvIU
 FBBJiEUMXlOAqI/BHvE7Euj55FdLX50yaQTNWjIc1kpN7mPgiMvlsuADwAICja73uEaCQu
 Gig+6W8N39atsUvGnLUyslbQj+QS1Aw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-0ZoFVyqQOm6ssSC53uEMSQ-1; Mon, 20 Oct 2025 12:34:54 -0400
X-MC-Unique: 0ZoFVyqQOm6ssSC53uEMSQ-1
X-Mimecast-MFC-AGG-ID: 0ZoFVyqQOm6ssSC53uEMSQ_1760978093
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47111dc7bdbso35059535e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 09:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760978093; x=1761582893;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TOkfXY0iVLyZAZOgIpW6Ph47AU7MNKM1w3CLMIffSbc=;
 b=XGX3s/498WE6JolK7YkO8x1lHwwEZlrWnuTsEjFi/KUBma1ZAvyZvMe+47ecbWOnDs
 jRO43QDD82vPH1ge0kwEfEwvsiec5EuwcNQR2YrP4jP4W3Lxnu1RVDv/QdnZvt2nYna8
 f6jCL26xlLqS+C3MF4GuWN6MKgGFtOvtvgLeJbPBC/wNO3CqM0Mf4uBvI0s3IZk2J2zM
 5i8zyg2CVE6Tjy5TnF62P5UIfjcBl3DYVWk8wRvK5issImNqGzJrtdsSXGdVJ06PJVBH
 MkcHE1xosEDMENBTuj3cysLdU2yYddAnXP9jGCPmVObO/8zCouQOJLXbCLp1fuYddpCh
 SFiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxYboCg7iaOHtc2i+dYvqd3BOV9325QipDdV+mE7re3crbDCNgtSfGDquMqIFlZ31LGk6mSU75fW0o@nongnu.org
X-Gm-Message-State: AOJu0YwQlb3CRkw2jN/Aklz45eKx35DjULlesB+TW+POJy3Y9OSU9oVQ
 Hj396s9r0wr1POpWcCFgyJrIiUVIyFGswhNp5TbE/MxauU4xMehvAGdXZ+LWMxIq9Wuf8Fb+K9A
 5Y7kVlmBqf2+dQvHttjf3q4X5HF2ZMhPVxBV4VpOWO2e0PbgmIhsbHVYpdUh/PZmE
X-Gm-Gg: ASbGncspElCtnReL7qKjP0IJHN7dfobXPOrmkrzMA7oWo5ygO1Py3oVPs4EPGyCSTQS
 ZPYIxJ5/xTRei+CW719AtPtvRZUnQLg3NGpN6PO2r/tu+6n9dyPR6KmJNv0BuW7TsXUUyewMgIk
 sq3v5sM7moICGAhEqSXsur3YpaOz5FGmSK8/b467n1XqbbLWQDqhorhPz/LT1p0LPpzgOth17aT
 /oFiOLXFsGQMbLzZPVu55TA2CJ5ZvWpKTfXUGOXA3PCS9XTMCXTi6b8XFq7mcMgA2J76hlUktKW
 NXWzb2i4z5ibcV76DAmszLPoOsQpZYHvG4bvdXbbJosANriM0ysFG/8xQWFjqeCF+AOjYvkG+Sy
 6HuvGOGXICUInukjLbNlNKvzR8G2lKHezyuiPdNEp
X-Received: by 2002:a05:600c:4748:b0:471:12c2:201b with SMTP id
 5b1f17b1804b1-4711791c503mr89945775e9.27.1760978092954; 
 Mon, 20 Oct 2025 09:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGidiuWGrAsxdfFt+EVANxue9fjXlfBppEUUGbMugmb4niIOxbR2L7WtECfZMUq39NxL0d6tQ==
X-Received: by 2002:a05:600c:4748:b0:471:12c2:201b with SMTP id
 5b1f17b1804b1-4711791c503mr89945585e9.27.1760978092535; 
 Mon, 20 Oct 2025 09:34:52 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-135.pools.arcor-ip.net.
 [47.64.114.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a781sm16458838f8f.30.2025.10.20.09.34.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 09:34:52 -0700 (PDT)
Message-ID: <747f25fd-aa88-4117-a92c-04769f650b32@redhat.com>
Date: Mon, 20 Oct 2025 18:34:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] qapi/machine-s390x: add QAPI event
 SCLP_CPI_INFO_AVAILABLE
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Michael Mueller <mimu@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>
References: <20251016121708.334133-1-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251016121708.334133-1-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/10/2025 14.17, Shalini Chellathurai Saroja wrote:
> Add QAPI event SCLP_CPI_INFO_AVAILABLE to notify the availability
> of Control-Program Identification data in QOM.
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/sclpcpi.c      |  4 ++++
>   qapi/machine-s390x.json | 21 +++++++++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> index 7aa039d510..68fc1b809b 100644
> --- a/hw/s390x/sclpcpi.c
> +++ b/hw/s390x/sclpcpi.c
> @@ -54,6 +54,7 @@
>   #include "hw/s390x/event-facility.h"
>   #include "hw/s390x/ebcdic.h"
>   #include "qapi/qapi-visit-machine.h"
> +#include "qapi/qapi-events-machine-s390x.h"
>   #include "migration/vmstate.h"
>   
>   typedef struct Data {
> @@ -106,6 +107,9 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
>       e->timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
>   
>       cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
> +
> +    qapi_event_send_sclp_cpi_info_available();
> +
>       return SCLP_RC_NORMAL_COMPLETION;
>   }
>   
> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
> index 966dbd61d2..8412668b67 100644
> --- a/qapi/machine-s390x.json
> +++ b/qapi/machine-s390x.json
> @@ -119,3 +119,24 @@
>   { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
>     'features': [ 'unstable' ]
>   }
> +
> +##
> +# @SCLP_CPI_INFO_AVAILABLE:
> +#
> +# Emitted when the Control-Program Identification data is available
> +# in the QOM tree.
> +#
> +# Features:
> +#
> +# @unstable: This event is experimental.
> +#
> +# Since: 10.2
> +#
> +# .. qmp-example::
> +#
> +#     <- { "event": "SCLP_CPI_INFO_AVAILABLE",
> +#          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
> +##
> +{ 'event': 'SCLP_CPI_INFO_AVAILABLE',
> +  'features': [ 'unstable' ]
> +}

Reviewed-by: Thomas Huth <thuth@redhat.com>


