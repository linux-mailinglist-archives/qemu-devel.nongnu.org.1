Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B121E802AF8
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:44:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA0n7-0003nE-Sh; Sun, 03 Dec 2023 23:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0n2-0003md-9Y
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:42:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0mz-0007sZ-CG
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701664956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRJvIo760Z+rlHzQ1bCrq/yapq6dYTsZzpyUzIf4nlo=;
 b=bPnQBgPsk4jru4t0PIbpxivMvP1GoWmVZkY+v1vq/Qs8GyKqqZUB52Jn8BeYfRlDNNZCwE
 AvOnlhsMgihsInX+kzrLSno+fW/rHvMKI+vjxdbP5p2iwKQ7JAU5rgF6p1aaTLZsf53eUF
 hd0HSzsWMiM0uPhO8CfXdfCDwMGofyg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-tHklXKhlNcmdynHXv7g3JA-1; Sun, 03 Dec 2023 23:42:33 -0500
X-MC-Unique: tHklXKhlNcmdynHXv7g3JA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2865a614ed6so1995931a91.1
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701664952; x=1702269752;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pRJvIo760Z+rlHzQ1bCrq/yapq6dYTsZzpyUzIf4nlo=;
 b=RibwzZVI3nSjFfudzkRPREDLpEEzYECsTs9PzS6BdvYoB+hNe8R7+pm5/2209VfWmu
 k5Ti2iPEs4dBUFFu0/jh/ODy4MlNVp+/OT2j81tVg3cDBNOzyUh1aqnYonUneyemkqQC
 bEGcUiRASTbUxOyMQfYxImuIGFm1LD7VJUcfh44D2g35CJRDQxtxZ5M3+qCw/M5bjj3v
 6CkvsAmwq4s3YLnXhXy5kMvrCQAHvZ6b9wsoz1xOVEdGwsgh0xsUxTbA7ZC/K3fLBbvD
 7/gC1zCSNogqbg8kKE0AvQ+V/VcbC8/W1XCm1X4ua7AQ9Xru/bKwQhi4O/Efh+CcbGrZ
 qsTw==
X-Gm-Message-State: AOJu0YzUGH5EcDk7Lu34Z983e/3qjmCXAs9AlOiRPM/Lo2bNln5C8AR3
 VOprj11hpVxo0d9zUHlaYpOM1I4mxaCqUaOxsyl4VRYKLL8CkfoqYq8K8x2ZeB/GpwQKiO1ItpH
 QURP1Ti9zGSXe5rM=
X-Received: by 2002:a17:902:8f8c:b0:1d0:6ffd:ceb7 with SMTP id
 z12-20020a1709028f8c00b001d06ffdceb7mr1282095plo.112.1701664951973; 
 Sun, 03 Dec 2023 20:42:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoqSgoHDOnNRFfQEyc+oomrNR8KDvFXQkbV9LlwMQAH6VgWb8juTRr0nx5gPHMjm31+M3R0w==
X-Received: by 2002:a17:902:8f8c:b0:1d0:6ffd:ceb7 with SMTP id
 z12-20020a1709028f8c00b001d06ffdceb7mr1282078plo.112.1701664951655; 
 Sun, 03 Dec 2023 20:42:31 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:42:31 -0800 (PST)
Message-ID: <fce90e73-7383-4a97-8065-ca9f7a9bc414@redhat.com>
Date: Mon, 4 Dec 2023 14:42:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 01/25] memory: Have
 memory_region_init_ram_flags_nomigrate() return a boolean
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-2-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()
> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/memory.h | 4 +++-
>   system/memory.c       | 4 +++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 

With Peter Xu's comments addressed, to replace cpu_exec_realizefn()
with memory_region_init_ram_flags_nomigrate() in the commit log.

Reviewed-by: Gavin Shan <gshan@redhat.com>


